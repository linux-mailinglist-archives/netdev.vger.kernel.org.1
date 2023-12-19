Return-Path: <netdev+bounces-58839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF28185A0
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07141C2332F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5E14F8A;
	Tue, 19 Dec 2023 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAKPWgQB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825681862F;
	Tue, 19 Dec 2023 10:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70BAC433C9;
	Tue, 19 Dec 2023 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702982954;
	bh=W+lwHMTd5G4ZYzSTPj9cBv7u7PhVP9PJOKmWaTIMUaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RAKPWgQB3Vg5d85avYOn8pqchKa+8qQNhg3kCoteIQxjHex4yoaxM2oVo4Lr0sw6e
	 B2n0+nPP77FKZkGHMDtdFhzh4qDRxyCYULgsc/fJ5NAfoF86B6q27wu5Snc3hAqQVO
	 0YskOfXS989NHgSvWg5j1tFeo/sN09yCfztHiLrfBjkC5Q8nUpC8cGlN+MWiK5MOWN
	 i3r8OjqdYj5D2uIyJsBxpLw/AI4L1aquJwHkVbnBqAavt3aIKQaHS4SzaSusRhWraZ
	 sW1kkHYMCej0GzASFrhQI/zFPLqo27s0InEbjbRBZVuNCZg2WpdYjQ43nWk02t8Hi3
	 GQ0aSgzLU7u2A==
Date: Tue, 19 Dec 2023 11:49:09 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <20231219114909.6b5c664c@dellmb>
In-Reply-To: <87sf3y7b1u.fsf@waldekranz.com>
References: <20231214201442.660447-1-tobias@waldekranz.com>
	<20231214201442.660447-2-tobias@waldekranz.com>
	<20231219102200.2d07ff2f@dellmb>
	<87sf3y7b1u.fsf@waldekranz.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Dec 2023 11:15:41 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> On tis, dec 19, 2023 at 10:22, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
> > On Thu, 14 Dec 2023 21:14:39 +0100
> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
> > =20
> >> +MODULE_FIRMWARE("mrvl/x3310fw.hdr"); =20
> >
> > And do you have permission to publish this firmware into linux-firmware=
? =20
>=20
> No, I do not.
>=20
> > Because when we tried this with Marvell, their lawyer guy said we can't
> > do that... =20
>=20
> I don't even have good enough access to ask the question, much less get
> rejected by Marvell :) I just used that path so that it would line up
> with linux-firmware if Marvell was to publish it in the future.

Yeah, it was pretty stupid in my opinion. The lawyer guy's reasoning
was that to download the firmware from Marvell's Customer Portal you
have to agree with Terms & Conditions, so it can't be distributed to
people who did not agree to Terms & Conditions. We told him that anyone
can get access to the firmware without agreeing anyway, since they can
just read the SPI NOR module connected to the PHY if we burn the
firmware in manufacture...

> Should MODULE_FIRMWARE be avoided for things that are not in
> linux-firmware?

I don't know.

