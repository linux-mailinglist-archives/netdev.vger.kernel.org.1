Return-Path: <netdev+bounces-191528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB9ABBD2F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D85317AB3A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCBF27511C;
	Mon, 19 May 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKwTHTol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546513D52F;
	Mon, 19 May 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656090; cv=none; b=N7JKn7xpSDIuNXVq+l+ZFi0swQSD8hGV/5ZRBaVlOtPX/I5oc+f2PwQ7RArIFwiXDX7yuK9sA2xpvkjOLrhwv8hrOlol8jFh4bMw+UblXPiL6n6sQMKVZ8jQwGOIub0y0NiQk7OrvTm4clDf3RHwEopMRO7wnPAVqCbWEX3kwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656090; c=relaxed/simple;
	bh=Oi2AsDVEz//MMAK2DEH0Sl+qm7MOIE7coxM6eIGolLU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PRlCbV3lFwXHbtp20i3O1ylwYnxuDu/BFvnZNGifmWbdKyh+cYmR0tVQY78+NItBu+Ltb4u5sB5sg6IXLY9t/aWVYiobd5EJTfWUSPQkyUG2MH/LtI1PACA2pTM0SjEcJROi5NiMXG9tB0ElpXfzjC6OysV+VrcDth9vfH21KrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKwTHTol; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c96af71dso1501725b3a.0;
        Mon, 19 May 2025 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747656088; x=1748260888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTmZBlZhUVLhhjEjpTTIpHbOBPnV7i0+TYTlL3dGEFg=;
        b=iKwTHTolgkJISlGRG0NxzXTuiedOD6xTElWMcPn5aVxSDWUmh3Lk7yLbxHVM8RkbqT
         xX/OphskVGnjt83aGpgrVY6KLznvz2W6w7foUDBMQSJCIAhwa7lSb94jDjjtzJgNZYq1
         5h7IeJLIAl6ZxhZWtxmn2tEqKbaWkOzfBEmnWkl1LQ6EYxMv3gEJPTJxh3IM84C20WHa
         wRZLojL6JcPHH43rgbAU/DTFdHKGbd3h+Jx2LREOeRXhn7Og4R6dcJJhh6SKLoU0wX2o
         U+PE5qCD64bNe+vnBaEBd+mArwxKb3WU7Neo9NoSgwLHWq4/uId0oNVUmN05JsXtI1fa
         waFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747656088; x=1748260888;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTmZBlZhUVLhhjEjpTTIpHbOBPnV7i0+TYTlL3dGEFg=;
        b=IHTHvf9mDIxDXdzr2bnM6nq5WpvCOtF/Lyn95WAAhRvllcj8t6+BIzvrAYoDqhdMeS
         jUcHAJeOahbR3RInZ2MMU/sZ+Fogrni6vMNiIEBWE+BSck57Yqr0QjpcTwL/Ap7lYCQr
         oYWBB0kkbhPexd6cKyeBX/RRkw6NYmUaSg5d8ei9/5MdSOsqAfqnrMDh+YyY3o2xb858
         GwK+uYjCpagwUMKSv2IvHwQH3NqK39e/hsngiT7kV7aiYSlbhEPzLtibtu5/3e5c2vVw
         Bofr4GVvGTenjh1NJfVNNr+b+wAlqB3/CE0LTTurZY13uLFCW8pqRDPQ6k3rnOGYr4P0
         NuWg==
X-Forwarded-Encrypted: i=1; AJvYcCUy4ftQ93fM9WKHDgbflsm3HiIVLGo9Skv8TuQDXFc6D/xV7baM8mrhyC6vKKgku/u0UyJGa+vklhqF@vger.kernel.org, AJvYcCVUf4ssKBicrZVmt9W5TPDAq4j1mOL0QyD8LAKxaNQ+O2tjZab5HnV0cZgaONe10mL1QKLg/fUxHBigr8Uf@vger.kernel.org, AJvYcCVjrHUOId3sAm7HL8rpUGP4x0XSwmFj4w+Brc1kMstEeY7z2/5RSK0B3XDKxy8rjR2SUIdVq+y1CHjPocs/pxM=@vger.kernel.org, AJvYcCXvy9xB3nkHUwRwkmbje2oCTwuKad3PzR6rY322YkUK/kKlpxhg+ZASBJ5fvJqLtAQ1AaA94tRj@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJB66SarHA+vNrGsilz64pJ9lMalJ3ofnnfZB2+5i1zcE4W/K
	JaCzgjmzB5qtfEuy9Ygge+6zafw+Ny9v+Q7uOtS9pG97FcHlLreyzqjCXBDcqDhu
