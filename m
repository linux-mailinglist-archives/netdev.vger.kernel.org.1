Return-Path: <netdev+bounces-198126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58427ADB56E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC063ACB23
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5A1F8BCB;
	Mon, 16 Jun 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXDBzzI+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBB20A5EA
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087708; cv=none; b=B8L2hvjhIzSAIU2mP9Xf+3U8i5K+GZa0MytLXDnuMR6QHB97uM1dyvw9bnJXPOVcBaZW1FeYTFSgzBUXB0rcgFVm9UuiC9uyNXuIU8Z8KEnEGNCDb7nwcnqo6Iyz43XKf93NNul3q0hcJwnH/6qF6V7MyRLGgvIGXP9UEnxb6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087708; c=relaxed/simple;
	bh=jUnLMJ4mgEMkxYxXybrAhu8PfopmxSlblONIIEBQ/9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOwpURLcRKfgy2UYS0Ji8hC5nlJ2yWGxpdVZntEaCaRFMbB09/jVRaX0nj2HV+9FPMTX0leClsDekfSOickNlZ6MyloOLLiXs5WK255e0JE39hsD95zFx4wcHcFoMX3nJZguXaPvQNlWSrHHmPPzN+enS/skoSDEJtl/lu1wuFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXDBzzI+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso41745865e9.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750087705; x=1750692505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmdgOwIBmyglhlfesmuFCDBliZsplgBzQwxIfVkAcpI=;
        b=dXDBzzI+RdrcLezRZckPSnxYh7MV3EcesGPzOO2DS2Gawx8NEDi1bnA+EBp6yUanwS
         jF/Aps2HtC4ADiolJb7pL7R6s0QbJA6RSq4DzCz2DQdImN6EW/713MEOJh0oGy8rmtXp
         NWYlwjvUrmQHDxhwf9OyaeMzNJza82PHRNve/09MjuOQuetl9U8Y5oPikvdSZVgdHrm8
         RaETVWeUvJz4dcDLh3iPEPOH1asmUaDhqPK3O+YixMqVVI1LXvw2dWmV64X3axFTy/CS
         LgZvvV1fIk+Z/uQlUI2gia8VZ6aFa/hYwgJFLLwOqiHnljl9DnrjOPMW1iy9BkLZx7GL
         t4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087705; x=1750692505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmdgOwIBmyglhlfesmuFCDBliZsplgBzQwxIfVkAcpI=;
        b=RxXMyB+BbIOhBgZdpAQcmnvuXqqhcvwbkkfyl5zh2C4cFIpwW8SGW7EymjkCU1WcFl
         Jpf3TQlDzaV298zWqfyx5+Jyghb95o/kQtM0vLLy+6rDOSN2tNxSUk7Vtc12Z8d2KO6C
         h0e7+whil6Cvjg6C5qyhHfM1Q6P8hpXBTQhzdUf0HmcS3GncmBHzS7kE6MK8DQo4zQX9
         ibv8Yr087bArAqnv5S4UkrJSMnBFMjJu3rzXTlyaVd9s1uYPKjlcDChdCPNxFQLsSdwq
         bUmsKA02Lj2jDYxLHAItvKMPG9J8NtKCvtd3XoX//qE5XLdLXU7/Zb67Ecp6KYXyfrny
         Vu0g==
X-Forwarded-Encrypted: i=1; AJvYcCX5swsztGzxw600usTHmhwQVyb6mtoYrO3cidEOODV8rGy/lypVZR+YZpWuLQp0zqVWmNnFxQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7iv+tY9liFhM8efGP03ogtx5rNaZ/8KfSRrV+COx3wZD4sZJ
	l6x12NHEjPllot7bcvO6OKPVV1nh0jQZLBic8zGE0OaWxnGT3QObmWBD4wQK7omJEBBzhz1MUfp
	xVPRzI+be86gUw813qBgI25hT8KSlolM=
X-Gm-Gg: ASbGnctn9OOu/vB+s+8UIE5VmpEGQo7TZIQkrT2AERT3mOX/37Y6f7T56x+dfEAUX2t
	Xgyo+b2WKG+QZ/MvRyrBPckTANTwgLH7qorR4/MVsNNM/Lp9Moivr47e0kjs/AAvrt9HxuZ5CX0
	/lS3X7EeW57b5+r8nCl90BkqG4Pao+5H5aeZllFeDyD09lXiN3VuNuxlo6XToFAmXXWXxcLAW4p
	52V
