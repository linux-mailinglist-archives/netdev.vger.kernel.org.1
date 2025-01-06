Return-Path: <netdev+bounces-155465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F4A02661
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A636B18813B5
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A82433A4;
	Mon,  6 Jan 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Gy6/OD8X"
X-Original-To: netdev@vger.kernel.org
Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97907405A
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169655; cv=pass; b=J9/mXOYbnkANGUmQsj4usVPYD8FNkwZPrGHSzyQlL8XVi0HiOlbze7U7TK9KzNuxDEHX1XVf/mIfVQ5qhm22jENXGLz19IL4cWl2hGIvkxgro0lZXOSGbXuImz2KRjKM2nbwtI7YL21lLJlBcPKsfe9GFjdEb8iBJL0yhKy92r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169655; c=relaxed/simple;
	bh=eFQcmC88QqiPwZxCaxueDnNiwlCTuOVm/N9iox22LBs=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=DVyfkRzriI/uVipzt11x1QxBKY1eHvnMScOOAKCBVjvCGp9347s9yUM2rIdvwXdU6fOIcPJP/LGcTFRFRMk+d3hF7u7yCw8L4sejW+SP2IulQEog+4fBVs+U/Lj+0T6OBScIEwlsDPDw/hIYF0fKVWZunZpB7LjUECvEC2FfTno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Gy6/OD8X; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 285CC164090;
	Mon,  6 Jan 2025 13:03:57 +0000 (UTC)
Received: from fr-int-smtpout5.hostinger.io (trex-2.trex.outbound.svc.cluster.local [100.109.211.86])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 82E7B161A97;
	Mon,  6 Jan 2025 13:03:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736168636; a=rsa-sha256;
	cv=none;
	b=Al67xvuDjV1w/VW3zt49Bw8pMKjVRFC9zvbe5M3LL8IcMugZb/mRT9UrvQkN+4qsIhANVC
	HQno4A4IBmXAl7ePOroKFRh0ewSfzhHu8eHsxOWKGJiISLorO3hcsVK8RCqo4qr4IQh6re
	Lkbvvi/snaLfIOP/OkgDmh3mzzK339a3W0HqVvhHlsKBVsYPsOYq3eLT6wlW0rytxO/G7T
	n0WgmBVQu9V/kB23j3XIVrjwJ8qtv82UTX0xdyVZwP2BstyUiOtDPzOg4v30n47YohacXT
	GHOcrG0dirkX9dxWiT1OPQ/or1L3dsNDX1FLPII3OSDc/Z/e0QdkidWfKAFhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736168636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XgunnjfEprEyEUPgYP1+kUccBZ3YjE+8YV+rdA6Sxx0=;
	b=aC3f3jKXL1Oht009qcD2a1nBPzXphJQ3l5ly29T8y3HEm6wExdyuSi3mH8mP76HXUlSbRy
	XT2bwjrZgMH4Nj3Rp0yDuYS+Wzyemm5po2YK6s2YZLfPP/YETLWefLC9r17AhPOJuDCc+W
	BvH8Vz7f54v6cZlfYYBD/w+HZiw7N11Yb/U5cMM3JC8+1HanOkNcJ0eWLnbGpiVeVN+sIT
	LwNDRHMW0KMsEe7zv39z0iYExbtDUiECO+scWyCXjilwTctbVEF95w1uJl5TYwh9lSTjKV
	v/1X+TU/JcP0DdS9/RfaaocS4v81IA8+z5EorSh304WEoAD8DAgyJyjRrLqgYQ==
ARC-Authentication-Results: i=1;
	rspamd-7c48484bf8-8b54m;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Attack-Battle: 131763bb7a50d5b3_1736168637037_1303998989