X-Gm-Gg: ASbGncuGU5ljxpJMOj0zUaB71EoKO5y45E1aJKS0FD5T0AHdDR57aYwhBcFR9Yxkgl/
	ZMwuWuAaOXuybagl8YeiRrt9nsrdnWcHoYTG4toyT2lXsElbQjU0TkNw97rVfc+Wk8zWfp610PQ
	c10cVBkQ2+LJ+rwx9soWClccuJYQuUlI+nk/zuSZgExpI+Nxw69Gd8FnRD/POfxP/T+DmW8h3IW
	JRmTvWDFOX8mo1bZ0TmQHfhrsRdX3iQdRYJIJUdaIkIBnft2Y2gkhZ/Z8f77qIhhyyq3rUFGlaF
	vTMLUKhNvWMquw/rR0vvpNcEXS9E+ktzs6SNS1cGH4c3Me/jbbB8i3ebw8EqBcGkgh1TyctKdCs
	asJoK0KVR4CK5jxigHrczr8dIZ+cxlnpeTQ==
X-Google-Smtp-Source: AGHT+IFA5WtJ5T6gVjrQKrpyLmTmrTegeDbfrWJqzoylEFS0ZUr6GsuE/3DhnckmSjBrOGZeN1nV4g==
X-Received: by 2002:a05:6a21:3289:b0:215:d25d:fd14 with SMTP id adf61e73a8af0-2162189f061mr17513907637.13.1747656077753;
        Mon, 19 May 2025 05:01:17 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986d9c3sm5972829b3a.121.2025.05.19.05.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:01:17 -0700 (PDT)
Date: Mon, 19 May 2025 21:00:59 +0900 (JST)
Message-Id: <20250519.210059.2097701450976383427.fujita.tomonori@gmail.com>
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
In-Reply-To: <D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>
References: <D9YA4FS5EX4S.217A1IK0WW4WR@kernel.org>
	<20250517.221313.1252217275580085717.fujita.tomonori@gmail.com>
	<D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 17 May 2025 21:02:51 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

>>> I think that's wrong, nothing stops me from implementing `Driver` for an
>>> empty enum and that can't be instantiated. The reason that one wants to
>>> have this in C is because the same `match` function is used for
>>> different drivers (or maybe devices? I'm not too familiar with the
>>> terminology). In Rust, you must implement the match function for a
>>> single PHY_DEVICE_ID only, so maybe we don't need to change the
>>> signature at all?
>>
>> I'm not sure I understand the last sentence. The Rust PHY abstraction
>> allows one module to support multiple drivers. So we can could the
>> similar trick that the second patch in this patchset does.
>>
>> fn match_device_id(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
>>     // do comparison workking for three drivers
>> }
> 
> I wouldn't do it like this in Rust, instead this would be a "rustier"
> function signature:
> 
>     fn match_device_id<T: Driver>(dev: &mut phy::Device) -> bool {
>         // do the comparison with T::PHY_DEVICE_ID
>         dev.id() == T::PHY_DEVICE_ID
>     }
> 
> And then in the impls for Phy{A,B,C,D} do this:
> 
>     impl Driver for PhyA {
>         fn match_phy_device(dev: &mut phy::Device) -> bool {
>             match_device_id::<Self>(dev)
>         }
>     }

Ah, yes, this works well.


>> The other use case, as mentioned above, is when using the generic helper
>> function inside match_phy_device() callback. For example, the 4th
>> patch in this patchset adds genphy_match_phy_device():
>>
>> int genphy_match_phy_device(struct phy_device *phydev,
>>                            const struct phy_driver *phydrv)
>>
>> We could add a wrapper for this function as phy::Device's method like
>>
>> impl Device {
>>     ...
>>     pub fn genphy_match_phy_device(&self, drv: &phy::DriverVTable) -> i32 
> 
> Not sure why this returns an `i32`, but we probably could have such a

Maybe a bool would be more appropriate here because the C's comment
says:

Return: 1 if the PHY device matches the driver, 0 otherwise.

> function as well (though I wouldn't use the vtable for that).

What would you use instead?

