Return-Path: <netdev+bounces-191544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A0DABBE70
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA63189BE65
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95E278E79;
	Mon, 19 May 2025 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrOuheGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AE27932E;
	Mon, 19 May 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659521; cv=none; b=rs4pQzHEo5116XWwnvOWdo4IKzpDbT8hX4KUlAsZUOwjxqr49awD6jn0Y+ipuA2zAl6Ezf05ckKgKoY7GTS1MK4JFcakWpQuhmgV57bFWWqc+mg4CYONBhXu2XF9GBsN3qoMTrnKgQfyHa/vcanZLpXOYhcdV+d85XrAhuEiRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659521; c=relaxed/simple;
	bh=oFuEsIyMtdHW4xr/XsspWnTkbzj3lSmpErD+ur42eYk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=boLsV8MxClkxTBrLstx953B4m6/1Rjweojjfc4CITTSIrM7GQ47v52SbBoPSRlRIWsH3qcPDZVrrQzbkXMegxhIaj8uoak4xFJAL+nFwgQ34UQHze5oNYRmigcnmnouFQkswf/qiOLieGJ2G1Obii87oEXTf4PhymckS2eMA1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrOuheGJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-232054aa4ebso12645425ad.1;
        Mon, 19 May 2025 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747659519; x=1748264319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/0KnmjPAzZe1jtRLxFL6PEohu3vN64d7ew6e5P7OhY=;
        b=UrOuheGJ5s0kEWypSX1FIQqCji37DQ07vELZccIRMwg3Itq3Y+vPCta4c+WQCcbdkl
         /axBFDE4fgnCrrOCYsfa+gmkEpGdoTpnDM4jdWmBgcUbSlSHMIWmbDTSuzHmjnyH4vNi
         6tuTuh8xOsMm4FXtZI1To3YgvhFd4ma7bCVVYU18K0Ms8mDOCs3B9sJd3i72sm5TYi07
         rrlj52eb1x4kqgjdh22Uv4bK0gzsRDFeoNIxpiE8UG18/PGlBP+pcSTyZx8nD4VYUsop
         W5yvflwos+r+IV71qpuBgg27T1Y8O6/rYZDJn4L5kbioKTfJnPTpk2K8cubfMn8jp1US
         XfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747659519; x=1748264319;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7/0KnmjPAzZe1jtRLxFL6PEohu3vN64d7ew6e5P7OhY=;
        b=RorGPJkov0PccxsiYSF7M1Nw7wzxEutPNpdBRZ0IrkTkb1dCOxgG8YolVDJeg3Qdl9
         YdQTCCJnBuQQs86KBZSmUEvUdy54JCl3eRBjN/1zAtQVZ3dwRmiQmBRJmj3aVq5h86l4
         GapJ+8lTJGyUIYjW7gewByiq+JZldtxhvYf9gd3JJ61c72hyVELAKd+pVnJRon94IYZj
         UHji5tQJ6ZH5hpVyva84C+mpNEQ8YyKBx9TQsVSUgOtm5eRbjzzqCfZfcme7+/6yCw1i
         TLkV0ypaof6/waKjFXXYMLrfBfrlErDHbR0A86VdFDv9zI0ZF5NUSdE4NqIH1l4jcf7t
         pj+g==
X-Forwarded-Encrypted: i=1; AJvYcCUFcJd7D5zG70QiRmgSMH66t6HrnVkYSe5ORMgsc9QNMoq8KBUoVWhhaDYkqClZF7QE1ZHRrYs9@vger.kernel.org, AJvYcCUXdsrRhKku7ICZY59fcmhwc0bCH2zuJMERSPhFn5bi8pfcsIJDuMSESmEh7wAaLlsGV3nvQGJgk1tG@vger.kernel.org, AJvYcCV3XKHT05DRiLhEN4IgBUFQKBX9rpi0V0g1QXEMTsBgIN/E1iXBIV9AOqoC4Xqdr8Z3mJ2+aMu2G6XWIiFj@vger.kernel.org, AJvYcCV4Tz5aqnRX631qk2Kz7ZZ/rLNMDxMvHxyWe/B2VI4PLJahG25l07MeRs3LOFBtDb78YVe10Tjbo84CzJ3OM+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZznNqYa6L3d5Z83j5TVPG8twFK6AHCqgMew7jgBFRLuGsTVrW
	t96BrmYnphOFellU37IlQDadSUoq/LZhJGi6Mo0XDv7A9nexGeND3+kJ
