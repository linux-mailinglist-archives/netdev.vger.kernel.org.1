Return-Path: <netdev+bounces-201128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D6AE82AB
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27AA172FDA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595325FA11;
	Wed, 25 Jun 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTDh6eO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F825BF19;
	Wed, 25 Jun 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854347; cv=none; b=cGE93Mc+LuilIepKJdzNsD8ElHZXVbi5BrLFRcz9p5oSlZqnsbpRTDNaA9FqfAwgFhI07+SgIzIe4k0MnP2DNQvTFwJlMRU6Aqfd1gpcQSwHigRukkzw8HAsMABoKY9P5nuIWKTma0W1zeR8JPtI/19O9AaXPnsRAtdfBrzlBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854347; c=relaxed/simple;
	bh=YRXmrqvP3M3tB2iy+7DSsufyltwbs2fauGg/i1jbcu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6YJFvAZ+pKSUhMNFrthmMfm6BdhibQw1qStBxcHKu5z0YgFS+djPZMDrh3jvey/I7a+9Zx2PkAnxUclEFyejngjk627kwF+Fye3v23oODFHe4GQDqEru0vv3tZTfIvOIZSST2HT/tWcaI5Chxj2ieL93CpyQzzj3zbO7N4/K8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTDh6eO7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23602481460so17502865ad.0;
        Wed, 25 Jun 2025 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750854345; x=1751459145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQx43JAoJGCGCTWMGPvD7Db1D0wY/v2UilUjcKIQhZ4=;
        b=GTDh6eO7HeMgl+13HrA1pm1v+RVOvRXcZ02UF3dPIzeAgLCcAahCjX8HYuoh71k9Bv
         YBDV9Oh0L/NgwAwAHvSHOf4PBjywaG1iuxooDRQnN6CgiwNdvDENIFWYefKHcBNtDvH1
         EayFfLad20P6PH8kHsIAzBKgrBQdQxvPj3ekys9uF0H4ItKRorx1XfhN/7M6d57HPdrj
         PI8NXR5ZPI0rcWgvJSLRfN5OScFyLHJQtAajEZrfy951wxBkOPJGbsGmkSVcp+NxqStL
         lywO1fy0YYY3Ba3pQlSCMB/y/5eey+ZI/t55awtoSltPC51JgqgJ3ITQxwwbl5/OiWxx
         cf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854345; x=1751459145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQx43JAoJGCGCTWMGPvD7Db1D0wY/v2UilUjcKIQhZ4=;
        b=olWBDvQ0ALY0SUa324QhNydjpGI8mblplB5v3AmqxeqpJCjwcCCRaqJOIPmMEX3PNa
         dliSyGu53uR8yOAImBD6GrWoW9pwptjoh0K6WsOG3cbEHMXsYK+1kzZXdbCpmfNltYf7
         HWSxEUy8N9An2xSw9mXow4h2VhVsUo/vcuJIsUgPcaoTGAfZYCe7EM/Xyz91AZ6UreJp
         hA4PEeQ6DQyDPEGtgBSGadc4QXSViwZ71t+o4iHSHDPrwT1O4dzvYDqCkSbjOoc9rjES
         amPZ+d/H+LMHesuXn5inZMi/b++FDX9Q8qCZ5NPp5h5MUPOJT2dKWILVa13kp20eAofs
         mkMg==
X-Forwarded-Encrypted: i=1; AJvYcCWjbq+ubtpN6LmpYiY9kF7zanr0QZ82MZhcu1ofWvFCVx0IBIgUiCBEawehFzCSQmtGjMHIxo8NavSVMU8=@vger.kernel.org, AJvYcCXf0t/XmIUmSL4Q/7YxFeIPXx/Y+hVhYie6frKQ1IBV/Y15oF8JMYdB/vmPq0jYx9CvfkkPpH2W6lfxKa1U66c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwskIxpJ6fcNDWhLpMBsPl3ka13ZdtjjKX5nQB6R49pusTlYvR9
	qBzM9HR+dUDUgZf+Hwdc2I+qKJPjbT7UuvurAO7bmd3K0VIZoTUoduBL
