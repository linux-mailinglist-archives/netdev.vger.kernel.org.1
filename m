Return-Path: <netdev+bounces-50369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 013367F57AC
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274C91C20C95
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 05:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1ABE66;
	Thu, 23 Nov 2023 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldLzqeaL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54361AE;
	Wed, 22 Nov 2023 21:09:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cba45eeaf6so134612b3a.1;
        Wed, 22 Nov 2023 21:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700716194; x=1701320994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b//rwd/Cz3go0jlj1XvfG3vovwZj+fDrqcgPjfXq9vc=;
        b=ldLzqeaLQe08/BahQzd/zevbIiHj4i4bHe64JfwKaRdkL8oownYoklvD01VP4y4VAE
         ij+bOhcTaKCddukW/ZXzDI5RT2Wt+bul+DkJMWH1ELKWPgti6kZ8Qj6DvPNiqHRuYkZ5
         OT9Vxqi1W3xi/0Iuzun1wvwWQD26/cYUeWi6IQkwI35QMtXOTylfWE81gl3QIJ5gZmyd
         9+P9SLOw1gsZOre/oNXOTuAzMyDaiJRPIBlJpYhKCOOxwaJMcuicLsAo2h5W2pjRoCun
         poe3DmhgHl4gAAWe27ORMWmb27Fea1ae8k5sqEsA9Ec/bq7lEaALpGu/SYEDM/C/lTKp
         p6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700716194; x=1701320994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b//rwd/Cz3go0jlj1XvfG3vovwZj+fDrqcgPjfXq9vc=;
        b=Ot46dzIQhRnF2aB/4/ZZsQKLzgyJWKPqrsnwkph2+gDLeESsn5nJrivCuWq4UdH62Z
         uGWEbBY6Y6YcqyLOB2Ul6yEPNiv6RElV8BRiWe3+7ekdG9fn8hXC38Uo7EF1P+5lAUlp
         EUurdWhXPvC0OCkgHyHS8J2450YTsxv6MgfuspC6NbzjfH61EDz6ifZ3HAQkxJ8DERJB
         0sHXtJBCojMlppdG0mfM8gM2DgF3XucQxa9lacrStkLTpOg7351avw6snXdvJrshXdJ5
         bZfMNvC0WVmCCfmhKY68nDgrQHolAQ7MrP96uvu5MRBI+BC8FW92ARjrrTr5raVVejOb
         Bs+A==
X-Gm-Message-State: AOJu0Yy1RhlEvOkB6QAveUpMDfqBxLBd9/lzdU94m7Xtq2C8AR5jnlrN
	9BOqH1lruUl1n6nKjF+Rfs9b/imErVrikCnU
X-Google-Smtp-Source: AGHT+IHGcN/fsEdXUKLW03AE5ilbaNX2k2iAaOjA3RQn9c36ptgWUyknvnIZhMQUe3OWFnHLcSHxmw==
X-Received: by 2002:aa7:8597:0:b0:6cb:b6e3:e007 with SMTP id w23-20020aa78597000000b006cbb6e3e007mr4623296pfn.2.1700716193828;
        Wed, 22 Nov 2023 21:09:53 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78007000000b006900cb919b8sm347734pfi.53.2023.11.22.21.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 21:09:53 -0800 (PST)
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
Subject: [PATCH net-next v8 2/4] rust: net::phy add module_phy_driver macro
Date: Thu, 23 Nov 2023 14:04:10 +0900
Message-Id: <20231123050412.1012252-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
References: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
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
---
 rust/kernel/net/phy.rs | 146 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index b395a6939fbe..fd73c614f48f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -745,3 +745,149 @@ const fn as_int(&self) -> u32 {
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


