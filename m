Return-Path: <netdev+bounces-118674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE709526C1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6694DB2152D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7E1A32;
	Thu, 15 Aug 2024 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYShPkVz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7162F3B
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681170; cv=none; b=Av6N9YoGAhXs9Wm+3LzRulomp9cDiOGUrpYrjiDrby4dLc3n8j9B0NB1mA+rEXGQnj2g7NuFVKIDo5GCosuw1eL6Vz33GPWIE7u+1HJC2aJDHY2loyx72LBo5LZMAaAu7/5fb0YoD3FrKyzqkO7x4VGC81zKnXPrBP6axvbXakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681170; c=relaxed/simple;
	bh=rkR1sWXapQfVu6wVGxLL5zJoh45nxt+YH0rveVpCDs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S57wGHaKC3lE42hRSsfVDTV6Zg40ZwRk3e2fibrFkujxqSyD33pYshUSRKQJPZm44HWTFiVZaq5emvyb/slmGjtNp236MwMv9pplXkeA+M0aTvL5s4TncHi9lWmfCPIUCTRLMSWp+93J1rWDCGwcvXsa5dddYCwHUwL8X35+53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYShPkVz; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39b32f258c8so5251255ab.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723681167; x=1724285967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEgTRDQwpDaoZ/gTggSmygmSIrigoqt9ay9ZMVkY0e8=;
        b=fYShPkVzY+mmv//P1wz4XBHSqiRmrXKZC2rPmmtv5bk8SIq19SnNWtauJZiwcLGsqj
         7swh6zmiawPiDfEovmaz3t3g4aJWMSYrySlUOQUGvTNpvP7azBA/5fMgQTb6iRe5Qmyl
         JgSHrqkd324PdsX0/R+gER+91u+vwLzMria2AU2cYmjDH01vaIOZmMdJaPYomHGnd4Qc
         419syhQDxFu3m6ZuJLlw+Pai6/lDLcOuldtqXBJj1F1pO8bFPYMEciELbAFPv6yKL7rC
         xAoEswP5oMMsHr3vNmOy7iCDw67fZMefo2KL7oOOxAxGe2ZJJ7DFlfEuN3GtxFdOXt/2
         Bc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723681167; x=1724285967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEgTRDQwpDaoZ/gTggSmygmSIrigoqt9ay9ZMVkY0e8=;
        b=BDCnr4pkBMBusnAU3R0cVXj1S9QsgftOuMam0KAR+l6islAe0plbo/L2zc9Ru4TLc4
         VBhtIwbysgz82rEhoRTuDvmPiTbQ/hujnPiS09doQuwHxQAuw4ei9yV7g1j/sJF3veZm
         3jlmfcLEvoFVos1uPzsoLOEr8PjhUXjIPVcG1EoWBTdFqfqGBKMq/CKgB1jLoIDDez0z
         BTx/63eOZbRpp22wyDwCRvEhZEWcNrP8Z/9BhiKc55eLseB9dplVq9zPEPKEvNUUgnVE
         jsCKyFhEHfgB2xZVJQG/m3IN0w96907ht/ewECfvOzPb4FFzk6bZXU0ZuLezkl8OG/5g
         iDlA==
X-Forwarded-Encrypted: i=1; AJvYcCUXuNbmJfFYyGqaNHfz++buujYhI/fwUbS0NwyvCOVVYkb1vqoD7uAfvCuvtdGCKcld5ZjiiCJPI99qODnAn4H15EhT2xFw
X-Gm-Message-State: AOJu0YxAoljOHTyJqpF7aFYg3VD5J9fT/EFgWBBoLs08QUHcV/lZFZ5j
	aNIxPMRBtpNRHEeWOdPyWHk5m5Bjjf4KlxOQrWEhAnHteYEs91J5
X-Google-Smtp-Source: AGHT+IGnB9AEyIqrdwDsH9uZ5/Cqb3BwTirsmfd1gmR/INA1EQJjXN494NsRX4g5OnjTehjvRPF3gQ==
X-Received: by 2002:a05:6e02:1c86:b0:39b:3244:a355 with SMTP id e9e14a558f8ab-39d1bdbe7b8mr15790145ab.11.1723681167477;
        Wed, 14 Aug 2024 17:19:27 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ed74e0dsm1244935ab.78.2024.08.14.17.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:19:27 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v2 0/3] tcp_cubic: fix to achieve at least the same throughput as Reno
Date: Wed, 14 Aug 2024 19:17:15 -0500
Message-Id: <20240815001718.2845791-1-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series patches fixes some CUBIC bugs so that "CUBIC achieves at least
the same throughput as Reno in small-BDP networks"
[RFC 9438: https://www.rfc-editor.org/rfc/rfc9438.html]

It consists of three bug fixes, all changing function bictcp_update()
of tcp_cubic.c, which controls how fast CUBIC increases its
congestion window size snd_cwnd.

(1) tcp_cubic: fix to run bictcp_update() at least once per RTT
(2) tcp_cubic: fix to match Reno additive increment
(3) tcp_cubic: fix to use emulated Reno cwnd one RTT in the future

Experiments:

Below are Mininet experiments to demonstrate the performance difference
between the original CUBIC and patched CUBIC.

Network: link capacity = 100Mbps, RTT = 4ms

TCP flows: one RENO and one CUBIC. initial cwnd = 10 packets.
The first data packet of each flow is lost

snd_cwnd of RENO and original CUBIC flows
https://github.com/zmrui/tcp_cubic_fix/blob/main/renocubic_fixb0.jpg


snd_cwnd of RENO and patched CUBIC (with bug fixes 1, 2, and 3) flows.
https://github.com/zmrui/tcp_cubic_fix/blob/main/renocubic_fixb1b2b3.jpg

The result of patched CUBIC with different combinations of
bug fixes 1, 2, and 3 can be found at the following link,
where you can also find more experiment results.

https://github.com/zmrui/tcp_cubic_fix


Changes:
  v1->v2: 
  - Separate patches; 
  - Add new cwnd_prior field for cwnd before a loss event
  - https://lore.kernel.org/netdev/c3774057-ee75-4a47-8d09-a4575aa42584@gmail.com/T/#t

Thanks
Mingrui, and Lisong

Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>

Mingrui Zhang (3):
  tcp_cubic: fix to run bictcp_update() at least once per RTT
  tcp_cubic: fix to match Reno additive increment
  tcp_cubic: fix to use emulated Reno cwnd one RTT in the future

 net/ipv4/tcp_cubic.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.34.1


