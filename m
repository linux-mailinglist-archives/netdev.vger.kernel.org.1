Return-Path: <netdev+bounces-226388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C725B9FC82
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36343A4F2B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EAF28D836;
	Thu, 25 Sep 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNKnXwyx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB52D9EC4
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808546; cv=none; b=fKLAT/GT8hTrMlWj/1Bva0p6fvPP9VLnIM7lNLMNs57TekHWjKA+Gyp9+FYeyH/bO5nX344gcwWv0yjLfcGNILYpwoquMDic9tUeLciBR7CS2OXPnzRedwqykP9YI+ACCc5VgHvQEoZVf+Tr7LdzoXnA/hx9R/I0f7u2+pxzCrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808546; c=relaxed/simple;
	bh=cGT2p8vWeMd9yhCscAqtKB14P0MqjieptZpD6VjuDnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ppr+JIiDycu8ohwxTfbl3kuwG0sEWV2U8iz/TCVY5OnyPfqkmtuM0ELiMHK5W8HsGsyjYzFKVLKPMIZNyWQuAy2CsPB1rqPnujCeBiv7iz0pUQD6+9XWqicl7r295Lbb8WjezkP7sxQiV+XB+7x9iSrv+HDUyAu8GOGYPXHF2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNKnXwyx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7960d69f14bso4707316d6.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808544; x=1759413344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAkOv1RieyKvIfCAhJItgJq0V7Rg1TFOU5lVc6t6PUg=;
        b=QNKnXwyxRNLHaB0G90cg4piqi+WLlffVo8gyhXvBR0dxXTRIJyhZ47K7ozqeszP2Gc
         6iZ5dHqRU53CX5dwNOX98mUQb78HSBEC9cBUAYmlWHLDvE+/qIyBiGJjgFEAJ/PSVWIz
         2dBfhUIFx9pZ4xMclW7yje4dGxt8pV/gXxZL7ynDXmarqR/OGueIIQEppDyAPqst+SKK
         ckWkTydWSBFrZ6GltJedHN4ms/EuId+U1MlEBk2y3IK2eSDLIAh33O48BxxUK/4ZPega
         i4v1X2yk5FylPajjOZO9eEpBfzWQEu5pKQqk9S5rbXvyW3hi1FQRg2gK2wwsX3GzXMRG
         7x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808544; x=1759413344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAkOv1RieyKvIfCAhJItgJq0V7Rg1TFOU5lVc6t6PUg=;
        b=YkL7o8aKRdoGjjP0HG2psmBpwk5AaGsbR8okQIYN03fPaPZ1pRYMAQ+eeFY0iJKRrR
         DbPOAb4Y7dIAswAvBS5mDeXlfHcet+z8LqUrR9X43xBhBpsX3Hrfa0yJ12Xc0XPEw/SZ
         2pWhjYTKi/1rV1Rd+2AH7jyiqR6V8V0+LLxdQrDZ1bsZuCo+NhRmzXmrQd8pj3HCSk7/
         yFhi3dlEoYl0aPEl++0QhJIYR10i0pHiuSv3emVDcWfoDCEB5nZGMertinJmSKMHjR7m
         rSwviQ+LlIkYN8L1s4VoE12R1P4iREeEtBo5ji6kvMvrgTaVv1DF/RLqlxLMQyWVd8BV
         PyoA==
X-Forwarded-Encrypted: i=1; AJvYcCVbGH7QiWvDAf4B5SGmzCxh/GEveBY1/dV+lVw+0JN8knrGKgrUQk9O1gPMiKRiif5XC/GB3hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIU6gQkAxv1s/GBpU02vItwBAVLR2G5XZZ3Jd2D5ZME8Udra5f
	sUeD7ArLEqv/3I8o4oRlraFPum6SszBUgQrik3C8IbBuAEAxsTbmBpTw
X-Gm-Gg: ASbGncvzEs0nXvua6GIM3WBDCsSHWiUDnuJ4rmYGC3dn6mbwpaQlx20G0guih5Qgti4
	Fw/1JRlUf5NBx07U2+WsGcgCNOCnYOR1qXjdw31jZ8SHueLMXYTT9NPZJVNzLbMOh/cLR5A/equ
	IVcGXUcf4sv2WMZXjKr2I7bblz2QW/g2KJnSNZYH+0dfkHyt/wPK1myGM8bmf6wpnJTtSvI0kOo
	RyjeT+1OCtt7HYj/00tjyjIpz/l8fSveQZyNyQ6yCd86purtLwjuy64Ct3EqhOMKQHYjeB2D/Wh
	rqt64Qf+3bEHKAeMEYADUP3cVABzrvCGpHcLBOJ4wgjMnG5g96hAjjMcU5I01IDh2C+69w0yfaC
	Z/RiJ/cWLoUpTPx77L6plmSq+4XShE/TstQLE53T5HTRL9ducfp8Hes+q5TrVanW/yzoFrUv/zH
	kpelLSKKg9Lt1nJWjbWdjQ1Bc+GnMgsJo2VGxVei+Bfb3pxKmYEtrRgGke31B8DCVpw8It
X-Google-Smtp-Source: AGHT+IHF9UuB9For1/7YW0Qxf6nPTFMieeyDSqN58eT9nYnL6TeBAODoPScd1hJnleJiIi565hDfTQ==
X-Received: by 2002:ad4:5bc9:0:b0:76a:fcee:97aa with SMTP id 6a1803df08f44-7fc309ec826mr47856686d6.29.1758808543310;
        Thu, 25 Sep 2025 06:55:43 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:02 -0400
