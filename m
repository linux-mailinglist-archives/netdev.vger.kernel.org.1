Return-Path: <netdev+bounces-135317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927F999D877
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E940DB21063
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E801A0716;
	Mon, 14 Oct 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPTm6w10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1A1465BD
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938853; cv=none; b=li4SMEc5alJsufWwfM74mJE3A1r4lN5j2JTVeQQZloy7iaVaDoxq5Yjjg+O3jQIk8oOu1aooyhD58J6ADxyOrgmooXOdTg9UwvW7Ro4JsRiWrugdjT5DQgTftuBzOwNt1wM5qfqYcPlajxcCWHVm+8sZUqMyP7u62g9/AM7rmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938853; c=relaxed/simple;
	bh=+7m14B0F1CbBDvzbENzJwxPZxq1S6Un9Pdti9qAYtcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF9zorX/MekSP7GW+n62ORpuDWpyFD7GvpaJmmi8Iop2Ix7lCQ8FYjtv5P+osr2FrDcwLFlGaw0gm/LF3afYdkGXgLeWKZq2QaEjhMOQjh473XD14qhT1ba8domOeOLpu1VFaTYxRKEe3nJe67kRHlLA53jgOEJ3C4EDfPRC7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPTm6w10; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d325beee2so2847116f8f.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728938850; x=1729543650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llKxJFDAoremiOaq2ZbP651Smk/otUQZxK+EYCEACYo=;
        b=hPTm6w10g/gD4jYK05wD8Uxu6dNMn7JLLpjulMJJeP9PgXstsSbp/fSz4nMtzdZluE
         c6NIOnTOAWloU+99QEQgQJyrESBjHB88dqGbvdR8WU0Qukdt3vUJUGLP/xLJkJ8pOszT
         m3E8SCSUArngl6miPoADzeNAxLe8MbFtHm2ZITrxBjZMbgXE/Q6Px08URFACQdfEccfc
         wkRAAeiaqyzgof2dbR98HSxvevHGzCtIUiFLyUexiTSECOVM3Iry9Bj6n+IyzGcU26Av
         o9JI7pAbRK2+7DkcIj0X+EP4Yc9btDGIvswX4GeYMT+p3Ngi8rIiq24gzsOkcRTYuGsR
         gSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938850; x=1729543650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llKxJFDAoremiOaq2ZbP651Smk/otUQZxK+EYCEACYo=;
        b=Pwqxwf1yrInWSFq5UH129Qn5iKjBphfe5w2iQC1hvUkCJFgb6vlqUSa0F14qRUWLeE
         bEPld4BrH97GNbzlIQnJqbplO4NFYbgjG8NUdSMO0rXyjkBIFRmzmFuKNOYqxzxi3dRN
         5aHfszBLgyaFAhp3+AGZ109dvf/x8GXNNi2RLX49PaA8QhYrJYCNvQYnSb+tVgyDfZPH
         SUQfMh6xJKHf82oqbkdTBfd6c5Igwg6TDn2l1U1p2QFaiqETKfCx/YVvIpBMnex8rqRi
         Hdgtb4/wQBDKISNPrR+WxoFncxhJQCiV3mD1mNnGMKoFditU0PjBc8GY9HgAG8SHn6JJ
         nusg==
X-Forwarded-Encrypted: i=1; AJvYcCXwg9SzaOZ24ACAOtat2V0/pO971jIQXyMDVT4NH2jeta7k4V5SroboWURpEsQt/p85CAi8Huk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfArOLGwcBwipYUbq6ohcK4UzRFUIoCtBMbpQBKEaSRWaidlMv
	LYWcAuPizO2i5ET8g2V6XCxB14/vfMYyeb4oUXYE7dsEmWvWxoLN
X-Google-Smtp-Source: AGHT+IFcwOVtoi/JwZrUwxcoJJ4KZjtuuiCxPWkUmUccTD4wR1LFW7CIykeFmi6kQ5lulhvYKgMxzA==
X-Received: by 2002:adf:f304:0:b0:37d:4fb1:4fab with SMTP id ffacd0b85a97d-37d601d21bemr5200282f8f.57.1728938849284;
        Mon, 14 Oct 2024 13:47:29 -0700 (PDT)
