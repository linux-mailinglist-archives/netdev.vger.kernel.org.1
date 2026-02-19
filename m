Return-Path: <netdev+bounces-259545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C8gMQlRl2nswwIAu9opvQ
	(envelope-from <netdev+bounces-259545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:06:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E665C16175B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F8D9300939C
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67134D4D6;
	Thu, 19 Feb 2026 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX76ZVOV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n1RhSrYa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A10343216
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524356; cv=none; b=rqGfuqfvP1CoR2IPw4czbWA7Db+u3TAt64KZeILy4LqB7+oFyHz1O6hjx/X/vYOz5PlttQUJgS7FkZCgC+iuCU/zlRe6T3HKJD65mmnHaEfxyEiUM0dXefeVGVnAgS0mwatmuWdabO8ID5GsYE8pgy7NMXpqfn8HEcQ1J02GTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524356; c=relaxed/simple;
	bh=d3cVsF7VAABtGs33IWmlOqDC8v3hLiy7BwtvhOHbqsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbYL+Ez+syawHa/W4ypQe65kW6vUpGC2hXuR1x3Zcl6eYH2ViwAmTZGSGIlr5GMF8kB+OHhnR89nJ/gZKv0vPaAJGeUSZ6wmchOQEZhTXXhRfLM6u+i36hiS6OfV+tNjttMNvA7xa4vtveX/3tPAP8VYD15P8dx/uqgYzhsys9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VX76ZVOV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n1RhSrYa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771524354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFeRM+f+hx9TQM9WhEaZMA68vLCY6hbM83VMFNORwM8=;
	b=VX76ZVOVimNyEKhrXo6F7wqkqhpl6o+6KpDsrUaVXdM0a+2sxzVkyVPRznmtLtgpJPstdg
	C9UvY1KMeTESqjX1dT4kEB9Hd8oHhqnVBmgNTiqFnxwAh5g+7qTNBnQwaq3tZ7wxjZjOGK
	axzhdWczPfaEJloqKgUgoMzRWlNhTbY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-FWv3qBKJNE6uetpLGPvG6w-1; Thu, 19 Feb 2026 13:05:52 -0500
X-MC-Unique: FWv3qBKJNE6uetpLGPvG6w-1
X-Mimecast-MFC-AGG-ID: FWv3qBKJNE6uetpLGPvG6w_1771524352
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435a11575ecso1298120f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771524351; x=1772129151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFeRM+f+hx9TQM9WhEaZMA68vLCY6hbM83VMFNORwM8=;
        b=n1RhSrYaoG6yiVLYgWK8HrsZJ3FBSX2NEkdprv21YhXyIZ6VQ5LWo7BcIQIdiUZI6I
         L5GWjyyvbu5VZpQ2lm3Bip/gqM54dctQFkYsiBrrEP8tv/x2bVxzs8/J/A5nAs9nlBxl
         Jv28SXnrCIcEj5rbpF9BuDho2LXu3DK4k/S0/1BiGg5A14cHipqzClrSV3kuT0euyU2x
         x7nZe9kWjrMhNpBiKrGy3sHqEE/IgzaHftGcqanrM+/s8qNP1KRVblPiobmgdOW4O0gQ
         Zdk3WhBDnItbfauGMc4kAzG+pGVK6+zXk1PcTlOL/W9WrgZx576bM314hCrSatrOfBtD
         AyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771524351; x=1772129151;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mFeRM+f+hx9TQM9WhEaZMA68vLCY6hbM83VMFNORwM8=;
        b=IGCFOpNHuxNRjZmMSAhLqiu+C56mKXBtkHsFILlTYJj+rHmMU55TBmt/hDS7TpjukZ
         YhWxy874ZnU7Jk4qq01L3/qNmiEojP5stVl4it68fV61doK7UDuqf7IrPj2I0WU40rgl
         faj7MZHzB2rYw9UwbcgyrTs5j4aMZR8fIcPbD1lwgiUQMSyf3+GDI4FpCi11W54DOazz
         viQDhd6jzPRf6DOWD4najGt/WUZJCcVFLWCQ876RPyez9AjUE8qptTYKdaLEWz0n1q2a
         TGeAd28bMifOFYon6D4cHkm/etp/txTfpnwpk6h8CJ3lRFU9lxdH7SyXMkvh72K0j5/o
         4kNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbFVwljPAWUPHjbCUB4siUshKcLzABoXlak9l5Zdy6Jx0BNnt3W5lC4zsa/utaYUxtW377qBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoyUzEmgwT6p2Sqf6hnE0HVSUWKtIn7phyk7AfCTF12/vT9l4
	ZXsb76ytq8in1Y5NnJCXguRIrRw+8qJwn314bS7QrAm/r70pNkSxqzXcERj1eCSouppMuqvjOrr
	dApDZYPexQCDyKmoWCrkTTwp9BUDge1JRl8W9BKxMH80hrmyqDOYX9+5cUg==
X-Gm-Gg: AZuq6aLT+4/O69VFFpWjwYw7z/hJKyOl7RrHWvApfWZ/SK6ReME0QS96oe81kV+qXtJ
	ODrkhFhKWAYuKVj4fVt4ZSy5KXnbZ2taN8vpaMN6wa0AaRwQifqYJeDUQWctV0bZ2Lb2gw+zchG
	EuWnylBAaTV7E2a+FoTgC5rOS6VExdYBJxTsWUteyeiCkOmoKTHtDCvLbjXxwWbxhHBYqeYDnZO
	sslx9brrg7dKCmMbUgbOq41jT+R+xVZXzuBKkYbmIeQ+A08ooZbclDYAlDbR5uLGpZSFzdeIYne
	pNX/TCpRwjF4+SpwNQ6e87KE7ZjRpnO9brl/Hu3jwky3OJ7c5cbk7XByP3x/w7npLINKaRZQ6ke
	Oi0jQ2Inpt5StmeQ8YTPyaQin+kyNswmu2Tye8DUyyOTM6SehRPS+cSOyqaM=
X-Received: by 2002:a05:6000:24ca:b0:435:a0f6:115d with SMTP id ffacd0b85a97d-43958df1120mr11212366f8f.4.1771524351380;
        Thu, 19 Feb 2026 10:05:51 -0800 (PST)
X-Received: by 2002:a05:6000:24ca:b0:435:a0f6:115d with SMTP id ffacd0b85a97d-43958df1120mr11212313f8f.4.1771524350863;
        Thu, 19 Feb 2026 10:05:50 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abcda5sm54489774f8f.19.2026.02.19.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:05:50 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, =?utf-8?Q?Th?=
 =?utf-8?Q?=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>, netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?utf-8?Q?Gr=C3=A9gory?= Clement
 <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next 0/8] net: macb: Add XDP support and page pool
 integration
