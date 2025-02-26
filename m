Return-Path: <netdev+bounces-169904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 659EDA4665A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E99B440AE1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8421C9EE;
	Wed, 26 Feb 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="gbx1pb3i"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD82EAE4;
	Wed, 26 Feb 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585351; cv=none; b=TrozGv847eU0INdvFP2ZvXbtkdcCnSAo//6Ix3gAwMOXy+TvSRGDoKhCYhs9ogLm0HVouhivul6jKusAdk6BrsWSxb7GRnfOnoNbM3KfL5o2JqcNJXeIwJ//lB6x6gJ2tY/EHVXsOX6yhHVbqpKq8R7NoVxQO7Tn0PBuSE4BWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585351; c=relaxed/simple;
	bh=MK6GzxJ5jGo62okKzHOa4sSEHxenNlh2+oDHDZBnef8=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=kpVB5epjsM5Mcp1Fs7BITABMJ55gg4mopYf9/wsPjuU2kBDEXGye2ETtRaIPRGUdq0JVbYDQBeqK5KGtoSitgWKShE2ZQd4kQp5aTquj2uLBgYxoIUlDBeJjUuS2svtHLdsazJf57R0eJiYnbLHHXUl0/Qe6LMFTVGOOVpJYWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=gbx1pb3i; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=916645903c=ms@dev.tdt.de>)
	id 1tnJl7-0093Ff-9u; Wed, 26 Feb 2025 16:55:41 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1tnJl6-0020Lj-0x; Wed, 26 Feb 2025 16:55:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1740585339;
	bh=6DTIZvB9ZKyPyxrGTYhLUZM1TdcZeH4MbCBRnoy1ij8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gbx1pb3iDQdqphjLSXKbnhN+y8ddMaU59rE/pEWQWjNK4/uq8i/19SsXFnezLLoEW
	 wFpHmcH7xJcQQ4AGiV+JuSDq+/1Yh9THthgSC0WX/vziHP2DQ+3ljGn7c3GcPaJSmD
	 2wjNzBnrVAet75BpmoVz8M50Uy5c9+pbG01nV3MwcPaFgdk614ZqCXKBU98P5WZmS0
	 as+ka+VfaKFZce93ntxzezA/o7y3kK1cR9JmPsXV74NFXXFbnJiDPxcpCQv/QQMLVi
	 4DZroS89IshHJ5tb0Dv6+H7shDq+8l45woFqxI+EIk7224MKUzz25SwfiW5xS6csHQ
	 QIqiW9L47Af3Q==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 6DD04240041;
	Wed, 26 Feb 2025 16:55:39 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 669A2240036;
	Wed, 26 Feb 2025 16:55:39 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id C8D1822442;
	Wed, 26 Feb 2025 16:55:38 +0100 (CET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Feb 2025 16:55:38 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper
 SFP+ module
Organization: TDT AG
In-Reply-To: <20250226162649.641bba5d@kmaincent-XPS-13-7390>
References: <20250226141002.1214000-1-ms@dev.tdt.de>
 <Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
 <d03103b9cab4a1d2d779b3044f340c6d@dev.tdt.de>
 <20250226162649.641bba5d@kmaincent-XPS-13-7390>
Message-ID: <b300404d2adf0df0199230d58ae83312@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1740585340-0351C41A-8D61EB6E/0/0

On 2025-02-26 16:26, Kory Maincent wrote:
> On Wed, 26 Feb 2025 15:50:46 +0100
> Martin Schiller <ms@dev.tdt.de> wrote:
> 
>> On 2025-02-26 15:38, Russell King (Oracle) wrote:
>> > On Wed, Feb 26, 2025 at 03:10:02PM +0100, Martin Schiller wrote:
>> >> Add quirk for a copper SFP that identifies itself as "FS"
>> >> "SFP-10GM-T".
>> >> It uses RollBall protocol to talk to the PHY and needs 4 sec wait
>> >> before
>> >> probing the PHY.
>> >>
>> >> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> >> ---
>> >>  drivers/net/phy/sfp.c | 5 +++--
>> >>  1 file changed, 3 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
>> >> index 9369f5297769..15284be4c38c 100644
>> >> --- a/drivers/net/phy/sfp.c
>> >> +++ b/drivers/net/phy/sfp.c
>> >> @@ -479,9 +479,10 @@ static const struct sfp_quirk sfp_quirks[] = {
>> >>  	// PHY.
>> >>  	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
>> >>
>> >> -	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the
>> >> PHY and
>> >> -	// needs 4 sec wait before probing the PHY.
>> >> +	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to
>> >> talk
>> >> +	// to the PHY and needs 4 sec wait before probing the PHY.
>> >>  	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
>> >> +	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_fs_2_5gt),
>> >
>> > Which makes sfp_fixup_fs_2_5gt mis-named. Please rename.
>> 
>> OK, I'll rename it to sfp_fixup_rollball_wait.
> 
> I would prefer sfp_fixup_fs_rollball_wait to keep the name of the 
> manufacturer.
> It can't be a generic fixup as other FSP could have other waiting time 
> values
> like the Turris RTSFP-10G which needs 25s.

I think you're getting two things mixed up.
The phy still has 25 seconds to wake up. With sfp_fixup_rollball_wait
there simply is an additional 4s wait at the beginning before we start
searching for a phy.

