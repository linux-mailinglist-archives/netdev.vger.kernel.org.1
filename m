Return-Path: <netdev+bounces-230683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60556BED284
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90C0B4E72FF
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F6226CF0;
	Sat, 18 Oct 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUcHPUlb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1537227EB9
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800926; cv=none; b=TSiid+Y8XANnZrSOsuNp6DxiyY4nEpQ1pj7U5BrAObX2uT+DgzQYKFGSexhRwNYonABWoJFhlOtgduI7VZTh9D/DifwXeGgUvbzy9VgbeOujj1Osuhn4YLtDBjWhnI9Yu7Axz3zhEbpb5fE+wVhEa/SyHAdnhv5kBAJnLRlrQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800926; c=relaxed/simple;
	bh=nzR01ZPksVG5TQ75xILFz5dk7YmAqDiwHTk56jUV8xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQ5KI5+RQBZIXv462cZr2e/PGpEbBsW9DqG72Zh7o0m0r+U0a91j1O0eO3hBNp0jvvdlxDN7oLmmON6nJANz+XjuPg3PVXPq3ByNc/ZMA+z+w2ZdNpbz3CPyegPBT4XN7U/loiGadEsxwbLc8qeXkcgqHU7y8/1YAgu+L9kdFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUcHPUlb; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b457d93c155so422016766b.1
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760800921; x=1761405721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=494+LdB+/vJI0VWXES/E84qAHGDNRCCpp6TfBFduueY=;
        b=XUcHPUlbD3mdSQgn4Blo3QlO03X3vd1PMP76898oGUyI/GHcw1uUUqPit9DETwiv0l
         qucKIFFLDjO+BtWdihyegCU05w9/dC6Yt5SLkrvCpdoWhbA/j7aH6oLvlRHs0NOlvySg
         XeqJUKyCkbVZN4xGSVBiC/sYFwMXYgvayPmPSfHdf8haikz0ycUj7Z901mXUnFGms6E5
         omp86qBaCRAshmvBsTi9b78zgMgndQzmRD388Jicz5ssIuW5gTiPwwjDmlGibSM/Wr8a
         Rip2mR+yvxfz0CpAiLnzC8K1lMjXWBOggSDT/8+4Tv1WtSluRcRGr14TNWmp0EtNFSSg
         ZaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800921; x=1761405721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=494+LdB+/vJI0VWXES/E84qAHGDNRCCpp6TfBFduueY=;
        b=CHdJCJyfWPUBlaG3PGg3Kp8i8+FR6YWERZXLVInB4dngaiPSjBcBuzGIN8yqHVPm3W
         iwcBv8f+b+6ZYErVq6SyYTeqmjVMffhAlL0lQyvYRShLo4rKokgxuQzD03+fGK78EkaE
         VcoTBmj4O6Du+wDk92C8XOG1KDhWDBOb88m9Yc4nakcRfsqYwanDQwuzbK58HFFtgdPX
         8L1rTCnhUnWrZOe067jsJY0gkgCcLayb1bXmKmWO2ypvGe9+Y7t4aej+7bs7RIsR+Kij
         zlpnGeNiCmx8p5ziSkP4VWpq1sN+RqQhEpbIRRoCjWmrFlkthwtndpq4ky1qU+D9BSG0
         Tbqg==
X-Forwarded-Encrypted: i=1; AJvYcCW+7aHEB+OtA1ijeZ/wGJ3OYbwclO3mHYmBiFhajuBzgHm5xiDEIGbFGq86dnWOhmJvOI9ibhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0piGEHzwI2up1ovNbzz5iKgJPr5X9yXLTNyvMqnd8FW4a5tu
	4+bopjIJ/5GAcF1bwHr84wA5fgrd7P/g3gdNOGxqA9V23C/osrJRztHQ
