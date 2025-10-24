Return-Path: <netdev+bounces-232646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99350C078EA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C853AC573
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7331E0F2;
	Fri, 24 Oct 2025 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="zUrOfAjA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FD254B19
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327323; cv=none; b=H8ZFUzCxE/uA1ylUGXceoyPRuYolM97qDngZMyAznsjseqFy9t0d6YKH8fg/P9AE9WSuZ+KFJlRBra4ETx8Ul+ZRc6A1YJ6u+/FuNtkAah77ZQov1iUaNMmTK/A2+gtzg6SRmMgGYHpe11Ut1LqeylsQg0P1s/s4F35aOOQdiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327323; c=relaxed/simple;
	bh=mXbvfEQIbRLg6rG81hv/RTX5vCliwJPhPkv+p8Gh0do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbKjp4oWtYSs9KgJbxo9V0R+EGtpS015GIwV+j8wmNbzgyK+DSPG9FCVHVyGyfaYEbdUyUavmkbXR5ifV0C9LIddqnBzkXTYpzIl1CllSNpqhNrffqu7I10lpnTfkZhLPYScTJWiQWzdmQZnPZXpe9rh4XHwACfQcWzEPqP+e0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=zUrOfAjA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33be037cf73so2600618a91.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761327319; x=1761932119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXMbYT70NLPu6BzjWG2yQn0RfjMWdVCvvig5iK24b+8=;
        b=zUrOfAjA4gbwpwVBPIWeL/yJ24jwA6Cy+Jn7x5i34KlWaMH7oxDOeahosptwn7JAkB
         By1TeAhEJIOo8wghuoC/58w9xT57DyWDZPwA3naA8z0Jf94dYA3V7PsLxDHMUMMUdEKP
         TLyVvZabXAAZO/g30iGA2NHwB7UK6Pqu/ncNG8htfq8cjTOiEvs1jI2QTBwSVae5zW81
         0GCVMtUcrLDOB4d7sWG+7dTh9kHrTflfU2THsu2AjqrnXPXTzjLvo6hXjyYv8kRUnODP
         TLhweAizn2zTJi5wHKkSGiaU1k4a7ndDp2+SAjSFDJSYZsARKAmFyxQ0qoat87CPi/0o
         LIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761327319; x=1761932119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXMbYT70NLPu6BzjWG2yQn0RfjMWdVCvvig5iK24b+8=;
        b=v6S1Jsju7+lUIMJpy5gEKt2eB3URuUiFaN1KYx10s6IR4A9oPxgh1bZj3gO85QF+bD
         kicM9lmekijGAj02+m0QsaKg6yMsvE4THNENAFkwuXIQXbfUPF8DOgKTc8jJpYFpElyU
         hI4s3GwpBnenUiz4iouo2+/F15PeWIueJlC+cptQUv5onKEgzz9U2si5M5uIcPOpNThI
         APQg0YoAO2I1oJCOgpw8IOMne9SGuF2Gn2MUZWWuAZJtdX3TGdokEM8tRWXaT6S51TK2
         E7pv1a5CkyE3V+o/oKjadDQeMKJc6uN53dO1gyvhyPo7qv5UwtX8/tnuLCeV8NEDJ679
         Z8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWwHFKPKJvUNWO8uX3foj2HzU8Wx7Erl6QwOu5LfBwrAPiJHPhJpgHNk/pohQEfv7Ij62BmY1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0owEOwRqnvTDjyc1/OOnoYyeM/wobPppuc0OuG6hH3TA5eXT
	6GqBtzJo04fQmkVrRQoYdS4k+CB2SAV6mS8AtT+91FEbLNmPNkDPvDqG3FPm/Bj8xB4p7VzgFnu
	f+0hazEw=
X-Gm-Gg: ASbGncsk+FM3EGNHIcAwwyTwAbw2A5OJjzbZjdpQ4WGEPTORHygAQ5XquATHTUL+E0D
	FFwIrdl0GA1qJPNXYjfvPn5IB96MOO8X7dmFry7zbkfUr4zN96BViyy6c1wbWH3xvgAh7/LjBNY
	2Hsdd91WQh9d+eD22w6++khqr+gFYuPsz/bbhoOJTlFbz/fUh7z88tMvLw9QqyJsx1UgeNUtZyZ
	uuBRn4eYgy4hJgvwhFqZ0iwpeqya+/Z9LPCFrS7rgCP0ttGmQ7K8z2EPmEEXmqzEvS9BOToHrEA
	IPYf9tC1vCdNr8Jc69jgRO+1SucwFPUP9H6IaQno6kI0MypvhOR3Cbex1bnByaRpa31TK7asPg1
	zEICQKa2KhQPzLaZcxwaGexNMxDzNOqruP23ad0RWAYXqjO8BTTiNHzSDbKKq3vYMHa+5RONwMd
	60XPjQpdIb78tDXKsnqcaIkg==
X-Google-Smtp-Source: AGHT+IHbzB1znYk97aCgMkkEMmeYysmxrGDyagwXbgG0SJG4dkZL522tTgvCl4oWdxBmjUyWPIlk9A==
X-Received: by 2002:a17:90b:2d8b:b0:336:bfcf:c50d with SMTP id 98e67ed59e1d1-33bcf86c98bmr34552973a91.14.1761327319578;
        Fri, 24 Oct 2025 10:35:19 -0700 (PDT)
Received: from localhost.localdomain ([49.37.223.8])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33e224a2652sm9915918a91.18.2025.10.24.10.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:35:18 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: isdn@linux-pingi.de
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()
Date: Fri, 24 Oct 2025 23:04:55 +0530
Message-ID: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>
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
before freeing the hw structure.

Fixes: 69f52adb2d53 ("mISDN: Add HFC USB driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index e54419a4e731..378d0c92622b 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1904,7 +1904,6 @@ setup_instance(struct hfcsusb *hw, struct device *parent)
 	mISDN_freebchannel(&hw->bch[1]);
 	mISDN_freebchannel(&hw->bch[0]);
 	mISDN_freedchannel(&hw->dch);
-	kfree(hw);
 	return err;
 }
 
@@ -2109,8 +2108,11 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		hw->name, __func__, driver_info->vend_name,
 		conf_str[small_match], ifnum, alt_used);
 
-	if (setup_instance(hw, dev->dev.parent))
+	if (setup_instance(hw, dev->dev.parent)) {
+		usb_free_urb(hw->ctrl_urb);
+		kfree(hw);
 		return -EIO;
+	}
 
 	hw->intf = intf;
 	usb_set_intfdata(hw->intf, hw);
-- 
2.43.0


