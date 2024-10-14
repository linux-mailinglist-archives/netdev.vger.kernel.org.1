Return-Path: <netdev+bounces-135316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A499D875
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B670B2814D2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998411C8FD3;
	Mon, 14 Oct 2024 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+eD+kQ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55B1474A7
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938722; cv=none; b=nre5+W/TSwk6DWBrMaM+LwQzL44+/BQIWd1v17UUdlOeb86cubaYhsPhFUprNMMj4VBryE5l879d49BM77TNrEEuEnnP5rXLMdLKdCNUnaxdLGI3NCqt2Qzyj/iHl4MD5gLpnPifaklRtbtCc7Y3hCLwOpGeeVtuBGJbIU9FZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938722; c=relaxed/simple;
	bh=gtoLWUE36z8fe2xUooCnEKWgc6V3XnT/dxkpt/KMoYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRzCu/FTh65+bsirO1vG5DJij5uYTUi4T/z3dxQnbeIkSEA0RQHGbouF3tcsyT3HJMOIE6EmvWb8Ae2ohIVC4FXmCRtn0OEr02NpjGgAHcgUv50mBVQlMGGADr9UlrV4w54HbnA+Nmp816zyrK8juMGgby+ZJqKpkG2h9xGCDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+eD+kQ/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4311e470fdaso31927705e9.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728938719; x=1729543519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlwZeOuUHFlz7hmxBAx3R1nCNwHCKDeuDK7/Jz6YVus=;
        b=h+eD+kQ/qfBqi4C0WKNLTj74KYTc/eXt6xQcnltxEoSouot/9h70r4tpLcRyRj6aIj
         SYIV3c2Qrg4pZD2FVTa7DZs2dbF0XyKW0tKiQ4ckpCKGyeMlX3zaBeGF+oKldOpm89jG
         f77gzvjF86gwqvn26T6mdoFcRL81DvjKoXDB4vtfi6yYfIqdSp0Ag7NSNVFKwbqRmXAH
         nLRskbbOu4ZEzRruhZ0kkCkqaCcHwrGArNefn47zrcK1Se2Gh2Cfev6EvrZoyv1claTQ
         v38Pl6TdIx7rV4aG1/8SPH81iqGebrZQ2H6xH7ic4yJDRlEEBj2LvbNA3jTn/R9w0Zre
         RVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938719; x=1729543519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlwZeOuUHFlz7hmxBAx3R1nCNwHCKDeuDK7/Jz6YVus=;
        b=eUOdXIxjPxOmB07/q2XPMPiHx3gsXUSqIRZTFPF/VpVOM4ntq+/3gNXZBTztoVbzDB
         krxtPWD/uQ1/ddWpfMMOYf3h0tGSHcmu9lYL1J8R3mRtpG74/4A3aDf+GIHQniHPM25E
         1SnWpef8l5NutcLe1/yXTsEUcfKfItb6lVkJkow/3s1QgXNwrsfvv0hrKSvOt2JZVUFp
         FUvoAXasGNotvBVo78bGAMdLGxpe0DW5kIfY1mDl2nPHPoAHwyaKk4HFtmvMRgQaC+UE
         7FPZSg0bqfu7vXVzCEg3QnP295EQwnmc7vA3U51WWCaFLt3Tyhmndu9vd/LA0zwE7/Nz
         S//Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyI2CZR3Te4dtYUmqNZYUJ3/RPrfiUvajPCaUHkQwq3q4aZnvmbSKFaW9k4qogtjFNb5M7H1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkU96OFx7S8eGNo3kg1BRj8m6+cHdSBLrLOh4hCimYr/zpJ7PW
	EXBSmzglnbDb+EiGLmNFOoIei/dwlehhp1yx+eUdRDG2MxWMrKA+
X-Google-Smtp-Source: AGHT+IEYo86v9X7qGf/TN+mMolhufc9aWpsAoLRNUENv1PswrC7nRbhc1pWjy0AFBQ+cPGABnQxb8g==
X-Received: by 2002:a05:600c:4f0c:b0:42c:b995:20d9 with SMTP id 5b1f17b1804b1-4311df57091mr122903515e9.28.1728938718645;
        Mon, 14 Oct 2024 13:45:18 -0700 (PDT)
Received: from [172.27.21.116] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d885sm166794745e9.46.2024.10.14.13.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 13:45:18 -0700 (PDT)
Message-ID: <98413b2c-b466-444f-8ec0-7bfa96223eb5@gmail.com>
Date: Mon, 14 Oct 2024 23:44:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/15] net/mlx5: Introduce node struct and rename
 group terminology to node
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, cjubran@nvidia.com, cratiu@nvidia.com
References: <20241013064540.170722-1-tariqt@nvidia.com>
 <20241013064540.170722-7-tariqt@nvidia.com>
 <20241014091737.GQ77519@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241014091737.GQ77519@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/10/2024 12:17, Simon Horman wrote:
> On Sun, Oct 13, 2024 at 09:45:31AM +0300, Tariq Toukan wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Introduce the `mlx5_esw_sched_node` struct, consolidating all rate
>> hierarchy related details, including membership and scheduling
>> parameters.
>>
>> Since the group concept aligns with the `mlx5_esw_sched_node`, replace
>> the `mlx5_esw_rate_group` struct with it and rename the "group"
>> terminology to "node" throughout the rate hierarchy.
>>
>> All relevant code paths and structures have been updated to use the
>> "node" terminology accordingly, laying the groundwork for future
>> patches that will unify the handling of different types of members
>> within the rate hierarchy.
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> 
> ...
> 
>> -static struct mlx5_esw_rate_group *
>> -__esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct mlx5_esw_rate_group *parent,
>> -				   struct netlink_ext_ack *extack)
>> +static struct mlx5_esw_sched_node *
>> +__esw_qos_create_vports_rate_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
>> +				  struct netlink_ext_ack *extack)
>>   {
>> -	struct mlx5_esw_rate_group *group;
>> +	struct mlx5_esw_sched_node *node;
>>   	u32 tsar_ix, err;
>>   
>> -	err = esw_qos_create_group_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
>> +	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
>>   	if (err) {
>> -		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
>> +		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
>>   		return ERR_PTR(err);
>>   	}
>>   
>> -	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
>> -	if (!group) {
>> -		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc group failed");
>> +	node = __esw_qos_alloc_rate_node(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
>> +	if (!node) {
>> +		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
>>   		err = -ENOMEM;
>> -		goto err_alloc_group;
>> +		goto err_alloc_node;
> 
> Hi Carolina and Tariq,
> 
> node is NULL here, but will be dereferenced after jumping to err_alloc_node.
> 
> Flagged by Smatch.
> 

Will fix. Thanks.

>>   	}
>>   
>>   	err = esw_qos_normalize_min_rate(esw, extack);
>>   	if (err) {
>> -		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
>> +		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
>>   		goto err_min_rate;
>>   	}
>> -	trace_mlx5_esw_group_qos_create(esw->dev, group, group->tsar_ix);
>> +	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
>>   
>> -	return group;
>> +	return node;
>>   
>>   err_min_rate:
>> -	__esw_qos_free_rate_group(group);
>> -err_alloc_group:
>> +	__esw_qos_free_node(node);
>> +err_alloc_node:
>>   	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
>>   						SCHEDULING_HIERARCHY_E_SWITCH,
>> -						tsar_ix))
>> -		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for group failed");
>> +						node->ix))
>> +		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
>>   	return ERR_PTR(err);
>>   }
> 
> ...
> 


