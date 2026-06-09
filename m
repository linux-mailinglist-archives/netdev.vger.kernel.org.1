Return-Path: <netdev+bounces-297097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U4jzAXQxKGqK/wIAu9opvQ
	(envelope-from <netdev+bounces-297097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:29:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32A661C0E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:29:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nMSgLzgJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297097-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297097-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97C8F3186F18
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBF8480967;
	Tue,  9 Jun 2026 15:03:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6747D934
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:03:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017416; cv=none; b=eJ8Hl0UhpdPgFaiCx87gp0tYlILc7hrGLucxTTAgGJnyIXXvDSIW37d81wfvWlkvvAVh/ZVNMzHJ3eW205WQEYD4mTBqunR+lW7urdQ0QLdfpPapfGV50I+uCyTM3ukdSHKTen61ImGj1gkD+149Ay2AbARVC3nvAdAohmFYlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017416; c=relaxed/simple;
	bh=+z2z6iU/y2HMbTEBl5xiZqMcHJhJTx154BuN+bMnsSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxJO1/nR4XN9RXLY9Q2OFH2+3D2ZbD2GDjnyLNBh64Lu5a+IWC6tBNSlU38O7wQIsxuxiJC+qhElCWKwCfa6pt4iPRPwE+XnfOXwZpdDOjiz9j9qufR9DxLpNlcGpjClQJFKSFNeGAASkZO/tFwO+nHRVgG9eUkh/Y87RRL3S5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMSgLzgJ; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef4223be7so3050688f8f.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781017413; x=1781622213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dF6R6rSyS51mkSPdhY89TGjX1b36QZSQc6NNcgJtTqg=;
        b=nMSgLzgJ+0LGhDQSq2vnp1fjNtlc3J3DJkMcVPGrBAl5d01XAO+DA59Nwhzeqtl73N
         yXFNRcF3df4DzagMQpoZYapweT7rwpd6ZHfy6SdQU/e1YXA0GangGt9TsDp8+iNrNlF1
         NrUdJ5TeARhgnShYmNIpzH/K0eJKAxyZ2myFmDbG1YN0yDtUf5txAg0dctwawYXbOTLN
         FbYHbX8go8Gy0IqxnGjl19L5/yKF7QCjQuPjtIBiQBuIRk7sdX0GyBmaMO24qDpkXaJl
         CvtwgQ0rwbw5BEP1LHyTjXD7dulMsCDq0wNLhjOk3YBky5Lnn9ld4hJ1X9eH7itOxLq/
         8PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017413; x=1781622213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dF6R6rSyS51mkSPdhY89TGjX1b36QZSQc6NNcgJtTqg=;
        b=nCRL95PO7YL5PUPE3SGDdofjzhdbedgySPJhaP9sSHUi45O160xTA8ou6FGmIiaoKV
         wWKPCJSfWBurrRKUgoqDFJowoqcuWF5URRBX8a8NA/R1CM7UaMLHc8tzVpzRvcXHvA0b
         FnTaN/g/LrvCs1AJGMejNvXfGMcdMzOXc+iC7GHAWNf/WQ81rCiFyk9WlAJL0aS1th8L
         7TtjoCa69aMaY4aEox40MtpyPX5UxUL4/zPzrIQtCO1OndSbwBK8twhgqN93qF2YjV9O
         x8eJzfHA+iJVP+5Hhk9k1xTlXgbeDDEea+Q4StfSWSliD/K10IBPmCeIGFtNqi7E/YW/
         yzxA==
X-Forwarded-Encrypted: i=1; AFNElJ9bKmP8HdAXSkdGopwy5hwkDOlkLGN0/t9SMvByUUD2T7iePUdoUIzfOKcxL759ttklz3lZBmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIT31Qzl3/3nIvCyMOJIqor6qFV9pu0HJYyw7wll36KZYr9Oke
	lb1/8lQuYj1zAJ6qq2V+c2mAWt2YJ7rrXWq8HiJsPjKpb/zKq6+4Bss1
X-Gm-Gg: Acq92OEMj3Hry1YxHa1sqk6uowemvfRjpZTPqaeZnh5Ure+WbO4E7WX6FIDHii5vJky
	vkVPhnrhsVvkYpyqdpEFCkPBElkMdXFKityiYsgnU32TJBSP1RYzHH0PzRrg5p7+0GwzdkbQ6v7
	0o4aIo86fW+3amTK2Jga2yURP62K0FX7i0qPre3oHFBbCwadFnUIf5NH5v4WdUqrnUUhZIZvgxI
	5iVdDV4c8kYMQ4Ik2rnV7TP7i/ohoD8UH+rVwO5+NiG5qF5yinHo5xDJ+cUvUUhKPWKb02ekhNB
	Z3QotO4fWFEVt8i/u0CqLqdQsyNoRLaeX7vNkIsuVOr4Lo1iMERaiB5rrvBGG68o9/09QWaMN47
	OsSKBwEzz0tLqzJxyRn4O6aDKu83yeOWGxFrx5RKlCDpCjYGKVy9DL6eYW0ou2nvFcUOuZKqBv9
	in2czZN7ljTEl+XcMv1wUoZZ58nNMuvkJjSvSR3C+dpYtNZNEM87V74EjiWd6UuCiPbSa8Vpmds
	FSOlDzIR+z8/r/UVMpe
X-Received: by 2002:a05:6000:4a09:b0:45e:779a:302c with SMTP id ffacd0b85a97d-460566c94ddmr3982199f8f.29.1781017412556;
        Tue, 09 Jun 2026 08:03:32 -0700 (PDT)
Received: from [10.1.0.164] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm68854439f8f.5.2026.06.09.08.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 08:03:32 -0700 (PDT)
Message-ID: <49c78c6e-5ccd-4789-ae53-359d4e5794c8@gmail.com>
Date: Tue, 9 Jun 2026 17:03:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] net: ethtool: add KSZ87xx low-loss cable
 PHY tunables
