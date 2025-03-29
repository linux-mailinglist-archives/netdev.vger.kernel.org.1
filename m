Return-Path: <netdev+bounces-178213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6EA757FE
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32B316B564
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554A12CDAE;
	Sat, 29 Mar 2025 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzcYcuzo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E9320F
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743287252; cv=none; b=d7IVWiZ2hfpbjOmYB+XPSm/RRCDafZOuB7jI1k1XjLIZEt02V5Nr7R3C5K7GQ/I7bcjjyvLeNmD3P7/TiHmWsXsyCOfAQJ5FdnS4Fw3fgFNZqyTFBezyx6Zrr4Pafo9r3v8DSqivEUchH8GULR2jikC/yEQhQ12W612+nmSf67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743287252; c=relaxed/simple;
	bh=1Bijnf9Ef+510Y4xZbxll0el1f5S9bkez10VQ7cIRjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fkf3kvB1n3RVSGEi1oLwSdgCcLzLaiD8dvfMqShefwzhWEvYXzXJpz05DygJfk35QIxqqGnkO39ZocAyLF5ClwBzy0UO12wEFYC4lHFzzfOIWqtYzzIR9qJ8i7IxmVjyQdBCCqx8Wn4KdcXBQs0dZIGz9xT0Y/74c5M1G6oP7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzcYcuzo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22423adf751so62976735ad.2
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 15:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743287249; x=1743892049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ziLnmYPU8Ew44YvrK1LmnC1UfhB/CSTytKDHmzJ0qZY=;
        b=AzcYcuzocI6lHM7p2qn2SsIr8mSEO1lkc+/mg66gri0Q8ZAzrz58LqjMbtnYfGnLDy
         W2AKFne934x9rKtqW60qpyCc3nfat/34LUYiaBxEaiAohYCyMMisINcxk18SA10t5rfs
         hypkaoQs2v8BxQ6Osq5g84m510oE2xZm2wuPwS5EbaZTCOeyX1jQrf29DCcba7DqdqSF
         vs7Yn+APB0DawkBubGQThC02MLdXc8Y/uvu+WBunXZMsq9jutG2t8oLGwV2Gwbi6t16A
         nrY4NpE/WmLYcukQy7lapsN1inLizjWA+jF0BKc40WfDpLZGcXhWLkNPbILWJdXK8m3C
         n/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743287249; x=1743892049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziLnmYPU8Ew44YvrK1LmnC1UfhB/CSTytKDHmzJ0qZY=;
        b=V3hMVm0+noKA+TeJErcol9wemyNc9YjnXmuST1RPM4fxUq9n7oj6+lNGGkmGztkGEW
         Z4qCqD88fHl//Zv7SwzhkTjpRv5dO6+iDw12oTiu4X0p2EOfHAZ8pArYvzrWjchB7c+S
         5MoNCTyK7irird4u+r+sdl3NPGYPVR3F/njJDHwXHxXnD6sDIN+oa3KIZSYbuoz/Syvv
         RmwVRMlULUjFrE0YgAAzR52HenTEw8vfY83Tt5pPCHObWyHUVto8r40yTcPSJ5UHcQQC
         CzXcMzYNmPyOgLjBXAR9FrLr11ymsrrsUodQhpKsFXaKm5M1+BP2ADIBvZSq0TKr1MFP
         Xo8Q==
X-Gm-Message-State: AOJu0YxwcNTDuByfsXGl0/FK8d4vJzJSTCmHHEwba2oktIV80Ki3Zgfj
	QlN3Y2I7Jdk4yQ+Br8DEGT49i3VdXCK4R1KrEnq5/QmUaF5/W0+J66sfQQ==
X-Gm-Gg: ASbGncvi3mYqHbHZ9++0mqO5X+diNm3LJTfMJDjKV/aNOamVqLBwkqcAgB+woSWlQ/P
	zuzGjHXXFkETxd04pZgL82tWZLOtynWghIbv/gr5O83L7HsyPBt00KIQR55zkqWWPCMgd4twwIr
	6ozJ127yVpjdPoQPHx/Bae3jq5vfSOdOHTcLGIYXP4iDQ7pWhWdtaLFtC5ncJc+6/u5ispY0i6K
	fbWu/gQPUZLgPmhnOWPMPcX5/PwySwbfgBWWmjv+X2qBzQ3UNaZHWFC5UxbRl6qpC7V5FYk6K95
	pns3H+RFfox+eYTwUG9a8qfEYGWuOqk9AO5GN8PYOKfPSfN9uA==
X-Google-Smtp-Source: AGHT+IGyn03MLLJX253OFH4nCDCFE1hESmep9Bo3RuzZdlj7g76JEOClqrQ3yym/lxz+5MwRxrcuhg==
X-Received: by 2002:a17:902:ea02:b0:221:78a1:27fb with SMTP id d9443c01a7336-2292f94499emr54641345ad.11.1743287249479;
        Sat, 29 Mar 2025 15:27:29 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c022:127e:b74a:2420])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ecbc9sm41477335ad.215.2025.03.29.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 15:27:28 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 0/2] net_sched: skbprio: Remove overly strict queue assertions
Date: Sat, 29 Mar 2025 15:25:34 -0700
Message-Id: <20250329222536.696204-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains a bug fix and its test case. Please see each
patch description for more details.

---
Cong Wang (2):
  net_sched: skbprio: Remove overly strict queue assertions
  selftests: tc-testing: Add TBF with SKBPRIO queue length corner case
    test

 net/sched/sch_skbprio.c                       |  3 --
 .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.34.1


