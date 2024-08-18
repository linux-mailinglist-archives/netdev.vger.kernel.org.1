Return-Path: <netdev+bounces-119456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F42955BD6
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1A8282191
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC9156CF;
	Sun, 18 Aug 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e94QLEoc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AEF9FE;
	Sun, 18 Aug 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723966580; cv=none; b=hNZ6QLZWBF2tAMUwgknCxdbAoGlCl/a5SfM6ZQVWagyE4eXzdI6EbwY831OieQkfozbsU5OPaetxi6iIbXLi7gh/tTDS/PIZs8DjSybYDPg0bH87g9sMXWHgWraaTCXtNxFe+KXYPFyoH8YyE0jcSRjbZ1IBMf84tod+UDGAikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723966580; c=relaxed/simple;
	bh=aZISA6wr6BfSfqzgyukSOocnF79lbu7DWfeX4ZnEqkM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nV/NB2T3LUEyVZyK9QYoDbXKWktQgGn5Iqp495UjghE0ieyrT74J5MZ4MWg/EwwCfkCjt50AhTqkArRCJJIdaIlRsxDAdBG+XzRE2+MINZEnjDKh47MgdbfoRIOlInuT6znp8pHlf9kIWkesXBEJ/SCSeNo1KupGclRDyRbq0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e94QLEoc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3cc6170eeso582850a91.1;
        Sun, 18 Aug 2024 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723966578; x=1724571378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKu1GhYrVFjdYQJ2smfak0FwxPk+H7nVp8sv/NuodEs=;
        b=e94QLEocwxeEcGPVVpuuGF30k0Ix3cFvHITOs7sKu/bCsp16m5LWBnsfBQR6v4CEH0
         OOGMgMG88nJfy+fXFbJ1RVVtwKLLcPT58oeaKKQtL+Zgc+9iIqwSO6zVp0/DJfhx8Vd7
         kzojcJKgy8VZLs2DvnAtERyGaIaL9UCEXbiKGyO+XF5ymKuqqZz82sHn2J82rV9gpkyo
         Y7O17sQ3bCrEmr06P08nft1Iw4W8g+2CZzFjGNmzyIwMV8G22Oemgx9h4/pw2gJ1ec+l
         gsL3u+jxGS1N5y4ZWz+yWR1qbvzsUTISTnwJEnEJLSnAYb18VQz4kAcZ6TsJ1yqGy9kU
         VcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723966578; x=1724571378;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKu1GhYrVFjdYQJ2smfak0FwxPk+H7nVp8sv/NuodEs=;
        b=l3oQ9B1zDnmuhPKc8gZMeS4m4ikhXECgo9n5y1nAcaF5cuOT1+i9EeLWqvIIkZOa8i
         LXBWpbmYU0y/QgzIbyRnQq+PwytlssgSuj+wtQ2BL1MbCmaj/4bw23ZZnQFyUfFWO38s
         ZiS8qqR7zH5GnCScC5nox1IEEl2NRGEsCWfsqxec2GojYvGc7bRoT06VXk2KK1+rcZLz
         04NWMyb97qDN+OYr4Cr4Y1Mn0/4lrWegDH1AA3LHS4x3o/Ekj+tjoTVkN8f+Ha0yZ76o
         ugf53zKy7tm5pgYj5ozdkAgKpf7Cg+W0qkXMCc33VHh6VSc3icW49fJT2dzKw8Y4mlVb
         Wl2w==
X-Forwarded-Encrypted: i=1; AJvYcCU34lqzQta+5B3pKNhe5Koz4rYnTFEKzRUGT06vZzWiI0skqELAkGhmGbU72wsV1v+31RZfuQWkAnQXKU3qq64=@vger.kernel.org, AJvYcCXj9YYmQ8/E06pbgxnJaQ1CxjG+UCy7Jh1hY4gioYOCmQicdzVLxLiINSjP7XKu3zyfeZhdhFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/V4h5ZrH86ZgSv5HIOj5V0hPGoxtsTx6pB3Juhrqtfu0Sz2gu
	FIiyCJ/IsqMNXqvVJr9mBXZ/tF4yFE8JU0zU52rkJb6o5F+ZZVZs
X-Google-Smtp-Source: AGHT+IFGVIaES8BO4ZhbtBk37eRChoHZMdMdST0UoRJXQ5yeQ/emEPcs+iKUjfUJMlr1VRvI7ZLkzA==
X-Received: by 2002:a17:902:f545:b0:202:41cb:7d73 with SMTP id d9443c01a7336-20241cb80c9mr1421515ad.11.1723966578145;
        Sun, 18 Aug 2024 00:36:18 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038a756sm47045165ad.204.2024.08.18.00.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 00:36:17 -0700 (PDT)
Date: Sun, 18 Aug 2024 07:36:03 +0000 (UTC)
Message-Id: <20240818.073603.398833722324231598.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <9127c46d-688c-41ea-8f6c-2ca6bdcdd2cd@proton.me>
References: <a8284afb-d01f-47c7-835f-49097708a53e@proton.me>
	<20240818.021341.1481957326827323675.fujita.tomonori@gmail.com>
	<9127c46d-688c-41ea-8f6c-2ca6bdcdd2cd@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 06:01:27 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>>>> +impl AsRef<kernel::device::Device> for Device {
>>>> +    fn as_ref(&self) -> &kernel::device::Device {
>>>> +        let phydev = self.0.get();
>>>> +        // SAFETY: The struct invariant ensures that we may access
>>>> +        // this field without additional synchronization.
>>>
>>> I don't see this invariant on `phy::Device`.
>> 
>> You meant that `phy::Device` Invariants says that all methods defined
>> on this struct are safe to call; not about accessing a field so the
>> above SAFETY comment isn't correct, right?
> 
> Correct.

Understood.

>>>> +        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
>>>> +    }
>>>> +}
>> 
>> SAFETY: A valid `phy_device` always have a valid `mdio.dev`.
>> 
>> Better?
> 
> It would be nice if you could add this on the invariants on
> `phy::Device` (you will also have to extend the INVAIRANTS comment that
> creates a `&'a mut Device`)

How about the followings?

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 5e8137a1972f..3e1d6c43ca33 100644
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
@@ -60,6 +59,7 @@ pub enum DuplexMode {
 ///
 /// Referencing a `phy_device` using this struct asserts that you are in
 /// a context where all methods defined on this struct are safe to call.
+/// This struct always has a valid `mdio.dev`.
 ///
 /// [`struct phy_device`]: srctree/include/linux/phy.h
 // During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
@@ -76,9 +76,9 @@ impl Device {
     ///
     /// # Safety
     ///
-    /// For the duration of 'a, the pointer must point at a valid `phy_device`,
-    /// and the caller must be in a context where all methods defined on this struct
-    /// are safe to call.
+    /// For the duration of 'a, the pointer must point at a valid `phy_device` with
+    /// a valid `mdio.dev`, and the caller must be in a context where all methods
+    /// defined on this struct are safe to call.
     unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
         // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_device`.
         let ptr = ptr.cast::<Self>();
@@ -302,6 +302,14 @@ pub fn genphy_read_abilities(&mut self) -> Result {
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

