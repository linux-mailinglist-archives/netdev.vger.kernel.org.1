Return-Path: <netdev+bounces-119461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A026A955C19
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 12:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33D91C20890
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 10:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8517BA2;
	Sun, 18 Aug 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b="0fl6nMZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F9946C
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723976534; cv=none; b=J1cSBcMcMwl/E+ux3J8Z5plvmYKJ1nkvuvrsngmVfIbAz1I1cu8A6NPHTZwfSBtvwNvSHv5IBYmg8toDVZdx8/GwGIgSqnZsTqvlc9MZW77iTe7SzjEW7skSW+HD5266BCZQ3Bfh1/v/IjVHG1c7RRuh31wVHgv4Dy3gZ4aK9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723976534; c=relaxed/simple;
	bh=OXw2dzcv9Jab2HPmt7MuahPac7G8KJx92L1+coByzBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7fsT0ZeCGQwuAk5ipZnZeSjGccWwQ11yxzHyWrVhxEfhIDRST4weSLWyRmW+D3akC1t8Ov8bjiHs2+vNI0wlQv8UxRpwku+7YRbbiqGYelpdt0ZObu82ClXVYUxR+viQf4n2aplGepb4TDLo6HOg967zL0/RutIbBft8DOFhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk; spf=pass smtp.mailfrom=martin-whitaker.me.uk; dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b=0fl6nMZQ; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin-whitaker.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=martin-whitaker.me.uk; s=s1-ionos; t=1723976515; x=1724581315;
	i=foss@martin-whitaker.me.uk;
	bh=OXw2dzcv9Jab2HPmt7MuahPac7G8KJx92L1+coByzBc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=0fl6nMZQ/TYxLs0xqG6A1jLDM0SCrIqEFHXANqNPI60HUNDaL2pl8XbXajAJr9pg
	 iaT638ZBAo4Yt9c3FQDe8S3HYDTmQNjJces53ObrKhcnIVnWZZQMJG0pmUK95c5Vy
	 G5oudhpo+h0TQDEWAPx4ICyJ/s5wvAWpDb7ehebMMRuZLnRiDhHEIn+Oxtt3JZQjY
	 VgK4CtDOP9vfC2gzGFj3ISRKvZZzCke3NeguualET3fSg5F8Ru78osjJA+miMBDGS
	 l9CggwdXkD0U45rm6wsGTFa/a+tL1Y1U9jKbYXeaKiTNw99SiDRMo8+83vA40BaCr
	 7PehqAdFSkG+JFN4ow==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.16] ([194.120.133.17]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1Mzhzd-1rslcY1Hlp-010dV2; Sun, 18 Aug 2024 12:21:55 +0200
Message-ID: <45a00063-b3a4-470a-bfd3-d14bdec6a48f@martin-whitaker.me.uk>
Date: Sun, 18 Aug 2024 11:21:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: microchip: fix PTP config failure when
 using multiple ports
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 Woojung.Huh@microchip.com, ceggers@arri.de, arun.ramadoss@microchip.com
References: <20240817094141.3332-1-foss@martin-whitaker.me.uk>
 <ab474f83-aaba-4fe9-b6b7-17be2b075391@lunn.ch>
From: Martin Whitaker <foss@martin-whitaker.me.uk>
Content-Language: en-GB
In-Reply-To: <ab474f83-aaba-4fe9-b6b7-17be2b075391@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/jlcJcrRGMnONI5ocqYBjDmzr6l5tlswxdBx+/bQh8DEiPNtuPW
 vIRcqlOojCTtUA8bdpTxstYu7QxQXdv+krq1I/gsdMA61CDeMq4NxV6v25m3wm0nOTYEnHk
 P6uBUm1zweAYpwjs1E1Qlj9Mv+vGZ+hBWlQLYtixYkba5+Dyde+Y0q8lTyA7dvnRrHJ7yde
 xaoFmqTjcF6cEnL1ht1ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KRM16u0cktA=;G7/LqygvZYE/VIr/7Y1ZyNGK8Cs
 TUQrBM/NTJwyo5ra5Q/CiUMyIY0AXWV73P6PJLZ5FLbZBhEEspFe07P1v9gFPO1jNTl51q8GF
 cLdL3BMvtQ449m+VQbjP3SyUpgSl4+xcGmRrpZPxukqRXfHRfCAxhf0dVBtLnK+FOcOp3qbbh
 OCzoz9dxbGbQl4KYFJRNBM417+sDXySzpb6tH7035LAAoyGTSTa8kN4eg2h5yHabibjVxGDVv
 SM4avlfzxBzNBQwCpBgqVQIpMSbrnOAgq/XeoK1zHjbcL7v2CeDAlGEzxvDp68SfokbViTSQx
 raFLCUmOpDQgNPHH4/jtq1NQC6cxd+eWIO+gdvkqNhiPkniZ7KZylk/pUTW/kFvJOs/+ESuII
 JciuaMSxpckrha2f/btiAQ7y7CvD7yPlE4joZ+5jZorqfVqGdMtsDROIJldmimSt/RQT5empF
 17INJ3x41C3oeNHd8DmYbP2xgKh3/SLSuC88zShZyPjQfJmvefRlFM0Je7+SXj6awQBMCcgw8
 x1UTcl91sboCKZ+6vp9e74qgUAp7g/WvA2O3TV8p0J4IvGGcUfhI0PtB20rkMj0tAK98TFycH
 pRdwDm0t52eDYDRUkGH20Vh2/9kg61GFG8SPn2LP+nHDi/3bKqdB9inuHDiJQfU4IqIUQjz7/
 U5dELj0qC6DLfi+kkLPIoWiFDvaCDo4Eb68k4QcG3lTWebKDoSTBxG2zJWEFwu4EQ124ioxZc
 Qz/iPbeswdbSumekTQ+FYzS0MA8ZZ5C4w==

On 17/08/2024 19:57, Andrew Lunn wrote:
> On Sat, Aug 17, 2024 at 10:41:41AM +0100, Martin Whitaker wrote:
>> When performing the port_hwtstamp_set operation, ptp_schedule_worker()
>> will be called if hardware timestamoing is enabled on any of the ports.
>> When using multiple ports for PTP, port_hwtstamp_set is executed for
>> each port. When called for the first time ptp_schedule_worker() returns
>> 0. On subsequent calls it returns 1, indicating the worker is already
>> scheduled. Currently the ksz driver treats 1 as an error and fails to
>> complete the port_hwtstamp_set operation, thus leaving the timestamping
>> configuration for those ports unchanged.
>>
>> This patch fixes this by ignoring the ptp_schedule_worker() return
>> value.
>>
>> Link: https://lore.kernel.org/netdev/7aae307a-35ca-4209-a850-7b2749d40f=
90@martin-whitaker.me.uk/
>> Fixes: bb01ad30570b0 ("net: dsa: microchip: ptp: manipulating absolute =
time using ptp hw clock")
>> Signed-off-by: Martin Whitaker <foss@martin-whitaker.me.uk>
>> Cc: stable@stable@vger.kernel.org
>
> One stable@ is sufficient. Did i mess that up when i asked you to add
> it?

Yes. Annoyingly I noticed it when I first read your reply, but forgot
when I later copy/pasted it into the commit message.

> Apart from that:
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> It is better to put your Signed-off-by last, because each Maintainer
> handling the patch appends there own. So it keeps them together. But
> there is no need to repost.

Thanks.


