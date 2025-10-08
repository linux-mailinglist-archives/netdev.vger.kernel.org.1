Return-Path: <netdev+bounces-228177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E26BC3CDC
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231F74050E8
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E02F7443;
	Wed,  8 Oct 2025 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nVhXnqOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E062F618C
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911498; cv=none; b=fW1E9q/wZ79zb6uI1DlCX4sSas6fNo2NA7MLbtTG51h1Qykn9eJU2F8OJ06Yo2nlzyUGrOpQBk2jYJKPJeHTYTqiXfR6WzRkY0o0wfrR+/NdEk+htOSs4CJ4ZQPVFbfA2Di5DSRTMqs4IoLEQZzqdfVOKMNzx+qMm24+VA91uws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911498; c=relaxed/simple;
	bh=NKTMPnPBEN3JCEgCuFzVlb6Jno24tg0DVRR09XWDb2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQrydwUgPUfgYALZK37xdRFu4bHJSuvR3zJ82ayD7fnVolcWGU3gl8Te6ReRRJ3AyOY9OdqE06WR8Z2/SMfcFOyIRCbg3L583z6V3MPp6XuKBiMGDMmeWYdKjKECIiSgdCOvOwo/Hk6J/HBHglAzZYPZhVUJCSkWK/8SinmFw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nVhXnqOj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso56944715e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759911494; x=1760516294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdoEjc5e7kQwXoL1Cm6IjPM2seG7Imvb9wLqalhk7Jo=;
        b=nVhXnqOjvumo7MCZjiCJjJ5xydyx28mcU95gWIXkTYQLaloS+uS0lBvlSkkeu/kD2r
         sSJZeG2dOU6WNZ7PyAwDOGo4Sk3RHO3gW8lHGCPQ6bIPNVC6SHRz6E3zZ0IbGu1GzJ5k
         TKFC/5oZ02yg0Na2VgRVP1ZW/bk52remsoJN+KhhxDmBsPro+6Ui3MzzdFoIs5A9pg4h
         6LJVcVzRW0IeFa315l1LkezhpDUOJx/p0RM3WNKS2EQ56Ruv0A3eguvIyKBiWZ+QFcZH
         0ZNaxY3tsb5MzTCpKU4Uto+v5QXvaUnYVZiO77u/74Y4jhOKDzu0t93V2SXhLz8VkiAq
         QZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911494; x=1760516294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdoEjc5e7kQwXoL1Cm6IjPM2seG7Imvb9wLqalhk7Jo=;
        b=SxmFy8CHCOwWQ5RO9ivI3gjtLY8Bi5sc/Mg9cYqFb5uXOg03qK/QrMg1XmcwaYjwAW
         eZ1+JvYp3RqycCqDw1pVgUDL4SIpzpF6mMQtKlMWKKvAHy+wlxkZv0sS+sE3CPknemkb
         i/Qb1Q7VOxTkh+hmoeu/rMbIAdL0RXPXfJ5Fqk8qdjzs+I2Z85joWdOHZnOWPyL/QxFl
         Qgbc2xwPBl64FmE2XiTQnL5M6Zvaz9LSaH7GYks7Pn8De7yuIrSgH8wh3G1IDhT/CWgo
         XZCN+VQcN/7mROhnjwDPTxdprNzge7Z9gdVjNHDEdJpjWQiWEy7doATzWN/UWp7O+AQy
         X6fw==
X-Forwarded-Encrypted: i=1; AJvYcCWCmuiXvhcfrCSqlG5OTp6cb5CQzZWjN5XV16oFb3nUTncIybX/a7ZwWfaayailQMBkDDxmdTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYzD3TEnVvRyt3A0xLqqjY+QXGsnhNJfkVg9NsIyZ5u/F76qC
	SUxKVPPWo7LQHfKjq3YETGKTqW7eJd4QA4sgrpKqdmP6c+W+EWzn4RYw95GhzfUi++TWamZU80+
	+bCd/QOw=
