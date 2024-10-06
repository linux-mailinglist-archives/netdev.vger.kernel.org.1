Return-Path: <netdev+bounces-132455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F05991C1A
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C01CB2216E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA5175D2C;
	Sun,  6 Oct 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeoeVDWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6DC165F16;
	Sun,  6 Oct 2024 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181741; cv=none; b=mQTes1r5FjeHzt6MvJxRKvr9Z0v+4dxI1vfFaS4q67C8lP1KDXQLKlCL5acXH4fnprDN06EbbEAda/XQkve4wrzZjC/C7txqI/l37PFonIVWQhQWXbqVFNtXluBLnSHj1yN7fG8e/WOlJNaaolxKtY3lTyZ+yxS9rihtqI+CEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181741; c=relaxed/simple;
	bh=1J3HkkjHl3tzny9aAzxVDp0YCbpSEdS4i7sgeMk1m4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDkFpM2vb+kq+dgcdaNKdPwZ4PGEzj3EbP7CQLf2Vv6Xi8bWSgMSWrcPrOTjYm1uPVmDkzBSIGZqSRcKQW4qXmP73EDpKyzrAPlq3zBmO6Udao0ia7KSGLvYRjkUtQBdle7S1TQ/1dnohu3wLuhQwBlZYtiYLqsYqN52ul3/Jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeoeVDWt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dee13061dso1118501b3a.2;
        Sat, 05 Oct 2024 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181740; x=1728786540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3q8IOuT6F3mrdk5yNzpUn2+azS++gVYdm1EhDfEdgI=;
        b=MeoeVDWtPX1rMI9CI7UMfODKzjeiEJWuUUbSWMU5mzgDvFtnjnDqKNkaL6nXQy9cSR
         dIo9NUT9wWSPHXqCWtHR+5u8Y0p47OFghG62e7sdyaM15jFAp5ixVZK0bEMnGKsn/sZR
         iQd3/RHpOZ2zxE5koy1DLhVNlQZ7coKdlEt8T5YSv/Q+1UzAY+1eMQSio7FCx47+PMoj
         JVZW5+EPMnycIrrGFfqAQOvTvkVKWLtIc4tUKmWKOe6w1Dnf3jK3Z4Mubjs565CETazE
         U7sbe1w+DHMmGH7O/sTBot80TDFUhWs8MsDtnYysd4bzqeow127CL/HdVP+3HUI0+aQu
         8pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181740; x=1728786540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3q8IOuT6F3mrdk5yNzpUn2+azS++gVYdm1EhDfEdgI=;
        b=nsSiolx1Lnb5ks4Den1mT4C0ZAT1AaMRMgbcHS4chMeA5RvcKVUCxCy8WPkIqnqgVS
         m9gdkLHFVdV7CIrUIbw7q0QOq9Z1ysGQqN+eRkojL2qgBYzBxeE7meSSkpAE15HFHcJl
         e2F1cjRHIN0taCedQClIxqeh0zml/tQH0Eg6g5/IC/D8hbjSc9ED+3YY7Ki2WVD+PBvl
         4QNO6aTJCXNqiSZ4a4LSXl1UGDt2vL0oeBal03uHd90DplSQW6fafwuaWaT8t/pMCRfz
         uWCYAXGDZuJSXjWj396+mUP26DPwwlXpdl49bIhVE/gYn3oIpVGZvfrS0Xxybg+nGuyF
         G+IA==
X-Forwarded-Encrypted: i=1; AJvYcCU21vy57a/UWwVzOXq/WQe2370ZiYmK+ggzHRv1U/NJVJMlqefgZZneBRG7i5u7zY4lcKfeDHCd/mIirIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLiRWndhHip8vcPmLQ/2LWkSM1OVfPR6wmnUJKHikMY0Nf5Dz
	d/LHSlQUwslHm0EunKRLJTe9u7hAKr2mHdHnPXI1qcYEegMzBmrOAPo8dw==
X-Google-Smtp-Source: AGHT+IGcQ78dWOeZDaCB01lY/jBzMOsSo/Q2GERF7zl1F1IIkk8aA5REdjnJT4ot01XNJLWeYyylkg==
X-Received: by 2002:a05:6a00:3a14:b0:717:9768:a4f0 with SMTP id d2e1a72fcca58-71de22eb62bmr13093755b3a.0.1728181739754;
        Sat, 05 Oct 2024 19:28:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 09/14] net: ibm: emac: zmii: devm_platform_get_resource
Date: Sat,  5 Oct 2024 19:28:39 -0700
Message-ID: <20241006022844.1041039-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/zmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index b0c46dfe95b5..40744733fd02 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -232,9 +232,7 @@ void *zmii_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int zmii_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
-	struct resource regs;
 	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
@@ -249,16 +247,10 @@ static int zmii_probe(struct platform_device *ofdev)
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct zmii_regs __iomem *)ioremap(regs.start,
-						sizeof(struct zmii_regs));
-	if (!dev->base) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	/* We may need FER value for autodetection later */
@@ -274,15 +266,6 @@ static int zmii_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void zmii_remove(struct platform_device *ofdev)
-{
-	struct zmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id zmii_match[] =
 {
 	{
@@ -301,7 +284,6 @@ static struct platform_driver zmii_driver = {
 		.of_match_table = zmii_match,
 	},
 	.probe = zmii_probe,
-	.remove_new = zmii_remove,
 };
 
 module_platform_driver(zmii_driver);
-- 
2.46.2


