Return-Path: <netdev+bounces-279488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIJqFipp42kIGgEAu9opvQ
	(envelope-from <netdev+bounces-279488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:21:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C030420F3E
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFFB130305EE
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F15C359A8C;
	Sat, 18 Apr 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAUjA1ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25D272E56
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776511252; cv=none; b=VmTIAKdvq0xECKmndfOcKc11qrLo9zcRLaI9yMixrRfn4JIpmYlmz6AOjimcHRSzgzL0sYkIf5xeLRukIiCp49MsjEihEicgSA+CQwo2AVYMhMEkCDW/cSXOVc6xamW5ESjjqPmLylzjEfIbycn9HFmtwHGrXbaYGvQ6jWzqdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776511252; c=relaxed/simple;
	bh=QZ+otmHQ51wHBNCYbGrumDSqewwVLcZVyf3pAK7qR/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTGtUBss3fyeKKz0HDU+aZMh0xhlDfaxtpz7zxUxNh5Ekwj63RtC4p47WN2afp5EX+mm/JIpS8wB7kXyVks4piXNQc8XAOg6FQgxSoseaEareXMKAe2xcMQNFzY7UkfD1Jhhe0xLpq38udzzvprd0uM37gHJ1qEhzsry9L+434I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAUjA1ci; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab39b111b9so6527215ad.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776511250; x=1777116050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/psW2MVGN0ZlOlI1ukn6qG5CJJnIPg4S5/cUT2aBQ0=;
        b=dAUjA1ciR+9Eg4xbWL+R3uV2heRNkB2OZbLN/ecQa29LCnoai/Cy2hCcQI5kY6zOWG
         Q12apyLHv+TixJTLg5sPL2TK3KKpKCmF8To49y2Vy9CHIrTeVSAUyjFtDWfzg8wIrq3b
         J67ZRkWOjvvxnXP5Jy+YvCap442S2fh4ZSwMvJZw8C+4tTJCEF/XXw7trRjgfdg4+h3k
         EMv5zima+jK4isNUTcFQmtwefOEj4r2jKt/kU3PzrMG+AZUqmc/CfiB/bizgTcan2bI0
         0Z6idB7BR454tgGeN8XZzbjufbSY+fEM4qnfG5yg4MtfqwIJRvOdhYOvGI4eX3kAudue
         Rd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776511250; x=1777116050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/psW2MVGN0ZlOlI1ukn6qG5CJJnIPg4S5/cUT2aBQ0=;
        b=TrnhjVKmOD3H4JSmOpq9wgLRD1qVN1Hcu6y7df/h5eHDdoi4GspQYX+ZvII1eQKIAO
         Z3Ot4qI5b61pZklnXORhFjEc/ltW427DZeW61GsNwpKTSLwFskDTEsJi+lwcHbvvayIt
         4XBpXIAUwDOAF9vPbLBB27BHiqoTV7RZitF19HygYwciQYf8ARSrDxFA2IhhHr6xo9I/
         eT/gLlMpXX+tcp+dooGw3Kl1PtRauGTmydI4ZG0fbC12FWwy/tJ+RpweE4N5acw8Uwez
         NOvXzGsHXwenih4KE4+yfMBe5E9jpgEGPfp692oWX6y0iMPP2YszIMINonrFDmOExJ54
         8HQg==
X-Forwarded-Encrypted: i=1; AFNElJ/WEOBU7ugrKIB5zygEWi6uCNYEoKiMMZT/heX8NWDAASbUC0gEc2iFiCX+Kio1t63m7HKoakw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SNDo/CX6+JM29jS6iUqbaEWQpu/eaYJNiEnnM18fyO5QhQ/Z
	8o0FQEhpYW1Sb9laBB05RG6lhu3yNCJrCOSe4cb58+ervzJnc3ZfRH6RDEQ/38R4
X-Gm-Gg: AeBDiesqfeU4beuocml+R+SaSq5X3X4hhxL5Kni3oGF3tpcJ5uoCwxQBkUV3uTLDGZs
	qSO1Cy8GEpkImdi+kWxQRgi4XZU91FODpRHgBQKhoUcSyzQlS+KFZW4AT2zY4rnyPkbJ5+3xh5J
	h356HWdyUf/MoYNy5d52qSRMaSvQDdnKeOJfu+6BLRBgwh+ijU7KuRxL7eJD9gJBxlbQqAmCjuv
	Ox5Iutg8+JRsaM1Gc3b58Jc6tE3PxqBVHZYN379ctsaSdQjm6gwrmmAkHaLJCBUUIP3pq5D94e7
	zaDQMuwvyGtTAH/icDc/Jv3oiyx9CB6BZeC55UiQSp/HjoYWySPxHWtVdTROk9Nz/dmIOwE5BKm
	k3PD6QUwIQ1WF0Q02VNRWqbnRRezP7vvUoNqzHsGn2jU+tY/NCQ8xtkcw4EP4YpQRRy3+s842d6
	k+dXj8eJcRB2I6MHX/ynRAg8+txo1s4iV3CrNslAx2OW+8VePvBsSEyyf3OReeANtk2agkBhz1c
	yike26bfxgweUHB
X-Received: by 2002:a17:902:c9c4:b0:2b2:712c:61be with SMTP id d9443c01a7336-2b5f9ed0b48mr47923305ad.18.1776511250049;
        Sat, 18 Apr 2026 04:20:50 -0700 (PDT)
Received: from 192.168.0.190 ([240e:3bb:ac4:ecd1:b506:aec7:52a2:94f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1739fsm48931965ad.22.2026.04.18.04.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 04:20:49 -0700 (PDT)
From: Bingquan Chen <patzilla007@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	security@kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Bingquan Chen <patzilla007@gmail.com>
Subject: [PATCH net] net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
Date: Sat, 18 Apr 2026 19:20:06 +0800
Message-ID: <20260418112006.78823-1-patzilla007@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041858-estimator-shower-0f16@gregkh>
References: <2026041858-estimator-shower-0f16@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	FREEMAIL_CC(0.00)[networkplumber.org,kernel.org,davemloft.net,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279488-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[patzilla007@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C030420F3E
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
Signed-off-by: Bingquan Chen <patzilla007@gmail.com>
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


