Return-Path: <netdev+bounces-215565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBBB2F3E8
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8D63B9C07
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DF2F39C0;
	Thu, 21 Aug 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbw0NxOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA262F1FC3;
	Thu, 21 Aug 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768385; cv=none; b=s5i4L95uuXaqp2QHupAFrb9EEPPiGFAomd2bO0MSxz6SVKSTmKb9mCBZpli81Z7uiwMjnNzAhFpkmoUMLny9D0BU5uOdPZ5BqF6+XJZkbwPoEKahvjI3/zmaQxYFLCT9GYO/BqVbQ30k9bHyZBrV9zTOtwE2s8X/rFJSJQBrF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768385; c=relaxed/simple;
	bh=0CVLq6osmPq96XDq28hoHnc4Cidg3ilPC8598ZST/DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qD4q/j8uM95Rtxn6A6e5a/bKHOQ/uE9V1kytQ0I0pBhmx/vgHy7g3C4IWNKsIxpMLEm/6Dowm5yBVHsmwx0f+jo9gP8cv4lHa+EcBW+1W3mpI7x+Yl8NDtMc0nHUrucvOwhmr36vBNXZ/er04Qnp94E8aJCF02+9vlFrYX0swTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbw0NxOo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24457f581aeso5406145ad.0;
        Thu, 21 Aug 2025 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755768383; x=1756373183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz2c6fH0PegEG0/euJ35zwk7H0Lkoqr89To/8warP7g=;
        b=nbw0NxOorZFk5v8QyUoDqsdNp4PTJ2phn6E7p3RsO9FAbxgVsrk2tiSpe05oehqtOb
         zmSHWFfuWMCA4xR7MzkchQWRigwPENlrSLqo3a9+gYKnbUY1nkjBowxLtCcBG7cEbwyi
         RbsXYw3RCB8zo27YQcxd+4wN+aJh3+n8tik7ZJsOE5BXgUlfsR75mYVVx9WW014d/PkC
         QL2538ZfHcij+43SbEy8j6834PXWVVMHTnHKBPmGmlbuw6JMZUANOtRSi7/O25BrCVKO
         nGdl6dLeDtwmb+ReFjfhpd/UsQZ1MTaJ88YgHuWZ+y1lp5PGuI4WiZZ8e54Cb1OBJHKQ
         HAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755768383; x=1756373183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hz2c6fH0PegEG0/euJ35zwk7H0Lkoqr89To/8warP7g=;
        b=vevDa8Ab3eQhlCIb69zUxdml/ZtgELQ7kIyqbOh8ubSQvFT8uttXS8VmgFbr270Ko6
         BD6YyxcmA1PzDYZGGrUJczhKZ5V0j+eecufvvUUQFYXQubhti8MGDE7Y0e8fuXmmrKLb
         8RSyN95i/BIKGWJyBpg2tDQxRPOKNbqVB+VrLPdNJ0KuXS0QJrmZJ2W2cDupt39OtCIG
         VlSMuVV1re+jQ5JMSVkDemYmNkmErxG9rSk/m6Uyb528lvs6Hp7J4JPIebAuS/j9pcDt
         fhW+FvmoR3lgOmD4/q1aTRaGVzuZg0iSfUJHRdFuyMTcGvmSXmqcqPmzJ2IdqjdQQW1M
         af6w==
X-Forwarded-Encrypted: i=1; AJvYcCWUAibW58dpd+oWRLicOlCpv/AHAkGFQpwuSO7H0NmH6TLO4dgZEERTSJp+EJCOQf9V/xFbMFbCjeuu@vger.kernel.org, AJvYcCXygyXEjZZ9vn3v6QKYx06XR796PvgclKHpe9UYOK5/e/1jwDLAyt91UK8uCCcSPEoXa7iOZYKeXhrR3crM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs45xLCxfIZQbWedOsqhH6b1vxkk9E7Xrwy0A/KjT+I3ttx3/B
	56/GpbcJIjffXffTrIaDxFH7S/6U5uHKpeKVtblOhwA/DSOtgIG8IRtsQ5yAyP2599FAC+44sD9
	0mcASy/dUaBToflZfzMaK1HEgHaIXq0/orEnbxNc=
