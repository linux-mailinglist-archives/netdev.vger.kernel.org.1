Return-Path: <netdev+bounces-169799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E41A45BE0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A037A40D4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419A211A36;
	Wed, 26 Feb 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="PUNCYDW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA50211494
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566007; cv=none; b=TMYFfRSnblcxcKK2PvbsPem7b189PbBv66//iwgLfmvmdIyuBmWBeafI+HMNFrvdCnKiqa9Rg93ij2LpYnySqMORTdPC+/IMRtHVFRCaOEE23xOTvWYzItmrAj3H6KN9xRJ84ep041pcl/QddyN9rU6AtQjyXIUFUOyhxhyHbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566007; c=relaxed/simple;
	bh=ynRJRA6fh8cdNAoV1rOcOBdNPaoBvJ60HtLCp7MCHHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKpZZuXvMTjq3cX6YGLXWGJwDgwqRA0kScEckGZMRlBS60Wj+4WAfdRhacfQeznW7mShPFdk6lwbkRmmODZoCK4C7DYjGBGDSsBNCFun6SGAyYiKkEyCAjRNLlzp84FiqBqLFqpMOPFtFX/RzdigqaN26ABSdcpBdbeX2cmnK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=PUNCYDW1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso1009022466b.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740566005; x=1741170805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/l/yqNANiIb9iFrI32DS8q0o6uDvSbvWNVDvRmR39Sc=;
        b=PUNCYDW1AdC4F6ID0tre9GPVUaLRAEFQpcVZoPVIKAa/P3KyPjqDBm38EgL399mXqZ
         H+xHu4NETzLDQM6RYRIzj6lAZh+8VaENCOh7aybD/LgkmPNXZYSnvZLPFKUIpeAFkCXp
         Mr4JxPJxBnk470FLZ0OfiZprnBBqW8ANwpmidKX1qi67S4LzFufoDIm9X2QuXZgUArQ7
         PDz+9bMpMMfz59JETGGrifs3151GAM0Z7LBAU4bBN6HUIJRItefgoOVsw1ti00bTzRYD
         kHcodfCgdQHVKpWGdQaGZ2bObeVLEhDIgQ+QSWJR5qynCU0uPMRwd8YYPb5JSaBl+0Kn
         eEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566005; x=1741170805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l/yqNANiIb9iFrI32DS8q0o6uDvSbvWNVDvRmR39Sc=;
        b=DXixrUKl7R31vk3GkLvg3S/ddIFUSZgyWB9qYE1WDpQfDh9+8zudhZX+4W8RiHMoEg
         lwHPY9IGBUBt977lAJAsgbvBjEdyl1BDAa0d2XbLH54/JapbVGJu0D0GNwaLw0zSjGVg
         mqMUmdrFcMXxF6OeeyZQl1f9bODOrG8UcaXLlwwf+Anbn+BN9yD95rPFiR0H54/6Otkg
         puFWQpn8g1diH9M3i8TWbD99vQN9UAZOIFEtZZYFG/d82oKKdsTSIMVbzNxukAB7ddEM
         iLPnVN3jmg7IGj1x9CeapSfkQ4Pk4WYFiF+H5OZM+0/pk7se7okboqhq5fCzv7L6M6kd
         96KA==
X-Gm-Message-State: AOJu0YyIbQOi89EHeITNEkzMaiXv4mS0aUe4HXqGfjGoYTSdU+qRWoxO
	Gq4wfhBtI1ViY/uvEcBmDjKd8RLQsdQRGnvjGY9QgQ51EgyrOKiVP5sYxRPtRFk=
X-Gm-Gg: ASbGncuIgTx7XU4WwWiJGNcjfnhRWL5GPz2g2bMNybqjAu9mjdzzExC8WnBmeULj+sD
	nxACJuG2H55RuOIzdKgSLFHI9ZGXATing4RLOoDUXyXe+XXQ5jBakfZckbiOyp8859Ej5walzPx
	dC/wFR+SRYWMcCb/f1PbvST11f5QStbcUnp9SMgihbtITMeUw3QR1Awu+aGokmKqQx3bOahr9yI
	S9kvsSqOImLlBksXDBK7KBa8DYfjqBEXrsjBjY863wEj8axFNzfGaGyJI0kWvczmXU2xHNEZvr4
	x7V5JcgFGJlfT2fyGR3lJAheZpOB/awvcENXpNgiYL+HIKUHIDb5MeIsAQ==
X-Google-Smtp-Source: AGHT+IFyViIUcT5L2jBWSWyZFNUHCk/WYK99JXGW5O4xzxAZXFR2THGsaEN/AdK09ibLNBMRg1p2Gw==
X-Received: by 2002:a17:907:7848:b0:ab7:f9d5:9560 with SMTP id a640c23a62f3a-abeeed5b2dcmr239704266b.14.1740566004575;
        Wed, 26 Feb 2025 02:33:24 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205e53fsm296530366b.159.2025.02.26.02.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 02:33:24 -0800 (PST)
Message-ID: <a6753983-df29-4d79-a25c-e1339816bd02@blackwall.org>
Date: Wed, 26 Feb 2025 12:33:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Ian Kumlien <ian.kumlien@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
 <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
 <20250225170545.315d896c@kernel.org>
 <CAA85sZuYbXDKAEHpXxcDvntSjtkDEBGxU-FbXevZ+YH+eL6bEQ@mail.gmail.com>
 <CAA85sZswKt7cvogeze4FQH_h5EuibF0Zc7=OAS18FxXCiEki-g@mail.gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAA85sZswKt7cvogeze4FQH_h5EuibF0Zc7=OAS18FxXCiEki-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/26/25 11:55, Ian Kumlien wrote:
> On Wed, Feb 26, 2025 at 10:24 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>>
>> On Wed, Feb 26, 2025 at 2:05 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
>>>> Same thing happens in 6.13.4, FYI
>>>
>>> Could you do a minor bisection? Does it not happen with 6.11?
>>> Nothing jumps out at quick look.
>>
>> I have to admint that i haven't been tracking it too closely until it
>> turned out to be an issue
>> (makes network traffic over wireguard, through that node very slow)
>>
>> But i'm pretty sure it was ok in early 6.12.x - I'll try to do a bisect though
>> (it's a gw to reach a internal server network in the basement, so not
>> the best setup for this)
> 
> Since i'm at work i decided to check if i could find all the boot
> logs, which is actually done nicely by systemd
> first known bad: 6.11.7-300.fc41.x86_64
> last known ok: 6.11.6-200.fc40.x86_64
> 
> Narrows the field for a bisect at least, =)
> 

Saw bridge, took a look. :)

I think there are multiple issues with benet's be_ndo_bridge_getlink()
because it calls be_cmd_get_hsw_config() which can sleep in multiple
places, e.g. the most obvious is the mutex_lock() in the beginning of
be_cmd_get_hsw_config(), then we have the call trace here which is:
be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_compl -> usleep_range()

Maybe you updated some tool that calls down that path along with the kernel and system
so you started seeing it in Fedora 41?

IMO this has been problematic for a very long time, but obviously it depends on the
chip type. Could you share your benet chip type to confirm the path?

For the blamed commit I'd go with:
 commit b71724147e73
 Author: Sathya Perla <sathya.perla@broadcom.com>
 Date:   Wed Jul 27 05:26:18 2016 -0400

     be2net: replace polling with sleeping in the FW completion path

This one changed the udelay() (which is safe) to usleep_range() and the spinlock
to a mutex.

Cheers,
 Nik


