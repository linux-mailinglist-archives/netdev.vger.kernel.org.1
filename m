Return-Path: <netdev+bounces-181210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E19CA8417A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B3C441EA4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3AF28134A;
	Thu, 10 Apr 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tnOxydS/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF121ABDF
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283456; cv=none; b=B8staudDlLmS+grSFnL9FRAKN+K+Bf3Q8geVXSG4+GeKyVppfk8taX+RS9qfDBCSp/FJbi/G/TNWZHnWoCP06oiYZgzyu1ICW79DOTW6p4qPwACqpzotq/nR5ZhdsEiWx0WGElvBN49SePgaNsvAQaM+KOp9E4Rz4dUQIRRPJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283456; c=relaxed/simple;
	bh=+e4uZEgvaKhO0stJYuLSFF3XAGqvC9lTsIv+F4Gta5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQFdxy4apXGeVF+t5VVrkYh61wEvIC52aaYrxJ+NnQ8r6LNBBi4Ypw2KPzLaLkwRZ/Q6gBoxpCPOAQlR9tAA3VEzeWmlGRxYfhqkZ8KwWXYnS6WoRxXBxBk449beivvXfXMgpGFdP39lHK1qCp4SFAusWq12ih/dwASB1u795Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=tnOxydS/; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so6112965e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744283453; x=1744888253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zXlC9nBwul2N0yZKb287bMYJF4TW86ravWYsYs27Cg=;
        b=tnOxydS/0D/X95SGC4TYOkrnKM/fvQKCoMyZEOOOE7u4vyhmy7v7aN9Yuj/7kQ+PMm
         kch5ZkpoQMrgijIDs8iVD0hqxDscS317dzG3DZHCPOP2so59vGvU13he7w8sOgARcmgZ
         mNaf6RMKHILPf3XQV7QDH897JTDKOFa4h+FEHSIQUZwXNIocRgTwFxPCsMq4E5rZ7Ajy
         93pts8FRUWpF9nIw68z9MTymPp59acYJYzLH/iGKWdRdhz8VZaJELhfbz3GroB88mm0M
         IhBc+u9qMDwLUaFvn1ExdyZ/KDutpDL48DW9JWGEx6sRbJlBApdUPAY32AXOk36LO41O
         Zxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283453; x=1744888253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zXlC9nBwul2N0yZKb287bMYJF4TW86ravWYsYs27Cg=;
        b=JCdV23uMNt8s6JCzEeDBAD9/bNfy9p3gOo5ulBbHZ0myv3yJdbtwcDrEvF/rJ6aJ+O
         bPCwyz0iiRoyTl5zOKIRdz7ZhxFEVfqdemR9GF2dMm3zu7qGJew/HJRxKzrFClts0WVi
         HGS029/QPX4R13hW7IpHsOplrUBIyEXph5wRBFMXffGm2Bi0xkd+ZW6fC2EV9/BBjlhn
         8N2KpHGjwqlHcuTZyJep+/rjs7Y+x7Pa6utCypjKC27aWbQAfO1f4mHB2kC/6UJqmT7W
         E3hyTg3MMTBC7X7j/GWETxuBXGVZsjr1McJcJcLPDiLba+q+YsMkoTBt1zjJAOof6+jH
         ptjw==
X-Forwarded-Encrypted: i=1; AJvYcCXJJB2qOuuiASNVIcizVhTT4emJRPjdUyBtLon9TxZpYtazwwincS5su70DAuINJxw52IAkiqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXzwdstdCp3qGZpLnxsiIjDPE5tzH9Rf992nX6W1ZP5mkhsQG
	V9wuhmAwjmArUpBy3JOukvRPq3Ia/vsaDsyzFOXOncMzoNtz45mRLTv55cjwHuU=
X-Gm-Gg: ASbGncvqLa8Px6W8sR8wmuP5AxuM7NpxgWPaHrkmRlb3zQlM0/dwucJd/3ZscT5UIzX
	Q357czAtiewmFmV3675yir3HFakS5d86Yitznbz/YUTkc/mRu+JtrzAXTIBLxiyXwQM/+LyegON
	5rGZ/Fx+LBapemduajtaUyLyOBV5F/9Rbsb907NKyF4MlXSSzEDf9dZs/vP49LNsmd0VMtM1GZU
	qRLosWoSzJTym5CoCLS4oMLnwPfWnmfH9W5B6JgmLVnf699GjFZCK1eIseRiVAH8VQ1xqpOiTpR
	5E1LQAJpDEj+C7gs37H7atalruPoNKzH0QKKpiBHSJhgox03LY2TY1G4fyCQonVOP5r4S13E
