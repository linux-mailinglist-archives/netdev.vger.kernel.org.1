Return-Path: <netdev+bounces-56679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6278106E4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD57F1C20DE6
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E115A4;
	Wed, 13 Dec 2023 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeYd8h9+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A4A1;
	Tue, 12 Dec 2023 16:45:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27fe16e8e02so1153499a91.0;
        Tue, 12 Dec 2023 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702428336; x=1703033136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO205Gyy3u2EwK/Wx0HOs1eZYci+1IO45TTBcIkAyNM=;
        b=YeYd8h9+Km6UDbtA7zAUMGBPxVBL3sssafoGushz9rQarIQuwnhQu/rG/wWlBbKT9o
         4cGbso7dQcr/6tcm1qP8840UQlUL8nbxFy8ntjBY97Kbr3J6TYtzH6tBYmLH1V/cJOej
         QpKrnpDsKMM4JncUteQAnmnc15I2Z5KVCG9TCGb6tX6eU/hr3KTlsklVlY+Ipns9EzA8
         1bDy91u6HOPYqm/VAGanEwAREdJNZWYAE8DsuQZcltTp0hygtlWt6RFH8s1LMwCVLJWm
         kUecDnPl0E4Tk2khx0girtwf+hs4FUIrhw5Bye1C7NGKMEaZi6Pkce7/IHQfcFYYx6l6
         RehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702428336; x=1703033136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO205Gyy3u2EwK/Wx0HOs1eZYci+1IO45TTBcIkAyNM=;
        b=vV2luBEmx9OFM2/eqmiDrvkuDdcU4RYMD1T0Q/DIUV56Utlti7X3diW7oiYgoMLhkJ
         Nqv6qKB4+craJycT+rQ8W5KB2kSY4roaCl52XSoonr8Bl/bCkQOdnS/8F/AIUQSEMqbN
         ciCyM1zPfskXLTwVachPiogICBj0S/YPuPNFIDSwx6Kok0ldQSDEWaYe3AnhDK1gRBgX
         p81CUxblAhMVQSedIuhkEilY63V/mALdohKKxfuWMTPdJ3Yd+4cBMrIsfQXVb1cFuehN
         r3Mar+pmSGnWTydpY6n2Mcd0+5DqLEF3NW77KHdLmkQl/g6Wi9HIJRtqwobwDFIbtAzu
         jI4w==
X-Gm-Message-State: AOJu0Yy7OLZ8Dz54+2Ujqbax3zYTuhxJ/uf0VHF4WqY28cEGgwjAoTm3
	iXDbBj0G8dwVvYc3zhiJVRhaZU0tjiZTOB7k
X-Google-Smtp-Source: AGHT+IH7goH0wU04h3dmF9b64dFqFsVGyvgT8LlIVl9ieEmnSu7dXLd9LpK9Ga1krTg3DKHIfhJF8A==
X-Received: by 2002:a17:90a:88f:b0:28a:e25d:a9da with SMTP id v15-20020a17090a088f00b0028ae25da9damr413259pjc.3.1702428335779;
        Tue, 12 Dec 2023 16:45:35 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id gn21-20020a17090ac79500b0028ac1112124sm2031130pjb.30.2023.12.12.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:45:35 -0800 (PST)
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
Subject: [PATCH net-next v11 2/4] rust: net::phy add module_phy_driver macro
Date: Wed, 13 Dec 2023 09:42:09 +0900
Message-Id: <20231213004211.1625780-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213004211.1625780-1-fujita.tomonori@gmail.com>
References: <20231213004211.1625780-1-fujita.tomonori@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
---
 rust/kernel/net/phy.rs | 146 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index b6142579e8fd..e457b3c7cb2f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -753,3 +753,149 @@ const fn as_int(&self) -> u32 {
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


