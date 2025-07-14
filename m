Return-Path: <netdev+bounces-206657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B4B03E85
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE36F189C055
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEDC225771;
	Mon, 14 Jul 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1ovxHET"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5921B91F
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495689; cv=none; b=TyEhJc7txj9Ka1vAXvF5wWp2y0P17AUqyhjCHQhn2Rombi3zkiPLrIo53gr1E+uWnjKZTqu3299zD9luvEFKd8kqdcMYCTnSq+0KxjMVr87rEURKV7et4LGwLYszK/UHexz7ybohNPjHux2yPh6N2gQ6MjBonhFgnPFX3ho3ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495689; c=relaxed/simple;
	bh=8mXUg96EvsUZr1iMagJfnqsF+/XijVdhvxERcN70AIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btswD2AEZUSs+Ii629I9MS7IMmqTNRiljDyQgHDVvMuSbFrkF+7qwNhE14FE+EUwum+Bh9KwTyFLXxnBKx5RyHItLGXcIkfJ5gffb0t/w27Iz9ONBjbduiAziBgydDl/cuWlFm2qOX3tfu/edPlpb0cyHE8F0v1FDCxhiHQXfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1ovxHET; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3113513f8f.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752495685; x=1753100485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUhNkhnJM9LJg+lJ4kHUKdCxmecqnhP8vLoEyt2XIgA=;
        b=B1ovxHET4cDmEV6kU7YdYxKVedEg3snNl9IeNW9CKdD0wcLonf+MlyHsY2+Ri48/JB
         h6gbn6ceYmsadh3hOlX9iso31DEwjKqUbKGiluGZEBB7FKoJloM/KF7oYbYnqlqTaEuM
         iSy+xZRDEdaEHDdKEWJxP8Dsn45lByuvKQGbB9SxhbXOUBPkrRUy2nMMvalqG1kovHzc
         QyS48OsYEWvoHSKAkDDvXBO7ndjy2BCHwVTCMmEVRwsGQPhxn/kzgEl+PgoUzcxNkQ4V
         h+ihpKHvAQqy4qh/KPLAu9L/AMrwYlJURwuPnpM+ltv8iSs19qrRx0afG+1cOXNBU7Ny
         uI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495685; x=1753100485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUhNkhnJM9LJg+lJ4kHUKdCxmecqnhP8vLoEyt2XIgA=;
        b=SpYMMdB8q6nCfzh7H8Mv1x72nevHQJdBamTxTYuGcha1UDUDBwQHNESZ8B6/n+MxrI
         FVzwCqMmSmtTW9gjV9B7m+V0k+hhyi/cAEupiXVyTo5OcYfS/h/9RR4S9nzsLoFBLpB4
         soMnz9z5zVaXGk9IfJGQUrybsmx5aqm85zDRWy2Q7tr3Lh+9G+2bmH8zCB6OWyypVGY1
         YGKvhfKbXeCIriXnbSce24a6YZdu/FjfF3uolbjBIPsFINWd9IjjGVVhU/3ps1NqrtLV
         ycj03ooE/axs1ha5Cw/pKDFW+27EV1ujUDUFBz/+zlUu6UhDqCAyLDVXJUDOwUKlFuli
         wb3g==
X-Forwarded-Encrypted: i=1; AJvYcCWeLVNzR4D8lJKlrmXKjHHmXohjm+/py37e++WN+9xBptOEWqm+HmSoEi9xtuKl0nSgEGFCAII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJsgs678YQzNf1BuUJ4QuOrYIbG5OKy+9Go90laISMo1aPlZj
	FN3cDu3021kxsTsJ6URktvy3WW2VKTPBXhZwq3uQCM6c4l0qK/VUF4PNi1EO6A==
