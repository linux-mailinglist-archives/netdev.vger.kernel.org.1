Return-Path: <netdev+bounces-233241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A632C0F132
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81A014F56FD
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2883176E1;
	Mon, 27 Oct 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LlLW3+UP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A531619C
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579919; cv=none; b=eI5vk9pkaIOCAjOxKaH2eZr8cCQaRmL0ct8lYPs3KQGjXz+cYYe8N2kdAAK0r8rv8lg8PLWRJoyeLYp/UGCmwofHjp5Y8xW2UVJR83PifzuuLpjY7O42U1lIpJKdWNKfR38oai1aOYtn/6/ZmxJOMLhpEfFVqIk0nqG12zGeqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579919; c=relaxed/simple;
	bh=l9RtVNC5Fv9HEtVFzEnmdGSQ5TtnCI0n17QaytPVRuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MU4cbyxvfuPLLiOmRwLDHH+kDPHYg8Ktsvmu1ABW2J6acSv+QBnC8w+4R3HGJF7rChu+KwR9RzgsuXaQMJaOrrT2ZSRuGbwG1iElJ023r+gY+xqJ0bRbQ4FN1H2YjgKdS9tr2s9kqFgT8M4R143cr9bVcZ9sxZRMEhWnwrHkGlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LlLW3+UP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so29177795e9.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761579914; x=1762184714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+F6l0oreG7JTFMb6Sz6ExSU/mU3oVRcsO804GwDbowo=;
        b=LlLW3+UPRi1KYhTwqZ0LCfvUp3jVRc46PrvNQsVUjTwgLUQX0VrdAuo3QkeIZfMqiX
         jr3v2TNmwIYdOFxH3NiolvGVjqefMNfYzjYX2McVHaPl573T69NeAxtYfuWoRWARLzkk
         SPRsyYqDOAJziQb+7JBRlAjkoXmSxNl1CnWd79vDhrhXDd3BRlCyk4kGaq7ND8iyEdPZ
         1+eOUiuNEYNe3uO1d3MZUgxPrkOVSiXRzCRXIoPw0soM+1c2KdLruIK79RvMLpocex+G
         8PW91WO5UdkLw4/21sHpHc7CIaSDfYWV/ifgUKmvBlhTqeazfw15h8J6kZ753SQ1nIPO
         1/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579914; x=1762184714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+F6l0oreG7JTFMb6Sz6ExSU/mU3oVRcsO804GwDbowo=;
        b=Sytbai59Lbpo/qTZdmjtexRQcSsZbjDWLuF9qj6EH+bhtVlLQ8u18qe01VFbVVlOt6
         XeAR8xZ9ZYZ9DbKTsZcAJQVSNn3Ekm7zA/y7CseJuhZUch3h0acCKydDNZafbuXOeJiV
         Gs7BYaNx3/H4tHg0GCNftt49A+MqTEZHYOt+Uqpl1VTVA4HXDE2+/eNc6M7GrJxJ74WW
         t/EKqUMX4CdoAw8dtYoYXq0ftCC8gxQC5iPDXFPH7lZP/7aHYuqMoMi8iJFqmnEA0hGJ
         FQIjHBnAR3UBq0FtC+4UlLlTd/wf9u+jSqoV+ZY128DMp0E2LWrPTDfmH5BKjqqaWB5N
         BPdA==
X-Forwarded-Encrypted: i=1; AJvYcCUs51zhc+VJZmUhctSt+PEsubayQ2LwduaTOr+0FHu0L38L7mEMetY6MZxnRcE1AU/d19aAyuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVF2thGrjVQAglppJFlSjFHiSZmPvbishJji7nA85AinSPLHa
	RIyGdbC7yEx0eSFwUN7PAGT4UQkWGpQjZaUtv/7TPjzl6idu0UAce/QVaijqRqqdCzs=
X-Gm-Gg: ASbGnctQqbZp+w+Fc0R2pfPC8Vsw1dbrnSfx9e8VmL9ZAc3ADJ10AS+c/ItHdo5KXcQ
	GMLl7gJ2gSoOCKlWf0hIqA3gVatiH+oUVPDSyQx9jxHsL++D4MsJSxz2+7rQzWX3LPeO/NCoCeN
	E4zkk5Phz41prXecNBSNHNUol4WPpCvA/bbeQV4mFtQHi0zj1jj8k101ZF2ACDsAKMjbaVvzaOz
	PAsFO0fsuITdp75VzrZCBDSDdNN4seHfdl1zBGECV663A65WF8RWlmqmZ2JR38RBXyzOrNabdIv
	BFDTqov6JD4GGOh1v4QND+mrZjW9f6ta6TE2fUnAHJbd37NO80d3ntxdGxC4qgGA9+LDp8QNl6G
	Ctnv/1L6N2JpAYkHqALXM+m4OOMtrC9md6lRXlVSDDb3dfj/KnMseNsGfRIu89Unm6CwqIeY=
