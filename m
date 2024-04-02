Return-Path: <netdev+bounces-83895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E677894B03
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2227B22410
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CB21340;
	Tue,  2 Apr 2024 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXVKzOG8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3481862E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037545; cv=none; b=L5ozDepgH5LwOoq2S+wH+bs6aTUs2Czovu2EkkfQGZjU+ijgUdm+ErA6QvtFsIkMN1maXFCfYlm6Zsm6YM4gd7XKhtadOU1DONclpolbdX6sZ9UUMvkemM9paL1/XnZnXz0E7wlbCXhyyw6xe100YOOrU3iRpw0cxU/0O84NmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037545; c=relaxed/simple;
	bh=wvKMTNgAe1hezUcUgYIskyDhvLfQTRzL4d6cbfc9M/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzLKJmJ1ZoOBiEmR1jqARD6ARZX1IWOJbwNX0jqGjTUnWZDtfCWWSKv3SreYM4F72L2uyMTA7lXZTayShdw4sulI50d2CxBwhgD8b7SQK9rLCqL6JVLOjxWr+yVtVMPtGt+XcQiF4AovuaSh3y+5E3QlcVnBgE8Sze6wUeG9PtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXVKzOG8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d485886545so78372941fa.2
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 22:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712037542; x=1712642342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fScNHd38fKXVunjONxLTs2Bfy7uVYSFHE6CXgTpd1f0=;
        b=mXVKzOG8C/5n6ihTez5khMLYq28Rp6n4BPJxkLTFa86ZMLXQan6ST7HOFkjavu7qHi
         jCR4hAbqI/qCB7fBGL12PQozcwGZT+CJUL5AI+gwe61reqHjF+7HTvyKIZW51UR2pss4
         Yze+TKaYMCY3Xu/iRtNorB91RhKVLQZuKHUTNfSe1/DwaBTmxeSIAvDPOFG2jSU+9STI
         W8OEC9fAN5UNPzdTI30cKcSTvlXno6W41d3C0Bb5yfgjBFR3v+4UsebAnSZFPz3u5qSv
         ePQEdF88+4cWz5xCo8Jab2rH2h3lNTl1roVtyRZHw54yLPm716fa/cRK19Ye+/TGnLxC
         D/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037542; x=1712642342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fScNHd38fKXVunjONxLTs2Bfy7uVYSFHE6CXgTpd1f0=;
        b=FpCyHkpyjzDYLcJNeLFzM+bDJotd7yb7TXA3UFXKm2FLTsWHwt5iK5OOdE3eiKBn2q
         /shBPKD2kGeJUrKR3tIKNphwgXWH5gDspSJFZeNEy5/y4CEw4uXhbHpTGYWwZKf3PEu/
         0342B59CAkSYvRE/Y1sDVFiKfxQeNHXzGXh2Knky6+FuMH8autAsNTzSUOK/uLOSnCkY
         m5TTts4lOpRy4v61DP0HlmyzQKOjuAHaXjZ3j44GdXuA6cWshBxAKpd9ZAHuBgY/SwFQ
         acTz6YzuCmNGEzoIw4qwGVHuOS6eKDb2iKJCNo5DK/XqzGa9aCp854d+G2MNxBcUoIaj
         6OLQ==
X-Gm-Message-State: AOJu0Yx/7wguNea01yzoUGAn2zdYa7d7Oh9FvAOa+6wFEZCyYsT0QvM+
	9hOBwJ0zC9aW98Ke0WcdrSr32XgeXZ7MzfkwCx2eum5qyuQhTVQ5
X-Google-Smtp-Source: AGHT+IHQq01t+zLvi4gg/ASiwTxLItUQ0scBfNMl90zXnqrMIzSsGRvxMThIGdcwSbPtpWgKrDvmzA==
X-Received: by 2002:a2e:740d:0:b0:2d6:cd05:1899 with SMTP id p13-20020a2e740d000000b002d6cd051899mr456510ljc.17.1712037542419;
        Mon, 01 Apr 2024 22:59:02 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id cd1-20020a170906b34100b00a4a396ba54asm6136636ejb.93.2024.04.01.22.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:59:01 -0700 (PDT)
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
Subject: [PATCH v3 net-next 6/6] net: sfp: add quirk for another multigig RollBall transceiver
Date: Tue,  2 Apr 2024 07:58:48 +0200
Message-ID: <20240402055848.177580-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240402055848.177580-1-ericwouds@gmail.com>
References: <20240402055848.177580-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

Add quirk for another RollBall copper transceiver: Turris RTSFP-2.5G,
containing 2.5g capable RTL8221B PHY.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f75c9eb3958e..6e7639fc64dd 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -506,6 +506,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 };
-- 
2.42.1


