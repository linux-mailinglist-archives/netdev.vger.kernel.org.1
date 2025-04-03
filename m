Return-Path: <netdev+bounces-179176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87CFA7B097
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33EE1890870
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42A1A8F97;
	Thu,  3 Apr 2025 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbSpRn2N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2833DB
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714649; cv=none; b=tY8FtJ6qoCIJ3rYhMb9aeXqx1qto10VPFCnnofYegNCSW42LJsRrSjl1NQk/WUbAnIDfaT+tqxIoKYb3x6yg/D1OGpjGPMdnolQS31G95DS9ueLvolFKUwDwd0FBF3rTyFCkLuAtsyfgUoh6aFWlfKxJ4OpKuE8+SGmtkHNQ+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714649; c=relaxed/simple;
	bh=UmeuiX4xvjtGwkWrPjF5Y1LxbVoOfzDdU1JUVoMDOZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lPdbs7x6cN9yZqr/RPrkVzFcnlEIFffQjibFp+btA1V4dARBb8tMkSjEWICQpWnIXAsnu/J+y81gIAx/MJdHgKoMaGJM6FEhIDbu1/dIUtzanvlrYDHIQsQmnUwPv8nNzlFq1K/xldlq/PPfCviGmaokSw/wq7NtCYm+RKIVVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbSpRn2N; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2264aefc45dso19388515ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743714647; x=1744319447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwMDIgAv09cdVuyUxHlflsfMB1EEyYIGctF9QkzuNtw=;
        b=dbSpRn2Nn+abhZaNCZQzhbcYcLPQMBz1RcfU+BhTnDa7D9uJ7TDfx4k0mN84TLbOxL
         gue3pvOlkU0sScyTWwBJSG0QsAjwa1yfz2RkkY6GiAD463OhfJTPQSTf1DfWxAaRPHTP
         /kSHUhdGKosvybPX71/maWDAGfDGGmEqaUgC7cUd8hY8jV7FTh5ujx+BDgwIawj3r+0O
         Wxm/amz9TmTOXXyQLHLXui92UwLFscUYYph9eu/AFh79jQWklgu2uPf3WGqR3U198o97
         YOhBbxYkyQofl/DEqEMHONUCWWPGN1rfJzEx/8JuhFVCpQ+Te+KMnJDBNpb/ZrYLx7Yq
         pFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714647; x=1744319447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwMDIgAv09cdVuyUxHlflsfMB1EEyYIGctF9QkzuNtw=;
        b=GrZ1HWJ4LfL9J+P9XUX7wepZxh/QKWOStKYCYfkvbSvQtp1/u2Bf9Oa7hSfDzRTu39
         mkZ4ONvOyoONkdWJ7D9ChEh5gSy9MlywZBtGSxihs+BuFOeptbFJ/+C9h5sGfz7i1gVv
         CfFZj2ajjNyICqqXbA/IavXDirRyUdT+Kg/QjQvCOp2xMvxEDQI5LX3WtJUSXavNyclz
         zt7lqP83ol2oLAQBhvawhhDA8lUf377qugpZbgXxWvwRf5iR0NpBgEo/gEeyz5bZjXin
         BtfJjFzlltfhJ0VZoGPzkx5/yJBsJBRRCyD+aC7MYN9puhQyfSeTF5rS0ECWDprxwFTH
         DuTQ==
X-Gm-Message-State: AOJu0YyOEhYwYYDIH1YljrInBPz46F0ztZvCCEW5jXlTriFxMVhQAyQZ
	4Cgq2obqvnoUf0TkkmuOODBnQayUtUzLfXk5xK24Cog+vD/aRSnorQOvBw==
X-Gm-Gg: ASbGncueWl4IpIQo4p9tST8d0FH/2azE1b02Y6Wta3MJOyZ1DdFAaolHzgq3TZY95el
	g5lXcUkmE2rS6zBOsbwFoKBB/7+cI7MDUwCUnsFD538yqbtJfhY6skHpL2XfTqVMbXnqwxPjeoU
	gpRDTmQreqFIFI/DNSe2gsFh0OurLqbkaTm1rdzAUKpSVfxGH9KLYQkIT+nGlZr9EYFe71IYsxK
	mkxHWjUQZnqMLmZ/lG+Wms0UYq9M21PAlJqHe2GuiakkiXYpWY4Tc3EfBAoMqwvCnWMGEwXtmuD
	u+8kZZESDyNaZdO9+q/UvKrQtgE3ueOalTswfU3A6cfhMOn3uflEHAM=
X-Google-Smtp-Source: AGHT+IEBZh6hlBhOBXRupZDfgPYW/D4APiu+/070pxwjnzYRcToSC4KkRFXMLb2tcc8SHz6UmL1vdg==
X-Received: by 2002:a17:902:f64a:b0:224:194c:6942 with SMTP id d9443c01a7336-22a8a8b828amr7378475ad.34.1743714646700;
        Thu, 03 Apr 2025 14:10:46 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad831sm19367645ad.11.2025.04.03.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:10:46 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v2 00/11] net_sched: make ->qlen_notify() idempotent
Date: Thu,  3 Apr 2025 14:10:22 -0700
Message-Id: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gerrard reported a vulnerability exists in fq_codel where manipulating
the MTU can cause codel_dequeue() to drop all packets. The parent qdisc's
sch->q.qlen is only updated via ->qlen_notify() if the fq_codel queue
remains non-empty after the drops. This discrepancy in qlen between
fq_codel and its parent can lead to a use-after-free condition.

Let's fix this by making all existing ->qlen_notify() idempotent so that
the sch->q.qlen check will be no longer necessary.

Patch 1~5 make all existing ->qlen_notify() idempotent to prepare for
patch 6 which removes the sch->q.qlen check. They are followed by 5
selftests for each type of Qdisc's we touch here.

All existing and new Qdisc selftests pass after this patchset.

Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")

---
v2: drop the unstable CODEL selftest

Cong Wang (11):
  sch_htb: make htb_qlen_notify() idempotent
  sch_drr: make drr_qlen_notify() idempotent
  sch_hfsc: make hfsc_qlen_notify() idempotent
  sch_qfq: make qfq_qlen_notify() idempotent
  sch_ets: make est_qlen_notify() idempotent
  codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
  selftests/tc-testing: Add a test case for FQ_CODEL with HTB parent
  selftests/tc-testing: Add a test case for FQ_CODEL with QFQ parent
  selftests/tc-testing: Add a test case for FQ_CODEL with HFSC parent
  selftests/tc-testing: Add a test case for FQ_CODEL with DRR parent
  selftests/tc-testing: Add a test case for FQ_CODEL with ETS parent

 net/sched/sch_codel.c                         |   5 +-
 net/sched/sch_drr.c                           |   7 +-
 net/sched/sch_ets.c                           |   8 +-
 net/sched/sch_fq_codel.c                      |   6 +-
 net/sched/sch_hfsc.c                          |   8 +-
 net/sched/sch_htb.c                           |   2 +
 net/sched/sch_qfq.c                           |   7 +-
 .../tc-testing/tc-tests/infra/qdiscs.json     | 155 ++++++++++++++++++
 8 files changed, 179 insertions(+), 19 deletions(-)

-- 
2.34.1