To: Jakub Kicinski <kuba@kernel.org>, Marek Vasut <marex@nabladev.com>
Cc: Paolo Abeni <pabeni@redhat.com>, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, maxime.chevallier@bootlin.com,
 horms@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Tristram.Ha@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nb@tipi-net.de, fidelio.lawson@exotec.com
References: <20260601-ksz87xx_errata_low_loss_connections-v9-2-fdbbb15592cb@exotec.com>
 <20260604114119.170747-1-pabeni@redhat.com>
 <20260604193545.0a906598@kernel.org>
 <4098dafb-838e-4854-add6-cb3ce6668a70@nabladev.com>
 <20260605163142.4bbcf502@kernel.org>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <20260605163142.4bbcf502@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297097-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:marex@nabladev.com,m:pabeni@redhat.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,bootlin.com,kernel.org,armlinux.org.uk,vger.kernel.org,tipi-net.de,exotec.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B32A661C0E

On 6/6/26 01:31, Jakub Kicinski wrote:
> On Fri, 5 Jun 2026 05:16:54 +0200 Marek Vasut wrote:
>> On 6/5/26 4:35 AM, Jakub Kicinski wrote:
>>> On Thu,  4 Jun 2026 13:41:19 +0200 Paolo Abeni wrote:
>>>> [Severity: High]
>>>> Is it intentional to enforce an 8-bit type constraint for bandwidth and DSP
>>>> equalizer tunables?
>>>>
>>>> This heavily couples the global API to the 8-bit register layout of the
>>>> KSZ87xx hardware without defining generic units like Hz for bandwidth.
>>>
>>> AFAIK this is the one comment from AI that survives scrutiny.
>>> Seems unlikely we'd need more bits, but then again - why not.
>>> u32 should be our default for integer values, u8 is more for
>>> booleans.
>>
>> Why waste memory space if we are already sure the space would not be used.
> 
> Waste what memory? We are talking about a syscall argument effectively.
> 
> My point is that this is adding the arguments as u8 in
> net/ethtool/ioctl.c, so as part of the global uAPI.
> 
> The driver can still store these as u8, since any value outside of that
> range is invalid for ksz87xx, and the input is properly validated.
> But we shouldn't constrain the value "in transit", at the uAPI level.
> Another driver may need a larger range (however unlikely that is).

Thanks for the clarification.

I will update the series to use u32 for the PHY tunables in the next 
revision, while keeping the driver-side representation constrained to 
the supported range.

Thanks,
Fidelio