X-Google-Smtp-Source: AGHT+IF9Hc7Q24zHl7xPZwtzZ5Sgf/XrRL5TMP+ztmFz2QJ9DEFpqqYglIh+Gx6IPi7LxlVpXe0SHQ==
X-Received: by 2002:a05:600c:4e13:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43f2d7b8862mr31752685e9.10.1744283452746;
        Thu, 10 Apr 2025 04:10:52 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2a13sm47242725e9.10.2025.04.10.04.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 04:10:52 -0700 (PDT)
Message-ID: <a7989f85-7699-4b90-9328-9480297a1765@blackwall.org>
Date: Thu, 10 Apr 2025 14:10:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/6] xfrm & bonding: Correct use of
 xso.real_dev
To: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org
Cc: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ayush Sawal <ayush.sawal@chelsio.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Louis Peens <louis.peens@corigine.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-kselftest@vger.kernel.org
References: <20250409144133.2833606-1-cratiu@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250409144133.2833606-1-cratiu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/25 17:41, Cosmin Ratiu wrote:
> This patch series was motivated by fixing a few bugs in the bonding
> driver related to xfrm state migration on device failover.
> 
> struct xfrm_dev_offload has two net_device pointers: dev and real_dev.
> The first one is the device the xfrm_state is offloaded on and the
> second one is used by the bonding driver to manage the underlying device
> xfrm_states are actually offloaded on. When bonding isn't used, the two
> pointers are the same.
> 
> This causes confusion in drivers: Which device pointer should they use?
> If they want to support bonding, they need to only use real_dev and
> never look at dev.
> 
> Furthermore, real_dev is used without proper locking from multiple code
> paths and changing it is dangerous. See commit [1] for example.
> 
> This patch series clears things out by removing all uses of real_dev
> from outside the bonding driver.
> Then, the bonding driver is refactored to fix a couple of long standing
> races and the original bug which motivated this patch series.
> 
> [1] commit f8cde9805981 ("bonding: fix xfrm real_dev null pointer
> dereference")
> 
> v1 -> v2:
> Added missing kdoc for various functions.
> Made bond_ipsec_del_sa() use xso.real_dev instead of curr_active_slave.
> 
> Cosmin Ratiu (6):
> Cleaning up unnecessary uses of xso.real_dev:
>   net/mlx5: Avoid using xso.real_dev unnecessarily
>   xfrm: Use xdo.dev instead of xdo.real_dev
>   xfrm: Remove unneeded device check from validate_xmit_xfrm
> Refactoring device operations to get an explicit device pointer:
>   xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
> Fixing a bonding xfrm state migration bug:
>   bonding: Mark active offloaded xfrm_states
> Fixing long standing races in bonding:
>   bonding: Fix multiple long standing offload races
> 
>  Documentation/networking/xfrm_device.rst      |  10 +-
>  drivers/net/bonding/bond_main.c               | 113 +++++++++---------
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  20 ++--
>  .../inline_crypto/ch_ipsec/chcr_ipsec.c       |  18 ++-
>  .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  41 ++++---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  21 ++--
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       |  18 +--
>  .../mellanox/mlx5/core/en_accel/ipsec.c       |  28 ++---
>  .../mellanox/mlx5/core/en_accel/ipsec.h       |   1 +
>  .../net/ethernet/netronome/nfp/crypto/ipsec.c |  11 +-
>  drivers/net/netdevsim/ipsec.c                 |  15 ++-
>  include/linux/netdevice.h                     |  10 +-
>  include/net/xfrm.h                            |   8 ++
>  net/xfrm/xfrm_device.c                        |  13 +-
>  net/xfrm/xfrm_state.c                         |  16 +--
>  15 files changed, 182 insertions(+), 161 deletions(-)
> 

Thank you for following up on this. It's definitely not getting cleaner with a bond
ptr in xfrm protected by two locks in different drivers, but it should do AFAICT.
In case there is another version I'd add a big comment of the locking expectations
for real_dev, and maybe in the future it can fully move to the bonding as well.

For the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
 Nik


