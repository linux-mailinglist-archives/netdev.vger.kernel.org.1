Return-Path: <netdev+bounces-181546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C770AA85663
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4849D8C5FEF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFD29346B;
	Fri, 11 Apr 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="D2ux74KB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667A28C5D5
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359717; cv=none; b=ZoyOXMYfmx3PyK2D4sbr1/erYba9SEZOn/HIvX3Jahop/ItjRO2RScwxKkAwp+dh6haDPnSDeTPIVYHJeeXIGvinc9/fiWnoiKPIqsrJmdoYVmSOEBKVYc3QkAoqyNea1od2YVPSAjKBcfEBv5IY6PFiZ5zUIwmyZkxlUTdodhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359717; c=relaxed/simple;
	bh=InATcmg1s/dNaLLaE0F4S9eY+JC3BKcWDbIYCuG2SPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1AWhJ1/1KLJIekqfYRRGDClG5KPmIImIbg9OLCzp+P9IV+ZuCdMzdAcnTVmwtTW7WdU97kClAwsQUnlXQo1CmqNTMCFEptt+pTIBTbYR7MN0phcpRalnkAaOm2gzSXMe6XZPXc2+6Jz59VpkaLYYvgtan58WON5jvinUmlNJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=D2ux74KB; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so12954225e9.2
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744359713; x=1744964513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ireW56YowLCLNzvEu46A49BcOt50pU4KjszIoJbYqS8=;
        b=D2ux74KBZaZxK8CcKBa9VrRzhLkSgX+2wVKbwAo4zhcoWQmN9Qeqm3OBVUyUwdXDxO
         BK58h12sGlHKCLMkxRbY2rJ7NIhJeOpwTJDON9RGCtjWQXg+ONJNy6nT5mwvgkIEMnm/
         Dj1+1Ksg2Gt5jLZD+/gsJhZpXuwK4djoNJhC0vCbDqdDCBzLI3ovK+VkMZ/XlR5kcF69
         sl6dgrzly570aKOBlRVK/WSutWzDCps8zDpQacHdwxjkotMyYkb6emI3t8IM/ZiDJdrR
         fEOfSo/1Ev1qkzv+b3ZH8wEN8g5OhsmbjC5g/TpVNj1CmVz6e6FkTL8u+aFybi9qmFCk
         hVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744359713; x=1744964513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ireW56YowLCLNzvEu46A49BcOt50pU4KjszIoJbYqS8=;
        b=OCVM00qpEapoEO1O3LSP3SL9Zb0n/gImpu0fmhbH8tIbNXVqP2k7noUhJHavkQf5Ia
         E7zMD1DeGa1DPzv0GpWNLGQKPMC+BXHLxncs6D7sBUllCbgMyzP1/5HLASdp7ayLv0uQ
         KceS2OHsR3Za97WZbWX6K5ymvuWv4Izui7wkB1k8VCH4oQE+tEJETFnEPIrvxgoofsbM
         SIOt/udJbXOVpNtdP4cgYnBiQHxt9xjTaT5uI1sYLKORlDg+AU5nr4reZOqeXTOSsIPZ
         Osf8pjhcR5J6w8vdBgohXa4RshtQWgWzeL9mAI++RbEkr6c+iyagYGTfrhz8xFt5eqKH
         YV9g==
X-Forwarded-Encrypted: i=1; AJvYcCWBmbzi2qjKzDArWmfBDSbdv22VGH7UnggIcV/4hq9myHXOg+hrW/XeUy7VXpSA+dfzzFMXDp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHsZYmweONWtIrwhWxZ/ORrMykpiTKsxPRnoLkqsrvhOT3t7Q
	16zWnwE2q5c7E67NihB3BBOhdDP4GIHXTApmVW4sb9a/XiM9bxRxKcNFXtvsqgs=
X-Gm-Gg: ASbGnctQ0VLo4a5cbz937W6NGG3flqETmUlFGmlrHYF+lpfu6SWV9uX4ch+tCxfuHCA
	9WjF/c3aKSkymwSMhhkgtqCHIGp8O/CGXL2qP7yZhKBb+AijI7VsHdVmz7e4EjDL5x00NEEG7yF
	biM9/1HYQWrhadWeTQXnv1/7H1co2OjOi4JWa1T0DYf+gHrR/cyRZyTw9QBnexP18u/9R9QsNB4
	YFJyjgcOO3n4lLxXDXzzAme7BHRqkWb7zxR309VpbennpOAQvp3UVmYLr7NxTXApLR5VMNwLOv1
	mRoYB3JLLYAO5n3bXpgRt74qH099c/LS0gozOTFSOK3K5gsDqYeAo6Kne2+li68vD+KtfLk3
X-Google-Smtp-Source: AGHT+IGotTYndKxxRBPkODTTBp8kqXMumoUZ1f5ks6nE/A24ZoJxpiNX7X5C375BG8xh52r3NnJibw==
X-Received: by 2002:a05:600c:1c8e:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-43f3a95dc30mr12595365e9.15.1744359712739;
        Fri, 11 Apr 2025 01:21:52 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44e9b6sm1245274f8f.101.2025.04.11.01.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:21:52 -0700 (PDT)
Message-ID: <c74a1a50-3502-4dd7-a5b9-57a0996e5dfe@blackwall.org>
Date: Fri, 11 Apr 2025 11:21:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/6] xfrm & bonding: Correct use of
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
References: <20250411074958.2858496-1-cratiu@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250411074958.2858496-1-cratiu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 10:49, Cosmin Ratiu wrote:
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
> v2 -> v3:
> Added a comment with locking expectations for real_dev.
> Removed unnecessary bond variable from bond_ipsec_del_sa().
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
>  drivers/net/bonding/bond_main.c               | 119 +++++++++---------
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  20 +--
>  .../inline_crypto/ch_ipsec/chcr_ipsec.c       |  18 ++-
>  .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  41 +++---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  21 ++--
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       |  18 +--
>  .../mellanox/mlx5/core/en_accel/ipsec.c       |  28 ++---
>  .../mellanox/mlx5/core/en_accel/ipsec.h       |   1 +
>  .../net/ethernet/netronome/nfp/crypto/ipsec.c |  11 +-
>  drivers/net/netdevsim/ipsec.c                 |  15 ++-
>  include/linux/netdevice.h                     |  10 +-
>  include/net/xfrm.h                            |  11 ++
>  net/xfrm/xfrm_device.c                        |  13 +-
>  net/xfrm/xfrm_state.c                         |  16 +--
>  15 files changed, 185 insertions(+), 167 deletions(-)
> 

For the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