X-Gm-Gg: ASbGncvPfFvzy48Wqg6UB39Pt0gb5khSzJzAt33ZFu1JCUOjgBMYk0+oIQxT+1j8s4B
	+TWWhKIejGht1EF69D8+VbdtCCsUr5fmQpdtsvtZ/zaCfRWoGjmAQGK0Hi10wQ56xvFHMWbKaOo
	WuYS83lwncNrLy6B4rMa63Uc+QYKRCtF0tyNKM5rAcONmrxanewGTtW6hKvNmkFpZHPX32dsg2d
	VUQu5kCpwViUB3qlJ2iR+bMBKCU+uf2Y8uf5N3AWYuisjiDajNXTD6xYNfKeDtCsUpendh/xCrq
	pCWQ+7zyX+M/ReG03ZtanlqZH6eenrMNMKbXK6U2QODx8QI4eqfaOQHJ0ld2pRaqilGKYp9J/3F
	uYbrg560g1vXcU+CDDcHD3T8Xqyqlivm7M3C2qOEz+Hf5jUM91mf31okW0PjjZ9tU/hvzQa46NR
	1G6Bu1m3qNUJsJBtss
X-Google-Smtp-Source: AGHT+IFp6+ydXSgicmckei67zciPSd8OF9UxvzlzqRFOwWZKZyk/PUfrsSkmtiGEm/J3CEOfMuPmBA==
X-Received: by 2002:a17:906:1408:b0:b65:f49a:7b92 with SMTP id a640c23a62f3a-b65f49a7b9cmr250885166b.24.1760800921148;
        Sat, 18 Oct 2025 08:22:01 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526175sm266480266b.56.2025.10.18.08.21.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 18 Oct 2025 08:22:00 -0700 (PDT)
Date: Sat, 18 Oct 2025 17:21:56 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device
 driver for config selection
Message-ID: <20251018172156.69e93897.michal.pecio@gmail.com>
In-Reply-To: <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
	<20251017024229.1959295-1-yicongsrfy@163.com>
	<db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
	<20251017191511.6dd841e9.michal.pecio@gmail.com>
	<bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 22:27:35 -0400, Alan Stern wrote:
> Without a reasonable clear and quick criterion for deciding when to 
> favor vendor-specific configs in the USB core, there's little I can do.  
> Having a quirks flag should help remove some of the indecision, since 
> such flags are set by hand rather than by an automated procedure.  But 
> I'd still want to have a better idea of exactly what to do when the 
> quirk flag is set.

Existing r8152-cfgselector and the planned ax88179-cfgselector
implement the following logic:

IF a device has particular IDs
   (same id_table as in the vendor interface driver)

IF the vendor interface driver is loaded
   (ensured by loading it together with cfgselector)

IF the vendor driver supports this device
   (calls internal vendor driver code)

THEN select the vendor configuration


It was a PITA, but I have a working proof of concept for r8152.

Still missing is automatic reevaluation of configuration choice when
the vendor driver is loaded after device connection (e.g. by udev).
Those cfgselectors can do it because it seems that registering a new
device (but not interface) driver forces reevaluation.

---
 drivers/net/usb/r8152.c    | 13 ++++++-------
 drivers/usb/core/driver.c  | 23 +++++++++++++++++++++++
 drivers/usb/core/generic.c | 17 +++++++++++++++--
 include/linux/usb.h        |  6 ++++++
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index a22d4bb2cf3b..1b016dd81949 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10020,6 +10020,11 @@ static void rtl8152_disconnect(struct usb_interface *intf)
 	}
 }
 
