Return-Path: <netdev+bounces-84996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40875898E31
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB59E28B0B3
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A3130AD7;
	Thu,  4 Apr 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ZdYoib4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4C12F590
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256258; cv=none; b=WUPYREXArODQYHj6QfUrYozo3bgkzb/WyWZTPqHdEHGmjqvHesLmHQfcelASvtkNA08PI4n9Bb1mb05FCPyMlH9jpzPSsPAqpNUe3Asw0P+uCy59qWH+gMDENprnKDJnqEZBVZwk3YjO8pYNJb7ZqwJU/kVZHeFBbOjv6pYMmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256258; c=relaxed/simple;
	bh=HsPOpo+Xk2IcoOw5CEfqbDCp3sUQgM1R5SrXr8OmdLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOqYulG1Ak7wygUxkqpXxR1WsnF4nGRqaEVOjc01iahYt08wx3hyUhHTjVgc0EhEjVZkFtpRsjG06f4DX5H7phBfNj1eujqt1vLWGs+lee7THmYdmVqmOteyirzGn2A8Gn5uueomdUxcMw9CxDHlY6Bq64bFbQ6QaZA6+tHPBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ZdYoib4q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e27f800ad0so9672775ad.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712256256; x=1712861056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNtJbHvpafpmIUN8pNu/CtUD6SepMG2eb3pflE9huDo=;
        b=ZdYoib4qGk9f3NaVSV2XuwdyGXLFfyBdmwv3S6yzVpdi6vHIlApL9SpeiOOhTjtmrI
         unlCkvOf/WqB+uIiTunK37ZrH45dOz8lloFEr1U9MpbLuXlQyWHvo/1r1yekdhDXTrpS
         q6IkJzDTyzLXjZKgsKwcTMvQtBS+pM0Ggn9c29Dm2YN+L3Ac6TYkd8uQhS0GcCgXSBq6
         9Qp2L9K3tAWMpERiU26GoUcNXaLEvS55W103wEq9KxhQ9Bx3a3WRiVii8cJCaniIHHaX
         4HmwNCZMUHlV+dZUfyOzPrXVtNUJJJMcCOrTo84KA9+pocRt9PYc3e0DE6C28MahY9PS
         LWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712256256; x=1712861056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNtJbHvpafpmIUN8pNu/CtUD6SepMG2eb3pflE9huDo=;
        b=s4Afhq75pND7ZPJMfzsGKO7l1InOfaAlVu5uxw/KMx/IRr9SqDYFgj4GlW5/rxY3oF
         Pl5PVAd3+hcPZ58HNrD7Sr9B0CFOFwy2vI4CWy2F9XU/wQZhHZ84W8fAWZzxeUrP8Tw3
         ZGrMslm8gnp+NtbEqlO7rOVW+WchAIBHWcFNoJWn4H1xXWcxMvgTfajnvD2C/3nY7ggf
         tJpmxH3CqoR0fd4CkIQLQArkISxx37AYz4S/FKhrEue2gXrVG+bf5Ma32pcn48xe9Kfs
         wjkijK2OdsSIBfYnTuWdYRX0qS9zzlj35mxTvzbemjlxS0szpG/qEsWkRJfzGswngWh1
         eBdg==
X-Forwarded-Encrypted: i=1; AJvYcCUu2KItMDHEbjLPfOEtRcbH4ZxiYERoeNKyfu2FS1AlAa2by/B4DBq6416jdCTDPvrBCeqQ8bJGZBOOgee61J3gcKc/xZMB
X-Gm-Message-State: AOJu0YxdBzXdqgYwgse/HOwDqQy8Ojz7795fmylIeKMBgqQHQmgl9hWh
	P4EYiqMvvcefWALu1EZu5kJKvI0ev9EFGaHmUSAAhZj2eszg6X4/7RzQWeyNYjg=
X-Google-Smtp-Source: AGHT+IEXKm/7RIU4s3MMLCsdLTzlchxh+5Jxvev26IZQbr53eItiG+I1Dx1dMoKHuPLPXGvm2bTgRg==
X-Received: by 2002:a17:903:11c9:b0:1e0:cd8a:58c with SMTP id q9-20020a17090311c900b001e0cd8a058cmr3338132plh.1.1712256255614;
        Thu, 04 Apr 2024 11:44:15 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::6:7e1f])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709027b9400b001dca3a65200sm15842182pll.228.2024.04.04.11.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:44:15 -0700 (PDT)
