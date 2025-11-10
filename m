Return-Path: <netdev+bounces-237187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCAC46C3E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11153A2DA8
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2521F91C8;
	Mon, 10 Nov 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo3ZtH+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0E21CAA79
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779962; cv=none; b=dOJY9ByHZP9lY21ILY4EGrG71X0UVAh6S0jvIiWqS3I9jidNkib0Y3q2FF1mmQTdugIC19qUiCwTw4MkLsSNribIRSscL34k8C3MwV7Fzul20MyXW6XjCu+e8/1ufQkJgSvsI9P1fKks7bJmxsDJTlA8KOBRo/92FP5eNCpRPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779962; c=relaxed/simple;
	bh=tkAid+ncn0OiE3KRWyzpO3B2eBpJtoyCWaXJhHBI37I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZXhrMeFnna6nmkW0NCHSHqGC3RlM0o13gxjjvviZoybkGLhnngNNUwXb+Fw/GDUG8rI3PVUfuQP3YKqbA8oGCrQ0lw626+YBWz+lXWPQkPlNlTZdlwLlMBV+9jkBkFUOiO8B2QR8Ka86C2YHwEfHWu39g8i7pm1UW+u2cySjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo3ZtH+P; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b22624bcdaso402554385a.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 05:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762779960; x=1763384760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YDJ2IN0Zya8uyamUgknQHfjkE1b693NA6xUsZI23zo=;
        b=Jo3ZtH+P71t3xp/24acBo7g98zfHwC+xAHdEj/p13u7XccEV9Qfga+Ml7DAfcc1kOA
         RbTiXDemn2AmSKnIBkjcJ+kAp3mlfZU6fEz8yU7zx4sdBnMiDVV+iH1S+Dr0B1Csdg6k
         zQJFhnqVwKVvH1ev5sVu3VAQNPUyaPD5247XhPGCmMNz1lkT+SpZUf9GQgR+/wW7QCH9
         Ztb7laGwULauKqIoN4y0lgCJcjr9lll3gxLHpeE9r+/K6UiOqTJGThQEvyoo9zDmK6gH
         3knhH9sDBHDq15tlC2I3ugq6rY9SnJpK0Kbb4w80ovltugXcSWjVK3uzfib/IBzxMWkG
         8ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779960; x=1763384760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YDJ2IN0Zya8uyamUgknQHfjkE1b693NA6xUsZI23zo=;
        b=Q98hJCp+G3+E9R2mfYg+UPBhtR5lAWzLeu/owxrRhDygzgFXIJcTl/5SW5HDzTISRO
         RfuF1ZkXW6SbXBRKSqbRX/VE3/ts5Z7x0fEBSR58r6iJDSnd5oHDOOdPM8Y1T4kRWkXu
         h1GgdrRmWlQFgIxGWnPDZwUCGYhGWjId1m8JXWJDNdgsS0Ki5O9tCxcyYlPIeUxxnuNE
         bdaDfkFaQw8BUQP73+c8cjL/2R9vO+KmdM+eAXKZsF5TpRrkRmZHGTUyTE0we0lQ6bBW
         FVBb84p7P8U50UAcmorahVUbKKUhWwDX5xpW8IEIxSUtsEvyBMFhGokq74Rq6ar1DO6p
         tQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIt1HRy4wHVF1DrEiDOdXoP0QYW5vU+yAutffG36pXLpC0HNP0vb9etkGIu+XMCPvWudZbHjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwd74eqHnQQruBP17F/LhicEHkKZVZlcYNADKqjc08aAq8/Uz
	CKPLW3IlmzPKFf+zc6W+cF1a9pdPNkMYBKa8N2JV3Uj24eLHcDA/wNK9
X-Gm-Gg: ASbGncsLOmDq152gphOS1qblQbVLZcU1IcmMY2fsCLAlj9XPJ+ULwGoBzMDo/CnhM8h
	6vRmwOT4wM1sj2Wtde4vL63udcNKWO2ggyj6RbJolpmBT6Xl/3FWb5lUEzE5NRRvskMDTufQ2RA
	TnQensClI7b3vNzssGayhBPowoZgXUzgzs2cxLKNnCqSYpjEPi87pXLG9azve/5ODA2mcTezAjq
	ZmFxyKXz7mfhJDQFr8cnxBiH320aie8yc+l1U89Br84Eed0gr8/U3lmTX2o+gVB7cm/0UkEfP9l
	iDU2h28aT8VvcPEltKvVf+4FriYRlBzEf4lS2mjQvk6dyUhrRERTX84jRQfyNGU9qepkSCRh6Dt
	Qc70n5vnUjEOqN30SF3XfUDgkB42VSxtPfiS496M9alCtVgbYBmmVsZ00v23DrjxI4IUgACsdJV
	+H3lkPxejFLFfklN8Ew3iiBUhD8Q+UuQ==
X-Google-Smtp-Source: AGHT+IHItn4s7icuGrWLzo0GYDNZ1tLgQrToLgg9q7HDTX1ld16PDLwn6BncR/yAsJAAE+zCLju5jQ==
X-Received: by 2002:a05:620a:31a5:b0:88d:125f:8b5c with SMTP id af79cd13be357-8b257f76fd0mr1053956585a.88.1762779960211;
        Mon, 10 Nov 2025 05:06:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:d8fa:5eb:c3a1:9f16? ([2620:10d:c091:500::4:ad9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c20cfsm1010519285a.3.2025.11.10.05.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:05:59 -0800 (PST)
Message-ID: <25ebaf18-f009-45de-a3e4-fe440c42ef19@gmail.com>
Date: Mon, 10 Nov 2025 08:05:57 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Manish Chopra <manishc@marvell.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vladimir Oltean <olteanv@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
 <mfuluoi4nebyc4avj52gkfs4nqikn6uwhqnkf4o6xfswtpceuq@zhpokcx6bb6l>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <mfuluoi4nebyc4avj52gkfs4nqikn6uwhqnkf4o6xfswtpceuq@zhpokcx6bb6l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/9/25 5:39 AM, Jiri Pirko wrote:
> Daniel, I asked twice if this could be a non-driver param. Jakub asked
> for clearer definition of this know in that context.
>
> Not sure why you are ignoring this :/
>

My apologies. I think there was a miscommunication. I assumed Jakub's 
question was directed towards you. I have no objection to making it a 
generic param; I will do so in v4. It sounded to me like Jakub was 
wanting more information on what exactly this setting does beyond what I 
was able to provide in the commit message and mlx5 devlink 
documentation. My understanding is that this setting pertains to tx 
csums and how the device expects the driver to prepare partial csums 
when doing tx cso. I don't really know more than that. Especially not 
something like what the FW's role in implementing this is.

