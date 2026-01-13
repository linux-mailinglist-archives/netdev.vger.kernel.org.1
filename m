Return-Path: <netdev+bounces-249330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D411FD16C34
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B528030173AE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805535CBA4;
	Tue, 13 Jan 2026 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyQ3nMc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5462F6925
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284534; cv=none; b=sJZmChiAzEzIVndj9ABhgg8GORk9C+mWXYIpS22BiPLpjqVc/kB5T2y0hBXBR38Aa8iQn7Gail2wwKheS04WnjzHGlhqgg/9poh29Ze0dRIYYWF6W++Yebpx7VuQ91A3UVEztBuGVdClfd99icelPD0/OIKSsCl7CrttQaQvmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284534; c=relaxed/simple;
	bh=s+Zptr/HPYKDK7I+WrntNKJrNlP3RpkE+kxChvEy6nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8H2D0sKoBSv9NZkUsPdmc/Vwk2FAWKyaH45bmNwv+X1p03sGWo3T6YyAcSKfPCKxZqJs4cWkS+3FQz9An+xyZagSWTaSKzzX/8J6CFspWbIYjv4ScnGZAjUOjseZLMgvn4L5ZIyyf66H5V78DQq2gADpSO8esMvtWoxpXQte8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyQ3nMc+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso41112885e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 22:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768284531; x=1768889331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9ZSFs1AHwHUdEkUdQBHwokHKh6cloNR08U6DUqtuI0=;
        b=MyQ3nMc+ojltg9/JczXKRJjjnv5NV26iBkoU3YmLbiUrtVVOX3lwyA4KlW1/TsPqrf
         ZOdg0Z1v74vH0Lu4wf1sphvbTqpGDnzOWDwj3PtuQgKkfXdoZqoEaSm7xZE1KPnUo4qB
         BmfpPMpigsnJhgwN3DNblHFFbtH7a8us8o8o9hSpsPYNkVKHOYN6r6QsBavZJb68ha8g
         LhwmmxoOd2M9miemmfJJ1GnmdPWvjTCkDx8RZlsdyVSZ9YndcsQauZBJXzahu3y0Xfgt
         BkbnGwsN+sKFQyz0C/3KwjHvhEV8AblX1h7sszOSbXhywf7U410GQIWdWeVkl6uTWZk3
         P8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768284531; x=1768889331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9ZSFs1AHwHUdEkUdQBHwokHKh6cloNR08U6DUqtuI0=;
        b=vrcfuEsKvmLDlbcRyCO2hlBbxXdyPpoPdBPr/UR6WQluKREKiyTmjaOoZeQwet7LRs
         odbBrQGzpU2GeAXxi/AwYKSkLJngZChrUoSk5JOSCRc85jUZn1UjY3ArRR9Lum3Uco5a
         Ts3H6TW6XkzTrQtwCddws72Mbo4GH9XgjLmOJZcTRq6d1I5JZ2aU447UewZC5CbNROvF
         vO9KGLOF9cr58t3SsnLiUxrcH67sFW17D70Xcd3PSanViwvhCYS2iEFHOFQ9ii4fA7Bm
         D28opJhfA4W0b6E+MTvWs9QvRCjD1mtiUJWPySiSnDfM9L8O7vr2sb5/XGkSatTLVBJW
         QD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUukyZ7nHBh+HRwHq0XA1W6yl9zFHGp4qRT2izlJOJESx8LlHddQEMAh01AJaAuTtPnXUPKAi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfv631QNb2K5EKwdI7nW/2BiOvunyfUGPApyzfJjiw7LB7wvJg
	kxUa5gwstro6pVRk7CWbbgeYYszEJdtci7drjZWvNcGyWA+LDVake3ms
X-Gm-Gg: AY/fxX4RA2rT0SBGXCebMQWE5Lg4R+Eet0ndMP/R4Yt6EfKhZN6zn1Psc4pqogWBF9X
	gAW7CAkzkIB4+wSXiVzv9ctxJbZSA6oaQsbWJudBDtpKr13AdTPCe7Y5TxhOUQgibl8ZkNNsICM
	mcfE/R+b5966Rr/G3ZnUIZ4AXEMl1BGeFdnm+aLhpWT7o52W/KDnDp/dkTQFaiSK1lqqR/A97M+
	yFFkYBb8VO+1dJfCxDmLw27HwbqV3XbcQFIfUNS7jpef4nYJTHos5/ZfLFcW7OGZBoAFkcXLbSc
	7YFaRS0zJUbMnxCqQGPwTf0HSc1PU396uVrMEXpSBh1wrciQ8beqyXrSJh6chThh3NCnHdovnO6
	imEGWmrJeT85kDty17icePmvMPbVWrZ7WHy//G49/AhRD0iktCggI6AJCM1y7iHskRx18m7yrB0
	NB5MDF9OgXVoMhjI+FTNTHuGJQ2rqf0RkzbTIJP/dZ/xLIKQ==
X-Google-Smtp-Source: AGHT+IG15wErQ03UH9DVDeoYCjGbCNvRirkF29C6VV/Z9728PIAUXXm8+rFEeW3TuGRjq5cyJFWLUA==
X-Received: by 2002:a05:600c:45c3:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47d84b3f642mr218415835e9.33.1768284530620;
        Mon, 12 Jan 2026 22:08:50 -0800 (PST)
Received: from [10.221.200.118] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm378935045e9.0.2026.01.12.22.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:08:50 -0800 (PST)
Message-ID: <4261e437-84b2-4d0d-af52-c5ee7fcf07cb@gmail.com>
Date: Tue, 13 Jan 2026 08:08:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/10] mlx5e: Call skb_metadata_set when
 skb->data points past metadata
To: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/01/2026 23:05, Jakub Sitnicki wrote:
> Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.
> 
> Adjust the driver to pull from skb->data before calling skb_metadata_set.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> index 2b05536d564a..20c983c3ce62 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
> @@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
>   	skb_put_data(skb, xdp->data_meta, totallen);
>   
>   	if (metalen) {
> -		skb_metadata_set(skb, metalen);
>   		__skb_pull(skb, metalen);
> +		skb_metadata_set(skb, metalen);
>   	}
>   
>   	return skb;
> 

Patch itself is simple..

I share my concerns about the perf impact of the series idea.
Do you have some working PoC? Please share some perf numbers..


