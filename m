Return-Path: <netdev+bounces-100412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578908FA71F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F751F23CDE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7BE522F;
	Tue,  4 Jun 2024 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="h64O2c+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD663E
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462001; cv=none; b=J3q2/Hl4Jn9Wa+Oxe7c0aFGn7/HiHDCsqSNE2VNciZJP2Jlj3ear0aZoT2q4r6Ap4clqkSZoPE7MLFzorQeC09t3Mj6SgUUAPJgoq47yLPlpVTExCSTvs4XkKMnAxg0+LPb4CVuJQD/jQ52MKndlL/XoIbn7G149mgeaMzc5eso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462001; c=relaxed/simple;
	bh=CcYTAVWyB3ymSj/OaY1OftSd6VsNT505IUtr0hifhfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QoW9lcjH8gGGXAFUUwgvU5my9iBwgEi30FGNwsQJ1/8/JwnpoKpTOp+bFhYlfP82VIlM4z0No7JnY3/5qF1s9yIKw3uC129XODTrcBkarx8dJayShF7uR0LH0dLSQnhhohkki9+itfyB81RRlPATwcXwvcshSluuJALzSKxf/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=h64O2c+v; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7025f4f4572so1384524b3a.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 17:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717461999; x=1718066799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6qJ3cMHA2ZvV0BHrtuqD+iovtfIMHyhYFzDZ7OtxxQ=;
        b=h64O2c+vb0/hkqU+j9xiH+oAo/4BANflqg4hW7j+kVwpE7XHPT2g9KvMqWp1OONrBo
         G91IdPe6AVx0cowx4wB70eyAgmss4XprBoq3GZVQffhyGOCsSZBjUm5QG2d2pMUmvNWu
         nAyQZL8hNYYovwlqCHv+qhxC86OZdHK0Tq3h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461999; x=1718066799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6qJ3cMHA2ZvV0BHrtuqD+iovtfIMHyhYFzDZ7OtxxQ=;
        b=UR2y7RD0MdO2Eumy8/mxt88bIlFJv6hfXukQH/wvI+gWhafz2MWXlQo9SeAg2ZqFBL
         iO+ljmu3El6WrteBR2e0m84H6xcOxgSFTgzLPMqcT0fK2HjmxAdaY31+qyDhF8VK0AlH
         RgwnqKop+ZBZKvjZS9v2Q2O9wYCjG6pGOdiRtYOvpm2tN5M6N8XQQux/S+1QwSXOtifI
         +mzc2YEaOSdLERVCNVBmYeSNJnks2PPYk7Q+ZfpuSwQWP91xIzyOBgpITgGCUDaxouCs
         7j0Zi4afRY46JMB45VSCv3CP0fmVOPw6luOBe3tW9gZZnccEiz+vPZ5w5UFSHqrFWm2b
         r3DQ==
X-Gm-Message-State: AOJu0YzQL4umuCN4m45zO3yLNTXfJ8yWm0tkpOiW69h94b11cHdoh6EN
	px3T1GHcT5PUItOL87fe10y+vj0F3X5yRo0jJyHGC9p4F/53wKdESI1iTqzWikO7f3o+QcCkpVp
	AbmKWlVx7Nvrb7HW+ya6uMVUQX/BRGuno7rdO3c31gSe+RGcZlol216XWJyjQJSZ5gIaoaEPfwy
	Q3Rx9i6KuNk/O5lV0cF2i/gMGkoYyBi9XAY5M=
X-Google-Smtp-Source: AGHT+IHiXBgr5xgcd9sLnnfdN+CIcxTRhmG+sm41M8+12g0FN0OWcYs//B0JiJ/pC845y6AvHYrpUw==
X-Received: by 2002:a05:6a20:8418:b0:1a7:590e:279e with SMTP id adf61e73a8af0-1b2a2b84011mr1872915637.5.1717461998677;
        Mon, 03 Jun 2024 17:46:38 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c26067sm6049316b3a.218.2024.06.03.17.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 17:46:38 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [RFC net-next v4 0/2] mlx5: Add netdev-genl queue stats
Date: Tue,  4 Jun 2024 00:46:24 +0000
Message-Id: <20240604004629.299699-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to rfc v4.

Significant rewrite from v3 and hopefully getting closer to correctly
exporting per queue stats from mlx5. Please see changelog below for
detailed changes, especially regarding PTP stats.

Note that my NIC does not seem to support PTP and I couldn't get the
mlnx-tools mlnx_qos script to work, so I was only able to test the
following cases:

- device up at booot
- adjusting queue counts
- device down (e.g. ip link set dev eth4 down)

Please see the commit message of patch 2/2 for more details on output
and test cases.

v3 thread: https://lore.kernel.org/lkml/20240601113913.GA696607@kernel.org/T/

Thanks,
Joe

rfcv3 -> rfcv4:
 - Patch 1/2 now creates a mapping (priv->txq2sq_stats) which maps txq
   indices to sq_stats structures so stats can be accessed directly.
   This mapping is kept up to date along side txq2sq.

 - Patch 2/2:
   - All mutex_lock/unlock on state_lock has been dropped.
   - mlx5e_get_queue_stats_rx now uses ASSERT_RTNL() and has a special
     case for PTP. If PTP was ever opened, is currently opened, and the
     channel index matches, stats for PTP RX are output.
   - mlx5e_get_queue_stats_tx rewritten to use priv->txq2sq_stats. No
     corner cases are needed here because any txq idx (passed in as i)
     will have an up to date mapping in priv->txq2sq_stats.
   - mlx5e_get_base_stats:
     - in the RX case:
       - iterates from [params.num_channels, stats_nch) collecting
         stats.
       - if ptp was ever opened but is currently closed, add the PTP
         stats.
     - in the TX case:
       - handle 2 cases:
         - the channel is available, so sum only the unavailable TCs
           [mlx5e_get_dcb_num_tc, max_opened_tc).
         - the channel is unavailable, so sum all TCs [0, max_opened_tc).
       - if ptp was ever opened but is currently closed, add the PTP
         sq stats.

v2 -> rfcv3:
 - Added patch 1/2 which creates some helpers for computing the txq_ix
   and ch_ix/tc_ix.

 - Patch 2/2 modified in several ways:
   - Fixed variable declarations in mlx5e_get_queue_stats_rx to be at
     the start of the function.
   - mlx5e_get_queue_stats_tx rewritten to access sq stats directly by
     using the helpers added in the previous patch.
   - mlx5e_get_base_stats modified in several ways:
     - Took the state_lock when accessing priv->channels.
     - For the base RX stats, code was simplified to call
       mlx5e_get_queue_stats_rx instead of repeating the same code.
     - For the base TX stats, I attempted to implement what I think
       Tariq suggested in the previous thread:
         - for available channels, only unavailable TC stats are summed
	 - for unavailable channels, all stats for TCs up to
	   max_opened_tc are summed.

v1 - > v2:
  - Essentially a full rewrite after comments from Jakub, Tariq, and
    Zhu.

Joe Damato (2):
  net/mlx5e: Add txq to sq stats mapping
  net/mlx5e: Add per queue netdev-genl stats

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |  13 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 149 +++++++++++++++++-
 3 files changed, 161 insertions(+), 3 deletions(-)

-- 
2.25.1


