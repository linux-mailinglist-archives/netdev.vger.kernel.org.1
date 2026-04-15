Return-Path: <netdev+bounces-278874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCSMDKYF4Gn4bgAAu9opvQ
	(envelope-from <netdev+bounces-278874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 23:39:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB36408389
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 23:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE116300A624
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C6B386442;
	Wed, 15 Apr 2026 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm1+aucS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4230FC33
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289160; cv=none; b=rU2pvFEEm2q12V3tjs3NZb17VeeaE0zA1fpKn/UzO0XnwwAOoN+1+0+aV9ph+pue5R8/Q9q1LwtcZBxM2o+3tehldoeEKysykL7vixiavdEC0OY8LPgsrqt5+3C3Fy5nKajwMufgyyhJBdmFGzVX7sfaWH/RS/ae6NAeJTFhqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289160; c=relaxed/simple;
	bh=T6VfWYRzjMus6wtGqwopl/YhElpFY9ecUva5JvwlRIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5VMptzAEbbZINqNhljtZSQUJf1j74wzM0st0Wr/L05G/4qsPrrn5vRKBs9Wi7khn5bRyWJvjf8mufYNgIXBWwRRCdX7VcnO6SU9yIAhwvqsgqIhRyMa8/0UdU9bLgh+8tL9jUgjepkiNXUBCb9dQVHm/+2fAiDscnYFz5PCYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm1+aucS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9f316d68so32712305ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776289158; x=1776893958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LVzYR08Auc9YT3EOIIo8wII44N4QIbDSpbdB5JC+60=;
        b=Pm1+aucSy86PVQ4EEoEstWgINowXWquYmVBekF2LFRfqJP/a9MFe6crbGp7OGEJgHS
         6d+TFwqav4+LDFHw1vHf3YOv2d5jXdvy+mkWmgM/gze+a5uZVq//VO/J6Q2vVQccCLJB
         E5TUuzsOP+hXIiVkOYVtIoILPB0oezmwFm9XYpNF9aZ0CwNd5qHxRvSDxFZM1Cyaf+01
         BpbQX2N6kflEUxCglwyZP2z7SpAZ0yi6osg2b8W8ExPOsFFUqNhnmpxhfADfDk3TD038
         dJ0WUoQGCh+BeiQ4VyTlG6oRk78VlcHdkj+8HVAoCZydtNKxQwKbx0SxtHgHqC32POjX
         3y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776289158; x=1776893958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LVzYR08Auc9YT3EOIIo8wII44N4QIbDSpbdB5JC+60=;
        b=ZLc2uY3D4GATw5JKWpWbdz23ycddoNq4/TiQHMYJxbG4LYG/d3BJp0R4YNsYkOaMj1
         buKRNweR0ONRs6Znavf2CqbUO/z5BSfuH9YKj74cxbTqV3e2gmnK8jhgboZFOEc/ZM7U
         8w7pMnpA+Xmb6yPxrP5FwptohEXng93ChRQQ/va0i1ovfBskai2QijVe/F0EXa9CmmX0
         mr8fkz3n4Vaaj8RMN8KRflktOgLfAffFafEx2dn3yCh20aLN6EeGTj8ahuZGtJPowkWY
         FJ7/kSY6MzH+1yeVhrhFnUPxRRJ3R/9zy69TCKZlA9eJ0X+cVW46BAEUII7fzS/5bzSN
         XtYA==
X-Forwarded-Encrypted: i=1; AFNElJ8bhtbQtTLxngN81oBvusotewU6RHGXLbrx+RDvy6/f+GWTtCdMqHbX3pHOX0gLMPxTFw6IQ4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTWtFEoBbcrbiqjK3P/05z4Nc9i7rYraGwWpRHa2KAhDfW9v5N
	vvEHuu2JNvoT6+nSuaWw1xQ6AH7ZTGIcOv05HtjvCyh7OkwGtsWpXpPt
X-Gm-Gg: AeBDievXgJh2IqiU+R4Kr88bfowkp2ctNVOpOmYx2kw/SMx7eWQTkNlRhphxhKgnkAx
	RgvPEgWZ8Kov1bYyngPGCxg3m2GexnFX7cv6VYPfBpMZ1WhuPWKqcYl0Kxmdu/94FVTX2RYvPXn
	WtXE8/ayJrVFDQchHqkWFDLVYiz2k8Ie3iTFD1oH3JtqB3j0r1YH64b9FfSLocG8MiTs9PpKKmS
	JByFRzcNh5xvvTviLdvIUNFAtIrjlwBb017qKvU8uERfiLCjPAUId2OsORzYOv/xB7NHaSUlgdX
	ZkkTklIH+Il7id7CpZSnrGkSsHPs5LsVxOtziKGZlEfVWHrF079RANVvyhEOpDc2q2JCpNRW1ac
	jD2AX7DO23av3hb4NiYeWKRFmaGSLDW+JNy6FvtZcD6fa1LvqLC48Ml+i9PtsoMuTCcBuvw3SGa
	2opjzdsKE4FJpI3ZfE7Ofe/mcnQI62cA0X0MZEUY37QwWWUzW6ZsH19r1O5odqjq5X9ZF9TY3h4
	MQnL6yYa2Xoezlevs6EEvI=
X-Received: by 2002:a17:903:b0b:b0:2b0:6d56:8d29 with SMTP id d9443c01a7336-2b2d5a40027mr242842105ad.32.1776289158176;
        Wed, 15 Apr 2026 14:39:18 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47810aea1sm31342765ad.22.2026.04.15.14.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:39:17 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ian Rogers <irogers@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Alan Cox <alan@linux.intel.com>,
	netdev@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] slip: fix slab-out-of-bounds write in slhc_uncompress()
