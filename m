Return-Path: <netdev+bounces-230545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4C3BEAF75
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9B41509462
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030842F692B;
	Fri, 17 Oct 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lowsAAAP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EB2F7441
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720468; cv=none; b=X/8Pz0CSdmbQW9VUMjmeiti4bou4ScSEuo91jsT4ahx6IbFklEyHlohb0af87gZtdi9Sb6Ild2PPicfAiB23VJmKqU4zoSpCnPUODA3bdDHxXDf0+tIi9z4tM2LKHK6u4mANOQbxBjNSinsU/UdnOjkrxzg+txU3oYpr8TOe9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720468; c=relaxed/simple;
	bh=Mau33/wua2YBNJWKTBa3hvehOZNgzc4Sf3mS32cpADs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa2cgl9fK89q8/y613LS//YE/1LckP7QSQ1tDCnmIam+0NkaHWllrqomh5r2J8QzyxV7HgHdZLtywg6ceDH/zgEq8RpAWgq9VX8zDWyhJsv20efHJcqgrq1uLqJ2CFXoeDE+MRdaoVsumZgvjNGJMBBTHF564/C9XK+HrHAee2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lowsAAAP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426ed6f4db5so1900521f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760720465; x=1761325265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqg7Htrwxofmei2fLsgAe1uph5/lzKI0qa3LLNeV4j4=;
        b=lowsAAAPvdT/++PZaSy4ECm9p49SgrW8bsdS9rzM+NXPmW/7vtDHQnoUbUARQVNk4Y
         GMjKKyAsHPV52OEe308ddog1BPyaDjoVsuA9cmTrwblmqmYnhzRiUl8YqN6wbaRaMr31
         auO/Jxdmiu9/bbMxmhQmDSD6M0o43Cqxims76+xR4/HG/PAZUb18mfz1bfM46iaZ8Kee
         A0eoZVZuKqweWeAc1jGId0HoIxPTOYsYEDIGWtAcqjk6m2qpp7jy4UiVnaklCmacvX9Q
         lS9at/ORJANu1ir/QlPN99pvYvD24C03/pg4Ru7ciEd8B15NRuX2VJyMBwjAEZn0LLQ/
         ztsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720465; x=1761325265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqg7Htrwxofmei2fLsgAe1uph5/lzKI0qa3LLNeV4j4=;
        b=JLwL51Mpw7rqWTvp6b76ddyR/F1nSYDmH6L4UDlI0FyZzTZqM3NHknv/vUvVCBaZZv
         AL6Mrw/525albZQZw1dh67qXWCAG/HsaArewQaQuNIO+uHyM63HKDdH28zyWOEzV0xdi
         UrvVopcrelDGb9+YxFmxvy4aUnmprm+raupXs2XRHoXhj47FFPRQwjD1rd2mp1PPwq0v
         7GHONINLqCe43o6fkirWPYb/W1t+Hz6+sP48jCgBg9XNPz3W9tQ2g+0ta7uCzK4T98WH
         nxcwmSrwDBxnCXbOAn0/+XpkA56WWVlfpLkt9JK15nKA3IYZqcm/OSJ3dOprMwXzwtnD
         JboQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Tgg/OE2/st6+uFkmQwiaWY7b+yAzhNc65AuvkK+alZOTZmSvxvJcvfUin/5d89br7cMjNk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyK7wXn4cizboN5doDh0XLutFE0njLBbDBHXqOKXPhTzYwL/AY
	AqGoI+SLg+YY1x2l06BeGl6cyzxsO7WJ5p7Ss8zBGbt6OcYUwo4aK30Np5z5eLDEC85zAve7tEa
	ETNLbZ3U0n5KhRcg323QnBafYv6s49ys=
