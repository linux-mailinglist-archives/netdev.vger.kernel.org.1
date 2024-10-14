Return-Path: <netdev+bounces-135344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19799D904
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7E1F22BA1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2811474A7;
	Mon, 14 Oct 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Cm0jlXlg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBE158DC8
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941428; cv=none; b=DSDikknSYjmsaQqe9CgLjI5Wk4FCG9+CsOsuCPLd1K9BG8pAGHmdJvfmBviwG3CJ/jhzEzhRJXfpubY8mznePBvmd4qlU3t5xdk6nAUEt2LojZRVJBUH73LlkAMBHUeT/ag1PH00ZbR7JgDVjxeZbVCg6owmpdNeztJ1AskS8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941428; c=relaxed/simple;
	bh=bEqAb+bVjJWGqU6I6zOFHprL01hEbWXrzpMDgxiSiK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EAdP4YHYQ2Rz2pLRq8kvdnItrBqx3hRmhTF6r8/96K5epEJPG7JnnZtCDT6N9r06s2iXy1D7OlaUjnvWPycM11S2/es8UI49m3sQeZptFs1DJiFhukOGvEOTF+a4UItTDkL54wDHzEVqF7jBkBSWWT2LlmQ1WEdsZVzmklWCnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Cm0jlXlg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c693b68f5so47153425ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728941425; x=1729546225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o+VyLQJDda5qPJG1fPPKSJPMELfF1NGTd/R4wmdZQaU=;
        b=Cm0jlXlg1Qx4VXxf1lP395L/YpYhOPE64rJ89HK2rV+d8vu3NZr4gMfabwkHDgbXzl
         lVjLlszI5qDigqBRBk8vUOXQPfkAzLqD26IhLZJYNkdNZe/WyGExFkFKGZ6tSjdO1ism
         Z/VF29gDgJHhadDLr6ln5zp0K1jXHrwvQTw38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941425; x=1729546225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+VyLQJDda5qPJG1fPPKSJPMELfF1NGTd/R4wmdZQaU=;
        b=jU5Ghy2sVzsYjvopIFWXUJu3LV/FfB+9NKheT0jV/n1hWawcTUVm4JqLb+SorNcMDD
         /9CrLgA664o+OO31vlaU1K8+AsQFNORsLYmoOPTxbuTbeft4upb693x9dDwNZBTxRMBO
         EIF9Or1Rp+5EFh0OmjycNECvYnKLKla0IAtE1VCADbBWT69pmMvjKZxS+PI/dqB193YB
         BcdOTnLRyfqxMeehuqvrj2Ihp53HAcwVpp1MJpmIaXSosiNuV3CcgNbL4o8QMbL6qFwG
         1bu8pKYNqwLqKNp38Uwj8VxoiieYcin9bVlKrdKWwXRHdsyMZu8yf/xB2QKfDBGc6uC5
         0KYQ==
X-Gm-Message-State: AOJu0Yy8K+zzdhaNc0u+Dm6zpv7/XPvkU8ML+nQN7A+e/JR51oL1K5bs
	fIVRh3mLXv7+ja13HYiiB+w64sdQ+ukzjNGdEao5QXRk9qTdfldJpR+y4N4SiEIllYsO31lawrm
	9q2PQLg+jJlYJvzrjbXeL0O/dt82rOyeWx+2kj01WK0hIcOBbZvmssYl21Yl4Qv2Ej/2gyL6JGe
	XJNJrna7o0nHM1tsZ7vzKVj6VAVwSNEjlViJE=
X-Google-Smtp-Source: AGHT+IE3xgA3WQrzZiPsFMr/VZiJGc90cpU5Zyfzew+lfIaXONPM/rnaXq1ihZIG6cOXGviq0kaUJA==
X-Received: by 2002:a17:902:d487:b0:20c:bda8:3a10 with SMTP id d9443c01a7336-20cbda83bcdmr94374715ad.37.1728941424998;
        Mon, 14 Oct 2024 14:30:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1a54esm70197495ad.73.2024.10.14.14.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:30:24 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [RFC net-next v2 0/2] igc: Link IRQs and queues to NAPIs
Date: Mon, 14 Oct 2024 21:30:09 +0000
Message-Id: <20241014213012.187976-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2, still an RFC. See changelog below and in each patch for
changes from v1 [1].

This series adds support for netdev-genl to igc so that userland apps
can query IRQ, queue, and NAPI instance relationships. This is useful
because developers who have igc NICs (for example, in their Intel NUCs)
who are working on epoll-based busy polling apps and using
SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
queues.

See the commit messages of each patch for example output I got on my igc
hardware.

I've taken the feedback from both Kurt Kanzenbach and Vinicius Costa
Gomes to handle the IGC_FLAG_QUEUE_PAIRS bug and the XDP case
(respectively) from v1.

If this implementation looks OK, I will follow up in a few days with an
official (non-RFC) submission.

Thanks to reviewers and maintainers for their comments/feedback!

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20241003233850.199495-1-jdamato@fastly.com/

v2:
  - Patch 1: update line wrapping to 80 chars
  - Patch 2:
    - Update commit message to include output for IGC_FLAG_QUEUE_PAIRS
      enabled and disabled
    - Significant refactor to move queue mapping code to helpers to be
      called from multiple locations
    - Adjusted code to handle IGC_FLAG_QUEUE_PAIRS disabled as suggested
      by Kurt Kanzenbach
    - Map / unmap queues in igc_xdp_disable_pool and
      igc_xdp_enable_pool, respectively, as suggested by Vinicius Costa
      Gomes to handle the XDP case

Joe Damato (2):
  igc: Link IRQs to NAPI instances
  igc: Link queues to NAPI instances

 drivers/net/ethernet/intel/igc/igc.h      |  3 ++
 drivers/net/ethernet/intel/igc/igc_main.c | 61 +++++++++++++++++++++--
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
 3 files changed, 62 insertions(+), 4 deletions(-)


base-commit: 01b6b9315f15f199a206c8b3bd3e051584237d7e
-- 
2.25.1


