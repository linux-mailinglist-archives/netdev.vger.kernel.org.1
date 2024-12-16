Return-Path: <netdev+bounces-152101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E59F2AD0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AD418891C2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F51D0E26;
	Mon, 16 Dec 2024 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="YpEKWB77"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B21BA86C
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333610; cv=none; b=GiJNjZrhQTbxE3VrmKeHiUuc8PUQtMP9F5jRs/DLW5iPbUYCpieO8NRqm1Q61JsYf+PJS0zQI6PRYlT+bvn8ERSAv/6ZsAPVPXrzqsNwC7/z6PRxxoJ01AcZe5a/p45a9FRmNjpMY1EuzAUm3CHsq2r1bsxM5YONio6fo2dDh1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333610; c=relaxed/simple;
	bh=7H+b53eqi9DiOlmG0r4AJgg7nxrSVI5qv94MdpvGEik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHAGWVFoeZjTsSvB5vcdA6nEOyguehkuYh8bYNCmWQrYG4eRdNqeiyQsQYem9YhmHxedBL2ERo+ixpPUcTB+uYbD/K0yP2nt/OT5dRJEPFTisujmZvBBr0fVV4qtpQwzWxguHrit3unwoNseQdt2iLOKFdyz5dfLhRngUQpqyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=YpEKWB77; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53f22fd6832so4000932e87.1
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 23:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734333607; x=1734938407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A37fHc27Oue7tYt3kSCSnf+lK1Jrrg8n8kixoTW3puQ=;
        b=YpEKWB77gdtab48SF5Al3qjMsTEvgHwzYWUbj9SnB6h1TyqQKIxd+mcUPG6lVc1PIK
         OSh8ivpuIz3ae9rHDRzGy1Qjg3le4lx3x+fyVmaNZLsdN8GtI0/zcgzBYjAwDuKVebkB
         y/lu8Zulb/tpSz/+K4lc8oAfMrB6lTD3S0qiFj+68BnAGkgkuXcTeYS33lXGoRJGwm8Z
         T8rhgIuAYfBhe/F/7iUC4Qur5tFIRIJM49DmEF6goUDX0T2AFXJmWmHHuW4Wlreihqc9
         xKqq3rWfZqzRGlwFewhMKbfwh3u00urxAXLqnQ4kc19C1EgkI3z5vnrHo3KPmAwdoN8G
         yK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333607; x=1734938407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A37fHc27Oue7tYt3kSCSnf+lK1Jrrg8n8kixoTW3puQ=;
        b=ZRyWF1rCrQfNVNQ/BQXGFls/N0yLvyeo+Eays6YN7hLIESWpsc/S9TxYwrcllY8+d9
         NJjXsHeORUWOQ27hDESME2xD9roMJFxE161CpBZkY1Sut87xAz40wLP6JDGWjCMONBjW
         RmbE/NXdhTwu2//gcYaBBSO0syTJ3FUxjYDNhlGC91KZf6pvEYbAJVvpmeTkMjOQc025
         FqkPkDO58uf65Orib6Fy7A7VVPsgWHPsRw1PtvbAiZhKzwavJ38ZnoHze4hee/whATq6
         eB6WlDq7bcC8FqbPKk47sPvz/mdm3gcEdC3ixLbJHCq+nhpBmF9Spi3B2d8Ng0h20HtH
         mRLA==
X-Gm-Message-State: AOJu0Ywi3Ft7AG+p9CC3Vy0+FM/CSlJJyA8NgQzsJFk2C7cgv7trLXE0
	MiJKstIdoUhLvPBjcke2fVxkiv3lEt6hXr1NWLTdXZd5Wim8gb0p9wbWzjnw4r8=
X-Gm-Gg: ASbGncslSEc/o1bAxxHU0ODdOGlhHSg3nQRZ64o/fk5ShGKv6bYA8RRxjLPO9dOchUb
	RJtNK9fcVWxWRbCQdeli9T2RffcIgPP5j35qZuqlbdy4Zqki6eePCkST4vBxV65xSRfYkr413oQ
	R+5WeAREnVFeHKEElL6Cx3F4vY7+uYoSD1l6YpiBFnPSDBu7yQZU2d47PFAgTxQpUtYQmY52ZSM
	t7XPMU+GaBpVmkhoxX/uJLv/yd3Tgp3us1TeEqcby0QM1p07iFxZf/QND2JOZJyqGwXmto=
X-Google-Smtp-Source: AGHT+IFZevgraoAzerxr2hEHYj5Vn6YWN6RGjMC+XJAc2rFLiXryY0wNygBr6mROD0KIKhDpCjOFXA==
X-Received: by 2002:a05:6512:33d6:b0:540:1c18:4e23 with SMTP id 2adb3069b0e04-54099b6d6f9mr3446396e87.47.1734333607243;
        Sun, 15 Dec 2024 23:20:07 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9b2bsm748930e87.94.2024.12.15.23.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:20:07 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next v2 1/5] net: renesas: rswitch: do not write to MPSM register at init time
Date: Mon, 16 Dec 2024 12:19:53 +0500
Message-Id: <20241216071957.2587354-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
References: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPSM register is used to execute mdio bus transactions.
There is no need to initialize it early.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 5fc8c94d1e4b..12efee9f75d8 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1166,7 +1166,6 @@ static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
 {
 	rswitch_modify(etha->addr, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 		       MPIC_PSMCS(etha->psmcs) | MPIC_PSMHT(0x06));
-	rswitch_modify(etha->addr, MPSM, 0, MPSM_MFF_C45);
 }
 
 static int rswitch_etha_hw_init(struct rswitch_etha *etha, const u8 *mac)
-- 
2.39.5


