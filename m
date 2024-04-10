Return-Path: <netdev+bounces-86385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270489E90C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638101C20938
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 04:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E0DC8DE;
	Wed, 10 Apr 2024 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="D25LaJJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860068F44
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723985; cv=none; b=eRZsQ7TM56yl0G2k8odu8y07c5LKvIbB9oYkcz/mQXeEESe6IR1ivD4vnUHNdGalc5YFZ5A8StQd2e+NF9I1HgVDRG2FaSu2vL4fguDgTe2Mxxo4vr9IjMttn3dXYn6FDEkM/ais4Vo4tEm9lvgyaQMbs+FwYwwOFDtP+p3zT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723985; c=relaxed/simple;
	bh=DtdulvZeq18gg5nwhugKq6JgQxiYFWo/qLdw+2pmabM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dcWqUMxsYvA9XFk0pwf3dD+lZCuVFN8Nm5eJeCLjwmygamb0HVQgDj/l/dYG5x2Bw9y3bhdMP17orZd42u/vuza1blUpAea+q1OvUsa/teLA5rkUWO4yu5Cr+5ePPnJjeyqyovuAoPVef2bul5OFh+3B87SntciAD8Owpprm84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=D25LaJJv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a475bdd4a6so3238700a91.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 21:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1712723983; x=1713328783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTBKn+X9fYIhUY+SfQqhA1p7Ow+PslkWyXYeQlLznYk=;
        b=D25LaJJvAKSXYchN6l1DiUFXFFyJthF2928PYJkQVv4AfGh0hfZ1sc/e2aI7RJUHCy
         cJpHgWuaWG2pPoG6tlUlkcOByTeZM2dfRBAemtGWqrgsLBcEq8YLxohiAG35RuvVelPU
         edVqJ+IPaoAGev5jYka87Xgr1vukAITh4pgeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723983; x=1713328783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTBKn+X9fYIhUY+SfQqhA1p7Ow+PslkWyXYeQlLznYk=;
        b=K+YS7HWXZ9LM7Zs/EqdHK8mdI8RyUallVGXnvdEY/ptmz3hXjFQD9JaU+jYjtbk2j3
         6HcyYq5OvnBhW0c/sxasT4wm3XhFrhMbZ32dDoZRvvpJXrAJsDtW5JRW7sNz5gOCfKUi
         XPpJkh6HQH4Ke7s5hRWbEmWn5p8YvzO+DcI8M/nE5zfqpFeFZRDZPmD1iZHFFXc0mtoZ
         UiuLwlEWhuMGQohPxN32AVPFdKkkxqoJ+YSCNOEHCrnsp793glt7APeqn98tWXabaEJK
         1bXQmyQMKlhWlY7wHuhWRuyzvyTyMKeW3TWk5LWUCtdm02SQI/zvXOCc6TDMoLxgrkJJ
         rocA==
X-Forwarded-Encrypted: i=1; AJvYcCWJFqgntSNvnOw2vGXlJgFudmVfyvAsmhddjTL4mYfN7TkfDjcM52yeFv9Ovof3KBY6+16vkfWvmaR/y+ZQUQ1bM3hWIPDt
X-Gm-Message-State: AOJu0YwDrelJU5G/0RS1sqDjw4HQrTHbEZHq0Nftm3SEuHZGAEXIDXQ4
	+03s6GdpqScUTXhrOoygIJoO8IDjsvPGHO1gEDmGHeyYgp1vTxKHwH/Weo8QqaHOWboBq3XAa2s
	O
X-Google-Smtp-Source: AGHT+IE6idq9nTJW2mID+KEBk2ciEgsbfXSMT5eLrh1uUoPhsGEPfHjous1/IHHuE4a4LZ+5SF/hIg==
X-Received: by 2002:a17:90a:d505:b0:2a5:37cc:cc4e with SMTP id t5-20020a17090ad50500b002a537cccc4emr1550232pju.32.1712723982772;
        Tue, 09 Apr 2024 21:39:42 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id gn4-20020a17090ac78400b002a5d71d48e8sm260773pjb.39.2024.04.09.21.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:39:42 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [intel-next 0/2] i40e: Add support for netlink API
Date: Wed, 10 Apr 2024 04:39:33 +0000
Message-Id: <20240410043936.206169-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This change adds support for the new netlink APIs to i40e which:
  - link queues, NAPI IDs, and IRQs together
  - export per-queue stats

This change is inspired by a similar change made to the ice driver commit
91fdbce7e8d6 ("ice: Add support in the driver for associating queue with
napi").

I attempted to replicate the rtnl locking added to the ice driver in commit
080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain scenarios") in
patch 1/1, but there's certainly a good chance I missed a case; so I'd
kindly ask reviewers to take a close look at, please.

Thanks,
Joe

Joe Damato (2):
  net/i40e: link NAPI instances to queues and IRQs
  net/i40e: add support for per queue netlink stats

 drivers/net/ethernet/intel/i40e/i40e.h      |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 160 ++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   4 +
 3 files changed, 166 insertions(+)

-- 
2.25.1


