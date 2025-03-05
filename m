Return-Path: <netdev+bounces-171958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D905CA4FA16
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1610916EA0B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306E204C27;
	Wed,  5 Mar 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrvjDzyA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46763204873
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167038; cv=none; b=tiR3jLyRxcjYA1j3SATGEYwKLZU2Y+CnkDlAjXt1Ixxh8hJMGCPHvqwiHZQRfZZeev3rf+fkJAQRCOrhzgxCEPLYYJa7DxT5s/S91S3IWFr9valZwL+0s86ZLSmiQaOI9OWA3J66IDAd5xv3H5YA2/F4z7tJf4kHAs92PSGc2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167038; c=relaxed/simple;
	bh=Vxv0VBbtdbVDbDGLcORTnzoIpxIDB3hFqwWMEq+B6MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1ruSC9/K/NBSdT3Oqom65IkXVk/+Y4FrDe8/7jszYStDvQj48op0bUceHui0i21g8/UPAxOfbprJs0MmUwUTb9JRZn6aPdVzMguNorhFjG1p8GjDzoV7Dd+/N4k1SDkWHnLZScBxQUGMT+MFT8DhTzs9dAXCC4o0Hz8E2GMVSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrvjDzyA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8BZqtssEKSX9U+sm7giaUTnUcD9w0nxNJyaKF0Dg8jk=;
	b=ZrvjDzyAJjA3AF4vKrijg4WtOSpsejEVLqEv+YV974FkuPBCPfyBE+QsFuv+gYraZu/U4p
	2Z4n8eZ6DIdUoTgedY1D4EsdEJqI0kD/F0SIqklBMfLone4Mmar4yWLwj3JZEbVGM4gRW/
	wpdwf5bw22YSWQb53//FjGyiQ3Cz9qE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-esUmWzCBNxmsJs52cuVXuQ-1; Wed, 05 Mar 2025 04:30:24 -0500
X-MC-Unique: esUmWzCBNxmsJs52cuVXuQ-1
X-Mimecast-MFC-AGG-ID: esUmWzCBNxmsJs52cuVXuQ_1741167024
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abf597afe1fso439456166b.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 01:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167023; x=1741771823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BZqtssEKSX9U+sm7giaUTnUcD9w0nxNJyaKF0Dg8jk=;
        b=GhFHjiLY/czEuhWMzm+OS7dy9+G1Bq3Upf9dfxo64mgK7JVi6SaTZftDgw4X0CaDyU
         68/05qyS+PHn3I/5+4VQjA/hA5l+ww8wflVsA+jFGznf6nWUusc2iyn8KIEiozCt3V+i
         HMnpIDy837jEVDAccpfCqw7f2Rh9Rs+EZs7P1dxn0AKQaQB4kStIdM7sqZ3GbD/FxfHh
         OIuBBBOwRL8ujMMHBBzaRKP5LbCChhLOojTp2ENUeM2QgS9V+yeqodzh6VPJV9Y2HpZ7
         uppD41LWCe4JyBQK79+EXjR/kqqJUC64IAJH0sIui/8HvLoE7qr4tAbd0I3HBDUQIV8S
         BaqA==
X-Forwarded-Encrypted: i=1; AJvYcCWQop46K/rNI3L39P+o0797zb6lY4fxvF/U/n2vevFAVXGOPEGZRBvqSSbWhL1ICc2vDKpRJTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdvKILTL4J7cWehv95lskDZRz4K9h9AZqTR6T7zyVDBzJAi+l
	IxaNKjLcPydpAIBkxJ3wtwUQxjWnvVt2r9lPMjKie6O0ILoMOwxXrSmuPbu2MtHa1nmQvUxjKeb
	yV6HNaifn/LYiTgcjbecd2oU5reWD0w9Zwe6wmobkqn6yqFbitTMceg==
X-Gm-Gg: ASbGncvDsy7xJEUZxlVulLMkA4QaXeHKAZW8ZHdrIRGrlrrHDYpkAWrtemkyqHFIzXW
	egT771N4oM47Xb314b7zicoyibCUmq7KSbJwjBTKYrKsmPdGDQ28AiYqpdnbXXp0Xlr+6wpZ4YX
	sBn1XnfLLVfQ3zzsjBSQ9K/jpWn39ONuLWefBKWP4qcUAWmf6HE4s+V87La36j0GiQQU6wufJzA
	k5+wBN/ztG30XW/yF943/ZO0Gyrgiz9MPy1T92TiulRYSXDQdohRVoS4+8bjFuWNg6g7C3k1fYN
	Xa/iSdxRjtqomY8IYu6Z8Qn/2z1537c/ofsWYGF9obg0JDIOw/JT4F9RMoyFlbo7
X-Received: by 2002:a17:907:9494:b0:ac1:da76:3633 with SMTP id a640c23a62f3a-ac20d84412emr257568866b.4.1741167023612;
        Wed, 05 Mar 2025 01:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXk7a1z+Ze1GZvne805ygS+jajQyu0NiMIy6MNpjgAxqXVnbiuz0kcZ2+UtS+U3NrxoZnl1w==
X-Received: by 2002:a17:907:9494:b0:ac1:da76:3633 with SMTP id a640c23a62f3a-ac20d84412emr257565066b.4.1741167023076;
        Wed, 05 Mar 2025 01:30:23 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac20225a3a5sm182343166b.177.2025.03.05.01.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:30:22 -0800 (PST)
Date: Wed, 5 Mar 2025 10:30:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
 <20250305022248-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250305022248-mutt-send-email-mst@kernel.org>

On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
>On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
>> I think it might be a lot of complexity to bring into the picture from
>> netdev, and I'm not sure there is a big win since the vsock device could
>> also have a vsock->net itself? I think the complexity will come from the
>> address translation, which I don't think netdev buys us because there
>> would still be all of the work work to support vsock in netfilter?
>
>Ugh.
>
>Guys, let's remember what vsock is.
>
>It's a replacement for the serial device with an interface
>that's easier for userspace to consume, as you get
>the demultiplexing by the port number.
>
>The whole point of vsock is that people do not want
>any firewalling, filtering, or management on it.
>
>It needs to work with no configuration even if networking is
>misconfigured or blocked.

I agree with Michael here.

It's been 5 years and my memory is bad, but using netdev seemed like a 
mess, especially because in vsock we don't have anything related to 
IP/Ethernet/ARP, etc.

I see vsock more as AF_UNIX than netdev.

I put in CC Jakub who was covering network namespace, maybe he has some 
advice for us regarding this. Context [1].

Thanks,
Stefano

[1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com/


