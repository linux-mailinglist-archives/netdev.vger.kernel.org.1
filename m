Return-Path: <netdev+bounces-225115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B29B8E99B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 01:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05973B40F0
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 23:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C38226CFC;
	Sun, 21 Sep 2025 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qthkb1n1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7D1805E
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758497822; cv=none; b=BpXuuOM39OXE/ANVcQhxVQlolniPn5LKLbZoOKmg3kL0WhkmAayVQ8NObtuvmAOYpDGfBRgLzsZUZyYK4Fs52k9QG6bQl3GrOMQj/P7Az/R1JxeyUeRfY52wPxLwYk8iQH0W1FCJd0Rcv+dxDUrrkxuSxR1qr4g451c3ofs6VTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758497822; c=relaxed/simple;
	bh=Jy9iv8eXgUW2eurblj4t+Dk2wGWK/qdeBVQkkUS/1Qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=allHelABkj6+K51YcBYzEBeyc/YrpaQgzGYYDcLjUvTdwGBfYFWY+0YfpICbb3hso/6ybx3gUXjnmES6Ej34O4J6EsPii1TfPUwhywLs21Y/V3uONMd6dHdMphxtmAg/QDClM0T3A2MRVGJf86ZZYYbks2tjzWnVnUkbNexkVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qthkb1n1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-271d1305ad7so13952725ad.2
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 16:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758497820; x=1759102620; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zbD+yBPEBHUU9GO+LWfLJSUyCDLhOgWee8hHgUPQCIA=;
        b=Qthkb1n12ci599H6XqPaakhnoCtOlhtVs6wmnLQks8wJQGjtS1J5XgPSWihn0/D0Iu
         nHOFiQHUC5paWPhIws5tPWkyt8G1Mu0qRC9zYHi2IugiVLR75+rDrbmwQpMq/R8jKQ0m
         N59/lrR9cr4MWboNZyALz5dRLsyrLNL3QuqOtTZYnAyhvuLdNGZMOL24MtJNzlhMXWci
         3CtgTmsG9H/3g1TBwv89hUqUPfNg0bMsROzan3D6DdmKM9iQUbL2u5nqHoX64zjkq5/H
         jz+aPRN/27oy22cM1vcOchkukl7K7qSfW0By9yrSs+U2Qr1uuxWIq9r/45lIVYj3czXG
         a86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758497820; x=1759102620;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbD+yBPEBHUU9GO+LWfLJSUyCDLhOgWee8hHgUPQCIA=;
        b=ECYfdzETozrc0ELBzjEFr5H9162nKs5Rsj+hu2p2PT+hYzjMlmwfGrYLZWzDRlUR0p
         N5eFFfNul2+mnD/BJUYciR4G0sCPdXEzrkWqw0LwI4bvFXIZX6BdvBXvD1TJso+JLATl
         KG0jjBeRQQzQWNjAO68o0UCShpT2olHlq26wSlfWVCIADg0/82u8lYBd04BzAadxiLDl
         m4LKsrl/NhZXC8H8P1upNWnofLCzs8D1mDTjm99Ybc2LuPxlCJ/eF3vCdropPDiLJC0F
         6GmWmokCWCJ5BUBqSFC8z+HFF7ojIvQgwezz9oEPyGiQ/80cssM1+anPbG0tPfnHmlRa
         Ps5A==
X-Gm-Message-State: AOJu0YwHst/EXOn0M8gft8GiVUzd9UJh1gmn0v941GLZWZH7tepJ68uV
	lJ6iu4qirmZQYbaVF+5Q/LoeoINPkyDrIg+hlVZsrKnr/RUvC4EuBuUEvLpzog==
X-Gm-Gg: ASbGncu+1OoUK6Bf+lbHIWbNKKJKX5yZA6stnD+4HfpbfHhYd2vp9gF7ODMevg0uzE+
	Punlxy+nseD5Qdh3A8gAoO+MqbmFCzRLzdRPzrabwtCS8LjEYicDClHS27rfbcC5z1NRPMREpAp
	TEMliVRZCpjBMWmlLnB/HEb8k06VafR/TeZj93AxOlAINGtlvrHSySN1dxtzlvY8epxmuu4CUuI
	dJbBfrY/1AKctqPQQxtycbxhm82dMKddRrInd/gpHT3KGkFwgj/w+nLfNwGE1MJR1vI7cXRAKvF
	VE65zHqlKv7DI1g2t5PQwmlb2gqC6O1LrAGoatM6ad5dZ4mMhXSCSyEzlBfsHtTvFCV4lgBM0Pl
	IwDBBUOhmr26LKNZqyuJY5SZ7ThXv9rHz38IzZ/w0EevK+2kWzKudDWeo5tn0P1hKpQSnuW8136
	8iyQ==
