Return-Path: <netdev+bounces-169916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E73A46736
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC6E188A751
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46421D583;
	Wed, 26 Feb 2025 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="QH4eEtXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC21A01BF;
	Wed, 26 Feb 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588715; cv=none; b=cAXNCqwIO41w89dhEOIAy1U6PicDAVk/H1yeboDknrrRS7gslcp7sd0WLCkemKF9wBskmgdGQeyYbPtRUyfNdhK1l0AZ4VbqslNjPiZinmzKV7MX50KONggMSOkAW/JHqsq4yWgtGw2qsRIhaEBlh/XcjHP52P/9JzaCLQEvzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588715; c=relaxed/simple;
	bh=ypRzZ2zObNci18/WsswuAcEa0/e0UBSYDjvPeqxQn8I=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=TU2hDgELqgC7bJ86wfd3qmhURr7XsnoHOKiFBCsCKgBDYfijfTcZwhWrbkWj0okQW5mahK+VYmik4t8Ftdf4JEivnLHWIUR3GB/Tu0WKohx0FzEaxa9THs+T6i5KIl7F1t41nJpEhbmc68CPWJUdVfSS9M91QOi0+ITV8oxzOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=QH4eEtXJ; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=916645903c=ms@dev.tdt.de>)
	id 1tnKdM-00CVZJ-Ta; Wed, 26 Feb 2025 17:51:45 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1tnKdL-009CW5-QK; Wed, 26 Feb 2025 17:51:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1740588703;
	bh=GM0VcKZjCHnEUU6GMlRDDDCbN9fpMRBoWK8fN5/nSw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QH4eEtXJIFjsEOqQpy+3RX3TWZQvU5S7VA6pzazGAhtZ9YXIuoy+IlIB6r10Rd2XW
	 rG4PeixWun2jOawcNDSBA7lKlUjSgmJLAI4TPGiIjbf9C8pcmxWxxUslC/HQgg4F9T
	 yz0FCxVI2y1IWpZOjOpwLeh0BRGCi2ZzMla1GD7CA+nK8KpxZXTLzqwzh6M3faUYET
	 8Y5xErBp/F2Nvb0yiVuUt5vseTqoW/OzGgvp4eNOSrqijtdc8SD+NVgRj9MhmacFQp
	 NGePDuUcO2nZG2Zc1Hw1p2ED/hj9N3RJxZd4OMfj7Zw0V7A1hurbpRBVc0JZvbjy6W
	 KZTnLzrhkA4Dg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 3C0B7240041;
	Wed, 26 Feb 2025 17:51:43 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 2ACB3240036;
	Wed, 26 Feb 2025 17:51:43 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id CB4D4237BB;
	Wed, 26 Feb 2025 17:51:42 +0100 (CET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 26 Feb 2025 17:51:42 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper
 SFP+ module
Organization: TDT AG
In-Reply-To: <20250226172754.1c3b054b@kmaincent-XPS-13-7390>
References: <20250226141002.1214000-1-ms@dev.tdt.de>
 <Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
 <d03103b9cab4a1d2d779b3044f340c6d@dev.tdt.de>
 <20250226162649.641bba5d@kmaincent-XPS-13-7390>
 <b300404d2adf0df0199230d58ae83312@dev.tdt.de>
 <20250226172754.1c3b054b@kmaincent-XPS-13-7390>
Message-ID: <daec1a6fe2a16988b0b0e59942a94ca9@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1740588704-2BC6995C-803E5AC5/0/0
X-purgate-type: clean

On 2025-02-26 17:27, Kory Maincent wrote:
> On Wed, 26 Feb 2025 16:55:38 +0100
> Martin Schiller <ms@dev.tdt.de> wrote:
>=20
>> On 2025-02-26 16:26, Kory Maincent wrote:
>> > On Wed, 26 Feb 2025 15:50:46 +0100
>> > Martin Schiller <ms@dev.tdt.de> wrote:
>> >
>> >> On 2025-02-26 15:38, Russell King (Oracle) wrote:
>>  [...]
>>  [...]
>>  [...]
>> >>
>> >> OK, I'll rename it to sfp_fixup_rollball_wait.
>> >
>> > I would prefer sfp_fixup_fs_rollball_wait to keep the name of the
>> > manufacturer.
>> > It can't be a generic fixup as other FSP could have other waiting ti=
me
>> > values
>> > like the Turris RTSFP-10G which needs 25s.
>>=20
>> I think you're getting two things mixed up.
>> The phy still has 25 seconds to wake up. With sfp_fixup_rollball_wait
>> there simply is an additional 4s wait at the beginning before we start
>> searching for a phy.
>=20
> Indeed you are right, I was looking in older Linux sources, sorry.
> Still, the additional 4s wait seems relevant only for FS SFP, so it=20
> should
> be included in the function naming to avoid confusion.
>=20

You may be right for the moment. But perhaps there will soon be SFP
modules from other manufacturers that also need this quirk.

There is also the function sfp_fixup_rollball_cc, which is currently
only used for modules with vendor string =E2=80=9COEM=E2=80=9D. However, =
the function is
not called sfp_fixup_oem_rollball_cc.

Regards,
Martin

