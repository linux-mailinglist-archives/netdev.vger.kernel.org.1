Return-Path: <netdev+bounces-191292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53545ABAA62
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF20F4A087A
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD17F1FBE9E;
	Sat, 17 May 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImxvMX9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294C1F473C;
	Sat, 17 May 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747488504; cv=none; b=oOjWkHV5lSUu8RdxnJUOgDmX13j/VvZeVvTi41OHcKy+FM1FRTbM3GEun+16ccKNtvvyMLOKvPOmiyeJkTriVueJ4/d4KBIwTNYDKoEhJiFE/e1UtoGmDNul35BPFKoXFyNu7qzt6pdn8z/tb/1vWO74JQZeLQRMZPDgAEnSdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747488504; c=relaxed/simple;
	bh=S1MWY0PJeO+keP5r+TY+fV9VcsQvbmi76vsf+dgP8hw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bvpn3s8KWkUmV7+Ts/LEq6c1Lctf6jLP//kyp2Dtk4MMmo52Z38jAsTGwfujFMbuMULyeIrr7/EdMqdkh08VE7q01oWExlVybIegDXUBIZjM/ylH0QNwKLQt1vzdwQQtIKrEg03FjhEPZWMPNeA3TvzdQo4RueN3tOvO6P3sNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImxvMX9E; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b200047a6a5so3711706a12.0;
        Sat, 17 May 2025 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747488502; x=1748093302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ok+Jn31WmGz0SXzj4UmJNwMJtqo//nsvsVAqld9UWx4=;
        b=ImxvMX9E8Y/+h+VMKLoHrdT3XeavjrPofImFu4ueL/hehW7dKSG6QIHIOyXUeAoebu
         BT22ZyeBWBBysYS/vI8DpyZ3h27YiXltwB67J8GOD/K+tNP9QQisSq3m4QeCKWPwzqz0
         gojB4i+YyTLhGuL+IrjwonJ56yFCPBp82tAQwbkdT3n63pI4uxHgxQDIPh3IUUW2zvH9
         R92xTPAUguWFRWj+CrIhD6siFt7VZPwRv88iOhjnBPvT20fGLxZZhhGS3iIReRMoKAOO
         BjK8Tmm0nOVeC4Ng7xZbjLCRrxibRp3RW3R1a+9RIXQf8hqqQUxr+jdsjvzQb/xHp5iX
         +QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747488502; x=1748093302;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ok+Jn31WmGz0SXzj4UmJNwMJtqo//nsvsVAqld9UWx4=;
        b=I+DD0ip/dAw2yx+/NkRFfXo4kRJYTSnDVETh04J9U9ZpAmr7J8cEqMVg+uB0uuYO4Q
         9beY7pKFsmFl/NkSQrZMPw5Dh0W0aAOKLafm5o/Yucwz+o9fLumqHsuraPg7VY+CzKjZ
         P2ZJypnE2qcEnVGo0MdUksH3JmajGYtYwutyMH3nZ/l24p5sb3Xe005Dacqg5s8n0+XW
         2pCch2cm3XXGhvhTxqHik1TgWEeFmW3q1T/0iO8cVMsMR3dIXn3XO6uEAG/LbLjisSHv
         w9PiMuueM+Iurkv1AAYHaYjBMLZtsA5CkK7pQgqQVsrp2lYHPkNMgqM62KYr1xRPUor4
         W21A==
X-Forwarded-Encrypted: i=1; AJvYcCURp1dIGfVt+Ib7SG5uBLYXG0+9QQFPhWb+SKaN9oXR6NeLan8v6S6yHWgR+2NRjPNCZ2GvLE5nafDx1dgbCzM=@vger.kernel.org, AJvYcCWMOWVikQUefQ2za1GfuEy51C9VcT08PuPCOyFBhKU68W6rafuihiP+fwJhon1+Ut0FPSwQqSABNjd1@vger.kernel.org, AJvYcCWYgiVL7V1bHOKWlm/6qeipXeNgnYKhO91xMwoPH0ldLV/Olyn5pJKsVY7RX+A3WwVpNshaAZMq@vger.kernel.org, AJvYcCXTW16F/F5bVvESxe+VkLxgLFzftrS9R+f443lSzpBAPLWNBJVuwTNH18yZRXY15KMfCAEfmW0MHdodfaDV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MhQtpQGCtLJNpGlzFpKC/OVFeUR+QtPJOsyXHIloCgwCCy0T
	LvE6F+o+pDibV35+IBf2ECRT8whePwCuBQ6HMZLjXEamq0F8zzzkkn8W
