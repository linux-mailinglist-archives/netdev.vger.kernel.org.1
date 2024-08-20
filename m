Return-Path: <netdev+bounces-120365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB14C9590C7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BF4281602
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88161C8FBA;
	Tue, 20 Aug 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSWG40Du"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BF1C8FB2;
	Tue, 20 Aug 2024 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194752; cv=none; b=NCekvlzbLof1x2VkyVyf+nanyIdOGz40btG+YQ+1UoTcVQqNdghRHNmQS09JzYkNkvrKxcsXDEYQK8Ry7/xVwqwybAdftsnAASczZekPTGFf86ZGiQDyhprsrpgEAsDN9/R+ip7MumFHefjo3RFHhQcXEicn3+13eZaEVfq6rvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194752; c=relaxed/simple;
	bh=Z+3W+TjB/+akxnGD/81jh9rFeSs5dXy3N237wOpbV+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKJS/LiNM4r0i1//te05q/DaoLjqoA7LkrOZTcohR0NpVh9+Ke5li1803ss14v1LukfBb+lJ/9Uv/CbsHdWqJLbIPkLymqKQM2lv3NJvWuMX10yjJ8YOBQv2MfHDPjW6xrnqqrHsUQnLZw2W/C+Mr+ncdfc6sO9SABrRt7W0494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSWG40Du; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db2315d7ceso3395294b6e.1;
        Tue, 20 Aug 2024 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724194750; x=1724799550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEn+T3edq3AlPKEeI8Gs8XwEjBjg6OpikVH3BRZII5Q=;
        b=eSWG40DulNhp7lbKOjvE8xRp6LsEKrk7SFFxbtmZ+Vg0hhvn2ErJ7jJEXRo+IsHDb+
         M6yBsPjUrL4FJEAjOYifWvecXcxfr8/hkmDsckkODt8D/PYnVIP5ocATa9iJCWmQIXto
         p0pMQZ3BOfUkMHbs85WpqqlrtiK9RKO/45OJKNeJ4zhzv5qryl6zw0zIwZzJx/t7bZPm
         YtMRjee6Raq+VzWHgxG03dE+qBiqUcKCW+pd9Ex1nlTvMapj67VtJjI0l41uKLBYPnQ7
         s6nHCHzgBQvwRx1pwGP+w5+/9oK1nzcTQZvktpESlvoki3zJsrBoO2kV+ksHZDHWUJhK
         i9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194750; x=1724799550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEn+T3edq3AlPKEeI8Gs8XwEjBjg6OpikVH3BRZII5Q=;
        b=CfoDBB/sRPQW8E0rshf/H6CJcOF3l247fN1uYs42wfGGZ7YcIcY4XQYiPW1v3FIua0
         WUKJM2CLY9WdTXCb7Ud9ObK6RD8Bq5J/WXMSiVkZWlwfhKGfcLVU5eb+JI3aIPc18No/
         T2Y9ObCWoawnPf11YxJtd9bSWlVTTtlAxfwFOQ+i/osBG2rVzSI+LT10DUQR87uUSUA3
         ihKVn1HYvsDgC2a2Z/lvPXgrgjtG6q+vfqKynU//uoiEFta2LYBjw0AgSsQkicoUUj1S
         DcYlQ3C6ft4+tgS2GtoNPV7E0iXNKu30WRvhWMzUlGrQN524Xo0th2/6L3EwDgQ7DwQN
         5MBA==
X-Gm-Message-State: AOJu0Yw0xJpeoehg4EwgBkFQfUMOh9/9ZGjx9kWvDLM/O/1xBDirRmVM
	cxsikeCE9hCcGxCqxbPswUPZkjZsReMwlhwAIK9EbCp77e32tnAEnHZrvlLw
X-Google-Smtp-Source: AGHT+IHU6k1OH2U2QpMmPC0J/hjEHPnvHiWDulna0liDaDjOWrAtuSC2PTrt0VL4YmkL0JHks0yKdA==
X-Received: by 2002:a05:6808:bcc:b0:3da:4c28:6697 with SMTP id 5614622812f47-3de19576b4emr799559b6e.38.1724194750170;
        Tue, 20 Aug 2024 15:59:10 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61d5045sm9922076a12.38.2024.08.20.15.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:59:09 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v6 2/6] rust: net::phy support probe callback
Date: Tue, 20 Aug 2024 22:57:15 +0000
Message-ID: <20240820225719.91410-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820225719.91410-1-fujita.tomonori@gmail.com>
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
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


