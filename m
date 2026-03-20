Return-Path: <netdev+bounces-270018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E8UG2qPvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:18:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7452DF483
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84352300AD8D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8D3E6DDA;
	Fri, 20 Mar 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXBmeHio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109343E63A0
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030691; cv=none; b=rbGZjag472xEzv6920OwaMn5KK+QhqPyIxJpIfon+h6RQi60S9GbPrk74QVRxjk7EV7zf1T13JTAT951oSYrAM+LZ4/9gZBqmWlEfJlJ/heAiXfNk6wg0aPT3bcvBSAWmmCPwoAoNu4im9Rtt21UYRwGcNKEJ9kwPf6c/UcA5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030691; c=relaxed/simple;
	bh=TveWmGtGF+NJQXSywEPJlwFGnrefgR4bV3UdzJamrTs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t8162q2XLF2yUuRimjPXQ9fDY4JPraNVASy7l1wsyF4s5up/ofOO6hgD3gr93YGpcwMLbpsJJLEOacGBK0sCL6qtAn1qGZgZl8Kzk5TqKlh9EL9qZZAbIuWlvWLclvibgA88w+EN2w6TcUpvUaJbV/9crFQy7+4XzeVqAeYeGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXBmeHio; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-482f454be5bso31805785e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030688; x=1774635488; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzgXZ3NiL5XfSi1Gl8c37CbUSVUYSABbSljKRuEeP+I=;
        b=cXBmeHioXEbh2o1U349rQL9HP8fHUf5F6ct2aryUjcp6BLhjFmXWqCLBzVBW5Wi13K
         iyEByVAbaHragCM875vXbtWe+wbIEkVy+Dr0GedhQQBFmLG6tHOHFpIdJhNx/YWewQJL
         kWIQkHfpxloYpwmcUa0VnRAXa4POJbbtNmgl3dKqau52ue/ff17waWkNVMUGZM8yLqVO
         b08Z08s5E1l3J4cdExrI5r6zh4I0MD80+DgnU3gRwOcpFW+XMWL3A/Oxm8UWhy3YOs11
         X6B0gr0frgGK2iImaYYTVxeAYy3q8wmoxP5XN8pto8bODYelG+ypInnO8l/TYzYOloVs
         t+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030688; x=1774635488;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzgXZ3NiL5XfSi1Gl8c37CbUSVUYSABbSljKRuEeP+I=;
        b=j9C3YqXFMdvBSH5woMuc2VHcEKdEt5X8oG6SQRtpDF3H9Nb1w9XtkxW4ekr8Lthf1c
         4ZI8T+ODSjFFPbJ+kb5ETddW5nXVMuckr0XDozSIX1zskB66qWSNsuTElVL6NecyeB6/
         z7CktPVF4GpIWMWT5XhrnApDy1UjJwZKHrPimQ9M4ZaOh2WZ/YfdUyOpGXd6fJSIl/+e
         ZOwSoiZPvZ19nkHXkdeGp38vFnQwd6AOGNRM5CMYfd8zFcrW4tT0xSwgfv90mbtpmjgH
         cunTF4Ejg3Pwsn4bSs9Uja71ZlwfFPhu/LpRXapTRgG+y/GXjSbstm5Oq04++EsXXjX1
         0s0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFx53ZQFC4W9Gc9mB4PJRnKcOst9YIb3YI0cQdsctLxozYfQQREumfhp1/XFjf0QDc3xhefZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xzSZnoWIeyzZ7/PlmQK86PQmSQ9vP8nk0TSIsHvSDE6BnHPt
	WqSIbyTHHeXIqkY9psFCHiC8YqCdOAr2irnrM0lWgaceeIuMoTnQbZsK7BIHaqED