Subject: [PATCH v2 14/19] rust: platform: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-14-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=6208;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=cGT2p8vWeMd9yhCscAqtKB14P0MqjieptZpD6VjuDnQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAqXnSTSLC5DSGmrQ0rUUvFP5bu0JMFwcjJ+FLO2nGEH20VIfZHuQ47CF/8jOiBsSKPADtt8TtP
 7X9bJlhhLGw8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/platform.rs              |  6 +++---
 samples/rust/rust_driver_faux.rs     |  4 ++--
 samples/rust/rust_driver_platform.rs | 30 ++++++++++++++----------------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8f028c76f9fa..d1cc5cee1cf5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -135,7 +135,7 @@ macro_rules! module_platform_driver {
 /// # Examples
 ///
 ///```
-/// # use kernel::{acpi, bindings, c_str, device::Core, of, platform};
+/// # use kernel::{acpi, bindings, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -144,7 +144,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_OF_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (of::DeviceId::new(c_str!("test,device")), ())
+///         (of::DeviceId::new(c"test,device"), ())
 ///     ]
 /// );
 ///
@@ -153,7 +153,7 @@ macro_rules! module_platform_driver {
 ///     MODULE_ACPI_TABLE,
 ///     <MyDriver as platform::Driver>::IdInfo,
 ///     [
-///         (acpi::DeviceId::new(c_str!("LNUXBEEF")), ())
+///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
 ///     ]
 /// );
 ///
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index ecc9fd378cbd..23add3160693 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -2,7 +2,7 @@
 
 //! Rust faux device sample.
 
-use kernel::{c_str, faux, prelude::*, Module};
+use kernel::{faux, prelude::*, Module};
 
 module! {
     type: SampleModule,
@@ -20,7 +20,7 @@ impl Module for SampleModule {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
-        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"), None)?;
+        let reg = faux::Registration::new(c"rust-faux-sample-device", None)?;
 
         dev_info!(reg.as_ref(), "Hello from faux device!\n");
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index ad08df0d73f0..b3fe45a43043 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -63,7 +63,7 @@
 //!
 
 use kernel::{
-    acpi, c_str,
+    acpi,
     device::{
         self,
         property::{FwNodeReferenceArgs, NArgs},
@@ -85,14 +85,14 @@ struct SampleDriver {
     OF_TABLE,
     MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
+    [(of::DeviceId::new(c"test,rust-device"), Info(42))]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
     MODULE_ACPI_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
-    [(acpi::DeviceId::new(c_str!("LNUXBEEF")), Info(0))]
+    [(acpi::DeviceId::new(c"LNUXBEEF"), Info(0))]
 );
 
 impl platform::Driver for SampleDriver {
@@ -126,49 +126,47 @@ impl SampleDriver {
     fn properties_parse(dev: &device::Device) -> Result {
         let fwnode = dev.fwnode().ok_or(ENOENT)?;
 
-        if let Ok(idx) =
-            fwnode.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
-        {
+        if let Ok(idx) = fwnode.property_match_string(c"compatible", c"test,rust-device") {
             dev_info!(dev, "matched compatible string idx = {}\n", idx);
         }
 
-        let name = c_str!("compatible");
+        let name = c"compatible";
         let prop = fwnode.property_read::<CString>(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
 
-        let name = c_str!("test,bool-prop");
-        let prop = fwnode.property_read_bool(c_str!("test,bool-prop"));
+        let name = c"test,bool-prop";
+        let prop = fwnode.property_read_bool(c"test,bool-prop");
         dev_info!(dev, "'{name}'='{prop}'\n");
 
-        if fwnode.property_present(c_str!("test,u32-prop")) {
+        if fwnode.property_present(c"test,u32-prop") {
             dev_info!(dev, "'test,u32-prop' is present\n");
         }
 
-        let name = c_str!("test,u32-optional-prop");
+        let name = c"test,u32-optional-prop";
         let prop = fwnode.property_read::<u32>(name).or(0x12);
         dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n");
 
         // A missing required property will print an error. Discard the error to
         // prevent properties_parse from failing in that case.
-        let name = c_str!("test,u32-required-prop");
+        let name = c"test,u32-required-prop";
         let _ = fwnode.property_read::<u32>(name).required_by(dev);
 
-        let name = c_str!("test,u32-prop");
+        let name = c"test,u32-prop";
         let prop: u32 = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:#x}'\n");
 
-        let name = c_str!("test,i16-array");
+        let name = c"test,i16-array";
         let prop: [i16; 4] = fwnode.property_read(name).required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}'\n");
         let len = fwnode.property_count_elem::<u16>(name)?;
         dev_info!(dev, "'{name}' length is {len}\n");
 
-        let name = c_str!("test,i16-array");
+        let name = c"test,i16-array";
         let prop: KVec<i16> = fwnode.property_read_array_vec(name, 4)?.required_by(dev)?;
         dev_info!(dev, "'{name}'='{prop:?}' (KVec)\n");
 
         for child in fwnode.children() {
-            let name = c_str!("test,ref-arg");
+            let name = c"test,ref-arg";
             let nargs = NArgs::N(2);
             let prop: FwNodeReferenceArgs = child.property_get_reference_args(name, nargs, 0)?;
             dev_info!(dev, "'{name}'='{prop:?}'\n");

-- 
2.51.0


