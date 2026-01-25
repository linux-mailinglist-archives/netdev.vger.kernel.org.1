Return-Path: <netdev+bounces-253151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFH2OZD5dWmwKAEAu9opvQ
	(envelope-from <netdev+bounces-253151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 12:08:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B728026F
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 12:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F96A3005E87
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E759B318135;
	Sun, 25 Jan 2026 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="Y0ZMhF/s"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597130CDBD;
	Sun, 25 Jan 2026 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769339276; cv=none; b=M1k9f2v8lLyeZF6WyOD9tC4yQ7hR8yk5kMsmcEXJC+zCnmWaSqHpKavBEZYEy1IA2sqT/Y9MNd0TcpikyXdq2MJFyzc8NZ1yDJd+AluyMvGKnH7jswwtvFu4VC+xncjolbTBHCFELdmEVwzdIGbDEAu4s2+9zNYcee/JlQPVYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769339276; c=relaxed/simple;
	bh=E461urgd8LlcikGl8eKj3Xspa2K6GJCUSjp/yZOrZeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1Zqgt00KUudRSILzFra3W8TRNY/+C7nCRlFsGuE3hNSU8jbqbU8PbxN5n6qF2sj2ApS6QOlcxNmK1m6Y7kwb1DuI2QdKpdSsOwU1+fBUbF5TZVH5O+3ptbtMipN3msO+rkTRbCJ+e0Ol51c94lXZSNVQJQJpcG70VVIg35/t8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=Y0ZMhF/s; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=Y0ZMhF/s;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60PB7Jtr1581266
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 11:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769339239; bh=ZbYWvdv5K7Sk5v0eLu0u+WMvL3Pp0afi40nSL4j2EOY=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=Y0ZMhF/sxHsKgSIKmMfvN11dHrexrylwr+GwntN+Hq5mngtcsCM/C2Q9yDkZ4Fl9d
	 fD4nvbmG7d3HuPylmJuoceZi81B0Br1Hg8f0RlVoyGPi9k4y/WvFK2A8BxLehacBqr
	 3ncCqDTKfvpNe079rIjwp6p+Mt2xskvJbimDhQlQ=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60PB7J583885267
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 25 Jan 2026 12:07:19 +0100
Received: (nullmailer pid 1277942 invoked by uid 1000);
	Sun, 25 Jan 2026 11:07:19 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: air_en8811h: add Airoha
 AN8811HB support
In-Reply-To: <aff7a69c-e72f-4cb9-8fc5-6d8d1626ab4e@lunn.ch> (Andrew Lunn's
	message of "Sat, 24 Jan 2026 19:33:31 +0100")
Organization: m
References: <20260123075817.1162068-1-bjorn@mork.no>
	<20260123075817.1162068-3-bjorn@mork.no>
	<4a3430cc-5a9a-414e-9dbf-cbc34c8fd019@lunn.ch>
	<87ecnfj6kw.fsf@miraculix.mork.no>
	<aff7a69c-e72f-4cb9-8fc5-6d8d1626ab4e@lunn.ch>
Date: Sun, 25 Jan 2026 12:07:19 +0100
Message-ID: <87a4y2hrx4.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,makrotopia.org,nxp.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-253151-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[mork.no:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mork.no:dkim]
X-Rspamd-Queue-Id: 52B728026F
X-Rspamd-Action: no action

Andrew Lunn <andrew@lunn.ch> writes:
> On Sat, Jan 24, 2026 at 05:53:03PM +0100, Bj=C3=B8rn Mork wrote:
>> Andrew Lunn <andrew@lunn.ch> writes:
>>=20
>> >> +#define AN8811HB_GPIO_OUTPUT		0x5cf8b8
>> >> +#define   AN8811HB_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
>> >
>> >> +	/* Configure led gpio pins as output */
>> >> +	ret =3D air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
>> >> +				      AN8811HB_GPIO_OUTPUT_345,
>> >> +				      AN8811HB_GPIO_OUTPUT_345);
>> >
>> > The code/comment probably does not describe what is actually happening
>> > here. My _guess_ is you are setting a pinmux, disconnecting the pins
>> > from the GPIO controller and connecting them to the LED controller.
>>=20
>> Possibly.  This code is copied from the out-of-tree vendor driver.  We
>> already have similar code and comment in the en8811h probe:
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/driv=
ers/net/phy/air_en8811h.c#n959
>>=20
>> The register addresses and layouts are suspiciously similar:
>>=20
>> #define EN8811H_GPIO_OUTPUT		0xcf8b8
>> #define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
>>=20
>> Without any docs, or a way to test this particular feature, I
>> believe the safest option is to assume that the vendor driver is
>> correct.  Can't start guessing no matter how tempting it is :-)
>
> The writing of the value to the register is likely correct. I just
> think all the names and comments are wrong.
>
> Maybe using magic numbers in this case is actually better?

I agree that it would probably be just as good here.  But I really don't
want to make unnecessary changes to the existing EN8811H code.  Trying
hard to modify as little as possible of that in this series.  And I
believe it's always best to keep the style of similar code blocks inside
as single file/driver.

So unless this is important, I'd prefer to keep the macros and comment.
It is what we have had so far for EN8811H.

> And describe the intent of the code in more general terms, allow the
> pins to be used to driver LEDs.
>
>> I have no other docs either.  The code is based solely on the vendor
>> driver.  But trying to reuse as much as possible of the existing en8811h
>> driver instead of duplicating it like the vendor did.
>
> That is typical of vendors, and i agree with your strategy,.
>
>> I have two almost identical boards with this phy connected to a Mediatek
>> MT7988D SoC.  I can test, and have tested, the features exposed by those
>> boards.  But this is obviously a limited test environment.  There are
>> for example no port LEDs on any of the boards.
>
> So you have no idea if the LEDs actualy blink with traffic, show link
> state etc?

Correct.  I can only test that this code doesn't cause any obvious harm
to other functions.

The options, as I see them, are either
a) dropping this functionality from the driver until someone is able to
   test and adds it back, or
b) keep it in the hope that it works, until someone is able to test and
   either verifies or fixes the code.  Including fixups of the macros
   and comment if/when we get docs

I believe that b) is more likely to succeed, which is why I chose to
include it.


Bj=C3=B8rn