X-Gm-Gg: ASbGncssKpsFZDjkQu76jo+QdZMxmip/+wYNLMk7Et7R1mTNHUI+z9k7chsyKywrpxc
	2FhI5XAJSH+2YCYXF00GBsecbS/rqBd6MxSsh8YlQD64BcZHwLJVrmLwfNpFZhLN3SjZkeONk8/
	sv8vWZgpVKJbwZ8oCw6fE0pOBnwJ2k79INycp86V7aYFgB/Kf72aVe/a8AKRE7vsGVC76D3UVyv
	jkLIxb5VCpwwTuOO2ycAMFdlzWodHJGPw7sMI5X+xNQnomfHnQ=
X-Google-Smtp-Source: AGHT+IE+gi3iryZSMoTSVIeW4YDQiq118LFo6hCsd6U78hkvx+WdbKZDScdgD7b8SXK81gsL07DYxCnPjnP+slSfqGc=
X-Received: by 2002:a17:902:e5c2:b0:246:163b:3bcf with SMTP id
 d9443c01a7336-246163b40e5mr7368645ad.55.1755768383077; Thu, 21 Aug 2025
 02:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820075420.1601068-1-mmyangfl@gmail.com> <20250820075420.1601068-4-mmyangfl@gmail.com>
 <aKbZM6oYhIN6cBQb@shell.armlinux.org.uk>
In-Reply-To: <aKbZM6oYhIN6cBQb@shell.armlinux.org.uk>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 21 Aug 2025 17:25:46 +0800
X-Gm-Features: Ac12FXwMQQM0me3KQLrYFCfyH8I5wZ2VAlw5jYW0DKrweHz-xQ0RjH8kCQ4zynw
Message-ID: <CAAXyoMMGCRZTuhYG0zxTgKdDdgB1brU7BAUiCVR_MheFK-n5Yw@mail.gmail.com>
Subject: Re: [net-next v5 3/3] net: dsa: yt921x: Add support for Motorcomm YT921x
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 4:30=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Aug 20, 2025 at 03:54:16PM +0800, David Yang wrote:
> > +static int
> > +yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mo=
de,
> > +                const struct phylink_link_state *state)
> > +{
> > +     const struct yt921x_info *info =3D priv->info;
> > +     struct device *dev =3D to_device(priv);
> > +     enum yt921x_fixed fixed;
> > +     bool duplex_full;
> > +     u32 mask;
> > +     u32 ctrl;
> > +     int res;
> > +
> > +     if (state->interface !=3D PHY_INTERFACE_MODE_INTERNAL &&
> > +         !yt921x_info_port_is_external(info, port)) {
> > +             dev_err(dev, "Wrong mode %d on port %d\n",
> > +                     state->interface, port);
> > +             return -EINVAL;
> > +     }
> > +
> > +     fixed =3D YT921X_FIXED_NOTFIXED;
> > +     ctrl =3D YT921X_PORT_LINK;
> > +     if (mode =3D=3D MLO_AN_FIXED)
> > +             switch (state->speed) {
>
> Someone clearly doesn't believe in reading the documentation before
> writing code. This also hasn't been tested in any way. Sorry, but
> I'm going to put as much effort into this review as you have into
> understanding the phylink API, and thus my review ends here.
>
> NAK.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Sorry I'm quite new here. I don't understand very clearly why a
different set of calls is involved in dsa_switch_ops, so I referred to
other dsa drivers and made a working driver (at least tested on my
device), but I would appreciate it much if you could point it out in
an earlier version of series.

Sorry for any disturbance.

