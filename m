Return-Path: <netdev+bounces-198761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7AFADDADE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3455188C1C3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF544155C88;
	Tue, 17 Jun 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI7atVmI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCD3BBF2;
	Tue, 17 Jun 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182504; cv=none; b=qxUwBr0Z08uTbr4Wk5VfSyJSn3DCUiqesE6WCkm3L3ZQtLew4IlXTOreXTiHBVq7nSiCluptXov7Ud/IzBRi8QpPGoatnO7lh0vPcw+svogc0HwEeI7QKHUxpr8uc3oJFqDj2ETXsW6Cta6yMNvvh7qTYrRqUQu3lHRZZWTE/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182504; c=relaxed/simple;
	bh=+XCjI5K9Mpd5ggLlm7MUlz3RbcKMVBu1U7/rKRSfuqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjF0XhxQyhThXMVNhRV0PYl3LfteQBYm8ECtHOVTm2Hz7YTeDHpJj0jKMJCy14YB3KkvsVgOTotSJ+82UU6DEx5HxVc9YSoF6ZqihsjLikkFhtGUtYyR0Z6zUgyZbVNwJXgPDvFfU00kMbFAQ6aQN1vVBEYS7XWd6zFXd1MTrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI7atVmI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso5309369b3a.1;
        Tue, 17 Jun 2025 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750182502; x=1750787302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Xl7EDHQegoMM5/vxaOFryLj+bioA1aFNCNkeocZIE=;
        b=eI7atVmI3Cmym42y/jq/YXFAkxFXlTSW1C6nwcmWtJLguUxEOFNl9I07FXjQncFhSe
         E7PnDr92RYnWrcT2Ub0tgM3gWpo2it2zco5zAAdTdVlKnSDaAAHGXAH2JTRBMOMYnaPT
         rpyfXNssCD7LO8o8GmnU54pgpsRay43iuAnwtCh65Cyl7xBP4R5nFG2QskATJC4i6N68
         5WdxdM92PN4s13nT1q0Pr4ukqxbFn9x2PtniERBkTK4YMtgo3D9GGfaQK3UCW46q9h1y
         TemVHMiuI6JatDrJ1nC6bsL7iiYnPHIQNKf4EZoeRg/mYp0WFMrvKf/F2NnY9Drr9nxU
         Xlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750182502; x=1750787302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+Xl7EDHQegoMM5/vxaOFryLj+bioA1aFNCNkeocZIE=;
        b=DhOfp8mo7wPnWcyJ67RiQMvZICrHo1GlG22JLVuVq/rXqBqEDEHVKxZd33tKhp7ddI
         hYdu58CqU7KlMq7qradmmq557kCbWawNz6tkgZNSdO1zE1GtjneDsvraeD/wKZiHUfp0
         UId+Omxfw6a+l+nqbtP0BTxrylFYuVdF1JP+7GclO3551BYWbS8HGp8ynESltcEjEqah
         E4o83PG0/K0VDT0/hQ1lUiaoZCeSprShtqF2XHRXTqekQyYFuanuXPc2PEqIT5SvVQV5
         MueWjXI0NHCgFNhPkdau4M4W5wcM7H2iPZo2UbI6xtnqaGFdp1Iza3AdNba72CqL4EUm
         sQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUh/oAGJuClcWChFLU8H8/igg6/KXlAgAF85C+8I7xpXhPNqihPkJVIJ9uedcRtGmko0fKn9jfZxNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyin+CIrc2R+LQ+xCYwc9x4zn968K4ic/RcNJjSDG/MxZDUDgPh
	Mn4avPhlE4Aqo8AngdRzjUnuRrGAV4gLIrRSXDBeiFPeMVH71cLrFEtfSJI9
