Return-Path: <netdev+bounces-55657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5B80BE5D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 00:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB102B20813
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 23:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB23C1F60A;
	Sun, 10 Dec 2023 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7D0oTWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADDBED;
	Sun, 10 Dec 2023 15:50:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-286bbaa517eso1109308a91.0;
        Sun, 10 Dec 2023 15:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702252221; x=1702857021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e31YXi0D8Z1xyARA/UHxIYXS+B1kdPjR1mjGNp0wP6g=;
        b=k7D0oTWP+L8roVEdb7IkkybNLh2VdGu7tZ48+w4WOTLn2vbzNihBx86GB0YFK0bSoP
         scXaKIU1Y8fYlaWIRS75dtYt36ruep2dKYEAAb8wZ9DarufznmIdZ7tJPfN73dURGk6R
         PE0dXYpfad+9eW70sB7cVs5041w07VFKTk2JtOAU9Oe6Zqs54+567CrzHeKYbZYQjOzU
         DFtJujTIQR7CwhGN1m6gS7GwIdy5dYfAUyx71tLxPlq2ih0ozatNRXF2+F6kfCemwjdx
         1N5rUNNgQ/spumI/pb5ZW4EFaBS4M5UnWstK3aDl7aJOU1araaiIvbZE4M9rVkxuoZii
         UZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702252221; x=1702857021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e31YXi0D8Z1xyARA/UHxIYXS+B1kdPjR1mjGNp0wP6g=;
        b=gr7RE+H7E8dGDsPLaB2q5moLO7yVffP8qZnt/1h1+NKUhT9NZoXptCDjJT17J26Dan
         GNJEEtB+7ANm9sOl0dVyeQ+KS0ReJTiSwYYfjUkmSw0AbgsKoe6POhaqqoOLacc03tvx
         lPID59665mk9YuiAszTwH3Hb0N1uG/GA4tBi9WOM8CKFG4XnoggcmlKh5CcRcOHprgkJ
         e9nCwLgBP+2uMbLlhPb8LIPJQlNFXS7SmciR1g+p8c265Bvwpxs6/DrFrLOj6kAPro0R
         3sBbQdGe95U4L+tSnUgzj78cFpqtWPR77O//MyigBiLEAANxnF2ievvaR/j87sL8mrsQ
         JDyQ==
X-Gm-Message-State: AOJu0YwNcdRgYzB0tNOA4Fx9zpUPf49N5bMsqqlwjx+518OL/xIFkge6
	TQoFhQ3dROrFcuY2FZn/aCyXIkprxV1Cgg==
X-Google-Smtp-Source: AGHT+IHKUVf85pGAwzIJdqhFAeJ7wGL59Di8i4oj/LOkLUDtIs5H2qBN/uY3AW0GAbP+Y6SmSfnNjQ==
X-Received: by 2002:a05:6a20:1609:b0:188:67f:ff2c with SMTP id l9-20020a056a20160900b00188067fff2cmr8443638pzj.0.1702252221359;
        Sun, 10 Dec 2023 15:50:21 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006cef6293132sm2812878pfl.101.2023.12.10.15.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 15:50:21 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	aliceryhl@google.com,
	boqun.feng@gmail.com
Subject: [PATCH net-next v10 2/4] rust: net::phy add module_phy_driver macro
Date: Mon, 11 Dec 2023 08:49:22 +0900
Message-Id: <20231210234924.1453917-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
References: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro creates an array of kernel's `struct phy_driver` and
registers it. This also corresponds to the kernel's
`MODULE_DEVICE_TABLE` macro, which embeds the information for module
loading into the module binary file.

A PHY driver should use this macro.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/net/phy.rs | 146 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 5d220187eec9..d9cec139324a 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -752,3 +752,149 @@ const fn as_int(&self) -> u32 {
         }
     }
 }
