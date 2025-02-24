Return-Path: <netdev+bounces-169093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F50A42902
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D17A17F4CC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8326659F;
	Mon, 24 Feb 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="GAfWaG1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46215266598
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416408; cv=none; b=n54JC69F/V9ekyRbRp3D6GZL1LPz2DUGRVkMEHbiA3WiHHltC6Ac4N/gLAX03pFp7tr9Pf/Onh9bOqFNhgkt43LlNsfQKpoIYxs3+31sF4uW3yFOhh4JpD7zALuyT71CzIXCMemZWts3nrgNCwG8aU6fB2csvJ1zbxHjMZqhUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416408; c=relaxed/simple;
	bh=H/eMT60CoAji4F4FxwCqPtUx6hQMzPO26wSo7Scx9oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwy2QfiFw4m6Wb42eG/BaKdexVLA4mxsRK3H/At5+0DWpzMo4v8rEnIae3epI2JDpdJIyNyIEIAJNdoD5R0on3X6Ahtb91K1sHnUct7pgnxeHzB3mrCATyB4FSchkbajF82FmEML5pZamifT8Wp4TqMiVWV9SfP4RRqv6FtTCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=GAfWaG1X; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb7f539c35so897013466b.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740416404; x=1741021204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNWih9tGwSww/JPegbyk7ztiO19aEjAHfJHbiibWT5Y=;
        b=GAfWaG1XraXegzjXe6MF5r/F9scDCaRIdSXos9sfgXrP6/xv0o9mv5rCO/E76k9E4Y
         lIVHazip91fCEj/n1sGbIblqSh096MBLsY0sAN+jYRF5fR3NEcezIO/Q09GmOgGxEpnJ
         HIqx20UNLqhTvcILJKzF644XYkMfu+sXfGpqA9Xm60klM1eRxSuBbUOVPbcrMJiaOroK
         0Hm82Fx11mnnC3KvrpMVR0z1016zM6eJ/kmrWtvmgw6xS+0Faa9/xEABpESAMFU661wa
         +vx3Z1eXfZ1XFSBv8CJEMoKsTeSSTdg1U0StRk0PXjBQQD/SwVDGh2kzSIlO3SGbNM5r
         PFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416404; x=1741021204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNWih9tGwSww/JPegbyk7ztiO19aEjAHfJHbiibWT5Y=;
        b=cbZJLkrYiKT1rqPrzwOmeGQCd9ggQM9KKHghA3iJ4GKOxJFNieWSPtgPt6lwz+kGGv
         0C2zrTBpjiMY0QzYPTURm3TJp1uh8h0tCHr+Sx5pQmw1Rrln8UfxJx6WHGb1RfciModd
         2a5N0kUvk7a6fKG1trpSZDLe6/CZ9yZDhyiv0vZYKDGiDBNG/SAzEaiP6qu6RUzi0hLh
         jrDTL/2Up9ARdQdgjww8bvLyMhSAd4c26UqQ61NeTena49+hx89dTXpQZHuHLAqg6YUw
         VAdXw36VIyo93fbkN8KHXjajTK4KlKs7SZnYIFSZPbHR4bJmCsZqu/JjnI3l0iBAx8HQ
         rkWw==
X-Gm-Message-State: AOJu0Yzfg/SoIscS63rbRHB0tueH9XV+MV0BO4/7O9I9KzWzAxMG0i+G
	kJ+YyrmqZ92Zb99FKpfnb0U+xGG+ZSjJ7Z1ezdyVEsiuqggDZZJzDDGcAcJs5ar1gm2xzoueC8v
	F
X-Gm-Gg: ASbGnctitjP9ZCX/CUME8jKqbhYkQttYIs+LVlZYyVYShc9o7nrYkUVJpMhXsu+W/Jo
	36xBV/Lg2FO3RerBOrsyCHOyLl6ZIKFzGcFzE04ib5ISo4FaXBfxqGqiYnXwmdzAsDB9M14MZra
	z9PLX6onmghzs/oMIw3EXiM8WDhQBgTbLaw5VpWhlpdTSSlqtl4dNJDe+IBsdt5E9zvTs6+FThe
	mUcDK0+/0diu9av5PjDI9Zh2M7BMhVRBJ08wZ6dTeVd6g8oOgpqMlYe+xud3Su3FXe8rF/5AzuI
	R5YypzeEh//znyStluAvP5AVYjGni7p6e8gi1e5U3Dvf5fH7jJQBY/347Q==
X-Google-Smtp-Source: AGHT+IEwsqOsw++yT+0bFX5SCBK/HWfbV4FpqmVLjfqG5YZq6RgAGIJsGwljpC8gwz0YwsGCV5s/DQ==
X-Received: by 2002:a17:907:6095:b0:ab7:e73a:f2c8 with SMTP id a640c23a62f3a-abc09a97a2cmr1333363866b.26.1740416404255;
        Mon, 24 Feb 2025 09:00:04 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc9ff4fcdsm1213817766b.87.2025.02.24.09.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:00:03 -0800 (PST)
Message-ID: <e8b6465a-3b32-4ec1-907a-414a6e5a10c1@blackwall.org>
Date: Mon, 24 Feb 2025 19:00:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] ip: link: netkit: Support scrub options
To: Jordan Rife <jordan@jrife.io>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stephen@networkplumber.org,
 dsahern@kernel.org
References: <20250224164903.138865-1-jordan@jrife.io>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250224164903.138865-1-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 18:49, Jordan Rife wrote:
> Add "scrub" option to configure IFLA_NETKIT_SCRUB and
> IFLA_NETKIT_PEER_SCRUB when setting up a link. Add "scrub" and
> "peer scrub" to device details as well when printing.
> 
> $ sudo ./ip/ip link add jordan type netkit scrub default peer scrub none
> $ ./ip/ip -details link show jordan
> 43: jordan@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     netkit mode l3 type primary policy forward peer policy forward scrub default peer scrub none numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
> 
> v1->v2: Added some spaces around "scrub SCRUB" in the help message.
> 
> Link: https://lore.kernel.org/netdev/20241004101335.117711-1-daniel@iogearbox.net/
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>  ip/iplink_netkit.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


