Return-Path: <netdev+bounces-68083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE69C845CC2
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABF9B2340C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD6D626B3;
	Thu,  1 Feb 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T4hsWUXW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121762174
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803882; cv=none; b=gvwLsuFvjBNVsHYwLaTmT01/QUSQESOEHLbAHfaHD730035k5HKVMw6ZZkjkmLWhWjpTb/RViLH9+zkkVx3jk1Ucj8y3XzwSfxGv3L8KdaA4/vveYxtN7J1aqISnWuSrI2Cz/1+1eO3zer0g270olU13ZDrcgM0EVRRzZW8EQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803882; c=relaxed/simple;
	bh=toAtsAYDJr62/SlzJEF/JPR/njCMzj58WbK9bgpFuv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3lHCrajY8Je94aH2myLPWvrRaDK2h363GuU984ulPM0jlBKjxJPYzb81eR61x86PseUY+tf4bHMVbiXexbCxGDA6GXpbSdwJXPhiOJ7zU+IQ1axZwGxWx95hiFrt71AYu1eWgEWWWERJd7xJ78wZByeTwhtqhZ+2mSVHfZJbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=T4hsWUXW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5110fae7af5so1529714e87.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706803878; x=1707408678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N8Ik3SYFkT9+X4quL9z3ncL7Fe3dfspMLXrHPzEbfm0=;
        b=T4hsWUXWC3oBRizEA74C7vZ3PiKWWhmDoBtbnPFItwzFjjcIaM4Y1aP7iYLaMdbb7S
         MjlS8qUftlbuANg7/vTVaryXyIsI7iXWj7MFTKCcdEkB8PwTCmhnyhEDU1u908r954+T
         8s/YU6mgJU7E8Sy9cEufDz8ov/VVMYY6euncd/qoFbcxecPrwg6vxtRvGFbGYMyuvzXk
         QkAXnrYakPlTO42kca3AlBOTFyU1g2Z1lAgcwzeH8t2GxIx+mSHuekANkknZyCdZg0ts
         YAGgExqTZGnLsAtO4K0ArsLWd102PS9o+FT0YqE+vPzyBTv1BYv/XbTkG6lHu2rqZGZb
         26Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803878; x=1707408678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8Ik3SYFkT9+X4quL9z3ncL7Fe3dfspMLXrHPzEbfm0=;
        b=wuS6v7J6drMkWgymZh/o8M0RJRCOxrG/CG6AHHRfnhpw2L5KvNWLNNmRO1m/Drdls2
         VkqPg4hjYxuIHFkVEcSrN7YRS2Wd3KcfxyEeA3N9swqLTm8x884UrEF9Rwn8uJabNT4p
         LeorViCsaJ0U98ZBAwGQZA1Rj9NS0v/d/B/HxVUuouNNfN+mTBv5rp5BPDE6YD2IqpHL
         vWRWVU2+DlpbNza3t3svSe7/ZPrtZkDz65QpwDYNV+dqmssoNq8AcHevt77zS4VkJjwW
         74qhXl/OcgDOt2aVVPs+52QWPkRehjadBarqfAmzCgYFsBwnE14ja6vd3ijFhXqZyYxi
         R80w==
X-Gm-Message-State: AOJu0Yw9LpNslJ+aoZbZlqPOVznJJ1mmjfIuuoKQ98Y0tWiHqlOz4QDm
	dOxvjvbXF8lkZ3zorJzWcHxn4B1jfq12TPUCer4dvMExt8QTCcJ+9oT/ehQPh7U=
