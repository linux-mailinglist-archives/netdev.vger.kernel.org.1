Return-Path: <netdev+bounces-119374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA84955587
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 07:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704BD1C20F7C
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 05:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838F130A7D;
	Sat, 17 Aug 2024 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVPSFc5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1012DD88;
	Sat, 17 Aug 2024 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723872342; cv=none; b=gOc4VYJxJu77Wbb2D+PJgxaBjDuRAmupNWRPyMjSPQFVfSRp5RM7ycBI2ZCgCciDNAqvwDqBQFv60XH6f6fClPVcGx7Kj+8LNeJoSuD6fzaHhkAKHqG7JxwIgxmJ3MREcpXtSojaGl6ZZ3mLmVH6cnnuL9Xg3SzHKas/UmemykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723872342; c=relaxed/simple;
	bh=wivM8IA7zenqRlJh8VPWy+HzbFJua1YXpxvnGDipUxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oh6zfpSMrt8AIwGjomq3YwhhXu7Ngl6udZqfzI6N6dcM9d4npYilA+NtI3L3NkqpnKmkv/rKzhnaLVE8VRLcJiaBe96SGEhz7HQd9Rgy5f1LZRFf2jkBnRAVpfpll2ViYueCKLkYjnkUTh+ifxKEBT1nfvzBKTLF5wmPvOKemyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVPSFc5T; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3bc9405c2so246188a91.2;
        Fri, 16 Aug 2024 22:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723872340; x=1724477140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+MO5WoS5mr4hQO5ykAo6VCslDN6Dd9dPd7bzUxiveU=;
        b=PVPSFc5Tw+vsjkEAftkVwIqr93IoWXy+8hsOebOQp2AnWhDSx69tngP1gUoCPgTlj2
         i/np0BTgvWYI4ZnMCETMNdM47ym2mOPnU5YL6MRiFFwLraOsrXs71QwHQrTBDY4L6DTp
         UuaMC4fkrzbmM3cXo6yupY0EpBoouoH/RJFUOHAxAu40ireNJDzXl8hciHvW+TItdTAb
         Oc4A4qxkQKUv2rdsaupxrMIa5N7BAufmjJ5yzXwxmU/4mDOMwmncoRqbvZB6nRRU6vKX
         ifPvuZ5Y1v6l1It03geH9Rb4Tq4POajyz40yCMirUZ5kp+uDL359sSdbG6kH8NAecHsQ
         54Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723872340; x=1724477140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+MO5WoS5mr4hQO5ykAo6VCslDN6Dd9dPd7bzUxiveU=;
        b=jMplBPfHEbym5lfELBl2ePwELH0yPx3xCs5XXL5Q7kgwORnm4qG/vgZjSp94wDuh0e
         VfUlsq3AM3ifMQWMSFk/sOL/jb5uxd+X7vaHQjImrJgHFEv2nx5Bjl8uTc5w0xRLNrD4
         AQ4z+EJ4IIyWw8KpbJaUuwGKOoeaouQZO0fExpFOffLU3FzfHNDe1eEWO+wBR04j8C10
         AGl8BPNx4KOVpF3cha26ydLrhHGVi0tLbqMd82mY1+zk//oLkmWlEzsce9nWmOfv25So
         6rvTNAUipKXOpPwVgocr1gVYY++ec07N9Hy1fwK6DiE5Vm0GhN4H+QWxiRen1UB8ezvd
         Hhig==
X-Gm-Message-State: AOJu0YzvvsgJlCu/j50ktxvANDH2ClxHueeUPwjnhUuazYjZYDZWSApQ
	w8K4fY+/4hVaDACQQVDtVOh9gvlkvX6UVK7Msq/aXiwNPeNfoYmwdwGE8IWk
X-Google-Smtp-Source: AGHT+IGSHJImcIrqTjBKR3SN3uNUj8selb7hjeeQwezkU94wFlZwsBNHdsVo6jfq31aLe6RAxLTDbA==
X-Received: by 2002:a17:90b:4f86:b0:2d3:b9bb:556a with SMTP id 98e67ed59e1d1-2d3dffc0f18mr3330481a91.2.1723872339578;
        Fri, 16 Aug 2024 22:25:39 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74e33sm2881655a91.39.2024.08.16.22.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 22:25:39 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v4 2/6] rust: net::phy support probe callback
Date: Sat, 17 Aug 2024 05:19:35 +0000
Message-ID: <20240817051939.77735-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817051939.77735-1-fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support phy_driver probe callback, used to set up device-specific
structures.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index fd40b703d224..5e8137a1972f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -338,6 +338,21 @@ impl<T: Driver> Adapter<T> {
         })
     }
 
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we can exclusively access `phy_device` because
+            // it's not published yet, so the accessors on `Device` are okay
+            // to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::probe(dev)?;
+            Ok(0)
+        })
+    }
+
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
@@ -511,6 +526,11 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         } else {
             None
         },
+        probe: if T::HAS_PROBE {
+            Some(Adapter::<T>::probe_callback)
+        } else {
+            None
+        },
         get_features: if T::HAS_GET_FEATURES {
             Some(Adapter::<T>::get_features_callback)
         } else {
@@ -583,6 +603,11 @@ fn soft_reset(_dev: &mut Device) -> Result {
         kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
+    /// Sets up device-specific structures during discovery.
+    fn probe(_dev: &mut Device) -> Result {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Probes the hardware to determine what abilities it has.
     fn get_features(_dev: &mut Device) -> Result {
         kernel::build_error(VTABLE_DEFAULT_ERROR)
-- 
2.34.1