Date: Thu, 16 Apr 2026 05:34:00 +0800
Message-ID: <20260415213359.335657-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,amd.com,google.com,huawei.com,linux.intel.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-278874-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AAB36408389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sl_bump() reserves only 80 bytes of expansion headroom before calling
slhc_uncompress(), but the reconstructed IP + TCP header is up to
ip->ihl*4 + thp->doff*4 bytes. IHL and TCP doff are 4-bit fields and
both can legitimately reach 15, so the header can grow to 2*15*4 =
120 bytes. A VJ-uncompressed primer with ihl=15, doff=15 followed by
a compressed frame of size buffsize - 80 therefore writes up to
33 bytes past the kmalloc(buffsize + 4) rbuff allocation, with
attacker-controlled content:

 BUG: KASAN: slab-out-of-bounds in slhc_uncompress
 Write of size 1069 at addr ffff88800ba93078 by task kworker/u8:1/32
 Workqueue: events_unbound flush_to_ldisc
 Call Trace:
  __asan_memmove+0x3f/0x70
  slhc_uncompress (drivers/net/slip/slhc.c:614)
  slip_receive_buf (drivers/net/slip/slip.c:342)
  tty_ldisc_receive_buf
  flush_to_ldisc

Raise the reservation to match the real worst case. The ppp_generic
receive path already enforces skb_tailroom >= 124 and is unaffected.

Fixes: b5451d783ade ("slip: Move the SLIP drivers")
Reported-by: Simon Horman <horms@kernel.org>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/slip/slip.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 820e1a8fc9560..37af7cbe7f81d 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -333,9 +333,13 @@ static void sl_bump(struct slip *sl)
 				printk(KERN_WARNING "%s: compressed packet ignored\n", dev->name);
 				return;
 			}
-			/* make sure we've reserved enough space for uncompress
-			   to use */
-			if (count + 80 > sl->buffsize) {
+			/* slhc_uncompress() prepends up to
+			 * ip->ihl * 4 + thp->doff * 4 bytes of reconstructed
+			 * IPv4 + TCP header. IHL and doff are 4-bit fields
+			 * (max 15) counting 4-byte units, so the header is
+			 * at most 2 * 15 * 4 = 120 bytes.
+			 */
+			if (count + 2 * 15 * 4 > sl->buffsize) {
 				dev->stats.rx_over_errors++;
 				return;
 			}
-- 
2.43.0