X-MC-Loop-Signature: 1736168637037:2752394756
X-MC-Ingress-Time: 1736168637037
Received: from fr-int-smtpout5.hostinger.io (fr-int-smtpout5.hostinger.io
 [89.116.146.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.211.86 (trex/7.0.2);
	Mon, 06 Jan 2025 13:03:57 +0000
Message-ID: <c133c8bf-d28f-437d-b5e1-f575959651ca@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1736168628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgunnjfEprEyEUPgYP1+kUccBZ3YjE+8YV+rdA6Sxx0=;
	b=Gy6/OD8XFvQii3YnmjbQH0VqO/Ykd9k0Jr94c64ckZhQHECZbIZfZmhGGSaN/nZne0WDrZ
	mxg0yqJmNZ/V2qNPiwUNUhm2rLzU0prfuHhLxkX6vR/1WNcNO9pqIUZX5cW0ikyprEmgAH
	xmOwjjnTU2NaCF0UaKsOO4Sz/+8Gh5Lf2wzyvaHlt61LuDq/ff5K4pqPMMcbfqwQhNTxf6
	ccVI5lhHvDe6+EVPlvBPkk1w9YMToWY9IjDi+g+7dN/PS0DLvncEZw0zcBdKGoNTmOAzTt
	d0/P5nmJ7e/izqgK6wYqv8ccn50qLSevi4WGafyjsDft8It44NmFecXmPZckQw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] net: dsa: mt753x: remove ksz_get_mac_eee()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Golle <daniel@makrotopia.org>, "David S. Miller"
 <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger
 <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
 Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>
References: <Z3vDwwsHSxH5D6Pm@shell.armlinux.org.uk>
 <E1tUllF-007Uz3-95@rmk-PC.armlinux.org.uk>
Content-Language: en-GB
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <E1tUllF-007Uz3-95@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Jan 2025 13:03:46 +0000 (UTC)
X-CM-Envelope: MS4xfOuJ73vLBHrLuVej0n1cCU7agxp9CmaswBEWG72vvoZew8+FZg1ujxav9c70yO4zR8J5S5YZ6mZ6oit6/TuWDr/6vXBvW+Aa+SzBM6zsGuKZMNikKVxN oTNqxP4x+swr3Jz9CrOGI4OkzwLE3Wl3aPfeJrP0QT99pED3UqZNdyyF/hun5m4ur3YT9yqhvL9g4045xcIamX7MKUJup6eU5jQIJWPHOl7OQjyRvC0rjTqr Xo8e1P3dYXUp/Ah0WFOtBun5TUpKpYtp54srXEpcg964gw9WWMd4oBUVN8XFAyTq2Ek/xOYPigeEcpSbWZUBbjExA9GdnxDwi9B7cYT1CtmGEuc+N79UKnoC FZ7lCfxZrOBUYMqC4JQ+Yk8LZq/gcNlxo8PvqMu6GT9mbJZay4gYF3fUuUtFRnzNu1nQYjEcXTpou6JXHNZvXJ6xgDdk7i9Asu3ImNb6n+1Hb/x4n8ruhJ3+ Y4cR1cpnjDn19Shvkll4oCPty1bzmcG3MXZ/KWI6PculF45+8bd24OIVZkQD2+Q0CBcIqKIX4fTwhNhZ+BmdqCjso3SZWkr2VqlglCJAh+h8YHn1tuAfk1U6 MA9whuMuxdIHw5HyQqgA4ZbZ7Y75p7cmFL1WNWct2Oty5u4ZBjnfUmjSwP9fjbMz/u8RpaNw/X9hHdVhbT8kHcF2Wu4Looyj4Ys7Ffevfm1dv8I5SC5njfmP cn3rvIQA6GbzTO5WcguhvKwfU+Ji7LFaKOsj8gcOKAkDPOhbf6VvBIIM45N2uZssE0Kw2M2JdLfia/6fA0pgitaW9tza24aa6dwizNFeQm20te/hOfsYG/Ao Q2jSwHa9j3fGaTv2SOAgDhYmW+8qnN7uP9ubKbWx
X-CM-Analysis: v=2.4 cv=H9KJwPYi c=1 sm=1 tr=0 ts=677bd4b4 a=xjZdIgyYDteOtQQgkZ0oAw==:117 a=xjZdIgyYDteOtQQgkZ0oAw==:17 a=IkcTkHD0fZMA:10 a=PHq6YzTAAAAA:8 a=GvHEsTVZAAAA:8 a=A3CJIOadstd3g-hVWj8A:9 a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22 a=aajZ2D0djhd3YR65f-bR:22
X-AuthUser: chester.a.unal@arinc9.com

Hey Russell.

The patch subject mentions ksz_get_mac_eee() instead of
mt753x_get_mac_eee(). Keep that in mind if you happen to submit a new
version of this series; this is not enough as the sole reason to submit a
new version, in my opinion.

On 06/01/2025 11:59, Russell King (Oracle) wrote:
> mt753x_get_mac_eee() is no longer called by the core DSA code. Remove
> it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Chester A. Unal <chester.a.unal@arinc9.com>

Cheers.
Chester A.

