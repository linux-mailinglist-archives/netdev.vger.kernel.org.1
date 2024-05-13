Return-Path: <netdev+bounces-96118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 397CA8C4614
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84ABCB2100E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FC20DF7;
	Mon, 13 May 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U2YkRFCI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183C20DE8
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621553; cv=none; b=hRLRxTsdWcK6JbnOOUc+tZhQxlL3AqfloA8sqdf/5jQ3oAip+6TQyGumMzD9bDvqVIhvNk18+npya0PM6dk9BiOeIXAKIr07RCEnOQnndobWwT+NbOsaSjOSme/5LVKZebEBVNiKmvLiqFso8dQbe5L53fgjwGGioXIT3gPxM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621553; c=relaxed/simple;
	bh=fXGQ64UwaBGW2PqZrX1S/gcdyXJ/tJlPbgzzA2oT+MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPhsk1aQgRougCoFXKjP8AouT6Oo3QPFd911g7hy+/V35ca5L4LGQwMH6hbQ6ahhktLFVMApQgFxgF3B7MbUpXXMwH6sOGJK+Oyb7YFNbbMclp3dWgUfYLXEaqFRZusemO7VH8KYoqpDruHtLuitpfl5VHnj2G/ORJaUaaBTqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U2YkRFCI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b2bc7b37bcso4086148a91.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715621551; x=1716226351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBskcfG9aM08EQ3NqSBzF1A9Ml9c1SIZv/ydH3cvOC8=;
        b=U2YkRFCI60P/XRuJlR8+NK/0cAsD0Ch4VG/5GHHAOK0awnX1C46PgOVjhkG9rVapxa
         M8E5VklMMQAsHZUeedEdnZzafdaj2EckpYD9g9nuNsTt6CiqumyaTIPtHSyibgsXINV8
         vvuS0+6N5kdPKW4w24p8ZJri96se96SFA3ymY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621551; x=1716226351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBskcfG9aM08EQ3NqSBzF1A9Ml9c1SIZv/ydH3cvOC8=;
        b=OV6lW0VluKpRKovftApfJTAgMASXyp5Al9gG1t/dsf8ZYGJd4Ii0FyqGGrWiRecXeL
         XCuk0CKpEfm1VlLIuMZn/10a/OrC3cx4dLdHYZ8zKHc6tteFoZQM1i+fArQhOY6UIfSX
         O0zg5yjYiNhtVrBx+GeSJIyTFxUhJUQ5CvN1UJ1Vv+H7wbugeONoRglsKT47sol9CfZN
         ABm98UH25+bYpkiaky5dMGFARO52LhawFDDieMzReG7gVI0396jlaOtiqD6EEqZ3tSKd
         WBJeK5rzKYVSmeLtO+cvlUqELZ2lhcOILFRMNJHJ6Qhbo9Nzwkj3ZHeZz9HaS1QyN4r5
         I7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/TWIouHcS4OvynmRFVtzaU/pEekBKprI5vNwTTbif7X7KBbLLznmdTCmOzHYQfej0jKfAlX7BC2wOrIFKySODWxMEfqg
X-Gm-Message-State: AOJu0YyEFrt9jVlQFFatl91ZOGxQ8ryc2HWBnpyeTGnX7oSaJqoCp3/1
	HwO2Jc3yB5YbZMeZqbV5LCmbVAyatom7LTGz/m6LwleUqe9IVDqS4LNsziZEWiyGGx8HzUBYdH3
	pqno8KybWp9QJ7x/KuSavxW7jd6OPCqDvya+Q
X-Google-Smtp-Source: AGHT+IF7+dEtjAXbfnCYpn8cxOY0NsZcjmqTQO78In26AeAGJNxjpO+h8xHhH1On7C8lWFuqkMS0FE5B4iZVrdBg0b4=
X-Received: by 2002:a17:90b:4f82:b0:2a1:f586:d203 with SMTP id
 98e67ed59e1d1-2b6ccd8874amr9380254a91.41.1715621550896; Mon, 13 May 2024
 10:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com> <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
 <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk> <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
In-Reply-To: <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 13 May 2024 10:32:19 -0700
Message-ID: <CAMdnO-+V2npKBoXW5o-5avS9HP84LV+nQkvW6AxbLwFOrZuAGg@mail.gmail.com>
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X SoC
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, richardcochran@gmail.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 10:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Sat, May 11, 2024 at 06:12:38PM +0100, Russell King (Oracle) wrote:
> > On Sat, May 11, 2024 at 06:16:52PM +0200, Andrew Lunn wrote:
> > > > + /* This device interface is directly attached to the switch chip =
on
> > > > +  *  the SoC. Since no MDIO is present, register fixed_phy.
> > > > +  */
> > > > + brcm_priv->phy_dev =3D
> > > > +          fixed_phy_register(PHY_POLL,
> > > > +                             &dwxgmac_brcm_fixed_phy_status, NULL)=
;
> > > > + if (IS_ERR(brcm_priv->phy_dev)) {
> > > > +         dev_err(&pdev->dev, "%s\tNo PHY/fixed_PHY found\n", __fun=
c__);
> > > > +         return -ENODEV;
> > > > + }
> > > > + phy_attached_info(brcm_priv->phy_dev);
> > >
> > > What switch is it? Will there be patches to extend SF2?
> >
> > ... and why is this legacy fixed_phy even necessary when stmmac uses
> > phylink which supports fixed links, including with custom fixed status?
>
> And now you mentions legacy Fixed link:
>
> +MODULE_DESCRIPTION("Broadcom 10G Automotive Ethernet PCIe driver");
>
> This claims it is a 10G device. You cannot represent 10G using legacy
> fixed link.
>
> Does this MAC directly connect to the switch within the SoC? There is
> no external MII interface? Realtek have been posting a MAC driver for
> something similar were the MAC is directly connected to the switch
> within the SoC. The MAC is fixed at 5G, there is no phylink/phylib
> support, set_link_ksetting return -EOPNOTSUPP and get_link_ksettings
> returns hard coded 5G.
>
> We need a better understanding of the architecture here, before we can
> advise the correct way to do this.
>
Yes, the MAC directly connects to switch within the SoC with no external MI=
I.
The SoC is BCM89586M/BCM89587 automotive ethernet switch.
The SOC presents PCIE interfaces on BCM89586M/BCM89587 automotive
ethernet switch.
The switch supports many ethernet interfaces out of which one or two
interfaces are presented as PCIE endpoints to the host connected on
the PCIE bus.
The MAC connects to switch using XGMII interface internal to the SOC.
The high level diagram is shown below:

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
   +--------+                     |                     BCM8958X
switch SoC               +----------------+         |
   | Host   |                      |  +----------------+
    +-------+                 |                     |         | =3D=3D=3D
more ethernet IFs
   | CPU   | =3D=3D=3DPCIE=3D=3D=3D| PCIE endpoint |=3D=3DDMA=3D=3D| MAC |=
=3D=3DXGMII=3D=3D|
switch fabric |         | =3D=3D=3D more ethernet IFs
   |Linux   |                      | +----------------+
   +-------+                 |                      |         |
   +-------+                       |
                                      +-----------------+        |

+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
Since the legacy fixed link cannot support 10G, we are initializing to
fixed speed 1G.
>       Andrew

