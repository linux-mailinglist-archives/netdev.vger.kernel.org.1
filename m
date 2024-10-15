Return-Path: <netdev+bounces-135607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9999E592
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21E51C22E9F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FAD1E7661;
	Tue, 15 Oct 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwdUVPUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168A1E764B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991575; cv=none; b=nZ9ndRi280xO/ussgSWP8R987yc/DKIhPJ+3Kt0powOeocmDzbmKSQUAyucxPCbUDdj7A6uOxxU5symH81qFWnTPDxh43DPawQ2IYW43ec7HtmWDTdm9ZK3jcmBnk5KroS3z8EY4cpLaYyg31n0xqVS93e5B6vRtbhBbF8bysS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991575; c=relaxed/simple;
	bh=63xtQQOYr6JT+AUuvH8Uqmj4NX27Tw2xHiweMWlTOF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZWgWw3qAZUA5bEv37o5xrJ4tMF/yIkSBCIBsdJ7lxBbJriEsna8LuHpsVMD+/lOKGXcgNwCQDzVow92VnTCEVPuSZJ6VTcamVw3sRTUR+NdNivHOGlzLpqNh5VY7rYKbR1fvJzdT5lrCDBSGALDdXuWPvosnAqVlhzE+o90r48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwdUVPUs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43123368ea9so27429325e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728991572; x=1729596372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHXeweE6JHcUFPqO8Un8+WVyWXQppoPaA4xEDsAZwwE=;
        b=jwdUVPUsV8+S5DdOURFmCagQy4YplFiUTGnKxu2lwkDUz1wPtga3Sdywp6Wr8nvOtu
         RIppc2ztKIu5BVStrtKBBLe7Dw4wOpAUGfLhJj+G2mUgcdvI62JzDdlvJ9arSXrU0RXs
         A4VH3QIUAfGO82SScbF29FyAqupefkzKpSppVggrf0tAHZ48/6Y5g6zx03b1LgT0WpiA
         HV0xMw/8DRQfy3cIta4Hje/HQHhsG9fyk5a9cuz3P+AxXYlzKyNee87VI0n6lmLikDmb
         idcQlEq0tUGalMn+pNdZm6RwgO/yjg101DQVe9GrdLGg07nCcjX8Q+d5OPfQa/PdfMmO
         FWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991572; x=1729596372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHXeweE6JHcUFPqO8Un8+WVyWXQppoPaA4xEDsAZwwE=;
        b=oNTMymOT1HweeErMUjUe1RhYmCvQlcnrTKYakTxbhatYOptvOpfANMrbTljbQ50O/4
         aLQSIEpufQNDDh//k5H30+DxAgJYUefR+/EgYKX6mPjKuzMhzh6i0iYq8GCdT803zuWb
         u1DSQpQ8PYa9ftH6FCi3wWVjNKTxEtTa/2YCopZtY1By5IoInn9BnhWdhsYoEhdklPMF
         Xo2ZaWI+/mgXrE4Xn/HQE5BjRFuIFmYFh5Kzg2ZwanjIoOWyW/YxxAbk739gycCseB9C
         ffvdWhzcDdPSmndXBKc6HEQCgZCzoIPFRvSTn7rDxV354QDgjiF7o6FO0aUKLy5YIuO9
         zMuw==
X-Forwarded-Encrypted: i=1; AJvYcCV5SbzfI4MuT4MYHD9MLcSF63cjk98WEMLM9Hhs2q7lyoX/hdlCFX9OJVhbipXFwLDnJ/UIUPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4jb5g8orq1eIE/Fd51ohQ9mifBCBW40PH8pkS2VCx2tuc9NC
	xiR4+g6r0+KcAIBpedxs22NozLYhUN+hMjm53mlqRWruMDr42k5o
X-Google-Smtp-Source: AGHT+IG6UKCfVWVozDJMcyqWN14TCPlLe1gdw8doyVlgLxdv3OPo0syVWoYQxXxy4bRT1FKB9c6G2A==
X-Received: by 2002:a05:600c:354e:b0:42f:8267:69e6 with SMTP id 5b1f17b1804b1-431255d4afcmr99714765e9.3.1728991571509;
        Tue, 15 Oct 2024 04:26:11 -0700 (PDT)
Received: from [172.27.21.116] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f569a06sm14973495e9.16.2024.10.15.04.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 04:26:11 -0700 (PDT)
Message-ID: <55da37ab-6a4c-4c9c-b152-461ff75f7f60@gmail.com>
Date: Tue, 15 Oct 2024 14:26:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 09/15] net/mlx5: Remove vport QoS enabled flag
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, cjubran@nvidia.com, cratiu@nvidia.com
References: <20241014205300.193519-1-tariqt@nvidia.com>
 <20241014205300.193519-10-tariqt@nvidia.com>
 <20241015110407.GD569285@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241015110407.GD569285@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/10/2024 14:04, Simon Horman wrote:
> On Mon, Oct 14, 2024 at 11:52:54PM +0300, Tariq Toukan wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Remove the `enabled` flag from the `vport->qos` struct, as QoS now
>> relies solely on the `sched_node` pointer to determine whether QoS
>> features are in use.
>>
>> Currently, the vport `qos` struct consists only of the `sched_node`,
>> introducing an unnecessary two-level reference. However, the qos struct
>> is retained as it will be extended in future patches to support new QoS
>> features.
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 13 ++++++-------
>>   drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 --
>>   2 files changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> 
> ...
> 
>> @@ -933,7 +932,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
>>   	}
>>   
>>   	esw_qos_lock(esw);
>> -	if (!vport->qos.enabled) {
>> +	if (!vport->qos.sched_node) {
>>   		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
>>   		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.sched_node->bw_share, NULL);
> 
> Sorry, another nit from my side:
> 
> If we get here then vport->qos.sched_node is NULL,
> but it is dereferenced on the line above.
> 
> Flagged by Smatch.
> 

I should definitely check why I'm not getting these ones flagged.

Will fix. Thanks.

>>   	} else {
> 
> ...
> 


