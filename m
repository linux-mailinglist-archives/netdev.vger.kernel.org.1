Return-Path: <netdev+bounces-226741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76006BA4A1E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A3C7BCE98
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93B261B8C;
	Fri, 26 Sep 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJkel49m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4E23F27B
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904124; cv=none; b=YqZCHmSi7saq3TaJ30LAtVH8GFosyJSnGMiOUTDh9u+6bVaiI9e12w3vT1pNt56L0RWwkPa99yZA5SSgGt691Mg18DjkJQU5TTN6S2xLns8gfKoPiD9hSlpxUe7ZdMR5/94QBpkKIePN1QQq83v3+yRht1Wp+eB2Siv60bz4G7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904124; c=relaxed/simple;
	bh=advGB0s4cY+Eij/iD8U4Na+qAHs8pdRd6nx34nKFrFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2XnSomYmXtat68a7VYRmOVnOVL2wtDlCP4zxiqg+JiSuWL7xlYEXek7DPKIAS0V0YMie9uhXjqaUqKTIgvnHCKUyrgqPOcJA5EE0uC6bmlucD2Xsufpl7jkl19DxWN9pYkqJqLyInpU47ZtkkLAyeqynrPahqeEGZQ7e1KcviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJkel49m; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330631e534eso2408306a91.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904122; x=1759508922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17SdlbsrW/H1oAGhyPo1vRPjIhKSOB2gzK7KjETew8g=;
        b=aJkel49m22/7RXgjQEiTwgVHHdEqo3rlyx0C0kk9t74ov7a+RFJoDRRrKG75NswkZs
         /llklE2NCccXLqnG3WZAqgoxVPoZ/w5FqM1Tik6EOIsbhBCAXLXm12ewCag2fbBn6pB4
         mbdZNpPAcGYQ/rkAg1TRbWZavykJB/ZxaEy7iefU4YxCZBLOXTiExMGkdBFl+HmdSZ7P
         HX++vjTw/PLTShLl/bx1KJNetNyZjYspQusDSZEiaJDJc3/1ajd2xhi5jNhOfcHBMgJi
         VPHi8YrmKsySExBGfPPGG7FUAdhQdUHcXXFljZPsKr1qvbPrdNPsBfNe3g+pNlEdkm/n
         AuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904122; x=1759508922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17SdlbsrW/H1oAGhyPo1vRPjIhKSOB2gzK7KjETew8g=;
        b=iGHCuCZ3aOiDCivTZBNqYE6z1KMovOBwmMmimAcHMnTjfVnqGskLgV1XVLZwE2NcO6
         KiLnZDGm+a32C3aeOeh5RG6ctKGYlzBo/b6HD0BTDDYkCbR8vOumWhClultkv7D7XUJR
         6SIwDVAgEWxIy5p/Wns5fVMuif+myVegJ7qzHUwsO2MnA5M4gEeEdK2PfG4skFc033Ka
         jvrLISLgmedVzkcRzxku9KI6XYOW0K5zqNssKMekMs1PzmT2v9K9tJtA+Q9SdDpTwZs6
         b8nLcJuzwMuk0rQ9MPS5Hi00ON+0C7kFga+0Hp7TYg+COIGt4fEUT/rtnY3td/u8OBgk
         w61Q==
X-Forwarded-Encrypted: i=1; AJvYcCU79+L67S0jpkTJRpBx2JWtRcOATDwcZl3mOj86hSn4NDloU8ncbgWSVisbeXKECVWstm3eBbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHeTiIjTgaS7sIO0pmy1zDECcIIRzHDLdI1EKdrcb3E84PmqK
	TAn3XhvBBx4FvbyqyOARbECpBKDgbaeVziGWhIBH9MEnvq0X8OHt1Sz4cJNJDo3t9Sh7OLZzxRE
	g+UNee9E/gaIgTKvzi8B6cfyuDBZQRo8=
X-Gm-Gg: ASbGncsr0Ob5sy9u34EPdZdudM/zrWXbzXDWj+0PFPrfsEFOK6ODtvHkBiHDwm7DMm4
	QNVvDmRgn2lRcup2+VK3VHsw6LzW8Us5D9ceFffVntHAd7WfMSY0MBP+LW5wCsfNmv5mUqyv792
	fCEy1teqwjUdX7ksjNYSRc8y75HlA/s0K8mHI++ECq1PTpT+Ux0ansmAvSBkPCzjMC0NdgAxpYT
	xN6FZsosxhkOUzlJ9h8FJghBm1Q5xdpSDRSF7Mc9xACR2frJiM=
