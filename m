Return-Path: <netdev+bounces-61280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 825628230D2
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675CAB234F3
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624971B270;
	Wed,  3 Jan 2024 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkvGtLpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613E1BDC3
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so393821a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704297128; x=1704901928; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STGARIPibttUnVv5z6v+OiceOQgEk3wgse6FH9PSdgk=;
        b=KkvGtLpukFOp/Nz4IxrYqVXZ2gc40YTiszFnhYDnF9hNQwY3yznYrgSkPVjQ/IvLix
         n3IZjXXJNKKlr8CL5oAVfo23sGMhubj7s+mul2HtRGtBQ6SshSiXFaeys4xrSB1VQQaq
         C+g+qw/Mm64B1hOTrEG/QKJQES0a6fqzoEnz3/qXJAC/LpsjC0MzcXnVX/OfFFeK7jFH
         o8mSV6S/MMX5Xt4EFTxufK8IGAhhkg1/ESezpsWkex2X+2PfCKs8mftInQlbRnKXFvD3
         voXAfV74oBJqIJpQ1CpQ+zGQPYrAi6ZMWRypedTRxQCWeMQ2YcdAox9KmwAPDv0sfRZG
         ln8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297128; x=1704901928;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STGARIPibttUnVv5z6v+OiceOQgEk3wgse6FH9PSdgk=;
        b=b6NOFUr8ikXwWyymGzHCKSfboaXNFwPH150Os6g69IJyN+FT5gtk04VhCq7GzQ4yy1
         b/LPcSH1BqawFO5PuXeEA4eD+B+VewzXgapHWAb0oQx/Wf2M9dp7bKJwtgtRws26hwGK
         2CeWtWZ7JgUXi1J5sK3uGCr5cDt1yOdsJ/gvfpAdUhEfVJpgmRdATzcxf4xWVjqGwRl1
         YgyF6eu14zNZm/R2vxo18dgAyoprhVEeHqqbFb+sqyGarBzPoRA0diXCq7MqdxVWa1z9
         hBHqEaOnLC5/ygYDccyoF/KM7rYG9hi9POxdVF6peh0VRnUK0OsAXsMCHoM8WqcF7b+m
         NweA==
X-Gm-Message-State: AOJu0Yynr2sIoVnYJCTaiVs/BIUtzup6ZfnaUlf97hCxuw3OsHsBht7x
	wt58XWpZgS19rmysevZzgYJ+YfaftQ8=
X-Google-Smtp-Source: AGHT+IGrX6EuYWW/a3MhpNvFrtNMogjTNmMDvUbBSTR0f6lcqW8FsQKxI/r6Fq3OrTWJ6f+9RzjicQ==
X-Received: by 2002:a05:6a20:6a21:b0:197:60cf:a838 with SMTP id p33-20020a056a206a2100b0019760cfa838mr1548016pzk.1.1704297128099;
        Wed, 03 Jan 2024 07:52:08 -0800 (PST)
Received: from ?IPV6:2a01:c22:7399:5700:b8cf:27e9:e910:c205? (dynamic-2a01-0c22-7399-5700-b8cf-27e9-e910-c205.c22.pool.telefonica.de. [2a01:c22:7399:5700:b8cf:27e9:e910:c205])
        by smtp.googlemail.com with ESMTPSA id m20-20020a635814000000b005ab281d0777sm22522600pgb.20.2024.01.03.07.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 07:52:07 -0800 (PST)
Message-ID: <d055aeb5-fe5c-4ccf-987f-5af93a17537b@gmail.com>
Date: Wed, 3 Jan 2024 16:52:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: fix building with CONFIG_LEDS_CLASS=m
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When r8169 is built-in but LED support is a loadable module, the new
code to drive the LED causes a link failure:

ld: drivers/net/ethernet/realtek/r8169_leds.o: in function `rtl8168_init_leds':
r8169_leds.c:(.text+0x36c): undefined reference to `devm_led_classdev_register_ext'

LED support is an optional feature, so fix this issue by adding a Kconfig
symbol R8169_LEDS that is guaranteed to be false if r8169 is built-in
and LED core support is a module. As a positive side effect of this change
r8169_leds.o no longer is built under this configuration.

Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312281159.9TPeXbNd-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/Kconfig      | 7 +++++++
 drivers/net/ethernet/realtek/Makefile     | 6 ++----
 drivers/net/ethernet/realtek/r8169_main.c | 5 ++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 93d9df55b..03015b665 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -113,4 +113,11 @@ config R8169
 	  To compile this driver as a module, choose M here: the module
 	  will be called r8169.  This is recommended.
 
+config R8169_LEDS
+	def_bool R8169 && LEDS_TRIGGER_NETDEV
+	depends on !(R8169=y && LEDS_CLASS=m)
+	help
+	  Optional support for controlling the NIC LED's with the netdev
+	  LED trigger.
+
 endif # NET_VENDOR_REALTEK
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index adff9ebfb..635491d88 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -6,8 +6,6 @@
 obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
 obj-$(CONFIG_ATP) += atp.o
-r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
-ifdef CONFIG_LEDS_TRIGGER_NETDEV
-r8169-objs += r8169_leds.o
-endif
+r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o
+r8169-$(CONFIG_R8169_LEDS) += r8169_leds.o
 obj-$(CONFIG_R8169) += r8169.o
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c6492096a..349afb157 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5356,11 +5356,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-#if IS_REACHABLE(CONFIG_LEDS_CLASS) && IS_ENABLED(CONFIG_LEDS_TRIGGER_NETDEV)
-	if (tp->mac_version > RTL_GIGA_MAC_VER_06 &&
+	if (IS_ENABLED(CONFIG_R8169_LEDS) &&
+	    tp->mac_version > RTL_GIGA_MAC_VER_06 &&
 	    tp->mac_version < RTL_GIGA_MAC_VER_61)
 		rtl8168_init_leds(dev);
-#endif
 
 	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
 		    rtl_chip_infos[chipset].name, dev->dev_addr, xid, tp->irq);
-- 
2.43.0


