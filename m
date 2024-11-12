Return-Path: <netdev+bounces-144111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DA9C5A72
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD15B63E3D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5B41FC7F4;
	Tue, 12 Nov 2024 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="w1Uy2kns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA21FBCBC
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419794; cv=none; b=OsGertITUkQeFEyRKsINrPpoIF3kUuIhlx0UIf3/PwQJgUr7CN+zjfKu9/TEQAG5l0equmlOIHA9QGNFsBksHjfpT4qeWcMPXZdaPzYg4a4z3+YPq5PXOuAJUrsyPkYBRfrx9l0h3li3Ntn6JzoRUcKTH6wMXctoUw7Ex4450rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419794; c=relaxed/simple;
	bh=cRevec8e//ikjEHY6w0HeKockRq+RD1uqwsLJQ/2KIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDs9ABkWcn1MSAVvsLJin1kJ7sEWoDo1BBik4OJfaett6i9QXmBxHNhuJeXAIeqivIundeSqBRJ31FFbeVf5xHFeR0K5YG9MosbiZQhV7MruilRScLz7XRskkXKHs4Uzrqe5UrSfxRgq+pklZQeeTSIOO8xPPs/7GPtlgD3zkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=w1Uy2kns; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so46969161fa.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 05:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731419791; x=1732024591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXCHDy2CtTq3ikpCtPUS/yL5SNnsohYV9UYTVkJYPjo=;
        b=w1Uy2knsmIWRvXC5dMn/m+sCPihEHr9PY8/U/3/IX7WA4S+Iw4NwcxJdzKC70XF7eU
         bjzSYUQymf1+mp9KSac1RfmPZTz+9Sdi/V77aACH8LQyiKvTW4DLOV/XHpXTaX0YbwqB
         7daynyTAQYc76aLY/6/rwwSj2fC4KFxC45FvqZsm9RU9ydz6BrPcCUl24frlqJDaTl54
         FVz8DyKp7PL7XHaxUEDXRLIQrJeTidT50kiMVQG6w2sZpY8K8vi+PK+DPA1pKiVHCJDN
         M5fhAjM/q7eRo9KZJcug9U/UXtEFP/5gSS2A9whSfmsZI+N1Guvt/SaKTI6xm5/K2zR6
         qALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419791; x=1732024591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXCHDy2CtTq3ikpCtPUS/yL5SNnsohYV9UYTVkJYPjo=;
        b=PDEq/rIZB/qfDGZoqHHfFX48vVVUlnf3/X3/PxLqLxs80otd3dT/1JBcYibaJuYowt
         3LzzJnluHnRxk1shYXi4AJPIDUX2U+QdmRoPKJfdDJ6p4JGe6DSkMQ3WD+89sp7rMBtM
         qF42JduCmMtPZxQ4B2Wc2ZoAL/4W9/Vyi8NmPqHmCH5KKqPM9vhQ5yTq1/xuc2rPhxbl
         U9q9GRrluGF2qnKJWdLp6Uld+HICGbo9qIjB14GvWnxmxTxgx7j8Nhe4i5GRtmH/EeUb
         t2pvmVdg6PGjagq/mIjNyvJ7rKM5fBN6YbpIb82/HhsUN0CwX9TYn64m3aBnIHYidM7V
         5w7A==
X-Forwarded-Encrypted: i=1; AJvYcCXECo3E+8rEwx/82v8+GV9QLGQOJXluIUe+QtT3ulg4fpHsJxZJOTVe9ZcYVzDbv8mqO8Fp6wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADGLNhzPjFqeSMXkLllyjJD5PP3fByDp7wpjqkNXvR29OG8zy
	XgQpTP1fP5cV3FrZcZAQo8YmB701lXGhhCmbT0oJRgbavpQ/XkSL1QyUV9gXg/0=
X-Google-Smtp-Source: AGHT+IFy5to0zem2CGYWJ4nSEZBhjBFKges/bowKsAqGZ5MejK3x4Ly1MEhGM+xRA91JqWSwPT899g==
X-Received: by 2002:a05:651c:221d:b0:2fb:4d7e:b942 with SMTP id 38308e7fff4ca-2ff2021c20amr72273991fa.10.1731419790579;
        Tue, 12 Nov 2024 05:56:30 -0800 (PST)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179d4b37sm20078811fa.102.2024.11.12.05.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:56:29 -0800 (PST)
Message-ID: <cdebfe36-5306-42c1-aa89-c60b168b2c49@blackwall.org>
Date: Tue, 12 Nov 2024 15:56:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/7] ndo_fdb_add: Add a parameter to report
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
 <2afc1da2e9cd2dc348975b0fe250682e74990719.1731342342.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <2afc1da2e9cd2dc348975b0fe250682e74990719.1731342342.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 19:08, Petr Machata wrote:
> Currently when FDB entries are added to or deleted from a VXLAN netdevice,
> the VXLAN driver emits one notification, including the VXLAN-specific
> attributes. The core however always sends a notification as well, a generic
> one. Thus two notifications are unnecessarily sent for these operations. A
> similar situation comes up with bridge driver, which also emits
> notifications on its own:
> 
>  # ip link add name vx type vxlan id 1000 dstport 4789
>  # bridge monitor fdb &
>  [1] 1981693
>  # bridge fdb add de:ad:be:ef:13:37 dev vx self dst 192.0.2.1
>  de:ad:be:ef:13:37 dev vx dst 192.0.2.1 self permanent
>  de:ad:be:ef:13:37 dev vx self permanent
> 
> In order to prevent this duplicity, add a paremeter to ndo_fdb_add,
> bool *notified. The flag is primed to false, and if the callee sends a
> notification on its own, it sets it to true, thus informing the core that
> it should not generate another notification.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> ---
> 
> Notes:
> CC: Simon Horman <horms@kernel.org>
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
>  drivers/net/ethernet/intel/i40e/i40e_main.c      |  3 ++-
>  drivers/net/ethernet/intel/ice/ice_main.c        |  4 +++-
>  drivers/net/ethernet/intel/igb/igb_main.c        |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 +-
>  drivers/net/ethernet/mscc/ocelot_net.c           |  2 +-
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c |  2 +-
>  drivers/net/macvlan.c                            |  2 +-
>  drivers/net/vxlan/vxlan_core.c                   |  5 ++++-
>  include/linux/netdevice.h                        |  5 ++++-
>  net/bridge/br_fdb.c                              | 12 +++++++-----
>  net/bridge/br_private.h                          |  2 +-
>  net/core/rtnetlink.c                             |  9 ++++++---
>  12 files changed, 32 insertions(+), 18 deletions(-)
> 

LGTM,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



