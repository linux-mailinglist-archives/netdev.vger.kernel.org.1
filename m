Return-Path: <netdev+bounces-286663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKEDBV3hAWq1lwEAu9opvQ
	(envelope-from <netdev+bounces-286663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:02:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED450F8F0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38F55309F49E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2877D3FB052;
	Mon, 11 May 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZxQ5kuP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515738F247
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507855; cv=none; b=P54ra6v9rpqueGYhwFBGT2naot+UN0Irme+bM9YIw2PWcQ0jyIsC5DXDPuwcwXbih42Os+yPTCHdUKTZfMDsps3mZbJBQg+3bfmrZ0T5jBohXNLiGpodtzjLb6xueyEEP1W6OHu+pFNm+Xsz+iPl5wnxMSHXZqjJCNl5KuFKlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507855; c=relaxed/simple;
	bh=E1H1+nd/RwnK9LuWJGKbmqe8Wgfvhjt2SMIIonrseao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGU3lqNwXmBDsMT3KqmJQtE7hAV8vQ6Jvp/d2X1Zvn4CXgELVj9AAHEpFL4K+beHLEVj+J292JiGEd8WAx5UrTuVfOPt53AqOXVf7C/3qbAw+iimTyGOptK/qYKoa4jtgrYsE0SZC/2nN6u6g8ezCDXMlT8aeH6VFD8m90FTDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZxQ5kuP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so686686166b.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507847; x=1779112647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY8lqIlaX558zAJe1pNahwarYdn7KKAgYehteYdm61E=;
        b=EZxQ5kuPJDd822ELEn5XyU1VzeTw1w+Mjno0plhe6QQMrVl4pJkiu9MJGF7kX8Xo4l
         gvM7IsTcSy+siGPSHFUR3253RsEOXHUFH+obV8+28ygPaOsSLAnxoqts3fG168PMYZCS
         ALmmejwb4IxfNAMVXGTTK0UHND39pxpuqwy67e6qFOMIwDEhmvVYmI3gzBOXbL+okxDE
         SvHv1ML8ayH1IPCCpJZuTAzu2+FS2xu7RQ0KsGgAbHcX9vDjEesCGTtqIQRzhN5dXlEI
         6apD2MAkvfWbtQlWVHMWPJ9SNcVinNv0amZ6p8f0RGdzZaLGPT1Jq+6mmhQ1S1ayOtVZ
         2VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507847; x=1779112647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BY8lqIlaX558zAJe1pNahwarYdn7KKAgYehteYdm61E=;
        b=ehe7S0H0ypYunaXdI3Eo64YSKIsr6RzgjDkVEvOxnrXh0NsR3hsMsjWmyt3KSdrSqr
         /98w2krs2AILI4PXEzvwuUoYjW7+G9VmKKfgt/3I50MaM3ZLxJ98CbltSfZfEUgaL4mz
         2Mz4uTKMSkMs++rqvjDODBL1vw0iwY3aPy/dk87r0nH8ZRHEwVs+5ezAXuJ7qmG+OsXC
         xYq33aRG7lgHYVB681KEIb9CZ00ODdy5FG4X/7M4AC6U7N2rGT8Q/XbQ6HqF1AatY882
         fCWF1D6X6HhgpbpsqN4XGgbGzWji6itMgafh1OnZRUys+RXQa+Gif/FSFYLeovS0d68J
         0tZg==
X-Gm-Message-State: AOJu0YwIVgW4tNJ1U5zSjJpCdL4ew+5u/32TZmyD54MBxyjnqskcf6nU
	7ZR5T811Mb1r0wmLszJ513pEj1srWAUWoumhLzYOeWJhFGI7YTSoKoFA
X-Gm-Gg: Acq92OE9YdaRgJiuwR5e/4MfNbP/ArceQjCeh5DhW6Jy6fLqumTueAa+MTRhabUDyaj
	T+8BmeZF1rNz7+saAdvU9qm7p/LssVEGyk0wRtspzHNdArm/zcXkte4OAAK8urLWFi1zcvzEf4t
	TluTQtxo6nPa+9V7rPNa/4tt7NuRaqKnjNBfjCwal5ehrYyeIFQ1ZZqS1vBZom0OYnYaOSM6RGn
	t3liWU8j+aLA4LBo+ivVV3iiZpKxMwy6EAmTTXImZhfwxRw6uEbx975HnoKInZ7zFJIYyaFfc+I
	W5KJI57kgDip9nAuY/DCknOQg0DztwVDePshXKNHJPNG0anuJ0ulO7zqPhTU66cGUXXDcdqJLB7
	3K1RStm3tOOUhoBeOlZuXlVyl/cMGijE2g9otNwHMslyasxM/ghPRCiHeocOo5TYm5kgk1ybSBA
	fCVylamdPjU9JS
X-Received: by 2002:a17:907:fdcb:b0:b9d:3e5e:fd32 with SMTP id a640c23a62f3a-bc56a6498c3mr1324021866b.8.1778507846254;
        Mon, 11 May 2026 06:57:26 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3b904sm3685357a12.1.2026.05.11.06.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:57:25 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Chen <peter.chen@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v1 2/6] usb: chipidea: tegra: Avoid controller/PHY init if bus is externally controlled
