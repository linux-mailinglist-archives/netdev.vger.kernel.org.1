Return-Path: <netdev+bounces-296986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uTjWEJfTJ2r42wIAu9opvQ
	(envelope-from <netdev+bounces-296986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:49:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44965DF53
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:49:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=G5J3Dd6H;
	dkim=pass header.d=redhat.com header.s=google header.b=mO6eO+dx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296986-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296986-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 403AA3015C0D
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4CE3EDE40;
	Tue,  9 Jun 2026 08:49:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4763DE434
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:48:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994941; cv=none; b=Z/znNAluMKqka1ns+XDTtAg1JW3KcY2Ky0vHs7TdwR2Bsep9RZQ5kH7b6VWRRXs/Fc/dqAI1arXTHGxZFDSwwy2HL/jK69HF7TiBdFJJwpBspcnScLB0cnmBqJpLftMZw+kyH7ZK381DxSzisARHwBu0lYsAAJARYv1/MW4vYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994941; c=relaxed/simple;
	bh=NDpEqQTyBnFaNwSrHBIymgwCB1NOUG/MXeIFTqcPqBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+cEoIEoTaPeYYMFxmNsCyzHzBR+JG3vBR7rDrK/w7r19WicL8Zb6U+kwnzAh60D2voGrP5SJtGSBDQHLeUSphIcfYQyKJLQuSLKqfYhYhO3i60zTzYEqUHjoqjGRnAgMLYiMJL3chdR8VcjENpeJmBHwrNK6WZgErNf0ms/i+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5J3Dd6H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mO6eO+dx; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780994937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVJGRkzfCQAxcTxT+5xsslew5qgZuC6BrnznINZ4a2c=;
	b=G5J3Dd6HJag7xvJf8rcVQlAA34jOMelsQBGstIW/kaUbuiaosvUupFcJUEuvbvNbdvsgAD
	+3Jm4qAaLMgAwvUGJYw50D8haGPn6IbgBSdYdBZPGxCx9L6BrLb+VzXt2TU472mkkoQrAo
	SI1Vxo/E+E0RGgIoc9j868+HPjPpCW4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-eVO_w9DbP4WP70UK-MHJag-1; Tue, 09 Jun 2026 04:48:56 -0400
X-MC-Unique: eVO_w9DbP4WP70UK-MHJag-1
X-Mimecast-MFC-AGG-ID: eVO_w9DbP4WP70UK-MHJag_1780994935
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4600cf05f07so2830275f8f.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780994935; x=1781599735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YVJGRkzfCQAxcTxT+5xsslew5qgZuC6BrnznINZ4a2c=;
        b=mO6eO+dxWAMk2IyPQbn0F35X9EiRPxDiwhZE9euNqyOW4F0Ox5YztgaPpgV+TF6/Tf
         LNpTyj3dvPe1C5MzJWywuyd6qZ4vEquaoKjrFMKJih6/elilFmmffpqyRYLA59nF3Df8
         UXa67L+l8wVpqVvhWG63y5+8ppb1wXyRKnVUWUQzB8c8cWx3LY3105L1yTEc/YBJbOc9
         PzDjc1LodY2Kn+yiGsbfwyxE286zMFwRoEnmDPR0D+3c157D7c5+xpu54hiDGnTKP3z0
         u27sqAGNpJ/CFOY9HWCIfGffVljh5ItJpMHrDZtjSjbMcivgfHGH9ZhYA71u5JX+7CgZ
         hGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994935; x=1781599735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVJGRkzfCQAxcTxT+5xsslew5qgZuC6BrnznINZ4a2c=;
        b=UpSzMVCUrWiPxN1wwJsqNrFVd1+bhvfEbK+AVPUPySRxIBIKzTgrgCvZNgx1xGfFxs
         edKyolLLtNv3f7FwXX15PieC9Ff/KBDBtO08HxAqPMUDzuPxH1UwhQEMW10MxDzcXzwX
         jagTQ+RO9FbN6W9KGNxMWeF7n9Y70vxVZjVpy/CqAYaUOxXHmCPPTArHV5q2YEB6m32n
         sDrFFb1ElxoBBfECeBFAnUuSTaJgP8dVS4OEyJ5PjnyxJlVbmRXLGtlHzewAg/K/hG/e
         G3zSuryJZzTrQfs3HzFVsuPpugQi30sWayST3f4cSTi4yeN9HbOcMT69mNPg78yaahSy
         Skfg==
X-Gm-Message-State: AOJu0YzW4RJe03W8XH09vWHAQufyP5GaIclGbYAlaWPFktlOeN2mjkBz
	jKUVCG75UD4kyy58RN+Vo1xemRh9iFlcYE4O8Pby65PKys4pImlAcC9P1icShcnXiG09eQRObTI
	UrSxgA9uwsx5cO52SfZyQ4vURhKOB2JpCQJLZNGpZVs/NWlcvLJm/bWyXdQ==
X-Gm-Gg: Acq92OEGVV0Ocr9lrNhyQqg284puiwJKd/yQRMV85XMfaW9KLRmVjYeWaO+s5BGkAZ6
	Wzmy3hJJO9yj6Zk4e5wVJFVc33j2YSjtf5njoN2cFmA5hX7p+iqjKa8zR2H6T2YovuUJKNxjrtU
	tFzFLJ3/DHsSanl3/zeHyaincRQNjYGTzTdVlMQAujtKmcogG4e9kWKyXQANUXSYcPivRsCHfiY
	xCKqmIOOBI54gBYpSysZiyGCn2CwxE49F6WPrVHkoi74R7tUBrQ4BoX3pjDX9zH2vsAFRPQ8wOO
	+7g2eBwG0Ul1SXkX5hffLW6pXlszKtQacZxSBfTMfbF1bs4+1ZvNSPx+TCP3FQdpXUsvHNozIMV
	GGNDj3aqYKWlt8fDsI7/q8fX3VXPRyEgRTbk1Neh8eTyWMcYZ9KkWBwYTkt5bg5nHESAOmKa43f
	CKro6Zfw==
X-Received: by 2002:a5d:4e03:0:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-46030641a81mr22875630f8f.24.1780994935290;
        Tue, 09 Jun 2026 01:48:55 -0700 (PDT)
X-Received: by 2002:a5d:4e03:0:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-46030641a81mr22875570f8f.24.1780994934775;
        Tue, 09 Jun 2026 01:48:54 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm108611773f8f.29.2026.06.09.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:48:54 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:48:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: netdev@vger.kernel.org, 
	syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: restore msg_iter on transmission
 failure
Message-ID: <aifL0f_QO1kocccU@sgarzare-redhat>
References: <20260609004809.1285028-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260609004809.1285028-1-tavip@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296986-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tavip@google.com,m:netdev@vger.kernel.org,m:syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com,m:stefanha@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:avkrasnov@salutedevices.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,28e5f3d207b14bae122a];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA44965DF53

