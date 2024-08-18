Return-Path: <netdev+bounces-119445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD2955A93
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 04:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B43D281EC9
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 02:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305D3D6D;
	Sun, 18 Aug 2024 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/4Q96Ih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B23232;
	Sun, 18 Aug 2024 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723947238; cv=none; b=GkdQWq4Uu4Djv/zHwzWRty/wh1/mSmxlQ+n2KnUshjjAm0+2Li5Ye4CodWz3T3CS8/JZsuwQ3rEO3iWpVCIglHk/dNxlEf745RXqbvSB+6Stm19Ny6YYUv9EXYdCGwlWa+LhgN7buFqliBMLiyjJmQKjzx+G+LJ/70vNtmXxE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723947238; c=relaxed/simple;
	bh=rTQIpkU5uq6a3oGKPLuD1Y3hwtiAcxNAQ6uSk5oQfPM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tb16Wi1tj4JbhItVi/O+SyiIokq8HzXIHPXt/8CUx8FKRXnm5JXaW/Xd92gFrfpyBP6YMYXVRXae0NxOatTsYlSUDdNMb9+oB8vSw1XCmSQEVW5jvpzu2DXQ0lLrR7OBI/LGhWpt+0LYxmOHnesQL1yT8a0eahokWMSclKdXgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/4Q96Ih; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c3e70fb6dfso84336a12.1;
        Sat, 17 Aug 2024 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723947237; x=1724552037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI8tlLsucAaJqcmXRnU/o0z1STasobgl0+vHWgKFG30=;
        b=V/4Q96IhtLGZ+fsl35lVtGiszEz2AGA789udeM2mn8taIx3Zt6wAwUcdkJj7/ksiMV
         N7Q9+782wEjWnWl22q6Apw3uVapezIli0NuPcjKe578YnXaBJVmoCW2Gy1cnveOlBHUQ
         qb4OXWvFFGe5CRDuneBIPxf8TDJMHSZvfw+An5qq5ghQHDogR2waXsC6wnyt8m8TAnWw
         FnwmpO5X51wiHjRwY1FP09rP//d6l1YFzJCWd7NZ/2yyGQj2rWSViM6r2RhdC9x0lKIL
         8yDtCyiUVn8qIM5h6+pFRme8VsmYFCbPxEvLmgYRpdbp83EJDyxfj+uDZi8b4m77b/NN
         howQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723947237; x=1724552037;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hI8tlLsucAaJqcmXRnU/o0z1STasobgl0+vHWgKFG30=;
        b=VRaf0zrJvnipAgkuyYqha86mCZe9WrdMUW+i4sCLgiv2yclmXZJ1VEpno8dH72JZVV
         K3IurhFkWPoOEMfE14rChD/N/xjmkb1DB94rAcAoxLN2tYp/3Ww5r1c8BTgqSR3NiwbN
         GZiTBju4y3ViuD2+5wPfP3mk6GuuF7lORZrL40PY/2RHX5gOnL/VFTer/4XGTofOZSQl
         474VsDghP08QNHsYKsQWLZjMxdOvS2eXgmosc7I93npsxUAAZDfefHooWK/1jVYVPRhH
         /x9BBEpFet7dGn6/xLSNfnBs1HlFNfmvW/uf/XKvGGwBPSNWb0F8u4csN+Y5zn42bSz4
         gOZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJucf+F8BvqwJmp+3uEngkWwaYOeKEtTf23b1ERshgk1kWcx38LWBO+INWovsJB2CyOj4yL//PGpAckqhmTmA=@vger.kernel.org, AJvYcCViLfoQjLC+CkHA8QL/ljVZjbpRL6aKGygcyTKNqnO7u+dtR7nQ10vlMhNMfuLu1zttKwVs1wI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rJlo9S+N767XLV0/ot2Y7qJJOnUX2h+mXEeviyCHwcXYeNz9
	D4ehoycL7P3R0Rwhh4EyHE3N7WNzcWo6cmG+S5EwXiEqEchOvSZ+
X-Google-Smtp-Source: AGHT+IH1zrqM6iGZ7VjC7cRBr1+4l+8+hBC8Oha8cYObln0VXFcw/rtqHrTG2m2AiuLxzRJSYT7GeQ==
X-Received: by 2002:a05:6a00:6f01:b0:710:51cd:ed43 with SMTP id d2e1a72fcca58-713c4da26a2mr5559558b3a.1.1723947236535;
        Sat, 17 Aug 2024 19:13:56 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef410esm4597422b3a.113.2024.08.17.19.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 19:13:56 -0700 (PDT)
Date: Sun, 18 Aug 2024 02:13:41 +0000 (UTC)
Message-Id: <20240818.021341.1481957326827323675.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <a8284afb-d01f-47c7-835f-49097708a53e@proton.me>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
	<20240817051939.77735-4-fujita.tomonori@gmail.com>
	<a8284afb-d01f-47c7-835f-49097708a53e@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 17 Aug 2024 13:30:15 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>> +impl AsRef<kernel::device::Device> for Device {
>> +    fn as_ref(&self) -> &kernel::device::Device {
>> +        let phydev = self.0.get();
>> +        // SAFETY: The struct invariant ensures that we may access
>> +        // this field without additional synchronization.
> 
> I don't see this invariant on `phy::Device`.

You meant that `phy::Device` Invariants says that all methods defined
on this struct are safe to call; not about accessing a field so the
above SAFETY comment isn't correct, right?

> ---
> Cheers,
> Benno
> 
>> +        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
>> +    }
>> +}

SAFETY: A valid `phy_device` always have a valid `mdio.dev`.

Better?

