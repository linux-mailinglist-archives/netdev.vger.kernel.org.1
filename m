Return-Path: <netdev+bounces-172672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A3FA55ADF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183451897ABB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29FC259C9F;
	Thu,  6 Mar 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMs/EA3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679032036E3
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303453; cv=none; b=HEZheXYeyu4qf9ylz5nHWpgexo7vH7sPD52BRLi/5oOLYI7hrMF5450FFnr0RH1uwG14S7jjWiCdpiEHeZ7TjoEyMar4A66REPrZ8pJ6RPFFSmLe+rborJBALBSVSAbIDDt1HFXVHqS9NuuD+eS/Y7PTFuA0l4g5nMpSf7KSqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303453; c=relaxed/simple;
	bh=fSjeX5swoAm2J/aBHwPKcLUP8lbz3eVQ7v+a3QtSmUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hoICkfxdtRkAyQwztd6AK1SFCHMkA+C/xxbbwCrigQPNkfOCt6LG6G904KFZdsVEWz4g19REbz+Tc4TH0Rm6JkfV5HTGpW9YZpzIaJbWJNdGcSJOc3nKUt8HR9gsItBoJH5gBFg9N6p+bGGrRQW/xpdbfOy4DfEm8ASIK0r1yPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMs/EA3J; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240b4de12bso31388705ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 15:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741303451; x=1741908251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJtfNHxoG3tMs1jrvV0JBwqbRioewFhTFHp4iGNoTHc=;
        b=AMs/EA3JlBqUk4uOD5sbijG37BYR3ve3j38Vt2Ho5WBBWXcSuddI9V1AHPZdWXYulH
         k1i5ofWJbFHNiXDBLg7/okatkXAjS5HK/w4BbG6a8or9M2P82ZlP359FTrtP+XH3AlTR
         1jFSqOY4Pcz+7P/aXBCpJhC3qlSZaW4ibcmGEEiKZ2pzRzdVlY4mLX5iu7J5FOmbMmiD
         lglfQ4Q9lj2vaaUOybCHkQvXaBSwzMznjj0DerOq3/QxhdjDnr5ycG/5wPcADikPPsbR
         pNmAweSTpK9/kP/fBlTYnjjuchdXbryCGjGjJzAljUchEvwzWC57aQNjga1Kv2MoXwxR
         4VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741303451; x=1741908251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJtfNHxoG3tMs1jrvV0JBwqbRioewFhTFHp4iGNoTHc=;
        b=TBSgsCT0uaSzyg2Oy6fih32/L9U4wznaZU0GMFWlKtLJ9Do9Pm783xmgtpadJoeIaE
         6yptv1348iWJyF9KS5UmsvHlbxNSftunxpTZaIr2PTFUAg3jWDdRM+kEeFCCLqIqw/v2
         b22PgQo78VKKcH6yAFAXxYwjfvrHDuPes4LLrHjuR5gaUtBBdBGR8lnCQo1Uz+o3fggt
         4jzej+UUrUbvHN54y2glb9unvdlF8SyXdaZNFFX2OeB1YjkLXj7KB0/VuD2vI3Ssz/Dd
         67l8hPRllmmhld+pd1yBR8DWLrm8fhcs3BF+6VOQS7JokdG41lGzUwXsKo2rVfu/wDAW
         eL4A==
X-Gm-Message-State: AOJu0YyDshXUdbPAU2YZ4QFPoBXZOogDsWELtQiZGGK2/zY4cSLHRT5w
	rPMK3zV8y8dPc38LKPqveg3hlhVVz0bLhoMhsz8hPhXO1GVh77Zur8GdXw==
X-Gm-Gg: ASbGncuP7GcgJZ3uVsjyWvdOmSw0IOmxaODmo78/wqBiJc/V/gUuC3TZ8yJdUw7nX8m
	iKnYsnD8ml0Z8LnEn+u4av3O6S2Bj6luAbk+OykTQCedgSgxUeOVQLz/0nLEBTl4gmrxJ+zXS3l
	/eOblriIaQWupxI4bNFdcnvJ0O0gzA5AADtazHE8nXDhtVHpYiprvWQxHjEApHax25wiy1+H8Lv
	t8QZDbrYsg2l4UNR5STcSu/JlhTXFVmU+bpTfW8C9nrql7VK5Wc6nUjYuFrHpECXbtOK/VIQcf9
	96CsblCF4BmwZl/RMATjdydY7P7svcBUrw/xRyn2c8AquEWa4c1KlD8=
X-Google-Smtp-Source: AGHT+IHe+ZhNou68aKQ+Q0A2GGrYFo/fGhoHEDEcL24PgrmnXQ6+vL0zcmoM3lYcouQUcNng1uPLCg==
X-Received: by 2002:a17:902:e802:b0:220:e1e6:4472 with SMTP id d9443c01a7336-2242888a998mr17504105ad.13.1741303451196;
        Thu, 06 Mar 2025 15:24:11 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dddd8sm18006285ad.12.2025.03.06.15.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:24:10 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	mincho@theori.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 0/2] net_sched: Prevent creation of classes with TC_H_ROOT
Date: Thu,  6 Mar 2025 15:23:53 -0800
Message-Id: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains a bug fix and its TDC test case.

---

Cong Wang (2):
  net_sched: Prevent creation of classes with TC_H_ROOT
  selftests/tc-testing: Add a test case for DRR class with TC_H_ROOT

 net/sched/sch_api.c                           |  6 +++++
 .../tc-testing/tc-tests/qdiscs/drr.json       | 25 +++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.34.1


