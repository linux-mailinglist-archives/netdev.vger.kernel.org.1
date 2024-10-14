Return-Path: <netdev+bounces-135314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC95999D84D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30774B21AC2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16E81D12EC;
	Mon, 14 Oct 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f37lIEnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7111C8797
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938123; cv=none; b=SONbhpVMBNhVtUPgV0e3Ocz2TubsNWAkY5BUv8zFv27zMAs1yuHcc/c6mfNymk0IP3xlFxWKCb0o/ZmX5ei+4izZ5I4cIMeH1dJ2j81zoxgX5UQtbGchRn4oETGpldD06c602jvZK6LgxE46hHLJX4qxQgjG4lPzP7bVQ1lBEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938123; c=relaxed/simple;
	bh=jOdS7NuHXuV9W1tFMjeB4EihNVgPlUsS3rAEg58DzqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZTe8gRXb476hqj+cQ9swHxkE3OwqlaxFy18obgG56LqmwjfZvP7VT9CKfBHaOKS553Kwb08IrhxQK/JMFK6DLrOx0K1q5swwd7vW7uwDEYoGQaukKuwZonlf8JB8wN12YTDD8ME6xeIB/djzeLeTi/v5TnQ8uuRI5C3QLdk1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f37lIEnF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4311c575172so35106045e9.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728938120; x=1729542920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnQ1CSPSVsOIfso6CFIhORuwLyAJEounHrmLlYhUU00=;
        b=f37lIEnFbDwznLOYhRub0MkU073Tv0PntYUsga9HuZeK8SIlowf460pFYbOvgPBkki
         gYo7IE+8IgEXYQ0Vmr4RN624gNKJ9kju+CdbUCqwRkUonTdWWQv3k+v5IXifL7OzIJ67
         +DLf5TkTwqS5jAdeYJcgX3qbF4g9NClPUbYaRXTq4mYnzZkEqmS0XS1KGDW/KoEp2EBp
         7iOqGtv9vMCyFrPa6R/kfXtj8vRswl+jh2dO1riGDPls+Hu8TPCJ/35ksg/cnunSduEA
         ftaQ78+9KTWpKFTB2QOMmYyJdHyNVSG+01TnOTM0KnNQwYst/2J7GVTOY+dGvDr9Qfg+
         +2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938120; x=1729542920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnQ1CSPSVsOIfso6CFIhORuwLyAJEounHrmLlYhUU00=;
        b=qW5CgGcEpDRxtcnz37yt4LTFMjni8h0V2vSDZDNtn+xBiw4WUwlbJhQh8tBpjVJpLI
         a/pr3Yl5ZWyrcFELkF2uYY7O+9w7W8jVsRd/ueqTGyapovYcwUuEJijwITAlruaFKXkZ
         6yfpjxIvI+G9wd9jafaqYL0QtOgaX4juUfs+TAw6MmfefOY5YRE3uB/1/MwGo84RIA3I
         0vimXuht1hymB+wLRi3H0Ds7X8nDaQ/s06Tu0W+HGvQ1fYdHEZBNKMz0aerZyO/CmOr4
         DuqO93kRs9dQrz5VWwIJJIdcMGIrqLWFduRLkUdHx8MyE3TWyamGtIRwETtXQdmDV5pO
         PGgg==
X-Forwarded-Encrypted: i=1; AJvYcCVAKj9uerU9fZ/voMyoapILbMKiPNnJeKGmq5DVFbWnt0LRy2E+LfWmMAvMGyq3AAWQ/LoH0+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+/RG8rQCulYVrhb1mvKAqi3/KQu+cGN3I8KBdJYTAucgvCZc
	BePExeiMfP0p6T6p+iv4ucfvDs8ztWyIFe5jmgpDpBzXP9PGzY4P