X-Gm-Gg: ASbGnctI1J64c10aLaFPkrZRe7eyMXcxdvUuhagwNLJMHWx/8cVQaTHAAgUXRW9CZOL
	T/hO+3sogkZzfas7J4+2p0NLrcl1/xPOZ1aqkuXl49Y1/DoEgE/kINiDvxhhtRgiaZz9iihbds2
	LdUfYI0gMBvJRu3E6al0QdNjv8eqrY2uJzJs05+0A7IEHTsic+OD7BW8YNon1G/ndrVzFwdGj9b
	Cu0GjeA3Q73+R5E8Qrd0A2rOQvqsZmtAsGugu+5X+toDhWNnNQvr5vRJHOZaK69FytnnXxRBqjK
	ucJYzc8=
X-Google-Smtp-Source: AGHT+IGl5uGRbmbZLL5/wdiOHc0P0AlgpbUQEkv+/OS3nj0yAr+2M9EwB6fqHN6SeNM2W4NfF3pf+/0qdkabuuH8kJo=
X-Received: by 2002:a05:6000:705:b0:426:f9d3:2feb with SMTP id
 ffacd0b85a97d-42704beea1emr3600647f8f.23.1760720464982; Fri, 17 Oct 2025
 10:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <YfEhaK7VtJ4oru03@shell.armlinux.org.uk>
In-Reply-To: <YfEhaK7VtJ4oru03@shell.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 17 Oct 2025 18:00:38 +0100
X-Gm-Features: AS18NWDRvAVPn4Jf57le9CYGXnLlVvbhb67dsacK4IgBFRScoJpp_oMsiemCpA8
Message-ID: <CA+V-a8taTL1aQ5L1uYfJ405X38953z1FO=X5S54QBqGxLsF5ow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net: stmmac/xpcs: modernise PCS support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 26, 2022 at 10:32=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> This series updates xpcs and stmmac for the recent changes to phylink
> to better support split PCS and to get rid of private MAC validation
> functions.
>
> This series is slightly more involved than other conversions as stmmac
> has already had optional proper split PCS support.
>
> The first six patches of this series were originally posted on 16th
> December for CFT, and Wong Vee Khee reported his Intel Elkhart Lake
> setup was fine the first six these. However, no tested-by was given.
>
> The patches:
>
> 1) Provide a function to query the xpcs for the interface modes that
>    are supported.
>
> 2) Populates the MAC capabilities and switches stmmac_validate() to use
>    phylink_get_linkmodes(). We do not use phylink_generic_validate() yet
>    as (a) we do not always have the supported interfaces populated, and
>    (b) the existing code does not restrict based on interface. There
>    should be no functional effect from this patch.
>
> 3) Populates phylink's supported interfaces from the xpcs when the xpcs
>    is configured by firmware and also the firmware configured interface
>    mode. Note: this will restrict stmmac to only supporting these
>    interfaces modes - stmmac maintainers need to verify that this
>    behaviour is acceptable.
>
> 4) stmmac_validate() tail-calls xpcs_validate(), but we don't need it to
>    now that PCS have their own validation method. Convert stmmac and
>    xpcs to use this method instead.
>
> 5) xpcs sets the poll field of phylink_pcs to true, meaning xpcs
>    requires its status to be polled. There is no need to also set the
>    phylink_config.pcs_poll. Remove this.
>
> 6) Switch to phylink_generic_validate(). This is probably the most
>    contravertial change in this patch set as this will cause the MAC to
>    restrict link modes based on the interface mode. From an inspection
>    of the xpcs driver, this should be safe, as XPCS only further
>    restricts the link modes to a subset of these (whether that is
>    correct or not is not an issue I am addressing here.) For
>    implementations that do not use xpcs, this is a more open question
>    and needs feedback from stmmac maintainers.
>
> 7) Convert to use mac_select_pcs() rather than phylink_set_pcs() to set
>    the PCS - the intention is to eventually remove phylink_set_pcs()
>    once there are no more users of this.
>
> v2: fix signoff and temporary warning in patch 4
>
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 147 +++++++---------=
------
>  drivers/net/pcs/pcs-xpcs.c                        |  41 +++---
>  include/linux/pcs/pcs-xpcs.h                      |   3 +-
>  3 files changed, 73 insertions(+), 118 deletions(-)
>
Although RZ/V2H doesn't have PCS, it tested this on Renesas RZ/V2H EVK
and found no regressions.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

