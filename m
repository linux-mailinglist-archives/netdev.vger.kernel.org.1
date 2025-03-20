Return-Path: <netdev+bounces-176412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6340A6A21F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862B516D3EF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386422173C;
	Thu, 20 Mar 2025 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMUff2xb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D6215F78
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461697; cv=none; b=NVIRBVLzjJx95eOPjJHitRzinE4g4hAYT278+zcP+B0elHX4bvYvqXC39ry+9T61q1pg/4Y8rSpzRgtY2i3yJIPP1DVuuOjxXBKyxnl7Gxdg4F7ipBVqGfn4JKNrwaCM0iLOvJZ5ydCkMkf211Je2R6KWp7kljR43V5rLNsvK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461697; c=relaxed/simple;
	bh=5W1uHTX0JS3ybfrgNeMmG6TgEZd4dU4vl69eG6Vq4OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA+llZH7aQQ9CZVqlfwyYYGc6JSlpdEMYYL+YMvvYFhP8EbyqacIwuU1ynLk/7HEeXlAGgTAje/JBWDVbB/qR+0mKR/LaRG2ccoo3rjb3cxk8VkF6o3rjhXd/mTkEghYlt/w0BEvA6scYYiqvj6ufMIYb9jzvY6MaVJzVT1cOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMUff2xb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742461693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDTq60/uptS/vYIusNxJ/yOQlPzuUR9or0TJgSxpmhw=;
	b=iMUff2xbcMVsZUkbgKSwbBzHicSNpA5LIqYyjHnuGJdO8bVfNuw5N7PRqYJbF9hB0a46wz
	fezjH9hdKJdUs0zWGtWSu5wUfdO9uLYHtQLNTOCnPmtxwVbN5SA611RLuMBm8J95BTpr1J
	IyvZS7Dya2r8vBDAa1UNqV8ZCFvcwIA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-WcY5fbvyPZWlD-Ic41AP1Q-1; Thu, 20 Mar 2025 05:08:11 -0400
X-MC-Unique: WcY5fbvyPZWlD-Ic41AP1Q-1
X-Mimecast-MFC-AGG-ID: WcY5fbvyPZWlD-Ic41AP1Q_1742461690
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so480200a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 02:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742461690; x=1743066490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDTq60/uptS/vYIusNxJ/yOQlPzuUR9or0TJgSxpmhw=;
        b=MA8N3ThJ5e6CuM0qwG8qfjHvCmPHuYDuuigQruxkEPyTB726xrb7qAuz1gUboPCkh1
         hSv/qT9rydehBujvK+fXnocTvn4FMwbQnciT26z+/45lEhDsLzns6zdmSyA1kocdW1i7
         440hoksxBKx91f0940Jw8uR2mSIl6Q2W7pCVOExLEcnutfKyngjhZfHBbigueYvL7ded
         S3kXu1qmxrAFedWiAuXdZko51I3AjwLg4ZcGLcI0NKrPQyzwFnsoCwupD2AjObRZcoem
         kQ72QhZhkG2NaHwgDCZh7o343fh7o11dh/AoZjFHIQrJCX00u8WKOWcc61A0qbDwbnPD
         Tz4A==
X-Forwarded-Encrypted: i=1; AJvYcCX3C/WfD+3HYRK11qm8rgb7NT8LaLt2FnXaPJX76FqtGj9RdvS3gN1wXiKj5l3lTlpHJ7I9rC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywfP0cGXKDqcoE0kutdjHuq6w2yqwyLV5gWcKH0sWkczGWTzmE
	QJi/aby7LnwQyhSw7fPQfmr0++FLYphG0KX4FqXx6pgHPD/FLKyaKp5KG2XB4/yZfKGot9v4G97
	JDobQksej6DCJqfx/ytjGdj+OwTgy759GCnC9U8TdhYCMnCic9oErew==
X-Gm-Gg: ASbGncuad+blOWqHoz1CkeoTLSpnTQ+3BYIaN3c59CEVW6KYwjYBPcSnZerD5rYgbQ1
	pkMXQedh4kRR/uyWtYuzXNbUVLOjlxrNfM+q76k+8d5D4VLOUykMYoqBLUcLBwUcV2X5G3nVNCn
	3yvrim8kcz/wd8OZMq2e/x+LsoEvlxe34pwxXvVXjZ8ntDummq1ymFV6bBCX6KUkIX1IFRhar5H
	TuZ4YVv9NlBEJWe5N0uH22f6yCRvuAomtBZoX/x9t4iIP8NILJdhEa5otTVRX1+zKMItd42Inwm
	lZacTbhBfhq9G/YqiBpHkDn740C10BUcZb+g6nbikjRUN48qlAdxKzUNQS2daHix
X-Received: by 2002:a05:6402:13cf:b0:5e7:c779:85db with SMTP id 4fb4d7f45d1cf-5eb80cdea32mr5839739a12.4.1742461690260;
        Thu, 20 Mar 2025 02:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOQHfmcgMblKkiR1tHejD7TWeiNXKZXGZAyBKU76H5X4T1+QQ1dIB97fNyYdpVkDoNZIj46Q==
X-Received: by 2002:a05:6402:13cf:b0:5e7:c779:85db with SMTP id 4fb4d7f45d1cf-5eb80cdea32mr5839682a12.4.1742461689546;
        Thu, 20 Mar 2025 02:08:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afeaabsm10004728a12.69.2025.03.20.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 02:08:09 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:08:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>

On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
>On 3/12/25 9:59 PM, Bobby Eshleman wrote:
>> @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>>  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>>
>>  	vhost_dev_cleanup(&vsock->dev);
>> +	if (vsock->net)
>> +		put_net(vsock->net);
>
>put_net() is a deprecated API, you should use put_net_track() instead.
>
>>  	kfree(vsock->dev.vqs);
>>  	vhost_vsock_free(vsock);
>>  	return 0;
>
>Also series introducing new features should also include the related
>self-tests.

Yes, I was thinking about testing as well, but to test this I think we 
need to run QEMU with Linux in it, is this feasible in self-tests?

We should start looking at that, because for now I have my own ansible 
script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to 
test both host (vhost-vsock) and guest (virtio-vsock).

Thanks,
Stefano