On Tue, Jun 09, 2026 at 12:48:05AM +0000, Octavian Purdila wrote:
>When transmission fails in virtio_transport_send_pkt_info, the msg_iter
>might have been partially advanced. If we don't restore it, the next
>attempt to send data will use an incorrect iterator state, leading to
>desync and warnings like "send_pkt() returns 0, but X expected".

Thanks for the fix! I have some comments.
>
>Specifically, this can happen in the following scenario, triggered by
>the syzkaller repro:
>
>1. A write-only VMA (PROT_WRITE only) is partially populated by a
>   prior TUN write that failed with -EIO but still faulted in some
>   pages).
>2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
>   buffer from this VMA.
>3. The first packet (64KB) is sent successfully because the pages are
>   populated.
>4. The second packet allocation fails because GUP fast pins the first page
>   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
>   permissions.
>5. The iterator is advanced by the partially successful GUP (68KB total
>   advanced: 64KB from first packet + 4KB from second), but the send loop
>   breaks and only reports 64KB sent. This creates a 4KB desync.
>6. The next retry starts with a non-zero iov_offset, disabling zerocopy
>   and falling back to copy mode.
>7. In copy mode, the transmission succeeds for the next packets but
>   exhausts the iterator early because of the desync.
>8. The final retry sees an empty iterator but zerocopy is re-enabled
>   (offset resets). It attempts to send the remaining bytes with zerocopy
>   but pins 0 pages, creating an empty packet.
>9. The transport sends the empty packet, triggering the warning because
>   the returned bytes (header only) do not match the expected payload size.
>10. The loop continues to spin, allocating ubuf_info each time, eventually
>    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.
>
>Restore msg_iter to its original state before the packet allocation
>and transmission attempt if they fail.
>
>Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
>Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
>Assisted-by: gemini:gemini-3.1-pro
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b10666937c490..588623a3e2bbc 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -367,6 +367,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	do {
> 		struct sk_buff *skb;
> 		size_t skb_len;
>+		struct iov_iter saved_iter;

trivial: reverse xmas tree: 
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>+
>+		if (info->msg)
>+			saved_iter = info->msg->msg_iter;

What about using iov_iter_save_state()/iov_iter_restore() ?

IIUC we may need to export iov_iter_restore(), so not a strong opinion, 
but it looks better to use those API IMHO.

>
> 		skb_len = min(max_skb_len, rest_len);
>
>@@ -375,6 +379,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 						 src_cid, src_port,
> 						 dst_cid, dst_port);

What about adding a comment on top of virtio_transport_alloc_skb() call 
(or when we save the state) to explain that in specific cases it can 
advance the msg_iter ?

> 		if (!skb) {
>+			if (info->msg)
>+				info->msg->msg_iter = saved_iter;
> 			ret = -ENOMEM;
> 			break;
> 		}
>@@ -382,8 +388,11 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 		virtio_transport_inc_tx_pkt(vvs, skb);
>
> 		ret = t_ops->send_pkt(skb, info->net);
>-		if (ret < 0)
>+		if (ret < 0) {
>+			if (info->msg)
>+				info->msg->msg_iter = saved_iter;

Also, what about having a single restore point after the loop?

I mean something like this (untested):

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b10666937c49..2f3c6c82c155 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -295,6 +295,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
         u32 max_skb_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
         u32 src_cid, src_port, dst_cid, dst_port;
         const struct virtio_transport *t_ops;
+       struct iov_iter_state msg_iter_state;
         struct virtio_vsock_sock *vvs;
         struct ubuf_info *uarg = NULL;
         u32 pkt_len = info->pkt_len;
@@ -368,6 +369,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
                 struct sk_buff *skb;
                 size_t skb_len;
  
+               if (info->msg)
+                       iov_iter_save_state(&info->msg->msg_iter, &msg_iter_state);
+
                 skb_len = min(max_skb_len, rest_len);
  
                 skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
@@ -399,6 +403,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
                         break;
         } while (rest_len);
  
+       if (info->msg && ret < 0)
+               iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
+
         virtio_transport_put_credit(vvs, rest_len);
  
         /* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.


Thanks,
Stefano

> 			break;
>+		}
>
> 		/* Both virtio and vhost 'send_pkt()' returns 'skb_len',
> 		 * but for reliability use 'ret' instead of 'skb_len'.
>-- 
>2.54.0.1064.gd145956f57-goog
>


