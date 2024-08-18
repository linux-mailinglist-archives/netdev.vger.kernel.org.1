Return-Path: <netdev+bounces-119460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56085955C09
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 11:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30A2B213AB
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496117BA3;
	Sun, 18 Aug 2024 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmSm27VU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948EE38C;
	Sun, 18 Aug 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723972550; cv=none; b=k0mVo+O5sNJrfEaPce+8lEMWaj9v2DwkK0kEDaD3ad+HlkfKPMu9iVygcEH8HcRxsEr4CQF09RV3Jkfqao8+oq23RN6g9ZlPJUGqto8JK2onPLS8IUPwjkJWV787dIpt5oCr+JEgdCOhJnsESVylI5NFld14GpIZY0tkjLAbfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723972550; c=relaxed/simple;
	bh=angU1JtYDNr07kSSnp/cyiZ/J7Osvm6y+lJ/V9O/HZs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aAY7TETE3D2sgUF5J8EPv9xutg0X/B5d8eMXl+74skIfQoO5n6sTRFuGNNjRclwPYmfOAOj5uvxixiRPHNHa1EIFQchRLGb3tjDNONPQHeCeM/xDe2D4x65LQClc2S0jmjZOjbe9brR13CDPf9i2QNiXW8Nb2ku0H3wPF4fXsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmSm27VU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3cc6170eeso590795a91.1;
        Sun, 18 Aug 2024 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723972548; x=1724577348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwX/d1L29zJUnAd7oNsQReRoZyznn9Hz89bALYLjHnQ=;
        b=PmSm27VU0xJ4iRS3Dby1U8qOrshV5FuI/p82/IhsdEkZG2KEHPpejOv+1k06FyBP6O
         A1YMQZtZufpTkjJ+kw2d5o5qJ/kZthbFmueH/uUXr3n/POHL4IPv1xlp+80pJ84OPpXF
         f0HfSer2eK31ZdiuCUZkocvKhWg3stbMdkrAK9sKCAbcwFc5VrkJgz02QmeTqrUb8Q1d
         d6/6qn4bclAs8Ds8uKrjw4ES6pisZxube/ISGI45A0bw7j10/4nBKf6droC2xlox0Q1H
         uEud1Ae96J64ucNs3XtuHcju0SST6R5525ljzvgG+ujnZzQAsN8Dna960lwaNGyumGx5
         C1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723972548; x=1724577348;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QwX/d1L29zJUnAd7oNsQReRoZyznn9Hz89bALYLjHnQ=;
        b=uttiOt/ak3xAlIr4dNDzYF9fpC43eLYr/kswVAagI1vytyc+2RTrhXUp65nInRCWPR
         xdrqwjutGt3vXXpczveYNI/Q0TKqSLyhSBKMnVp41ly+cXtZM5btYV5Q+FEmSzRvTwnN
         mP4vz/YP5+lz5kGF308ToSnfGwcA6pg4Ne8/V+5nD7hklzrm+ZcW5POZQ7qN5qRmcRkm
         rYx1YOpyMN7oBlSrH4n2xaeGxxGmFiTko58TJgdhexRFbvPEMfiNqNpr56JALXhJ/VUR
         Rqp8Zp7noJ3egfcZj+UDX8EIOQNICSRrP2wUUgBs0y9PpOLG/+Iaw9MFVDyQeKapwfR4
         lp/w==
X-Forwarded-Encrypted: i=1; AJvYcCU68uejImHGZSxrd2Gni2iEi1cqDoQhGgRWiTfTyb2AOLkyF032GD0pBbWNA7FGheOqhaS3egg=@vger.kernel.org, AJvYcCVy/rXInm1aJTZRThTc0zg6O1lUccogCGdLuf6R1DMAeWFKnXTI4Va67rypAhUlLOHVSOd7wotaeBn5ITANzmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzckuPCRR/DT5aaDEgRzhn84y1UgiKUSb5jLgL8tj0dDJyT1OQ
	Ave1n6wcfYnVVvhGUsH33ctRh0X8yT19s6brJiMErPSwrglrhiZR5FK9QaXs
X-Google-Smtp-Source: AGHT+IGTXJyZtpnri8sf+9MP5ipFUtJRRGyV5NGyYI4W57wgvGTvM8ewCFHnvJLb+8taUjyA9AG38w==
X-Received: by 2002:a17:90a:fd01:b0:2d3:da94:171 with SMTP id 98e67ed59e1d1-2d3e05610a9mr4955995a91.5.1723972547529;
        Sun, 18 Aug 2024 02:15:47 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d958cdsm5109931a91.49.2024.08.18.02.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 02:15:47 -0700 (PDT)
Date: Sun, 18 Aug 2024 09:15:33 +0000 (UTC)
Message-Id: <20240818.091533.348920797210419357.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <f480eb03-78f5-497e-a71d-57ba4f596153@proton.me>
References: <9127c46d-688c-41ea-8f6c-2ca6bdcdd2cd@proton.me>
	<20240818.073603.398833722324231598.fujita.tomonori@gmail.com>
	<f480eb03-78f5-497e-a71d-57ba4f596153@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 09:03:01 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>>  /// PHY state machine states.
>>  ///
>> @@ -60,6 +59,7 @@ pub enum DuplexMode {
>>  ///
>>  /// Referencing a `phy_device` using this struct asserts that you are in
>>  /// a context where all methods defined on this struct are safe to call.
>> +/// This struct always has a valid `mdio.dev`.
> 
> Please turn this into a bullet point list.

/// - Referencing a `phy_device` using this struct asserts that you are in
///   a context where all methods defined on this struct are safe to call.
/// - This struct always has a valid `mdio.dev`.

Looks fine?

>>  ///
>>  /// [`struct phy_device`]: srctree/include/linux/phy.h
>>  // During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
>> @@ -76,9 +76,9 @@ impl Device {
>>      ///
>>      /// # Safety
>>      ///
>> -    /// For the duration of 'a, the pointer must point at a valid `phy_device`,
>> -    /// and the caller must be in a context where all methods defined on this struct
>> -    /// are safe to call.
>> +    /// For the duration of 'a, the pointer must point at a valid `phy_device` with
>> +    /// a valid `mdio.dev`, and the caller must be in a context where all methods
>> +    /// defined on this struct are safe to call.
> 
> Also here.

/// # Safety
///
/// For the duration of 'a,
/// - the pointer must point at a valid `phy_device`, and the caller
///   must be in a context where all methods defined on this struct
///   are safe to call.
/// - 'mdio.dev' must be a valid.

Better?

>> +impl AsRef<kernel::device::Device> for Device {
>> +    fn as_ref(&self) -> &kernel::device::Device {
>> +        let phydev = self.0.get();
>> +        // SAFETY: The struct invariant ensures that `mdio.dev` is valid.
>> +        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
>> +    }
> 
> Just to be sure: the `phydev.mdio.dev` struct is refcounted and
> incrementing the refcount is fine, right?

phydev.mdio.dev is valid after phydev is initialized.

struct phy_device {
	struct mdio_device mdio;
	...

struct mdio_device {
	struct device dev;
	...