+static bool rtl8152_preferred(struct usb_device *udev)
+{
+	return __rtl_get_hw_ver(udev) != RTL_VER_UNKNOWN;
+}
+
 /* table of devices that work with this driver */
 static const struct usb_device_id rtl8152_table[] = {
 	/* Realtek */
@@ -10067,6 +10072,7 @@ static struct usb_driver rtl8152_driver = {
 	.name =		MODULENAME,
 	.id_table =	rtl8152_table,
 	.probe =	rtl8152_probe,
+	.preferred =	rtl8152_preferred,
 	.disconnect =	rtl8152_disconnect,
 	.suspend =	rtl8152_suspend,
 	.resume =	rtl8152_resume,
@@ -10119,13 +10125,7 @@ static int __init rtl8152_driver_init(void)
 {
 	int ret;
 
-	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
-	if (ret)
-		return ret;
-
 	ret = usb_register(&rtl8152_driver);
-	if (ret)
-		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
 
 	return ret;
 }
@@ -10133,7 +10133,6 @@ static int __init rtl8152_driver_init(void)
 static void __exit rtl8152_driver_exit(void)
 {
 	usb_deregister(&rtl8152_driver);
-	usb_deregister_device_driver(&rtl8152_cfgselector_driver);
 }
 
 module_init(rtl8152_driver_init);
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d29edc7c616a..eaf21c30eac1 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1119,6 +1119,29 @@ void usb_deregister(struct usb_driver *driver)
 }
 EXPORT_SYMBOL_GPL(usb_deregister);
 
+/**
+ * usb_driver_preferred - check if this is a preferred interface driver
+ * @drv: interface driver to check (device drivers are ignored)
+ * @udev: the device we are looking up a driver for
+ * Context: must be able to sleep
+ *
+ * TODO locking?
+ */
+bool usb_driver_preferred(struct device_driver *drv, struct usb_device *udev)
+{
+	struct usb_driver *usb_drv;
+
+	if (is_usb_device_driver(drv))
+		return false;
+
+	usb_drv = to_usb_driver(drv);
+
+	return usb_drv->preferred &&
+		usb_device_match_id(udev, usb_drv->id_table) &&
+		usb_drv->preferred(udev);
+}
+EXPORT_SYMBOL_GPL(usb_driver_preferred);
+
 /* Forced unbinding of a USB interface driver, either because
  * it doesn't support pre_reset/post_reset/reset_resume or
  * because it doesn't support suspend/resume.
diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index a48994e11ef3..1923e6f4923b 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -49,11 +49,17 @@ static bool is_uac3_config(struct usb_interface_descriptor *desc)
 	return desc->bInterfaceProtocol == UAC_VERSION_3;
 }
 
+static int prefer_vendor(struct device_driver *drv, void *data)
+{
+	return usb_driver_preferred(drv, data);
+}
+
 int usb_choose_configuration(struct usb_device *udev)
 {
 	int i;
 	int num_configs;
 	int insufficient_power = 0;
+	bool class_found = false;
 	struct usb_host_config *c, *best;
 	struct usb_device_driver *udriver;
 
@@ -169,6 +175,12 @@ int usb_choose_configuration(struct usb_device *udev)
 #endif
 		}
 
+		/* Check if we have a preferred vendor driver for this config */
+		else if (bus_for_each_drv(&usb_bus_type, NULL, (void *) udev, prefer_vendor)) {
+			best = c;
+			break;
+		}
+
 		/* From the remaining configs, choose the first one whose
 		 * first interface is for a non-vendor-specific class.
 		 * Reason: Linux is more likely to have a class driver
@@ -177,8 +189,9 @@ int usb_choose_configuration(struct usb_device *udev)
 						USB_CLASS_VENDOR_SPEC &&
 				(desc && desc->bInterfaceClass !=
 						USB_CLASS_VENDOR_SPEC)) {
-			best = c;
-			break;
+			if (!class_found)
+				best = c;
+			class_found = true;
 		}
 
 		/* If all the remaining configs are vendor-specific,
diff --git a/include/linux/usb.h b/include/linux/usb.h
index e85105939af8..1d2c5ebc81ab 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1202,6 +1202,8 @@ extern ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf);
  * @post_reset: Called by usb_reset_device() after the device
  *	has been reset
  * @shutdown: Called at shut-down time to quiesce the device.
+ * @preferred: Check if this driver is preferred over generic class drivers
+ *	applicable to the device. May probe device with control transfers.
  * @id_table: USB drivers use ID table to support hotplugging.
  *	Export this with MODULE_DEVICE_TABLE(usb,...).  This must be set
  *	or your driver's probe function will never get called.
@@ -1255,6 +1257,8 @@ struct usb_driver {
 
 	void (*shutdown)(struct usb_interface *intf);
 
+	bool (*preferred)(struct usb_device *udev);
+
 	const struct usb_device_id *id_table;
 	const struct attribute_group **dev_groups;
 
@@ -1267,6 +1271,8 @@ struct usb_driver {
 };
 #define	to_usb_driver(d) container_of_const(d, struct usb_driver, driver)
 
+extern bool usb_driver_preferred(struct device_driver *drv, struct usb_device *udev);
+
 /**
  * struct usb_device_driver - identifies USB device driver to usbcore
  * @name: The driver name should be unique among USB drivers,
-- 
2.48.1