X-Google-Smtp-Source: AGHT+IEebYweczID6I9J4d+ZTcxjA3h0z80MLejK7SErUsWbrjT6OYnp+rm8FaxJ3OLg0zwLUs9I6w==
X-Received: by 2002:a17:903:384b:b0:269:8f2e:e38 with SMTP id d9443c01a7336-269ba4028d8mr160016895ad.6.1758497820258;
        Sun, 21 Sep 2025 16:37:00 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2698030ecc1sm110937565ad.112.2025.09.21.16.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 16:36:59 -0700 (PDT)
Message-ID: <fe7eb1335c11ae91cf6b28d37d1f24daccb2c65d.camel@gmail.com>
Subject: Re: [PATCH net-next] eth: fbnic: Read module EEPROM
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	gustavoars@kernel.org, horms@kernel.org, jacob.e.keller@intel.com,
 kees@kernel.org, 	kernel-team@meta.com, lee@trager.us,
 linux@armlinux.org.uk, pabeni@redhat.com, 	sanman.p211993@gmail.com,
 suhui@nfschina.com, vadim.fedorenko@linux.dev
Date: Sun, 21 Sep 2025 16:36:58 -0700
In-Reply-To: <a7184bd2-2203-465b-b544-4dbea0b9645b@lunn.ch>
References: <20250919191624.1239810-1-mohsin.bashr@gmail.com>
	 <a7184bd2-2203-465b-b544-4dbea0b9645b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 21:25 +0200, Andrew Lunn wrote:
> On Fri, Sep 19, 2025 at 12:16:24PM -0700, Mohsin Bashir wrote:
> > Add support to read module EEPROM for fbnic. Towards this, add required
> > support to issue a new command to the firmware and to receive the respo=
nse
> > to the corresponding command.
> >=20
> > Create a local copy of the data in the completion struct before writing=
 to
> > ethtool_module_eeprom to avoid writing to data in case it is freed. Giv=
en
> > that EEPROM pages are small, the overhead of additional copy is
> > negligible.
> >=20
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> > ---
> >  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  66 +++++++++
> >  drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 135 ++++++++++++++++++
> >  drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  22 +++
> >  3 files changed, 223 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/=
net/ethernet/meta/fbnic/fbnic_ethtool.c
> > index b4ff98ee2051..f6069cddffa5 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > @@ -1635,6 +1635,71 @@ static void fbnic_get_ts_stats(struct net_device=
 *netdev,
> >  	}
> >  }
> > =20
> > +static int
> > +fbnic_get_module_eeprom_by_page(struct net_device *netdev,
> > +				const struct ethtool_module_eeprom *page_data,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	struct fbnic_net *fbn =3D netdev_priv(netdev);
> > +	struct fbnic_fw_completion *fw_cmpl;
> > +	struct fbnic_dev *fbd =3D fbn->fbd;
> > +	int err;
> > +
> > +	if (page_data->i2c_address !=3D 0x50) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Invalid i2c address. Only 0x50 is supported");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (page_data->bank !=3D 0) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Invalid bank. Only 0 is supported");
> > +		return -EINVAL;
> > +	}
> > +
> > +	fw_cmpl =3D __fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_QSFP_READ_RESP,
> > +					page_data->length);
> > +	if (!fw_cmpl)
> > +		return -ENOMEM;
> > +
> > +	/* Initialize completion and queue it for FW to process */
> > +	fw_cmpl->u.qsfp.length =3D page_data->length;
> > +	fw_cmpl->u.qsfp.offset =3D page_data->offset;
> > +	fw_cmpl->u.qsfp.page =3D page_data->page;
> > +	fw_cmpl->u.qsfp.bank =3D page_data->bank;
> > +
> > +	err =3D fbnic_fw_xmit_qsfp_read_msg(fbd, fw_cmpl, page_data->page,
> > +					  page_data->bank, page_data->offset,
> > +					  page_data->length);
> > +	if (err) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Failed to transmit EEPROM read request");
> > +		goto exit_free;
> > +	}
>=20
> At some point, you are going to hand off control of the I2C bus to
> phylink, so it can drive the SFP. I know Alex at least had a plan how
> that will work. At that point, will you just throw this away, and let
> sfp_get_module_eeprom_by_page() implement this?
>=20
> 	Andrew

That would be the general idea. The fbnic_fw_xmit_qsfp_read_msg will
still have to exist as it is essentially the firmware provided front
end to issue a I2C read request to the QSFP module.

I have code that essentially does that somewhere in one of my patch
sets as I had coded it up as proof-of-concept. I am hoping to wrap up
the phydev/phylink code this half. Unfortunately I haven't had a ton of
time as I have been getting pulled in several different directions
lately.

The larger hurdles I am still trying to sort out are adding support for
25/50/100G to a generic clause 45 phydev support in order to support
the fact that we need to deal with a 4s delay due to the PMD needing
time for link training, and then I have to go through and sort out the
PCS/PMA code which may be a bit messy as it looks like XPCS was already
added, but it only seems to support 40G so I will have to sort that
out.

