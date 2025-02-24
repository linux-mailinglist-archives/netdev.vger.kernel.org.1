Return-Path: <netdev+bounces-168913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB64A417E1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08E51886862
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369671A072C;
	Mon, 24 Feb 2025 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="TLHOAF1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD31DD873
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387309; cv=none; b=tX10Kn36iTwvyDyzgVAE6H5dLIWCCGboIyC8eH80muNfcsV/PvQfeIWhXTpG67DuQMZ2zrL3yWoY5+f6xAXEHAIBtFtOfJ0IrWz4RDS9RSbAO3sybueTtSgGIHZbwtI4N2XOXoluW3/tv3hjcfJtCMgVYzNnhtAYELsO0Aj1ADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387309; c=relaxed/simple;
	bh=1GgqBPyBTFlKCgi0PwPjLYZrEEzQFrvP4PexcY6r2dM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tmsM0djmSOrjJbl3Mnr7tuE8OInm+hAsAyShtvL3xWUPd+NeYsSx7Ihi7lJZxrcSsKbGQ5tjaTZhUvvB3FBnR/HMjEElgRvLuOmNi5HWnshlm5xXDnR8zzcz14qbbC3DnX9zlKfErSOPhsHuUr3sI2WMfyE9x1QefK2IDOqu7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=TLHOAF1E; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so6933681a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 00:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740387306; x=1740992106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QO+xMkuYp+Md7PtJmgu3Mx03+LhiNMwmbB5jOoWRdDo=;
        b=TLHOAF1EUERyT5gmg6oFpsACOR2JV1qcireA6IO0bBO+NX6AxAmsFdzhjY2I/qzKz9
         zOOFikz7tnbKysc1zGWFTG4dKs9U/dM3AS92DXaJU/r/hsf9c0aJ9k13QfP3/AlHMigL
         XAApyXvAt/F0OAhczVdP2aC0QVWpv1vw+MLJDfrpW+2rTeqbzLR8Fw38gLH2Az0JWEib
         o/l4o9AYhijxjBpdr74kH7aGJK8o1zMC9s0slNsYvsJHgxdImfDAJzfwU4Gx9xF/fAWq
         HN4VTm1bb+rVEIASGQ0FsNkfm3SK/vsJWrZdZfv0sfYBmn3FcuOaY8NPZgGn0I2d4dOr
         CZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387306; x=1740992106;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QO+xMkuYp+Md7PtJmgu3Mx03+LhiNMwmbB5jOoWRdDo=;
        b=ec0fUuTklHJosB3PGT+2R/yRYelxPCm5hhGKy72a9/qu8bYqcsteE/oTHQMsXvyrHF
         h6gB2y7scTpQDnL8ETbSjPaFgVu9NHhrYFfMZ6XN1UfCvXUBvSUysGE/WNiPvK/VtMBL
         /LohGmuIkSVQsTRdjU9U1BCAZxIQZEYp89T1xDwjzzLnWcDi8hmsEMZ/Y/BhhZWXLKQq
         4qV4cJuVFI1w1/InERZddI7fmdTDzmTIllP8rMWwud9+JGqa9uXRwcqV5v83UMIoo5ER
         mNe3B9zyD9LwoY3N3FJkYUTldCBhU7s17OQDA5bnWoZpeoH7ZZF6MK8Mk2DdXmj6N36b
         NETQ==
X-Gm-Message-State: AOJu0YxcO1p1N2hTh5L5QEo6zg4bMyNjsk8HLa9Cl/3+8XmztOD5WcUO
	DXVw35vOfV5rl2q6Alnilf7MyfZxX4FlsyuxtyhO87+SRFu8E3YBdm4OwqV9I0k=
X-Gm-Gg: ASbGncsYuJfXTt0e6H0HGg0OCQ4Y1XYNvkisHgtwkMoZWRpBEdQD2PTk97YGUmPZRkm
	uHDHjcmflM6HAUB9Vn2EVezq6BbiJJpefdEUWsIXJ5r5634dynYAOVUcCVK0wssxR9YV0gdHxoG
	1i9pMJcUFP6F0u9PrIUhUWZA4+MfPRC58FnK5RoyY2oUPjcOZcu907nyvCgnkwxN33qN5TmSRhg
	htO9lOlS+APqYXMHyIood+GXQgqfhkYFDJ2hdTZ3YQwhIv/zM0pfk8ZRxVkKJksnJDus+HlyaRg
	JnTKGM1PJBXYX/N7SH/QTmbCuYYH2zfMf7gUplj1HuBDNFaZiqGqFPcKeQ==
X-Google-Smtp-Source: AGHT+IH9CYcouR6wSGj8Me5I7gLdm8lODFGLx/dNc4PMI3z/SgqUIEeLqeDKb91xDS6hqr1+z+Zq/A==
X-Received: by 2002:a17:907:7214:b0:ab7:d801:86a7 with SMTP id a640c23a62f3a-abc099b847amr1224459866b.3.1740387305528;
        Mon, 24 Feb 2025 00:55:05 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb4d3ef3c0sm1841360366b.41.2025.02.24.00.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 00:55:05 -0800 (PST)
Message-ID: <ce7053c5-b06c-45e2-b0f0-eb1a33131853@blackwall.org>
Date: Mon, 24 Feb 2025 10:55:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ip: link: netkit: Support scrub options
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jordan Rife <jordan@jrife.io>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stephen@networkplumber.org,
 dsahern@kernel.org
References: <20250222204151.1145706-1-jordan@jrife.io>
 <1cb55499-f560-4296-a44c-e5af7a3d1758@blackwall.org>
Content-Language: en-US
In-Reply-To: <1cb55499-f560-4296-a44c-e5af7a3d1758@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:51, Nikolay Aleksandrov wrote:
> On 2/22/25 22:41, Jordan Rife wrote:
>> Add "scrub" option to configure IFLA_NETKIT_SCRUB and
>> IFLA_NETKIT_PEER_SCRUB when setting up a link. Add "scrub" and
>> "peer scrub" to device details as well when printing.
>>
>> $ sudo ./ip/ip link add jordan type netkit scrub default peer scrub none
>> $ ./ip/ip -details link show jordan
>> 43: jordan@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>>     netkit mode l3 type primary policy forward peer policy forward scrub default peer scrub none numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
>>
>> Link: https://lore.kernel.org/netdev/20241004101335.117711-1-daniel@iogearbox.net/
>>
>> Signed-off-by: Jordan Rife <jordan@jrife.io>
>> ---
>>  ip/iplink_netkit.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 45 insertions(+), 1 deletion(-)
>>
> 
> Patch looks good to me, since this is a new feature perhaps it should
> target iproute2-next. Thanks!
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 

Aargh, just noticed one minor nit:
"Usage: ... %s [ mode MODE ] [ POLICY ] [scrub SCRUB] [ peer [ POLICY <options> ] ]\n"

The other options are surrounded by spaces but scrub isn't. If you're going to send v2
please add spaces for scrub as well.

Thanks.


