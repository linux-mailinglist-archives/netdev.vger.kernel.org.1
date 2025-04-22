Return-Path: <netdev+bounces-184918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B74BA97B1C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68C43B2805
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3D21ABDC;
	Tue, 22 Apr 2025 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LQbpzP7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92B184F
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365025; cv=none; b=HIWGXYJoPzcjGIjSdn7ZEL3xmVCctLhLRLfFJ+5EOBbunYref1XjQ5U+Aex4oMpPK1btPqiC8catsUjfJ8DhV5OnRQPefKIp0+bZAvHI8HhDIOAXYbqA5JiDEifTFJESDCddbAfd6t8Ow3AMGLvDWotpZA6NSfoTUrkU/EUZlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365025; c=relaxed/simple;
	bh=egefmihvY7KvIWGw0oH3dkZJaryrd/Jbo1oPikiQ4Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t3HjeXbswdNmnhqe60Zn9KHjSLeJh53r/saupk09j5kMxDh2NDvqRW+dK2tCnJBba0n9Jen5ukahpZrYA0Nx0+yJXiojbHZ990iSSdcX9Vi0ABGC/rd7XOqVReD/aRBaJszMjR+pBE8xcIIpLc1UIqKafumTToOwCMgK8EdfuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LQbpzP7/; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fefbbc7dd4so3021624b6e.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365023; x=1745969823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjqcO+U/XyU4d+h0NFZpUVq/FQdh/OHM7nsYwloXxL0=;
        b=LQbpzP7/1VbtVkOhtyjcsFtf8+gfW4Gr1Kj2bdekJ1DAzOXjw280l2RlVbTX7gMExQ
         vR+D71SmABLan3Cw/WQ0e0j2H0fRd6APenVBgNAElBwipGI/rkXN6KSDIIdoB/1dghlR
         dszcgkNJJhh2oKj0Lb3x3LZM0LQoeh5vY2nKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365023; x=1745969823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjqcO+U/XyU4d+h0NFZpUVq/FQdh/OHM7nsYwloXxL0=;
        b=fj5iR009lm1OK6Ix/0RAAvoobMr3MQp1gwJWPrwC+jfYNDVdZcYi80YQsWwl8opwHk
         wojnohd0AiY40GeEmFNN/qPbeY0KT1Snqe8gOSG2VZHodKBPSMAvh0dvGgK1e9Vcu2nX
         BuYa7NRrLmq2KfiWvlGozakDrU5vDIpmdy6WBh9JoTWabjjHsUn0NJlwlLC4Jv2RhHWn
         CSO49ltrjKALI41nbnz8NvoNVrNmGm2v+reyVgSSbN6jQVwhun5PRT2Js3GrU/6yKUrH
         onXyMVnepGC5tVVpiU8tEMVg4WbquWqdgARnMBRWSund6aRsteDW56oyEO6KePaMPux6
         63xw==
X-Forwarded-Encrypted: i=1; AJvYcCXxsjNrGt8+MLHkpq1j3KFy6e67u6VPDj0X2MWsprOAdtYsHwxXci5cLo3n7jKR60UyIsuRnKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4OgQR4//nghfw0hH3fUg3Zbq93VytyqA1hTmxaenSrpi6mlV
	sTlo2jHVY97nEv1jfABC58mf9Nq8HChhQ6NXSgZ5suFc5NdGl3lDxfMuODdc0w==
X-Gm-Gg: ASbGnctnIKnnM5MTvzd1FAiGHjOeY9RwzK0GkeLnNWclHBM3Ep/i8pOzbJ4wtcK+t26
	iQvIZ/d/uaj+K01BbZaLFPxekn/rqWsVpdOUwEJ+OHV788mZjPI3y0WVNs9nexD3Do4+FnWJLzk
	ZdnMEF2oTEBsZ4jYzbL0l68gpe15vJ9PqQeNCz6gXmoothHiiTrKsDTxTVn1l3bkE9GTrkF3ISc
	DhJorxdHpRmJynsO4FhArYg4u1aMd5nUrLwy4LtvLvr/8dswYWyG/nRbExn8AA10NZwZWxQ5BRr
	nPoaf6+C5S67duJQyDphiIcgz5vNN/r0yCFRoIdCjTwu217tEVEdcS2RjVSBb/T0+CRJLt/X7i+
	Ey08IOvcHcQG4XB/T6g==
X-Google-Smtp-Source: AGHT+IH1oIIuIEXPzQd7SJBIxpIXXT/UNsQKeEcQVGstYqpBcYZng0qKt/x4BT0RLqWCQbQdUYJQhg==
X-Received: by 2002:a05:6808:6f8c:b0:3f6:a476:f7ea with SMTP id 5614622812f47-401c0c5125bmr11643037b6e.32.1745365022778;
        Tue, 22 Apr 2025 16:37:02 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:37:02 -0700 (PDT)
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
Subject: [PATCH net-next v2 8/8] net: phy: mdio-bcm-unimac: Add asp-v3.0
Date: Tue, 22 Apr 2025 16:36:45 -0700
Message-Id: <20250422233645.1931036-9-justin.chen@broadcom.com>
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

Add mdio compat string for asp-v3.0 ethernet driver.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
        - Split removal of asp-v2.0 into a separate commit

 drivers/net/mdio/mdio-bcm-unimac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index e2800b2e0288..b6e30bdf5325 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -334,6 +334,7 @@ static SIMPLE_DEV_PM_OPS(unimac_mdio_pm_ops,
 			 NULL, unimac_mdio_resume);
 
 static const struct of_device_id unimac_mdio_ids[] = {
+	{ .compatible = "brcm,asp-v3.0-mdio", },
 	{ .compatible = "brcm,asp-v2.2-mdio", },
 	{ .compatible = "brcm,asp-v2.1-mdio", },
 	{ .compatible = "brcm,bcm6846-mdio", },
-- 
2.34.1


