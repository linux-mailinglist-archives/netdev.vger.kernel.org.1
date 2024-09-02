Return-Path: <netdev+bounces-124282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE754968CDF
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E2A1C221FB
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F71AB6FC;
	Mon,  2 Sep 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsqnSZIm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6F1AB6E8
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725298762; cv=none; b=WLTehzhUqZDUXAgpNyEdq5FPGMh+veWaXynD2t0h7V10XIBPxrB3vrgC7rhIugYWv7pnjrWUGJoN61ByHL3tYFn5hqi/U9WOnNsK6dHjlGTcdufJGoGKnIHFYT4enNjXsjUNKS6C9Izq6I8bRSmfncGFvB7acAf2Kxja9T/fwV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725298762; c=relaxed/simple;
	bh=bar0Oo3HeN+i+rpgtLuh/jt2Ks6JJZL9d2B27aYJrZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMmNdeNMsQ9/OhRIpbyVwm86BaUSb6t4d2pALYVAQGOs9xE7AC3MuMEJc5zfnVud05h1OhAK9u2QVSxp1fVIdaqbl9Oe0DZCciGfzA0PbA4IhbZuCJNQEuwzgMSzpDHHvmMbaYLCtx75cwopXp9G//zGz4E/b3ayfTX9uCRsddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsqnSZIm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbf138477so24544685e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725298759; x=1725903559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+kFJC8cvU2nTFoSm40D7acxGkIP3j16jxtAWX3iLEQ=;
        b=SsqnSZImxTZzzX06aKq9Epc3LdEIkAASfniLmmVP6xnJ/ibE6hFQn+bwokVvAS/SJp
         /clpzXbjcZng3Pgi/dzBF9HEyxbgMScwTZnwnxVWOt2aRZ243OsmpwsrQv4tWaDH0i5R
         AW6DuCfo9/PMONhlMHPOhBwxVmXn+OZHSejN7RgRov3/OjnttPz326U8sZNDBTCGtvUm
         qBiWXUkRiUGDvFUatFtU0/vLFuKtG23dBFjDPzucRpts8L9UH1gb1onv7gR2L08doRko
         yI3RTREWzyJZDS5dIV6zxZKq8LBpZyPfmtiSBKuh7dFM7YTfC9vmzL0OXc8Elv6KA811
         R+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725298759; x=1725903559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+kFJC8cvU2nTFoSm40D7acxGkIP3j16jxtAWX3iLEQ=;
        b=DYkhaRla/zSYyzdmEfhsJDPU6XePc9OmND/lCwNMG13NvdKptXMHi/cl44QsWv6UUf
         eb1zTPmyIvrsbmn3FuygK9te4Xz0kFWbicWBpX5T8YvMCfdhjuhGThC7phtZ/mS39P4v
         zoClcY4TDFCU2OWgLHL0eC2mRlhRUbMwsdORzqI2T/RLx6+ifZKtVsQkowxZN6qsgVXR
         stPFpzg/mDpdgXREtD0EbiDMoPv3MzTjg+njqUNlDV69UY6H6OIhIoHTcSW7UD2s4P3t
         8lh0w4iWL1mYUF76hMTYfT/3+l4b4pPwbqhNhw1DjMHRhc5QUIrzT2XOPM0E2iefikQf
         hM+g==
X-Gm-Message-State: AOJu0YwmieFydFYRAiiIi1nQCn8SvnMWW7DiFVR7VKwPfP1JASl47WpW
	a4aUoak1DzOyunKDrufk07CqMFHgfPIj38yTxrLBHxCHVAKV3aJwVdrdaA==
X-Google-Smtp-Source: AGHT+IG4BGMZ2F2SX9XZkXrx+LBdxPsCDTwy6eAg6XPbBy7Ff0fToy4W+aCI8LNkhYHEz0YWLCCIsQ==
X-Received: by 2002:a05:600c:45d1:b0:42b:afbb:1704 with SMTP id 5b1f17b1804b1-42c880ec5e4mr7156205e9.6.1725298758650;
        Mon, 02 Sep 2024 10:39:18 -0700 (PDT)
Received: from localhost (fwdproxy-cln-018.fbsv.net. [2a03:2880:31ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abea3sm181936905e9.28.2024.09.02.10.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:39:18 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kernel-team@meta.com,
	sanmanpradhan@meta.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v3 0/2] eth: Add basic ethtool support for fbnic
Date: Mon,  2 Sep 2024 10:39:05 -0700
Message-ID: <20240902173907.925023-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds basic ethtool support for fbnic. Specifically,
the two patches focus on the following two features respectively:

1: Enable 'ethtool -i <dev>' to provide driver, firmware and bus information.
2: Provide mac group stats.

Changes since v2:
- Fix v1 reference link 
- Fix nit

---
v2: https://lore.kernel.org/netdev/20240827205904.1944066-2-mohsin.bashr@gmail.com
 
v1: https://lore.kernel.org/netdev/20240822184944.3882360-1-mohsin.bashr@gmail.com

Thanks, Mohsin Bashir

 drivers/net/ethernet/meta/fbnic/Makefile      |  2 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 37 +++++++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 75 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 13 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  6 +-
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 27 +++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 40 ++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 50 +++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  3 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  2 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
 12 files changed, 260 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h

-- 
2.43.5