X-Gm-Gg: ASbGncvFMs+uQqNOXxxyCvBxPUPg7KrsVGmHtu4bwht2fDYPF9jJKcj9VrEY7xQ3mOT
	MhT3qbGa+xiNgMp6gOXkbFzflYyObyJHB6puAKD9oUFme72XL5SxfcEzQ4AmdWkYBw8bbRQRHsE
	iKrVdtg617igK3d3IxmL/GkYOimn6HEcQRn81wOH71gAIlIG+3vBqoHqtfnqj4ZMUyYz9qSHiW8
	Wbq9VuB6PT06cqTw+QuLrFUqmhjnnID0DIpgYnIWzHUbD2PovdP5h1OtuuLuPzpsDw2pOtYKuFy
	hSkeCyr5JRCiTJAhVGB0oMZd1oE3W6705eAzr8bE8+WjBwFUjUdA4kwV/V1uVASY7PNfNmcthAY
	VQgy/5gDtcMO25ViZg0PTNkI=
X-Google-Smtp-Source: AGHT+IEhjprXOs9xwkpuoMFSMYZ7C1cb4GdCMo2ynXQHqSj1mlKbEuXO5EoB6CDfQwxFLrLNFCyxtQ==
X-Received: by 2002:a05:6a21:68f:b0:1f3:1ba1:266a with SMTP id adf61e73a8af0-21fbc41233bmr20709696637.0.1750182502191;
        Tue, 17 Jun 2025 10:48:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe1680420sm7735781a12.38.2025.06.17.10.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 10:48:21 -0700 (PDT)
Date: Tue, 17 Jun 2025 10:48:20 -0700
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
Message-ID: <aFGqZGvSSEfR-sDi@mini-arch>
References: <1922517.1750109336@famine>
 <aFDAkS3VUgHwxxr6@mini-arch>
 <1934950.1750126872@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1934950.1750126872@famine>

On 06/16, Jay Vosburgh wrote:
> Stanislav Fomichev <stfomichev@gmail.com> wrote:
> 
> >On 06/16, Jay Vosburgh wrote:
> >> 	 Remove the ability to disable use_carrier in bonding, and remove
> >> all code related to the old link state check that utilizes ethtool or
> >> ioctl to determine the link state of an interface in a bond.
> >> 
> >> 	To avoid acquiring RTNL many times per second, bonding's miimon
> >> link monitor inspects link state under RCU, but not under RTNL.  However,
> >> ethtool implementations in drivers may sleep, and therefore the ethtool or
> >> ioctl strategy is unsuitable for use with calls into driver ethtool
> >> functions.
> >> 
> >> 	The use_carrier option was introduced in 2003, to provide
> >> backwards compatibility for network device drivers that did not support
> >> the then-new netif_carrier_ok/on/off system.  Today, device drivers are
> >> expected to support netif_carrier_*, and the use_carrier backwards
> >> compatibility logic is no longer necessary.
> >> 
> >> 	Bonding now always behaves as if use_carrier=1, which relies on
> >> netif_carrier_ok() to determine the link state of interfaces.  This has
> >> been the default setting for use_carrier since its introduction.  For
> >> backwards compatibility, the option itself remains, but may only be set to
> >> 1, and queries will always return 1.
> >> 
> >> Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
> >> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> >> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> >> Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch
> >> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
> >
> >Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> >Maybe better to target 'net' with the following?
> >Fixes: f7a11cba0ed7 ("bonding: hold ops lock around get_link")
> 
> 	I targeted net-next and left the Fixes: tag off on purpose.
> 
> 	First, the bug this nominally fixes is many years old, and
> wasn't introduced by f7a11cba0ed7.
> 
> 	More importantly, though, this patch is removing functionality
> that someone theoretically could be relying on, and I don't think such
> removals should happen in the middle of a stable series.  The default
> setting for use_carrier (i.e., using netif_carrier) will never hit the
> issue in practice, so the exposure seems to be minimal for common use.

SG, especially assuming that use_carrier has a default of 1 (so the
issue should not appear in most/default setups).

