Return-Path: <netdev+bounces-163657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6234A2B2AC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E6E1885CBC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76851A9B3E;
	Thu,  6 Feb 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFZPPV51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374631A7253
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871473; cv=none; b=S1QzAsBUlg2e/oE/1byVp+UI28aubBdyFYv2WBjuP3FrrpZqc1iSnV89vUGk3UzSSi+Wmlb7zx+c3+cJ3gHzywxuCvJwi7qHzZ6kcUxNqOVhHpVqWtSEM12SFio1mDuMbU7M4MAVWBGbiTQ4EzaIgvounXA5FAScf/0bPhCoIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871473; c=relaxed/simple;
	bh=nUe1tnfu0drpPJm6lIGOlBz6q2WdsdY2xa41ghkCU5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bP3HP3A7YlzlnixPVc28lRbzHFAJxLgExVFKtiLvn/d2qLIwKgfIjmofm5ZJtqTmN1hYi2LMEHffhvXkXIST69E04t4OPoW2MEXkYQsZxtU8krLksUP6oE+HfM8q58IhznMmgYAqinqtEa7MuvCAUGFS+b2pVDlCARQYXJs/y9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFZPPV51; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38daa53a296so651516f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738871470; x=1739476270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/i4SRGgUjEO49ow12gwpW1DZp7r8zGhGKhi0bJteowc=;
        b=gFZPPV518brmho1AAn1kw+JzRPO6DmYfUZ8opzFViA4pPrfsRgV+4/A9/OSnQxqv/F
         Ni92pxQ1Ka9W4SCWXPsrFYcVcPGucDKn/FBLofQ3YcQqAVnutjRgI45IaEgbPg5T+1JW
         lgeEtW3Ez2I8VRe/jqvssD3rEKc1kCIXsYlbUpY+PTW6o8T4ij0NI/DtapxdViG3JYp2
         QO3n83CSBFrUp9t2M0RAOKINRl6b8m7NuFrqpCzucaHxuOtIsuj/p+ZFmbKuKpGfyBeB
         ydlapZA7X8g76h2GabLAe97zNMXtGcgk0sfpF1dkTqQjttRlZxoa2XZYYTQ25voIsAH/
         tP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738871470; x=1739476270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/i4SRGgUjEO49ow12gwpW1DZp7r8zGhGKhi0bJteowc=;
        b=l8nZZAKbiZgFnH2C5K0NCjAiLeDeoAfYMY3o/qZxExIHDhEDdIVsFHTn6wwb+yDl89
         cc12eE2SDBTOOEafdXk0rtU7Drsd0LTM+i+EUezvYq8NCAGto/O0JsGvXQ9sxwBwbduh
         utsq7RTporNYMmvUEFaxfTzcThxIypqeiYowRGKNET82MJH1roThJliZnbsM7PoOcdJh
         sl2iLKWa2uqJc8ImOPqMDrrIAMAPsyTBonfeU65V9VS1hgssFgSiYV58Bcpbk4BpRTj/
         H2QLKZf5CE0IRQLftVa+Xh3Li8FbKMX8CaPjMTi513ZDXgKI3AbCULF9z+nYDXFsM5qO
         MnHg==
X-Gm-Message-State: AOJu0Yz/Q2g+HUVn9UQQ3a4kx96UrJ+Ggdb50Aztfh4zYt6qCv4pXqt0
	Ijm0R4fG1qxm3GOeUSCbFnYL388TxaUsluKff4JOKK8OC6/3Rqd9
X-Gm-Gg: ASbGncvX1AwYLUtLnB9Mmr/2FvW3hyOp4+yFykkkgkgnBtw1ufHnfX+H5ACOkqbqWwZ
	noDawWQ6P0r1HBXwdy9XAbmZBziKQh9q4krdwa5xIyMC7LkEQCP5/0m34B6Dg6qPphwafKxY+5c
	/V8rZvLkk2MH19AwrMPeyR0meMxNWPIALT453ptSzzeYV9LXghw5uFYrDKN/W2H3cnrtDy8Esfx
	/uql0tmkZUjBiqY9k23i7odmgau64tOHSoIxHbCV3c6U2D+NF3gFssCgVGBcyN2KQa0yojf1Rl4
	M37McCEQ71fARXKBIFIou89aNdNOobxNlC1l
X-Google-Smtp-Source: AGHT+IGkAV/WAvCgAWIVkU0xue7zdc9CGcWAuMX83BRBEH4pHDwywezkJeIJV+ktOSZpru+r88+xlA==
X-Received: by 2002:a5d:6d0e:0:b0:38d:b34a:679 with SMTP id ffacd0b85a97d-38dc9373577mr172574f8f.37.1738871470059;
        Thu, 06 Feb 2025 11:51:10 -0800 (PST)
Received: from [172.27.51.105] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc73c2e00sm462403f8f.57.2025.02.06.11.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 11:51:09 -0800 (PST)
Message-ID: <d0f7e1e3-2e30-4d10-9535-cd264dcef5fc@gmail.com>
Date: Thu, 6 Feb 2025 21:50:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] eth: mlx4: don't try to complete XDP frames
 in netpoll
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, tariqt@nvidia.com, hawk@kernel.org
References: <20250205031213.358973-1-kuba@kernel.org>
 <20250205031213.358973-3-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250205031213.358973-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/02/2025 5:12, Jakub Kicinski wrote:
> mlx4 doesn't support xdp xmit

Are you referring to xdp_redirect egress?

mlx4 supports XDP_TX ("bounce"), as well as XDP_DROP, XDP_PASS, and 
XDP_REDIRECT.

 > and wasn't using page pool> until now, so it could run XDP 
completions in netpoll
> (NAPI budget == 0) just fine. Page pool has calling
> context requirements, make sure we don't try to call
> it from what is potentially HW IRQ context.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_tx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> index 1ddb11cb25f9..6e077d202827 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> @@ -450,6 +450,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
>   
>   	if (unlikely(!priv->port_up))
>   		return 0;
> +	if (unlikely(!napi_budget) && cq->type == TX_XDP)
> +		return 0;
>   
>   	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
>   