X-Google-Smtp-Source: AGHT+IF91mAd7YaLZmhICPT5pGjrn6SdoDxaN3hspM0MLXITYizDEDuvkKni6M700Nb2wmJqqssKEA==
X-Received: by 2002:ac2:4ed4:0:b0:511:3144:4471 with SMTP id p20-20020ac24ed4000000b0051131444471mr1289084lfr.50.1706803878270;
        Thu, 01 Feb 2024 08:11:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW73+61JgHKJk7vA5p1WsCzcu8zeN30Nm54HbkOYhdAxQSexlPz+FHdLGwOB87sMlSD3Pxh5lr7SzZqixwp75Q4DozWtqfKX1FwZopx5zQTaJXyBnGEb9Sq1txIE08bRJklnZKgFdmMvcTjbjczrqCSdlOkFjgYj53goqzdkxbtu4pX9qP0QXNIcKo2QZygcz9uulukf9BnlziXKJ6o+UWE9w8A/17BkjMLQA9MOTzmyzS8Y/AM1n/6aEilN6WGz31qYVVoThwZ+bAYlOHIG6a4rtp04STF2uoOWEILUtB9WLk6uZS79sRQyGa6gm1oBQiTkVFFrgzXk/Bos/dbxwdyAXXGgSousjt9QHDL9abxM+4CkYRgCqg1AhBw62sUsyJMmpW/MLssZIk8Ilb0DWoXEKgmkMWjFJESjmY5IQ9xoBbDEBoIcl2nGwkmG4kEWUa+b1N95cuDHxjiw1OtP4yWNP+cPQ82kg65TUh0jI7YjozNS1+p3G4cuRO5c39FJQFAFBv9lj1p2/gf54EyuB8HReqgCcE3HwZJ+TRwsUUblBI770hXtzMqh1+KKePV3RV00huKaXOy5epmSkZMUP1bJO15mzXnIxKU7VLOOyDD3ngXEkFjO7IlJozvaKy0l0mfhI4a6wEOdQyLZ45TBgbrWyVhmvfFxLaadRlxNYOyaYCbX6xDHM0ndViq9fLOW2dsFLI/WOcGs91vij5Kef/cCkga2g/7gMeTTXlKEsmFiHejT1+5SoEjwUvIgUPP2V9LjDBmB+DGsOa3UFwwzR8jPvdE4XhyfjHlCCHAg4MTXPUJ61lm6JJc3XrgDJtLrRIMlRapeYZID832+Qq+lZrQlmYCq4zE4Mjc5Z/WCf0P35uSOV0h/GWg73naVTzbvAIMgnJ7BDAlvvxoVeCoXMi79oGewon6qxt0n5GC5MlDxZSgxg==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c420c00b0040ef9ffd3c1sm4721040wmh.19.2024.02.01.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:11:17 -0800 (PST)
Date: Thu, 1 Feb 2024 17:11:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.com,
	vsankar@lenovo.com, letitia.tsai@hp.com, pin-hao.huang@hp.com,
	danielwinkler@google.com, nmarupaka@google.com,
	joey.zhao@fibocom.com, liuqf@fibocom.com, felix.yan@fibocom.com,
	angel.huang@fibocom.com, freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com, zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v7 2/4] net: wwan: t7xx: Add sysfs attribute for
 device state machine
Message-ID: <ZbvCorTYXK1o_sdV@nanopsycho>
References: <20240201151340.4963-1-songjinjian@hotmail.com>
 <MEYP282MB26974374FE2D87ED62E14549BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB26974374FE2D87ED62E14549BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>

Thu, Feb 01, 2024 at 04:13:38PM CET, songjinjian@hotmail.com wrote:
>From: Jinjian Song <jinjian.song@fibocom.com>
>
>Add support for userspace to get/set the device mode, device's state machine
>changes between (UNKNOWN/READY/RESET/FASTBOOT_DL_MODE/FASTBOOT_DUMP_MODE).
>
>Get the device state mode:
> - 'cat /sys/bus/pci/devices/${bdf}/t7xx_mode'
>
>Set the device state mode:
> - reset(cold reset): 'echo RESET > /sys/bus/pci/devices/${bdf}/t7xx_mode'
> - fastboot: 'echo FASTBOOT_DL_SWITCHING > /sys/bus/pci/devices/${bdf}/t7xx_mode'
>Reload driver to get the new device state after setting operation.
>
>Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>---
>v7:
> * add sysfs description to commit info 
> * update t7xx_dev->mode after reset by sysfs t7xx_mode
>v6:
> * change code style in t7xx_mode_store()
>v5:
> * add cold reset support via sysfs t7xx_mode
>v4:
> * narrow down the set of accepted values in t7xx_mode_store()
> * change mode type atomic to u32 with READ_ONCE()/WRITE_ONCE()
> * delete 'T7XX_MODEM' prefix and using sysfs_emit in t7xx_mode_show()
> * add description of sysfs t7xx_mode in document t7xx.rst
>v2:
> * optimizing using goto label in t7xx_pci_probe
>---
> .../networking/device_drivers/wwan/t7xx.rst   | 28 ++++++
> drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  6 ++
> drivers/net/wwan/t7xx/t7xx_modem_ops.h        |  1 +
> drivers/net/wwan/t7xx/t7xx_pci.c              | 98 ++++++++++++++++++-
> drivers/net/wwan/t7xx/t7xx_pci.h              | 14 ++-
> drivers/net/wwan/t7xx/t7xx_state_monitor.c    |  1 +
> 6 files changed, 143 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
>index dd5b731957ca..d13624a52d8b 100644
>--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
>+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
>@@ -39,6 +39,34 @@ command and receive response:
> 
> - open the AT control channel using a UART tool or a special user tool
> 
>+Sysfs
>+=====
>+The driver provides sysfs interfaces to userspace.
>+
>+t7xx_mode
>+---------
>+The sysfs interface provides userspace with access to the device mode, this interface
>+supports read and write operations.
>+
>+Device mode:
>+
>+- ``UNKNOW`` represents that device in unknown status