Message-ID: <31999fb9-2a00-44e6-8cf9-5a904d6035ce@davidwei.uk>
Date: Thu, 4 Apr 2024 11:44:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 2/2] mlx5/core: Support max_io_eqs for a function
Content-Language: en-GB
To: Parav Pandit <parav@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
 "jiri@resnulli.us" <jiri@resnulli.us>, Shay Drori <shayd@nvidia.com>,
 Dan Jurgens <danielj@nvidia.com>, Dima Chumak <dchumak@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20240403174133.37587-1-parav@nvidia.com>
 <20240403174133.37587-3-parav@nvidia.com>
 <fae76581-bb19-43dd-a770-9a72a89e95ba@davidwei.uk>
 <PH0PR12MB54816646A6CD3D241797CB25DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <PH0PR12MB54816646A6CD3D241797CB25DC3C2@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-04 11:05, Parav Pandit wrote:
> 
> 
>> From: David Wei <dw@davidwei.uk>
>> Sent: Thursday, April 4, 2024 10:27 PM
>>
>> On 2024-04-03 10:41, Parav Pandit wrote:
>>> Implement get and set for the maximum IO event queues for SF and VF.
>>> This enables administrator on the hypervisor to control the maximum IO
>>> event queues which are typically used to derive the maximum and
>>> default number of net device channels or rdma device completion vectors.
>>>
>>> Reviewed-by: Shay Drory <shayd@nvidia.com>
>>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>>> ---
>>> changelog:
>>> v2->v3:
>>> - limited to 80 chars per line in devlink
>>> - fixed comments from Jakub in mlx5 driver to fix missing mutex unlock
>>>   on error path
>>> v1->v2:
>>> - fixed comments from Kalesh
>>> - fixed missing kfree in get call
>>> - returning error code for get cmd failure
>>> - fixed error msg copy paste error in set on cmd failure
>>> - limited code to 80 chars limit
>>> - fixed set function variables for reverse christmas tree
>>> ---
>>>  .../mellanox/mlx5/core/esw/devlink_port.c     |  4 +
>>>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
>>>  .../mellanox/mlx5/core/eswitch_offloads.c     | 97 +++++++++++++++++++
>>>  3 files changed, 108 insertions(+)
>>>
>>> diff --git
>>> a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
>>> b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
>>> index d8e739cbcbce..f8869c9b6802 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
>>> @@ -98,6 +98,8 @@ static const struct devlink_port_ops
>> mlx5_esw_pf_vf_dl_port_ops = {
>>>  	.port_fn_ipsec_packet_get =
>> mlx5_devlink_port_fn_ipsec_packet_get,
>>>  	.port_fn_ipsec_packet_set =
>> mlx5_devlink_port_fn_ipsec_packet_set,
>>>  #endif /* CONFIG_XFRM_OFFLOAD */
>>> +	.port_fn_max_io_eqs_get = mlx5_devlink_port_fn_max_io_eqs_get,
>>> +	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
>>>  };
>>>
>>>  static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct
>>> mlx5_eswitch *esw, @@ -143,6 +145,8 @@ static const struct
>> devlink_port_ops mlx5_esw_dl_sf_port_ops = {
>>>  	.port_fn_state_get = mlx5_devlink_sf_port_fn_state_get,
>>>  	.port_fn_state_set = mlx5_devlink_sf_port_fn_state_set,
>>>  #endif
>>> +	.port_fn_max_io_eqs_get = mlx5_devlink_port_fn_max_io_eqs_get,
>>> +	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
>>>  };
>>>
>>>  int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw,
>>> struct mlx5_vport *vport) diff --git
>>> a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
>>> b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
>>> index 349e28a6dd8d..50ce1ea20dd4 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
>>> @@ -573,6 +573,13 @@ int mlx5_devlink_port_fn_ipsec_packet_get(struct
>>> devlink_port *port, bool *is_en  int
>> mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port, bool
>> enable,
>>>  					  struct netlink_ext_ack *extack);
>> #endif /*
>>> CONFIG_XFRM_OFFLOAD */
>>> +int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port,
>>> +					u32 *max_io_eqs,
>>> +					struct netlink_ext_ack *extack); int
>>> +mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port,
>>> +					u32 max_io_eqs,
>>> +					struct netlink_ext_ack *extack);
>>> +
>>>  void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8
>>> rep_type);
>>>
>>>  int __mlx5_eswitch_set_vport_vlan(struct mlx5_eswitch *esw, diff
>>> --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>>> b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>>> index baaae628b0a0..2ad50634b401 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>>> @@ -66,6 +66,8 @@
>>>
>>>  #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
>>>
>>> +#define MLX5_ESW_MAX_CTRL_EQS 4
>>> +
>>>  static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
>>>  	.max_fte = MLX5_ESW_VPORT_TBL_SIZE,
>>>  	.max_num_groups = MLX5_ESW_VPORT_TBL_NUM_GROUPS, @@ -
>> 4557,3 +4559,98
>>> @@ int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port,
>>>  	return err;
>>>  }
>>>  #endif /* CONFIG_XFRM_OFFLOAD */
>>> +
>>> +int
>>> +mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32
>> *max_io_eqs,
>>> +				    struct netlink_ext_ack *extack) {
>>> +	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
>>> +	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
>>> +	u16 vport_num = vport->vport;
>>> +	struct mlx5_eswitch *esw;
>>> +	void *query_ctx;
>>> +	void *hca_caps;
>>> +	u32 max_eqs;
>>> +	int err;
>>> +
>>> +	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
>>> +	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
>>> +		NL_SET_ERR_MSG_MOD(extack,
>>> +				   "Device doesn't support VHCA
>> management");
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
>>> +	if (!query_ctx)
>>> +		return -ENOMEM;
>>> +
>>> +	mutex_lock(&esw->state_lock);
>>> +	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num,
>> query_ctx,
>>> +					    MLX5_CAP_GENERAL);
>>> +	if (err) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
>>> +		goto out;
>>> +	}
>>> +
>>> +	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx,
>> capability);
>>> +	max_eqs = MLX5_GET(cmd_hca_cap, hca_caps, max_num_eqs);
>>> +	if (max_eqs < MLX5_ESW_MAX_CTRL_EQS)
>>> +		*max_io_eqs = 0;
>>> +	else
>>> +		*max_io_eqs = max_eqs - MLX5_ESW_MAX_CTRL_EQS;
>>> +out:
>>> +	mutex_unlock(&esw->state_lock);
>>> +	kfree(query_ctx);
>>> +	return err;
>>> +}
>>> +
>>> +int
>>> +mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32
>> max_io_eqs,
>>> +				    struct netlink_ext_ack *extack) {
>>> +	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
>>> +	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
>>> +	u16 max_eqs = max_io_eqs + MLX5_ESW_MAX_CTRL_EQS;
>>> +	u16 vport_num = vport->vport;
>>> +	struct mlx5_eswitch *esw;
>>> +	void *query_ctx;
>>> +	void *hca_caps;
>>> +	int err;
>>> +
>>> +	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
>>> +	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
>>> +		NL_SET_ERR_MSG_MOD(extack,
>>> +				   "Device doesn't support VHCA
>> management");
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	if (max_io_eqs + MLX5_ESW_MAX_CTRL_EQS > USHRT_MAX) {
>>
>> nit: this is the same as max_eqs
>>
> Yes.
> max_eqs may overflow and we may miss the overflow check by reusing max_eqs.
> Above if condition avoids that bug.

Thanks, I missed that max_io_eqs is u32.

> That reminds me that I can replace above max_eqs line and this with check_add_overflow() and store the result in max_io_eqs.
> And save one line. :)
> 
> Shall I resend with this change?
Yes that sounds good, thank you.

> 
>>> +		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of
>> range");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
>>> +	if (!query_ctx)
>>> +		return -ENOMEM;
>>> +
>>> +	mutex_lock(&esw->state_lock);
>>> +	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num,
>> query_ctx,
>>> +					    MLX5_CAP_GENERAL);
>>> +	if (err) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
>>> +		goto out;
>>> +	}
>>> +
>>> +	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx,
>> capability);
>>> +	MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
>>> +
>>> +	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps,
>> vport_num,
>>> +
>> MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
>>> +	if (err)
>>> +		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
>>> +
>>> +out:
>>> +	mutex_unlock(&esw->state_lock);
>>> +	kfree(query_ctx);
>>> +	return err;
>>> +}