X-Gm-Gg: ASbGncs/8DbS0v8HBdxionj92dS/BE+Jxs/DNWh5yyhdtpWcqkG8R5joL46zD6au1ns
	td17xdjL97pT/NLkeS/iAe1MJJ43mMkewKSNTCf/ObJdkvk6sHIneD/ruGUf+nWOBMhimfzZuGP
	uprDVCechb8h32mlMRid7cl/qWCCSYFHBI4haOih+Qa1njNNatwL7GRIocuXTp43cn8L9iho7N0
	hDT/PEoT2f+ZvC03o136OIuemQKDs6oVvqr0mgfiSC7JbLgyXd3wpuZ2De2oZLHbfzyBCwhkKFJ
	UDuPwaHxInaJuF3sGLsu0lYtSZlba8/SNCWFyCbnsl71/xmOeYxRGjjzfp4Zfk4HBDbGtN8wpvr
	bHsn6rlJbVexnH0s9+rS950UbD2mtpeJm9WTnauI6+fhfcx+JNO3rS0vQ
X-Google-Smtp-Source: AGHT+IEi8CWyMU673+BCBQHzKVzK6rWZJmwPlwuPsnwkOjHOqfKVf+EzvwqVyPcy3sTt99q1VqQR1Q==
X-Received: by 2002:a17:902:da91:b0:224:26fd:82e5 with SMTP id d9443c01a7336-238247987ccmr51072835ad.48.1750854344507;
        Wed, 25 Jun 2025 05:25:44 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([50.233.106.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ea243sm137551405ad.72.2025.06.25.05.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:25:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 25 Jun 2025 05:25:38 -0700
Subject: [PATCH net-next v2 1/2] Use unqualified references to ffi types
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-correct-type-cast-v2-1-6f2c29729e69@gmail.com>
References: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
In-Reply-To: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1750854341; l=4578;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=YRXmrqvP3M3tB2iy+7DSsufyltwbs2fauGg/i1jbcu4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBoKBgtgkGMb4d+aGKpEutO9jimAlYOOxMhT+JLyoYfd3r2VHzuhFKYRtaf53ZUtw1DQ27+ThmE
 N7Vo2YRpX9Ac=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Remove unnecessary qualifications; `kernel::ffi::*` is included in
`kernel::prelude`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 65ac4d59ad77..9b4dc09403e4 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -312,9 +312,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn soft_reset_callback(
-        phydev: *mut bindings::phy_device,
-    ) -> crate::ffi::c_int {
+    unsafe extern "C" fn soft_reset_callback(phydev: *mut bindings::phy_device) -> c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -328,7 +326,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> crate::ffi::c_int {
+    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we can exclusively access `phy_device` because
@@ -343,9 +341,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn get_features_callback(
-        phydev: *mut bindings::phy_device,
-    ) -> crate::ffi::c_int {
+    unsafe extern "C" fn get_features_callback(phydev: *mut bindings::phy_device) -> c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -359,7 +355,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn suspend_callback(phydev: *mut bindings::phy_device) -> crate::ffi::c_int {
+    unsafe extern "C" fn suspend_callback(phydev: *mut bindings::phy_device) -> c_int {
         from_result(|| {
             // SAFETY: The C core code ensures that the accessors on
             // `Device` are okay to call even though `phy_device->lock`
@@ -373,7 +369,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> crate::ffi::c_int {
+    unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> c_int {
         from_result(|| {
             // SAFETY: The C core code ensures that the accessors on
             // `Device` are okay to call even though `phy_device->lock`
@@ -387,9 +383,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn config_aneg_callback(
-        phydev: *mut bindings::phy_device,
-    ) -> crate::ffi::c_int {
+    unsafe extern "C" fn config_aneg_callback(phydev: *mut bindings::phy_device) -> c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -403,9 +397,7 @@ impl<T: Driver> Adapter<T> {
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
-    unsafe extern "C" fn read_status_callback(
-        phydev: *mut bindings::phy_device,
-    ) -> crate::ffi::c_int {
+    unsafe extern "C" fn read_status_callback(phydev: *mut bindings::phy_device) -> c_int {
         from_result(|| {
             // SAFETY: This callback is called only in contexts
             // where we hold `phy_device->lock`, so the accessors on
@@ -422,7 +414,7 @@ impl<T: Driver> Adapter<T> {
     unsafe extern "C" fn match_phy_device_callback(
         phydev: *mut bindings::phy_device,
         _phydrv: *const bindings::phy_driver,
-    ) -> crate::ffi::c_int {
+    ) -> c_int {
         // SAFETY: This callback is called only in contexts
         // where we hold `phy_device->lock`, so the accessors on
         // `Device` are okay to call.

-- 
2.50.0


