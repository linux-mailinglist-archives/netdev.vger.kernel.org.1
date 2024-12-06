Return-Path: <netdev+bounces-149662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600969E6B06
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180DA286AEF
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB11EE010;
	Fri,  6 Dec 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MkXaibff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE11DDA3A
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478520; cv=none; b=tg4R1nqu6peRzwrGaY55ute0lN6JSE3JdicWZHbz49VIRUh6zohqjdVPJjlehGameUsSIzRylXQlTCdaCYQznIeZgmgl/vy5cERjVtMvZgSUTsACniV83KNPrMSR0jGtDzEYTWisth+8BTthimW1ae/7bG/ry1wx+D6ji4VSRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478520; c=relaxed/simple;
	bh=2r8pylXs/Twu58JrlVG7EteCTVgvGwN9RIoZuY7VaOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOtBABSl+uPR/+1em+4D00TA8ZKzGZqL6FQWM6Q36GQfyvvzmfbhUr5+VNG2Utq01hRZgOb+DDNZzrOLC19r9m4c/Pu8m5k2RQbQDR7cD1qxxzJgqk65H9yka/s9I9oTkTZC5/D/lUhTjsgD3BpF4z6LWjjro2glRlfnFixJp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=MkXaibff; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so1136482a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478518; x=1734083318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMK56cZTycgI4vfKzSxxk0iKhdhNGddOzETc8Y9Cd34=;
        b=MkXaibffEDMgMnfXyWZCfH/EKS73ppzD7oJdKgBauiwylAyRYSutS7zslV2KrmjWVY
         5F5HpElHnJWkK22SWb6dR69MN871+AKKrebXVWCGsx1yRd13a62e/mR8logTBTnpmisB
         zTdPDe6NgbF0vYzGWORiaz96gYGH/oHgdBBCGBpRZ68KZ9/ybrZ7Hl+b0Ju7Pf7dOaDa
         XPhnZIivmqO7g58FV3FQPJCAiyhQARdZuuQzKqOfWuDVjdmLDHy0feT3ex0ekQzSI9yK
         KA8DcuIA7tYerte1Ae0gEEejaNLImIXD1/dGw+nQKFOZEFCCGhRnMBXO44oNiCLjJirF
         14iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478518; x=1734083318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMK56cZTycgI4vfKzSxxk0iKhdhNGddOzETc8Y9Cd34=;
        b=cdE+74Vx44zUwhntstMun/iGHoSzE6v5VpRoGvwfoFjlyAGTwLajxrk71QG2tTJ00S
         J1oOWvJthEppjHnPfgrtWqhaQJTnWbh1MvuotwPB6XznoHgP02+gpSgf+Mtesp3//hYl
         1PxsN2/xn4BuG9d5FtrekfhBeLdZ7BfaILgrRDTsuM+B5VpnJfQp2l2iUHnMQwGB51hk
         ZMHG8a2Pk4xFyuI3W0kik8dL1IE2Ph8fmaA31aJKf1FJNT1BWXS7l1BOKL4JlwWo5SY7
         eL+9LT+X22RVj6V4kVOY/+t3PzB5FpCOmB9k58WqMR67FzFAeUxAlccY0lUqTcfG8PXV
         b2DA==
X-Forwarded-Encrypted: i=1; AJvYcCUTctQCJ7ilPeNtrWwuVJ6RrsdiqOWLIAgftCjsnfFB8a6vyD8qJxAzA/NKimD4WiEF7Wl46TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwggtI49zHPAc4rJU59u4x6aGfPBNYJ/0f8lTE0KHdRowBGjEKV
	2bOvvl9OPQZFv9MpA8ELlNlGvNh++p7uExhDT5SOTLUpR9Eyd+mDZsWSu7lgFEE=
X-Gm-Gg: ASbGnct5empDPx/V3O/BLPUnf6A2LH1CR+QUeo4+YVPT0rMBM1E3WTOgSULeYQs39g8
	HsELwlioMk6nnJQhS605QMb6OOCjNXIwYkTR0SOt3xjNkKIv0U+59AqUerFRHENeAUqCABLFx9t
	pnB9xJPEgHYezWfaGDx/kRlld/Z41Lhszn0chXK+pkSAlN2me/tOt/PEK8IFIdxTgwrVbYXPH2t
	QGcVR2FMhANtuprEkmiM3dCydMAw7FgzU+Z06Vfcf57PKtHY+QepfNT
X-Google-Smtp-Source: AGHT+IEQGz4ncGLxW+djEWICPN1ZiR6AxySVCJxhG8ZLE1Sap5DiS8K+atDERjr+4pNjgY4Se81ejA==
X-Received: by 2002:aa7:dac9:0:b0:5d3:cff2:71a9 with SMTP id 4fb4d7f45d1cf-5d3cff28725mr666973a12.33.1733478517702;
        Fri, 06 Dec 2024 01:48:37 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa441sm1893564a12.72.2024.12.06.01.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:48:37 -0800 (PST)
Message-ID: <2d546228-e290-4161-a7cf-227732ab8e73@blackwall.org>
Date: Fri, 6 Dec 2024 11:48:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/11] selftests: net: lib: Add several
 autodefer helpers
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kselftest@vger.kernel.org
References: <cover.1733412063.git.petrm@nvidia.com>
 <add6bcbe30828fd01363266df20c338cf13aaf25.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <add6bcbe30828fd01363266df20c338cf13aaf25.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> Add ip_link_set_addr(), ip_link_set_up(), ip_addr_add() and ip_route_add()
> to the suite of helpers that automatically schedule a corresponding
> cleanup.
> 
> When setting a new MAC, one needs to remember the old address first. Move
> mac_get() from forwarding/ to that end.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Shuah Khan <shuah@kernel.org>
> CC: Benjamin Poirier <bpoirier@nvidia.com>
> CC: Hangbin Liu <liuhangbin@gmail.com>
> CC: Vladimir Oltean <vladimir.oltean@nxp.com>
> CC: linux-kselftest@vger.kernel.org
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


