Return-Path: <netdev+bounces-183533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920BA90EDE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F406E1753E1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C913C24A057;
	Wed, 16 Apr 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="edg7ivuc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E263243378
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843711; cv=none; b=KYozWaSdrnI1RzQnj3MShzGQuM8GF3fwOfD7U5h9h/cDdimc4v8JMuIsko4aaqy5l2SfqAONToPnMd9f88LztliSFhU+oz6Z9Ly1P9o/tOvGI0hrHhBGVd3TXo3vHGVdj4Z+pLMolaZ317lvi/AmKhxdBGCwPMEyedmhuRg+7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843711; c=relaxed/simple;
	bh=eqyYaYWChMPmRU5DAc6y6TmudTWOOglC+kKHcnAeHRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNfskXkhwkzWb/BHP1S4OMIlb7m2gTIYhekeaJuXZ7r/SxM9EWDVT0S7r1Iq82bxKprjGkG8gXzDve8flnlAXdTIzBesy/C0NEEYlOe24+uht4Rf6Iwqq8tT5VD0FZgNsIPCb+PU8IDlXjyDpcrjSDY4p3CQP/dTWbi0mDUlFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=edg7ivuc; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72c7336ed99so47794a34.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744843709; x=1745448509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1M7OacyH/ahFd8hgf1tLeJiARoK46j4SXfIGzzZlOg=;
        b=edg7ivuc2DLIZnQkPDaSWafq8zlE+l1GMsDDD771vs/B7jvAoZOzp1bRwaHR8ZZpuM
         kQi/EkunQdzZv8b1X8l2+OGInV9pjECO9Nm1tgVbfpiaY5Vg5QaMtyjyJYz1ogEZI37z
         aKgkPAnsyxsCItbt2HVTX2+LsmAMFVQDR3ATQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843709; x=1745448509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1M7OacyH/ahFd8hgf1tLeJiARoK46j4SXfIGzzZlOg=;
        b=SdC9MpXPKTdAGtc7jLVOcMrWADIG7DcQIHkCA7T0yqdDvJc6HYzudGGU0hJEjBZPBc
         Ebm5e3WyCnUHbZUVpArJoXxsS6yrTvzjwMAX9vbkmvIH+WEFylszZQWsSBG5mghqHjPd
         pvL8t0Ml5OaFvL1JfdsEUoXauyv8aMqpCH+tnPceqUfKGavOsinS15+/Hu6quAfr9oY/
         QluWHI8oIFMKg62C92u2ftqI0fumOvm7lKIMFPp0wdiGWrmMyynwSTlSmKoMfwWgRfhL
         0nLZMkmURF/WwKkivrF70P1lvJQxA8UIOrIKStNVjFSM7hruEXnALoTCt0Xr5/+FQnUL
         uWpA==
X-Gm-Message-State: AOJu0YzsElYJG+VJY3sy9t+3jqWAFYnwzr9eCU1E6NhUWCY6PkhG0NpB
	jS8Nrs/97+tss/vNeFa5FKj3qukJ9UicJT22HtQ9XbBB+Fvd4wWkL8s0egCd1NqFX/wMoopQWOg
	ehmsXxkqBCAlzqNqM9SU4mxg0u5Sjc/DGObVd++Mj8uPz0iTyuvhMkeOGMR1Sfe240cgn0ckHSs
	ccqu4d8tIlEiOe4qvB0B45VAijaxanEdIeV6slgqw=
X-Gm-Gg: ASbGncvb78nnX+aHfkF0yxpOQnSu8QyqMm0hSn0Ezm8HTix3eapghhbWPBxGr8Y4Frn
	cB/BUUixqU8zJ3Vmd6JObYX2KdYvlJw+EE3Zymj2pokNErNt73E6JGFTNmC+FE6h4tJHMX05ov7
	03evaMdcIXhWNwb0E4K49rk8MjBVKSGrJ4XP8PH7BxJ8Jz07FM1W5NihrW1Sq5HQogY/kUSELp1
	XXMrNoXbHuMjtzFe3X9tqmz1TuFJc+T6J8Een8Npxqnd3zwIG7UMQlGkMDY25ruOWiZHS1Gz8FY
	X9D6siqnoqXQO2saAqF86uTq4l1okQu48XLTwMI88CfdzfbBQd1l7yOHzBxb9LNwY2KlUz5oAiZ
	8/TgRXR6M5eHN1SpGuA==
X-Google-Smtp-Source: AGHT+IEr3rp6o3U+5Le2wh6aSpiLtCjtqa8QZlb5yvodqDM7XxmooWxghWU11yhXt7iXnPux3PQ2Rg==
X-Received: by 2002:a05:6830:2a8a:b0:72b:b8d8:3995 with SMTP id 46e09a7af769-72ec6cdf37cmr2352252a34.19.1744843708919;
        Wed, 16 Apr 2025 15:48:28 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d71813sm3015956a34.26.2025.04.16.15.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:48:28 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
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
Subject: [PATCH net-next 5/5] net: phy: mdio-bcm-unimac: Add asp-v3.0 and remove asp-v2.0
Date: Wed, 16 Apr 2025 15:48:15 -0700
Message-Id: <20250416224815.2863862-6-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416224815.2863862-1-justin.chen@broadcom.com>
References: <20250416224815.2863862-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mdio compat string for asp-v3.0 ethernet driver and remove
asp-v2.0.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 074d96328f41..b6e30bdf5325 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -334,9 +334,9 @@ static SIMPLE_DEV_PM_OPS(unimac_mdio_pm_ops,
 			 NULL, unimac_mdio_resume);
 
 static const struct of_device_id unimac_mdio_ids[] = {
+	{ .compatible = "brcm,asp-v3.0-mdio", },
 	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v2.1-mdio", },
-	{ .compatible = "brcm,asp-v2.0-mdio", },
 	{ .compatible = "brcm,bcm6846-mdio", },
 	{ .compatible = "brcm,genet-mdio-v5", },
 	{ .compatible = "brcm,genet-mdio-v4", },
-- 
2.34.1


