Return-Path: <netdev+bounces-176705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE6A6B868
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D969F46100C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBCF1F2C34;
	Fri, 21 Mar 2025 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh2ozByb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA61F0E4C
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551366; cv=none; b=f/0OTx8O6UVKTPQa30bjGJkt/oPNwbpfHHPEq42CAhHcbURsAT551iNqTgIjUTicYKdf27tXi4v2J4Tg6Ru+VZMFWTcmVd0yDadG3keB64nW3hA0efJYuJREXQYfuCXW0MfmhBJs9+L0qC/rFCwv4XU1lK7ybT5Xhqyn37M5mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551366; c=relaxed/simple;
	bh=7FXB9MgUSNIAeCSTjixx/fGT1P/pEpqm6PYZY4ugldk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amkCmz8SVIRgt2YWF4WegfCRrLnMJg/X5Bb0hVXDTuEhpOj/dUYCl7GVnz2HYZJ0NaLoToZNt4Z1GrVlSrecXJlcIvDhuUeUPoL9h8v8Jg6gox9G8kBkuqJ55Btp0i0OfhQ2rq5OjRIcyBcvCAygzG7xdd6HEZ1fermuRQsWn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fh2ozByb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742551363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1fasRIza0+wiA592mMux1XtH5KpwcITkoYkMYOlXyU=;
	b=fh2ozByb7XrKwBDe232od9RzU4T8w7G0yMGs6geOIeClm1OdZd5M1RFiAOPsb7z8nrZKQW
	cya4Q6z4/LgJNScLmHjSjUDuke66TkB+7Z86XkiCYpldJ1iOWgBiAJ0PLhxLOuo2RBtNqR
	zj79BGx3LkZGjSuwa0hAzPlhgRRvAFM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-uSKU5AMfMt-iIrC2t4wK4w-1; Fri, 21 Mar 2025 06:02:42 -0400
X-MC-Unique: uSKU5AMfMt-iIrC2t4wK4w-1
X-Mimecast-MFC-AGG-ID: uSKU5AMfMt-iIrC2t4wK4w_1742551361
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3d175fe71so144420366b.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 03:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742551361; x=1743156161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1fasRIza0+wiA592mMux1XtH5KpwcITkoYkMYOlXyU=;
        b=p6tJD1PPIhS5QIW80Wkf7R2wmz7q3mlWok7tj2gg3zdztjMX6kbSyNGyTQ0mkTlFCG
         IB6av9fgy+GZaH1cOzA3KtQDZUo2Tf4qq4mKOTwedhOi14qkH01W3AY2/XuLcx0CvXIa
         L+iIBlj0Yu0jRzC7fgvZrFpNxAUZ5fDtVSmK5peIcmclr2/Mh+btgpp8Q/5mKK4gDpv0
         esYXyuexVTwK9mE01Vrq5KdsL+/bg3Lg/QMvksFGEvHzj6RDk4M2wWtOVSdQXtKSQLp9
         1B22xy6VrHaWM32Ge2lT8I90/dgNP6UeEOE0NPsZcMgiWOVXYKATLNLD+dKjkKzc4UDw
         0UgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWNeu8WciKGlepUeZMJsKspnQOQbvtfZkcR+nsZehCJOHYLx3RC5tHnE0LaPvtUpIQUFnp1fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIGfCf0sKSnwfuuXDa1RGsQmJxLH6BeanOwY+Jp6YG7flZ8hL
	Za19ssRdEZZTbFcCtCR9tSPwKKhafSdzOsFHc/Uk2lny6GP0858eBR0n1KlxeVfslVCMAy7QibD
	QMtI0hzkpr6VJstIeV5eSuUGBEZEalzBp8qTTU0c3L64IfNym9Ygw6g==
X-Gm-Gg: ASbGncso1cXDMUZtf+GZaEi/64BmVfOJY32gEQSVkZZU+Xa6FNXEb6oEVOjOuOzdngu
	tAeAWW64++iDXB4W4opzmEMyUAo4BgVjiCZrtrUGp8FBGWRBVxWGNzJO084gciHuHP1Ma1JwK6g
	YBwKuLbxkBePeddBRZ9CdLqhMmwBbkPJjsRW7yH2tG3Cn05f/8a1Y/I809Ejw7/IehxTbOWADqx
	R+vXWqCKQy578neLnkbE2s+2LygGYnFUFuXcmn/hgk9pn1E6WjoCw2jVGggKWqQGdPuuxw0XHS9
	dFyTQUQcX5frr0ZvgBDR00F/Zf/dUcWvSC2SgW/hfyBFlYzbO2y7n51G+ZBKXW8B
X-Received: by 2002:a17:907:d7c8:b0:ac3:9587:f2a1 with SMTP id a640c23a62f3a-ac3f20f2eadmr273956666b.20.1742551360984;
        Fri, 21 Mar 2025 03:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI1seRG9imWZDzSDGMTwRVM4KqTGFuBDv5cjB/u4qDI0LlvpoSZCACNxNmno6+XKEHNnW4Jg==
X-Received: by 2002:a17:907:d7c8:b0:ac3:9587:f2a1 with SMTP id a640c23a62f3a-ac3f20f2eadmr273949266b.20.1742551360312;
        Fri, 21 Mar 2025 03:02:40 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e50b9sm125525366b.55.2025.03.21.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:02:39 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:02:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <aqkgzoo2yswmb52x72fwmch2k7qh2vzq42rju7l5puxc775jjj@duqqm4h3rmlh>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
 <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
 <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9yDIl8taTAmG873@devvm6277.cco0.facebook.com>

On Thu, Mar 20, 2025 at 02:05:38PM -0700, Bobby Eshleman wrote:
>On Thu, Mar 20, 2025 at 10:08:02AM +0100, Stefano Garzarella wrote:
>> On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
>> > On 3/12/25 9:59 PM, Bobby Eshleman wrote:
>> > > @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>> > >  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>> > >
>> > >  	vhost_dev_cleanup(&vsock->dev);
>> > > +	if (vsock->net)
>> > > +		put_net(vsock->net);
>> >
>> > put_net() is a deprecated API, you should use put_net_track() instead.
>> >
>> > >  	kfree(vsock->dev.vqs);
>> > >  	vhost_vsock_free(vsock);
>> > >  	return 0;
>> >
>> > Also series introducing new features should also include the related
>> > self-tests.
>>
>> Yes, I was thinking about testing as well, but to test this I think we need
>> to run QEMU with Linux in it, is this feasible in self-tests?
>>
>> We should start looking at that, because for now I have my own ansible
>> script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to
>> test both host (vhost-vsock) and guest (virtio-vsock).
>>
>
>Maybe as a baseline we could follow the model of
>tools/testing/selftests/bpf/vmtest.sh and start by reusing your
>vsock_test parameters from your Ansible script?

Yeah, my playbooks are here: 
https://github.com/stefano-garzarella/ansible-vsock

Note: they are heavily customized on my env, I wrote some notes on how 
to change various wired path.

>
>I don't mind writing the patches.

That would be great and very much appreciated.
Maybe you can do it in a separate series and then here add just the 
configuration we need.

Thanks,
Stefano


