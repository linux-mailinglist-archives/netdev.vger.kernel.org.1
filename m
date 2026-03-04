Return-Path: <netdev+bounces-263651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBBEFG/tp2mWlwAAu9opvQ
	(envelope-from <netdev+bounces-263651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:29:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A11FCA00
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D1CD301A2AA
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABCB3914F7;
	Wed,  4 Mar 2026 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9a/IGhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778A386C09
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612950; cv=none; b=soWS7Sj5sO+FwoTlhicpcM9XuJofaK504v+jPdgBKAYbs8kfU+JR2TtmWyiUmR6ctYcw3HBOAZECnFrZ+BpYskJUGiC/HtdeBl6cb1L4gTTnGjvndzhtw2PQkw5S06yUtgPgR34/slsJVn2jOE8YPme9k/j69y5tjaPY5RmrT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612950; c=relaxed/simple;
	bh=W61KOgJijBTu+KgaDoSnTPcPN7wOVxVekxKvmZ2tA8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8Osxpgn6qZzoSCfmThBnznAK+Y8aTnipuF40bwzmtiHoyoFcn0FgIFg4pWsLYNB/AmYGv8RPQ+zLH5Ncp//Pf7B5dixB9B6C+1OuS/XDZDm1utwaT8KzhD95ytEHFT/yrDYSYGl+OF7N9/O1diVXUbcNJT/yPgPmoupBqdOG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9a/IGhf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b2965d4bso3030593f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772612947; x=1773217747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSKM+6gFf9Fg1BMeTVJ4haJM0Fv9Kx92rGo08mnwG5k=;
        b=K9a/IGhf7C/F1Y6Zu9TyAG6UZawwX0nGBdTeyDeX3DBZlrY8jMuL2i/qgtiO2vUVOC
         K/OFqT9J7n/mnYzLCc2c7Q8XO+LBgaSQXWZjvur2Wlb4RnaDhBz1cjNsLvteq6ymF+5I
         ImTnzpXdtYdK/g9PqO41/kPpt43eh/UjKq4ndOpXRDJep07XTEcfrqbNDUZfBvTiNdc7
         bOd7P+D987XXes8sP8H26AwTphVPN5wyVy9G7F6TP8uEnl0eALbv7FfYZqS74cb+Z2t5
         BnkgDgsuHFVPVWZPaszbrVakQN/Lq5iDJz4IePODoElijX3SlYVzJKEK0qx2zJ7K7wrx
         fTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612947; x=1773217747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSKM+6gFf9Fg1BMeTVJ4haJM0Fv9Kx92rGo08mnwG5k=;
        b=kB3reeVmy+aGkBfYhMzuLLC5Y6zDwV3MBY8YP7sHasru+fNXUGra9vByLNk1+dSA8w
         btmnStejW7sRrICnlFIWjCQRIpTYM9x0YHfaunYUeTkQiKVTCbciFp9RXwTopCM1Jzrr
         yHnhdsNX0hzsTSkVwtQrj8Ko3mi65+etW4n6W8CCYZpKS0kILlcQ1Rk44EH2PqcQed+D
         JERMaP9KTr0zi5Uk0CP6tgSGurevf26sUfgPyJ/QsSGvBvWOi6S6Wszk14MlO4YVFrCq
         KgWt/JmSZdX0OQRV4SlFjtxXbboTOcBTypZI+vl4O6YdrOWB0bgUIy0q86kryqs+/qXr
         uBkA==
X-Forwarded-Encrypted: i=1; AJvYcCUWweizySASd/Ms7fARdjAw3uS2L8HcHuZf8ucdBaiW/Pro1/7kdysYSuI3Dn55MkyxKxYdnTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVani6A98icouW/LijAGsynCy72pddH/rbEhn+r3MMT0XCWB2K
	H+ENOgYpHFILwhmkhP7r2PjRc4kWDfxvy3ZhZD/nNkcm4/pXNeBRuokP
X-Gm-Gg: ATEYQzxd1yvY41nrrE8ml5INgfkVdUyUa6RIVQMfG9FQ0j+h7+pigDduyaNvFZ/tz+e
	We9lDV3JE5tgbJ9xaKENiy2XGRZnemw2gBJ3+IUZ9hL4iDARUQWjjtByRk8bnm6h/p+9X4BogVB
	Ie/ANE2IANMLES5/EkjcdEGjGFoDz0A4XuhMtge7t+9xcJRfqc2BkbHfXfo8NfF13KOQrl+iMhJ
	KKZ19lS800FnHOqzb/a9Ql/lgkyuADM+AC5Yp4UXYNBHL1hYx6xQ/SGYaIxoyzlHaqq1u8rY6Dp
	93BCj1+NZ4hgk3xw52Xs90CjD/fHO2mowTmudjCCcQqVeXVkXlfWw/fSfi7mh1m2/UE0HCTyAVh
	pdu0mNGX8awnVnDcyu8KpRylJgXLxhFbhBGdIxQ37sYNNq1WunA4OJd9Gcd24IsVpTGT/4YSZDi
	ZxP5WDY4LJuzGTHxZ/Vaw3tYEmaPl03W3lYGkreMsq3iLCrsk=
X-Received: by 2002:a05:6000:2c07:b0:439:b7c9:2edb with SMTP id ffacd0b85a97d-439c7fbbc27mr2236706f8f.25.1772612946627;
        Wed, 04 Mar 2026 00:29:06 -0800 (PST)
Received: from [10.125.201.152] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm42507855f8f.3.2026.03.04.00.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:29:05 -0800 (PST)
Message-ID: <639ae63d-dbb0-428f-a13b-4cc354e19566@gmail.com>
Date: Wed, 4 Mar 2026 10:29:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: use flex array for rqns
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260304042042.7822-1-rosenp@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260304042042.7822-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B92A11FCA00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263651-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 04/03/2026 6:20, Rosen Penev wrote:
> Simplifies allocation. Separate kcalloc and kfree not needed anymore.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 

This is not the typical structure that matches the usage of kvzalloc_flex().

I prefer keeping current code, being consistent with other dynamically 
allocated members like rss_vhca_ids.


> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> index 92974b11ec75..fc71dd72938c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
> @@ -16,7 +16,6 @@ struct mlx5e_rx_res {
>   
>   	struct mlx5e_rss *rss[MLX5E_MAX_NUM_RSS];
>   	bool rss_active;
> -	u32 *rss_rqns;
>   	u32 *rss_vhca_ids;
>   	unsigned int rss_nch;
>   
> @@ -29,6 +28,8 @@ struct mlx5e_rx_res {
>   		struct mlx5e_rqt rqt;
>   		struct mlx5e_tir tir;
>   	} ptp;
> +
> +	u32 rss_rqns[];
>   };
>   
>   /* API for rx_res_rss_* */
> @@ -316,7 +317,6 @@ struct mlx5e_rss *mlx5e_rx_res_rss_get(struct mlx5e_rx_res *res, u32 rss_idx)
>   static void mlx5e_rx_res_free(struct mlx5e_rx_res *res)
>   {
>   	kvfree(res->rss_vhca_ids);
> -	kvfree(res->rss_rqns);
>   	kvfree(res);
>   }
>   
> @@ -325,20 +325,13 @@ static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsig
>   {
>   	struct mlx5e_rx_res *rx_res;
>   
> -	rx_res = kvzalloc_obj(*rx_res);
> +	rx_res = kvzalloc_flex(*rx_res, rss_rqns, max_nch, GFP_KERNEL);
>   	if (!rx_res)
>   		return NULL;
>   
> -	rx_res->rss_rqns = kvcalloc(max_nch, sizeof(*rx_res->rss_rqns), GFP_KERNEL);
> -	if (!rx_res->rss_rqns) {
> -		kvfree(rx_res);
> -		return NULL;
> -	}
> -
>   	if (multi_vhca) {
>   		rx_res->rss_vhca_ids = kvcalloc(max_nch, sizeof(*rx_res->rss_vhca_ids), GFP_KERNEL);
>   		if (!rx_res->rss_vhca_ids) {
> -			kvfree(rx_res->rss_rqns);
>   			kvfree(rx_res);
>   			return NULL;
>   		}