Received: from [172.27.21.116] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd03fsm12333765f8f.34.2024.10.14.13.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 13:47:28 -0700 (PDT)
Message-ID: <202a36b6-8940-4d65-8743-4997300aa1c8@gmail.com>
Date: Mon, 14 Oct 2024 23:47:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/15] net/mlx5: Refactor vport QoS to use
 scheduling node structure
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, cjubran@nvidia.com, cratiu@nvidia.com
References: <20241013064540.170722-1-tariqt@nvidia.com>
 <20241013064540.170722-9-tariqt@nvidia.com>
 <20241014093337.GR77519@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241014093337.GR77519@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/10/2024 12:33, Simon Horman wrote:
> On Sun, Oct 13, 2024 at 09:45:33AM +0300, Tariq Toukan wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Refactor the vport QoS structure by moving group membership and
>> scheduling details into the `mlx5_esw_sched_node` structure.
>>
>> This change consolidates the vport into the rate hierarchy by unifying
>> the handling of different types of scheduling element nodes.
>>
>> In addition, add a direct reference to the mlx5_vport within the
>> mlx5_esw_sched_node structure, to ensure that the vport is easily
>> accessible when a scheduling node is associated with a vport.
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> Hi Carolina and Tariq,
> 
> Some minor feedback from my side.
> 
> ...
> 

Hi Simon,
Thanks for your feedback.

>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> 
> ...
> 
>> +struct mlx5_esw_sched_node *
>> +mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
>>   {
>> -	list_del_init(&vport->qos.parent_entry);
>> -	vport->qos.parent = parent;
>> -	list_add_tail(&vport->qos.parent_entry, &parent->children);
>> +	if (!vport->qos.sched_node)
>> +		return 0;
> 
> As the return type of this function is a pointer,
> perhaps returning NULL would be more appropriate.
> 
> ...
> 

Sure. Agree. It was not intended.

>> @@ -718,18 +750,26 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
>>   		return err;
>>   
>>   	err = esw_qos_vport_create_sched_element(vport, esw->qos.node0, max_rate, bw_share,
>> -						 &vport->qos.esw_sched_elem_ix);
>> +						 &sched_elem_ix);
>>   	if (err)
>>   		goto err_out;
>>   
>> -	INIT_LIST_HEAD(&vport->qos.parent_entry);
>> -	esw_qos_vport_set_parent(vport, esw->qos.node0);
>> +	vport->qos.sched_node = __esw_qos_alloc_rate_node(esw, sched_elem_ix, SCHED_NODE_TYPE_VPORT,
>> +							  esw->qos.node0);
>> +	if (!vport->qos.sched_node)
> 
> Should err be set to a negative error value here so that value will be
> returned?
> 

Yes. Will fix.

>> +		goto err_alloc;
>>   
>>   	vport->qos.enabled = true;
>> +	vport->qos.sched_node->vport = vport;
>> +
>>   	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
>>   
>>   	return 0;
>>   
>> +err_alloc:
>> +	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
>> +						SCHEDULING_HIERARCHY_E_SWITCH, sched_elem_ix))
>> +		esw_warn(esw->dev, "E-Switch destroy vport scheduling element failed.\n");
>>   err_out:
>>   	esw_qos_put(esw);
>>   
> 
> ...
> 
>> @@ -746,20 +787,23 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
>>   	esw_qos_lock(esw);
>>   	if (!vport->qos.enabled)
>>   		goto unlock;
>> -	WARN(vport->qos.parent != esw->qos.node0,
>> +	vport_node = vport->qos.sched_node;
>> +	WARN(vport_node->parent != esw->qos.node0,
>>   	     "Disabling QoS on port before detaching it from node");
>>   
>> -	dev = vport->qos.parent->esw->dev;
>> +	trace_mlx5_esw_vport_qos_destroy(dev, vport);
> 
> dev does not appear to be initialised here.
> 

Will fix.

>> +
>> +	dev = vport_node->esw->dev;
>>   	err = mlx5_destroy_scheduling_element_cmd(dev,
>>   						  SCHEDULING_HIERARCHY_E_SWITCH,
>> -						  vport->qos.esw_sched_elem_ix);
>> +						  vport_node->ix);
>>   	if (err)
>>   		esw_warn(dev,
>>   			 "E-Switch destroy vport scheduling element failed (vport=%d,err=%d)\n",
>>   			 vport->vport, err);
>>   
>> +	__esw_qos_free_node(vport_node);
>>   	memset(&vport->qos, 0, sizeof(vport->qos));
>> -	trace_mlx5_esw_vport_qos_destroy(dev, vport);
>>   
>>   	esw_qos_put(esw);
>>   unlock:
> 
> ...
> 


