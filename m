Return-Path: <netdev+bounces-150071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58DA9E8D3E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5ADE163955
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04EB215187;
	Mon,  9 Dec 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX8sJdgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01850189B85;
	Mon,  9 Dec 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732511; cv=none; b=WK9jBy/ST6mTEfcuJMb4Z4D6MhGo3LPghaLkNbBPKcWg8klhofZKJHQP99B3e+eQuAecEYnp4sda/8t8bs+DtirIostoOMaIDJvkrMxul04TNLtsjyorb1NHDzHWqdQ+xtLhzgYO2acbRqt0LqWVo4PUbkWdB6ez51JLYiTXE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732511; c=relaxed/simple;
	bh=Ck5S5UStSgxAo7JB8vwj7vH53/X1LJaeiPRtCR4KqFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCQPOptaxab2GikGIaioh2ixRViB2QJJDmASqQesy4pPFIMwB0NHuBOZeCdXvNRfQbCFGC0cFWZqD+mAmunoMOW9dJyGhyAJhe/SNcJJLISPnmR95sNKi7DdXeTZW53VbOwnvaLgsd0bVh3DSCjEpedSybqFQjjdrB9+2YeajBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX8sJdgt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6d6064b93so78378185a.3;
        Mon, 09 Dec 2024 00:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733732509; x=1734337309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awh+ClfHImBzrrL2TAHAng95htBMT8eQLu9aqmC2sps=;
        b=DX8sJdgtgn6tdddUEL2ddRWNVPdJUjrtleU0g8ElLil8arzFcu0E3IxxMxcTiR/RXN
         oB5lo1Y5hoehwctbCyEFK8eXxY2LkrxD3+tidH/+Unm+nfxaMLhj93joSBD0LCrWXtmV
         gPU3BimXRFjNC2BnU1vDrv0ENTKvuj0D3c3zr8zVn9n4eZXvN4sZS5DLye1uS8QVakqO
         pjiHaoY12hMRRewuB76Fd96nS5c1zt2Bb+9/8X2jsHZk+ykSf4YFzeJoYqdmapc6kNen
         wMkkoKE92vRKGIRku79Eto9RHfIQtooSbfxZMDoeZ7E5RwsnvXPXMmtfCgDNS7FfxG/8
         Ft7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733732509; x=1734337309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awh+ClfHImBzrrL2TAHAng95htBMT8eQLu9aqmC2sps=;
        b=vOtM2Jm/s4En+xTV6MvcqB9En5Nd+ANbMm352v0VPTT0nNJBd4vUeC2crn0floHF0l
         0KOE/SXmPJNUVXFSf6m1tjAbmrQHfXIWQQ8Kh5i0AtLweUv4jZG2s7R37aaG7xhVtyGR
         P5UwxiipEDnEssMCqiVAetK2Te9LmQZjvb3L/XanDz7pQ0yFMrzUmayXn9sr2iHp5jwQ
         HTSvhbUkYQT3Bvf3/ocyuep4XPxF2JHRjTx353qpoLU60Kw+ap0+pblU4n8gk9yK+RPB
         ZhJVVcixbUxo5MjMG0syVxaQFrkg2gwKQFZrr1bQ7QDRCcMXKSd9UbV6iIXnc2cDSQ1U
         RsJg==
X-Forwarded-Encrypted: i=1; AJvYcCVRehfKzWjK/DKceu89tyusdSRqSVVxZEes6lickXOj023eVIOk+Pz4byySwAXAuRAa99IeeRAC@vger.kernel.org, AJvYcCVdC9M0Kq1bF4nB0z8S2RqHIyHGISm9CSa5KbfiN+BJB2tUgzW5btg11NWk4UeZmPZkNhsppQp5/Q6W@vger.kernel.org, AJvYcCWt/L7O96WDTQuzqpD+UyIlxygHJg6fPHt4ddUnW3GDM3xP+Y2WfrTAWORv9rfA89V2zOc3MQK0nwTxCWbu@vger.kernel.org, AJvYcCXuq2ix3+hSD2pJIDBQjqDWOzMJSF/OkgfLvseQrNvuFUm3qJ11pEfzMGI3Tbsb4PB5mdq0cRTLvAYm@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwkIivBSkMvqvRzBEdKKcp/l60nWrlQaOzUzDcY/ch/b6IuMy
	4LmO9sENog+AlKiaGjyt10QJqUEjyEFtTx2/hL4yd0+9ltcY/jRg
X-Gm-Gg: ASbGncsddNDb1fDsrMZ9xvAKSe/IR5DkKkLr3nUujcUST3sUx5O3o8dQKZd/K7ELvJM
	aN0LbKS1nfaDd0+X6u+lFOET8jVZHbZPgSNJurEQ9eJltf8spnQ3+qgVztv6ia0KvkGschzsPdE
	lMbK2tj6elgnpu+M4ee7GPaB1xRsTWw4ntXx56cNHLh4VE0bZ0tEszajYruxU96PWJ5LX47DS0d
	lkVE2VRBmMXSHYMRQVKrQqQVQ==
X-Google-Smtp-Source: AGHT+IH3Z1wHTlbyWa2+4bS8MnKrr1jLso19lmLRXYOGTes0r/t1WrTW33uAk6dL+9PDP470skMu/A==
X-Received: by 2002:a05:620a:2441:b0:7b6:d441:bded with SMTP id af79cd13be357-7b6d441c008mr420244085a.51.1733732508771;
        Mon, 09 Dec 2024 00:21:48 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d7886351sm57211985a.86.2024.12.09.00.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:21:48 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/2] clk: sophgo: add SG2044 clock controller support
Date: Mon,  9 Dec 2024 16:21:29 +0800
Message-ID: <20241209082132.752775-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock controller of SG2044 provides multiple clocks for various
IPs on the SoC, including PLL, mux, div and gates. As the PLL and
div have obvious changed and do not fit the framework of SG2042,
a new implement is provided to handle these.

Inochi Amaoto (2):
  dt-bindings: clock: sophgo: add clock controller for SG2044
  clk: sophgo: Add clock controller support for SG2044 SoC

 .../bindings/clock/sophgo,sg2044-clk.yaml     |   40 +
 drivers/clk/sophgo/Kconfig                    |   11 +
 drivers/clk/sophgo/Makefile                   |    1 +
 drivers/clk/sophgo/clk-sg2044.c               | 2275 +++++++++++++++++
 drivers/clk/sophgo/clk-sg2044.h               |   62 +
 include/dt-bindings/clock/sophgo,sg2044-clk.h |  170 ++
 6 files changed, 2559 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
 create mode 100644 drivers/clk/sophgo/clk-sg2044.c
 create mode 100644 drivers/clk/sophgo/clk-sg2044.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h

--
2.47.1


