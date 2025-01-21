Return-Path: <netdev+bounces-160129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8CA18632
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 21:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B562162D3E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFB1F8673;
	Tue, 21 Jan 2025 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gTUZ/HOh"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E581F76D9;
	Tue, 21 Jan 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737492103; cv=none; b=gJU9En/cS8iLJs/q1yo28bOsf2rVk3M84Yd+TRtyk50CHWK+hE49VPXHspgrb0FvAmW6kbAE6KBGA3TLES/RV3YKLKresmV+K7885XS/OSBZVawsxzXU+pie83aPnEAqUsVOtwF/WE7NPPjFYB59aZRxAt2mQwQ4vFcSOJf4hi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737492103; c=relaxed/simple;
	bh=q7DoTJ4FdOJKu23a0OLBxyG5TVcFn0n3Tf/Lv8fjHuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YHzJtLeVJzd7wuP5dFJoeZlKD1YOMSXYN0MGQpM5vIqFquMK08/8aFDW7IcoIKNekSFFO2GNA8TTGI+OGf49+/FU3a9sVBFT+pg2jvQ7sOM2yvT5gLW3vQTwzzeVYjpA8OPoiPQIXIzrPoIFkl+bM6IPFoJCTNeBFSzsSDCznqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gTUZ/HOh; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C3C3AA0578;
	Tue, 21 Jan 2025 21:41:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=5JnVWWuVq2AzhwTPwMTG
	2xnTfDhIJpjBHH8/rH3BId4=; b=gTUZ/HOhepOsNotNlBHyfkYSoF6rOUNdzyQN
	rS9Z573MCnnttPfb9lq7nqSyoVXJ0jAidTm3iSgYM00mNm8ccrFQFOTTIjC2WDe1
	mO8xZbCwhpcu3zMvRJC7J0GhW+YUYvso0cbvUu7Ls6a5gPUwCMxo7pWnzNcTi86e
	IkJflxURscD/wY+27fXfk5mZy3Z7/hpbaS1reH3vA8mq8ZoJQPZzWEcmnUXP7FmK
	AifOSL6ZofhkMlsXrSEeHzRW0ayqQGKqdHcQcOPcz1Cp0KaIVB2sxY4meUt+wC2s
	PotZBWKppFSt7S5OvVmbm9ThkisZi07TnL2Bdys5SDYpB8MxKm9wQAT0aUFZvk33
	fT9uQVPQZGbT37z4BKgk3bzLX+0s2QsHAWI6bMMfcTRoI2sVfByXe4UC9nw5erqB
	xmznIjjlrTguaexyZ8n8V4GVrwNQXFbCgzTnqQsIyrpAijPVdhAWLpN0h7Gf+ZOz
	kzEhU7r9SZBQCQXbm2IfFR30rWZXoUeRJwyx+o73Cjy4zw/51DFmUFPEOVNtDZwA
	lAMPWc7qau+ESvcRzHabBovq42G2Yoc1WzYcGgV2Iwj9lqHuLVHe7cHJ4P6SpOVB
	roOQuqRYu8/cDcTwHULB/rVmPiPde7623aWKjxkgdPN5Ht0l1p9uAd7+NlJQpAHK
	2zuwD9c=
Message-ID: <8395976e-c867-4788-82e6-6d606599bf6c@prolan.hu>
Date: Tue, 21 Jan 2025 21:41:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] net: fec: Refactor MAC reset to function
To: "Badel, Laurent" <LaurentBadel@eaton.com>, Jakub Kicinski
	<kuba@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
 <DM4PR17MB5969CC2A8D074890B695AF2ADFE62@DM4PR17MB5969.namprd17.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <DM4PR17MB5969CC2A8D074890B695AF2ADFE62@DM4PR17MB5969.namprd17.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852677763

Hi Laurent,

On 2025. 01. 21. 17:09, Badel, Laurent wrote:
> Hi Bence and thanks for the patch.

thanks for your input.

> Leaving out the check for FEC_QUIRK_NO_HARD_RESET in fec_stop() was, in fact,
> not unintentional. Although a hard reset in fec_restart() caused link issues
> with the iMX28, I had no particular reason to believe that it would also cause
> issues in fec_stop(), since at this point you're turning off the interface, and
> I did not observe any particular problems either, so I did not think the same
> modification was warranted there.

I had a feeling it was intentional, however, `fec_stop()` is called all 
over the place - not just when removing the interface (e.g. unloading 
the driver), but also by the PM subsystem for entering suspend, 
restarting auto-negotiation, for handling Pause frames and changing 
HW-accelerated RX checksum checking...

> If you have reason to believe that this is a bug, then it should be fixed, but
> currently I don't see why this is the case here. I think a refactoring
> duplicated code is a good idea, but since it also includes a modification of
> the behavior (specifically, there is a possible path where
> FEC_QUIRK_NO_HARD_RESET is set and the link is up, where fec_stop() will issue
> a soft reset instead of a hard reset), I would prefer to know that this change
> is indeed necessary.
> 
> If others disagree and there's a consensus that this change is ok, I'm happy
> for the patch to get through, but I tend to err on the side of caution in such
> cases.

To me, the name `FEC_QUIRK_NO_HARD_RESET`, and its doc-comment seems to 
suggest that we do *not* want to hard-reset this MAC *ever*; not in the 
codepath of `fec_restart()` and not in `fec_stop()`. Did you observe 
problems on i.MX28 if you soft-reset it in stop()? I _might_ be able to 
get my hands on an i.MX287 and test, but I have no idea if it is 
working; I took it out from the junk bin.

Right now, we're chasing a different bug on the i.MX6, and this was just 
meant to reduce the amount of clutter we have to cut through.

> An additional comment - this is just my personal opinion - but in
> fec_ctrl_reset(), it seems to me that the function of the wol argument really
> is to distinguish if we're using the fec_restart() or the fec_stop()
> implementation, so I think the naming may be a bit misleading in this case.

True, but I would prefer to keep it separate, i.e. the `wol` parameter 
should really only control whether we want to enable WoL. If we decide 
to keep the old behavior of not honoring FEC_QUIRK_NO_HARD_RESET in 
stop(), I'd rather add a new parameter `allow_soft_reset`. That way, if 
ever someone needs to call `fec_ctrl_reset()`, they will be able to give 
it values they make sense at that point-of-call, instead of having to 
"fake" either restart() or stop().

Bence


