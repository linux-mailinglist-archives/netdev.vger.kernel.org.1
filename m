Return-Path: <netdev+bounces-49844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493DE7F3A91
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8171C20E28
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452037E2;
	Wed, 22 Nov 2023 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc+kYcPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F38F1BC;
	Tue, 21 Nov 2023 16:04:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3316bb1303bso2887114f8f.0;
        Tue, 21 Nov 2023 16:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700611484; x=1701216284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fC2fNeQQfha7AakRhFGBGF525Yzx+UJPTaQlXPp2Yrk=;
        b=Nc+kYcPQ1Yks6wOJbbrWa+oJdjZmwYF0qmhcdSpvgRjgxHAjxurcd02eZ8/VHEezZt
         c+2YT4bvejYCqz2dINoo795PwcOTBWUmqlTPmkdVQvTssnPTVdHUkgSalr3Lxdb8y18e
         PA3cc9Ynx/PHTl0qkPbnNop6UWmF8LavRyf9QvbRVzWKgEcvgudytlLBKACk5JleHrTi
         XOrD9EWTBJNK3K15qz2drk4Ys2dAo3VKl8LHFaxYNFQ2KLfaqgWJv27/HaoOV4kdpODv
         R+1kBTzARqSl2O0gsFtdaOEse2yieIxApQb48726y9O9rXwWXsJ9j3E/tT1wEbUJKblM
         HFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700611484; x=1701216284;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC2fNeQQfha7AakRhFGBGF525Yzx+UJPTaQlXPp2Yrk=;
        b=X1q+38oz8Cu73QGF9H36FrPHINK4HHMGevyu1dYrmhb4oKwm8MbqU4TOJFKCaeENd7
         NxO+C9c8Zp36Jer90CXkHf8Bu2ULD7jx9dykUzOxNZYQ1FjnQ41D2tzNKJkOfAE8XAGq
         grIIAcHtOAnoXnmjFHo+OPboNMj9MzMypZiY0q2FO3UbmDTU7EqexELx+8PrFnCc8mtP
         CiXid3zaXKtECbGEk/uhzJ1nvFnfdnvNt+S39TuxyF1B4XjDuO/7JUodAa+tB1JAISi5
         XptQE7dKyCzaCFbLnipFueW42nYdMKb40vDQ4XnCcWHAAHLAQEXtbEjJUJYOIJ3lM6gC
         sA0Q==
X-Gm-Message-State: AOJu0YyUWo+7pnuqixVxrxrWa16JWTr5AZaxFoCXs21t/BIJs3kefrfu
	LOiQ5xAZzDCH+nFki+u7CSU=
X-Google-Smtp-Source: AGHT+IHSK0cz5w/vME34KfWCrJ/rhVrXXg5TSn550g/YTE026Dp95YGHPGdy32fyGtoPo/YglJJD+g==
X-Received: by 2002:adf:fc81:0:b0:332:c4e3:9afc with SMTP id g1-20020adffc81000000b00332c4e39afcmr270064wrr.63.1700611484390;
        Tue, 21 Nov 2023 16:04:44 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb0c000000b003316b38c625sm14746475wrr.99.2023.11.21.16.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 16:04:44 -0800 (PST)
Message-ID: <655d459c.df0a0220.daf6d.3e1c@mx.google.com>
X-Google-Original-Message-ID: <ZV1FmSlIDdCFW+qe@Ansuel-xps.>
Date: Wed, 22 Nov 2023 01:04:41 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: make mailbox interface4 lsw
 addr mask more specific
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
 <20231121150859.7f934627@kernel.org>
 <655d3e2b.df0a0220.50550.b235@mx.google.com>
 <20231121153918.4234973d@kernel.org>
 <655d41b4.050a0220.36e34.359e@mx.google.com>
 <20231121155812.03113405@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121155812.03113405@kernel.org>

On Tue, Nov 21, 2023 at 03:58:12PM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 00:48:01 +0100 Christian Marangi wrote:
> > > Not so sure about this one, it puts the u32 on the stack, and takes 
> > > the address of it:
> > > 
> > > 	u32 word;
> > > 
> > > 	word = (__force u32)cpu_to_be32(word);
> > > 	crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> > > 
> > > so the endian will matter here. My guess is that this part is correct.  
> 
> Actually I'm wrong about this, you're reading and writing the data,
> so endian conversion happens twice. Canceling itself out.
> 
> > Ehhh this is problematic. Data comes from nvmem or filesystem, in theory
> > they should not be touched/converted.
> > 
> > nvmem_cell_read or request_firmware return pointer to u8 and it's the
> > firmware (that is always in LE)
> > 
> > If data is not converted and passed AS IS from what is read to the
> > allocated data, then data should be always swapped.
> > (this PHY is fun... it's probably BE internally but expect LE stuff in
> > the mailbox, as it does emit BE CRC.)
> > 
> > Any idea where I can verify if nvmem_cell_read or request_firmware makes
> > any kind of endianess conversion on the data it does read?
> 
> The underlying storage should be byte-accessible, so neither interface
> should change anything about the endian.
> 
> You should probably switch get_unaligned_le32() for reading it into 
> the word variable, tho.

I don't need to read it, I need to pass the data directly from what is
read to mailbox so using get_unaligned_le32 would actually make a
conversion. Anyway thanks a lot for putting some extra words and make me
check this further! Will send a v2 tomorrow!

-- 
	Ansuel