X-Gm-Gg: ATEYQzyHQi4IGbu4ewqigafQoAXkDmrsrV0TrmOdkmkECfoTd/BeQdxN6o6I04pqZ9F
	AHW2hhgLVuP9Hur64KIvQw5u0IXj5AM05If0i/UaMksa66FmbVqOvj16k3Jp2cMRPVoCzAj3jjU
	wbn/Zm7HPDq/V8ONyAiLXZZRkbBEWNIe1Tr1IzcfL3oZWr3eaQivtFGqvf6TSUERBrU58R1uHto
	AutNwZPGPfLYiwOa9Nb14drxLiYYbJufBgvd/k1ciTCPBqGElVQiKm8uubASSGRq0pxkTMx/erC
	foFVrYYsUXe4kwjhlTP19LL5sdFWbzw20rkgjb5iA6YGYLiECKhupyjiG33j+rRwwo2Aa2PDbFJ
	UrcgIJjOjKk6qinisFlbmniSHFAZ69mrrmAYk3OUDORRsPqVOr6j8PC2j4mhvL9uPkPCrh1P67T
	MTB/Ji3Z+8SSoCXp18eUZIY3Vs9zxhulJ+VwI6jXmrdMrs5f0SZGOlOE4=
X-Received: by 2002:a05:600d:8449:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-486fe8a2bafmr52731085e9.3.1774030688082;
        Fri, 20 Mar 2026 11:18:08 -0700 (PDT)
Received: from smtpclient.apple ([2001:912:1ac0:1e00:48e8:da36:b41d:78fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487031790fdsm12424335e9.3.2026.03.20.11.18.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:18:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH net-next v9 2/4] net: phy: realtek: add RTL8224 pair order
 support
From: Damien Dejean <dam.dejean@gmail.com>
In-Reply-To: <20260320082156.GX1753385@horms.kernel.org>
Date: Fri, 20 Mar 2026 19:17:56 +0100
Cc: andrew@lunn.ch,
 krzk+dt@kernel.org,
 robh@kernel.org,
 kuba@kernel.org,
 maxime.chevallier@bootlin.com,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 edumazet@google.com,
 davem@davemloft.net,
 hkallweit1@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <46FAC4A6-9462-45BC-B17C-B7F5F19F0ADB@gmail.com>
References: <20260318215502.106528-1-dam.dejean@gmail.com>
 <20260318215502.106528-3-dam.dejean@gmail.com>
 <20260320082156.GX1753385@horms.kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,bootlin.com,redhat.com,vger.kernel.org,google.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-270018-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-0.922];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lkml.org:url]
X-Rspamd-Queue-Id: 6E7452DF483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> Le 20 mars 2026 =C3=A0 09:21, Simon Horman <horms@kernel.org> a =C3=A9cr=
it :
>=20
> Checkpatch warns that ENOSYS only means 'invalid syscall nr'.
>=20
> Looking over the implementation of of_property_read_u32() it seems to =
me
> that -EINVAL is sufficient to detect that a property is not present. =
Which
> may be appropriate here.

I added the check on -ENOSYS because in v8 Jakub commented [1] on the =
fact
that if the kernel is built with CONFIG_OF=3Dn, of_property_read_u32() =
will
return ENOSYS. If ENOSYS is not handled there, then the call will return =
an
error while it shouldn=E2=80=99t.

Damien

[1] https://lkml.org/lkml/2026/3/17/2464

>=20
> Likewise in patch 4/4.
>=20
> Using a quick grep of the tree, I do notice the same pattern as above =
is
> also present (only?) in aquantia_main.c.  So depending on the outcome =
of this
> discussion it might be appropriate to update that too.
>=20
>> +
>> + if (ret)
>> + return ret;
>> +
>> + if (order & ~1)
>> + return -EINVAL;
>> +
>> + return rtl8224_package_modify_mmd(phydev, MDIO_MMD_VEND1,
>> +  RTL8224_VND1_MDI_PAIR_SWAP,
>> +  BIT(port_offset),
>> +  order ? BIT(port_offset) : 0);
>> +}
>> +
>> +static int rtl8224_config_init(struct phy_device *phydev)
>> +{
>> + return rtl8224_mdi_config_order(phydev);
>> +}
>=20
> ...
>=20
>> @@ -2395,6 +2457,8 @@ static struct phy_driver realtek_drvs[] =3D {
>> PHY_ID_MATCH_EXACT(0x001ccad0),
>> .name =3D "RTL8224 2.5Gbps PHY",
>> .flags =3D PHY_POLL_CABLE_TEST,
>> + .probe =3D rtl8224_probe,
>> + .config_init =3D rtl8224_config_init,
>> .get_features =3D rtl822x_c45_get_features,
>> .config_aneg =3D rtl822x_c45_config_aneg,
>> .read_status =3D rtl822x_c45_read_status,
>> --=20
>> 2.47.3
>>=20


