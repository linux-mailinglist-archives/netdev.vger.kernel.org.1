Return-Path: <netdev+bounces-234270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00999C1E588
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3A5B4E11AE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895A72EB5CE;
	Thu, 30 Oct 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="ddSVIiQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962F2E336E
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798337; cv=none; b=li1S9uJHT+efb8sRmRTkVQZOBYpqxm4vYCekKW7v1hPiqgoKzRhlYRgKlP+TJ9t2BJztUUD9Ab0DG+WDhOTfD5Zv2nU3Xm/hN6PL+HF4yIn8pl1zTmFrY/p8u4rJlv0Bdbjp5NkylbSRK6dVn9XlS68el9pz/ra/Wf61vaXVyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798337; c=relaxed/simple;
	bh=akH7KpJecI4n+QJrs5zH9nQeo0YDkYU2UBuk2BavrVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrHd7PS/vAL17g+20/qrciETOXm8O/6lyj7Bd3BgIB9jjBOuKnNaEiL1lKyf0A+zovf0ND/tVxxkej6ua7ip/c6xdfQWx/Beis/m4+PVsRukJMEHv+ZBVycx8OH0/7f5sCcf4/W+o3gZQrukkc8GWjzt3/BW8KkVWXfco1ler9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=ddSVIiQu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290dc630a07so4283815ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761798335; x=1762403135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6cUclqtjLqmHCCyJ+ZbRyqsvOdXEkvs5Ie/9Febbuw=;
        b=ddSVIiQux12DoSrznFw/KgfWv4RCUijOzECd7MSpEVEfbMHrwUyIt5OehVOiCmzOOc
         PEqvGz065En91gOpJMXKdC6gdLel2icbRZF3/WlU072IIYH3Mu+qrAZ4An6LNZSyoytu
         cqhM4khFtheDO2UEv03V5UYFVVhxUL+qRUvdlUwR83unDXzAOGzZPn1ck+cWYb2AUeow
         EmOu6vQZEd/1PPUxnrVgp7bwW8jz/dqUATPGn1ZExFJF59eLkBu43VYDjUWURYWIMykP
         +ogm+oX0Y7gYh2eBKEhM5Z+j6NGLUq2EcwQb3mkdUlbrlnGxQZEp1ak8fSl/OSw2e/st
         5fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798335; x=1762403135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6cUclqtjLqmHCCyJ+ZbRyqsvOdXEkvs5Ie/9Febbuw=;
        b=eBjtWUoh2hOkSYXy2xM7WzigE3DDyeTqKItcYcfbzOQ6ALpPAdF1muRV6R+/WLZSP0
         bNIlQAqW3XEFn2P79BhW+KH3y/6KxZT/FfZjU+I5KambOzTlpuGRNM9SxE2ZGCSlc9UC
         DsafBRH6K5SgxLU+xAo49Mf7nOPHrnJ49FwO91vp9TV5GK22Ls+vFiQBCP99dziOSnfe
         4PklSDzTWNWfYXYBiUG6HOIJECvR3NifGBjGzAgupQa2Z3Ps6s+qV+/u4XiRqkM2HHWs
         MMelrnGguUZoo8hIjxvGcVmmwh/PQEYOzIs9OpQ5CwzRtRSeds77n4AI3aVjzPaFavcV
         xPjA==
X-Forwarded-Encrypted: i=1; AJvYcCUH2wf7hiY7beifyl5r+iAOkjMgTrWpcYfdZ6qvHr5zl7o3h0kyTl1SlrLptm8tD7dG7gQLq2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0CVfv0KGPvGe56vJkDrSogkfqRI0EwaDd7LxbDVNViFN57JE3
	PMLF/VD8iw4zMOUe24h97OwtOBPlYeZ2dKUUvQutFL3mSwwGRzPmi8ogNSBTcqHrhFeS0VhX7SM
	xGb2V
