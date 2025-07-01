Return-Path: <netdev+bounces-203056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93929AF06F3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73FA4A823F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D1242D96;
	Tue,  1 Jul 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ4cjOq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DDD26B778
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751412602; cv=none; b=TUfWqb468HsbYTB0ki6BGZ8z/+bG5zdm/51xE31fUwXfBIKv3CyJzV5zZBXSgr9sEe3X5Vo9a4e6USYtT6eA82TNYJfErPSYUbIykLx4JYCnye4LcnatesoxwM7mQitcPsloVsqfA6lVOXtu51EOrtDQmc8PYvsnXXGf5EPRpvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751412602; c=relaxed/simple;
	bh=rTldjOOaJQ9ycPTHDpEqHEp6g2xLSuIxTz69i+VAWV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hsIYwFNupeI8delakOONSCs73lsJt309RHrcIlFmWYF/+dglTvEQtKV4Bll1tStkppVAICN1HuJrUFqgImyVpAwCoX/HPT6jdQbjqIxsSwhbw55qwkHCey/kI1ABbHtdxJH2EOtcPhnEfpl5pCA8VcT8iOOlo1vKweIIdLmcLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ4cjOq5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4947706b3a.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751412599; x=1752017399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QACqmqo8WAHaSedC1brVb5Ns/6/dzTUNTHvnDFSMpI=;
        b=eZ4cjOq5MH8oPiwGPY3GGWvIX4DQJbo3g5WHxJpckbpwM4biOhhElcDv750DG3/uWj
         zXsL/h9euriyDcO+EC/8h55/WjGt2CeEEf0FwZZ8PZ1VuvFUwDXKhGGXQU3wTPgHio+o
         qYpxvDDaz62aXv82mYb5pKClmsod8f6ChtXyZJ4PI60DYodzOQo7NzqzP8lm7S1yCPy0
         jldvFAKJEUR6CaIRX6pQyzVNv9ANIaGvIjUfWzbwityeMPQO/i4s8kyXphVaYa2brSJr
         jdqGKD2oJ3iqYik32F5xWdUKtHszIY2smu/0VwP7oCUfyyfTlIoqadZ2XOxiF0MuJUB/
         u4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751412599; x=1752017399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QACqmqo8WAHaSedC1brVb5Ns/6/dzTUNTHvnDFSMpI=;
        b=IQtc8YmSiR0eJgIEIF7So9xbE1E6w1gdIXH0jyDbHC9tdi86Y/snxdK88w51pHdObz
         GT7I/zbA/rs6k59mfL+H3eJEiR+Au7N9X6PuWrjwFx6RCLOHmcO5dXWM3wyza3RnjMz9
         hD62puBdglQIToarNEaVpJqjByuZVRk1Hc5/aSW7Dv7cf44MLKXJlUz2eFEGjYxpSkRa
         HZhJjSMWY+F1aXHCB0LP1D4vziQPcTUzWg4EBVlKoj0Kg45O0FafHN6tCJ49BtP3Vleh
         GFQdsNG9TpXTZgLnJQzI7aR2cPqcqD/OiU7Y7FLfWbF48NaHvUeQJl2mZlyWxcRtGdD6
         Hclw==
X-Gm-Message-State: AOJu0YzLgC53bDir2Hdw1hvP3IE/1o3UHSfE4IsLPHEF3H0uRxaC4cZ5
	v1I67liDK3vYAJ+OLqrFlSKOoJoZzz15VPDwZGIPwjULLga6wraZoW+/JaFKug==
X-Gm-Gg: ASbGncvDbN9Pk16PU/jOwcqgdPm9gsa/ksQObI9Jy6tGE4cxYvcC8vHQx+zJP49S0dr
	YmYNmMdhy6dozntzj2UtecTziW/DCqtX5MQTi+TUTtqqFw76ie8u319KX7MDD05vWB3zzOfsHz8
	CzZJbCl2J4k0saykta7ROCsYyhYt469ihTxIn9MzsiiNu0ED0MsXc9noGsgnQgIVFLgFOxUlu2T
	IwYI8ornfh8YNLvA3+FN5S9Dx0ErsaRVs6F64MsecbVi7sERJCsTk5buFYJyXfYqNximAXymnA4
	oCiTxQqYulqCO3GEfzoCrqyASm2uLTGYtqJC9AAtaL8NHxhNh+nCC1uzcz6XpDls8dVm0yXn
X-Google-Smtp-Source: AGHT+IGuntVlSGDjZQ0DHAFqRRaswE8cubFTuR9eqZMBaBwyxNWjQm7mcWtW0yIl6MNwZesgOEKdFw==
X-Received: by 2002:a05:6a21:4a8c:b0:21f:62e7:cd2d with SMTP id adf61e73a8af0-222d7eee64emr1579585637.34.1751412599607;
        Tue, 01 Jul 2025 16:29:59 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af54098a3sm12909269b3a.16.2025.07.01.16.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 16:29:59 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	mincho@theori.io,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [RFC Patch net-next 0/2] net_sched: Move GSO segmentation to root qdisc
Date: Tue,  1 Jul 2025 16:29:13 -0700
Message-Id: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset attempts to move the GSO segmentation in Qdisc layer from
child qdisc up to root qdisc. It fixes the complex handling of GSO
segmentation logic and unifies the code in a generic way. The end result
is cleaner (see the patch stat) and hopefully keeps the original logic
of handling GSO.

This is an architectural change, hence I am sending it as an RFC. Please
check each patch description for more details. Also note that although
this patchset alone could fix the UAF reported by Mingi, the original
UAF can also be fixed by Lion's patch [1], so this patchset is just an
improvement for handling GSO segmentation.

TODO: Add some selftests.

1. https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/

---
Cong Wang (2):
  net_sched: Move GSO segmentation to root qdisc
  net_sched: Propagate per-qdisc max_segment_size for GSO segmentation

 include/net/sch_generic.h |  4 +-
 net/core/dev.c            | 52 +++++++++++++++++++---
 net/sched/sch_api.c       | 14 ++++++
 net/sched/sch_cake.c      | 93 +++++++++++++--------------------------
 net/sched/sch_netem.c     | 32 +-------------
 net/sched/sch_taprio.c    | 76 +++++++-------------------------
 net/sched/sch_tbf.c       | 59 +++++--------------------
 7 files changed, 123 insertions(+), 207 deletions(-)

-- 
2.34.1


