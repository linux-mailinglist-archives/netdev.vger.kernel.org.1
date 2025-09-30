Return-Path: <netdev+bounces-227392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE22BAE409
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA99320DEA
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 17:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1826A08A;
	Tue, 30 Sep 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkD2B7BD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7A25334B
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255043; cv=none; b=lDNHD2V6QMB0zNfUdbI16dw9HyeTEyKYyPWey8bQ8ixMEgQ5LikfghTCrz42ZNFvMVHYbxeJWjsZN8bhjvNwFLj7TtmGNAf55QvxY4W8vQAcrVqhqWkh9aPuMbT/J9TQqFNWOzxnUwfdzSlLGPZfj+41D3T6Zh2od6/tYJOLK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255043; c=relaxed/simple;
	bh=Max6oYjp5D3qbRhClZcpeQqxWWduSdPHmYSu58K+hus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgOo4Ke4GD2thtvo0Q8og2UI0KvyGA9cMKzRY1vXa7/Vc5GCkh6hwxq+liciZyBRtsKGsqI3ZaU26GDPKs13zjgkq+bXXu5A7IFl7BmXR/9496K+FMHboQufVOkNWBmZlJqUgqs1NoI0pIq/+Dr21LVOHHz1oVh+QxoV2FZXRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkD2B7BD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e317bc647so40553205e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759255039; x=1759859839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CCkw5Or1/60aBNkinJ1VyW5i1CU/eQk87PDDXRRxyo=;
        b=nkD2B7BDh/vlGQ1MrPvmOQ6JjZ6/e/sZwGoWbUrKMfvCqDeIo5UqEynHMSC3vig3v4
         yxYcQT/nPsgdAgkTLZVL0WABCdpdrP5Iqm49dgWti2MsZMoEzgDav+ZKu5j7if3E+JT1
         ddmc4p1Z5emXkAtO0n1pZt0Wmj13VMv7zjSqn6qiW1EtSaToEhUS+Zjcb0fKno6achbY
         Bsu/olyzcuXTY7hRt3FFr9bDeA3dVeFGPYtC4CkAgBS2vdMdYbzy3PS3Fh/AZwvkCfjv
         9tl9O9D2j4qe/Ydlbo0N4Ex+vIrzgPApj9t3jpNx/pYcRiFeMahJO64UP7/PnAZrIiYa
         +sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759255039; x=1759859839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CCkw5Or1/60aBNkinJ1VyW5i1CU/eQk87PDDXRRxyo=;
        b=wDY6xTodoG+n+4PfpUcw0+GzfVhERFi4aPwvM1eKDRObEGKFtU9An7rN4Su1+uhsAV
         it6iXbbKBBASCiFAYG5IPl3G9/tKWnBPaXxCCgc3RamDMI8yr54/gumVwGhmhhThxfK6
         cLAXSX/yCqqJYk2vOXmwnJzWDmr400KUn5z3ajInbxQsrjxk91gXrRBIMytvqU9JvJZj
         HFTzdpcLmfVC8JuKj/d1bCislxD3A/B/AkJ9ZEzOd391k65cL2Ptaf/5NN8KgTcyr9lt
         yxVfSUYyvlB7BAd91FFPSc7ZPKyxsAne98DC8+ayZTYKVXKnMNzcxKqppoV1X9BmtQcO
         j1vA==
X-Forwarded-Encrypted: i=1; AJvYcCX3NzNQi50JqrSCbqiAvhOCVTLnz5qrqYyIEVyZom0BSVZ6QXNLSRbu+oi75Jnoh2+XQwBSTyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Db+FgWGdQlkFFM3E+Le20oqDzu/kLBuc75IRQvGFXl35NelQ
	zucKqkIfMLD8QvhvF8gVem2jRTmsPZNFmWCvIHURQCY+5T57LC/O1mem
X-Gm-Gg: ASbGncv+Obq5+aD6h04GY6JjzCtk4YAEOuRhwTYasiIxUxjzw3EotAPPE27YWA/DPbc
	vLGpRSeI/GcShgckXXCRZSJMzrdFqnRSr3Dhfpi/MqlOTKMCyxvbq2u26kMCx66x1VDL5rWkhSB
	dWa4dtfDP7Dw6km0idV+v4O5izRlFyTL3gow5ztp4x681M6LOid2hazpt0g1iOfH8b36hGReKaf
	7npgAdXu9M7/gfxLnC65LuVxbMtBh7Z0eNf7m1RV4+/1uqCST2POFjuUVCnoLc0by/kG0v00DrF
	GjPk8eQvFw8wrYUfLEfl9gMC0RID6bpfoc//6Va7rJbH/cN9VgFz8CBdUMUfA9xzu45in1lux8l
	4EfMtcXtpG/3Y48Rv4M1z+M2Pgg2w9vXUXdApWWJWUS7dUxl4mKQdHJYP1A1XXdCCseagvPV69Y
	2Cvltb
X-Google-Smtp-Source: AGHT+IGBw6qgNhEgcsqcE8zCMkDf2TtpGxLfDO0oRgvvd6iJf8l8nQoTud6qKNRaSJSlCEwWdeeWoA==
X-Received: by 2002:a05:600c:348a:b0:46e:3dc3:b645 with SMTP id 5b1f17b1804b1-46e61260525mr6798605e9.3.1759255039290;
        Tue, 30 Sep 2025 10:57:19 -0700 (PDT)
Received: from [10.221.203.31] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89065b5sm23488437f8f.17.2025.09.30.10.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:57:18 -0700 (PDT)
Message-ID: <8b34f81e-86a3-4412-828f-39f0419b98c9@gmail.com>
Date: Tue, 30 Sep 2025 20:57:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx4: prevent potential use after free in
 mlx4_en_do_uc_filter()
To: Dan Carpenter <dan.carpenter@linaro.org>, Yan Burman <yanb@mellanox.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aNvMHX4g8RksFFvV@stanley.mountain>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <aNvMHX4g8RksFFvV@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/09/2025 15:25, Dan Carpenter wrote:
> Print "entry->mac" before freeing "entry".  The "entry" pointer is
> freed with kfree_rcu() so it's unlikely that we would trigger this
> in real life, but it's safer to re-order it.
> 
> Fixes: cc5387f7346a ("net/mlx4_en: Add unicast MAC filtering")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index d2071aff7b8f..308b4458e0d4 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -1180,9 +1180,9 @@ static void mlx4_en_do_uc_filter(struct mlx4_en_priv *priv,
>   				mlx4_unregister_mac(mdev->dev, priv->port, mac);
>   
>   				hlist_del_rcu(&entry->hlist);
> -				kfree_rcu(entry, rcu);
>   				en_dbg(DRV, priv, "Removed MAC %pM on port:%d\n",
>   				       entry->mac, priv->port);
> +				kfree_rcu(entry, rcu);
>   				++removed;
>   			}
>   		}

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.

