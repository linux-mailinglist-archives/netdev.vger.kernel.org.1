Return-Path: <netdev+bounces-275670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JzJOPjt02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:31:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0DB3A5B66
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABDFA302F3A7
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E9338F933;
	Mon,  6 Apr 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="iX7JgO5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9338F22D
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496445; cv=none; b=drC3kun01CuM5rEQn27LIhl/e/cQuSnSWMYn6i27qT0DZQgmljOyFtfye/W72YgeRhlVwqvx50sFvdoWVFnLacbtQNwmAYoNkUrDn52Dd8pYoATKCsMNeMJxPSS3QGfMpeDZ2Is6GeZwHPxFYzrfzUrsP2Ht/wuJ6JM81MCjFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496445; c=relaxed/simple;
	bh=TdSbYldN8BgHeccaQnv5dUiqChuSPpB3xVgb7tE+F8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSkrOwDk+HQQJy02V/zqvJT7nUzxyqm8O/f0eoDJDgGO/fbJWBzc5K7qM+t8LSS3J0MEeaSSrkbMJniCCIJEPLClIQ0rfoMBb6f1XIzQXwR0LYUfed79xezuTGbK/KgOuB4yXlzOuZvUK19bMesPT3UGkeIVul5CO0KTzXWimyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=iX7JgO5s; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c76af79f029so1635455a12.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496444; x=1776101244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WtkE8OyzNx92SNs8SVA1PmzsnKoNFoQZNHcbvKbHJU=;
        b=iX7JgO5s+SNNkOUPjazigN2V+4wq6xMA1ei4CFWHaFkcIfHnUllIep9DcHZ0NIkh90
         C4FTwOiYqgWsvgF7vU3XCNUk9be6ju/8AuoZIbo/ElrIDS0+fFbfBHx0y86aVEKFAL5S
         2Ox0NKdK45ugKagig7BAOqV5zc7fEUEIFPdIvStEYXid76vtVrGGO3lsBZcAdoL8NXFe
         CnL9siU855O8fDXfaQ8TRfk4yAxCBQfVaAVXqaYyceJDp00Ti1VZjf0gzah5/CMbjgAd
         EfEBuffOXRLY4i7DD3mADPcH2+zt/8dzDbw4EDpSsacfKz40qVUuu+nA4QB2t3wLJ2J4
         Aqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496444; x=1776101244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2WtkE8OyzNx92SNs8SVA1PmzsnKoNFoQZNHcbvKbHJU=;
        b=E142QyBkNoj0E3om4CB2y6i5cFkcGzrSf9UiDaQX0B7JexgSy+ufpIFfE8m6SP4InY
         ReXdoszpQMyavKShw+dwfVzhejEZhC8ODFJTnbzjB/LBWDXfcLAwNXLcIYKevZ4hN8w/
         jn0R0rsmeYCD9dIo8k3nIZLqk8q6BT2lTLND5/EtBI1XInxRF2ELmVfwxHqcRLPd2rrZ
         PQUNA3Lu9hOT5wDOL89SkTNsfxnNVMotqzvu40xdJi+8gUD2Lu6hXtwTibwvSti38d0t
         ghNF4gpLWn2LVk3H6jLNTep0CNZ+oqDKnXOIwh1bflx6n2OpQ8KgyEK95mja7EtWQI2I
         UIFg==
X-Gm-Message-State: AOJu0YxGelLAL2+UlUQjPBGusD2lQRqRQaJQXF2LgXJY2RYCr5MWdBHj
	I6/UISgMB49OkYy4Mroe54za/+P9DxJYGQteG1cIXfpQf0t5o1Yv5CMYrzV9tn0J8wAqu4Ulgqr
	otKLt
X-Gm-Gg: AeBDieu9eov9OBVAA3gyGRPQgzHciMfBRSRxJIWbO8eZ6C650A4cggwnF+BOSA6rxE4
	537R1rA1tTmt07xoaIWRpIS1t8BHReNWWeTE1IFlN7NWXcX4Cjbq5qERexMdYLVDi3ZZc8kNfpD
	UZzW/555WDiqI2vpxyHv69MmpOJ8MV2xQZMaE+BEFS9gukdVYD6zwg2vfAizBoVYw1HwLvf49Kn
	ROlnaBjL+zvs6iyvC5QdSka1p0hRjt8QXnnova+EUF4AP4vGaS8lWIBHGaYGlB0UIuIAGOMDAGX
	PHP3/ix2SEpx3VW/WOzQRQ0085plAc4g1RZmtvv0Jh27SkE9BLtPjRCGqEOR283UtldGMLX5Egd
	KKMrJyNbkibSHDxviePrqhTurtjc8h37B/3iyBhaaOVuIz/JkYS8xLOGsrLPQoqah6fJxvgN40I
	4iMPjyVrZsK2XbgsIHzBLI6sc1TF//oMsL
X-Received: by 2002:a17:903:22d1:b0:2ae:a45b:42f7 with SMTP id d9443c01a7336-2b2817b3e21mr140053395ad.36.1775496443798;
        Mon, 06 Apr 2026 10:27:23 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:27:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yousuk Seung <ysseung@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 8/8] net/sched: netem: fix slot delay calculation overflow
Date: Mon,  6 Apr 2026 10:25:16 -0700
Message-ID: <20260406172627.210894-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-1-stephen@networkplumber.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-275670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4A0DB3A5B66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_slot_next() computes a random delay between min_delay and
max_delay using:

  get_random_u32() * (max_delay - min_delay) >> 32

This overflows signed 64-bit arithmetic when the delay range exceeds
approximately 2.1 seconds (2^31 nanoseconds), producing a negative
result that effectively disables slot-based pacing. This is a
realistic configuration for WAN emulation (e.g., slot 1s 5s).

Use mul_u64_u32_shr() which handles the widening multiply without
overflow.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index c82f76af41aa..d47e1b0d7942 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -660,9 +660,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
 	if (!q->slot_dist)
 		next_delay = q->slot_config.min_delay +
-				(get_random_u32() *
-				 (q->slot_config.max_delay -
-				  q->slot_config.min_delay) >> 32);
+			mul_u64_u32_shr(q->slot_config.max_delay - q->slot_config.min_delay,
+					get_random_u32(), 32);
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
-- 
2.53.0


