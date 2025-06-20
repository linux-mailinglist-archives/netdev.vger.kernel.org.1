Return-Path: <netdev+bounces-199639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A182FAE108B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 03:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406BD3B9D27
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 01:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC561758B;
	Fri, 20 Jun 2025 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbtN11a+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0A63CF;
	Fri, 20 Jun 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750381557; cv=none; b=jgjpiGP/laM5sWO9LcGAZC4D0MJDoqNW1gDxixo05BztV0rVOwVSbzniRPyw+LOb5mWxw09XdUCvwTUFKbQfg+hnvCHprgk8s3dMwPEuVPmdnfQPMMh5Z58aKagZe1PLS3TDtOK2VptXvbH1nUH/qlqIpBaQatjlkoO01Wcf2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750381557; c=relaxed/simple;
	bh=W9mOqeP2kwr3pLH9cYKHBcKZdgpJAyreKBwjSHcB8Mo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eqt9fLw9ZMVlpWu8PkmT9MGV18x4GnCWFZuOQPKkPyq2ftPh02Lfb00FlTxmN5T4X1IIzVRMycgS8AG0j28rUJlqaTEmErh5EqEojkVq2RPGEwuMZOJc5CDoDouHO5H/5L5HTCODxkX6QoMBbNTkZzQj9vnTmjFBVpIPRMcm4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbtN11a+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso848217b3a.1;
        Thu, 19 Jun 2025 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750381555; x=1750986355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzT2Iuf/ZzNOLQ6gupaXsLkqUMoBHoKHOKKIlOgccBA=;
        b=AbtN11a+QW7OvI1YSIdisDyjVHD1EKwifjbO7FW/Xquin1f11c2lWfJMMUWEwAfD5Y
         LE+4VF6KWqIq1wcxm/M3V3NY5ltIyXvORsaYYkTaEt+pyp3DyLsnbf72f47FtGb4RYFd
         ryZil7jz+VIx9r78Oy2rM7O+JeUbK6IdARXdswzmSm5GDGvsxna7pUw/UWpAySz8WDmq
         5xEiubbTv+MBScG7FeIQX/oZ1WGHC/jG8mM7rxgfi+NCrAtahGvMeghuHuC2iAjatO/7
         z6anHl7bqNj+HJXx0DMNBRuBOV5ItIMBWAt/yMwaDMvzmHceWSyo16bbjTmkTxYllezr
         7Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750381555; x=1750986355;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DzT2Iuf/ZzNOLQ6gupaXsLkqUMoBHoKHOKKIlOgccBA=;
        b=CyOLlNHhVWaHHgCEfssNEMpOt+UESucQuJxIVgnM1ywRUIC06uCgWq8y3/qLLVSDBY
         PoW3SvadgWeEhQ+l5NfZp/VdH9ZTCUghELcb6MzjIrCiGfkQ6u+ABCZhUFGs0OiMTnJB
         CgiAvo89S06GTroKBuTS7OqtTmqcRTc0f9PnO5CJ4jD5tcBIhUNy7PhgR3zEO8qiLmk1
         eIQGSwxWJzFfKHJP1eA9CWVy2qouLg20K/Lv3iqqbAYOtU7rLFTcLqqLCsX+HhErhr+9
         9KB/06lpHCRIX8oAaTZj/aq7qlgz211uMH0HH3VKTimOAgyFeJ2VRSA8hOWbD0fLCjDY
         RbLg==
X-Forwarded-Encrypted: i=1; AJvYcCW4tOHcbcuIXiD7irKmNZBNcYba4TLVWgOVexEAEJpBFgiqySy8YuGKYNtKZnBXarSdEdrPqgbaijdciuM=@vger.kernel.org, AJvYcCWfLSGcDih/c++MComSfhjxxhB9JvVBkp49H7Gf0WN8fL0q0knml8XZjPdwDLWjumZgfYg/8ZfU@vger.kernel.org, AJvYcCX+qd87qBXG6ez1VpOmgPXMj7N+9qTjbgGMWScMD6VuVIdkGtauY+ircnkz7DYZXZJl7xVkmx8rT1rL7EQcy7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQl0UxNq5jHZ+81ODMiMSXv+bdqRzVdJvdxVR1Bx/6B9ALoICy
	C3rQQMVnRQ1C1msTBFf5e4opGE/5E0WL51UHth1nM3Hq1XFWmGN3/Hu7
