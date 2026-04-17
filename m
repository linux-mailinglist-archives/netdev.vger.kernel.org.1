Return-Path: <netdev+bounces-279319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WICSEoE34mm13QAAu9opvQ
	(envelope-from <netdev+bounces-279319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:37:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E088541BBA0
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D1B830164CD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 13:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417732D8DBB;
	Fri, 17 Apr 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnK1R9Tu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73A384250
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776433020; cv=none; b=se9vzj0j9kTmLHouucJJF7nyr2KAyfI4Zax5dr3tVhvCJpiirOad9sPD5CSp/niErIoIhgI+c29lS7teXlBn7bNPSNO7/It4XiwJFs9pgPEbiiD4m6awUmIVw2m1G4bI27LNOzALZlUYn4HLZSCSjhEjKXsfmJ+PBL1DAMMOFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776433020; c=relaxed/simple;
	bh=o6nRsoHRbabeUEx5FRlO1E1P9PR4iGXFvxod9XNvcs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0h2sGWC5tbEkwAwmms/SokjpS09jK0uDvcujGCGdogZEyUjsW84LWRg/wVV9dx8GNM6lbCyYLVv6t/oR7nCGZ3OuK0zaY4pFf9rAGvvpnCh2R0bdNKdADUmGNgPL+r4b0Kq7nO68DS7uB0EkJKSxMRJv/lu/cr170HfkUG7oFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnK1R9Tu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c70b5594f4so76201285a.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776433018; x=1777037818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN1Vl2vCUK3z1yjVhJuVnrXRp0s++5jKB8Kqq1WFb3A=;
        b=bnK1R9Tu3Y0PCx9TRvY6GNO4jAlF7YmIEWfmrvOpT0Pu/p4UVVvFMcFg0IyhL2nJq1
         cg3LBbDmOCw3ZFx1nFJOZsibq8qHtj2JUXKuRBHTee6g/lwsgHzzyRjo3TColWJt9tmP
         XW0siS5TksbdgAO8u+12t1hX7LpafHOnvCwcqEWHJJ0Xu9M3U8bgnqcNM22v0jzWe6f5
         BbfCfJfsynD6ucOCCPrNJ97aVVL0Cxng+HqUhDHREf73TG2VIh090Fni7z+nui0DTVwR
         s8cKl1TqmOHwg18/GiRpDw5f6n8Tv1cxXZuwKCwbTG8uDhJ7RTWVxpeonKETEZXbHg7f
         qrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776433018; x=1777037818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qN1Vl2vCUK3z1yjVhJuVnrXRp0s++5jKB8Kqq1WFb3A=;
        b=IamI+6t9kNuNRKDrvduRBTtkebMl76Q6XwzAM8ks4PZHd82mspzlxmMzwo9PcRnJv6
         h+sSw3zWUz2ELO+5oGvH4ZWkIr9WZV1GsWcoj4Mt/X+/kCY9ksoK6HUM4rySOe53NFQm
         k0e47erH83i6orDV3KQ8h44VkGlWvE6I+SRJi+wGfGqdFbazGDzRNttKOZ7C/8vdpsWt
         oiZo+xahyKY1tK00JUUwskVzbsUmCG+bd5SSesyhR8QIpeMt14zWnKqiePBBVqQggzY1
         ptgx7cF7iRi2zDZkQ+XkHXi3QQ69iRNdAwDrdN6+tvmefBg0vkGZDIJMLMHqd9Y5s607
         FmYw==
X-Forwarded-Encrypted: i=1; AFNElJ8paZb+BIHU3GPPCjESucg7vgsgwGkvZvqbpNdcQUR8N4TXGk/3i0WrInZEVv++BVwy1lBsBfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLR+EnT4vns6eCyQoB5zj5SaqULdKJSHQDfPxj8S/Iv/8j5pS1
	mNJ/Ml7kxkHIgOSVLAnj/NABrlHZwx/aaF82qNM0UZxK2XW0fNAkidKICYZk/tJG1xI=
X-Gm-Gg: AeBDiets2n15JnSOB28zHQon6OsdVP1VLv9U2ULXy04jo7u2nNOR7Esg3sje0lhJ5Ev
	hkQPvhUQQoIejOyso8/7TIgR6mUSe6pobstmBY4+JvfCCPkiHG5C9UHY7jUqTHbRy9ZT5VQ66W5
	UTX6W1JWIctt22SK5DjAuHSdiwR6ghaREOHEdkaiHgPTxVXn/zaW9gDBLZb1WJMEb5h1dumvzBB
	rwjyffutXtK61IfNS1ZA17Rp/heP93qa1pP8kcvVymclw5TblmiMmHk8PheMBlPS3wb9Sp4oyMb
	8RuQeInKOjvfEGPTWEPVCKqcpNAogpDpEz2faSx3n4LVlFQV1IcZ4n3LMz4J56H4LdRnDhFnWna
	TXajDzTzErh7fTyu69MdzJqAo2WfN+U0Ecm8mXaNk/uIgbS6dxiLG8nBWd+kdfqgqdbwjhkNnpE
	xw8sMByDOmFCHalCzgiGkN44Z+XM3Z0NP9UK3YCyqfWb2z2ZdAGkFF16MO1sw9SgJIRSYAmCYbK
	QldLLE=
X-Received: by 2002:a05:620a:4690:b0:8d5:8815:ffbf with SMTP id af79cd13be357-8e789874c59mr324492085a.2.1776433017630;
        Fri, 17 Apr 2026 06:36:57 -0700 (PDT)
Received: from localhost.localdomain ([104.128.58.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d93c2fffsm106948785a.36.2026.04.17.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:36:57 -0700 (PDT)
From: Zero Mark <patzilla007@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: security@kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Zero Mark <patzilla007@gmail.com>
Subject: [PATCH net] net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
Date: Fri, 17 Apr 2026 21:36:10 +0800
Message-ID: <20260417133610.88158-1-patzilla007@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <willemdebruijn.kernel.1683671b10e8@gmail.com>
References: <willemdebruijn.kernel.1683671b10e8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279319-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[patzilla007@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E088541BBA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In tpacket_snd(), when PACKET_VNET_HDR is enabled, vnet_hdr points
directly into the mmap'd TX ring buffer shared with userspace. The
kernel validates the header via __packet_snd_vnet_parse() but then
re-reads all fields later in virtio_net_hdr_to_skb(). A concurrent
userspace thread can modify the vnet_hdr fields between validation
and use, bypassing all safety checks.

The non-TPACKET path (packet_snd()) already correctly copies vnet_hdr
to a stack-local variable. All other vnet_hdr consumers in the kernel
(tun.c, tap.c, virtio_net.c) also use stack copies. The TPACKET TX
path is the only caller of virtio_net_hdr_to_skb() that reads directly
from user-controlled shared memory.

Fix this by copying vnet_hdr from the mmap'd ring buffer to a
stack-local variable before validation and use, consistent with the
approach used in packet_snd() and all other callers.

Fixes: 1d036d25e560 ("packet: tpacket_snd gso and checksum offload")
Signed-off-by: Zero Mark <patzilla007@gmail.com>
---
 net/packet/af_packet.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4b043241fd56..8e6f3a734ba0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2718,7 +2718,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 {
 	struct sk_buff *skb = NULL;
 	struct net_device *dev;
-	struct virtio_net_hdr *vnet_hdr = NULL;
+	struct virtio_net_hdr vnet_hdr;
+	bool has_vnet_hdr = false;
 	struct sockcm_cookie sockc;
 	__be16 proto;
 	int err, reserve = 0;
@@ -2819,16 +2820,20 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		hlen = LL_RESERVED_SPACE(dev);
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
-			vnet_hdr = data;
 			data += vnet_hdr_sz;
 			tp_len -= vnet_hdr_sz;
-			if (tp_len < 0 ||
-			    __packet_snd_vnet_parse(vnet_hdr, tp_len)) {
+			if (tp_len < 0) {
+				tp_len = -EINVAL;
+				goto tpacket_error;
+			}
+			memcpy(&vnet_hdr, data - vnet_hdr_sz, sizeof(vnet_hdr));
+			if (__packet_snd_vnet_parse(&vnet_hdr, tp_len)) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
 			copylen = __virtio16_to_cpu(vio_le(),
-						    vnet_hdr->hdr_len);
+						    vnet_hdr.hdr_len);
+			has_vnet_hdr = true;
 		}
 		copylen = max_t(int, copylen, dev->hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
@@ -2865,12 +2870,12 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			}
 		}
 
-		if (vnet_hdr_sz) {
-			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
+		if (has_vnet_hdr) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
-			virtio_net_hdr_set_proto(skb, vnet_hdr);
+			virtio_net_hdr_set_proto(skb, &vnet_hdr);
 		}
 
 		skb->destructor = tpacket_destruct_skb;
-- 
2.53.0


