Return-Path: <netdev+bounces-287879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACwiBx+WBWpLYwIAu9opvQ
	(envelope-from <netdev+bounces-287879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:30:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA0D53FCAE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 209383004D02
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E23A6B8A;
	Thu, 14 May 2026 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqHmrock";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzhzmzkI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95C3A544F
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750997; cv=none; b=joEW8Yo4kK2STzlBFsptM5Z+r/vF1wggPnYjoxmiq6D2EkmP6QH7pTJdjbjKIavbB7yaEoPqJsCwHdKNZCKWKITWm2EB89zj7TbYkrZ373jWrNhSG+gPV+wBdaMbv9CzfdqMNEIj/N6z3rvEMhbV6jdfAs6kCYfl1/BbvxUmiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750997; c=relaxed/simple;
	bh=giBrJRQN2VMMjCh/yoL5SJRMxEqzegUg6O8u4pivPpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+01uRkkGWZGckAvymZFi/HXL65ZBwt68Friv1sZGW9eS/MEba74Qc1IULqz7YoxfYP0ggm/o5v0jdvAuWymMf3H2lg/861SPbdaWo7vPQzDnjiF/tu95aiBeGfwqSa3P0ubgsTKTkqfoj+DKoz7upaRBJZ+ii6yBE5B4FNYLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqHmrock; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzhzmzkI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778750994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X7d0CywKsZQfA/8iHBsstOBzlQ/bG9Xhxh5p1dy0nCs=;
	b=CqHmrockUf/NL4EU8+A9D6jsxXFfXxgSLQEnH2nSjjk71gVOh+J2/wunMfFLVkCNFSauvx
	bqDJ53zI0qyvZYcyVqTzQ9VNojCgIjwaRoXo7A6/0LRxxVTz1c5juy9FoMwb5BspUvLYSL
	dI0bnWOg3ESd6NW+EmhQjg+Jyf655Nw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682--CPyWDWQPcirupC6kg7BtA-1; Thu, 14 May 2026 05:29:53 -0400
X-MC-Unique: -CPyWDWQPcirupC6kg7BtA-1
X-Mimecast-MFC-AGG-ID: -CPyWDWQPcirupC6kg7BtA_1778750993
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so38851545e9.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778750992; x=1779355792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7d0CywKsZQfA/8iHBsstOBzlQ/bG9Xhxh5p1dy0nCs=;
        b=OzhzmzkI+J9OzBIERCrgLc7zkdxsS+Jnx0q2QIrIDnwfmsZ3CJDGapprCN8gJXAbGh
         W30pTa+BBTNoL20DvZHYJupUsT8x7rNdQhkXddKbRLBxGhbn07unB2JcqlkOjKyFTtZL
         sWrhyVQ3se4gdTBo5e7kARVWvGMt7vKLCpSomROyuJ4v0SjhX5Y1PTx3wDlFnEGtzYWw
         /XdgC3hEypLZqI6YJnJqF8SU3B3qKVo0JSSPwQilOtCfyYsJ/15OSnauUjGHf3PxuTb9
         bF3yKynoebOnygYyVE6wlDwiNEIruHb+cZuRt/rmULoJZKszsAWfsXp7zaurayFd7eH2
         BNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750992; x=1779355792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7d0CywKsZQfA/8iHBsstOBzlQ/bG9Xhxh5p1dy0nCs=;
        b=nAFndPaKLjejeLi9+UU0U9hlSv/+EUV6mBs6hDQ5sJ/XnO5hWSy6fEzbXzEI+vjECa
         RFRy+BayXpvcd1iQrfGVMu/kHT9TEmSLyYhq+kqJiV+bcaBpzi/JqtutssFZQIt+K655
         XPICoMB00O0lxurLSmkaxNAufNi6pehVp+bsIDyF7zvW8ndTRqBzlle8IqFaYuZ+Evum
         P7H8YzEwx1eNxk5JOxPGK2SwET6lLlq/D1mDlovQbcxibRXMieN6HBa9FNOZva7SU1Ts
         obfYPGYCUx6OjvvkdFfcRpv7hIM6o+NsL3bNdhpEsXSnCnru0mWUpTL1xjXfW5W1IT2H
         1+Tg==
X-Gm-Message-State: AOJu0YzOgO776gfZdv4uR2Onii9rtfVW/okDhz4sBynl/HMhGrDmjFz3
	A7T/tazvPBu0rHXLjAJMnoaTtT7BRzYhap5DShX/jv1rEWkd1jJoBRDjAXDSaScSJTAkPvOW5ge
	Z3Xo6+spy0JY25j+5U/btiWcxKhptPjSNBkuVhLKKQkehCEx1nH66/CL44UuMAuOKLZjTp1LWd0
	/iWobEp+7Z4Jn0tkCatwUeBVqnkZs6pZSx+/ojz5yp5A==
X-Gm-Gg: Acq92OE0e/y423WcvCAGxPagoI8likXyqe3FtQJhtjtEfGkQGh/72aL4ZA/ju8fsRCq
	+Vu5Tt+7hWbng5O7QBmrnQEErraXTlrCI47vyJGlDBskwt6wSn0nfcsXmDMdgjdVnUOF1OU/CyF
	7Tyr4uAQlB8AbWOZronrl+WrD2Nuh7X0VxyfhzHmzNHi85af1YUmkVqvntnDLQ4jW5K1/2UbuDB
	5OU/rgR3O6DVcJTfAtkO661lVVb8zMa3bmMXh726PFebxUD8q24102hYiBEdcLqH6TrQZHrtMtL
	aO0289l7nZ5CUhzHCxBHTveBTfsp4G6A8vF6hCDqOiZpL+zhFD7KmempyGZx/nSsFQ197ucqQbP
	ON/CFRMNA46yOdLCloEkiaiLLsenfkBjaYPJ87xfsawB2Dv92rG5eNLU1Gq1YpbBInuLYHS0=
X-Received: by 2002:a05:600c:a305:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fe24960bemr2343755e9.13.1778750991898;
        Thu, 14 May 2026 02:29:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a305:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fe24960bemr2343285e9.13.1778750991254;
        Thu, 14 May 2026 02:29:51 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd7672ae9sm19873735e9.6.2026.05.14.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:29:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb sends
Date: Thu, 14 May 2026 11:29:48 +0200
Message-ID: <20260514092948.268720-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EA0D53FCAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,salutedevices.com,vger.kernel.org,google.com,linux.alibaba.com,lists.linux.dev,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-287879-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

When a large message is fragmented into multiple skbs, the zerocopy
uarg is only allocated and attached to the last skb in the loop.
Non-final skbs carry pinned user pages with no completion tracking,
so the kernel has no way to notify userspace when those pages are safe
to reuse. If the loop breaks early the uarg is never allocated at all,
leaking pinned pages with no completion notification.

Fix this by following the approach used by TCP: allocate the zerocopy
uarg (if not provided by the caller) before the send loop and attach
it to every skb via skb_zcopy_set(), which takes a reference per skb.
Each skb's completion properly decrements the refcount, and the
notification only fires after the last skb is freed.
On failure, if no data was sent, the uarg is cleanly aborted via
net_zcopy_put_abort().

This issue was initially discovered by sashiko while reviewing commit
1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
but was pre-existing.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
Reported-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 989cc252d3d3..1e3409d28164 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 	return true;
 }
 