X-Google-Smtp-Source: AGHT+IESXL7C94oRtg/mkfMxvKP9HHopRp+Mm8QZHzfXF8KOACq57ge9LME5YaZIIT/GvljQEVeuc37Y6wlacvHyNDk=
X-Received: by 2002:a05:6000:188d:b0:3a4:ef8e:b31b with SMTP id
 ffacd0b85a97d-3a5723840f1mr7397820f8f.24.1750087704462; Mon, 16 Jun 2025
 08:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal> <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal> <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
 <20250613160024.GC436744@unreal> <aEyprg21XsgmJoOR@shell.armlinux.org.uk>
 <CAKgT0UdkGK7L6jYWW9iy_RnZV8+FofSGV+HTMvC3-fBtCBoGyQ@mail.gmail.com> <aE_oue0q4QhoYggH@shell.armlinux.org.uk>
In-Reply-To: <aE_oue0q4QhoYggH@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 16 Jun 2025 08:27:47 -0700
X-Gm-Features: AX0GCFtZBRE6whXDmemKalxlXu214mW0vVsyUfnIfD0Pv3X4Rl3s3GMNU2p835U
Message-ID: <CAKgT0UexXaC+RHODH2peYCYjLvsWE+Yd+_hJSjewrRWrBH6XBA@mail.gmail.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:49=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Sat, Jun 14, 2025 at 09:26:00AM -0700, Alexander Duyck wrote:
> > On Fri, Jun 13, 2025 at 3:44=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Jun 13, 2025 at 07:00:24PM +0300, Leon Romanovsky wrote:
> > > > Excellent, like you said, no one needs this code except fbnic, whic=
h is
> > > > exactly as was agreed - no core in/out API changes special for fbni=
c.
> > >
> > > Rather than getting all religious about this, I'd prefer to ask a
> > > different question.
> > >
> > > Is it useful to add 50GBASER, LAUI and 100GBASEP PHY interface modes,
> > > and would anyone else use them? That's the real question here, and
> > > *not* whomever is submitting the patches or who is the first user.
> > >
> > > So, let's look into this. According to the proposed code and comments=
,
> > > PHY_INTERFACE_MODE_50GBASER is a single lane for 50G with clause 134
> > > FEC.
> > >
> > > LAUI seems to also be a single lane 50G, no mention about FEC (so one
> > > assumes it has none) and the comment states it's an attachment unit
> > > interface. It doesn't mention anything else about it.
> > >
> > > Lastly, we have PHY_INTERFACE_MDOE_100GBASEP, which is again a single
> > > lane running at 100G with clause 134 FEC.
> > >
> > > I assume these are *all* IEEE 802.3 defined protocols, sadly my 2018
> > > version of 802.3 doesn't cover them. If they are, then someday, it is
> > > probable that someone will want these definitions.
> >
> > Yes, they are all 802.3 protocols. The definition for these all start
> > with clause 131-140 in the IEEE spec.
>
> Good.
>
> > > Now, looking at the SFP code:
> > > - We already have SFF8024_ECC_100GBASE_CR4 which is value 0x0b.
> > >   SFF-8024 says that this is "100GBASE-CR4, 25GBASE-CR, CA-25G-L,
> > >   50GBASE-CR2 with RS (Clause 91) FEC".
> > >
> > >   We have a linkmode for 100GBASE-CR4 which we already use, and the
> > >   code adds the LAUI interface.
> >
> > The LAUI interface is based on the definition in clause 135 of the
> > IEEE spec. Basically the spec calls it out as LAUI-2 which is used for
> > cases where the FEC is either not present or implemented past the PCS
> > PMA.
>
> Please name things as per the 802.3 spec, although "based on" suggests
> it isn't strictly to the 802.3 spec... I don't have a recent enough spec
> to be able to check yet.

So just to confirm, would prefer I include the 2 then? The datasheet I
was working with referred to the mode as RXLAUI and then required
clock modification to take it from 20.625Gbd to 25.78125Gbd per lane.
Since there was the clock modification aspect I thought it better to
just call it as LAUI since this is already 2 steps away from XLAUI as
we reduced the lanes and bumped up the clock.

> > >   Well, "50GBASE-CR2" is 50GBASE-R over two lanes over a copper cable=
.
> > >   So, this doesn't fit as LAUI is as per the definition above
> > >   extracted from the code.
> >
> > In the 50G spec LAUI is a 2 lane setup that is running over NRZ, the
> > PAM4 variant is 50GAUI and can run over 2 lanes or 1.
>
> I guess what you're saying here is that 802.3 LAUI-2 is NRZ, whereas
> your LAUI is PAM4 ? Please nail this down properly, is your LAUI
> specific to your implementation, or is it defined by 802.3?

No. The LAUI is NRZ running at 25.78125Gbd without FEC over 2 lanes.
Where things go out-of-spec would be when we add the FEC for the
25/50G consortium and then push that out over the wire. At that point
we would no longer be within the IEEE spec as the expectation is for
clause 134 FEC for all the 50G links. So the main non-spec piece would
be the use of something other than RS(544/514) which isn't used by
anybody for 50G links that I can tell as the main use seems to be
RS(528/514) to match up to 25GbaseR/100GBaseR4 and the 25/50G
consortium implementation.

