Return-Path: <netdev+bounces-149983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B49E860D
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D901648AF
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36E015DBAE;
	Sun,  8 Dec 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="d1Iv4bpY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D714D456
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673168; cv=none; b=SzTNHBFLhBfkXJqowHBd4EbVs1kroKiGrz0pD4Xp10X/wA5B8qaO2HWOGu1LW4O3MBbT0z92RusuA3riq651+odOwmDYPt++oMXhKHK6FYgqRFi94qGta5Qd0uCAF7Wxi6REQcOnu3ljTBZF09xbhERwT9ScmbHqQPua0F/dz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673168; c=relaxed/simple;
	bh=pR239TJH6DkmyjLOOWJrEa9qa6lKwq6zBqCCU7HNb+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7aj8M9Td8+hn7j0UVRfGvs7muEBhlEXUWmUWeRNY97H6JP1J72QVVn3l7APfoCnEhRqr7+HtuoiKnCQ0jGRyiuWB0yiWrKBb03Ituf2CrG5mR+ZRLTh8V8GJFXNuBZHyxgR+1RZ81cOVh0LSj8V6j1mtZJqxbrnfJZqnHkyGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=d1Iv4bpY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so793496e87.0
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 07:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733673164; x=1734277964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM5DZdXZqiBry1GF0hiPMUU57y91Is3FbX9t5e3p81c=;
        b=d1Iv4bpYYgxKt8zGwpriFDplZs2LllAYlDDcdMvk+YGdmkeyc24NiIve5F85xmWY2B
         gGDjXGCL3uYJfGwbLxJvapUleLflyrW/AhZ35GbdiAIrPxJXzyUCjPFdVJWlx8FieEvP
         4NPSLDNFX1fnlRk7HNOJhzmYVsv6RjPubGHwSuYGaKegtEr8JkVhl6JVK+DoWZ3/Yd++
         uVoi76ppkhQv0h8fRHZNtom3fodCbWRadyntxgr82uEpM3LYsguzBnMzq1wb6b7Z6QJO
         dtxQsRvWVI9gPeytZS8XnbGY18/mOsj9FajuOOeYUDRjKF1PWm51HG3ACBPDTyQgXPAf
         qxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673164; x=1734277964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM5DZdXZqiBry1GF0hiPMUU57y91Is3FbX9t5e3p81c=;
        b=eaxdLo3/SdUutCgiBrsNRRDbr2MJEI849+jhS3tkzgrnp/y9660ZZ0bC5arFalAc6y
         CXXGF1jvF7jUqKXlDcK2DHcshunS6dD+c0g4RMOf90Om88zEAkJHIJvImGcPF/yRzjE6
         2Au7ckvpnt0Ue0bJQZyH1jUOEXfUlQpa/uXywoOe4P7A4cXggiC/9jeDEww6F/Ryn06H
         gCt2sWRJo/ttRUn2bihtCI7fx0zHqPTaUTAuXuUxUi9GOQPq9c4GQ+L/mHLKrcO98kJc
         hUjzjFubRlGll5B9+839AaiXt0k7Q5qwk6J7zyA06Q3ILZSeX4aoDobo4LrTQF7xaNbY
         85Iw==
X-Gm-Message-State: AOJu0Yy5pZ0RO3LWAeR4Po3x7nUb4G17qXjBPz/FJ7g1E2EZ2nNBgRqz
	c+iHEsu39X7EbHJuOGbfImNk4/x103j5gu6RrJX4/zEAjgZG7893YXCHfecCnRY=
X-Gm-Gg: ASbGncsh/0pK0rl613DQthlTnYBeV89Z1qnvZOft29PQDEPnfCdmaImy/4dkSqeuTo1
	6r68+iiv+jij++luWfPvbiYdz5djFpib4Vfl2m7vSZ6OVUwCdcQs/0iPxylUlXKfLcv9cnL9Y1d
	NgkR7T+k138zIgvwWITSghdUD0ZQkHGCn+BmBl879rr+ZnUBx7GfLC0+BxW+S9jlh96bMk7T23s
	Yt4SwxhXh25NXuqroLnlUdP1XxfBnNlDSOFyNo6BNQEmGgdukxceOfbhNyvIubh
X-Google-Smtp-Source: AGHT+IH0mhFJkzgTaRltbt/3f/uOZ0/C8ZdKxaDXSeoLslSVJ6jaMefU1FWkl1ufVYiQ/d2eGcmVPQ==
X-Received: by 2002:a05:6512:2823:b0:53f:232e:31ea with SMTP id 2adb3069b0e04-53f232e3741mr1250833e87.54.1733673163671;
        Sun, 08 Dec 2024 07:52:43 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a1ce70bsm580882e87.66.2024.12.08.07.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:52:43 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH net-next 1/4] net: renesas: rswitch: do not write to MPSM register at init time
Date: Sun,  8 Dec 2024 20:52:33 +0500
Message-Id: <20241208155236.108582-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
References: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
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
index 8ac6ef532c6a..57d0f992f9a5 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1139,7 +1139,6 @@ static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
 {
 	rswitch_modify(etha->addr, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 		       MPIC_PSMCS(etha->psmcs) | MPIC_PSMHT(0x06));
-	rswitch_modify(etha->addr, MPSM, 0, MPSM_MFF_C45);
 }
 
 static int rswitch_etha_hw_init(struct rswitch_etha *etha, const u8 *mac)
-- 
2.39.5


