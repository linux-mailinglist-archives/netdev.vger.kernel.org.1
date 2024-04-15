Return-Path: <netdev+bounces-87864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D38A4CD7
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD0D1F227A9
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF555D73C;
	Mon, 15 Apr 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXwbB8+R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C757876;
	Mon, 15 Apr 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178046; cv=none; b=ecUWM36+6qNJJqiQMaINRA0PtVhgShgWpgj/Mlb+/t+Tr/VHKXe1QDHSfzpv7I1dm29gyaHTEjyeQ4LDe6Ld2omfG6VtWxtqXN7xn9usGtvz0jeMuO07UYnn8qgxs8QBnZu6GSCfrrOqc5lqzH6d+X7YsQLgBzVFBA8l7m6g3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178046; c=relaxed/simple;
	bh=ksei461v/kjUsGfd+wJGh9e0382A9W4NsZnA+JLB5gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cOy/SujTM09fyBwiNZ2qGUnGHNjM/ZuuSL3+pmYD6q2MWU8LiWyf4F8Bwlrs9RDXS0IauUxuEXtj/krg8ymhK7iA3TGJxAwtYWQaJc+OVsjHQz+79Mv63bsB4ys5Io6iIgnIjd9UmUNeMBWlZRPhciAY+rMx6DIVLxm7j+7uTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXwbB8+R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e45f339708so5334025ad.0;
        Mon, 15 Apr 2024 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713178043; x=1713782843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaBlxvIjzhIk8Qt+IPbhIW9BsmPzQyIbQPUOYV6Usl8=;
        b=iXwbB8+Ru1v2G9a+ELAz6TvfVdYpX88zDMhm8PIybi6L+6SJHVz4j/VdlicwQWCDLH
         2eWXuwKMjtnW5xPp3V9ED/F6j7vC1PaA92DUMvIHDHeBUx4UyVDnT+l6NCyY4NqQt+Uh
         A82DoB5PLGXJpobfk6MiE3KDCSYFvc0cfazhfuNJ6815dTjc5hWDIsVJ5U45aRGaWERC
         Qwx7eyI/+52kWoDVd9VjPDzJiT1bV1/slZhBk7vPT8icdWHHtXAEd+MgZ0Aqf1aiQN4x
         imlIv2CwSRKwZt0nWFxkZcGtY1MZYstuXhPXNyS0skrojxcTj33P7oZGgqOMuxcRZjSq
         9ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178043; x=1713782843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaBlxvIjzhIk8Qt+IPbhIW9BsmPzQyIbQPUOYV6Usl8=;
        b=kdmdBtnPA8k37+P6HpKRXRqj0lBCNVn/JdQdeEBa3zdF7fLxSrYxpAMUrHRlukeAF5
         j7otJPw71s3ddBiX82qZ8qxa7NiWyAK12OaNtL/FpjXsESJ/whUfq+6DocjMdH95ORVB
         iYpa9Se/Jez3u3FTA/LiobofFI+/SkoZiCPMMshJJ9hPHGUqX7f2PaDVIUZRQUNYJX8g
         huyC1hQolBPub4JfBSjxCIYObH035ozH9snC6Ne7y/FOWdcMOL7UwqtHT3lMSkLZSN2B
         RGYkvrF9HaHTuyXR9WBo5GB8djDJYF2h+GKn1BRd/7r8nPHpxCsX8J5ePPAET6dGhGnK
         sNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw3jVDgobHRgb0kb/oTehCnWA/WQZPwzBpV4QktlYAmrQpcqNAG7ocz9XomN6tYlJjGJYH1DmNzEXCOO2nbMjlD4gDbdOEQDbAyegi8wg=
X-Gm-Message-State: AOJu0YxEgMa2yB/ao4VPFnjg9OpGSf0+JLW73YSomFnpKtxlN8WhDcy8
	X+YZjBgE4A0ThIKGCr0HQQJ6ovFwI8NX8cBAT+b6XvBdbUwEyzxFVve6gxiv
X-Google-Smtp-Source: AGHT+IF0sPp1WW2BdNTKBq55dR2f88/opUxXD/GasCgBBnQYUbn8L9c2XhB0RcKgxvq0nSa3HjXBXg==
X-Received: by 2002:a17:902:c94f:b0:1dc:c28e:2236 with SMTP id i15-20020a170902c94f00b001dcc28e2236mr12263179pla.2.1713178042845;
        Mon, 15 Apr 2024 03:47:22 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001e20afa1038sm7807806pln.8.2024.04.15.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:47:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>
Subject: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
Date: Mon, 15 Apr 2024 19:47:00 +0900
Message-Id: <20240415104701.4772-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415104701.4772-1-fujita.tomonori@gmail.com>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support to the following basic Firmware API:

- request_firmware
- release_firmware

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
---
 drivers/net/phy/Kconfig         |  1 +
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/net/phy.rs          | 45 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7fddc8306d82..3ad04170aa4e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -64,6 +64,7 @@ config RUST_PHYLIB_ABSTRACTIONS
         bool "Rust PHYLIB abstractions support"
         depends on RUST
         depends on PHYLIB=y
+        depends on FW_LOADER=y
         help
           Adds support needed for PHY drivers written in Rust. It provides
           a wrapper around the C phylib core.
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 65b98831b975..556f95c55b7b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
+#include <linux/firmware.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 421a231421f5..095dc3ccc553 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -9,6 +9,51 @@
 use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
 
 use core::marker::PhantomData;
+use core::ptr::{self, NonNull};
+
+/// A pointer to the kernel's `struct firmware`.
+///
+/// # Invariants
+///
+/// The pointer points at a `struct firmware`, and has ownership over the object.
+pub struct Firmware(NonNull<bindings::firmware>);
+
+impl Firmware {
+    /// Loads a firmware.
+    pub fn new(name: &CStr, dev: &Device) -> Result<Firmware> {
+        let phydev = dev.0.get();
+        let mut ptr: *mut bindings::firmware = ptr::null_mut();
+        let p_ptr: *mut *mut bindings::firmware = &mut ptr;
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Device`.
+        // So it's just an FFI call.
+        let ret = unsafe {
+            bindings::request_firmware(
+                p_ptr as *mut *const bindings::firmware,
+                name.as_char_ptr().cast(),
+                &mut (*phydev).mdio.dev,
+            )
+        };
+        let fw = NonNull::new(ptr).ok_or_else(|| Error::from_errno(ret))?;
+        // INVARIANT: We checked that the firmware was successfully loaded.
+        Ok(Firmware(fw))
+    }
+
+    /// Accesses the firmware contents.
+    pub fn data(&self) -> &[u8] {
+        // SAFETY: The type invariants guarantee that `self.0.as_ptr()` is valid.
+        // They also guarantee that `self.0.as_ptr().data` pointers to
+        // a valid memory region of size `self.0.as_ptr().size`.
+        unsafe { core::slice::from_raw_parts((*self.0.as_ptr()).data, (*self.0.as_ptr()).size) }
+    }
+}
+
+impl Drop for Firmware {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, `self.0.as_ptr()` is valid and
+        // we have ownership of the object so can free it.
+        unsafe { bindings::release_firmware(self.0.as_ptr()) }
+    }
+}
 
 /// PHY state machine states.
 ///
-- 
2.34.1


