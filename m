Return-Path: <netdev+bounces-89222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB1E8A9B63
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB7E282612
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC2146005;
	Thu, 18 Apr 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFXmUxwk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A11411E4;
	Thu, 18 Apr 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447324; cv=none; b=r7J5AutYJ5WmUvISjxsT142MdFZn/nX2wKK7PfzjC8dxJPGCSe1swY1iElwPzwdHD9Of6hONUZagHy8o7m2VyClyURodyDvneCt2sMjLAt8/wHR5g+KUj8MlgDXS98MSu/17nnKXxni8gW4Oxql+3569nXfjscgv1E3GYeEr1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447324; c=relaxed/simple;
	bh=GHcWg8xMlKQHbp/W0r8Tw+Ei2EAuP/0oWQw8TdvUzWs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=egOvJp3iblMeYKOwQDesc2Qe/nTn9e8RsgBC5VbGREKt8wTRc7ZBmhgzbCnfNOZVNdQFhTu8o/qIJrhNjB1adKoOx8kHHv2OZni/EbfdmqoBmtWbBtTMekUapa04GKLQTlGR8OBnKQCMtF8pBnL/I2R/0hVZQ3785ZePYN4JLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFXmUxwk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d862e8b163so229387a12.1;
        Thu, 18 Apr 2024 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447319; x=1714052119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPNCQjwFtl1wCNPwQLt88ugCpW4RlnqoD7yNsANf8+c=;
        b=HFXmUxwkc+CXFIcKUsuTETU3kgavSdfO7hinwTwTGCn3ZY10UEf3M7IiBWfAIvQNgM
         0pHObotb8z34WtjzkAYY6XpgkfwlZRKqUZp3MqeL10AYu5XGRNy/tXnL4fwXGwof0LS8
         RXs/G3xtM2HJt+aAT7SXx8lSaydUwudSb6NB5rvJrK0UFfiVx/bMiXwiRNLc3yY65HaA
         OoTXpWQjSqZun0GHMA/YWpLzpF2FcbCbE5pS4YZckAO3rxm2wdTBy08qe5Hl97PPW12A
         8Yr/QoCUzmORklViY+UHA4DJUOUSC1/8mRV9rtqBhWsx890PKa5y3MHW3leFprRqaDS4
         a7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447319; x=1714052119;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vPNCQjwFtl1wCNPwQLt88ugCpW4RlnqoD7yNsANf8+c=;
        b=fSCKTin+6P5A+GsR68qlUxIOLCPk93oxWBeW/qZ0gssTc4sEv8StQOy3MYbjD7V0YG
         O1Gi62MzrdBnzRkgJM35WSHRvJyccudfp7VcopUwU1fNwC3EuqSHOh1+BvA5dO5ZPgSI
         ywCiKSdPMlnLdJbn5psJy1S4reynxEo5NUbGg2IrlCWfmvZ+dxVEFR8CNWXiONIZrmlI
         DYHUwMCItOV6SMbXBxj4d4jZx5LTEpgerqrtvDndSn6gwuMfNW/ATlRExYWWAtPa6z61
         5Sv8uCTt/xbxG6qc5cyjP79ZPhFaDf+/8BLzL6g1iEgjV/Fytn6k5BwIJlvjHwiWkBct
         jdmg==
X-Forwarded-Encrypted: i=1; AJvYcCWwwtB/JRfLMc4AKesDW/YuDGQcimNouWPsbgCBUnQeB2j31fXBl1ozM78a2VNFw7CVYrPQs/gtBkAGfiM2e08X537DakpgobM3oadJD2LiSZQmwA0DVq0sI2PrRwMngGgoHpg6kCI=
X-Gm-Message-State: AOJu0Ywvtv6V1EhCPtYHugIOB+ZqCMwhQ7sEBsZ/AmMEr4nA0IjasvCx
	gieNB+9vHQyfVOTZGaZ1hhQAwBtwMitAKLr8/vXnS5soX7ZeW3JS
X-Google-Smtp-Source: AGHT+IESJo3tUDg6w6iKA/ZFR4+ySWD9UKFY7lCTYdxze+XW9+dKMEInu+mo6hiktPLcVmj5GXZ2YA==
X-Received: by 2002:a17:90a:d196:b0:2a6:d054:3214 with SMTP id fu22-20020a17090ad19600b002a6d0543214mr2824468pjb.0.1713447319287;
        Thu, 18 Apr 2024 06:35:19 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001e3d38c9e70sm1489521plh.125.2024.04.18.06.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:35:18 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:35:08 +0900 (JST)
Message-Id: <20240418.223508.1645077134421913977.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, mcgrof@kernel.org,
 russ.weight@linux.dev
Subject: Re: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2024041800-justice-rectify-3715@gregkh>
References: <2024041554-lagged-attest-586d@gregkh>
	<20240418.215108.816248101599824703.fujita.tomonori@gmail.com>
	<2024041800-justice-rectify-3715@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 18 Apr 2024 15:07:19 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 18, 2024 at 09:51:08PM +0900, FUJITA Tomonori wrote:
>> >> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>> >> index 421a231421f5..095dc3ccc553 100644
>> >> --- a/rust/kernel/net/phy.rs
>> >> +++ b/rust/kernel/net/phy.rs
>> >> @@ -9,6 +9,51 @@
>> >>  use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
>> >>  
>> >>  use core::marker::PhantomData;
>> >> +use core::ptr::{self, NonNull};
>> >> +
>> >> +/// A pointer to the kernel's `struct firmware`.
>> >> +///
>> >> +/// # Invariants
>> >> +///
>> >> +/// The pointer points at a `struct firmware`, and has ownership over the object.
>> >> +pub struct Firmware(NonNull<bindings::firmware>);
>> >> +
>> >> +impl Firmware {
>> >> +    /// Loads a firmware.
>> >> +    pub fn new(name: &CStr, dev: &Device) -> Result<Firmware> {
>> >> +        let phydev = dev.0.get();
>> > 
>> > That's risky, how do you "know" this device really is a phydev?
>> 
>> That's guaranteed. The above `Device` is phy::Device.
> 
> How are we supposed to know that from reading this diff?  I think you
> all need to work on naming things better, as that's going to get _VERY_
> confusing very quickly.

I guess that usually a path to a module prevent confusion. For
example, a MAC driver could look like:

fn probe(dev: &mut pci::Device, _: pci::DeviceId) -> Result {
    let netdev = net::Device::new()?;
    let phydev = phy::Device::new()?;
    ...

    Ok(())
}

