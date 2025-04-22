Return-Path: <netdev+bounces-184915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DFA97B15
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458CC3B21C5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96510219312;
	Tue, 22 Apr 2025 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EHl3zASB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BA1F151E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365018; cv=none; b=VrKlUFZ+8Y/nboMG1CEbViFp4rO5Wv8BeDukh6QOFEPiMuNqbAdxPRstnFoO+HW0BMCYouJB70jl/dFUEcjPuWXGJTKxTQdlv+IjAAQGkaISg38LtS5X07RJsvvq8ojfYMk4efdGHdCdKEJ9wtMZZdyfeFqJPhYTzk7VOrUPVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365018; c=relaxed/simple;
	bh=0MajdxKyaHIVnsykLUzsIIxRjVd+bS7YJWc3wfIPbnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTDC3v8JlsrqsoZv7Ok7WIoUqtWbrMC+LKmSqwJ5PNI+BUbin38hf1VW1G4Xr3wNGiEUsYSgXZ7e+q+U7wtVznXwOiLMerjQXqKn9m8yT1PfPDM127onJCtdl5nMA5dLnbR82aAQsTAE5CB/kJ5laj2nJdjAVCrGhig2mDwkPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EHl3zASB; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-400b948600aso1555745b6e.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365016; x=1745969816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19MmXmxBI44zE/jRyZ1VAn2A08Wrh0byg1LURdcHnek=;
        b=EHl3zASBgJkRP+wChFGjg7L2ERIgcSK2FADVsUWWT//iGCV7UsMHIhTOinRn/lyWSn
         WrLwE4Tt0LzmnFs+JM8L5MK3IBE35igeP6I3dR7K0A3un1nCVPfsAWG59yNBNwEdO3j9
         /uAGGmgdhRqO9i32+icl8SmURNQU9h+/piRos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365016; x=1745969816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19MmXmxBI44zE/jRyZ1VAn2A08Wrh0byg1LURdcHnek=;
        b=Oi66qm8IBadqT9LOzDPN6u2dh4+ClQFTDGWi4/pH3LvvZ0HsfZ6Tfd7HYUkiT4U4j9
         lb4HVq5QHnoOB+Gg4cfOt5CaMNnviQX8ZK71Mi1HX7MUTKDLNXKjml7WV2jV2qDQRuQb
         Iz0Xl7AOUIaLOGDn0zeSv/PdgwuKUzunA3EJcYPsFg5NRTLpSzCqDwVXiL2jyvdgCVSC
         EC5uzpMpTCD1kxX3dMHhH9YSiVnQfcW9SRY4yjKxcOLNpPhb2hkhUi6Rt+8PSXnCohWB
         CG4+iy/RkgTVroMmQqNb0eu1+3lGudxfJMWPbRhQ8Tic8Uqte5/ncPDzY3bYHhUQPyeU
         SJJg==
X-Forwarded-Encrypted: i=1; AJvYcCXTMn5O+a74Tx23VA2o+phRfxRPzey1Hx9WWD7MEi3qriSz4d6VDViTmXr85DPLJKEWTilH8kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0xKYnUITmxQNTHKlXJfWDWLvU5me+LNtxXVOdw1J0vMCWgf4
	3uCJbWKfH58EO4NMkS7TlQK2ER+fLKODYGYQ1pO27O9Hbgz6h7tBUiyQdoq2Jw==
X-Gm-Gg: ASbGncueXr+ZHvxVatkswNmeh43deTpmoNwBZtXYnx+T0+RanzBT0m2HyWV+GfSECzD
	x8Tr9U4ebZE8DFYOE1CAI8R40Nk5VTkZY8aVz1f+WNlkmR8mO9aJ1b5Ebs8643ss12wt8JVC9Ao
	3bVavBlugKRQy7R7Bzv37tU3KY7kbKSlH7gug57lTEbu8sypp5feeNLWz/kFrZoXVYQzbAiy9g3
	jqoraQvAZd9PfVcPc8mKynUREdb+S/aloIXpvrgtY92WXorS8Lg/qDwuhmma5yygdcVduWxfemM
	txOOJKYiUkDfn+9TM245bpWvCdljPpKBrWBbxOsPc/4S+KyCpVqifi3ZxFl/1I6OHQWlgTYHlqn
	I8h8I/Dv40lwUWCIECl7hUwSmCNYr
X-Google-Smtp-Source: AGHT+IH06vBTc0L7af5hB6EVFf5tDdhSK0BUxpsN5jCB3IOqmEuUjMFYm/zDfvB6MsHT/vCjbkDUyA==
X-Received: by 2002:a05:6808:8305:b0:401:bcae:68 with SMTP id 5614622812f47-401c0a7bb43mr9951971b6e.19.1745365016087;
        Tue, 22 Apr 2025 16:36:56 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:36:55 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 4/8] net: phy: mdio-bcm-unimac: Remove asp-v2.0
Date: Tue, 22 Apr 2025 16:36:41 -0700
Message-Id: <20250422233645.1931036-5-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422233645.1931036-1-justin.chen@broadcom.com>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove asp-v2.0 which will no longer be supported.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
        - Split out asp-v3.0 support into a separate commit

 drivers/net/mdio/mdio-bcm-unimac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 074d96328f41..e2800b2e0288 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -336,7 +336,6 @@ static SIMPLE_DEV_PM_OPS(unimac_mdio_pm_ops,
 static const struct of_device_id unimac_mdio_ids[] = {
 	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v2.1-mdio", },
-	{ .compatible = "brcm,asp-v2.0-mdio", },
 	{ .compatible = "brcm,bcm6846-mdio", },
 	{ .compatible = "brcm,genet-mdio-v5", },
 	{ .compatible = "brcm,genet-mdio-v4", },
-- 
2.34.1


