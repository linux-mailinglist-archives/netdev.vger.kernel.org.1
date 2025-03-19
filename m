Return-Path: <netdev+bounces-176175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C8A69414
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D152D3A326C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97282D78A;
	Wed, 19 Mar 2025 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CIu5eRfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157171ACEAB
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399180; cv=none; b=s5mVhO67b9SZrnZzCYfSy3Mx7gAB1xnu3j1271GrFN4Rmbln9yxUpbLRer82YftVw55LjTHMIfOg/uw8kHrF/K9+a1lsQXZpxPnmpG7tefdk3VWJLXwf37/54PTAfuDiw4sT0wwuOsdoD6ZU0ywMX9Ii+FPi6kqcnuohRJSJfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399180; c=relaxed/simple;
	bh=L7HCyDb7LnNg4J0gRM8YDdC4Vhjc4+Tn+Y4X4SSs7AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oslx6Hwom+lJkYjORa1gH18U/7f16HOA87Nb1vuBptfba/h01cfgTKDK8vli5mlA0Lc2Uc/E/WO/9buR5YnFoXZkm2OvSomQlN+15Wrra0cjzcR/PH4JpLnFDw0sfcvL8l0k5Oj7fAt8Pk4fB2fAhIOMEWZxh9Fv17aHnjmjbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CIu5eRfe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225fbdfc17dso73298795ad.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742399178; x=1743003978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1Scu5tF9VZ9p7nm2nH+so3KyEMESDnhtpEE5G5jj7Y=;
        b=CIu5eRfelaQt8nME4cTf4Cv57vXyO1Il1MJvEVIOOX4J7MladLJjopNgF4sUYqU3lD
         lFO/YdaYr+vKAe9iKq22YDBs2sm+aIydD43HdrFstJ1FvZF6svPu4/E/ugsKfN+EkP7Y
         k63pXVBB+f2AqJ5f2tsfEs20eCmnHn6YN929w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399178; x=1743003978;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1Scu5tF9VZ9p7nm2nH+so3KyEMESDnhtpEE5G5jj7Y=;
        b=Diltx+Jl/w1uSNte3TyaErDL3sKxVJDW42TPX21fHVIdhAuHN5j3rjE41gF6fL/0vG
         lCD5hNlpvjx3yGvkRJ3H4fhtczxzf67QMOM1/6kg8RRL1x24iDXQjJDSSabPmU5rSaTq
         C9gza2Y8M6qlSgGMDJq2jF4edV6nhZA7NiwUamLLALsBA6/BcLIT/CBBj4IfrMN/eSDI
         dpqSOq5EQiwtbBqKru/D4wtP5j5Ds+tft2T++REZOOmpnPKKowAt7RN11dxwpei342/C
         hkbl4ap9kVZKxfz7WYlSTod18OL7y74EcOQFtZV7kGLBBtaO5Ejq75UhIZBKMMRJ2clk
         yB2A==
X-Forwarded-Encrypted: i=1; AJvYcCVaOX3kMJlb4MQUSmQgCfyw2YRUk5Lc9EqRvePJlBNxw6UQardcMXnMxbCescJ7mnB98mKW7Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ54M7mtBweinkvD8jlCBaPTNvSrvKcszTHH4utqiKJJZzo04g
	VRn3w0X4TnO65D4xlLAzKTTY3IccaEN15ZeWYxMpsik6jGaKVk8p9DP9b8bCFew=
X-Gm-Gg: ASbGncvVWkGEZB55118ZQWsCToyYhZHGhgMeYrrpdAt27wGzryWz2EiUVPHVP8VmtB/
	/8Sw7icNtb4aM5joL5SKvimep0dZFKoadxHVV3Su2d60kMa5GRlp6QF6vDTmgDXuPq6/4WoPaNT
	5VPwMPdRJyQizSBCOGN6YKg5Ugqxx5M2qN9jUjhhMXu254OMrdbM1KGTZ30daASk9TZpw9he0Nr
	P+ac7wqisg3kmeImd0Uiie6M33mL7O3nvo92RRpSL7BD7/HmjBUeGgHH8NZNOyfES8/SU103u55
	dWXm0o8CKBCV/h88K1aafBCuiZg95XvUbNHlYBzFmY7NEu8R3fvUWAyMzbeE04giblCRdzBCWIh
	KdgUfeMqLOQx9abf7
X-Google-Smtp-Source: AGHT+IHBKdoUiZMMdG+THH2iq7nGh1pbO/+rlRVDIBUrcNwQMdT8tRT2Ot3Ajrv9hg7zlPC62go/vA==
X-Received: by 2002:a17:902:ce09:b0:220:f7bb:842 with SMTP id d9443c01a7336-22649a7fe13mr45258105ad.42.1742399178250;
        Wed, 19 Mar 2025 08:46:18 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883d0sm115727325ad.10.2025.03.19.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:46:17 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:46:15 -0700
From: Joe Damato <jdamato@fastly.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS
 context
Message-ID: <Z9rmxwUCmqxxTIDw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250319124508.3979818-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319124508.3979818-1-maxim@isovalent.com>

On Wed, Mar 19, 2025 at 02:45:08PM +0200, Maxim Mikityanskiy wrote:
> There commands can be used to add an RSS context and steer some traffic
> into it:
> 
>     # ethtool -X eth0 context new
>     New RSS context is 1
>     # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
>     Added rule with ID 1023
> 
> However, the second command fails with EINVAL on mlx5e:
> 
>     # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
>     rmgr: Cannot insert RX class rule: Invalid argument
>     Cannot insert classification rule
> 
> It happens when flow_get_tirn calls flow_type_to_traffic_type with
> flow_type = IP_USER_FLOW or IPV6_USER_FLOW. That function only handles
> IPV4_FLOW and IPV6_FLOW cases, but unlike all other cases which are
> common for hash and spec, IPv4 and IPv6 defines different contants for
> hash and for spec:
> 
>     #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
>     #define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
>     ...
>     #define	IPV4_USER_FLOW	0x0d	/* spec only (usr_ip4_spec) */
>     #define	IP_USER_FLOW	IPV4_USER_FLOW
>     #define	IPV6_USER_FLOW	0x0e	/* spec only (usr_ip6_spec; nfc only) */
>     #define	IPV4_FLOW	0x10	/* hash only */
>     #define	IPV6_FLOW	0x11	/* hash only */
> 
> Extend the switch in flow_type_to_traffic_type to support both, which
> fixes the failing ethtool -N command with flow-type ip4 or ip6.
> 
> Fixes: 248d3b4c9a39 ("net/mlx5e: Support flow classification into RSS contexts")
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> index 773624bb2c5d..d68230a7b9f4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> @@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
>  	case ESP_V6_FLOW:
>  		return MLX5_TT_IPV6_IPSEC_ESP;
>  	case IPV4_FLOW:
> +	case IP_USER_FLOW:
>  		return MLX5_TT_IPV4;
>  	case IPV6_FLOW:
> +	case IPV6_USER_FLOW:
>  		return MLX5_TT_IPV6;
>  	default:
>  		return -EINVAL;

Good catch.

Reviewed-by: Joe Damato <jdamato@fastly.com>

