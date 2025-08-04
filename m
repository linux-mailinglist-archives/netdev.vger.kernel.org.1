Return-Path: <netdev+bounces-211612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E341B1A6B7
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CCB18211D
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBAB2737E7;
	Mon,  4 Aug 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQUKEOsr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF925A2BC;
	Mon,  4 Aug 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322808; cv=none; b=BIMIqjXTFhAfP6I75KWQ6hCqrddt4oeaGWQybrgkofGXbxuCSggdjTNTKj4kLCWOgxtcsJurjMj9oha8O/crjZDtrhDLevrJz3mNbjtaufRTTcyN0P1QstX9ZgVDQWLKQGz7LFHv4dKaM0ZxI6dI/QjgwDOJLTMPmSIhE6djoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322808; c=relaxed/simple;
	bh=PTjrL1PcFmZSOGqieDrNCC0+OR0oCAGs6pqK2aqAPkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/8eGCHoeCIBhp5F6Kp0yZTUPEASPSEobrcmEH8g70DZjgvUPYST1RXh2nuiFTLbIP4+EmqTgkNxyVRGMr9HtqqMzQFzyMiIPdeMyj0ohUYDlde6Q47tYO5E3dAmLKpQBhzFBw3CI+AYXCzSX3BraQeqfq2N62fLcDJYXOcV5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQUKEOsr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2831885b3a.0;
        Mon, 04 Aug 2025 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322807; x=1754927607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SvowspioqhZDQjqsMOOfsfPPJLqqPAiwT2r5o8/mf8=;
        b=HQUKEOsrBsVVGnbu54g+F0N/BbiKPg9pPGIgH3hClloZnGyZX8AoKNnGDGZTWI3SDE
         kM4wbE7yafcMTu2uKKkeXkGdUFBY7JYudfE5DLqEjE62bC8JEmRK3S5as5xemEv5y4OQ
         QXmDWUHc0P2ZKPizhTocTzSSf+000XdE2PGa4D7JKbseYXJQNyPVqxRtaKOQuxyHuBbz
         2aSmzguEIn3Ip9nQrymw/tQRyHEw67VZ5no6aNcd99RUdwt1QLGLrMsQXIh6TzB/jbqm
         ZdmdoradvbXiT3y0Jp1hPLBBNsQaz1Mtbl0TTyL4himbJ2pmxvFb0UEgVQf8bO/I4yhb
         DIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322807; x=1754927607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SvowspioqhZDQjqsMOOfsfPPJLqqPAiwT2r5o8/mf8=;
        b=UCrdXnjs76dmfIEw1QUsC+Q4ZtH9iSGmBZhkF8jvaNwRVKU/e3Q9XcoAzlo3h8cDaO
         OaMLqVp9ZTOdpqwlRmwLftVGwj8QFLABXoBKg5oGGOF1K5TrGU4f/FO/s0dSu5rBT4T8
         GdX92TvztBlFHUFRWNwcGtqCGX9eGMMNZ3oPpkymXYSVL9iZQNMwps2pW0vhlk9mTDLj
         pnVzETGcrz9O/tbcTsMRm/6+6tkeOOHq9/WG+U6RAYIKMDjFFjY7kgdSO6JkcNiDgMlk
         Lmc/MW6REbHc7e/IIAHQyjDOnMw52fzKWJecofxZN6EoT7Cwbk+cm7/xjBK9dmzjtHF9
         64Tg==
X-Forwarded-Encrypted: i=1; AJvYcCU4+RsZDWz5A3A6MecjsZwSVKK46P7fZAXDc9CtwDW6G/DTZeqD/VdZQn36ub2RxwqBlYXGnyxAe+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUd/W6mEXASkiv/gSlmvW25uCbSyqbByVhqWJWFmnHC86BO5Sm
	u9nfT0f6h8JODLnVlYMvfGOSEMf5n3Xg+YmJmLZPC7h73bEYi/vqzmEaxVvQ
X-Gm-Gg: ASbGncvlaKBh2JmsOLNwlCG0gE6ZcHmzqZXgKnoVsqSl69j88g+Wn/NaXLl3Gq5B7GJ
	xICZDlailimPLEGwrnzTIEFCyEUA/6qzQVgSntMByv441r8dl6B/800K0UTk09eXXs3brvqMUhg
	A/Fb0BUspNOr9zoxdwCXc55BDF985rEvpJtV3joBzFkogdtJPhVS4NUJi47ijL7fSZ3CaJi912+
	x+lzILFvIimw0869zskgyLew9WCZ36LHomTToVvZmfR/Z6adtRC1uO1BrjHwYR1VmlJEWPkKaWa
	xxWrPhthENJXZa6lLhcqmASAVX47Ts+4VtWOSsM7iTUMu3riBoOuhWP+bbToh7DHpGCkv7Gqadi
	5H2DPU/+37w+zHQ+wjyh3Sa1DZVQ3GE/sPWp6TXmWv3CDwM6oJHEjeKAjivQ02GwbQqcIAg==
X-Google-Smtp-Source: AGHT+IGF22gzp/oRGn0hTfHTOW+RZ7WRl+qPR7f8V3jQ6/Ch+1TS38pSikn/9RUjo3/wUip3IdeGQQ==
X-Received: by 2002:a05:6300:218b:b0:23d:9dd0:b2ce with SMTP id adf61e73a8af0-23df9154a30mr15318448637.44.1754322806625;
        Mon, 04 Aug 2025 08:53:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b422b7828a0sm9423056a12.2.2025.08.04.08.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:53:26 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:53:25 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hangbin Liu <liuhangbin@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: Remove support for use_carrier = 0
Message-ID: <aJDXddrijhXn2z6E@mini-arch>
References: <1922517.1750109336@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1922517.1750109336@famine>

On 06/16, Jay Vosburgh wrote:
> 	 Remove the ability to disable use_carrier in bonding, and remove
> all code related to the old link state check that utilizes ethtool or
> ioctl to determine the link state of an interface in a bond.
> 
> 	To avoid acquiring RTNL many times per second, bonding's miimon
> link monitor inspects link state under RCU, but not under RTNL.  However,
> ethtool implementations in drivers may sleep, and therefore the ethtool or
> ioctl strategy is unsuitable for use with calls into driver ethtool
> functions.
> 
> 	The use_carrier option was introduced in 2003, to provide
> backwards compatibility for network device drivers that did not support
> the then-new netif_carrier_ok/on/off system.  Today, device drivers are
> expected to support netif_carrier_*, and the use_carrier backwards
> compatibility logic is no longer necessary.
> 
> 	Bonding now always behaves as if use_carrier=1, which relies on
> netif_carrier_ok() to determine the link state of interfaces.  This has
> been the default setting for use_carrier since its introduction.  For
> backwards compatibility, the option itself remains, but may only be set to
> 1, and queries will always return 1.
> 
> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch
> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>

Hey Jay, are you planning to send a v2 for this? The syzkaller is still
complaining :-(

https://lore.kernel.org/netdev/688e282f.050a0220.81582.0000.GAE@google.com/