X-Gm-Gg: ASbGncuP+eMqn1zIwykyXTe7GM3UYI22hcJ/GKYZSb2hVSJH+Y0hcbjx1csAWrPlpTD
	xqL4qHdJyPZOgSs3hHwvMLFLaGPU91sIuCpfgn01kHQPAiCNljF7MmP+wR40g1Xf4hAFf80E15Z
	ILXrtsEsQmh0O/3KqE0z9YPXbY6EvBuBwUUnv+2vz+XfZqqWFAy11zunXNc0vG4uAdhD+qQNobE
	lnVG3KVGbbDZMQPAuCeIhOr0XSgqizRCdVmTz3njfs5r0nNiNqk15C6CjwrXbOzFmgz10ytIE7u
	sJJQLDMMOo8KYPw5rmCKd5891n1dCvFB65g3LPnfnriMuMENbsuR64W6vXHXM4dE+OqMu18PMY+
	OYXsxWgjucnDOwbEQMa4He/q8JZ0GDZHlCQ==
X-Google-Smtp-Source: AGHT+IH5hEvowQ5CPq6Wsmyc90mHajT0omFrAsJiS01Jw1RxAbnSbo1x0AV+uz2orEbI8LME+p49eg==
X-Received: by 2002:a17:902:c951:b0:211:e812:3948 with SMTP id d9443c01a7336-231d334d209mr176474485ad.0.1747659519479;
        Mon, 19 May 2025 05:58:39 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4815sm58526305ad.232.2025.05.19.05.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:58:39 -0700 (PDT)
Date: Mon, 19 May 2025 21:58:21 +0900 (JST)
Message-Id: <20250519.215821.1932215801961121518.fujita.tomonori@gmail.com>
To: lossin@kernel.org
Cc: fujita.tomonori@gmail.com, ansuelsmth@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 kabel@kernel.org, andrei.botila@oss.nxp.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org,
 sd@queasysnail.net, michael@fossekall.de, daniel@makrotopia.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DA05GA6QUD1R.1XR0GFPLNXPTQ@kernel.org>
References: <DA051LGPX0NX.20CQCK4V3B6PF@kernel.org>
	<20250519.214449.1761137544422192991.fujita.tomonori@gmail.com>
	<DA05GA6QUD1R.1XR0GFPLNXPTQ@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 14:51:55 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> On Mon May 19, 2025 at 2:44 PM CEST, FUJITA Tomonori wrote:
>> On Mon, 19 May 2025 14:32:44 +0200
>> "Benno Lossin" <lossin@kernel.org> wrote:
>>>>>> The other use case, as mentioned above, is when using the generic helper
>>>>>> function inside match_phy_device() callback. For example, the 4th
>>>>>> patch in this patchset adds genphy_match_phy_device():
>>>>>>
>>>>>> int genphy_match_phy_device(struct phy_device *phydev,
>>>>>>                            const struct phy_driver *phydrv)
>>>>>>
>>>>>> We could add a wrapper for this function as phy::Device's method like
>>>>>>
>>>>>> impl Device {
>>>>>>     ...
>>>>>>     pub fn genphy_match_phy_device(&self, drv: &phy::DriverVTable) -> i32 
>>>>> 
>>>>> Not sure why this returns an `i32`, but we probably could have such a
>>>>
>>>> Maybe a bool would be more appropriate here because the C's comment
>>>> says:
>>>>
>>>> Return: 1 if the PHY device matches the driver, 0 otherwise.
>>>>
>>>>> function as well (though I wouldn't use the vtable for that).
>>>>
>>>> What would you use instead?
>>> 
>>> The concept that I sketched above:
>>> 
>>>     impl Device {
>>>         fn genphy_match_phy_device<T: Driver>(&self) -> bool {
>>>             self.phy_id() == T::PHY_DEVICE_ID.id
>>>         }
>>>     }
>>
>> I think there might be a misunderstanding.
>>
>> Rust's genphy_match_phy_device() is supposed to be a wrapper for C's
>> genphy_match_phy_device():
>>
>> https://lore.kernel.org/rust-for-linux/20250517201353.5137-5-ansuelsmth@gmail.com/
> 
> Oh yeah you're right. But using `DriverVTable` for that doesn't sound
> nice...

Agreed. We initially assumed that DriverVTable would be internal to
driver registration and not something driver developers would use
directly. Now that this has changed, it might be a good idea to rename
it.