-static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
-					   struct sk_buff *skb,
-					   struct msghdr *msg,
-					   size_t pkt_len,
-					   bool zerocopy)
-{
-	struct ubuf_info *uarg;
-
-	if (msg->msg_ubuf) {
-		uarg = msg->msg_ubuf;
-		net_zcopy_get(uarg);
-	} else {
-		struct ubuf_info_msgzc *uarg_zc;
-
-		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-					    pkt_len, NULL, false);
-		if (!uarg)
-			return -1;
-
-		uarg_zc = uarg_to_msgzc(uarg);
-		uarg_zc->zerocopy = zerocopy ? 1 : 0;
-	}
-
-	skb_zcopy_init(skb, uarg);
-
-	return 0;
-}
-
 static int virtio_transport_fill_skb(struct sk_buff *skb,
 				     struct virtio_vsock_pkt_info *info,
 				     size_t len,
@@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct virtio_vsock_sock *vvs;
+	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
 	bool can_zcopy = false;
+	bool have_uref = false;
 	u32 rest_len;
 	int ret;
 
@@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		if (can_zcopy)
 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
 					    (MAX_SKB_FRAGS * PAGE_SIZE));
+
+		if (info->msg->msg_flags & MSG_ZEROCOPY &&
+		    info->op == VIRTIO_VSOCK_OP_RW) {
+			uarg = info->msg->msg_ubuf;
+
+			if (!uarg) {
+				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
+							    pkt_len, NULL, false);
+				if (!uarg) {
+					virtio_transport_put_credit(vvs, pkt_len);
+					return -ENOMEM;
+				}
+
+				if (!can_zcopy)
+					uarg_to_msgzc(uarg)->zerocopy = 0;
+
+				have_uref = true;
+			}
+		}
 	}
 
 	rest_len = pkt_len;
@@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		/* We process buffer part by part, allocating skb on
-		 * each iteration. If this is last skb for this buffer
-		 * and MSG_ZEROCOPY mode is in use - we must allocate
-		 * completion for the current syscall.
-		 *
-		 * Pass pkt_len because msg iter is already consumed
-		 * by virtio_transport_fill_skb(), so iter->count
-		 * can not be used for RLIMIT_MEMLOCK pinned-pages
-		 * accounting done by msg_zerocopy_realloc().
-		 */
-		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
-		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
-			if (virtio_transport_init_zcopy_skb(vsk, skb,
-							    info->msg,
-							    pkt_len,
-							    can_zcopy)) {
-				kfree_skb(skb);
-				ret = -ENOMEM;
-				break;
-			}
-		}
+		skb_zcopy_set(skb, uarg, NULL);
 
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
@@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	virtio_transport_put_credit(vvs, rest_len);
 
+	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
+	 * skb_zcopy_set() increases it for each skb, so we can drop that
+	 * initial reference to keep it balanced.
+	 */
+	if (have_uref) {
+		if (rest_len == pkt_len)
+			/* No data sent, abort the notification. */
+			net_zcopy_put_abort(uarg, true);
+		else
+			net_zcopy_put(uarg);
+	}
+
 	/* Return number of bytes, if any data has been sent. */
 	if (rest_len != pkt_len)
 		ret = pkt_len - rest_len;
-- 
2.54.0


