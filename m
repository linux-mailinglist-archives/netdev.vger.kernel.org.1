Return-Path: <netdev+bounces-297324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +te+CNKPKGo0GQMAu9opvQ
	(envelope-from <netdev+bounces-297324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:12:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4FE66479A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:12:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=JSqBpBgO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297324-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297324-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE257300D969
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75591408018;
	Tue,  9 Jun 2026 22:07:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C53EB0F6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:07:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042861; cv=none; b=lff2a8mEdVTyWOAUgtF7sBQilzGxaWRgVtPrT1Lowsu15aBViBIyPD1nhT4cDrL9nID/gqk28T1mkP5bBsY9WH3pMdWK+T0MiNfuM3Yd/E82d0VWb6nmVd6rwDQNPqzWrM8FX3ZzrCV37skbluTkKFhu6sXrZXDNViFi/wkto2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042861; c=relaxed/simple;
	bh=pfst8Pl1eMIbnL+CLz2qwcP1CNCJ01jwiT7Pi+Po1Q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sIVe87oQzvnQQgnfamJRvNKOHocinzBZyl1uBUdtvE74yqTf5rjDZmyJ+cCbza32fLBMJ+RjXA00XovYOAtOEHdqsXeBI0vpM4nDSrQGFwwyYtVpEYK88jc5MokFuMBv+kDXzEuqg11wBfW+5kcbgVCQ6xb7LuL6RAusSEt9434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JSqBpBgO; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso3984082a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781042859; x=1781647659; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OuxYNglbzg4w1eq48zhKqAxq6WHek0Yx27zZwn93ut8=;
        b=JSqBpBgOpUPU4YnujU7ZlBFkeoQAFz5S2qGBkqf9kyY99omh+7WQ81++jex9DzmoFf
         156HOgHlK3g42NnoqAxLcIQ675bAOoOGfk4AgBZCqaw/CmvopbvHnUI8wYSOIHd3fNEF
         91IP7masUWzLKhb/qslGjsgxpDW1WQg/D3TGvayx5APOHAfJ4bP21kie+4H/u3cb8kPD
         J2C+kpHCKqoMbd+O/uPf7S+DJ7r3Y0FUBNoGxrjYIX05JscBcvTR0Iwlo18igSn1hAM0
         PAWgp50XcBY/z+hCAGkHoQ9YoON24rr8BiakSIVp9Zkaz2OYKP6eKoPdZd9xz7DxeQvc
         rCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781042859; x=1781647659;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuxYNglbzg4w1eq48zhKqAxq6WHek0Yx27zZwn93ut8=;
        b=Tmo5hTCiiK/X7KRg0Dy+bxprmKJjw09zHJjq9InruVEHZerbldT5K5vGj2VBPAdO8O
         +IrfV8moUTYVoEGTuz0WLD12k6VBy7YGwHtKgxD1TsDXxpKLapVjvtsnjo1t7S30GZWS
         fQ41l3ZXw/mRlGjBVHJGSuN+ECPt0DphTrZybErHjaA1AGKLhKZnMVO5aVtNMYqqvubD
         DtwYOg7eBUNxXoboecK+Zks8hX0GGFHEkuF/IF/amFQRQWcPATe8psHEQapbtQORVXdq
         oYpiBM8anFDxNLmuIMuBM2blXkdfHrdJQi8Ba6VN5dxbW4z28IRp0bA30y4sd00p6phu
         Pzrg==
X-Forwarded-Encrypted: i=1; AFNElJ8Q72JDtmdWT4s1Y8boSa2Iftv4dz4zxebjM3gUk5GTpL70IyIzcvJExcCmHF24vMr3br39lbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMegsiCCtY4nzkatpPYKU8zEsrN6t5mU1qnx5bw8TLuH/BCS8x
	+ETWOMTKsEVzI1eB0ZMZRAZFH7OW9bN5zx2f5ZGwoqPY6vNfEoOXLGaf4Og4sPY62fs=
X-Gm-Gg: Acq92OGosltnqNnJyRNe6f3CBUUhBQfAFhOK7jYRPNerd+xB/DxyM1AvQbR8Iac2ldD
	l2HTVnGt8+FPrjCfT49ZYw3hIIpzXIXpANDxMWA9pLWzGK3S7/ybRMmgZM1YBdtcvWIKeRas6QV
	Z7KxvVXQlKTQnb8FJZ4qJ5Rvh1ip17KL4vCdmAWavk3r3pJ5wtA9cao/JB+9WylVmRXEuqorYyd
	K17/RG7BC0Zfz1AfKJg5GmG1z2e+I0W7tk0NJ/m4jSUxRP+Kr+QyWkNtSJ6yrw/0sbbLad3TDsW
	DuY05bU5F9tBg/hEy25dnaOA8RvLsdpZdfX4qE77tme6+mAp8ODiAyDhAnnmJV/P1ITePlWtI5p
	k9dczxu7/TsEmzVLyS5kuic9eX9tXnIJOwKlhZDCrx8J8Wqdd+doeve/qkT6R56VdqEK5VYlyWp
	u/X1v5kyO9Q0ctPFOioEnz3ssGqvcOFr4=
X-Received: by 2002:a05:6a00:84e:b0:842:708f:39a0 with SMTP id d2e1a72fcca58-842b0e1e4c6mr24016847b3a.8.1781042859082;
        Tue, 09 Jun 2026 15:07:39 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8428221cc48sm23176324b3a.8.2026.06.09.15.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:07:38 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Thomas Richard <thomas.richard@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Aaro
 Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH v2 2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet
 controller node
In-Reply-To: <f3280b6f-7cf1-410b-9711-6dfaae2596f2@bootlin.com>
References: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
 <20260506-b4-var-som-om44-lan7500-v2-2-b8af59ab877c@bootlin.com>
 <f3280b6f-7cf1-410b-9711-6dfaae2596f2@bootlin.com>
Date: Tue, 09 Jun 2026 15:07:37 -0700
Message-ID: <7hcxxzmkpi.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297324-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[khilman@baylibre.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thomas.richard@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:aaro.koskinen@iki.fi,m:andreas@kemnade.info,m:rogerq@kernel.org,m:tony@atomide.com,m:o.rempel@pengutronix.de,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-omap@vger.kernel.org,m:nb@tipi-net.de,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:dkim,baylibre.com:mid,baylibre.com:from_mime,bootlin.com:email,vger.kernel.org:from_smtp,tipi-net.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D4FE66479A

Thomas Richard <thomas.richard@bootlin.com> writes:

> Hello Kevin,
>
> On 5/6/26 2:13 PM, Thomas Richard wrote:
>> Add USB tree description, including the Gigabit Ethernet controller
>> (LAN7500). Adding the LAN7500 node will allow the bootloader to patch the
>> devicetree and set the MAC address.
>> 
>> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
> Could you merge this patch? Or maybe you have some comments to do.
> Jakub already picked the binding part.

Sorry, due to travel I missed this for v7.2, but I've queued it up now
for the next merge window.

Kevin