X-Google-Smtp-Source: AGHT+IFP1pZQQc/fe1s5lC9WTMOccd345qaOrvak7xLKmHiYtcellclXpMJlF7A8FJF338xuOE/Uc1mneQkNtUiDrKk=
X-Received: by 2002:a17:90b:4a01:b0:32b:6eed:d203 with SMTP id
 98e67ed59e1d1-3342a2b126emr9404474a91.24.1758904122505; Fri, 26 Sep 2025
 09:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922131148.1917856-1-mmyangfl@gmail.com> <20250922131148.1917856-3-mmyangfl@gmail.com>
 <aNQvW54sk3EzmoJp@shell.armlinux.org.uk> <fe6a4073-eed0-499d-89ee-04559967b420@lunn.ch>
 <aNREByX9-8VtbH0n@shell.armlinux.org.uk> <CAAXyoMPmwvxsk0vMD5aUvx9ajbeAENtengzUgBteV_CFJoqXWg@mail.gmail.com>
 <f7d78131-7425-487f-a8bb-ed747dd9a194@lunn.ch>
In-Reply-To: <f7d78131-7425-487f-a8bb-ed747dd9a194@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Sat, 27 Sep 2025 00:28:05 +0800
X-Gm-Features: AS18NWC4VpC0VraXX2b7ElF7Q9xckDyqxA2rIp_ujgdQGGcV--mnzBcfmdWMe7A
Message-ID: <CAAXyoMM3QG+zWJQ8tAgZfb4R62APgBaqaKDR=151R7+rzzakCw@mail.gmail.com>
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce PHY_INTERFACE_MODE_REVSGMII
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 12:09=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > > > How does the databook describe reverse SGMII? How does it differ fr=
om
> > > > SGMII?
> > >
> > > It doesn't describe "reverse SGMII". Instead, it describes:
> > >
> > > 1. The TC bit in the MAC configuration register, which makes the bloc=
k
> > >    transmit the speed and duplex from the MAC configuration register
> > >    over RGMII, SGMII or SMII links (only, not 1000base-X.)
> > >
> > > 2. The SGMIIRAL bit in the PCS control register, which switches where
> > >    the SGMII rate adapter layer takes its speed configuration from -
> > >    either the incoming in-band tx_config_reg[15:0] word, or from the
> > >    MAC configuration register. It is explicitly stated for this bit
> > >    that it is for back-to-back MAC links, and as it's specific to
> > >    SGMII, that means a back-to-back SGMII MAC link.
> > >
> > > Set both these bits while the MAC is configured for SGMII mode, and
> > > you have a stmmac MAC which immitates a SGMII PHY as far as the
> > > in-band tx_config_reg[15:0] word is concerned.
> >
> > So any conclusion? Should I go on with REV*MII, or wait for (or write
> > it myself) reverse-mode flag?
>
> Sorry, i'm missing some context here.
>
> Why do you actually need REVSGMII, or at least the concept?
>
> REVMII is used when you connect one MAC to another. You need to
> indicate one ends needs to play the PHY role. This is generally when
> you connect a host MAC to an Ethernet switch, and you want the switch
> to play the PHY role.
>
> Now consider SGMII, when connecting a host MAC to a switch. Why would
> you even use SGMII, 1000BaseX is the more logical choice. You don't
> want the link to run at 100Mbps, or 10Mbps. The link between the host
> and the switch should run as fast as possible. And 1000BaseX is
> symmetrical, you don't need a REV concept.
>
> Also, in these cases, stmmmac is on the host, not the switch, so it
> will have the host role, leaving the switch to play 'PHY'. I'm not
> sure you could even embedded stmmac in a switch, where it might want
> to play 'PHY', because stmmac is software driven, where as a switch is
> all hardware.
>
> So the hardware supports reverse SGMII, but it is not clear to me why
> you would want to use it.
>
>         Andrew
>

Cause I couldn't make 1000BaseX work with qca-ssdk, so I can only
confirm and test REVSGMII mode on my device.

