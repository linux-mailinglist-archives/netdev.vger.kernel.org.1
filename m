Return-Path: <netdev+bounces-254656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGt9Aokde2msBQIAu9opvQ
	(envelope-from <netdev+bounces-254656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:42:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B5ADA31
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49398302F7CB
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F537BE80;
	Thu, 29 Jan 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWMB9joG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mq5aWqvy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FD3793AC
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676140; cv=none; b=WlCW+pVSVx/uGHvzRd4dT7LQbQEBi6nFjkV0V3zVh7X+rgdA0J0vofVi+ZLeN+hacVIoWiFQqjMmuK0Rt5nVZjii9RfskI0H2QwmfERdb6nUmFt7JaFuHGPx9LYpP8Tpvb4TZm9UAWKWhPMteCV/aeDRMIh1UriD0tzImPWbB1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676140; c=relaxed/simple;
	bh=Bs6mTjUeA5qkWiBJBxqsJFMQQCY3VsRZlZa2vBfNivk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFlNaTVG7ztpOWJerkrHDTkfAiW47V7xvm7EcE6IEG+AZZw5UwggPYNZNQ8rItLePJLKONQt3/qGLtgwu941CJlc89ZreNbsUGdY2daWhMcP9Xp4/2gmjqnO4N9Ff2MnicTZFTV4FTSVRHvoI0ldV9GZ8C4PStGQsjSa7XW6GfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWMB9joG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mq5aWqvy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769676137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=THtu/B0OMAesHMQ0Tb4jSeVco+ToRrfio4hfGUipZDw=;
	b=VWMB9joGXYC7p4SXDrqZ3kZ3eOqnv+1+GtytduFRo7jVG9Ybe1PWzU0Bt8QeKVgfkfWdz6
	zmGDLVMkEvnLW0E9bRuhO3BQN7RGMB8HvHXXW10KrTRrtR3xoELejQ01NarfC09UEGnnFN
	zyLUAx/s2WOiULXH4ByRf/0obMLKfDs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-JkwuRVrROoGup2KA09yjqA-1; Thu, 29 Jan 2026 03:42:15 -0500
X-MC-Unique: JkwuRVrROoGup2KA09yjqA-1
X-Mimecast-MFC-AGG-ID: JkwuRVrROoGup2KA09yjqA_1769676134
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43284f60a8aso462122f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769676134; x=1770280934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THtu/B0OMAesHMQ0Tb4jSeVco+ToRrfio4hfGUipZDw=;
        b=mq5aWqvyQmv8XKxcpsL05xFNhP61yPx8mUM6PcbPlav9+2J+a2Asd7Xk5Xzvo/A/D8
         YADLhS4VMYeN+3paz47G30CRdVTA6Ogaltn2PsoOPaJ+d55xEIJ/OqgOUBd6pxZBmcl1
         yQ3/6bJ7YzwirFNvFH4c7GsCYJoB0QtVW3p8TUQLSoBk3NbBGlcxi7WINp0jDJG76yXv
         ilLWC8irwCt8KlWWqe8LuhFPQYPHtZUZDIYYcIjDNB1r6KNgfP7VRlZUWuiyx8Cis1Vj
         +L6SWkm3ku2hbUf67agmgdb+aUldVPeyCA5ksesY7AGlPwv2nqiduFy+F0BylQenQr1P
         +doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769676134; x=1770280934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THtu/B0OMAesHMQ0Tb4jSeVco+ToRrfio4hfGUipZDw=;
        b=fwRSPiAI9Fh23/5GtXu61icJ0Wf6gTwvXRiWQKOb3QEiLRPvA+ik8aJIlohcrUSEV/
         Ke7YEdKwjTEHYYs9/Gwm+7wICJ4kNCSco8a1h8boomYUZJOhBYXnHF7ppDSeVJl6P8+a
         6g0rqUlo6L1thkey7JO2lMXUfWdDpMAgy059+/zQ/QqH+Y8OO0Lv8EEj2YwrkOTYxwQB
         DEW/KhqN0vNmUQt5KPxf5g2TMR83Yu3SHAFDOa7kU96qkiGzDLDGfkcs4QaqnYFz+xBg
         QJ7UE4K8XqiVWwYly8Gpa+KzyTXWw3yvxmbtyeA2/Pm3qv7ree8aphpruQXHyiUgYT4H
         ctRw==
X-Forwarded-Encrypted: i=1; AJvYcCU5+2K1kr3jFjWIwDDXes+3ZJC51K07O2Dj/wzEBNRPJCO4guAi7uMdZroLFAE1frEQnUgIcUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzg+uuD0LEwd5zpW9V5laYN8sy63+kvfhHlbpm0Lsww7uutGlr
	QyVRuxBwRHA+xMAyFEdvbQx6iyJtB79fSpovf8fUtSYpWGCIkFebNVNBeHuMVNLsXjpfBV+9xoc
	bWoumceYBZ4y/QuYgU4LkRsuGlINMQ8t4PLZQNXxRhNZ/bQgHucHJi16xWQ==
X-Gm-Gg: AZuq6aI4UL4nIJpZO1B+PxqeJCZCYbM0iDeOG9I/AzE6TlCblbrwiUtbTQ3ARDFodd2
	ZKLT3yjH1XZySY851kOxW1vEzHaV7lRFQxzIX/IXW1bzUnzHyG/l6tjdp0/8udNg2i4blDwb1pe
	E39gHhZgm+ktMEmNph9AKUxV3UOpJ0b3LzHKmIEEM7uY3PgdeZPyl1Z7/SSkQ6h4s0Wwu9248sl
	UmcRRQySSr8Ka2TOnYWDKCXAAsjar9Jh2mBM1m+yXQqmSMUcGrRSA4NZdZFQ26dyTvC/d2/RnNf
	Lhle43kNyJYpmj7W8RkN4BB0mWoc1jpdSgh+Plvg6DnCSRe76N+aAsWoO+iyrs6FrzL3YYX0unp
	215vbYIKfqHdFuKEbuTQpLhGRyjGohJUCOjZvSKd24Uva62gttcE1
X-Received: by 2002:a05:6000:178b:b0:435:9116:c713 with SMTP id ffacd0b85a97d-435dd02db27mr12237802f8f.5.1769676133928;
        Thu, 29 Jan 2026 00:42:13 -0800 (PST)
X-Received: by 2002:a05:6000:178b:b0:435:9116:c713 with SMTP id ffacd0b85a97d-435dd02db27mr12237753f8f.5.1769676133482;
        Thu, 29 Jan 2026 00:42:13 -0800 (PST)
Received: from sgarzare-redhat (ip110-139-192-82.pool-bba.aruba.it. [82.192.139.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm12807318f8f.11.2026.01.29.00.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:42:12 -0800 (PST)
Date: Thu, 29 Jan 2026 09:42:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 15/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <aXsclvInQFIuFe5i@sgarzare-redhat>
References: <f1221bbc120df6adaba9006710a517f1e84a10b2.1767601130.git.mst@redhat.com>
 <ce44f61af415521e00ab7492aa16d3d19f00bd5e.1769632071.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ce44f61af415521e00ab7492aa16d3d19f00bd5e.1769632071.git.mst@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254656-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lwn.net,selenic.com,gondor.apana.org.au,redhat.com,hansenpartnership.com,oracle.com,linux.alibaba.com,samsung.com,arm.com,davemloft.net,google.com,kernel.org,suse.com,ziepe.ca,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE7B5ADA31
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 03:31:21PM -0500, Michael S. Tsirkin wrote:
>Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
>last. This eliminates the padding from aligning the struct size on
>ARCH_DMA_MINALIGN.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
>
>changes from v2:
>	move event_lock and event_run too, to keep
>	event things logically together, as suggested by
>	Stefano Garzarella.

Thanks for that!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Note: this is the only change in v3 and it's cosmetic, so I am
>not reposting the whole patchset.
>
>
> net/vmw_vsock/virtio_transport.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 999a0839726a..b333a7591b26 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -55,15 +55,6 @@ struct virtio_vsock {
> 	int rx_buf_nr;
> 	int rx_buf_max_nr;
>
>-	/* The following fields are protected by event_lock.
>-	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
>-	 */
>-	struct mutex event_lock;
>-	bool event_run;
>-	__dma_from_device_group_begin();
>-	struct virtio_vsock_event event_list[8];
>-	__dma_from_device_group_end();
>-
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>
>@@ -77,6 +68,15 @@ struct virtio_vsock {
> 	 */
> 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
> 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
>+
>+	/* The following fields are protected by event_lock.
>+	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
>+	 */
>+	struct mutex event_lock;
>+	bool event_run;
>+	__dma_from_device_group_begin();
>+	struct virtio_vsock_event event_list[8];
>+	__dma_from_device_group_end();
> };
>
> static u32 virtio_transport_get_local_cid(void)
>-- 
>MST
>


