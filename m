Return-Path: <netdev+bounces-100075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBC8D7C46
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C7F1F229BC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2F37147;
	Mon,  3 Jun 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiF4IBx1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31821360;
	Mon,  3 Jun 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398916; cv=none; b=L1PPmPhmMmlVvxOBBvml4W5A5CsTGkvZUVs5iT8YqQppj5aB3r9hJ97LEugVCsqh9u+tR+gPy+TR8hPMdzx3/7ya8MihcmbAO4026eokHTdAhqB0wPC1DsaLgKIIVifzdTCpNnuaUKV6+N80Sc/DfAWpPI2yFO41ZOKT/7oaPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398916; c=relaxed/simple;
	bh=SRkAH4O5vOm0fmKCzjnZRzeUfl/+uwl1jXqqZccV5YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iCE5mKU4TLcD21ZvmlbIqFltX91Xtu9eLHhsYn5Q+TL342+/NuZdJoTSZkMACC7/1QKHa8xQctT08sc8FNvtAbDp74N9iTgvI9R2Js+VuMW1GPDcTTRojmrahpp0WO8XBLLEunN4DySC3mxJgyy88mHI9UnD35xWdj2OPaQpRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiF4IBx1; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1f60a17e3e7so3207595ad.1;
        Mon, 03 Jun 2024 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717398914; x=1718003714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sWJ+ghBtSe8Nj1TZ8ojyawHfDULvuVFkGiOmN9JBQA=;
        b=iiF4IBx1YmAwhf7jp3j9chkKni3KRDUjFJV4ENHDncu9/FLFjOdTNkscCGzONk516p
         R5rjRLbgkUpY0GPvUmhgAIy9zpQyxRr0eqU0r01ljVnY4Fa2tIsWLij6qP+almEjStUU
         m8oaoPoc+NtybDpMKTZ2BORevN39j7tOn1uXUwDDydevG50IX0HZP5r9OXOAgBeLC8m1
         nl9TYLR69LAG0WAtUgh+XrquZr8GdkMIKU7i/oda0AnGT3qz4yiFCpsT4sJUBshaJqHQ
         eSzGbXEs+Nc0x/TZR2Pt39hajw75AFlbPXhAO/SG7LHbq2SGUs3UaiJi+okf/JJQvpc7
         6i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717398914; x=1718003714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sWJ+ghBtSe8Nj1TZ8ojyawHfDULvuVFkGiOmN9JBQA=;
        b=fQcQqiXrLCwwVoOWB0goJT8x2w4Llj4nIqgnuGrJ06WOWAZpm/x8kSO+b4tfY3DXR/
         B6DS5RO281GkImcY6L7/bgKZMYXBVB49MFqvG1TII8nRvXY5fNXeBifpLOzrepDuSIVH
         Pvv+d+CzScTPo34HExHoCWUCPEHrRoQVXvqylyifvVeVjesWISL8tyNjMqnbAOEfaaIX
         Bd9gI5KMDqQ/hool7nnk0iIOHmIq+Q1nOPM4ofBeh6ws08lRjlal8V0Ibwpze/oxjdhP
         G/uCJLGkBFnXanzne7gBAhd52pYXyZu/pgXeJbe1yScxeDUlV5Fu7OSOgpbR+2h4oZ3c
         KkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIRWi6Q6/ZjivKxVHp/GCXOAS4r3YBIcEZg6qlnGYURaW4SgBxneFT6JBpLq/FBtiJSqnUhgSsBhcVcl7hyUVrpAy2jIGXHoKz5MGg
X-Gm-Message-State: AOJu0YwzKhS9LqSAIT8pU0sBffkh9FajdFKTe/XB/2Y69arr0GCeuzQA
	UVNOUaGklRn/c39PZg8NN6FI65sjaGhxFrkdb75UOr+zoT+wgsSD
X-Google-Smtp-Source: AGHT+IFm4jVAaNRV503akITNTz08JFMRgh+rtxe1U62GtxRAVS5Fp2leg7A20Z5lwI5YzTS1axJJqQ==
X-Received: by 2002:a17:902:e74c:b0:1f6:828e:86ab with SMTP id d9443c01a7336-1f6828e8839mr8714735ad.6.1717398913996;
        Mon, 03 Jun 2024 00:15:13 -0700 (PDT)
Received: from hbh25y.. ([31.223.184.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63237ae1dsm58613335ad.119.2024.06.03.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 00:15:13 -0700 (PDT)
From: Hangyu Hua <hbh25y@gmail.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@mellanox.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] net: sched: sch_multiq: fix possible OOB write in multiq_tune()
Date: Mon,  3 Jun 2024 15:13:03 +0800
Message-Id: <20240603071303.17986-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

q->bands will be assigned to qopt->bands to execute subsequent code logic
after kmalloc. So the old q->bands should not be used in kmalloc.
Otherwise, an out-of-bounds write will occur.

Fixes: c2999f7fb05b ("net: sched: multiq: don't call qdisc_put() while holding tree lock")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 net/sched/sch_multiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 79e93a19d5fa..06e03f5cd7ce 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -185,7 +185,7 @@ static int multiq_tune(struct Qdisc *sch, struct nlattr *opt,
 
 	qopt->bands = qdisc_dev(sch)->real_num_tx_queues;
 
-	removed = kmalloc(sizeof(*removed) * (q->max_bands - q->bands),
+	removed = kmalloc(sizeof(*removed) * (q->max_bands - qopt->bands),
 			  GFP_KERNEL);
 	if (!removed)
 		return -ENOMEM;
-- 
2.34.1


