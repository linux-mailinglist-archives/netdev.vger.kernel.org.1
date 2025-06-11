Return-Path: <netdev+bounces-196452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03865AD4E84
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2041BC00EA
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6D323C8A4;
	Wed, 11 Jun 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUV4CA7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A72367C0
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630906; cv=none; b=n1rqO5g3grLmXoJn+PGWPPD7bADeKd0KJBvhzahR09X4rUZ3iAt9ZEejiN5j9w/0i524GByMMGmQ2mJSx6Vih2U5CkhoKnRcEoqHQzqgsdL5WDIHr8/aNTsFirJW/DSymfmcvnzI1DJvMjuCbC8ySnTYQiPLDKh2lRz9inQlf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630906; c=relaxed/simple;
	bh=sh28WoI07kRUIOUIAPoZClX6B7O6vXzsXebAB+1KS2g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gvheTCQ/Hvjs+yye82L7iSOcib/l7jj9cfON5GAsvGTwZlBwxyLpFojt3t3QyF1jHck4bnXje8YRkiTPuFvYc/N5rVNA12OPhSoGHhoOjuKFmkujn3id+HzrC9vBGk+kwxQfbt2nwr4nQTKjOBUAIRomexiKWRqN9MLgfyNzVHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUV4CA7G; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6f53913e2b6so93024686d6.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749630904; x=1750235704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IJ/Ii+kzH15uD/kklpl8P0Wjrt+djWjANqmqylLT3w4=;
        b=aUV4CA7G7bpNTtWcY7F0cLIj7pxdvL36l+IDqAjm85d28e3VXW6BjCWIckIglY/nPM
         6B9IQez8dd694RLUGLPo1AabVkudY9KZS8AT8bVeqb/Tl5TpSfUgxnHFL+vInUY6kDsC
         PrfHA3mztoqYO3kOXtQ36jhdWdOv1t40ABi6hm4D0e5Y2KkAnqFSYaGPozOPTCwfatSA
         B4++I6H5YaAoBfRBjdPlImNAgBcRr8W/vsZ0y2KTE0v3mHpGw7231LBtrUDxNqrSQqt3
         0UJmx+4wQSzLLK7mhZ1r8RSfhYIncpCgOeHzrpRCoHBC2aL58eaBaKaZqxzu9gDBhebB
         KpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749630904; x=1750235704;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJ/Ii+kzH15uD/kklpl8P0Wjrt+djWjANqmqylLT3w4=;
        b=jjpoVGRDTf8RUf6Z5nANSHGLsVlwS2AMprT6nrbH3nTmAxfng9ol01qJ6J2t0FRdHL
         LYpKHH5vnYZX5wA1lAR3CXK58nSs2EMyMSkLF4yslIdxj2Isqq8Q3V536J8XpHxwWvVS
         mll4ZNVLM16cZAliXrGq3k9fd9sSw6GNBWjNHbGDjbB+HEultYPx2gX1TAgdEJ0A4kBG
         C+SduWCY3GdccobVb1fPVxSHdqZKG8VpynXU4eate3kw3v/WvOxmHgEBSVWyR77kXSxa
         3mORLF6pQOcUMLdHH6OjS4NSYYaAAENwQJrT1wLvPaqPCRkZAm6Jl7IxF+YgYKbzoz5A
         aj8g==
X-Forwarded-Encrypted: i=1; AJvYcCWAlMy4+xxyd5LL2kZ2MxBCL6eCy6fTwUMzj4SFEJwEMOs9bdJn70owhugKmxcq00VRCw3X3ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoiF166Z1o6/pnSB7gBM0RyjPAH6UjqqsYRNWIR7qT3hBaVzWc
	BmrtY2wHWt0Y6tp+Tw17O09FVLie2mtEl5UrjZs1niF2DLBXIwu3E4o/EtcmmQI70skt397PVvT
	wtuGXoF6EJEqxTg==
X-Google-Smtp-Source: AGHT+IHw9sP/8Wq7IkSrM4UC8Nhhb2G5uH2e5zWZM44KSph1JcvfbhuuK/JHaueoOQppzQT9FDzSJA+zFpr+MA==
X-Received: from qvblx13.prod.google.com ([2002:a05:6214:5f0d:b0:6fb:461:b629])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5dc8:0:b0:6fa:c4cd:cca3 with SMTP id 6a1803df08f44-6fb2c3274edmr41060906d6.14.1749630903742;
 Wed, 11 Jun 2025 01:35:03 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:35:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611083501.1810459-1-edumazet@google.com>
Subject: [PATCH net] net_sched: sch_sfq: reject invalid perturb period
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Gerrard Tai <gerrard.tai@starlabs.sg>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Gerrard Tai reported that SFQ perturb_period has no range check yet,
and this can be used to trigger a race condition fixed in a separate patch.

We want to make sure ctl->perturb_period * HZ will not overflow
and is positive.

Tested:

tc qd add dev lo root sfq perturb -10   # negative value : error
Error: sch_sfq: invalid perturb period.

tc qd add dev lo root sfq perturb 1000000000 # too big : error
Error: sch_sfq: invalid perturb period.

tc qd add dev lo root sfq perturb 2000000 # acceptable value
tc -s -d qd sh dev lo
qdisc sfq 8005: root refcnt 2 limit 127p quantum 64Kb depth 127 flows 128 divisor 1024 perturb 2000000sec
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_sfq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 77fa02f2bfcd56a36815199aa2e7987943ea226f..a8cca549b5a2eb2407949560c2b6b658fb7a581f 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -656,6 +656,14 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
 		return -EINVAL;
 	}
+
+	if (ctl->perturb_period < 0 ||
+	    ctl->perturb_period > INT_MAX / HZ) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+		return -EINVAL;
+	}
+	perturb_period = ctl->perturb_period * HZ;
+
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -672,14 +680,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	headdrop = q->headdrop;
 	maxdepth = q->maxdepth;
 	maxflows = q->maxflows;
-	perturb_period = q->perturb_period;
 	quantum = q->quantum;
 	flags = q->flags;
 
 	/* update and validate configuration */
 	if (ctl->quantum)
 		quantum = ctl->quantum;
-	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-- 
2.50.0.rc0.642.g800a2b2222-goog