X-Gm-Gg: ASbGncvgfbKkWP0FnSGvQQtE5UHuyTb3ok3AIkhsmh348f03Wr6++IurpfM1FiaiF4a
	TFPcStJxBFs7sGXuaWy952swfknw45ZnGiodXhw/7bDK9AYaI6lRC+lo0MRPOPW4NTwnF5UPt0+
	9hZNcGdHbRtc0BZXuh3rQMkhgfAgiAWL7+H20L8/MzeFwpBAQGe6sKwEaEym73fX0nnxK3z+ZI5
	Fa5SBpiV0FXQiHpDuu6S1lpaoBAH/sxwR4yWDIDn4ArKPMtrVbLFHEUY6DnG+wwPfpaZPz+EAd+
	Mp9U26ClsHqy3IGDAUC2JmrWyNjKWqbKF/PsTTSFAn1fS9R9iBFLsqFSdDDjFOnmfbL4t3g/UC2
	GtFByZZheYwIM7aGERPg1/27aySOsjZb0ZS8LQHC7AF4fv1b0XUFe/3rOmRl1UqbENKpidYZiB0
	zPO3iQez7KdclzNC5mufB4fb0x
X-Google-Smtp-Source: AGHT+IH1qZlCrQ7jvNZuabOFz90UxYltHxbnuJBYmWEXINJqkod6nkwwuZ3kM71t1oIhJR8TNZjC7A==
X-Received: by 2002:a17:902:e812:b0:28e:acf2:a782 with SMTP id d9443c01a7336-294deea9585mr62399795ad.37.1761798335012;
        Wed, 29 Oct 2025 21:25:35 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.22])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d0827fsm167991715ad.31.2025.10.29.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:25:34 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: isdn@linux-pingi.de
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()
Date: Thu, 30 Oct 2025 09:55:22 +0530
Message-ID: <20251030042524.194812-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hfcsusb_probe(), the memory allocated for ctrl_urb gets leaked when
setup_instance() fails with an error code. Fix that by freeing the urb
before freeing the hw structure. Also change the error paths to use the
goto ladder style.

Compile tested only. Issue found using a prototype static analysis tool.

Fixes: 69f52adb2d53 ("mISDN: Add HFC USB driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
v1->v2:
Updated to use the goto ladder for the error paths, and added a note on
testing and detection, as suggested by Simon Horman.

Link to v1:
https://patchwork.kernel.org/project/netdevbpf/patch/20251024173458.283837-1-nihaal@cse.iitm.ac.in/

 drivers/isdn/hardware/mISDN/hfcsusb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index e54419a4e731..541a20cb58f1 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1904,13 +1904,13 @@ setup_instance(struct hfcsusb *hw, struct device *parent)
 	mISDN_freebchannel(&hw->bch[1]);
 	mISDN_freebchannel(&hw->bch[0]);
 	mISDN_freedchannel(&hw->dch);
-	kfree(hw);
 	return err;
 }
 
 static int
 hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
+	int err;
 	struct hfcsusb			*hw;
 	struct usb_device		*dev = interface_to_usbdev(intf);
 	struct usb_host_interface	*iface = intf->cur_altsetting;
@@ -2101,20 +2101,28 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (!hw->ctrl_urb) {
 		pr_warn("%s: No memory for control urb\n",
 			driver_info->vend_name);
-		kfree(hw);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_free_hw;
 	}
 
 	pr_info("%s: %s: detected \"%s\" (%s, if=%d alt=%d)\n",
 		hw->name, __func__, driver_info->vend_name,
 		conf_str[small_match], ifnum, alt_used);
 
-	if (setup_instance(hw, dev->dev.parent))
-		return -EIO;
+	if (setup_instance(hw, dev->dev.parent)) {
+		err = -EIO;
+		goto err_free_urb;
+	}
 
 	hw->intf = intf;
 	usb_set_intfdata(hw->intf, hw);
 	return 0;
+
+err_free_urb:
+	usb_free_urb(hw->ctrl_urb);
+err_free_hw:
+	kfree(hw);
+	return err;
 }
 
 /* function called when an active device is removed */
-- 
2.43.0


