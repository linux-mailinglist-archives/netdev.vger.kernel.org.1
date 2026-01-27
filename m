Return-Path: <netdev+bounces-253929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HjvLk/geGkGtwEAu9opvQ
	(envelope-from <netdev+bounces-253929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:57:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F5973B1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6DC130BBED7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018BC35E554;
	Tue, 27 Jan 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fpV21aWq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6935CBD2
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528901; cv=none; b=Xg9HhWhr7qYdR/FoXb5vin2yxr4hhY6nEUrN/iRafJweimTqQZ8kQ8TMVgliJI/R5j0xMw04vGS5sTeXgi+MP9qWN+rXWHuGw/fT2t5w6DIaEdAYnlTR6EmBaMQOI4AR0mPlrKqcbVfMr8XAJptB2kXyb7wn3rJAItTj1lk+330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528901; c=relaxed/simple;
	bh=MyJH6B/DAC2Hks4I0KKh108Lu3whfs1qSGJMxXLIyA0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=K4CuAO6+drhZcOfUyZaDa1xn7jJw1tgz/x2CIYwxFMkRcAjCqiXeFjKVqeUoX7Ld8Bfc7EYCDG9qFVmzsJy1RP+FxU1K14+9G+8ukSsby1bEaNgBVAVKDcfEmTGoB4HAtNb4a2hWv884z+d/JX+gCz2NGN1Mpg4svsbCk37nmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fpV21aWq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 772884E422D3;
	Tue, 27 Jan 2026 15:48:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4ADC8606F5;
	Tue, 27 Jan 2026 15:48:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AB21119A8637;
	Tue, 27 Jan 2026 16:48:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769528896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OxkgHIERK1QMMyBS9ryD4i6d6w+RIzeILS9CMd6za+4=;
	b=fpV21aWqssDyfTLubMz3GX7FBO/K944DIV7FsDzkeJY1zGQoT4g+hFHhUQktqnCgHWT8JK
	ef2tYOjMpJNp0jZxNhVUKkKiLv2zBKwzsaKt4qNudaYDxRlQzX3IjggSJTybDZ03YBxSrl
	UgwP8HK5I51PFp2oBmEwUE+KgmX2iWgtEv1dQzHuKfrM/xR+30opbvPBwLVLeSWPIV7YO8
	NqYZ1SFnffF1HjucvPOJIaSUJ3BLVKjhfVaBuov/92yB3qjZv8DiWpdBp+rl2nJjnynCxY
	F/27PHKDrXi9N+9TDFdqkbGejV3JyzYSfOMdMGTUatLdwv8mCpO2bmqZ+5MJHg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 16:48:11 +0100
Message-Id: <DFZHN2KXS7UI.C1WHCBAAII2K@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
Cc: <netdev@vger.kernel.org>, "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Lorenzo Bianconi" <lorenzo@kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch> <87cy315lru.fsf@redhat.com>
 <840fd286-779e-4130-b544-913116c97a29@lunn.ch> <87qzrdecs1.fsf@redhat.com>
 <b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch>
 <DFYQS9RIPCSY.25SHGGC3VM2M3@bootlin.com> <87ldhkexvq.fsf@redhat.com>
In-Reply-To: <87ldhkexvq.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:url,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,archlinux.org:url]
X-Rspamd-Queue-Id: 565F5973B1
X-Rspamd-Action: no action

On Tue Jan 27, 2026 at 12:51 AM CET, Paolo Valerio wrote:
> On 26 Jan 2026 at 07:45:29 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>> On Mon Jan 26, 2026 at 3:29 PM CET, Andrew Lunn wrote:
>>>> > I was more interested in plain networking, not XDP. Does it perform
>>>> > better with page pool? You at least need to show it is not worse, yo=
u
>>>> > need to avoid performance regressions.
>>>>=20
>>>> I retested with iperf3. The target has a single rx queue with iperf3
>>>> running with no cpu affinity set.
>>>>=20
>>>> |              |  64 | 128 |
>>>> | baseline     | 273 | 545 |
>>>> | pp (page)    | 273 | 544 |
>>>> | pp (2 frags) | 272 | 544 |
>>>
>>> So no real difference. That is unusual, it is typically faster, or if
>>> it is always doing line rate, it uses less CPU time. That might
>>> suggest the page pool integration is not optimal?
>>
>> One more data point. I get line rate with & without page_pool so below
>> are CPU times from /proc/stat:
>>
>>          upstream    pp
>> user            1     1
>> system        179    91 (!!!)
>> idle         7874  7303
>> softirq        35    37
>>
>> 16K pages on Mobileye EyeQ5 (MIPS), 7 fragments per page.
>>
>> Paolo shared 64 versus 128 measurements but I am unsure what those stand
>> for; I doubt it can be packet size as xdp-bench does not have it as a
>> parameter. https://man.archlinux.org/man/extra/xdp-tools/xdp-bench.8.en
>
> 64 and 128 are packet size in bytes.
> For the first test I used xdp-trafficgen on the sender side and
> xdp-bench (skb-mode) to count the drops in pps on my board.
>
> For the stack test I used iperf3 (UDP) similarly with 64 and 128 for the
> length option.

|           |    64 | 128 |
| baseline  |  75.3 | 145 |
| page_pool |  79.3 | 154 |

Call is: iperf3 -c $IP -u -A2 -b1G -l64   # or -l128

CPU affinity is important. I get approx -30% on CPU0 (where IRQs land)
and -12% on CPU1 (2nd thread of CPU0).

I looked at ftrace function_graph and it looks sensible. Baseline spends
16% of macb_rx_poll() in gem_rx_refill(). This goes down to 10% with
page_pool.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


