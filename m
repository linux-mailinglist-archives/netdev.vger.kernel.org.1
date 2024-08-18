Return-Path: <netdev+bounces-119465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E0C955C48
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 13:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77977281CA3
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9519BA6;
	Sun, 18 Aug 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrJOjU6x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E9A8462;
	Sun, 18 Aug 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723980324; cv=none; b=twz/cbeyb3uoWwVBRrrJIWm4Urdcj2Bo6CNYNQpAL+ctRtxB4E+/kmYTf2+bByfj4kNcyz2mpNMRIBZrEPuPOGU5q0lvlnWr99ZHT+P0csORU7vh1QZ4O/kOW+lLSdlji4xSS5r6K/EUjg9yC4AGMOriY1q355xTb/kgciC4Zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723980324; c=relaxed/simple;
	bh=I+nlJTgcpfXjw7iTbQM3GTWFWLDTeh0LS/SbRKrqs9o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nmVyTINDT/xy9PFP/Q643YI0cBTdS64tHbjAhb8wnD6iDocMO2De95EqB/UHuipXUzh+KXSPmn6G5y1P8cZgxH2U4gZRZwGHm1vJ45NDDcrKcm9ccWWHqophJnielcpSBBPuLNmH4Y/fnDyLH5kuZ9bV9l4ewSaT/xIqyx5HHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrJOjU6x; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3badec49eso435363a91.1;
        Sun, 18 Aug 2024 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723980322; x=1724585122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He7zFKY6u3JHBleBNSFHgAEOD5MYfZVUdXlGbGn+VY4=;
        b=SrJOjU6xV6zj/OCn2hWFBlUoaZ9PkQlt88DILjd5aWv60YmoT7utEUU48nh4Mqd/Nf
         rXeMM4A5AbevZl4w9wYdL3VMDqTxCQBCLqSNCoG4ayVZbuIr+Ucx4TXJqRljUCx6a9dw
         2SpPwLgJ167iO2SrSl60y82nfXQtc4JftFcjZei/5Er/Bi5+jO8TR/c8vzsNx9GkZOh4
         ewR2EMbqcx1l6RF1BcBTNf9lxOJKVizw0GODNBjBo3Hy5s4qNU5ZkmJqawZSeu/aTzYr
         xAECWCwhSH6CpPpx/qOnRrIUG+pmWEpPv8vy9i3TcN/R9rxhisVObvmy7w0+aX6lLCcg
         mFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723980322; x=1724585122;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=He7zFKY6u3JHBleBNSFHgAEOD5MYfZVUdXlGbGn+VY4=;
        b=ZCLCRwgEukmXSpag1HW3mUaYE5GglT+kFm4ltACn3Vk7K4KW7pSYnJ/Bv7FpFTwjjQ
         WqXtUSR/A8jFH+s1GO4HlJp1/PX1HeloTnwrHiVqUjGO83w5KuOPd5y0DDF14q1dGyzE
         GZTKRIRaX296Jg7yfSs/NJeWaD0GvN2wW72QGaoT9zyacVL6+J3oaoLMqsCsFLogXTmn
         /beTh4bhLFFlTZreI84WOn5f5IwchA8lefvPWNEnu5W85UjzToPkY6K4H7UgyJMid7F4
         uMdwfghFmb2gYzPgOrKHrFoi4XSHBdETCJ5Ahd0TvapRvgImzy//3ebeUwaSfNoexSji
         fhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy+euavI2a+7Q1x8V7hxUrjN5osw5Rn0s2J1cGtTw0FRrzPH/TDVAM0Px9N4DneuqyFOmC6IA=@vger.kernel.org, AJvYcCXf2FgiF2mopOg34loRMx1PY4+m8+wnvby6lPUPwajxKHD18nMvk20wWbUfNZI++Dx9nYYOaZXGX6iHAsrhcZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGHtrxsePCARTq33t+eZ+WBHmoqOn8dAeDHV8VAKDRp5ZTGKz
	/RzsF5pETQebxoBaFwud2PAVkt/gTLK+SbfZHLQ8qVrl58/C+yUh
X-Google-Smtp-Source: AGHT+IH1LTZqZr+pm2GLRZBlSnM9POIKV9mWTMP/6VAjTePo2USbMfkg3SxmCD5stz4bmUUaLchS9g==
X-Received: by 2002:a17:903:52:b0:202:c94:1462 with SMTP id d9443c01a7336-2020c941a8amr50602195ad.5.1723980322177;
        Sun, 18 Aug 2024 04:25:22 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031991fsm49511655ad.88.2024.08.18.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 04:25:21 -0700 (PDT)
Date: Sun, 18 Aug 2024 11:25:18 +0000 (UTC)
Message-Id: <20240818.112518.2098286584782950755.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <dc644e0a-516b-40cb-8c33-cf98ef0111c9@proton.me>
References: <f480eb03-78f5-497e-a71d-57ba4f596153@proton.me>
	<20240818.091533.348920797210419357.fujita.tomonori@gmail.com>
	<dc644e0a-516b-40cb-8c33-cf98ef0111c9@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 10:42:32 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>> /// - Referencing a `phy_device` using this struct asserts that you are in
>> ///   a context where all methods defined on this struct are safe to call.
>> /// - This struct always has a valid `mdio.dev`.
> 
> Hmm, I think `self.0.mdio.dev` would be clearer.

Sure, fixed.

>> /// # Safety
>> ///
>> /// For the duration of 'a,
>> /// - the pointer must point at a valid `phy_device`, and the caller
>> ///   must be in a context where all methods defined on this struct
>> ///   are safe to call.
>> /// - 'mdio.dev' must be a valid.
> 
> Also here: `(*ptr).mdio.dev`.

Thanks, looks better.

Here's an updated patch.

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 5e8137a1972f..ec337cbd391b 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,8 +7,7 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-
-use core::marker::PhantomData;
+use core::{marker::PhantomData, ptr::addr_of_mut};
 
 /// PHY state machine states.
 ///
@@ -58,8 +57,9 @@ pub enum DuplexMode {
 ///
 /// # Invariants
 ///
-/// Referencing a `phy_device` using this struct asserts that you are in
-/// a context where all methods defined on this struct are safe to call.
+/// - Referencing a `phy_device` using this struct asserts that you are in
+///   a context where all methods defined on this struct are safe to call.
+/// - This struct always has a valid `self.0.mdio.dev`.
 ///
 /// [`struct phy_device`]: srctree/include/linux/phy.h
 // During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
@@ -76,9 +76,11 @@ impl Device {
     ///
     /// # Safety
     ///
-    /// For the duration of 'a, the pointer must point at a valid `phy_device`,
-    /// and the caller must be in a context where all methods defined on this struct
-    /// are safe to call.
+    /// For the duration of 'a,
+    /// - the pointer must point at a valid `phy_device`, and the caller
+    ///   must be in a context where all methods defined on this struct
+    ///   are safe to call.
+    /// - `(*ptr).mdio.dev` must be a valid.
     unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
         // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_device`.
         let ptr = ptr.cast::<Self>();
@@ -302,6 +304,14 @@ pub fn genphy_read_abilities(&mut self) -> Result {
     }
 }
 
+impl AsRef<kernel::device::Device> for Device {
+    fn as_ref(&self) -> &kernel::device::Device {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that `mdio.dev` is valid.
+        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
+    }
+}
+
 /// Defines certain other features this PHY supports (like interrupts).
 ///
 /// These flag values are used in [`Driver::FLAGS`].
-- 
2.34.1


