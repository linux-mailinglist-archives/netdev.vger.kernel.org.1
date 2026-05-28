Return-Path: <netdev+bounces-292868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7q4ZHVDEGGoWnQgAu9opvQ
	(envelope-from <netdev+bounces-292868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:40:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C35FB0FE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC03C3017270
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA4369D44;
	Thu, 28 May 2026 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0nCwRC4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF433546C4
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007660; cv=none; b=JgqksNgFkjJ3KlTF+WODbg/oIXXHsoBlekN3j1F5nAaZk5mUxzu8pXL7DBN5J/0xnz/6rLYIHhMdqVJ+xBYVCS0r6mTlt9K1fxHbyCqJTLYJY2/cCrRky39zsT81qxoUa4rlAnVeVLpdUdTUtW9z2UZHRD4q8rbSjas4falBXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007660; c=relaxed/simple;
	bh=xjHdc+vc12MKCZBHKVjl8PEg9uX/avR1IAYxPXPh5jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihgiOoQuPKwiE1WHDbd4jZhlRp66Tm3NzUHVy5laRwZRYFiRsjmHXyXF2TVWckdfy5CvqDqVdrGT/SXE6W2l4cR/yoUnq2rDctBN/Dmw1L0SyuPBSOP3liJY1ifKUvR8aSRZl37+tlcqD+wO2xVsxwTrdGYniYQg1160zSZiNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0nCwRC4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso58160175e9.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780007657; x=1780612457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFy+qmKG40w4ZnEG39ULoB2AQiEuE/T4yBXKnfStJQU=;
        b=e0nCwRC4MYMX0NUvqz1odXpI04NBxW5keCFo5cwlmQnGVFWktenlyOhOnQ2otR0jfS
         r7ToCROIfMOTKaX7WtJho+FozZ3UwUyqgBaXEt7QZqJ3pTuMyYKU4Ns9wOdnBfsZBV9V
         LGq+Gq5HU+QgVUeurKVze5+SRnxAvSwEnvFGRbV4VYT12k0K3gmX/cuuc2pFFPN2G+w5
         E8nCdTYaiPoMJTOGJvuKLfxcjlqze28mKMhSqfAMxBIuozRfYFD4nO3RjwwAh9I0c+UL
         wJRaasuqe/d/riPUvqqjXTBonS+kLudh6eXor/fl5LufUDpbBXuzC9/8WYCKZlX5yMC2
         UG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007657; x=1780612457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFy+qmKG40w4ZnEG39ULoB2AQiEuE/T4yBXKnfStJQU=;
        b=FXtCL8fUe2fV1TpyPlrkZdPjZArgdYRWJH6lvMVjwSjwEu3zxf2T0spg2tTFKu+DyC
         lzTzLcty05rcKI2AXbLL4v+oz5tM20eGsgnsAyaI+iB5Hd4FNHOS8rMuRI1rTfbEFJ0j
         EOrhs0499ji+SXjxb6hixaKIpAJ90LUGHQV1wjpZXC+iNiqxZ3ryPwU+hPoPOa50/UTv
         gOWkqLMvwAWwQxSZ+qPe9FGBFgH2/hSdq2agOmL130xLLODee7l8bSspm2gC7ea7BVNd
         XWXHfca+GFATMmBOS4/XNEVc82su/Ey2JpO1brpEetjnngC2ofnBK8nDa2R4QvGZ5nVy
         oSBA==
X-Forwarded-Encrypted: i=1; AFNElJ9+k1Ybqiyf4OgiYSbamx0c2ebrjQDPQda5RLWI6j3CZ/KsQxSxaATdJLXwXpvl4Bt9e+IWvn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ROYKhJIKv13dDYrjPKQ6JPYp23PwVlSxOtDVjxciOjM95neM
	Zu1kF4MexP0US06NChyRWSGfVQabX+nFpsTL3nJzlgfVUIPfJLYMwR93
X-Gm-Gg: Acq92OEsIgWD954Kurjc/KNo2ALm6DGbeAXCoW2RfDqGd+NW3XyKXeRI2yXKWxiZJad
	y2vxGa+xLVY+xQOW6UEo21HE14W8iZpXZc5ZB7VK5pQOyK/Bhd/n68tWY5IFQ/LqaqgbIiIn1Bl
	vxn6I9SuHHlsdUUHye83q1H9Hx/SOtK7j7SsEe58Q1NHHaw3dA3XBUa8cYzND5JNaH5hfHdwdjT
	nTbeZiEOomMiUALnZMXyYZm9RSoXhZ2DDqTat4l5jEdWtXxNZxoBaQczucabs1Ks42SLN9XLdy1
	ka+ePKmvVPiQETszjOClKgDkwxkbzdCBUowMu8RVUKMmtCGpZwo2+0bx7KASQeMlfIwNnIm80tS
	URwqfihl7oPh9AZx+l1FjMWyMcrKdoH2RpxVnnQdMJ5zA4QE8AROj3u9ec/g93426tBMiq4WQmB
	4ex4YY/UNzxmTk8l7JAvgrp7SeUv+CBKKfrwTC8ETTOMFveoHu2OEkCyfJBoUmnbCNZ/KKHy+wW
	fg0IqX4FvLApchszuk/cwlerzdAhBjeIZNe2mDUTVx+BTx0
X-Received: by 2002:a05:600c:c047:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-4909c07faa8mr4076425e9.8.1780007656895;
        Thu, 28 May 2026 15:34:16 -0700 (PDT)
Received: from britney-pc.tail2180da.ts.net (host81-152-149-195.range81-152.btcentralplus.com. [81.152.149.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7e17sm2611475e9.9.2026.05.28.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:34:16 -0700 (PDT)
From: Kacper Kokot <kacper.kokot.44@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fmancera@suse.de,
	fw@strlen.de,
	david.laight.linux@gmail.com,
	Kacper Kokot <kacper.kokot.44@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] netfilter: TCPMSS: fix dropped packets when MSS option is unaligned
Date: Thu, 28 May 2026 23:34:11 +0100
Message-ID: <20260528223412.27311-1-kacper.kokot.44@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528204020.7ae744ab@pumpkin>
References: <20260528204020.7ae744ab@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[netfilter.org,suse.de,strlen.de,gmail.com,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292868-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kacperkokot44@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C17C35FB0FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Padding TCP options with NOPs is optional, so it is legal to send an
MSS option that is not aligned to a word boundary and therefore not
aligned for checksum calculation. The current TCPMSS target is not
robust to this: when the MSS option is unaligned it produces an
invalid checksum, and the packet is dropped.

This has not been observed in any real environment. Senders place the
MSS at the beginning of the options block, where it is naturally
aligned, but the spec allows unaligned options and the kernel shouldn't
silently drop legal packets.

When the changed word is not aligned, the modified bytes straddle two
checksum words, and using the standard incremental update helper
(which assumes alignment) produces an invalid checksum:

    | w1     | w2     |
OLD |  a  b  |  c  d  |
NEW |  a  b' |  c' d  |

Since b' and c' sit across w1 and w2, we could compute the incremental
checksum in two operations by recalculating w1 and then w2:

    C' = C - w1 + w1' - w2 + w2'

But working it out:

    C' = C - w1 - w2 + w1' + w2'
       = C - (a * 2^8 + b)  - (c * 2^8 + d)
           + (a * 2^8 + b') + (c' * 2^8 + d)
       = C + 2^8 * (a - a + c' - c) + (b' - b + d - d)
       = C + 2^8 * (c' - c) + (b' - b)
       = C - (2^8 * c + b) + (2^8 * c' + b')

So an unaligned incremental checksum can be done in a single operation
by byteswapping the changed bytes before passing them to the helper.
This patch implements that trick for unaligned MSS option updates.

Signed-off-by: Kacper Kokot <kacper.kokot.44@gmail.com>
---
I decided to go with the get_unaligned_be16 suggestion because
it's idiomatic and it produces shorter assembly on x86-64
(6 instructions vs 9). SYN processing is a cold path so
I didn't look into it further.

v2:
 - Use get_unaligned_be16 (Fernando's suggestion)
 - Fix alignment check expression (David)
 - Mention it's a theoretical bug in the commit message
 - Drop cc stable, the bug is only theoretical

 net/netfilter/xt_TCPMSS.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
index 80e1634bc51f..32c87a520361 100644
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@ -117,8 +117,9 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen(opt, i)) {
 		if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
 			u_int16_t oldmss;
+			u16 csum_oldmss, csum_newmss;
 
-			oldmss = (opt[i+2] << 8) | opt[i+3];
+			oldmss = get_unaligned_be16(&opt[i+2]);
 
 			/* Never increase MSS, even when setting it, as
 			 * doing so results in problems for hosts that rely
@@ -130,8 +131,19 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 			opt[i+2] = (newmss & 0xff00) >> 8;
 			opt[i+3] = newmss & 0x00ff;
 
+			csum_oldmss = htons(oldmss);
+			csum_newmss = htons(newmss);
+
+			/* MSS may be unaligned; fix up the incremental checksum
+			 * to avoid an invalid checksum and a dropped packet.
+			 */
+			if (((char *)&opt[i + 2] - (char *)tcph) & 0x1) {
+				csum_oldmss = swab16(csum_oldmss);
+				csum_newmss = swab16(csum_newmss);
+			}
+
 			inet_proto_csum_replace2(&tcph->check, skb,
-						 htons(oldmss), htons(newmss),
+						 csum_oldmss, csum_newmss,
 						 false);
 			return 0;
 		}
-- 
2.43.0


