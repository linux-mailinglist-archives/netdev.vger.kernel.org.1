Return-Path: <netdev+bounces-258033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJY3DozLimmbNwAAu9opvQ
	(envelope-from <netdev+bounces-258033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 07:09:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE105117479
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 07:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F9093015A77
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1ED2D1911;
	Tue, 10 Feb 2026 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN1q30Lc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986722B5AC
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703749; cv=none; b=I3Hfaw6ghD9jBK7xpefSzn/O6Jub848BHseW5G6/G2uD3n1g75RdAOo3z++LN65DzCYm5ZZFOTjtUirz69IPE+uZ+PpvU9FhC1x1qXPIe//H+VA00jN7zWxll7SkV7mJ/O0wZv4lViLq7GRuEt6ajVFtXCh1QuEBKcSxCO46WVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703749; c=relaxed/simple;
	bh=eyDjIBG7hfEhRuYrIjZHAJ0n1jwhXYzNByFDefcW8b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulH/pRwoJr4Rcr23QODAOcourRbGyaa3MwsgdDfb9FIwdMw62KWqePuRPpYA/6Frqp/5A+gc1th68jVOVAKVKbX6XveT2rJdg22koi/zay9pvzFiGdUvLYMApvO5gmb0BASK2pw7y/EGcN+GQmQQ/aMDYMKNvHFwxP18aK0Pqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN1q30Lc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4362507f0bcso3185365f8f.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770703746; x=1771308546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQ1jQtZTg9NmtE39KxvfhgMIzdFgti3yzkMdp/kLIq0=;
        b=nN1q30Lcz9e3IHQmZ5iKy2lkDK5ziWUd++EguFVcR4tOsFAQLSl+mRJFaA0Gmcivkn
         d6Etfni+07NhnYE+k7joM4pdvGUslITIuR4u6XvZO/bFT+6pRIu8VitEjIJiijxrxsxV
         8/0eWeHFJCiHGIQBk9PVtUquLcPm0hwTBoY+pz8SfcafU5+3kGkweHbJQLOjndQKsXo6
         2xGWUXVlSMM2f7sn23nJrwQLIb6CQNmkjNm0I5CeBluRa2mn3YOC41COLnhntoBda5yI
         S6bt8t1JEdj0U2BUtEdl20/sny3lzesMaahOPBXzKqQ5+5HF57YncPnsV1e0XSspy1mI
         SpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703746; x=1771308546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQ1jQtZTg9NmtE39KxvfhgMIzdFgti3yzkMdp/kLIq0=;
        b=f5ZJAnbUnQL2CDRAp4re3f2GumQDbhZisv8RyeFc7OLpYj+kuEFRLAJaSNRwwHHZGT
         si1F8i2kV/p9S/62EMsOBHWHAmBqk4WvJ8XKA+J16QCd8LIVGZCjgig95e6QdRORIp9d
         Veezz+uO8LXTkkbgNW6vK1eFde9Korveo8cBFu5oyviCA8bE563BANVi6zR8vetxIQNF
         NwrVQgka4HFRbRQXxc9VIl7Ph8vuxk7LkxBmxq97csXGkfANbfHqZQsfmXG8FC5Am6GL
         8KH+ctiM0UusBAAP8M8hVsna1k8eRPXHAEJWlQ9QjnqFuC5XnSYflhwtb7LfOTacHwB8
         1hZg==
X-Forwarded-Encrypted: i=1; AJvYcCWz6hVYao7g0GS49RebLv5ftvmB3wO6diOdPiMa+G161jIA/HXxtp1xINg7AD/+ijtowciFx94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxORZTeZuwGga6yoAoBlC/auJKMyzQbL/FWbU3JrZ21Vu7IP27W
	Cnfq2u+7v9s4pFen3zKA/R0NsJ7Sc6/s30HM2pxyv8tuN6b1wsL4mHrs
X-Gm-Gg: AZuq6aI5BZV/R+cG0a3ThVd8VgyE70N2OoAUeRDNqvUbu9WLAKU3ouvLZMV22ZIGRyu
	xphLFZQEnN3BGgpYDNnw7bFIz4RC6/WZgfQPKWrxPwG8UNgpHRcBh8RH1XoEQVFzS0ra9DuPv7D
	l6jl7OxXN+YaBYcim3Cn1kq1giJdNUtoGyw5vMo+Ioa4yyYdlfWn1XsvTKjtAXJyP31j2STC6zV
	Nbpx5JF0d7p28hEqN5QeWx7Iu7RpAUMHATdf8ZMl1I07BOjpH738u+edUJeYkxOnIROBY2CMQl8
	JguGLn0p26Z/fg922/pK8kmHkMVR13y3RoohpZsiPSJaJ42gu8Y23fQv3GVpcpkFuQaKAP/n6eq
	5nQkBAVjq5jV2Xa340TNbfPTow92dQxzOpLDGWbHbzfGzEwVSl5oySwb3umKkl616SPWRlmxZC6
	OMdxpYWfTqmPQzS29W+iCUltB9aKU1YSNPtAtAENxvYdbIgA==
X-Received: by 2002:a5d:5f92:0:b0:436:339a:9a9f with SMTP id ffacd0b85a97d-43779fe26damr1912794f8f.10.1770703746074;
        Mon, 09 Feb 2026 22:09:06 -0800 (PST)
Received: from [10.221.203.72] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43768d07fa7sm19108386f8f.35.2026.02.09.22.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 22:09:05 -0800 (PST)
Message-ID: <a36c490a-0fcc-4fc5-b73a-6d6e0eba4e70@gmail.com>
Date: Tue, 10 Feb 2026 08:09:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: remove declarations of
 mlx5e_shampo_{fill_umr,dealloc_hd}
To: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258033-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: AE105117479
X-Rspamd-Action: no action



On 06/02/2026 13:18, Simon Horman wrote:
> These functions were recently removed by commit 24cf78c73831
> ("net/mlx5e: SHAMPO, Switch to header memcpy"), however,
> their declarations were left behind.
> 
> This patch removes those declarations.
> 
> Flagged by review-prompts while I was exercising Orc mode locally.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 843f732e4eedb005eba58b9a9ebe48c6703906e5..a7de3a3efc49f6c237ea42b0b932fbe1f5aca847 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -1034,8 +1034,6 @@ void mlx5e_build_ptys2ethtool_map(void);
>   bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
>   					    enum mlx5e_mpwrq_umr_mode umr_mode);
>   
> -void mlx5e_shampo_fill_umr(struct mlx5e_rq *rq, int len);
> -void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq);
>   void mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats);
>   void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s);
>   
> 
> 
> 
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks for your patch.

