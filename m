Return-Path: <netdev+bounces-144112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF959C5C2F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B94DB288A4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C741FBCB4;
	Tue, 12 Nov 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tofzuupw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9B1FBF52
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419813; cv=none; b=Ql+B79QD0HmPrjIm4N+VINyOKJwPjiJ/615mJZGgN1DNUcjRzoWAXg5Zt3pgqnicPqd2Is91KrFjnpA1ldFgNt6c7ivVS7yxQnDVV3l1iMY2GFlfoetE39qTjahKhmGl3yOYb1CHwrq8r+P8kk7avwOOYF5dUWWu9UbMRVA/msY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419813; c=relaxed/simple;
	bh=pkDv1qZhZ720WQ+N9YNVRNgTFRC3x08IFpZ57D13sY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbRERMRVZRvcE4wuLwCMAkqcKqttA9j8mMnHWNTd4i0KMp3WkDOehBAyVMvpyaFChK2tfz//AvVH3rlQPcN0+cSDzhSz+Jq/2IbU3zfQ/PWBCVXDCB5eLJLrz4979M7llaNHVLKUi/xl+NOeP4MwEi0N7eV2goXYrO8qpdrKVo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=tofzuupw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e3f35268so6277350e87.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 05:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731419810; x=1732024610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6GJIfsl8L+Awni2vauytFSpkySMXcNGaJ2BvaXXMQw=;
        b=tofzuupw3xUi5YqJnlGSgEWLOOSF+AobnxqGAWJib6ZtCXZrplc8PLucjkDnV0z/pR
         g/og2GQ28zCYXoz5yK6ooGVw4vQ4KocIbBx4/wxCnAzSwlA6dwlRfdowKr9SU24O1k9T
         WThqHxM4vGfVmiIw92gGsZQJPamWZxwqtDemf+TLp/WOXuLxv1kY/ZPdvNXJEil1D1f6
         wbjvYY7Dc77Z5kmrQ1EBG6CRCJ1hkBK8C/1MerlG+5vpF8LfkcVcLBmEYERQLS4N/ODu
         ofAl1x/rJEaLh4/bdrf+dqsaZnKkJdLzplP3Izmo4uss8mjTQzQ6cSTwjn+4PV96g4Q/
         vBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419810; x=1732024610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6GJIfsl8L+Awni2vauytFSpkySMXcNGaJ2BvaXXMQw=;
        b=OeJG0Hn4aTQYH1LI/bBeZCWk8u0cPXQAz0DIR3Rhw8KQF52KjBbs5gpuoaJp4qE7qK
         JgGwseYmTH7w9VJ1L8vO+S86Z6UL2Xsb9m+P4OXAm77uBHZNpxH7SBKsea801Thzz7oY
         nSYHGsT+bDcCpw+MPfeMwZNogqSkvuS8lvccSWf4Hw/ZbA+FRFkbcsX7FRQkZ6AAEi2p
         +MKufcG9jj0I8orrDnNgAUWCYobY8aH4bYJ36XQK5pZZdJi4OSa5XohQiARYibSiQk06
         XzGmbkGY/UJ0vCMad24IkKSWjkFP1wiLxbs30mttmvItD01T9sMAv4uXoJGdJ7xZck8X
         K5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWeXVGzujoX2G7VWAPnsqOBVUzto0WTxoHBY5+7aRYfbcQwGoAWMylH3zrD640WxBeMedvYOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44obSVROYbOu/k4Mzc8Y+/F+4FBMglk2YE4WOPbzyzSGdpuJe
	PCIbshJ6x71blzwqJVqPwtqBRPyYrYyyNL5Iv+8zOoCvruMJPeayv7mNxIgj+Ag=
X-Google-Smtp-Source: AGHT+IHOF4VYkC1Kg9QmW1uZS8lsVgKoN0pd0sATWDdzVSP/M3Xfx+BY8yEfFd2p1qhzXQFX+yWURg==
X-Received: by 2002:a05:6512:3dac:b0:535:645b:fb33 with SMTP id 2adb3069b0e04-53d862b358cmr8000838e87.2.1731419809953;
        Tue, 12 Nov 2024 05:56:49 -0800 (PST)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82678ec6sm1884152e87.50.2024.11.12.05.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:56:49 -0800 (PST)
Message-ID: <c0bcb7fb-6e52-45af-a115-7d10375047bf@blackwall.org>
Date: Tue, 12 Nov 2024 15:56:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/7] ndo_fdb_del: Add a parameter to report
 whether notification was sent
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Andy Roulin <aroulin@nvidia.com>, mlxsw@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, UNGLinuxDriver@microchip.com,
 Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 bridge@lists.linux.dev
References: <cover.1731342342.git.petrm@nvidia.com>
 <8153c15a3a5d341642e8c176cfb0d32e4be3efeb.1731342342.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8153c15a3a5d341642e8c176cfb0d32e4be3efeb.1731342342.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 19:08, Petr Machata wrote:
> In a similar fashion to ndo_fdb_add, which was covered in the previous
> patch, add the bool *notified argument to ndo_fdb_del. Callees that send a
> notification on their own set the flag to true.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> ---
> 
> Notes:
> CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: intel-wired-lan@lists.osuosl.org
> CC: UNGLinuxDriver@microchip.com
> CC: Manish Chopra <manishc@marvell.com>
> CC: GR-Linux-NIC-Dev@marvell.com
> CC: Kuniyuki Iwashima <kuniyu@amazon.com>
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: Nikolay Aleksandrov <razor@blackwall.org>
> CC: bridge@lists.linux.dev
> 
>  drivers/net/ethernet/intel/ice/ice_main.c        |  4 +++-
>  drivers/net/ethernet/mscc/ocelot_net.c           |  2 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |  2 +-
>  drivers/net/macvlan.c                            |  2 +-
>  drivers/net/vxlan/vxlan_core.c                   |  5 ++++-
>  include/linux/netdevice.h                        |  9 +++++++--
>  net/bridge/br_fdb.c                              | 15 ++++++++-------
>  net/bridge/br_private.h                          |  2 +-
>  net/core/rtnetlink.c                             | 11 ++++++++---
>  9 files changed, 34 insertions(+), 18 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