50GAUI is running at 26.5625Gbd w/ RS(544,514) FEC, aka clause 134,
and either runs 2 lanes of NRZ, or 1 lane of PAM4. As per the spec,
50GAUI it is a fair bit more flexible too. It allows for running it
back and forth through PMA MUXes to either increase or decrease the
lane count.

I don't think our setup is anything proprietary. I am suspecting I
will need to carry the code into the XPCS driver as well as I think
they are supporting this mode with just XLGMII currently, and I am
pretty sure we are using the same IP. Where I think we might differ is
that we provide an option to change the interface mode via registers
that control the signals to the PCS. So we can shift the PCS up and
down depending on if we want 25R1, 50R2, 50R1, or 100R2.

> > > - Adding SFF8024_ECC_200GBASE_CR4 which has value 0x40. SFF-8024
> > >   says this is "50GBASE-CR, 100GBASE-CR2, 200GBASE-CR4". No other
> > >   information, e.g. whether FEC is supported or not.
> >
> > Yeah, it makes it about as clear as mud. Especially since they use "R"
> > in the naming, but then in the IEEE spec they explain that the
> > 100GbaseP is essentially the R form for 2 lanes or less but they
> > rename it with "P" to indicate PAM4 instead of NRZ.
>
> So, 100GBASE-R is four lanes, 100GBASE-P is two or one lane using PAM4,
> right?

Yes.

> > >   We do have ETHTOOL_LINK_MODE_50000baseCR_Full_BIT, which is added.
> > >   This is added with PHY_INTERFACE_MODE_50GBASER
> > >
> > >   Similar for ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT, but with
> > >   PHY_INTERFACE_MDOE_100GBASEP. BASE-P doesn't sound like it's
> > >   compatible with BASE-R, but I have no information on this.
> > >
> > >   Finally, we have ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT which
> > >   has not been added.
> >
> > I was only adding what I could test. Basically in our case we have the
> > CR4 cable that is running 2 links at CR2 based on the division of the
> > cable.
>
> Much of these translations are based on documentation rather than
> testing, especially for speeds >10G. Adding the faster speeds helps
> avoid a stream of patches as people test other modules, unless the
> spec is actually wrong.

Well I have been able to test the above, and from what I can tell it
is correct based on the spec but assumes multi-lane QSFP support. I
think naming is going to be the biggest challenge with all this as
there are 2 specs floating around for this section based on the 25/50G
Consortium and IEEE 802.3 so I am going to try to stick to the 802.3
for the naming, but I worry that some of the lines might get blurred
like the LAUI setup I did which from what I can tell is somewhat a nod
to the setups where this can run without FEC being enabled, or
something other than the Clause 134 FEC.

> > > So, it looks to me like some of these additions could be useful one
> > > day, but I'm not convinced that their use with SFPs is correct.
> >
> > Arguably this isn't SPF, this QSFP which is divisible. For QSFP and
> > QSFP+ they didn't do as good a job of explaining it as they did with
> > QSFP-DD where the CMIS provides an explanation on how to advertise the
> > ability to split up the connection into mulitple links.
>
>
>
> >
> > > Now, the next question is whether we have anyone else who could
> > > possibly use this.
> > >
> > > Well, we have the LX2160A SoC in mainline, used on SolidRun boards
> > > that are available. These support 25GBASE-R, what could be called
> > > 50GBASE-R2 (CAUI-2), and what could be called 100GBASE-R4 (CAUI-4).
> > >
> > > This is currently as far as my analysis has gone, and I'm starting
> > > to fall asleep, so it's time to stop trying to comment further on
> > > this right now. Some of what I've written may not be entirely
> > > accurate either. I'm unlikely to have time to provide any further
> > > comment until after the weekend.
> > >
> > > However, I think a summary would be... the additions could be useful
> > > but currently seem to me wrongly used.
> >
> > If needed I can probably drop the 200G QSFP support for now until we
> > can get around to actually adding QSFP support instead of just 200G
> > support. I am pretty sure only the 50G could be supported by a SFP as
> > it would be a single lane setup, I don't know if SFP can support
> > multiple lanes anyway.
>
> Electrically, a SFP cage only has a fixed number of pins, and only has
> sufficient to support one lane. As such, I'm not sure it makes sense to
> add the >1 lane protocols to phylink_sfp_interfaces. I think if we want
> to do that, we need to include the number of lanes that the cage has at
> the use sites.

Okay. What I can do for now is clean up the code so that we only allow
the one lane protocols in the SFP setup. I just wasn't sure if that
was the case as 100G was already supported and if I recall correctly
that required 4 lanes to support so I had just been following the
pattern from there.

I can re-introduce the multi-lane setups for QSFP when we look at
getting QSFP support enabled as that is what really introduces the
concept of partitioning the link anyway.

