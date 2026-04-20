Return-Path: <netdev+bounces-279759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGbOK2At5mliswEAu9opvQ
	(envelope-from <netdev+bounces-279759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:42:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC5E42C2B3
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8062309302B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527D43A873C;
	Mon, 20 Apr 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVcmeEr5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fF4+aoQ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51E3A1A5F
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691262; cv=none; b=eYjAiJbY5ZJYXvIlkU3xkk5STTFD4efN2/eDtwmmL1okowvvsdwwDm/IesFtkgr2A48tGYbFfmMFaJgSzjxwrqzo9GqphFoOXchBq8vOAMXwLNPneE5llcT8lNG85amUQNZwbZj6HbYPby7QOHq5UKlh896dC6/HnKfpx4iJeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691262; c=relaxed/simple;
	bh=oRz4R1uy7BvYcGv9q3SW450IGK8oQQE9HdAqw2IRtxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gb9bu577kXvToGxZUjktsDHNZiWWZ4rT1k5zAFCdqgMveT8ruJ8R9Sf5sNyFuurPYNpq6GeHewc880l2CPcbiae30S8lNXmpqRG9+20fK0MDq18YJpZSQQnUGVX21oyi14v8SiyaFCLfy1A2rtI47w+rODoU8UiPOFAe52RoiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVcmeEr5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fF4+aoQ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776691259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZNw8VU2wHUCMW8yOpvKsEhvAEIS86OBEtLoYfE3AKWY=;
	b=aVcmeEr5dkPGzG+90vVVOTyb8QbM508qn1ikfML0VvgARuznIsFTeGzDzbS0CKcRiHkkX0
	FgGUF6156RWuzaY3GRrq1gjzsuTAMV4mjExauK0E7e2xJQKRXzupCj3QhQuDzUCQ7Rftwf
	0nEhyE8x2RSraKmcSTQK+mtebL7kPh0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-mnRA86KbM7al5TF_gvLRGA-1; Mon, 20 Apr 2026 09:20:58 -0400
X-MC-Unique: mnRA86KbM7al5TF_gvLRGA-1
X-Mimecast-MFC-AGG-ID: mnRA86KbM7al5TF_gvLRGA_1776691257
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a1f9601so862847f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776691256; x=1777296056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNw8VU2wHUCMW8yOpvKsEhvAEIS86OBEtLoYfE3AKWY=;
        b=fF4+aoQ9ORE+8pfPTrY9kG7rar5FYNikC4i9K7e0v9tPpt2C5FwkWfyCfPEEpAy/pv
         CnqLM1jYEgwYtHevuEjNDYqSqAodtWChyk5m61n7ozsaDQHwZ+kDnFi7Ef8eJ8sgYdGg
         z8M+U5LvhAsDLB7uPTBuwO+t1vLECvG33ptkZ0XDMXvIOEug+vGqCRf75K2pDkJQUHnZ
         Fizh2cBJkn4MB/iuOw9ZZXvWmKYZzrknCW81lUBhtDusJTfH5bvvQCvincWxjPpmCJwp
         FfjxKXmroSm1EPN9FnI4BOBNRlmKkX9PemriunFoGlTJ7F7LTHhQ5Z4aD+WeImQehbPa
         d4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691256; x=1777296056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNw8VU2wHUCMW8yOpvKsEhvAEIS86OBEtLoYfE3AKWY=;
        b=b/jBj01B7VnO6YIAi6sPlj2Ow2TQYDvO5o0XRs0CzdatR/cKU45BdGVcgN0VRtMrLx
         rf6Iby45+PSfmh+zW1DGcUAt2EM+tcUPemmVBdxW1yhj7FGo0wYdvSNF5CaRYLO+4mSN
         XSSkaP8jE3CRU4gyeHZTkj4GWBhOWNandKIts7L+2a8J8bt73JqjvxxEGcSpaJc9d0xW
         z2kxWJT/JiVu13JjF2VdyBactB6GrvQD3YGBXBIiLAg19xVlGUAeFfjTjfujTBQZk4QO
         92Qrrc+YRKZxQ9nHw7oYtx8hwZ4w0nH9bsHzPdN4/8WeK9yuXVHVVRo8+SiKqgcJ1CjK
         nrzQ==
X-Gm-Message-State: AOJu0YyLJG748TMC489luGNKDxR4wyKMKBxLfZW1VDujNzu8KURA8Xyw
	aiX4nw5Q7aDv+7QRta1FNr5DHuMyjaGe8E+jvTMqQCxvPZdE0iQTH3wpmkFH4YFvfX6xbLoqXyH
	xFEi2VWYcY4ChrMiczLfFTtZHtmVqFEVxCogocndfn1AzIMCV1eJVAraV7gqTtjeFySQcfPwfoB
	cUJgz5f2Buv6HFSUAb2MGsVbbdjZo6KVvhyrJGV33w9w==
X-Gm-Gg: AeBDieu269EFgSJAk6B8OlW8atdH5Nngl6Ximz/6MnaGYSl7Mx7amYM0xTl/JEg+v26
	t5uFHVyO4WxzEObDfp3Hve5T0XIpPINo8LKgZFw7TatIj4nTpPdg+nZ7wy7rc9SeeM41lmnAwYu
	UXKKlYZtYtmSmgvKkiQ9gtR0++/WfctdMwIwybr1tbX0PIGwGovCfhoGRmAG3nDkKFX7BFBNEI9
	fxUGRwezt5zKNlO/STjBfTgcEO08sUHeWybmQOOrPXT5wrWEmeRDCI7UMKnkusRqS1bQkjei0cZ
	QafM6uW1SKlbkPi7y6VQd7ETNow7Wd38s5hd7vIrqyiUUVmej44f/3vga2qcdX6pf/gxgGrVCYw
	Coax3dYxFNDUViFsAj1n2d3QXv6EnSJCGEyRPSAx/dDTKQFMeA20qXTlUUzXvxxtQl4SyUr+6Cc
	msQJrebkdS
X-Received: by 2002:a5d:5e01:0:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-43fe3dbec67mr19818847f8f.4.1776691255962;
        Mon, 20 Apr 2026 06:20:55 -0700 (PDT)
X-Received: by 2002:a5d:5e01:0:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-43fe3dbec67mr19818744f8f.4.1776691255247;
        Mon, 20 Apr 2026 06:20:55 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm28294807f8f.4.2026.04.20.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:20:53 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	kvm@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: [PATCH net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting
Date: Mon, 20 Apr 2026 15:20:51 +0200
Message-ID: <20260420132051.217589-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,vger.kernel.org,salutedevices.com,davemloft.net,lists.linux.dev,linux.alibaba.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-279759-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FC5E42C2B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefano Garzarella <sgarzare@redhat.com>

virtio_transport_init_zcopy_skb() uses iter->count as the size argument
for msg_zerocopy_realloc(), which in turn passes it to
mm_account_pinned_pages() for RLIMIT_MEMLOCK accounting. However, this
function is called after virtio_transport_fill_skb() has already consumed
the iterator via __zerocopy_sg_from_iter(), so on the last skb, iter->count
will be 0, skipping the RLIMIT_MEMLOCK enforcement.

Pass pkt_len (the total bytes being sent) as an explicit parameter to
virtio_transport_init_zcopy_skb() instead of reading the already-consumed
iter->count.

This matches TCP and UDP, which both call msg_zerocopy_realloc() with
the original message size.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 0742091beae7..416d533f493d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -73,6 +73,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
 					   struct sk_buff *skb,
 					   struct msghdr *msg,
+					   size_t pkt_len,
 					   bool zerocopy)
 {
 	struct ubuf_info *uarg;
@@ -81,12 +82,10 @@ static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
 		uarg = msg->msg_ubuf;
 		net_zcopy_get(uarg);
 	} else {
-		struct iov_iter *iter = &msg->msg_iter;
 		struct ubuf_info_msgzc *uarg_zc;
 
 		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-					    iter->count,
-					    NULL, false);
+					    pkt_len, NULL, false);
 		if (!uarg)
 			return -1;
 
@@ -398,11 +397,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		 * each iteration. If this is last skb for this buffer
 		 * and MSG_ZEROCOPY mode is in use - we must allocate
 		 * completion for the current syscall.
+		 *
+		 * Pass pkt_len because msg iter is already consumed
+		 * by virtio_transport_fill_skb(), so iter->count
+		 * can not be used for RLIMIT_MEMLOCK pinned-pages
+		 * accounting done by msg_zerocopy_realloc().
 		 */
 		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
 		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
 			if (virtio_transport_init_zcopy_skb(vsk, skb,
 							    info->msg,
+							    pkt_len,
 							    can_zcopy)) {
 				kfree_skb(skb);
 				ret = -ENOMEM;
-- 
2.53.0


