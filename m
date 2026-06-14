Return-Path: <netdev+bounces-299129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TET3C8gkLmpqqAQAu9opvQ
	(envelope-from <netdev+bounces-299129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:49:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AC6804CB
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:49:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=Wa0AMHF9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299129-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299129-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2631430209D0
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410226158B;
	Sun, 14 Jun 2026 03:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08F2B9A4
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 03:49:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781408965; cv=none; b=Xe5lLhHIHm39uePnNklhaEB7KaBYQjnxcHtOL8x6R7yuwHVtZmv/WUfPReFV2IhC8oUOQOUa4GsqYL8ICzM0tnO3NihGsiz5Ktch/7JD/zYEEcmVr067geFJpDLB+ATKiRI8JhNpLZsXrjXgH4sEx+gYyxjWCa8eMgRYzG7K83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781408965; c=relaxed/simple;
	bh=y8tGezi7s2JitSMFlWyVrDKw4DZahftkEjrAZTWurPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUy0f02qb56KLMpeSnZH18WY8pZFXasiW75l871S9n5DQ3T2I6LnMljOp2EZU0CA2GLYK1pEs7GdgYbg2LtQ93zNUKmvYtc/lRYjm6BCqvk9iTx/YH5hGT5JLmS2dCTI/Uk9XR3aDz9bJd1aLqtbmO0lYBJn4LQMWtHmC7u9Zk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Wa0AMHF9; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c3543590so15218725ad.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781408963; x=1782013763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnxbwPMepZpTeOQprxsLUR7JW3lAA0bleF3iZYdOJ2E=;
        b=Wa0AMHF9FuOLmv69oCJMyEhHkV4+uZBXbUhdyzmc2/GhwiagYlnp8Oxf5uqyBydrA1
         bFhrxY2hwnHdlNXJ9IWEG9DDdlpEEnAFOyL+HH6rrIe5Mgr74oT0LvKAK3Mh4rZ2+xLy
         2rKryefXxPkAuD2GT5E8f8P46oT/Qx+8hlhLiEfWQdESHFhIzplgUX3hZcxVw2/ntzu4
         DczP4zwK0A6GdWAWQ1DyHKakRFIreZF4hmXr3ip7cP39iJThyO4hpcfmwzOxmBufWR3S
         Jqn2YO2MbfQ7j+NGnceXF3C0ARjJxpHbdLRJ3QHfoOMhPjP3R7VYou/gGuRqIdwYJ2vE
         rEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781408963; x=1782013763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnxbwPMepZpTeOQprxsLUR7JW3lAA0bleF3iZYdOJ2E=;
        b=OOblKik0kAxqtFIHp5ygidiXfV2m5cja/cXlVpsAZjMysjNrZItK04qxlCk5K7GOOC
         kgQY8hcq4alzn2aRUorAYuRYSHsHSW54AaDOzDGHmk98ccr4JNR1EOW1b+DVI9O+foje
         FUkpZyhHraD1KeoZ9jriyJJILTkirkH1Jwj7fdDI2igcyKyKM/zZvLyTNoLcW0yveFz9
         valr8PHO0k9MsWRb2250h296FWYbkrX6CX8y+MjMih6xFwBFQpLs8CrStWfNcGk9v/AH
         YX+YnO2MMgY1NyrRq1PLaEfQIQ32zorDyQdcGfe9zKmaTr3+w1dNmk85v7ejjgI9BC0f
         G16A==
X-Forwarded-Encrypted: i=1; AFNElJ9mlvk1Q6PZhQsLFDtzfE3C6HMM5SP0Vnq1Z+gymWW6w21YWe+oOHGeLYnPC3cdwRxzn0/GyJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKkMzl8JyK95YSZ4B2KrTYbi6tn+BwdXJ+6vS5Z8BI7GdRccj
	tZsge+0tgmu3yf4RUwJk8l143pPLV70Pi04xgmDgFE5JIF1s5vaaKUkvD7Bjm5Rs3g==
X-Gm-Gg: Acq92OG0bhTpqi/Yg0vIy2R6rYbpGBJc/inVafQ9pmNdwtPkvgHFNj09H+5j/Qd1Noo
	Gu8bS1WzVKgfw52qHnbxb0DaWrZJk4l5Rv+U8lvqQJd3eurmqyJun2TI/nVl1zNQydeedM7519a
	nbd5/QP5VjoMeXR/rffPlOJ0Q5y/8QsMhk7eYuymQLYt7Jo2cNR7AyG7fuOSi4QedYEc3m544/T
	8ItA2eyGUezTXHwQMA7Hnfj2Xefs67q3oo8PQKPf07mWOZxsLRgpKSO/PUsgEaNw7nKYxIlem9U
	rdtq7SQ3mM8PrMFoyYd334UcnTkfVhpUC/fRQZMZVVLi9txlIVNdIOEi4s754ZPByhq3JCeksxR
	J1cZkrhg6QTFxMzK83NzJz5t32yCR8n8lQpqzkPDKXlpt2mLwL0JbqY2amc3JT1Zzodnri0CdJI
	rdAo1Uf+PTGMgbaA4=
X-Received: by 2002:a17:903:11cd:b0:2c0:d2a1:70b9 with SMTP id d9443c01a7336-2c40da4c303mr101491505ad.0.1781408962939;
        Sat, 13 Jun 2026 20:49:22 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432e81a05sm61518595ad.64.2026.06.13.20.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 20:49:22 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: kuba@kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	yotam.gi@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] psample: use nla_reserve() for PSAMPLE_ATTR_DATA
Date: Sat, 13 Jun 2026 20:49:19 -0700
Message-ID: <20260614034919.918494-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,google.com,redhat.com,kernel.org,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299129-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:yotamgi@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E9AC6804CB

psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute and
reserves nla_total_size(data_len) bytes but only writes NLA_HDRLEN +
data_len of them.  When data_len is not a multiple of 4 the trailing
alignment padding is left uninitialised, leaking stale slab memory to
every listener on the PSAMPLE_NL_MCGRP_SAMPLE multicast group.

Use nla_reserve(), which lays out the header and zeroes the padding, and
copy the payload into the reserved area with skb_copy_bits().

Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: use nla_reserve to ensure no info leak

 net/psample/psample.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index 7763662036fb..6a714a4b4992 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -476,12 +476,11 @@ void psample_sample_packet(struct psample_group *group,
 		goto error;
 
 	if (data_len) {
-		int nla_len = nla_total_size(data_len);
 		struct nlattr *nla;
 
-		nla = skb_put(nl_skb, nla_len);
-		nla->nla_type = PSAMPLE_ATTR_DATA;
-		nla->nla_len = nla_attr_size(data_len);
+		nla = nla_reserve(nl_skb, PSAMPLE_ATTR_DATA, data_len);
+		if (!nla)
+			goto error;
 
 		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
 			goto error;
-- 
2.43.0


