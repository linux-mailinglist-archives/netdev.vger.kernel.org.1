Return-Path: <netdev+bounces-247911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3942D007D6
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 01:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C493E301DE20
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 00:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4AC1D618A;
	Thu,  8 Jan 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIl2wAgc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086851CEAA3
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833002; cv=none; b=vBp4g9ntS+9Zj5eV0Wl74NVYbv2Z7OxF5amV2SHaSKqnWXKkSnZWY/EWghn3nDXPZiSkM0E1zbKkOchHsAELg+GLfdbwyDwpi0NcaDUWsEYrxL05zPPRxf0t59uNjvtQ67HIklQTTueUPkDZA+QvqTokAYalPOmD5wdLp/CS8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833002; c=relaxed/simple;
	bh=TKccjqaNDGKSN8I2zv8eLezQc4TbljNm9tj+eToCpgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtV1KL3dn1Eu54N5b3ZXN72lmsnOoLNpt2rK9d5AlnMxTROnM2TVQ6MFnUnw7Q2oMR4NilCv0gr9CtRIZCUiUf2zOCzefB/JWksG9PMk9VMuxFpG/vRiKwhgZ3APlKa3LiP1BbL8Cb1yOMeGyBxZPIVe0+FkRHlYMyerr6ewJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIl2wAgc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0ac29fca1so20966755ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 16:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767833000; x=1768437800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cM0TbDxIeFJglsNYhqH1xgbVbFKF0WxpEUgM20nRoBY=;
        b=TIl2wAgcelcrBXpLEASyT7fTnupII3nyklQIp00N3AUMrWRzjdClnzHH9W0NJtOVHY
         75r1cvuyv+kyU56EyizgzSPqDm8YXpc9HoWvta1E81FfsyjDWUA/neb98z3QCn2jW/Jj
         1HJ0NVhDXvZFzxcri7P+i68mg88BNCUQoKtUrdMmsXSt1UTP5QrS6SobeHVjdD2JfUQk
         VUy6Y0tJ97MxxfOkta/VJdsPE/GbNxbNvfyELhWXWJwCKv7uvqPWAZE+gRrAzDa3o6EM
         oDVJEcnhyuZaFbgKyyLjv8NkaY+zjH0RuinRWT07gHzkT9QcLsc4SNUa+66vW79Y9IIT
         uFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767833000; x=1768437800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM0TbDxIeFJglsNYhqH1xgbVbFKF0WxpEUgM20nRoBY=;
        b=OfohOU7uG1G3Bg7UwSQZELkNMI8d1w+RNB6BmQpOpFkVrJ75LPZ0r9ysThUJyfX70v
         EK7SArENSqfZIeR1C38rqcBnpuMB8GC+g5K4K5eIcoovoM4aZpcZIYd6lCenrM/ztVz5
         9OrsNiKo08SObZzdbF3yO04v2GJ5Y4sWhmt4CoqOcs8a5Rse4HLrQ+fXAi2doH3PyZXY
         SycU99vhNR207yxsJNbiBGQW3Q1JH5ixkYEMoYGOrYXXaMzte4R+AsYzjGwaHFlT8xBS
         xzSDudoKqxh++xZS7hEW5qY8iUPB95F04HayMDrofdmCaVsjxXqkx239ikAPgb5DTZtM
         6r2g==
X-Gm-Message-State: AOJu0Yyf+ZMbsbQFKSKpJlkWSLthQeDq6SCWESEr5Qr7Ieu9IiJahkP/
	1/i+dmT9axCj50xV5rLFjqjS79Gm1m8ptIMJ5GglWjoyerco2/IRCRv44JAlq4EP
X-Gm-Gg: AY/fxX4NSHY6hWf3KDhJ5ipkL+urf0wy7GSLclloDRPrDHb3XSFcG+7N09Hrdz/cc68
	NjECgly/+TLeY9D2I/hkKe8mGm2I8C2h1/KDoN+eeMbj52vIcziW5xX1Fnb+siv1haP3TXzM5JJ
	BBN+nUq15F2bemTc39mrgjTE+CX5VeZh7FhMEJtjUlAG0tQuc9UscCDkBcwtLhBghp/GG+zw7XW
	qmwPv1VHNibgveo2yhpjY8D+K8rSxLkqD+nFrTuCmfNyTA6o2xX773IQGXaIub2rPP+wzk3N7NR
	FNVToQX7CNGp2AhBo6Kke05Lgx4oPGCUtTWicW2C809dkSfdN9SIzl9b0yrmMkWquOPHBIh1ipZ
	5E2Ozfz4/K/kiKh3/Eluei9aaP5n84cqUJOnJwMHieTqrOIdqQVKINc0MTX03rku+K/JFyHe4fO
	X2sCUUI2D4pcPy6wWy4ngRFyerUy0+bnttsocEPp7cnA4ltC6YEH9UIA==
X-Google-Smtp-Source: AGHT+IEzTajH4CFIYSUxvfDnBf/w8VVN+9EAwEK8HjYNmyhIcSt/or/XO3hktdIRa4//bsSeEmYAgg==
X-Received: by 2002:a17:903:40cf:b0:295:5da6:6011 with SMTP id d9443c01a7336-2a3ee437892mr40662745ad.11.1767832999995;
        Wed, 07 Jan 2026 16:43:19 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88d8sm60198435ad.80.2026.01.07.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:43:19 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Thu,  8 Jan 2026 08:43:04 +0800
Message-ID: <20260108004309.4087448-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning reported by static checker.

v3: https://lore.kernel.org/r/20260105020905.3522484-1-mmyangfl@gmail.com
  - use u64_stats_t
  - fix calculations of rx_frames/tx_frames
v2: https://lore.kernel.org/r/20251025171314.1939608-1-mmyangfl@gmail.com
  - run tests and fix MIB parsing in 510026a39849
  - no major changes between versions
v1: https://lore.kernel.org/r/20251024084918.1353031-1-mmyangfl@gmail.com
  - take suggestion from David Laight
  - protect MIB stats with a lock

David Yang (2):
  net: dsa: yt921x: Fix MIB overflow wraparound routine
  net: dsa: yt921x: Use u64_stats_t for MIB stats

 drivers/net/dsa/yt921x.c | 257 +++++++++++++++++++++++----------------
 drivers/net/dsa/yt921x.h | 108 ++++++++--------
 2 files changed, 211 insertions(+), 154 deletions(-)

-- 
2.51.0


