Return-Path: <netdev+bounces-244576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D56CBA1C7
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 01:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3258C300F3AD
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 00:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDFD1B78F3;
	Sat, 13 Dec 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="o9tNlgKD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8D1A3160
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585362; cv=none; b=ogGO5qgfOmOvtVBgnbx7D/kgoSFZTehCl+mQxvkETKp9VQA0VV4QxCSIEgmkn+8wDP4i6O8JyjJYsrng9tnKQJ6t1M2huAbPF3+mUaStQdUAnvNZxdVI0kCme7E2NfcP/8Ekw/C3edtWtPHx61/3cVbqlVNUfZn0PxyJkLhcjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585362; c=relaxed/simple;
	bh=J+ZTQ2XvhF+eJ6uEvbqBdblHfUG+41RKurpRpIN18GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYL8J8RPZrsfioodhhtu9vhPT/yTiX2uEgL2QFtK5t1VkWTAd3B/yCax1dTcQy5b4peS5EdVb1kI6hy6YPMgmuUgDO/B8FXI0CAYso9AqY7kIfOb/1zJ1Z/nBWb3y5aRHsqrsLalu1Rme0Hfa0XulhIYSlxpH2IYhpGz7KTpRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=o9tNlgKD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343f52d15efso1818733a91.3
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 16:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1765585360; x=1766190160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygpkiDbZjJvjZf+AJjz4EzzCS+085NwneWPh5RGHKtI=;
        b=o9tNlgKDzWxnG1VFX7bcohugoBRkZiskjxOpoKta8tAgP7W0DotlrpDBwWj/C/6l5A
         ash+MVfJHuYxRcwTxoNb+ZI5FHsWJcNtXNvK3VmRLcvoZZ0Adv6yO+lSJ+7ZWa2H6gua
         +No5f+/4xxHZLgoZtsNXmdKU2d9LXG0EOiV1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765585360; x=1766190160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygpkiDbZjJvjZf+AJjz4EzzCS+085NwneWPh5RGHKtI=;
        b=j42QrNmbJC+u/E+f673Xt/OvywT+l+4FjvtQEUKI1xUfdKDcswvtgumAeEapdqHyXu
         aO3FM70JW0UfkYkhUnXqwJkPJdMvwLMmRJeoDl+pYy2vNv/p5BZhJOic93xndgnEFqxe
         hU4rvSstmMsJl+R+F7AypqOLm7sdcm1qWv9NqGVluRD/ANsOr9tIJWvjF8woS9snbUQC
         WX1a+L2FVN9f3z4qJOtCjl9JYgnmBPlO+ISK3wNXms8V8SMXQYj9kyVYaHhgnsr11FFY
         clBdPVXrqzOtlrO1Jro8npQyeeffAug+LxRo9iBbUujmt88pm0A8II76OoHLiNtFMC0u
         zJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrjLP2kf5cD+WYbwJv8oHZKR+SjELU+1r0L/qyldktLzxKzPqDLCviTbT0S5kY0wOHEjrr8Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcfk7oi3+Nb4Z/7smDxc9SLi+9C1qXhMTqyTYPBi+6kdon2YA1
	G/QtWGhGMi29XKoYtSynSJ6PAZ4mTyKgg4Y/Iao6jv4r0qv3bcO+mh6vnxpY+HsqRrY=
X-Gm-Gg: AY/fxX43X7aUPPwu8vy+e89ulEVVHzqKnnMk9NwjAGGAAVUY8ewH4balSUwoKJ07id1
	7pkLGdrxR1c5wamoU11SjuzSHg1cxBpgyUGxPn3nIx3E9OU1Vxjm2ZkiTyGuYAC+n5wcAOnbcBy
	vGs6Z1FYI2Te/itlTmBYIojBpOnN3eAgrQF818RgfrZHe7TJ1KHjumbFnypjSTPj8IuFC6HxtL0
	fnEhJE4u1+SQRKBsDp5VcO1WzooHqgOjuA1bbJWOa0IDq5upD4GKoQn5ybwwx2mhKSeuN445KLy
	RwmT1XoDFxtwYCy9IjbdnYD4ehHZj1DOkBP1EXi7PclGd6ML6B7QHaG29jR16RKm44Y9vH4Ve2a
	EEl2D3YwOTsdznW/RRcJ8BipgUmcVOljaoA28g01TOj5eG4xjjjXaztStY74eCbl6245eFi5NLG
	PPQISjPFP9Wnh6o6DFn9+A6CGFon6IXF8L
X-Google-Smtp-Source: AGHT+IG0QiYTdCHSIsEkeQltqDYtw5/P8taR7PvtjQwb68+KpS6nA4pHgaLRQkALdrQsTkpgs3B5Xw==
X-Received: by 2002:a17:90b:380f:b0:340:66f9:381 with SMTP id 98e67ed59e1d1-34abd6d873bmr3073525a91.10.1765585360489;
        Fri, 12 Dec 2025 16:22:40 -0800 (PST)
Received: from fedora-linux-42 ([104.160.131.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe1ffdf0sm2904719a91.4.2025.12.12.16.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 16:22:40 -0800 (PST)
From: Cody Haas <chaas@riotgames.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Cody Haas <chaas@riotgames.com>
Subject: [PATCH iwl-net v2 0/1] ice: Fix persistent failure in ice_get_rxfh
Date: Fri, 12 Dec 2025 16:22:25 -0800
Message-ID: <20251213002226.556611-1-chaas@riotgames.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey all,

This is a small bug fix for an issue I found when testing some e810 NICs
on kernel 6.16.5-200.fc42.x86_64. I originally reported the bug in
https://lore.kernel.org/intel-wired-lan/CAH7f-UKkJV8MLY7zCdgCrGE55whRhbGAXvgkDnwgiZ9gUZT7_w@mail.gmail.com/

User Impact of the Bug
----------------------
In the current in-tree ice driver, if a user tries to get the
indirection table using the SIOCETHTOOL command and the
ETHTOOL_GRXFHINDIR subcommand the subsequent function call with always
fail with -EINVAL. 

Cause of the Bug
----------------
When a user gets the indirection table using SIOCETHTOOL and ETHTOOL_GRXFHINDIR
ethtool_get_rxfh_indir is called. This function will end up calling
ice_get_rxfh which then calls ice_get_rss_key. The function
ice_get_rss_key expects its *seed parameter to never be null. This *seed
parameter is the key field in ethtool_rxfh_param. Neither ice_get_rxfh
nor ethtool_get_rxfh_indir set this value, so it will always be null.
This causes the *seed parameter for ice_get_rss_key to always be null,
ultimately causing ice_get_rss_key to always return -EINVAL.

Fix for the Bug
---------------
To fix this, I went ahead and implemented ice_get_rss which checks if
the rss_key is not null before calling ice_key_rss_key. This follows
suit with the i40e driver's implementation.

Cody Haas (1):
  ice: Fix persistent failure in ice_get_rxfh

 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 +----
 drivers/net/ethernet/intel/ice/ice_main.c    | 28 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

base-commit: 67181985211850332c8ff942815c1961fd7058b9
-- 
2.51.1


