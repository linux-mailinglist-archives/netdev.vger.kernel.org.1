Return-Path: <netdev+bounces-230546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F045CBEAFDF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F425747D31
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E02F9DA4;
	Fri, 17 Oct 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giYRHGJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373852F8BFF
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720578; cv=none; b=cz4kHy+GMLYDQbg1Df+idvSFOU7gGjOClRt+IxIBo1tMaPM4gEvtLMx4yNN9BqbUVttX1zaOEofeRPa9lR01zNrWCjIIVcDP9qwbAy/UphE+xJIBwlytLCEhaeR9DlAq9QCxy2l9yIzysgNXjo4gdg8FZ1uvi1cnuhWCqiqmco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720578; c=relaxed/simple;
	bh=OWbgDvUz4T6vNlRyFNq0DUT4KMA1TciihvdC9rOTHfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz86MGCM1QRCImWnmSVYN77LeSizE94AANTLGJikpOqZW7Aa6Ts087mpSU8K0Ukc7djhKnqhgSkdbTMBLAgGtFSMxaf8QbRBiwhRJjYNsXaZBt1Lr1jld8J/Y1j5mM9x5hEcjMH/4m4V4QJOeO4M9H0NOgb0hMhdhTSQjG2oTUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giYRHGJv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-427007b1fe5so1287735f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760720574; x=1761325374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55RDAqJOlsF7cspILuwSRpcdchDKHFWIMFN0rshDS00=;
        b=giYRHGJvcA7VgoXMS6OBsAa1CeGdfo02zF1G2+BU9CHH4FM+U2EHeFEN/2cgGURlP1
         ya0AOeIiRZPoMzPlh+mvY6xBbFpnMF2TuRp8taFgBrMiVI3/7P2E+VxywqNxzjrZjfrz
         lSMIYih5c55faGBRUy0CL8tlaoSirhx1qSLYqqgMqfZPboFJ/W1u7xcF2hAJQJdEcb+M
         k4YD4RRlelSSwiVqLYnyASI5c++1a0KHLnuACMRFR2xiOqcQwgXXEPO+fHNpsfzRTrtA
         gfJBI3Vc9w0ct94Amg2IWsG2naVi/MFENKP1xSWDaCjV5pQRncTV3YndwjCkSKAx01cP
         qcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720574; x=1761325374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55RDAqJOlsF7cspILuwSRpcdchDKHFWIMFN0rshDS00=;
        b=UPBJbcal2HwlfEgMj8eJ3ytpdLX6oD280aUqtPAFNbG1+XiMyZADja3ya/y9Zkv84q
         +89g+4Du+VLsNyItPovGINjO1smgh6+5FmbB3uD96I9OkheV6bL0ACqI1uuLVFsiGG/p
         HgBHQ2ZRlAZebpsEUSwKBR1KJI7dvxB3KTnNKHk+Ue7sB1XDo5PqMbgabop/4iIwGi3Q
         KRZ7EjTmGhswsSDRpb1Fn43u+z2lBC5jM2U5Lp6C9j9sbQMQutKie+TKFdm3l/JDgcXD
         QOGQlUXjAJNCPhlHt2L7t3Omf2LgkFSu5g1pTVSSTyE+rXhltQDDkHtgLMGDBy3NZ+lR
         nTdw==
X-Forwarded-Encrypted: i=1; AJvYcCXw3ubOXkF19jMZG5F6q700H3pI0lZM7lRO06lWT1kdvqk83PLt8hGsCpIEY4u47PapOB5q6Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwF1i7MtI0YE/rXphyI80r3hDh8Zn4bcKG4W1qTZVxuSTJCaBp
	HTh9KrE2B8hLoz6orcdWB+ZVKbqjYYkwHTR3F7O7ZpzXJ1vayHxUOQW9JO0eosXmGV1Pi+m/5eH
	tfS8rQdwVxtaM3Y3rCeQwBKE0eL56ORI=
X-Gm-Gg: ASbGncu6RuLjX/QKQ4THRnXT3gKrSkMLt9I1/01RAHf4X4DFxwSIhGbFTy0NnuwFpEb
	aclDLOcHNUKB7RYiqUXx6i6tgpSepkZo3/qC6MiCuR6+ZKbwcGAVW1d5puLJUEl1MadqFfbiI/K
	3q+doMIK4W7ptlTlk1QKS1xkKppSDAcniFMPQzMLLAGAYn5NVoYY61zpWInRCYAcCEh9JDhP7ly
	9viEYdjgtTH0T9sEeibiFmAQeYMjZiLy3CIv+lVzDEdf1MMiAx+UeI38RqhNA==