+
+/// Declares a kernel module for PHYs drivers.
+///
+/// This creates a static array of kernel's `struct phy_driver` and registers it.
+/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, which embeds the information
+/// for module loading into the module binary file. Every driver needs an entry in `device_table`.
+///
+/// # Examples
+///
+/// ```
+/// # mod module_phy_driver_sample {
+/// use kernel::c_str;
+/// use kernel::net::phy::{self, DeviceId};
+/// use kernel::prelude::*;
+///
+/// kernel::module_phy_driver! {
+///     drivers: [PhySample],
+///     device_table: [
+///         DeviceId::new_with_driver::<PhySample>()
+///     ],
+///     name: "rust_sample_phy",
+///     author: "Rust for Linux Contributors",
+///     description: "Rust sample PHYs driver",
+///     license: "GPL",
+/// }
+///
+/// struct PhySample;
+///
+/// #[vtable]
+/// impl phy::Driver for PhySample {
+///     const NAME: &'static CStr = c_str!("PhySample");
+///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
+/// }
+/// # }
+/// ```
+///
+/// This expands to the following code:
+///
+/// ```ignore
+/// use kernel::c_str;
+/// use kernel::net::phy::{self, DeviceId};
+/// use kernel::prelude::*;
+///
+/// struct Module {
+///     _reg: ::kernel::net::phy::Registration,
+/// }
+///
+/// module! {
+///     type: Module,
+///     name: "rust_sample_phy",
+///     author: "Rust for Linux Contributors",
+///     description: "Rust sample PHYs driver",
+///     license: "GPL",
+/// }
+///
+/// struct PhySample;
+///
+/// #[vtable]
+/// impl phy::Driver for PhySample {
+///     const NAME: &'static CStr = c_str!("PhySample");
+///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
+/// }
+///
+/// const _: () = {
+///     static mut DRIVERS: [::kernel::net::phy::DriverVTable; 1] =
+///         [::kernel::net::phy::create_phy_driver::<PhySample>()];
+///
+///     impl ::kernel::Module for Module {
+///         fn init(module: &'static ThisModule) -> Result<Self> {
+///             let drivers = unsafe { &mut DRIVERS };
+///             let mut reg = ::kernel::net::phy::Registration::register(
+///                 module,
+///                 ::core::pin::Pin::static_mut(drivers),
+///             )?;
+///             Ok(Module { _reg: reg })
+///         }
+///     }
+/// };
+///
+/// #[cfg(MODULE)]
+/// #[no_mangle]
+/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = [
+///     ::kernel::bindings::mdio_device_id {
+///         phy_id: 0x00000001,
+///         phy_id_mask: 0xffffffff,
+///     },
+///     ::kernel::bindings::mdio_device_id {
+///         phy_id: 0,
+///         phy_id_mask: 0,
+///     },
+/// ];
+/// ```
+#[macro_export]
+macro_rules! module_phy_driver {
+    (@replace_expr $_t:tt $sub:expr) => {$sub};
+
+    (@count_devices $($x:expr),*) => {
+        0usize $(+ $crate::module_phy_driver!(@replace_expr $x 1usize))*
+    };
+
+    (@device_table [$($dev:expr),+]) => {
+        // SAFETY: C will not read off the end of this constant since the last element is zero.
+        #[cfg(MODULE)]
+        #[no_mangle]
+        static __mod_mdio__phydev_device_table: [$crate::bindings::mdio_device_id;
+            $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = [
+            $($dev.mdio_device_id()),+,
+            $crate::bindings::mdio_device_id {
+                phy_id: 0,
+                phy_id_mask: 0
+            }
+        ];
+    };
+
+    (drivers: [$($driver:ident),+ $(,)?], device_table: [$($dev:expr),+ $(,)?], $($f:tt)*) => {
+        struct Module {
+            _reg: $crate::net::phy::Registration,
+        }
+
+        $crate::prelude::module! {
+            type: Module,
+            $($f)*
+        }
+
+        const _: () = {
+            static mut DRIVERS: [$crate::net::phy::DriverVTable;
+                $crate::module_phy_driver!(@count_devices $($driver),+)] =
+                [$($crate::net::phy::create_phy_driver::<$driver>()),+];
+
+            impl $crate::Module for Module {
+                fn init(module: &'static ThisModule) -> Result<Self> {
+                    // SAFETY: The anonymous constant guarantees that nobody else can access
+                    // the `DRIVERS` static. The array is used only in the C side.
+                    let drivers = unsafe { &mut DRIVERS };
+                    let mut reg = $crate::net::phy::Registration::register(
+                        module,
+                        ::core::pin::Pin::static_mut(drivers),
+                    )?;
+                    Ok(Module { _reg: reg })
+                }
+            }
+        };
+
+        $crate::module_phy_driver!(@device_table [$($dev),+]);
+    }
+}
-- 
2.34.1


