Return-Path: <netdev+bounces-250261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 755A0D26257
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D2FF305C967
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E53BF2E4;
	Thu, 15 Jan 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="CGsK+8RX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A493BC4F3
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496999; cv=none; b=u9p6mpb1lH3qQLpToXqqpgvp7c0ZalvJfuFodaQyFlRlvr4e4unvXYTU2byB6fLPtku0Gu5ztbAFraazLMLf4yyCrXwO0GyNgJhT3YEVDqKWZRZaoUVR5HNbLqzkDvjGPA8osiuLusXDCpoPE3eztgXftp3GUKXw1RApRBpNr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496999; c=relaxed/simple;
	bh=1EDq5ZPRMnIGZMFaI4xo2JWXv+jMsvw689r6RKN9IEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzZr13klLCaDZuL93u1KLq6TyqZaR0DsGIYRenMbnbF54fGAQDf1J244RTteyvcpCg2w+JdvNTnIkgynkhoe6eUBpKvrgfd3+MLphEWtTX/FWGASQVTT2WjqoL7mf8YiYGrQt/1emYhmGIxKZP2V0XP7wJMHv2GEqLNfIl2pang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=CGsK+8RX; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12448c4d404so328751c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768496997; x=1769101797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yeNnib88Xjj68PvEZBZRp0ajnP5njNHxJvHevJizyc=;
        b=CGsK+8RXEaMFIFvljm/xvJobUZflk6yERtDNtuvwRpoTs34zHGT7GYRjVKQsZ/fs2U
         M4p8aJy5QGSthwYYHRL7MoSq1wsL29rMjB+yH3DQVB50cg7xBFQBvftIq7uhz/SHUU4v
         PkaC0wX67OjljrETyaM98yyCGArhzNQK+VLslpjPQoV9Ge5bObU4q6yipZB+3Wh9aigr
         PIBL96L3KoCOLmGXMIakFOmyWuoiPLB1sLuSq+9pz8w4VaZBB28Y9rvrkMJBJwUdgKK+
         P22BNv2odHQb317+PCx3WTPp8w1ac5sLvVpZWWmb/+fSjDlZqJSwqO+5IAdNaZyIOtTE
         pGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768496997; x=1769101797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yeNnib88Xjj68PvEZBZRp0ajnP5njNHxJvHevJizyc=;
        b=b6yQlt/tbqT46Oj+xO+zLY1rCRtvnjf32aHkZEO1CaKtJvlDBw+f77JrRhyB5g4zto
         veNI6zVAsryVF31LdV/ZOId/9OSaHKIQ9JuO3CrECBpJ0Ems0UdYwe6dkpx/YXOhKW7j
         d5D9x25SZxzFzCkyEG6RjcrtFcPhmEApDWAHQ0olQG4b4O5eWcqIQ0/ZhbkbLPgMYEjX
         E/YV/uX0/eF943T5I+oyksh8yA54Zr8bjSX5etqNMmRvOsii5Y9QkTMFCNnS3VyYrWeg
         Qgq9lAG3vyeuDdZVOYQuQapTLLj2P0Hwqopj1ZF0umrPg+OtcaINfZOZ21gL8JxEj3Py
         G7ug==
X-Forwarded-Encrypted: i=1; AJvYcCU5bBPUhBA/IjBYcFmGG1dPhbGkLr5ooZ350ERtvUAQp4BppsYLjoUPNGUr/C9HZRfdnhMUsTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfcCc1vMt448H4MFsX5WBo0sLsO5/GkwNeJtGLshw+wob5Wi+
	JKs1CSKoQcmily9OHLTCpj1/SZffRzNbXTvYK/RizWyIcwtykpmYtFjEbygRy9QwQyM=
X-Gm-Gg: AY/fxX6O/o/wyPl2SqlsUZjbKEgaFDXxNADxppOr5lFosIuEYxA05pGvFBxxKoeqymF
	CiL05ZE/UH57ZIeFWEzU2MFOrgirn6XiQD7FQbomjvQpNPhJ6V32+aASv1opkGqlkkQ5h1YI6oa
	TqoqiUTFe3aBriwl4hJhPu9UEOOAaAQzDW6VVBqZesO9gGcDFzXpDWDRttsdbLIjHb+5uac+p6J
	v7BTYvMXDMGdYgvGMX8UWVm6AVcb/cElPsyNIOEFQIVD+vN9BnaTB48ndItrEck3acwxlnvrBPj
	WlB5WJ7+1QqyJuRt1V1zbxpAaeFBVwtOD8WT8j8ZNvcjq15wr85+/YGW0FXJbgga48P7vEoOrkw
	A6I+LuaGuWN7QLUQdILUgloQkWZsnlJncfcD9+Y5Bpjeiuqult3yPNlDG5mj/QDjlKTpj8THxWR
	x5VgBRpFMCDZBY/K6aerhwesxUb+PU2lTsG4ThYCQhnd9vlNpdUpN0JBq0Hgbi24fUqTivCA==
X-Received: by 2002:a05:7022:6b8d:b0:122:33e:6d41 with SMTP id a92af1059eb24-1244a76c4dbmr287679c88.23.1768496997355;
        Thu, 15 Jan 2026 09:09:57 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad72063sm136407c88.6.2026.01.15.09.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 09:09:56 -0800 (PST)
Message-ID: <1ddec6fb-7a0d-4c07-a328-4eb7685b9b69@blackwall.org>
Date: Thu, 15 Jan 2026 19:09:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/4] bonding: 3ad: Add support for SPEED_80000
To: Mika Westerberg <mika.westerberg@linux.intel.com>, netdev@vger.kernel.org
Cc: Ian MacDonald <ian@netstatz.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Simon Horman <horms@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>
References: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
 <20260115115646.328898-4-mika.westerberg@linux.intel.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115115646.328898-4-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 13:56, Mika Westerberg wrote:
> Add support for ethtool SPEED_80000. This is needed to allow
> Thunderbolt/USB4 networking driver to be used with the bonding driver.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/net/bonding/bond_3ad.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