X-Gm-Gg: ASbGncty/Cs5Z262ngp6QDPD4Hp8heB0Rj/xtoj+k/H2KVoCoNO9DfeFtOgqysQ74xt
	XUm1VgIN8A4H3fLk9+57aGHiMCVQO7DmEsPWkToXG1pMNT38sxMvYC8QJ+OlpQGoQrv5H312hD4
	Cg+rezvjSWQ6CZtOF8uMBb0UE0lV3D+iJLZa8tQFRo0H55ROty0Wfc+Q996NAFGPLLYgyndpATJ
	2WY1eJNXEDPTaQDkBq7+KhPcv1Ig1qX+lNcPa4lg4Aijm5Ip/EhOTp8CPGm2R1TLE3dfh8z6kUT
	xml1hK3p19sdfO15xjyUIwkNuwHM90daYVFcbYn6Biz/n9vu6MaIJsmn2wUMX1RoBxv74ote+ye
	LgNAam9dbXkNnuJnwBK3kv65sM6wJzroazw==
X-Google-Smtp-Source: AGHT+IH1yn0X4kPCK1uLV4MGl8bTGl35nSAlr0/UoFaLxgHm9QPrSBYXGKUXCH/5q+OGg4JXuR79pQ==
X-Received: by 2002:a17:90a:d2ce:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-30e7dc4ecb4mr9309953a91.5.1747488502263;
        Sat, 17 May 2025 06:28:22 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334016e7sm7006077a91.9.2025.05.17.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 06:28:21 -0700 (PDT)
Date: Sat, 17 May 2025 22:28:04 +0900 (JST)
Message-Id: <20250517.222804.482303667530450320.fujita.tomonori@gmail.com>
To: lossin@kernel.org
Cc: ansuelsmth@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, kabel@kernel.org,
 andrei.botila@oss.nxp.com, fujita.tomonori@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org,
 sd@queasysnail.net, michael@fossekall.de, daniel@makrotopia.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 rmk+kernel@armlinux.org.uk
Subject: Re: [net-next PATCH v11 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <D9YA78RFVQMH.QPUFXMHSVU7V@kernel.org>
References: <20250516212354.32313-1-ansuelsmth@gmail.com>
	<20250516212354.32313-2-ansuelsmth@gmail.com>
	<D9YA78RFVQMH.QPUFXMHSVU7V@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 17 May 2025 10:09:53 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> On Fri May 16, 2025 at 11:23 PM CEST, Christian Marangi wrote:
>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>> index a59469c785e3..079a0f884887 100644
>> --- a/rust/kernel/net/phy.rs
>> +++ b/rust/kernel/net/phy.rs
>> @@ -418,15 +418,18 @@ impl<T: Driver> Adapter<T> {
>>  
>>      /// # Safety
>>      ///
>> -    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
>> +    /// `phydev` and `phydrv` must be passed by the corresponding callback in
>> +    //  `phy_driver`.
>>      unsafe extern "C" fn match_phy_device_callback(
>>          phydev: *mut bindings::phy_device,
>> +        phydrv: *const bindings::phy_driver,
>>      ) -> crate::ffi::c_int {
>>          // SAFETY: This callback is called only in contexts
>>          // where we hold `phy_device->lock`, so the accessors on
>>          // `Device` are okay to call.
>>          let dev = unsafe { Device::from_raw(phydev) };
>> -        T::match_phy_device(dev) as i32
>> +        let drv = unsafe { T::from_raw(phydrv) };
>> +        T::match_phy_device(dev, drv) as i32
>>      }
>>  
>>      /// # Safety
>> @@ -574,6 +577,19 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
>>  /// This trait is used to create a [`DriverVTable`].
>>  #[vtable]
>>  pub trait Driver {
>> +    /// # Safety
>> +    ///
>> +    /// For the duration of `'a`, the pointer must point at a valid
>> +    /// `phy_driver`, and the caller must be in a context where all
>> +    /// methods defined on this struct are safe to call.
>> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a DriverVTable {
>> +        // CAST: `DriverVTable` is a `repr(transparent)` wrapper around `bindings::phy_driver`.
>> +        let ptr = ptr.cast::<DriverVTable>();
>> +        // SAFETY: by the function requirements the pointer is const and is
>> +        // always valid to access for the duration of `'a`.
>> +        unsafe { &*ptr }
>> +    }
> 
> If we go the way of supplying a `&DriverVTable` in the
> `match_phy_device` function, then this should be a function in the impl
> block of `DriverVTable` and not in `Driver`.

Yeah.

> See my reply to Fujita on the previous version, I don't think that we
> need to add the `DriverVTable` to the `match_phy_device` function if we
> don't provide accessor methods. Currently that isn't needed, so you only
> need the hunks above this one. (I'd wait for Fujita's reply though).

Agreed, to make DriverVTable actually useful in match_phy_device(),
further changes would be needed. I think it's sufficient to simply
make the Rust code compile, as shown in the patch below.

I can take care of making sure Rust uses DriverVTable correctly later.

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index a59469c785e3..32ea43ece646 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -421,6 +421,7 @@ impl<T: Driver> Adapter<T> {
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
     unsafe extern "C" fn match_phy_device_callback(
         phydev: *mut bindings::phy_device,
+        _phydrv: *const bindings::phy_driver,
     ) -> crate::ffi::c_int {
         // SAFETY: This callback is called only in contexts
         // where we hold `phy_device->lock`, so the accessors on