should be "unknown", missing "n".

Btw, why are you using capitals for the mode names?



>+- ``READY`` represents that device in ready status
>+- ``RESET`` represents that device in reset status
>+- ``FASTBOOT_DL_SWITCHING`` represents that device in fastboot switching status
>+- ``FASTBOOT_DL_MODE`` represents that device in fastboot download status
>+- ``FASTBOOT_DL_DUMP_MODE`` represents that device in fastboot dump status
>+
>+Read from userspace to get the current device mode.
>+
>+::
>+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_mode
>+
>+Write from userspace to set the device mode.
>+
>+::
>+  $ echo FASTBOOT_DL_SWITCHING > /sys/bus/pci/devices/${bdf}/t7xx_mode
>+
> Management application development
> ==================================
> The driver and userspace interfaces are described below. The MBIM protocol is
>diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>index 24e7d491468e..ca262d2961ed 100644
>--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
>@@ -177,6 +177,11 @@ int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev)
> 	return t7xx_acpi_reset(t7xx_dev, "_RST");
> }
> 
>+int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev)
>+{
>+	return t7xx_acpi_reset(t7xx_dev, "MRST._RST");
>+}
>+
> static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
> {
> 	u32 val;
>@@ -192,6 +197,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
> {
> 	struct t7xx_pci_dev *t7xx_dev = data;
> 
>+	t7xx_mode_update(t7xx_dev, T7XX_RESET);
> 	msleep(RGU_RESET_DELAY_MS);
> 	t7xx_reset_device_via_pmic(t7xx_dev);
> 	return IRQ_HANDLED;
>diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.h b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
>index abe633cf7adc..b39e945a92e0 100644
>--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.h
>+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
>@@ -85,6 +85,7 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev);
> void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev);
> void t7xx_clear_rgu_irq(struct t7xx_pci_dev *t7xx_dev);
> int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev);
>+int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev);
> int t7xx_pci_mhccif_isr(struct t7xx_pci_dev *t7xx_dev);
> 
> #endif	/* __T7XX_MODEM_OPS_H__ */
>diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
>index 91256e005b84..1a10afd948c7 100644
>--- a/drivers/net/wwan/t7xx/t7xx_pci.c
>+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
>@@ -52,6 +52,81 @@
> #define PM_RESOURCE_POLL_TIMEOUT_US	10000
> #define PM_RESOURCE_POLL_STEP_US	100
> 
>+static const char * const mode_names[] = {

t7xx_mode_names


>+	[T7XX_UNKNOWN] = "UNKNOWN",
>+	[T7XX_READY] = "READY",
>+	[T7XX_RESET] = "RESET",
>+	[T7XX_FASTBOOT_DL_SWITCHING] = "FASTBOOT_DL_SWITCHING",
>+	[T7XX_FASTBOOT_DL_MODE] = "FASTBOOT_DL_MODE",
>+	[T7XX_FASTBOOT_DUMP_MODE] = "FASTBOOT_DUMP_MODE",
>+};
>+
>+static_assert(ARRAY_SIZE(mode_names) == T7XX_MODE_LAST);
>+
>+static ssize_t t7xx_mode_store(struct device *dev,
>+			       struct device_attribute *attr,
>+			       const char *buf, size_t count)
>+{
>+	struct t7xx_pci_dev *t7xx_dev;
>+	struct pci_dev *pdev;
>+	int index = 0;
>+
>+	pdev = to_pci_dev(dev);
>+	t7xx_dev = pci_get_drvdata(pdev);
>+	if (!t7xx_dev)
>+		return -ENODEV;
>+
>+	index = sysfs_match_string(mode_names, buf);
>+	if (index == T7XX_FASTBOOT_DL_SWITCHING) {
>+		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_DL_SWITCHING);
>+	} else if (index == T7XX_RESET) {
>+		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
>+		t7xx_acpi_pldr_func(t7xx_dev);
>+	}
>+
>+	return count;
>+};
>+
>+static ssize_t t7xx_mode_show(struct device *dev,
>+			      struct device_attribute *attr,
>+			      char *buf)
>+{
>+	enum t7xx_mode mode = T7XX_UNKNOWN;
>+	struct t7xx_pci_dev *t7xx_dev;
>+	struct pci_dev *pdev;
>+
>+	pdev = to_pci_dev(dev);
>+	t7xx_dev = pci_get_drvdata(pdev);
>+	if (!t7xx_dev)
>+		return -ENODEV;
>+
>+	mode = READ_ONCE(t7xx_dev->mode);
>+	if (mode < T7XX_MODE_LAST)
>+		return sysfs_emit(buf, "%s\n", mode_names[mode]);
>+
>+	return sysfs_emit(buf, "%s\n", mode_names[T7XX_UNKNOWN]);
>+}
>+
>+static DEVICE_ATTR_RW(t7xx_mode);
>+
>+static struct attribute *t7xx_mode_attr[] = {
>+	&dev_attr_t7xx_mode.attr,
>+	NULL
>+};
>+
>+static const struct attribute_group t7xx_mode_attribute_group = {
>+	.attrs = t7xx_mode_attr,
>+};
>+
>+void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode)
>+{
>+	if (!t7xx_dev)
>+		return;
>+
>+	WRITE_ONCE(t7xx_dev->mode, mode);
>+	sysfs_notify(&t7xx_dev->pdev->dev.kobj, NULL, "t7xx_mode");
>+}
>+
> enum t7xx_pm_state {
> 	MTK_PM_EXCEPTION,
> 	MTK_PM_INIT,		/* Device initialized, but handshake not completed */
>@@ -729,16 +804,28 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
> 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
> 
>+	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
>+				 &t7xx_mode_attribute_group);
>+	if (ret)
>+		goto err_md_exit;
>+
> 	ret = t7xx_interrupt_init(t7xx_dev);
>-	if (ret) {
>-		t7xx_md_exit(t7xx_dev);
>-		return ret;
>-	}
>+	if (ret)
>+		goto err_remove_group;
>+
> 
> 	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
> 	t7xx_pcie_mac_interrupts_en(t7xx_dev);
> 
> 	return 0;
>+
>+err_remove_group:
>+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
>+			   &t7xx_mode_attribute_group);
>+
>+err_md_exit:
>+	t7xx_md_exit(t7xx_dev);
>+	return ret;
> }
> 
> static void t7xx_pci_remove(struct pci_dev *pdev)
>@@ -747,6 +834,9 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
> 	int i;
> 
> 	t7xx_dev = pci_get_drvdata(pdev);
>+
>+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
>+			   &t7xx_mode_attribute_group);
> 	t7xx_md_exit(t7xx_dev);
> 
> 	for (i = 0; i < EXT_INT_NUM; i++) {
>diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
>index f08f1ab74469..0abba7e6f8aa 100644
>--- a/drivers/net/wwan/t7xx/t7xx_pci.h
>+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
>@@ -43,6 +43,16 @@ struct t7xx_addr_base {
> 
> typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
> 
>+enum t7xx_mode {
>+	T7XX_UNKNOWN,
>+	T7XX_READY,
>+	T7XX_RESET,
>+	T7XX_FASTBOOT_DL_SWITCHING,
>+	T7XX_FASTBOOT_DL_MODE,
>+	T7XX_FASTBOOT_DUMP_MODE,
>+	T7XX_MODE_LAST, /* must always be last */
>+};
>+
> /* struct t7xx_pci_dev - MTK device context structure
>  * @intr_handler: array of handler function for request_threaded_irq
>  * @intr_thread: array of thread_fn for request_threaded_irq
>@@ -59,6 +69,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
>  * @md_pm_lock: protects PCIe sleep lock
>  * @sleep_disable_count: PCIe L1.2 lock counter
>  * @sleep_lock_acquire: indicates that sleep has been disabled
>+ * @mode: indicates the device mode
>  */
> struct t7xx_pci_dev {
> 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
>@@ -82,6 +93,7 @@ struct t7xx_pci_dev {
> #ifdef CONFIG_WWAN_DEBUGFS
> 	struct dentry		*debugfs_dir;
> #endif
>+	u32			mode;
> };
> 
> enum t7xx_pm_id {
>@@ -120,5 +132,5 @@ int t7xx_pci_pm_entity_register(struct t7xx_pci_dev *t7xx_dev, struct md_pm_enti
> int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity);
> void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
> void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev);
>-
>+void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode);
> #endif /* __T7XX_PCI_H__ */
>diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
>index 0bc97430211b..c5d46f45fa62 100644
>--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
>+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
>@@ -272,6 +272,7 @@ static void fsm_routine_ready(struct t7xx_fsm_ctl *ctl)
> 
> 	ctl->curr_state = FSM_STATE_READY;
> 	t7xx_fsm_broadcast_ready_state(ctl);
>+	t7xx_mode_update(md->t7xx_dev, T7XX_READY);
> 	t7xx_md_event_notify(md, FSM_READY);
> }
> 
>-- 
>2.34.1
>
>

