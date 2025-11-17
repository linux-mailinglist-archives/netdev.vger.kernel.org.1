Return-Path: <netdev+bounces-239111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C22C64169
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 091904EDEA6
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD432D0DB;
	Mon, 17 Nov 2025 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cObxshb/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94432D0DA
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382671; cv=none; b=ORI4hGY2dZ3I7COv/3x3j1l/BNLSxtMqQTFmqlfEkeVIBWlkB6iMkYn0ganTZtg7HE/NhT9HRHXaKBa7dCTxKik4GuIdL24brZB5rzXW1tzNkOcE6la8GYyZQu794Sa4oxRH40ugDqh0zP+EWhJ7LohMdGtR23qQFd5lhOjUx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382671; c=relaxed/simple;
	bh=eZX3VY/wwOhnBkRxrXkAj4ZYfjPMZWso2jVLNleXNjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5Hqoktxlj5Y3taF5+ZtwSxkt7elg1vamlHPhxsYByOJUSFFysVYnOU50l+mFCup/xJN/5XAsL58zpGy9RQmQ3kj0+K5nJfhbXWW9+I9UUlB81wRxicpB7dAOflpqfpPXLvZw4QlJIWBFNO5WEMXrd9w4yP5REM7fcthDa1u9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cObxshb/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so14624845e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 04:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763382668; x=1763987468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9tE4VHTomLTpQ4uC8z4QSbQwAJDgksbr7MPRCjOv8s=;
        b=cObxshb/zWlrC7l8qsdGgV++Gyux2J/uT6WyodKUG/P2G4tL0AtwV+GBJvf6MG6T1e
         wh8jvF4e/ffR1ONVDti0GTOCO9IjS2F8jfBpCUXmqZq3/RT7WECFIZgDsw5dgpSv1gJt
         UGnrvRMERUAjVLg2pIszT4op+stHOTNl9FKBb3RL18SJl/6Yj0V2wdCNT8bIcmS+FQul
         3vnsDIgDsouneyjqNOx4f6TqRWerck8RTCy7u94Dm2ejIghYatjQ6lI3tLuuG4UnFkEI
         YwYCbbB8g0m7j/P9g8efT81S7HJyJEF7Lk98gfml9rgpNw8bt+/xqFxQ/XdtrIi/KQP3
         VYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763382668; x=1763987468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9tE4VHTomLTpQ4uC8z4QSbQwAJDgksbr7MPRCjOv8s=;
        b=LFFTdPoi6cMyV9GHl0deTqryGSlDefOhcH2pBF62P4gln9PsxoS8Rie31/iK+Sqyv1
         B4hlJDPn/XfIfOBX58jUaLUEq5O6/1e91fZcLMnDDN5jIn9cfwfYvkAPOVPDcSIC2l5s
         hOyVO9Y5S2Hg4aDMtGhuYGjDwtDxaK8vj/sfsZBhpShOdlXuElAaUbIWUZWosDBuZGx4
         +6lEdQ13M/S+WbhH0hCadSnt2hItFU2iWrIgx6AT705s7AEL1GTG8HbehVnnEzTjDIBn
         BD4X6tsWVQer7Zu5zBBy33ehJT08m9exN627oOzMvLcrupQUiTFQgXfQPuE14CgV09it
         qzmw==
X-Gm-Message-State: AOJu0YxSwBZGNCZW9D64hwLyMZawikyzuApQPvOmRZv2el4issQQ68rw
	AGNVE1AR/7Fi3bWb09oouT9EgTjbDYfYytnMjuP913e2uINO06HT06HU
X-Gm-Gg: ASbGncuQucG9ItwfjWX49PtDjfvIZ5X7FASB1bOJoWLILMaQKnsgftS3rCn/dmz+kSQ
	GcAvfwilhdtmYlGI92wP/DgBochdN9vXHZPCgFrfUDKZDEg6acLKAi6A+oKRvFC6NRL1bajz6oK
	Fi0RATWEncblVJcrt/zEgbEYKoNYXPEY8hf6hfMV5TaiUtx0AIFqvJl6PEwkUMwwMxNQtbCVRW+
	BcJOae6C6XwQUqyBSQOsGAQNrum/yYZvqyepNpTm85owjVz4QUp/mvD+0aMqshOdQQz0XRx3uow
	ojqIOpBR0H8EYz5NbIj3o2R/m8geSoD35ImDEgZMR47JgNQ+VHqrl68JlVevWEx1W+JzW5FCQzK
	bxZ2YVWLw4TMW4RxrY2SEpAbKIO9uC/cTX3hTqC/yiT5zjIkjCXpYheBPpfHAvYDRuHJtL+Y7Bd
	WbAVyHWahaCyNds36V
X-Google-Smtp-Source: AGHT+IG2sWHMA6qjXeWEG8ifkX2qxcH6n9I6A++NPco79OGgUlbMCsxhZ0kNtfCAgnQ8jL7yVBKhIQ==
X-Received: by 2002:a05:600c:45d5:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-4778fe59054mr117495935e9.14.1763382667815;
        Mon, 17 Nov 2025 04:31:07 -0800 (PST)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6acsm316428125e9.9.2025.11.17.04.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 04:31:06 -0800 (PST)
Message-ID: <56b75450-6c51-44f1-ba7b-92688386c4d5@gmail.com>
Date: Mon, 17 Nov 2025 14:31:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mlx4: extract GRXRINGS from .get_rxnfc
To: Breno Leitao <leitao@debian.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
 <20251113-mlx_grxrings-v1-1-0017f2af7dd0@debian.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251113-mlx_grxrings-v1-1-0017f2af7dd0@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/11/2025 18:46, Breno Leitao wrote:
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
> 
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
> 
> This simplifies the RX ring count retrieval and aligns mlx4 with the new
> ethtool API for querying RX ring parameters. This is compiled tested
> only.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> index a68cd3f0304c..ad6298456639 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> @@ -1727,6 +1727,13 @@ static int mlx4_en_get_num_flows(struct mlx4_en_priv *priv)
>   
>   }
>   
> +static u32 mlx4_en_get_rx_ring_count(struct net_device *dev)
> +{
> +	struct mlx4_en_priv *priv = netdev_priv(dev);
> +
> +	return priv->rx_ring_num;
> +}
> +
>   static int mlx4_en_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
>   			     u32 *rule_locs)
>   {
> @@ -1743,9 +1750,6 @@ static int mlx4_en_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
>   		return -EINVAL;
>   
>   	switch (cmd->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		cmd->data = priv->rx_ring_num;
> -		break;
>   	case ETHTOOL_GRXCLSRLCNT:
>   		cmd->rule_cnt = mlx4_en_get_num_flows(priv);
>   		break;
> @@ -2154,6 +2158,7 @@ const struct ethtool_ops mlx4_en_ethtool_ops = {
>   	.set_ringparam = mlx4_en_set_ringparam,
>   	.get_rxnfc = mlx4_en_get_rxnfc,
>   	.set_rxnfc = mlx4_en_set_rxnfc,
> +	.get_rx_ring_count = mlx4_en_get_rx_ring_count,
>   	.get_rxfh_indir_size = mlx4_en_get_rxfh_indir_size,
>   	.get_rxfh_key_size = mlx4_en_get_rxfh_key_size,
>   	.get_rxfh = mlx4_en_get_rxfh,
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

