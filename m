Return-Path: <netdev+bounces-250515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A59BDD30B6F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF473013567
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14B37C110;
	Fri, 16 Jan 2026 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="D+Y0x8L/"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517937BE9A;
	Fri, 16 Jan 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564361; cv=none; b=mq6944/93DP9wOyxSHXRtixpnpI9i2E5gA+IhI9MBcnSZm3bo7IXaZ3AZEIgAHfJMBD0tQ+sUos0EGJMmI7kIfYaWRVXvQtNcsOo77eQbZerGIKlDgcRmP203GzY+ccm+QzSVtx6qtaCoY6o9/qsxROqD+F8AB4xFznkjkh4A9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564361; c=relaxed/simple;
	bh=l4Z3L0eSIOmedzZKy5xxNT96CXf4nRAYp4vkgSI0/n8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q0HozOWcLkZYQnk5WgYPjfRtoQI865kDtOGGkufPl6QBCFprJCu2BfefB0/0WQKT5Xp59dl3PKcFSEi9/6hnIU8AY4jVfF0WFowvWs5RsWw1vRJZkHbzK0X/IX63iSlLxGxNuGxO1qgB016fNDlfkcphkgBVQsta3DbVlq2LP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=D+Y0x8L/; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=D+Y0x8L/;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60GBpmL2487713
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 11:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1768564308; bh=mwpLxfn20Fc2lrmXykLCG1maMV4wepIXnppFnDA+934=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=D+Y0x8L/Mby7vZuO4ByicLNAvcxOkF957t2d3jIUfuEq1AKakB7Z/zipvjYiHL0rf
	 ChkKFe76SY72v88BktoJM3Ru7idHD+Z2sFregalj2bksLKQqH4rIdjANTK7zyjslGS
	 LFWWXjzrmsoEuvxSkSWQ2+wARAHTZ4vKAb+Wj++E=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60GBplec1938416
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 12:51:48 +0100
Received: (nullmailer pid 552088 invoked by uid 1000);
	Fri, 16 Jan 2026 11:51:47 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S
 . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
In-Reply-To: <aWofM8Y0AIHVESml@shell.armlinux.org.uk> (Russell King's message
	of "Fri, 16 Jan 2026 11:21:23 +0000")
Organization: m
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
	<466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
	<397e0cdd-86de-4978-a068-da8237b6e247@gmail.com>
	<0c181c3d-cb68-4ce4-b505-6fc9d10495cd@bootlin.com>
	<d5c11fec-1e75-46cf-aeae-593fb6a4af09@gmail.com>
	<aWofM8Y0AIHVESml@shell.armlinux.org.uk>
Date: Fri, 16 Jan 2026 12:51:47 +0100
Message-ID: <87jyxhwzak.fsf@miraculix.mork.no>
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

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> On Fri, Jan 16, 2026 at 12:16:11PM +0100, Jonas Jelonek wrote:
>
>> When I come to trying to work on that, should that all be kept in
>> mdio-i2c.c? I'm asking because we have a downstream implementation
>> moving that SMbus stuff to mdio-smbus.c. This covers quite a lot right
>> now, C22/C45 and Rollball, but just with byte access [1]. Because that
>> isn't my work, I'll need to check with the original authors and adapt th=
is
>> for an upstream patch, trying to add word + block access.
>>=20
>> Kind regards,
>> Jonas
>>=20
>> [1] https://github.com/openwrt/openwrt/blob/66b6791abe6f08dec2924b5d9e9e=
7dac93f37bc4/target/linux/realtek/patches-6.12/712-net-phy-add-an-MDIO-SMBu=
s-library.patch
>
> My personal view on this is not suitable for sharing publicly. I'm sure
> people can guess what my view is and why. (Look at the age of the
> patch, and it's clearly "lets re-implement mdio-i2c" rather than "let's
> adapt it".

FWIW, I agree if my guess is correct :-)

I see that my name is on that downstream patch, due to the RollBall
additions there. It was never intended for mainline in that form.  I
originally implemented the SMBus RollBall access methods as part of
mdio-i2c.c and that's where they belong IMHO.

It was briefly discussed here.  But I never had enough time and
motivation to finish this properly. So it ended up as an OpenWrt
specific hack for now.  I certainly won't object to anyone else reusing
any of the code I wrote, if it is any help at all.

Not sure the c45 SMBus stuff in openwrt ever worked BTW. I have only
tested c22 and RollBall over SMBus.


Bj=C3=B8rn

