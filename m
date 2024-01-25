Return-Path: <netdev+bounces-65711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FC83B6D3
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017061C21DEA
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116917EF;
	Thu, 25 Jan 2024 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa/V/gQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583B5C9A;
	Thu, 25 Jan 2024 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147218; cv=none; b=u3Wzv2Q+WbVvkl3tQPIh0LcD1H1vH2w/ULXznYqqxUXbVF93VE0hTXoPjVSGM/NRdn/6WYyMqnceWYL4DDamOAsmtaytRzoRORQha3KUzmg1bQ2owcXATjFkmIyPRHH3mjVl+3bdv404K1BBazpu9ZkNwM8ONRELjvm4J3ZliPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147218; c=relaxed/simple;
	bh=e6tu0RJ7FwCpH7lvTfF61t81MBqoT2j9mZqAE/BI9+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mn3lGITHFkowa6lUjX6SyfWJi255Wl46915AMxRXHz5tXKCjrDu5CUJYKZyGFdTc9i/GiByz0VBGdAx72LBRT6OcNa2vCCXorB6l5YLpvRlcE/11ny0MS1DmiD/Y/oat7jDFT77U8mRZj6R4jpjIPdPHNk41aodtgvg+sn5hW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa/V/gQm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d748f1320aso5302985ad.0;
        Wed, 24 Jan 2024 17:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706147216; x=1706752016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxw0Q7fyPTSlCbsUpebmlJqSh8Z3XQAMhcbX5D+D/KE=;
        b=fa/V/gQm6AN4PSy00gZv54JtTHfUQtjNiILS3kGItv/mvyGzqPNDLuphvfIlj96klb
         1AmPbnL8J0JSNStl28N6FOZENFKWhKgKiCeJc4egv+JscfHdRE25rMp9gVqrh7Z+cb1u
         f4SjXMeXZ1f7GROrQ4kE0Nv+4HU8SnbBofxXgyiA0/s5JQPEbi72S1WKTy26SWaJj4DE
         mAHYh533pINhTTg9CYgthycZKAKP+xT4kOYqDSJ3mJGwQz2Jcov8uFs3lQwqFp9k54xh
         lMFCxKpxZn+ncKZUGlyci+y3Y5h8a9T15LBX0gUrJI8XkBw0M2+6MakNzcsOiOm83CMK
         4tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706147216; x=1706752016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxw0Q7fyPTSlCbsUpebmlJqSh8Z3XQAMhcbX5D+D/KE=;
        b=ckNtY42XUTzrspWjQpVBaoI/kQZaQGYQD12h9OAaXAh1WjFjfqBlVKicrLcn+M3Qho
         MBdXxaAm2za4BKK7WLzc4rJcxAVPtsAUbaCD8daFdvEDBraF2hFTnvzWm0pk+ddagy7a
         R4aw/47IdG5WsQUjecwzokkfv/JzoURrB6DDzYs6cPXD6lWnxWSNqdt8FYgwjkn9cBZG
         Su5z3HdG/NRtYYXUHF5r497aqE0SbEi6iw04/6wvvVHWffFI2O8C18dp+McLzcyJnBIx
         J2EvNMvTvAu6GADpyhbNf24PtbG/BfW+/whMq/vqibA82NlM8Vwktfjhlo/S+5/MtbLl
         kCkw==
X-Gm-Message-State: AOJu0YyJbSE8YPx3HFOHC1d/yZtSf0OIigNXvIA4h2LqEId/iOsQhMST
	dkC/fznkF7BV1F6RyQNLMwSWdW8CFh/gRoIUgkbHz5xRFhyX3kddDjOxObeb1yuAkQ==
X-Google-Smtp-Source: AGHT+IELCcaBBDvNeUhLlenHnZ3yTV9+54ZX/MI722WCJ2FZv9gmGuAl4Zfxf4Z1lmxARF/abYnhqg==
X-Received: by 2002:a17:903:234f:b0:1d3:c5e4:b2f6 with SMTP id c15-20020a170903234f00b001d3c5e4b2f6mr491973plh.4.1706147215944;
        Wed, 24 Jan 2024 17:46:55 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id mg7-20020a170903348700b001d69badff91sm11107980plb.148.2024.01.24.17.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:46:55 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu
Subject: [PATCH net-next] rust: phy: use VTABLE_DEFAULT_ERROR
Date: Thu, 25 Jan 2024 10:45:02 +0900
Message-Id: <20240125014502.3527275-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125014502.3527275-1-fujita.tomonori@gmail.com>
References: <20240125014502.3527275-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 6.8-rc1, using VTABLE_DEFAULT_ERROR for optional functions
(never called) in #[vtable] is the recommended way.

Note that no functional changes in this patch.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 203918192a1f..96e09c6e8530 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -580,12 +580,12 @@ pub trait Driver {
 
     /// Issues a PHY software reset.
     fn soft_reset(_dev: &mut Device) -> Result {
-        Err(code::ENOTSUPP)
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
     /// Probes the hardware to determine what abilities it has.
     fn get_features(_dev: &mut Device) -> Result {
-        Err(code::ENOTSUPP)
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
     /// Returns true if this is a suitable driver for the given phydev.
@@ -597,32 +597,32 @@ fn match_phy_device(_dev: &Device) -> bool {
     /// Configures the advertisement and resets auto-negotiation
     /// if auto-negotiation is enabled.
     fn config_aneg(_dev: &mut Device) -> Result {
-        Err(code::ENOTSUPP)
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
     /// Determines the negotiated speed and duplex.
     fn read_status(_dev: &mut Device) -> Result<u16> {
-        Err(code::ENOTSUPP)
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
     /// Suspends the hardware, saving state if needed.
     fn suspend(_dev: &mut Device) -> Result {
-        Err(code::ENOTSUPP)
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
     /// Resumes the hardware, restoring state if needed.
     fn resume(_dev: &mut Device) -> Result {
-        Err(code::ENOTSUPP)
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
     /// Overrides the default MMD read function for reading a MMD register.
     fn read_mmd(_dev: &mut Device, _devnum: u8, _regnum: u16) -> Result<u16> {
-        Err(code::ENOTSUPP)
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
     /// Overrides the default MMD write function for writing a MMD register.
     fn write_mmd(_dev: &mut Device, _devnum: u8, _regnum: u16, _val: u16) -> Result {
-        Err(code::ENOTSUPP)
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
     /// Callback for notification of link change.
-- 
2.34.1