X-Google-Smtp-Source: AGHT+IFVuLjo+i5c3IPWvna7TnCjd/xxCKMaX2xPnsJedsSIowSo9qclvYxNvzwvo+hSZ3qc4RHxZPFW9pF6/iHQQLk=
X-Received: by 2002:a5d:5888:0:b0:426:f38a:a51 with SMTP id
 ffacd0b85a97d-42704d8d684mr3719155f8f.22.1760720574362; Fri, 17 Oct 2025
 10:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <YfEhaK7VtJ4oru03@shell.armlinux.org.uk> <CA+V-a8taTL1aQ5L1uYfJ405X38953z1FO=X5S54QBqGxLsF5ow@mail.gmail.com>
In-Reply-To: <CA+V-a8taTL1aQ5L1uYfJ405X38953z1FO=X5S54QBqGxLsF5ow@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 17 Oct 2025 18:02:28 +0100
X-Gm-Features: AS18NWA6rZbliLLfxCHoG6LQgOdssCxpGbGI-5dUFG30WqziM0nwOAV2pUiLnc8
Message-ID: <CA+V-a8ve+6XPgWAQDJNwzG9ox-BSNqOBrO6JU7dL=yfQPgP0Ag@mail.gmail.com>
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

On Fri, Oct 17, 2025 at 6:00=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi,
>
> On Wed, Jan 26, 2022 at 10:32=E2=80=AFAM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Hi,
> >
> > This series updates xpcs and stmmac for the recent changes to phylink
> > to better support split PCS and to get rid of private MAC validation
> > functions.
> >
> > This series is slightly more involved than other conversions as stmmac
> > has already had optional proper split PCS support.
> >
> > The first six patches of this series were originally posted on 16th
> > December for CFT, and Wong Vee Khee reported his Intel Elkhart Lake
> > setup was fine the first six these. However, no tested-by was given.
> >
> > The patches:
> >
> > 1) Provide a function to query the xpcs for the interface modes that
> >    are supported.
> >
> > 2) Populates the MAC capabilities and switches stmmac_validate() to use
> >    phylink_get_linkmodes(). We do not use phylink_generic_validate() ye=
t
> >    as (a) we do not always have the supported interfaces populated, and
> >    (b) the existing code does not restrict based on interface. There
> >    should be no functional effect from this patch.
> >
> > 3) Populates phylink's supported interfaces from the xpcs when the xpcs
> >    is configured by firmware and also the firmware configured interface
> >    mode. Note: this will restrict stmmac to only supporting these
> >    interfaces modes - stmmac maintainers need to verify that this
> >    behaviour is acceptable.
> >
> > 4) stmmac_validate() tail-calls xpcs_validate(), but we don't need it t=
o
> >    now that PCS have their own validation method. Convert stmmac and
> >    xpcs to use this method instead.
> >
> > 5) xpcs sets the poll field of phylink_pcs to true, meaning xpcs
> >    requires its status to be polled. There is no need to also set the
> >    phylink_config.pcs_poll. Remove this.
> >
> > 6) Switch to phylink_generic_validate(). This is probably the most
> >    contravertial change in this patch set as this will cause the MAC to
> >    restrict link modes based on the interface mode. From an inspection
> >    of the xpcs driver, this should be safe, as XPCS only further
> >    restricts the link modes to a subset of these (whether that is
> >    correct or not is not an issue I am addressing here.) For
> >    implementations that do not use xpcs, this is a more open question
> >    and needs feedback from stmmac maintainers.
> >
> > 7) Convert to use mac_select_pcs() rather than phylink_set_pcs() to set
> >    the PCS - the intention is to eventually remove phylink_set_pcs()
> >    once there are no more users of this.
> >
> > v2: fix signoff and temporary warning in patch 4
> >
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 147 +++++++-------=
--------
> >  drivers/net/pcs/pcs-xpcs.c                        |  41 +++---
> >  include/linux/pcs/pcs-xpcs.h                      |   3 +-
> >  3 files changed, 73 insertions(+), 118 deletions(-)
> >
> Although RZ/V2H doesn't have PCS, it tested this on Renesas RZ/V2H EVK
> and found no regressions.
>
Ouch wrong series, retracting the Tested-by.

Cheers,
Prabhakar