Date: Mon, 11 May 2026 16:56:57 +0300
Message-ID: <20260511135703.62470-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511135703.62470-1-clamor95@gmail.com>
References: <20260511135703.62470-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BBED450F8F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286663-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,nvidia.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

If the USB controller and PHY are externally controlled, then the
registration of the controller and the PHY initialization should be
skipped, since these configurations must be done by the device that
controls the bus to work correctly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 36 +++++++++++++++++-----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 372788f0f970..593390a818d1 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -32,6 +32,7 @@ struct tegra_usb {
 	struct clk *clk;
 
 	bool needs_double_reset;
+	bool externally_controlled;
 };
 
 struct tegra_usb_soc_info {
@@ -312,20 +313,25 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (device_property_present(&pdev->dev, "nvidia,needs-double-reset"))
 		usb->needs_double_reset = true;
 
+	if (device_property_present(&pdev->dev, "nvidia,external-control"))
+		usb->externally_controlled = true;
+
 	err = tegra_usb_reset_controller(&pdev->dev);
 	if (err) {
 		dev_err_probe(&pdev->dev, err, "failed to reset controller");
 		goto fail_power_off;
 	}
 
-	/*
-	 * USB controller registers shouldn't be touched before PHY is
-	 * initialized, otherwise CPU will hang because clocks are gated.
-	 * PHY driver controls gating of internal USB clocks on Tegra.
-	 */
-	err = usb_phy_init(usb->phy);
-	if (err)
-		goto fail_power_off;
+	if (!usb->externally_controlled) {
+		/*
+		 * USB controller registers shouldn't be touched before PHY is
+		 * initialized, otherwise CPU will hang because clocks are gated.
+		 * PHY driver controls gating of internal USB clocks on Tegra.
+		 */
+		err = usb_phy_init(usb->phy);
+		if (err)
+			goto fail_power_off;
+	}
 
 	/* setup and register ChipIdea HDRC device */
 	usb->soc = soc;
@@ -342,12 +348,14 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (of_usb_get_phy_mode(pdev->dev.of_node) == USBPHY_INTERFACE_MODE_ULPI)
 		usb->data.flags &= ~CI_HDRC_SUPPORTS_RUNTIME_PM;
 
-	usb->dev = ci_hdrc_add_device(&pdev->dev, pdev->resource,
-				      pdev->num_resources, &usb->data);
-	if (IS_ERR(usb->dev)) {
-		err = dev_err_probe(&pdev->dev, PTR_ERR(usb->dev),
-				    "failed to add HDRC device");
-		goto phy_shutdown;
+	if (!usb->externally_controlled) {
+		usb->dev = ci_hdrc_add_device(&pdev->dev, pdev->resource,
+					      pdev->num_resources, &usb->data);
+		if (IS_ERR(usb->dev)) {
+			err = dev_err_probe(&pdev->dev, PTR_ERR(usb->dev),
+					    "failed to add HDRC device");
+			goto phy_shutdown;
+		}
 	}
 
 	return 0;
-- 
2.51.0