X-Gm-Gg: ASbGncs4isijS9rFudIm83B7f4F5WT3MB1KA3yGTx0eahdQAEKzdLJfu3monXDJZXJC
	3qrDhOAA8nHfhox92rgC4gurcpVoiPJ7iK63GkjSFvj6OMZB0BP1uy2vTeUD9wignHf7rjgEWnv
	zy5qATjmzWf9WwtyN8v2ZijJH5SOq10bhnzqBMleyrnPblpLssmiP3B8gQBy6RRrN6a9Vnlzold
	5GTNF13lavs03T9UI3gZZp8huiqtb7xpbuL7RT8Mfuj4SreBTSOt0LLFxFWYrMYd2ZIiVhpRNkm
	sTmxzXEnPc/UmNJ9Ekaa5k44c5yxQpTVcf/iJ2dzBqWyfRciZqRWd+7NHoNXR8tPHgY9nSRrgi2
	Ifu7Dhi5jT1WpleQeP5FS5UWZ9igYFHujSJctHNdDSQNROacN+sj5
X-Google-Smtp-Source: AGHT+IGGV9RTxvTs6ChYk2BboL/91pz8TbAVWTDNgaDs9JbMT5f/sR8m26V513f/xADuHAv6BhGW0w==
X-Received: by 2002:a05:600d:4205:b0:46e:74bb:6f6 with SMTP id 5b1f17b1804b1-46fa9af914bmr14615105e9.22.1759911494198;
        Wed, 08 Oct 2025 01:18:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:286d:ff1d:8b7c:4328])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm28498943f8f.27.2025.10.08.01.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:18:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 08 Oct 2025 10:17:54 +0200
Subject: [PATCH v2 7/8] net: stmmac: qcom-ethqos: define a callback for
 setting the serdes speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-qcom-sa8255p-emac-v2-7-92bc29309fce@linaro.org>
References: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
In-Reply-To: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
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
 bh=xmsTTIN+xNt0moiTieLp775A3Rxh60igauD1SnixUA4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo5h424wYIOWx/QTIauQ0Xb0HiSiOu+mcvinaVu
 GhOkDp/gnqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOYeNgAKCRARpy6gFHHX
 cln8D/40P5o2ziTr4Wk7CJ0ckAfckinQriPZ81qAubZQawfXquU0f9MHcGxOVvpWRqeF8pQsvQV
 XSQsT51LnHQ9SZMfesP3vKY0QQaz6SKjkhiAoR2CKFM/8nkGzuRjt7oWYKFKbJVhwkJKAfK6tRf
 6/vUg0er/eXFIy/tXoe71+uRvAqTClesPLUXGcPLRpcGchrumTBYB5j4bKFN0DdQBuNJlp2QbN+
 0/gxygzyNpUtZwtdJLGN73TZSTSE1bVeVicT3tIIiYPIjCW1Lah0/IJL4w5Cp5qEiq5oiThfgjx
 /t6Eq2bUJ5kns+bSpzgVx3cHIMMdqf/Km/K2gUsyBPkW6VF9KvF3QObG17Nej1gxaOGRgDoFje7
 X3/68pKORhRcaflwwnlGIwWUK0BGsjQ9rAZ4OUMg+7Oz8mYGwlhKrI/Aq1Me6slet7SrbfBpkyf
 uEOYvdOLVFR/0WSifZVhrNABqZWtD/BBnanKxR8Rh5VGg3fki7Ev8jEDA364ubJkfYcKWt6O3bK
 q+ukAukJOQmZayqSjIyQ5gqU0j97tXkVuqONtZA0UGiFf7RvuodWy2AteLDVpbwXXmGRt8InpSf
 S03B2C+Ox/rniLc3eY+4YPs40szdtegi1bKYPhM0FIKWxCbL6B97v+vVxnMSPo7t9K2l0S2s0my
 bRm3rw809SJ/T2w==
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
index 1fec3aa62f0f01b29cdbc4a5887dbaa0c3c60fcd..2a6136a663268ed40f99b47c9f0694f30053b94a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -125,6 +125,7 @@ struct qcom_ethqos {
 	struct ethqos_emac_pm_ctx pm;
 	phy_interface_t phy_mode;
 	int serdes_speed;
+	int (*set_serdes_speed)(struct qcom_ethqos *ethqos);
 
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
@@ -646,11 +647,16 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos, int speed)
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
 
@@ -881,6 +887,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ethqos->pm.serdes_phy),
 				     "Failed to get serdes phy\n");
 
+	ethqos->set_serdes_speed = ethqos_set_serdes_speed_phy;
 	ethqos->serdes_speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
 	ethqos_set_func_clk_en(ethqos);

-- 
2.48.1


