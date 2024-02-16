Return-Path: <netdev+bounces-72524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A128585875B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340651F214C7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DBA157E84;
	Fri, 16 Feb 2024 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="V+le+COp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4871552EA
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115626; cv=none; b=GA5QQTzviV49ZEvSVVFoERVsVObTZLunP13CA4vFPwsBf6Dmdbd/0LvJb0bpLervrE7p7noHy5veNavsRHEcMmfDCS5dC0d9CkKn9XdA1s7u+uNWRhuuiZSCCYK8zK/PuVEUNEphY3N6P47woMWwEhsQpViyDRyPLnDdshd4QHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115626; c=relaxed/simple;
	bh=uljvXxVDpjLWioO7DI8DpfhUCiBQy2gqLlZzbqfC6rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6krigyui7SwqOXD2iAv1pd3p9SUdJyoMbZgxo4F1LCDWGLgNXAHQgUZHfZVd+MFSy/dc1qGtxGWbWllhv203ImO0PqpdBnltbaVJeIE0oINGMbyqctaEePQTDiK0NeYKldfLDPDKq7tMxihEb1t82OgbBONFQCT38VtJ6Bc5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=V+le+COp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0d7985dfdso34410921fa.2
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115618; x=1708720418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uwXThQ+QNJ1YUcFKYkH+xTMKxSP1HSsH1gWvVHVIOI=;
        b=V+le+COpES3rzhzVkrdn4DxtzXuOAw0tE8JdWra0ezkowznSetxsc6HeplrfocJW3m
         1ZP6ZL1oY8BKpW1yfY1VqifVkhhLXTAcw+dFeKVcskePCazEzV/ysTSMBzfjRdZfMhtO
         lIKtosZX71EB32XBCC2XYDGobjcLO6xoJGFw8I9/bK3qHLdWjKYHIYvT4Lx9KJqJ+Bzb
         vUqQpahzE4iv4VdI/tfEEBhDEqTevGR6sL96gohZpeQ6XaQ1VrAF9DqC0omUU2PbIgwk
         Clk6Dq+UKJ5MWcDzf3f2HSUHvvwW/ZQIulpmI3vHefhtqQ/e5E3KHrU3+nDAIbxQJwI7
         7+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115618; x=1708720418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uwXThQ+QNJ1YUcFKYkH+xTMKxSP1HSsH1gWvVHVIOI=;
        b=LOI5/xaTN4yIzglYFOVhcOG4fmLH0Zl2AoEcz+vcFyI8PGNGAyUwUYqezbawrJGXBx
         X9UMwBRHwbCDiePTujsD0R558bHK/6momEGrVdjNlbTCYUM1qSZTm5bfVF8aKnTWTGTs
         6NQHHERt71xsDCOnUsHA2hKx9lgaB3sLePP15aNPZpkMMvUHxeDWCe+Vr5LoaPEJInM8
         rldyiHqleCWELejiJOszTzwEjOi7/aXjUQcY/L/tCGdpjVmSbdebXANq1FLr/3oGGhIo
         a+UGUTKv0XPsyJOMb2maJqzjAeStuLv70BPrSTldZ1aL2kqnTd3e02Kw/f3Y43Y9G8Is
         Zptw==
X-Forwarded-Encrypted: i=1; AJvYcCXLfIBjaYK+YIYOjIvDfxmqBU/rmy9nvLLIJMXykQ9ILTZ6JAQEIq/h99kFdiRsNmxEhUzp/wK2Nbll0jUtjNaluuGkP9It
X-Gm-Message-State: AOJu0Yy1DMrmyps1xsp09dmywugCRYg9djlcO32jylfuPle4IgZHiSwC
	TUyv+X0gj8Othm0f2ymuj0ejVp5RlbjFDKD1WbbdwcBNSd3ZxfXkIfwSslpcelY=
X-Google-Smtp-Source: AGHT+IF7BFIzhFkzuOLkmprDQ2Up8MWLKknrN8msVe4koNW57AcePamcT2Ya3gh+sU9bXgW3MuxO5g==
X-Received: by 2002:a2e:a36a:0:b0:2d0:ffe3:db07 with SMTP id i10-20020a2ea36a000000b002d0ffe3db07mr4323626ljn.25.1708115618351;
        Fri, 16 Feb 2024 12:33:38 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 17/18] Bluetooth: qca: use the power sequencer for QCA6390
Date: Fri, 16 Feb 2024 21:32:14 +0100
Message-Id: <20240216203215.40870-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the pwrseq subsystem's consumer API to run the power-up sequence for
the Bluetooth module of the QCA6390 package.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index edd2a81b4d5e..6e747db30492 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 #include <linux/mutex.h>
@@ -215,6 +216,7 @@ struct qca_power {
 	struct regulator_bulk_data *vreg_bulk;
 	int num_vregs;
 	bool vregs_on;
+	struct pwrseq_desc *pwrseq;
 };
 
 struct qca_serdev {
@@ -1792,6 +1794,11 @@ static int qca_power_on(struct hci_dev *hdev)
 		ret = qca_regulator_init(hu);
 		break;
 
+	case QCA_QCA6390:
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		ret = pwrseq_power_on(qcadev->bt_power->pwrseq);
+		break;
+
 	default:
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bt_en) {
@@ -2170,6 +2177,10 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		}
 		break;
 
+	case QCA_QCA6390:
+		pwrseq_power_off(qcadev->bt_power->pwrseq);
+		break;
+
 	default:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}
@@ -2308,12 +2319,25 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCA6390:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
 		if (!qcadev->bt_power)
 			return -ENOMEM;
+		break;
+	default:
+		break;
+	}
 
+	switch (qcadev->btsoc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+	case QCA_WCN6750:
+	case QCA_WCN6855:
+	case QCA_WCN7850:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
@@ -2354,6 +2378,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 		break;
 
+	case QCA_QCA6390:
+		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
+							   "bluetooth");
+		if (IS_ERR(qcadev->bt_power->pwrseq))
+			return PTR_ERR(qcadev->bt_power->pwrseq);
+		fallthrough;
+
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-- 
2.40.1