X-Google-Smtp-Source: AGHT+IHRGKVi5MN0KlmP/QWn9GK7Gt4IncDu1UnMNHIlVsLNKr3cmM9451HaPofTrSWpTuM98bmS9w==
X-Received: by 2002:a05:600c:45c7:b0:471:6f4:601f with SMTP id 5b1f17b1804b1-47717e30926mr964515e9.19.1761579914067;
        Mon, 27 Oct 2025 08:45:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1c6:7dde:fe94:6881])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd477d0esm138708045e9.0.2025.10.27.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:45:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 Oct 2025 16:44:55 +0100
Subject: [PATCH v3 7/8] net: stmmac: qcom-ethqos: define a callback for
 setting the serdes speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-qcom-sa8255p-emac-v3-7-75767b9230ab@linaro.org>
References: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
In-Reply-To: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=5Gxjb/17qAbEtiGjyBW7mjBpKziLG21U9VH1r3QiV6U=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo/5N8BBE1xELlKYS4ZKFTuPBcaEPIPgSxudZ/m
 3UORCOMzZyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaP+TfAAKCRARpy6gFHHX
 cmQWEADIxpsG6tmx74j0WRSxVrRH/JRNVBzM4zS/ZdSdSlQ4LxTy1mCDLEtm4Fi/6+WZ/SZiWXI
 1ZzMvymBFVn2D0iZPoYzpkAabamHrQrlQJe6noPUboVYrfR9EeQ+RKSVikMZ98pad0NLj2bT/Nd
 4a0XI3jAoeBjMPegufW4igZP+WeYXpxgIdkxP5b55+7iDHEpWwzDMAFklDLzMcQumr/YYWTAzD9
 mjGM4WGouN/jtGgNHac0Avwd5CJ704zorc5h0XENpiBH/YXCdg1xhJw5RkIUVk9lsQyWS86Hv/H
 P4OSHiq/vBYXZusrl6cMzGlolvc0S0PB4476vZC77MyWRhAzxLtSxRuM6CPLFVxDh7QLA3/kdmT
 iGGSDxGcgn6lvKEQGropggTfrMvRcxtQCSyScQ02aEw92XnTUtqE5sF/4o8R4DYIS6o2sd/RYFA
 eXK4HuFvPXD9fc3ykTGCtnvw+fkq35yCAxUFpNBpB3vgsIaRb3WV5CIS/o+IukZkU8YGX0bXfVu
 J3Plra45gnO0uIBzIJAGgU8uIyRtlqQM+BPBboMu/B9Mmm1UmgksrUDEMv3y36cJ74CwygQcivF
 fbOG3nv0FvGk6hBfzztxguJORGBB4Cepg2dnoMFUVeJK20HwbhY5inwbdsKL5uGhXchr63VTOD/
 KOj+W54h3X1BhaQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Ahead of adding support for firmware driven power management, let's
allow different ways of setting the PHY speed. To that end create a
callback with a single implementation for now, that will be extended
later.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index c25b4b4581f9cea6107a39f0bc6165be6955cc1b..840d44f052786a79b85d25d2181467aa96102ec8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -124,6 +124,7 @@ struct qcom_ethqos {
 	struct ethqos_emac_pm_ctx pm;
 	phy_interface_t phy_mode;
 	int serdes_speed;
+	int (*set_serdes_speed)(struct qcom_ethqos *ethqos);
 
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
@@ -644,11 +645,16 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos, int speed)
 	return 0;
 }
 
+static int ethqos_set_serdes_speed_phy(struct qcom_ethqos *ethqos)
+{
+	return phy_set_speed(ethqos->pm.serdes_phy, ethqos->serdes_speed);
+}
+
 static void ethqos_set_serdes_speed(struct qcom_ethqos *ethqos, int speed)
 {
 	if (ethqos->serdes_speed != speed) {
-		phy_set_speed(ethqos->pm.serdes_phy, speed);
 		ethqos->serdes_speed = speed;
+		ethqos->set_serdes_speed(ethqos);
 	}
 }
 
@@ -879,6 +885,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ethqos->pm.serdes_phy),
 				     "Failed to get serdes phy\n");
 
+	ethqos->set_serdes_speed = ethqos_set_serdes_speed_phy;
 	ethqos->serdes_speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
 	ethqos_set_func_clk_en(ethqos);

-- 
2.48.1