X-Gm-Gg: ASbGnctwSXe6rcEZC6vb5xwJXTsWiyLTiobhTxUO72Pqb/JpPO3YuOoM5BEu/9tuBiT
	SiqJ/mCzhkEGMy0x2gJ0ANwItDN3YN6TV4ySQtCv8ig0RygpgLug2Q2aax5UOTFSMaclk8amQtO
	VjcRrNzwxGPtWk9hvHOT4/j32Roywc3NJnynvZyy7zGHTUMmR5vhNYCIac7aOjCHousZd2ZjxO/
	nuoRZiNDMHw09ucqHepM1PcmBF15BHZtVk0KOnou4ecDZqfGKWI7g3/iZGkTE1YVOrDwmqP/X4k
	Qbx5jxlKFfix0Yrbral2Rr00DNZHEceMeYyuUC0qMjTMIfwfGJAHMUAzM+smfdqkxEKCzpbqbw7
	fnscf4W/U4cHpK+CtNIHkz7ao0ID9hsiNoz2maDH5J7tOk26bXK75xvdYFPeq
X-Google-Smtp-Source: AGHT+IFPob/ovid7y6X6Qrgj4BNMpAVrprUu4PpYPUCrQ6SCsUTGZL+60GqaHj6ms6E+U4jzYhkbhQ==
X-Received: by 2002:a05:6000:1acf:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b5e7f0a33emr13049731f8f.5.1752495685046;
        Mon, 14 Jul 2025 05:21:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1997sm12502206f8f.10.2025.07.14.05.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:21:24 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:21:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Simon Horman <horms@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 1/5] e1000: drop unnecessary constant casts
 to u16
Message-ID: <20250714132114.70feff08@pumpkin>
In-Reply-To: <522a1e9d-0453-447b-b541-86b76fa245bd@jacekk.info>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
	<e199da76-00d0-43d3-8f61-f433bc0352ad@jacekk.info>
	<20250708190635.GW452973@horms.kernel.org>
	<522a1e9d-0453-447b-b541-86b76fa245bd@jacekk.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 21:40:12 +0200
Jacek Kowalski <jacek@jacekk.info> wrote:

> >> -		if ((old_vid != (u16)E1000_MNG_VLAN_NONE) &&
> >> +		if ((old_vid != E1000_MNG_VLAN_NONE) &&  
> >
> > Ditto.
> >
> > But more importantly, both Clang 20.1.7 W=1 builds (or at any rate,
> > builds with -Wtautological-constant-out-of-range-compare), and Smatch
> > complain that the comparison above is now always true because
> > E1000_MNG_VLAN_NONE is -1, while old_vid is unsigned.

I'm guessing 'old_vid' is actually u16 (or the compiler knows the
value came from a u16).

In either case the compiler can 'know' that the condition is always
true - but a 'u16 old_vid' is promoted to 'signed int' prior to
the compare with -1, whereas if a 'u32 old_vid' is known to contain
a 16bit value it is the -1 that is converted to ~0u.

> 
> You are right - I have missed that E1000_MNG_VLAN_NONE is negative.
> Therefore (u16)E1000_MNG_VLAN_NONE has a side effect of causing a 
> wraparound.
> 
> It's even more interesting that (inadvertently) I have not made a 
> similar change in e1000e:
> 
> ./drivers/net/ethernet/intel/e1000e/netdev.c:
> if (adapter->mng_vlan_id != (u16)E1000_MNG_VLAN_NONE) {
> 
> 
> > Perhaps E1000_MNG_VLAN_NONE should be updated to be UINT16_MAX?  
> 
> There's no UINT16_MAX in kernel as far as I know. I'd rather leave it as 
> it was or, if you insist on further refactoring, use either one of:
> 
> #define E1000_MNG_VLAN_NONE (u16)(~((u16) 0))
> mimick ACPI: #define ACPI_UINT16_MAX                 (u16)(~((u16) 0))
> 
> #define E1000_MNG_VLAN_NONE ((u16)-1)
> move the cast into the constant
> 
> #define E1000_MNG_VLAN_NONE 0xFFFF
> use ready-made value

Possibly better is 0xFFFFu.
Then 'u16 old_val' is first promoted to 'signed int' and then implicitly
cast to 'unsigned int' prior to the comparison.

Remember C does all maths as [un]signed int (except for types bigger than int).
Local variables, function parameters and function results should really
be [un]signed int provided the domain of value doesn't exceed that of int.
Otherwise the compile is forced to generate explicit instructions to mask
the result of arithmetic operations to the smaller type.

	David 

> 
> (parentheses left only due to the constant being "(-1)" and not "-1").
> 