In-Reply-To: <DGG9UYCB17KB.4V0H8BECUV57@bootlin.com>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <DGDZR8L3E9WI.2MEYVL01KQ2YN@bootlin.com> <874inj72uv.fsf@redhat.com>
 <DGG9UYCB17KB.4V0H8BECUV57@bootlin.com>
Date: Thu, 19 Feb 2026 19:05:41 +0100
Message-ID: <87fr6w1udm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259545-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E665C16175B
X-Rspamd-Action: no action

On 16 Feb 2026 at 10:17:39 AM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> On Sat Feb 14, 2026 at 4:37 PM CET, Paolo Valerio wrote:
>> On 13 Feb 2026 at 05:57:17 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com=
> wrote:
>>> My XSK series (based on top of yours) is ready.
>>> I won't be sending it while net-next is closed, of course.
>>
>> Nice!
>> Same for this series, will respin when net-next will reopen.
>>
>>> It starts with a few cleanup/rework patches that have no direct link to
>>> XSK and touch code you add in this series. They could be appended to
>>> your next revision or even squashed (with the right SoB &
>>> Co-developed-by trailers) for most.
>>>
>>> Some contain bug fixes, mostly related to stats accounting. I expect
>>> some amount of discussion as well, mostly regarding the page pool DMA
>>> direction.
>>
>> I quickly looked at the patches.
>>
>> As we briefly discussed off-list, in my plans stats were considered as a
>> follow up. I intentionally kept them out of the series and to keep it
>> smaller.
>> Given you added them, I guess it's perfectly fine if you include
>> the patch directly in your series (unless maintainers prefer/suggest
>> otherwise). The same should apply for macb_tx_complete() rework.
>> That being said, IMO, we should account xdp stats separately instead of
>> including them in the generic ones.
>
> ACK so I keep those patches in my series.
>
>   [PATCH 4/_] net: macb: account for stats in Rx XDP codepaths
>   [PATCH 6/_] net: macb: rework macb_tx_complete() processing loop
>
> If my diff related to statistics grows bigger, it'll deserve its own
> series. Until then I'll keep it part of XSK.
>
>> The one about DMA_BIDIRECTIONAL is already part of this review cycle
>> (see bot's reply to 5/8) and already incorporated. I'm also considering
>> the possibility a change that make this no longer relevant anyways, but
>> I'm not sure as it was planned as a follow up.
>
> Yes indeed, Jakub's LLM pointed it out. I looked into this for a bit and
> couldn't find any good solution. In the end I couldn't find any
> measurable performance improvement so no need to worry about it (on my
> platform). I guess the only valid option is to reopen
> if `running && (!!old_prog !=3D !!new_prog)`?
>

yeah, which I guess is fine, after all.
Also, this way at some point we may even consider to remove the xdp
headroom for the skb case and reserve less like NET_SKB_PAD. This would
have the extra bonus to not require a full page for 1500 mtu with 4k
pages.

>   [PATCH 3/_] net: macb: always use DMA_BIDIRECTIONAL on page pool buffers
>
>> Regarding the patches containing simple renames, I don't think they
>> require a Co-developed-by. The reasoning follows the same logic I
>> applied to the patch you authored in my series; while I addressed a NULL
>> dereference, it didn't seem significant enough to mark the entire patch
>> as co-developed.
>> The same goes for the style change patch, it doesn't change any logic,
>> it's just a cosmetic change that normally go through the regular review
>> process, but if you think it requires a separate patch, feel free to
>> follow up on this in your series.
>
> Yes for sure! Squash the remaining patches as if they were ordinary
> review messages. It was simpler for me to send those as patches along
> the other three.
>
>   [PATCH 1/_] net: macb: rename release_buff() -> macb_tx_release_buff()
>   [PATCH 2/_] net: macb: drop two labels in gem_rx()
>   [PATCH 5/_] net: macb: improve Rx refill error message
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