X-Gm-Gg: ASbGncuNmzYDQc2ylTmpW7uRmC+R+2KQGH3ZjlXJY2nSX7Fq77dYx9PN/779P6zFJ8i
	5VkyutyZ65xLlIbIsdWiLnFxvDiJbTIZfKi/y6ntStP5gl6FnsmhHXrVwRJCFGdzkrlQGqTRv3/
	qzcD2Zxiy/i3KrT+x6tCVxvswNwwRmmg3dH+zly1fq431PZYSgDrbJ2MPdYk/lSKd8Ya1c0n0Ig
	85N38QFc8H1JY6wCXzvazCf32T4/7Vm8G4MMZPkexYx7PVdNEgvKi4eddGYbruZGFaZemDAzwYt
	zbTt56u4jOiocI4nXXoSWDdNl6eyVuPK7z/qi8YWPQDBqatLA+3Iy51u1PIhyqcEdz1HIUymLPu
	nCsvS0tca1KOIlsfvm/loD/A4vau/L10vdkLKM9hk
X-Google-Smtp-Source: AGHT+IHMGyH3pwfxqRRi0CyniU9wTwDjsc/wVG5OYqjExsCqaW50JCFuTv7mJNtVdKpPWwfIgL+fQg==
X-Received: by 2002:a05:6a20:4321:b0:215:dacf:5746 with SMTP id adf61e73a8af0-220293b751amr744762637.19.1750381555001;
        Thu, 19 Jun 2025 18:05:55 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12587fbsm459847a12.62.2025.06.19.18.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 18:05:54 -0700 (PDT)
Date: Fri, 20 Jun 2025 10:05:39 +0900 (JST)
Message-Id: <20250620.100539.89068405138839860.fujita.tomonori@gmail.com>
To: tamird@gmail.com
Cc: fujita.tomonori@gmail.com, aliceryhl@google.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, dakr@kernel.org, davem@davemloft.net,
 andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cast to the proper type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAJ-ks9n-iQAiwN3CVnJP164kPEgwq5nj-E5S7BnZrYdBWoo16g@mail.gmail.com>
References: <CAJ-ks9mazp=gSqDEzUuh0eTvj6pBET-z2zz7XQzmu9at=4V03A@mail.gmail.com>
	<20250620.075443.1954975894369072064.fujita.tomonori@gmail.com>
	<CAJ-ks9n-iQAiwN3CVnJP164kPEgwq5nj-E5S7BnZrYdBWoo16g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 19:24:14 -0400
Tamir Duberstein <tamird@gmail.com> wrote:

>> >> > >> > Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")
>> >> > >>
>> >> > >> Does this need to be backported? If not, I wouldn't include a Fixes tag.
>> >> > >
>> >> > > I'm fine with omitting it. I wanted to leave a breadcrumb to the
>> >> > > commit that introduced the current code.
>> >> >
>> >> > I also don't think this tag is necessary because this is not a bug
>> >> > fix. And since this tag points to the file's initial commit, I don't
>> >> > think it's particularly useful.
>> >>
>> >> Would you be OK stripping the tag on apply, or would you like me to send v2?
>> >
>> > Hi Tomo, gentle ping here. Does this look reasonable to you, with the
>> > Fixes tag stripped on apply?
>>
>> Yeah, if you drop the Fixes tag, it's fine by me.
> 
> Thanks. Would you mind adding your Acked-by?

With the tag dropped,

Acked-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


