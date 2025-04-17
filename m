Return-Path: <netdev+bounces-183879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F3A92A2F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A21B62F09
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99C24BBFD;
	Thu, 17 Apr 2025 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXzyJptl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043A1E98ED
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915660; cv=none; b=eLOB4uZSbxpUvkqWIeiCD0iY13NVQwJuFVQS4dh60VK4GcK5CHXSLZGLX+DGgYhnGykc4G947+/HN+3sFjAjNQxt3yTRDtT/pyiVL1VbMltJieAxWSI5JB333mXDggXE7ONxq9a+9uuyDmajphDMIGYjyDWybgzmwekxWDcOUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915660; c=relaxed/simple;
	bh=+8DAMQ4mXCFiCf0R/PzTsY/vzR4OdTs3VAov8tiuFJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U/GRA2QyNEtkypbtqqr2jeYHx+sqpnNngB07YKKxot4enj7wnV6l3v37UAKbpGy9dm408x0DRpFIAnK0TTnyymYlKIOrJXD/67IfV99v5+9uV4vFauq1Nd02UKfrphRJI2CmwgV3utKcxCjOczW3C2hwR3ScMqFvN4H3ILFZcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXzyJptl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2255003f4c6so15616795ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744915658; x=1745520458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAiNyEVQpnIfpU76FgPL3+xDJ5WsaPyl5U2dsO/kRSE=;
        b=lXzyJptlbTNb1XTZ9HmV302NlOstqTB0r6TBVPx2nQBBk8LWGbeE2x64tMIjlSUeca
         NN/tDLJKfiX1IMwgp3NDj+m2Z2sGeL9H/h7FVzDIkS+XHpaT2zvNp8sLZIlRS88POCHt
         ZqYaOjplMQgROgu+fSB500TuJS1EKn0qtS7YlBKLvFHiFBm/pAC4xfn1GZn4KNQb9H/9
         FbDAIspdS8TEDT6ftdQSUowLxvlHvp5eqJaSOhhRgdur7j8Nqg/6MdteeXFKM8rpUAiL
         ZRVCxVo1iLkQ/03qEMc/EpO2xF/rJP3tATiSggrt15lZSbHt0borGwbPzBjrt2wtoDeJ
         jr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744915658; x=1745520458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAiNyEVQpnIfpU76FgPL3+xDJ5WsaPyl5U2dsO/kRSE=;
        b=UWbZEv368bKu+zL/jH+L2z7ZlhqcF9YVB3iqQWw+0SQCTkyKfwMfvGH7XfyU8Y+km7
         VdzGSZOvFDn6uqSLptErvUdPGw1uvuNSyef1f9tRMPKEvSIlqZ8sGK8qqns39zoi+szf
         tRmLhc/21wD3/pZjhRy5Q5BnhSPaVQbgxL0kqduzUI3OIMZ78wlexRn7lgAgvSiszOds
         Z/0YO7iaxPumRISsrWq1nh/JrUeldJ4MvNnT6+t30Bm2GZjyyuoukL0DTdeNP1BABh66
         +j+YLugFnOH/TpgGdDXNA93CP6BLw/RJ/76OYTK6k8iusNFZTMYSDtuMTorVTjHul3j6
         4x3g==
X-Gm-Message-State: AOJu0YyYU0JByRj3AC0P2TiJJS/XTUNDn7Sq4qM4YvDnzit/RGKmJWw1
	0dUvU6OqKyHOzw6gLN521V0gcnDbzwGrDmqu9JMcf4SkRNrI94SjImX2Q4Ce
X-Gm-Gg: ASbGncunZQxFcwcnLO8Qb+PJK8mm4JoaHdc3sSVdFbPQeIzi4KQiY8bA9t3AJ4pD3Uy
	forpDBfOlnGxJMRy/fhb2g4WLqgcBAy4N+J360f0jZY1kqPolUIRzV2MwNb60WjfNKfWHdObFA9
	NJc7xz1pYFfsXWkhlOGOEz3T7o/0k30HtMmPzgnFS0ANzQY91eJ2VO4ew5K5KY8OqBiX20BJrIV
	UwPpqxgd3cUEjQ37vpEp3SYE8AGuUUc3klqbcuRPLWY7AGUfIwGPQxf5f9Cj2exM2borVE8tGRt
	2AkZvS6wwxt6sV0z710RNrgDadSbiTxwMBk9kKbVmG39ihlus0bS9J3YUT0w6g==
X-Google-Smtp-Source: AGHT+IEfTfCmldwEWuqJ3zeSBtfkITTYpTvovgBzwFh+CD7bGq1ydhRfRZSdENSQ1BEGMjYqmTON6Q==
X-Received: by 2002:a17:903:240a:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-22c535aeb6fmr1063335ad.23.1744915657855;
        Thu, 17 Apr 2025 11:47:37 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad645sm187773b3a.150.2025.04.17.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 11:47:37 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v2 0/3] net_sched: Fix UAF vulnerability in HFSC qdisc
Date: Thu, 17 Apr 2025 11:47:29 -0700
Message-Id: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains two bug fixes and a selftest for the first one
which we have a reliable reproducer, please check each patch
description for details.

---
v2: Add a fix for hfsc_dequeue

Cong Wang (3):
  net_sched: hfsc: Fix a UAF vulnerability in class handling
  net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
  selftests/tc-testing: Add test for HFSC queue emptying during peek
    operation

 net/sched/sch_hfsc.c                          | 23 ++++++++---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 39 +++++++++++++++++++
 2 files changed, 56 insertions(+), 6 deletions(-)

-- 
2.34.1


