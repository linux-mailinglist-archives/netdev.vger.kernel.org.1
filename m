Return-Path: <netdev+bounces-53708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6798043D5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDA281482
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9077E17C9;
	Tue,  5 Dec 2023 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXfGC8LJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42410F;
	Mon,  4 Dec 2023 17:16:18 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfa3f7fcd4so8075205ad.1;
        Mon, 04 Dec 2023 17:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701738978; x=1702343778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3z6ld/WKs0arz1n4VhAMHUvHcRZJg5LK6hVB6xHj9M=;
        b=EXfGC8LJ+hBQEK7Vk8frrOLBiCtm2SpoJRbSW85oZWJ6DK5z2omZ/W3MT5IG2ohe1w
         H9Hfi6Rh50M/354372IQPbda/p7+d+B6Y6Qbces1EAn5Q91x2jm0bsZjq8kEpcF5K2Oz
         4wQTMgmvYbAGCG7+B/TgP3qwV02tcuzmWXNlNFvkMZ7ziKlezR5JSuQTd0CZLIxXpscv
         UfWP/z3CKvv1eNloXd+2VNqe8S2uGhV3IskpxjsNTgDmrRMi7Xcu0mQc1SiRmzCdtEEf
         veLhZpIV3DrfhnOKNKQnQ712fq9M4DAxuh4EyHKEQpuQCYEuN3Y2Sy20icVlvu06BO+b
         3LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701738978; x=1702343778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3z6ld/WKs0arz1n4VhAMHUvHcRZJg5LK6hVB6xHj9M=;
        b=Ms5nortj0BbcUjx1tu3ZRdcHyodQjSa4DWthbHjotejHaL1i6bi/wFRxsK7NlM3zxA
         HY5rZk0JfiHYAw74eIDEgcL42ByXrQXLDREjf7qdmywkybvqoClGFYNjJRbe8daSAddZ
         klv+hjUV0n21qvvZ20Fbd8ibgNE7vm4qxqi1InI68vOEA3OVfreyYAQL5pyaSht4SbaF
         2n7inuSlnuNX374ZBvb8pcIxhcZ9EqD/U0KdvA+9mEyG2NDKwrSPq630tk5sblUI2iqW
         eGnz6hZfZ+AZdP6UHRJW4c//2PXIHByOjpvmKFkqvCNnaNjCxNfBCjP5zqSQMJpvXwbT
         7d9w==
X-Gm-Message-State: AOJu0YwyPhQJltK7r6xLCTcmu0eH4hNBxmjPraSXWUpjzH6YO/Ugf3iU
	hGRL033/mwc2mbxTCd5lbEZQfO2ZxGvE2h5z
X-Google-Smtp-Source: AGHT+IHg7+I6K94E3XB5U/oVbsPYoBTC+We3s0eik8ek7wn9j4g/RAabc21BinHAYt6wrRUuopYWrQ==
X-Received: by 2002:a05:6a21:a598:b0:18b:d26a:375c with SMTP id gd24-20020a056a21a59800b0018bd26a375cmr46759590pzc.1.1701738977945;
        Mon, 04 Dec 2023 17:16:17 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id m18-20020a056a00081200b006ce64ebd2a0sm89337pfk.99.2023.12.04.17.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 17:16:17 -0800 (PST)
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
Subject: [PATCH net-next v9 2/4] rust: net::phy add module_phy_driver macro
Date: Tue,  5 Dec 2023 10:14:18 +0900
Message-Id: <20231205011420.1246000-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
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


