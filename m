Return-Path: <netdev+bounces-303062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EFteFNKQQ2rHcAoAu9opvQ
	(envelope-from <netdev+bounces-303062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:48:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B176E26B7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:48:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=N5jUq8qt;
	dkim=pass header.d=redhat.com header.s=google header.b=dQ7dT7oF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303062-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303062-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73DD2301FF8B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD938C407;
	Tue, 30 Jun 2026 09:41:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3D38657D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:41:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812478; cv=none; b=ZabNGXuAhODpxyc1aGCgGlHXgS8wWr6KekdiiL3G/0FPFHxAtd0O7xajU0omR9vSoh5X/+MxLkOGX+d4P/XrWGHBc/CBBwAesY23naCC3mzhJyb3ysvhuSmPQYjRqjtlFG+Cry9Ba9cHavDZqHrVb+LGW55BBidvk+8JDjn22dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812478; c=relaxed/simple;
	bh=YqmB8gQ2CSWotm3YyLmOYcMApzVTX/fpUiUxd3r4ALA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCoZRDEnyIdilol7CJkI1JBU8qWGjXb4VDh5QV3xZz3id9MUgMxd90jT1thEquLVJus0MX5rCWfMkDrnjGpt0BaEqctlRLOpU9plNNj36d9oGi5nagz7twOqDHysc01xSJNc1YhBU4TdJ9g2CF4fqGYM9l/tUnwc6qs4bewUVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5jUq8qt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQ7dT7oF; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782812476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT7VxdFpL+bwbQAtpOmSJ4nkpUzUgPkf4e0PHfftdcI=;
	b=N5jUq8qteDoM2HBNvyK73qszNNqKgxoj9PCsuFRJxktYMpuj3xaYNgBI+BlxA353im8Im2
	JH/aDt3RvCg7h7+fOHhTuyFdKZR82WRO3GvOmK+t8mmcYA15WZ8vcjz5EtJeqXN7QlL5y+
	OVBbQVFnPeSqyE+4bRBaWB8eEzZVILM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-myAJImPjMZCSGOJbWNIrRA-1; Tue, 30 Jun 2026 05:41:14 -0400
X-MC-Unique: myAJImPjMZCSGOJbWNIrRA-1
X-Mimecast-MFC-AGG-ID: myAJImPjMZCSGOJbWNIrRA_1782812473
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926d371224so26269005e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782812473; x=1783417273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sT7VxdFpL+bwbQAtpOmSJ4nkpUzUgPkf4e0PHfftdcI=;
        b=dQ7dT7oF2RDGNQd5S4pmUOsVKHR/kc7gZlJYMGC4Nxjwbk0zSIfJrBdZYwxrCZ1rix
         yBe+WffP77YzzIE0VNJo2xn8vbXSkuQoVmXOa4TpodHOH2WtXkS8AmnTt+eDez4oRkh9
         O3IjrzcCQH9k6mfpd+GZGP4XDv4u+2wGLdiEtNRt66YyWH2rxw3BwEPMIf8N/Ne6dGVm
         3Z/d2QDeicKnX9AAs6V53CM3XpPhsadBguevzSYJqIK8I39fTp6paJKV9JugCBn8QL5s
         /M3gshpdqlqX60DGQxbqfOJIkGtDCxM5R2/yXoWMxZTXvN4faKNIDOQAW2hrnyJh2jIx
         l5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782812473; x=1783417273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT7VxdFpL+bwbQAtpOmSJ4nkpUzUgPkf4e0PHfftdcI=;
        b=ilbJm5BS4lcqKchY9qWmLDl/4K14eJb/WYcleijjd9bmKOlEEVi/WtPZLjVI8Gt+vt
         WW4E/yc8ff6bXvDA9tKUdZcjiwaj7Y4+uRxtAD6ghu3OvJwGRAJc9sp348SZRvRzVbYt
         udGouho1kx8PTXZbJ9mw70E6qeCeIxzi31SjAtB24/rhZRTjeC4I6TJ5AJasIrdVQ1Q1
         THjBz87kIP3r+R6PcbKJ8CJpy9rIr26GGTCINA0VxIO/F1nRf8bJY70Qs6ys/lpSLy4R
         Wki+GJ71OLftatZfTO+6HwJyKvdE8GauDv99uOIaFnRrL8afaiWJb/JMnVdfcXY3blwb
         H+qA==
X-Forwarded-Encrypted: i=1; AFNElJ+px5FgoD53yCDQ4Hjp8XQCz3QXVJwGNqHnPfBoPELy+Ix+J4/vC0fTh2QqKrOsqZIN9GIU7Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvmwMrL0baWYGhIbeHglm/TDfddluXpGSlqrhikIb0xrao2to
	pPxEuZF1W8vTcInTg2jVNW09GiFXC+oLpj+ct2azaLtLwYDQ37ZI7F0NDEnwjMoKtcqNp01yN5g
	UO2gqj7cJQ1WPHl3t8GthOTIhLojcn/xQBG/uA4Y/mxc0R6jYc0T7LkTSuQ==
X-Gm-Gg: AfdE7cmzgB6YEb8JL60CrK6PE2ODbWbxH1HmD7Dt8V1YaIGoSzXh4eZEWVjr8w91YrP
	4wycNU8449Al0z9j2i/BNwRvLhKrNonnbAOXCAVr3nbA2vOgtS5R6b9W46xEyZ0viAunwCABMLa
	w/STDgG7KxH2zxii6F58kheM37ts7twq502yUdYtpA3SVcipy1t7fJqVoOERM4t3S5WojlF3MmU
	kTYjjdTDWYJjsG/B5u/Y860TfRcTT8W0kkCykTV0h4tWIFdNNyAwZO23SCjZ7zklfPS41wiIYke
	cfxRY8qeBWf65mHS1AyC8LqfMwRRW5wXKXT7TuXFb+5sHEeuk0cCKMKl/Cy3ZyRapfh7WQ/dVnU
	v/DiIOjSk8PMVClLq2txMiIJ1iZnMc2SDguURiteRD/kauVLNT7V1qXhPGKBh
X-Received: by 2002:a05:600c:a403:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493b82bc279mr38092645e9.31.1782812473067;
        Tue, 30 Jun 2026 02:41:13 -0700 (PDT)
X-Received: by 2002:a05:600c:a403:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493b82bc279mr38092065e9.31.1782812472479;
        Tue, 30 Jun 2026 02:41:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8d0bbbcsm64869355e9.13.2026.06.30.02.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:41:11 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:41:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oxffffaa@gmail.com, rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <akOOf7ShQS4OBJrd@sgarzare-redhat>
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303062-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,meta.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@rulkc.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobbyeshleman@meta.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06B176E26B7

On Sun, Jun 28, 2026 at 09:20:52PM +0300, Arseniy Krasnov wrote:
>Logically it was based on TCP implementation, so to make further support
>easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
>this way, patch also adds handling case when 'msg_ubuf' is already set.

Thanks for this!

IIUC the result will be similar of commit eb315a7d1396 ("tcp: support 
externally provided ubufs") for tcp. Maybe I would have added it to the 
commit description, anyway the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>---
> Changelog v1->v2:
> * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>   already added.
> Changelog v2->v3:
> * Update commit message.
> * Remove one empty line.
> Changelog v3->v4:
> * Update commit message.
>
> net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
> 1 file changed, 22 insertions(+), 25 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 09475007165b..41c2a0b82a8e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>-	if (info->msg) {
>-		/* If zerocopy is not enabled by 'setsockopt()', we behave as
>-		 * there is no MSG_ZEROCOPY flag set.
>+	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>+		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>+		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>+		 * handling from 'tcp_sendmsg_locked()'.
> 		 */
>-		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>-			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>+		if (info->msg->msg_ubuf) {
>+			uarg = info->msg->msg_ubuf;
>+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>+			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>+						    NULL, false);
>+			if (!uarg) {
>+				virtio_transport_put_credit(vvs, pkt_len);
>+				return -ENOMEM;
>+			}
>
>-		if (info->msg->msg_flags & MSG_ZEROCOPY)
> 			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+			if (!can_zcopy)
>+				uarg_to_msgzc(uarg)->zerocopy = 0;
>
>+			have_uref = true;
>+		}
>+
>+		/* 'can_zcopy' means that this transmission will be
>+		 * in zerocopy way (e.g. using 'frags' array).
>+		 */
> 		if (can_zcopy)
> 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> 					    (MAX_SKB_FRAGS * PAGE_SIZE));
>-
>-		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>-		    info->op == VIRTIO_VSOCK_OP_RW) {
>-			uarg = info->msg->msg_ubuf;
>-
>-			if (!uarg) {
>-				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>-							    pkt_len, NULL, false);
>-				if (!uarg) {
>-					virtio_transport_put_credit(vvs, pkt_len);
>-					return -ENOMEM;
>-				}
>-
>-				if (!can_zcopy)
>-					uarg_to_msgzc(uarg)->zerocopy = 0;
>-
>-				have_uref = true;
>-			}
>-		}
> 	}
>
> 	rest_len = pkt_len;
>-- 
>2.25.1
>


