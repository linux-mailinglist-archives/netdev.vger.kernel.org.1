Return-Path: <netdev+bounces-81616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597988A776
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8160F1F37975
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A70715F3E2;
	Mon, 25 Mar 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r1BtkEeS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB113158A17
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372648; cv=none; b=WkiW+FvvK885k+leu39s5x3oq2DEPyUTOXvDV6WyZkY7od7OP/GLio5aZ8cFWaYNdVlhPy48t8vmoLopJ1aPM3NLHJm1z7wlqvoHkhmALhpCjr0hFFvVPJtR6+kXs2XsXwclDzghRSA1j+M05p8VBD408fzgZ+LQmaWtuFD18og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372648; c=relaxed/simple;
	bh=nYwGcUeSu2lOGz0Fbu3qFb7BX7DjJR5EiBYQwBjfl1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TP4y6uPwHs5VHxUgAQf3jqtgFhKSGm9HTJfRzyo/TWYnYPyaZa4hg8aKipCTiU6RrZzKUmZETnm4gJGu9dB2Px1znaESql6wV3z9xp+k/6HVrrj+jpIUEcBVXCSJ9uUgawbXfwn8pGE6BGkG0T53oLRjcYs+DEMoe1TN8bRdueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r1BtkEeS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso3073553f8f.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372641; x=1711977441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q7lk+2TIXEIJZSxUoCWXqCmqzprQnmyhj7L+zSgmo8=;
        b=r1BtkEeSlKjiSt2MUfvytWTnMY2jEy7RElifeZbH0pqf9X8qlWyTdVVIN4jrWMvUPG
         fb9JJ6tdASUESlHb/67kPDQrqEspug01Gwf7tXhYcHFTZXP0BhXmYNuvIJrNeztWlNJc
         003smVOaGc5Fsw9/3fjC/snNanXrI9feA5GTVO4B0+QpR7/AmdOCMjPlFilU1oeTo9rA
         AoEdB2KFiVyIsitGH8JXhzcNF16PJ0+Otf1yYpunc5G9kKziu6KqhZZRWdB3OXP9gO6u
         ej3AqfSXBMOrqRRelOFxhpzl8O2Y8LdzpZFrm+XfZaSFVZGOg+0e5aS0ywR35SQAqzwR
         AdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372641; x=1711977441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q7lk+2TIXEIJZSxUoCWXqCmqzprQnmyhj7L+zSgmo8=;
        b=hsFYgIRqW7b+MWzs6nuANvphetk31eeK9RvhqqopwGCJfpg8sigx0nR/i/JiSaUGs/
         DoFoyljVmXD66gg9fzvzA1JEmRrQ1gK81fxgm7txFr2xFeMr+NsxPP4WpgtAE2+cdoS/
         59YumsyqpLMF/46pyeRDBCtyzvK9nmDc9h3NqZ+p/6Uu/4qmrMJieAKu+5QQZ26ecEMQ
         PDRAFTEafbP6xXP7D0vLoLQwkJMUEqQt8Iojyj0+cQWb/JVZPn33xnLlzHEVKZzy1VpY
         7dagKBZy4klJQTVnUfsKPXo7UqP/B+mFLIr+TtGgQL1QQC9chqM+BkumU+C+nwcM892C
         PIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW418yo8QRBS3jdepn+Bv80MjwGIljeSQJ0quHrHtIFIY7tOGgUqCSDbVrxTZWYL5iNDoHsQzv8ayOg1mGoOMSH/UTwoJ/b
X-Gm-Message-State: AOJu0YxEl8f0jTeX0l4p6/BD3mceucxubEKoGi/uI1btDpsFLeCeBPEM
	hq/AlWyoIr+oZ9VUNa1nQj5SnMsHk7HUM0i0GVUShTV6HnNsljMeoaA7/DQJnlY=
X-Google-Smtp-Source: AGHT+IEWAleZxrehHkAeog/CpCY+3Uky4Inx/OcRTu69F57KovJSV1TsaOT5odfmaMTbK0CJCnSfiQ==
X-Received: by 2002:a5d:6986:0:b0:341:bdbf:ce0f with SMTP id g6-20020a5d6986000000b00341bdbfce0fmr4644057wru.34.1711372640881;
        Mon, 25 Mar 2024 06:17:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:17:20 -0700 (PDT)
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
Subject: [PATCH v6 16/16] PCI/pwrctl: add a PCI power control driver for power sequenced devices
Date: Mon, 25 Mar 2024 14:16:24 +0100
Message-Id: <20240325131624.26023-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI power control driver that's capable of correctly powering up
devices using the power sequencing subsystem. The first user of this
driver is the ath11k module on QCA6390.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/Kconfig             |  9 +++
 drivers/pci/pwrctl/Makefile            |  2 +
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 89 ++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index 96195395af69..eb126225eb9f 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -5,4 +5,13 @@ menu "PCI Power control drivers"
 config PCI_PWRCTL
 	tristate
 
+config PCI_PWRCTL_PWRSEQ
+	tristate "PCI Power Control driver using the Power Sequencing subsystem"
+	select POWER_SEQUENCING
+	select PCI_PWRCTL
+	default m if (ATH11K_PCI && ARCH_QCOM)
+	help
+	  Enable support for the PCI power control driver for device
+	  drivers using the Power Sequencing subsystem.
+
 endmenu
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
index 52ae0640ef7b..d308aae4800c 100644
--- a/drivers/pci/pwrctl/Makefile
+++ b/drivers/pci/pwrctl/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
 pci-pwrctl-core-y			:= core.o
+
+obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
new file mode 100644
index 000000000000..c7a113a76c0c
--- /dev/null
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/platform_device.h>
+#include <linux/pwrseq/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct pci_pwrctl_pwrseq_data {
+	struct pci_pwrctl ctx;
+	struct pwrseq_desc *pwrseq;
+};
+
+static void devm_pci_pwrctl_pwrseq_power_off(void *data)
+{
+	struct pwrseq_desc *pwrseq = data;
+
+	pwrseq_power_off(pwrseq);
+}
+
+static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
+{
+	struct pci_pwrctl_pwrseq_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
+	if (IS_ERR(data->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
+				     "Failed to get the power sequencer\n");
+
+	ret = pwrseq_power_on(data->pwrseq);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to power-on the device\n");
+
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctl_pwrseq_power_off,
+				       data->pwrseq);
+	if (ret)
+		return ret;
+
+	data->ctx.dev = dev;
+
+	ret = devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register the pwrctl wrapper\n");
+
+	return 0;
+}
+
+static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
+	{
+		/* ATH11K in QCA6390 package. */
+		.compatible = "pci17cb,1101",
+		.data = "wlan",
+	},
+	{
+		/* ATH12K in WCN7850 package. */
+		.compatible = "pci17cb,1107",
+		.data = "wlan",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pci_pwrctl_pwrseq_of_match);
+
+static struct platform_driver pci_pwrctl_pwrseq_driver = {
+	.driver = {
+		.name = "pci-pwrctl-pwrseq",
+		.of_match_table = pci_pwrctl_pwrseq_of_match,
+	},
+	.probe = pci_pwrctl_pwrseq_probe,
+};
+module_platform_driver(pci_pwrctl_pwrseq_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("Generic PCI Power Control module for power sequenced devices");
+MODULE_LICENSE("GPL");
-- 
2.40.1


