Return-Path: <netdev+bounces-75206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95AB868A34
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7541C2107A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65554FA4;
	Tue, 27 Feb 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2uQlC08"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8754F84
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020334; cv=none; b=jDvP4xRb1mVpaxTw73c6KS8XB79jKTk9oH8IFhSQWTMj/Nq844MbmjYK9z6OAWesGkbtNRYcLx/+Z2U4PWzjTj5iYiVE3AC853DQHuUAvuon0Qt5ufDaBYpMkOvTEb/KveA4onp1b/eJSWbOr8vwkUEG9c0Kq59y3Jif+6tG9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020334; c=relaxed/simple;
	bh=PpM/ZvNynvPW6fbRgMWHBC+fG2UiZkYuuMp77c1sL7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jeGJWBA16PJ6fKOrtZsUrU39nT9icY1MOv66QbiJFW9/uxBK6kPBf5YBWG/RMUNipVZBOajTNY/iTcHgRgnwH0XyU5CQDCDm90dYeqkvd5/r9d9ZNeEDE222MS28nr2/5sPoT/Q10NiHI0VWP13lT/AOjA4pbF+X+idv7y9D2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2uQlC08; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so6308648a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020331; x=1709625131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKs+09mlvsrKHnsa4TKlVwPeQqdrM2wTn34KmK3Tquo=;
        b=O2uQlC08iiv7PYbMBtqEH6WOcNytn3ud6UB95kssW7942jdf8vOB32RVEbOUDrSqEr
         yM4qeoCOfnc2GFheVWFvMvSNWiZwDQCD9+tpt3XpejVv+quFbjuPMi131uYjVAjeIm4N
         m6cd2aBC4sqlkDvPZqgl3tIjb7qzvXEOEFb1F4Ve1SV/YB/Y7t7zOJ0ljnMqfCEVUxwY
         TO8WkjC/Cj85WfPqFLaGRMPTHQaGCPWSZpXaTUFSUYXTjlfm00NMVQjtSq0GVmfVKNQb
         P5CZiC2Q9epX80xx/kW2ogYdaAzmiudMPmKa/QETPhPE8zNQeH4wf9I3pgQ8M5YyI3B3
         nNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020331; x=1709625131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKs+09mlvsrKHnsa4TKlVwPeQqdrM2wTn34KmK3Tquo=;
        b=IZ1FC9ZeQLunNUrHhKyMQSTehgyqigkugT/itYK8Lrb8lGB1UVhHj+5acR1Tu4ODmJ
         BrNIO621tR8Ql3yoOWFcgSXJEMf4I2oa5VhEG00h/ZqIS0P4Sft9NmEzICxkiHfgiaiL
         LWhE+A8JY25n8NbMT9z5HrQ60h6mPJmlG0QnbYGcdxpkCnMGriiWERfqnCjxkPXAw6Ja
         XHFgxPrfP8YVudh8Obys77Qc9Ho/NdxRz/1NLVFq2EwW+/TxON10LSXlpyiHKmLJNoPb
         a4W8GBLnqe63FOD5UqZSB4/wei82qpkczmsqDpGKfFWhI+NTK6fScPLdwwJtU1EU1oBg
         FUog==
X-Gm-Message-State: AOJu0YzsXfJMo8AA5ln0G5fBNH4iN/yPT9zwEZvUI6CcqvO9cie7t2cg
	txYxlqG1KRhyI6WpGhAUgq4vDd86580p3kbFjWWy9G5nrz8qtb1P
X-Google-Smtp-Source: AGHT+IEtHEHybmEtTaCIhjJ80BFp8+i5TLKVoQ+1tfA4bMv1KAURQ2EiG0bKAuj2/ddiR5oEQ+ljZQ==
X-Received: by 2002:a17:906:918:b0:a3f:ae09:5f8a with SMTP id i24-20020a170906091800b00a3fae095f8amr8027953ejd.14.1709020331081;
        Mon, 26 Feb 2024 23:52:11 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3f0dbdf106sm496460ejc.105.2024.02.26.23.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:52:10 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC net-next 0/6] rtl8221b/8251b add C45 instances and SerDes switching
Date: Tue, 27 Feb 2024 08:51:45 +0100
Message-ID: <20240227075151.793496-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on the comments in [PATCH net-next]
"Realtek RTL822x PHY rework to c45 and SerDes interface switching"

Adds SerDes switching interface between 2500base-x and sgmii for
rtl822x and rtl8251b.

Add get_rate_matching() for rtl822x and rtl8251b, reading the serdes
mode from phy.

Change rtlgen_get_speed() so the register value is passed as argument.
Using Clause 45 access, this value is retrieved differently.

Driver instances are added for rtl8221b and rtl8251b for Clause 45
access only. The existing code is not touched, they use newly added
functions. They also use the same rtl822x_config_init() and
rtl822x_get_rate_matching() as these functions also can be used for
direct Clause 45 access. Also Adds definition of MMC 31 registers,
which cannot be used through C45-over-C22, only when phydev->is_c45
is set.

Then 2 quirks are added for sfp modules known to have a rtl8221b
behind RollBall, Clause 45 only, protocol.

Alexander Couzens (1):
  net: phy: realtek: configure SerDes mode for rtl822x/8251b PHYs

Eric Woudstra (4):
  net: phy: realtek: add get_rate_matching() for rtl822x/8251b PHYs
  net: phy: realtek: rtlgen_get_speed(): Pass register value as argument
  net: phy: realtek: Add driver instances for rtl8221b/8251b via Clause
    45
  net: phy: sfp: Fixup for OEM SFP-2.5G-T module

Marek Behún (1):
  net: sfp: add quirk for another multigig RollBall transceiver

 drivers/net/phy/realtek.c | 318 +++++++++++++++++++++++++++++++++++---
 drivers/net/phy/sfp.c     |  10 +-
 2 files changed, 307 insertions(+), 21 deletions(-)

-- 
2.42.1


