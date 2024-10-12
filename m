Return-Path: <netdev+bounces-134839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312199B493
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A0285ADA
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269E170A2E;
	Sat, 12 Oct 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGMCbMi6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEEB16F8E7
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733673; cv=none; b=WgrcbSW3Of8OWhbY4ZIlCjJc/gHqW0QNoDats5Gn16NESALX5+TZQ6x037v3eaQJlmpXjFulglTPAv2gBIZXEvrRIwMoc3zzqfe6elRDtzqFLPMUv85tBgxb6sfoSxK+bEXtlClPdItORs9JNzBW0k2DpK55E6IAYubAvoZvFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733673; c=relaxed/simple;
	bh=X6tNm/g5VEahg1mb+bA80xaMEwXvHa7A9Zpav8cY60A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kdgELdkFE+S3sTM0zUmusFWC3sRf9rzKzxlHG2B0Z7rELu6PgDxXKmggAB0EPK7mIFJhJGzWzUswNjY5cF+Ke59eKsOcrk9DDITEJuWo/AfSqqsc3w78H7bu0aKUHlVn20BkfVrZgiSOVUcNoAdLtZGRegdBiyOiMhZFFwqrkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGMCbMi6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35865abe9so14560347b3.0
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728733671; x=1729338471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pbJtmykR8b+rVgCLVNLodppRWXR1wuydA4kxTBvT/50=;
        b=zGMCbMi6NDcrebtxu/4dXFkdA85bNW70B2uZYlnPLf+mWJjbDd/ubwkWyzk9MUe2Tm
         VhYxSG0gn88Xjls4kSPTBpdAFvACIxQskavIywOWydOibMeE7rotSVfEZBlc6if/asvB
         dc8TRaS7riGQh3oe8/ver6pB4oGuhUqGXjTryKmI2rEdAaLBPedZeTjmX7sXtmOvKHSV
         nKZzE3VUQIe6qHf+OvGsLIlkjfFGmYrahBWCXFJML23iVXyugbbrC9eb0Vlvhy26ECR6
         wZYwuUX+7qZId1P5rXWomRMZAlGNWDn3YPtQfW1JFDlQyH8fwcH/2D4qn4KzGd93vbLk
         WeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728733671; x=1729338471;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbJtmykR8b+rVgCLVNLodppRWXR1wuydA4kxTBvT/50=;
        b=Okvb9hEG+LYqqzwdxrtahaTxB2eu7elQzvfs8HmmHawXkTYoiiomkJIyfTRXbunEmk
         Uj8p7rBw5dccM4iRkSXCaMaMkIhn44RISli3tBsBvTQ6kH833SCQTHvrlW3GsWf4Jtsl
         PUUpbFDM12y87jeCjdzCmGR2uzgzfPjiqYd/agLS+Cg++gSq8V0hYDSs10v0GA545PJW
         G9m559m0Tr7IuPSKHweF39TsOmowg6a7Y4UURycjd0WfVg+SanSmX6iFoT8LJdsCtp5B
         Lcd4hvUcLemwBGeEGc83zRfZ0AKqtrc8Tgbau6bMfl5UNXuadMZdO/BRHr+hQhbXeey/
         kWsg==
X-Gm-Message-State: AOJu0Yw1bdjzlXvHkWrRyR0Vd2kMypdF2JcbJt1jkweqd/erPB+Jf8WM
	N0j4nAmWN/KuXA64NLjBe+S794pd1edmZVnghWcq/goUaIeMYuet8ypW3GCR53B54u/44IM81GJ
	qezIgntRceE226hfHeRykIQexChi5DFiEA/bGIa5nsqxxZ8tMp7mz/MzB1v+GFSlM33mPWIjh1d
	FrsuBFum6NfbKw6Nyk45yl6hDqlvnGBxetp2C0WQ==
X-Google-Smtp-Source: AGHT+IFVis+N2PBg+iScmKMir+LkDaDftwyIiHdrgEVYyiNGbxZYarDzYptKFVdpFLvdilxoJFt8QAlNP3Xz
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:310])
 (user=maheshb job=sendgmr) by 2002:a25:c703:0:b0:e0b:a712:2ceb with SMTP id
 3f1490d57ef6-e2919d870edmr18395276.5.1728733670286; Sat, 12 Oct 2024 04:47:50
 -0700 (PDT)
Date: Sat, 12 Oct 2024 04:47:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012114744.2508483-1-maheshb@google.com>
Subject: [PATCHv2 net-next 0/3] add gettimex64() support for mlx4
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

The current driver only supports the gettime64() PTP clock read
operation. This series introduces support for gettimex64(), which
provides pre- and post-timestamps using one of the supported clock
bases to help measure the clock-read width.

The first patch reorganizes the code to enable the existing
clock-read method to handle pre- and post-timestamps. The second
patch adds the gettimex64() functionality.

Mahesh Bandewar (3):
  mlx4: introduce the time_cache into the mlx4 PTP implementation
  mlx4: update mlx4_read_clock() to provide pre/post timestamps
  mlx4: add gettimex64() ptp method

 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 50 +++++++++++++++++--
 drivers/net/ethernet/mellanox/mlx4/main.c     | 12 +++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
 include/linux/mlx4/device.h                   |  3 +-
 4 files changed, 57 insertions(+), 9 deletions(-)

v1->v2
  * Split the original patch that implemented time-cache and added 
    pre-/post-timestamp into two separate patches.
-- 
2.47.0.rc1.288.g06298d1525-goog