X-Google-Smtp-Source: AGHT+IG1GPKHBIzVkY/R1pSMRz89894knAasaxaDWZ1XlJu0m1sAXE0tuhs7O84UqfbFEmw8rTsVtQ==
X-Received: by 2002:a05:600c:1f8c:b0:42c:b220:4778 with SMTP id 5b1f17b1804b1-4311df5c639mr111221885e9.33.1728938119924;
        Mon, 14 Oct 2024 13:35:19 -0700 (PDT)
Received: from [172.27.21.116] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b41bfsm162443135e9.29.2024.10.14.13.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 13:35:19 -0700 (PDT)
Message-ID: <eb8df6f1-7b16-4682-b6ef-06a5df133eb0@gmail.com>
Date: Mon, 14 Oct 2024 23:34:59 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] net/mlx5: Refactor QoS group scheduling
 element creation
To: Daniel Machon <daniel.machon@microchip.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, cjubran@nvidia.com, cratiu@nvidia.com
References: <20241013064540.170722-1-tariqt@nvidia.com>
 <20241013064540.170722-2-tariqt@nvidia.com>
 <20241014085446.gjlhbj377nadis55@DEN-DL-M70577>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241014085446.gjlhbj377nadis55@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/10/2024 11:54, Daniel Machon wrote:
> Hi,
> 
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Introduce `esw_qos_create_group_sched_elem` to handle the creation of
>> group scheduling elements for E-Switch QoS, Transmit Scheduling
>> Arbiter (TSAR).
>>
>> This reduces duplication and simplifies code for TSAR setup.
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---

...

>> @@ -496,21 +523,10 @@ static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
>>   static struct mlx5_esw_rate_group *
>>   __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
>>   {
>> -       u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
>>          struct mlx5_esw_rate_group *group;
>> -       int tsar_ix, err;
>> -       void *attr;
>> +       u32 tsar_ix, err;
>>
>> -       MLX5_SET(scheduling_context, tsar_ctx, element_type,
>> -                SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
>> -       MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
>> -                esw->qos.root_tsar_ix);
>> -       attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
>> -       MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
>> -       err = mlx5_create_scheduling_element_cmd(esw->dev,
>> -                                                SCHEDULING_HIERARCHY_E_SWITCH,
>> -                                                tsar_ctx,
>> -                                                &tsar_ix);
>> +       err = esw_qos_create_group_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
> 
> 'err' is now u32 and esw_qos_create_group_sched_elem returns an int -
> is this intentional? the error check should still work though.
> 

will fix.

> 
>>          if (err) {
>>                  NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
>>                  return ERR_PTR(err);
>> @@ -591,32 +607,13 @@ static int __esw_qos_destroy_rate_group(struct mlx5_esw_rate_group *group,
>>
>>   static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
>>   {
>> -       u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
>>          struct mlx5_core_dev *dev = esw->dev;
>> -       void *attr;
>>          int err;
>>
>>          if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
>>                  return -EOPNOTSUPP;
>>
>> -       if (!mlx5_qos_element_type_supported(dev,
>> -                                            SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
>> -                                            SCHEDULING_HIERARCHY_E_SWITCH) ||
>> -           !mlx5_qos_tsar_type_supported(dev,
>> -                                         TSAR_ELEMENT_TSAR_TYPE_DWRR,
>> -                                         SCHEDULING_HIERARCHY_E_SWITCH))
>> -               return -EOPNOTSUPP;
>> -
>> -       MLX5_SET(scheduling_context, tsar_ctx, element_type,
>> -                SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
>> -
>> -       attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
>> -       MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
>> -
>> -       err = mlx5_create_scheduling_element_cmd(dev,
>> -                                                SCHEDULING_HIERARCHY_E_SWITCH,
>> -                                                tsar_ctx,
>> -                                                &esw->qos.root_tsar_ix);
>> +       err = esw_qos_create_group_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);
> 
> Same here.

err is int here.

> 
>>          if (err) {
>>                  esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
>>                  return err;
>> --
>> 2.44.0
>>
>>
> 

Thanks for your comments.

