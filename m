Return-Path: <netdev+bounces-209163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E23B0E820
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224771C88750
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E0143744;
	Wed, 23 Jul 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UINusBYR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DA111AD
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234234; cv=none; b=B+PIUCxhZzsKkfk6i9OuQUse2T8H3nxQKZIra1s5emqRKnAwPxJbt03+F/94DkUemhcjGyBVJXKKzhb9ZjefmZszsM1+Eo93YPr3m/gZfaMB27Yed9spBCiOrsJnUv/Z35BGIjNWMVzIwBFhqoZjPAjfw9wOmvcrxdkXsqMlv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234234; c=relaxed/simple;
	bh=TbmtZ/60qNu99Sqz7AUx2tGBBoF1vzkhS3uywpq3EtQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SkZLa1/5rPpuaUbMYNzUaKobdlvnpef0Qxe1VGyJ8W/Q+aiuhHk6x9XY4wC9/zgsjsNtWq4/XofiQQNZgAUXVmNMrfvUjigs5DtxFotSNWUxjguEy7DhO9BXHRkshKxkNWsrVnP2NNyCan7ekcwQ3vdVlot3cZJxNK3Zro4BPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UINusBYR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31f4a9f67cso6975640a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753234232; x=1753839032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9x7MhiqEJyLxYdB3PPVHCommmHmcRCseuZdal5aGCnQ=;
        b=UINusBYRr7F/v0rERgl6LaEzlnDPnbWls0UKTmj5DKiVXOQb9pcTkMEQ/SpzWNfzh+
         qqqUfu6IFasAAewqGzbXUF8dRZrh+6dU8VRFsoB8/FeF7EzvrP8c1UhKaexSRugqUbtQ
         7PVnd+mpisgbPMhKxsr1sTB0NvkJYeTdmJv7b4RL9tco+HAMFYNNyFrZAFhFOS3vUnQm
         I/3RdAN0Pj44RCBxxRFM9stpoEOf69u5MEsiCvF7XqJcD5KktcPlz/W87Sg8pgwWnour
         i51Wpa/WEM9BhYE4rnEJhNO1zElaDi30GX7MQk6at6WE2kGk8EQ+1UgSeiDh4CtkssM+
         lICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753234232; x=1753839032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9x7MhiqEJyLxYdB3PPVHCommmHmcRCseuZdal5aGCnQ=;
        b=OvYY5pKZt2q373PSnv1+h0ttV6iTSbYY6iqx2gGBAOMY6h8xvGD21HkHWRR8/MGEjC
         x4zF7bjSZhkDQb7Dgs/BmwNIydfxbmkfzc1xiwTPnmyveIdly+hm4Uzcoie5ZP3xSrl8
         xRqnzWJofwTXHRazfIHcEt72vnGMb/YoH6FltxUjdDyxPNsjqpPhsBspgOL58hTx5vmD
         mOfTECD5Qfjpy2RTt+9Vpn5Qfl9kl7f/niPukamdqU0guBhS2rCDuZ6Uwe++dczCpPfa
         VazIYRmejPFpP1nKdcNXwjbjR2SzD1U4+sKENMa5+Qc8xnA0ampTjxRASdI9r7vHb+Hx
         CHng==
X-Gm-Message-State: AOJu0YzMEp6H7zdlcwL3/wapz0timMoBmdtqEDDiRfYOMpB+TPIhcyIS
	4+Y2lYHRxERzL7kKNDADCJWV9699ZtVH8M+wRG09ySO3uGrpPhKLDCrenS//QlyqO5qOe1fvjPX
	NnA917OCfYXhSOg==
X-Google-Smtp-Source: AGHT+IHtATFWz0zWVE5KiSgkgHPWK5mEcJG2wS9kwQ/01K+jVVXB84QUy7MUn014KV0LNQg5bayfV6OsyrE76g==
X-Received: from pfbkq20.prod.google.com ([2002:a05:6a00:4b14:b0:746:2ae9:24a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:32a5:b0:1f5:7eee:bb10 with SMTP id adf61e73a8af0-23d48fe0ae1mr1681221637.8.1753234232585;
 Tue, 22 Jul 2025 18:30:32 -0700 (PDT)
Date: Wed, 23 Jul 2025 01:30:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723013031.2911384-1-skhawaja@google.com>
Subject: [PATCH net-next v8 0/3] Use enum to represent the NAPI threaded state
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Instead of using 0/1 to represent the NAPI threaded states use enum
(disabled/enabled) to represent the NAPI threaded states.

This patch series is a subset of patches from the following patch
series:
https://lore.kernel.org/all/20250718232052.1266188-1-skhawaja@google.com/

The first 3 patches are being sent separately as per the feedback to
replace the usage of 0/1 as NAPI threaded states with enum. See:
https://lore.kernel.org/all/20250721164856.1d2208e4@kernel.org/

v8:
 - Add a kdoc for netif_threaded_enable
 - Renamed netif_set_threaded_hint to netif_threaded_enable.
 - Added cover letter.
 - Return type of netif_threaded_enable is changed to void

Samiullah Khawaja (3):
  net: Create separate gro_flush_normal function
  net: Use netif_threaded_enable instead of netif_set_threaded in
    drivers
  net: define an enum for the napi threaded state

 Documentation/netlink/specs/netdev.yaml       | 13 ++++---
 .../networking/net_cachelines/net_device.rst  |  2 +-
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
 drivers/net/wireguard/device.c                |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
 include/linux/netdevice.h                     | 12 +++---
 include/net/gro.h                             |  6 +++
 include/uapi/linux/netdev.h                   |  5 +++
 kernel/bpf/cpumap.c                           |  3 +-
 net/core/dev.c                                | 37 +++++++++++++------
 net/core/dev.h                                | 13 +++++--
 net/core/dev_api.c                            |  3 +-
 net/core/netdev-genl-gen.c                    |  2 +-
 net/core/netdev-genl.c                        |  2 +-
 tools/include/uapi/linux/netdev.h             |  5 +++
 tools/testing/selftests/net/nl_netdev.py      | 36 +++++++++---------
 18 files changed, 95 insertions(+), 54 deletions(-)


base-commit: fbd47be098b542dd8ad7beb42c88e7726d14cfb6
-- 
2.50.0.727.gbf7dc18ff4-goog


