Return-Path: <netdev+bounces-200157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5380CAE3783
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38355173E7F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BD1F873B;
	Mon, 23 Jun 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="aJtZ8RAE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB245376
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750665157; cv=none; b=BEc2vOIE4gCqWKYK0AJ7GLkG6/HjY5x0jGVxavi46bEYxZujBvFrNgL6DGnI00vL1S33oHJy3Oslolw29WvPmd42a6xaiqkRAPrIZbFIUgyD8fc2rmGrWsKgoPs9fXgL6dZoUwDPh1atrq3G/qgFx2DPvjEbljuRkI3rRibpvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750665157; c=relaxed/simple;
	bh=MiMVMR/aVykWmRUvMhLFXxT/guoaCBMyhvS6yqiFAvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYWmokfq3pD9fxn5cGiDAqRfukxUsep/OjTDTGDdKUocEY/M2rXp41ZJlXe+3UF5mAwYDmtrtSRIm9zpYlgu97kWc1tMP0kIhkPrIQRgZ8mJkycMwXkgFniI5l85m8ckxjXbMnlbGnM4eunaskshaGYlBd1a1wxmuB006b1pomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=aJtZ8RAE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso7474817a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750665154; x=1751269954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiMVMR/aVykWmRUvMhLFXxT/guoaCBMyhvS6yqiFAvA=;
        b=aJtZ8RAEKccHHjKu2st0TZkhPUs7lrCWfQwmp5H9Njy5EWdTozJU27NBpIGG4PI6qo
         CwYqri7ufOxGOfpSID/9KPVcHdWTJiMxkiMq2lg7iTLxsN4r7M4g1kn+Ik9QHZVcdO83
         iu2lTniHRovujqlrcIFIhhTA3pPoecQ0rsvQ1xn+8ihB2k2ptZ/4yPXDF6IgcqAbjGRY
         z53B3P+aR3Q9y3xgohmGgJpu0ykKQHDqg9LSCTnuM6Q3ha2ZqZprPicO1Of1ri8p/6Pg
         OhQSiuk7iLjE0uArZNU3m37MTfncKZtDldpQdwEfADRa36q+PNTDDe7A/FKjL8CaBbmv
         xxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750665154; x=1751269954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiMVMR/aVykWmRUvMhLFXxT/guoaCBMyhvS6yqiFAvA=;
        b=TKrP7z3uJgDdM2cq3MYzWYyjgopGUqR+6sfQxLm1Q8gJUD2R8X8ciAZpwVym0u3dT8
         JyQYDZwAraZO28w2Dnpu1qIwhR1Co9FulDjPpxYwD/6Gd9lbJ9O1i6m4AmC9lvkGasZ4
         IJxZ9ppHbIMTnbb3UiETJj5VrUshJbiH1/w9q/n385LbqhVyPF0RmveVhu5awKQwZMP+
         Mly79bIY24gPTXxbbJ23WRSQhYU4VuC6AkerEZyRf4YizEvW3X9aSkt3D40PgdpJT92x
         6SDZaXrZgtaSlD3CrwIX/HuZBIrjdQFE8JkHKsYdDngvZPuohVu/IkmTJgraoUxvi4mH
         mdHA==
X-Forwarded-Encrypted: i=1; AJvYcCWE7/WBn4eqeFUa55i3qOpfXOXHWUjGJ6uNBX4AtcorKJkNaLRKfip0+VQ2HoUUP/rV9+YldCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZBpN96yPoq8h1FqIM/X/PY03GhVjLYjju2fL592hgyBLlqJ70
	6SSNe781kqmj6gq3xbDLrH08bcdnvFtsEeywB+goHTvIHroNsd1eysHFMOEquwwBSTGD72MECF9
	zXBS2
X-Gm-Gg: ASbGncvq+XESLR+i8X5BA/T/9ITRgKc+453/l8GWbEK/+np6W2ZirD2Isx+aRVuW4X2
	D1oyTuI/AqwtwsPUdpjB7LH7EbH+5Z+vJEyUMOVqkY7YwQSVjBz+8v7zhPg6foHKDxnFMyfak/Z
	On3xtH/lVgC29PBakch84GaDLS9BowfIaVYidyxxElP6/nJCGgWE/3psV9OuutAIj90CleFu/w0
	HM2TQW8MP489Tkl9Ggw9BduKjgtTp/vMLG5x437232qlFpvvruo49kkkcBZXCWOxJHmFH0VW3BL
	jRT5HC9iE8KpnWFzroJ8AGP2u+0yyxxl3CRPcht1KD52ZiWhKu4KlcOPKBTI4o7rzwx8Ye6QUiv
	ROowe7WGbsmIg4cO9CA==
X-Google-Smtp-Source: AGHT+IEcI2WKNX5Vp6Sj64483GIFOnB/otWSEXt2rQsFZPBJwINAl0CsDM7Uhhr6hpdpqprvcuW88Q==
X-Received: by 2002:a17:907:3f1a:b0:ad2:3f9a:649f with SMTP id a640c23a62f3a-ae057f65c4cmr1055113066b.42.1750665153660;
        Mon, 23 Jun 2025 00:52:33 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7d1dbsm673152366b.16.2025.06.23.00.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 00:52:33 -0700 (PDT)
Message-ID: <8a8ba47b-76d6-46d9-b48f-c01edd160d22@blackwall.org>
Date: Mon, 23 Jun 2025 10:52:32 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bridge: dump mcast querier state per vlan
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
 <d8d5a8f4-33a8-4a62-b48e-fb82b8de245b@blackwall.org>
 <dbc2fcc9-5cd9-43c9-a9f9-9d5d16bb81b4@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <dbc2fcc9-5cd9-43c9-a9f9-9d5d16bb81b4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/25 10:45, Fabian Pfitzner wrote:
> On 6/20/25 14:44, Nikolay Aleksandrov wrote:
>> On 6/20/25 15:16, Fabian Pfitzner wrote:
>>> Dump the multicast querier state per vlan.
>>> This commit is almost identical to [1].
>>>
>>> The querier state can be seen with:
>>>
>>> bridge -d vlan global
>>>
>>> The options for vlan filtering and vlan mcast snooping have to be enabled
>>> in order to see the output:
>>>
>>> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
>>>
>>> The querier state shows the following information for IPv4 and IPv6
>>> respectively:
>>>
>>> 1) The ip address of the current querier in the network. This could be
>>>     ourselves or an external querier.
>>> 2) The port on which the querier was seen
>>> 3) Querier timeout in seconds
>>>
>>> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
>>>
>>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>>> ---
>>>
>>> v1->v2
>>>     - refactor code
>>>     - link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
>>>
>>> v2->v3
>>>     - move code into a shared function
>>>     - use shared function in bridge and ip utility
>>>     - link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
>>> ---
>>>   bridge/vlan.c      |  3 +++
>>>   include/bridge.h   |  3 +++
>>>   ip/iplink_bridge.c | 57 +---------------------------------------------
>>>   lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 63 insertions(+), 56 deletions(-)
>>>
>> Hi,
>> The subject should contain the target for this patch which is iproute2-next,
>> e.g. [PATCH iproute2-next v3]. Since there would be another version, I'd split
>> it in 2 patches - 1 that moves the existing code to lib/bridge.c and the second
>> which adds the vlan querier print code.
>>
>> Also a few comments below..
> I'll split it into three commits then:
> 1. Move existing code into shared function
> 2. Call shared function in bridge/vlan.c as well
> 3. Refactor code according to Ido's code proposal from v1

Sounds good to me. Thanks!


