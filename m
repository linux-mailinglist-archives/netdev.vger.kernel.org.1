Return-Path: <netdev+bounces-249329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1F9D16BFB
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBA530169B4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 05:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F930DD10;
	Tue, 13 Jan 2026 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUhY7zAC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433C1E9B1C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283604; cv=none; b=oQCg7oXQu7ZxkZvisfbfm7P6qd0qqmhyTASEs+atAwXwATacGXk5KSFGAA/CjkACMZF5oVox6fHI3yMvKbSfzezGEvt9zDMoMdC+EsF2frx+KmgyBzp+bPVbgfJm0+DcMmp3G6oEOglUuCjdpEvKoKKMSRQcc8thfVXMzYYvI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283604; c=relaxed/simple;
	bh=19vdQo6pYfLOqyUW2a2rZf9ayU9mlx5fbadNgHNsOsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpVVaQ2hQ6adZewCzTtpr1pz9yZ3Wjygcl9XszidIkwXA8c+t/BB9LCasYhdFSVZHUbtPNOhQMb/JETzpHV2EGYJ8rQoPNqoMd8UJFb4l7G7EpfVhuB7Vr7A5N58UPB9miLW00OP3gle36WQl8AMchoRBhqWYMsDXPWPmKDbKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUhY7zAC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d256c2e6so3646196f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768283601; x=1768888401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88pm3P6g81XtGnprrTXJfTCXXLwIxJufnowFgUK1NPI=;
        b=CUhY7zACyQqSbtyWkASj38wKtk3Qx+ufSfDyWRcAFPP2aoXqPpf7mPmDlv3/ym436L
         CPEGfO7jpYDy/IXrLBWiQkXujXCK6jlKBzHQu1Bd1/Plvq+RLTWwHU5McINusb9vkn1d
         PLTBDM747TQKhWS8Q95+HLxaJoY1yBf2I7gfRQiUQsf8kGbJoFvdF1bQbsn4tT8UL/mU
         BsWt50uqTYWGmuWmDoIrAXjeMQv1V/DLn4dLe+ft6x9zT/2AGO+pGLcvjcNVgaihGzGd
         fU+/lZbrYsb92JBBf9KywTexTU4CbO91CmMmSY3Re0SFWPA/Z9yYTza5wnW4auYK8/vM
         cZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768283601; x=1768888401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88pm3P6g81XtGnprrTXJfTCXXLwIxJufnowFgUK1NPI=;
        b=HoTJu6XLzC0TI5/FOPq8ksOIuC9P9MH0wxtNE7QYwJZU9eeZKkTTtJg+0lh7ujUNOw
         axiCkGBos8Yi0VB+E9c4Yg17IVvE7xVR1SGfWU2QFBxC4+6vNW5EPiCNElEutqJMHz52
         Sptn52rfy4FGo7g2wB1fikOX7iyOXMfFkuOnvQOHU12urJTF2xP5LPLgnPKYhnjzMYuh
         e7o0GEbCFEaj+JxRUS+28XRe6N6N/Rej42zJ0DA1fjFUP9TRy2ezxnbslLghfINIPrU8
         DzY6FyyfSSTYWtZfsVIEUR2cxjm+9/UMVnI+5f3xjKouG9KgDrGyWtt6Hf+++F4Xan5M
         Z9ZQ==
X-Gm-Message-State: AOJu0YzPwaaJFJJXSWXxMTmUyf4xiGAUfV8KXNZNOlXHxKuWEUY1Uf8k
	4C7yUvNtcwsGdGJ6+cRcaEDpZNijuRWPY7WvtgdQ+xXUWFXygGqaMngr
X-Gm-Gg: AY/fxX4WLLfjEvnKfJsrHXT7SxTDfOrTp7TekOVeWvGofSDj7EZftg3JgEdIIGf7OcC
	2Zu7w45HyngUwVKUwOXmoK107o2gZfHAiV21U2omWvtwB43y/JslAoxfYUUW0nqUFFrob2HivEs
	bOOFaBe9jaMgIW0UjWgEqApHHuQVblO6fxwLPRKyGKccF+K7KT2kbzerj7WpVhB1w3mYmddcPWc
	jjB+N7PjfUIfZ3oqBQp3PxUegXxUu4D6+zMxgSG8PBKOp8x9Yw7XgUAqqMfSPWwoaw2dcv5HISJ
	ldEOmCHzqyf+342Q2Nzca+dalcEfofLXpDUWS63b4KwAlWoGdkmvy1y6G+ni46fLMXFW2OfwXNy
	OaO8BdEwXD3PECUWiUxRIGeREGXWrLwmYEV1syj5bplNXRmqIjcQ+fI+GpiBp3GJT74hwcJLYK7
	CIWSOzQ+6yYGgUyeC/WVTQ8WCtl9pJGOXeigmv3S6laF+xuw==
X-Google-Smtp-Source: AGHT+IF68TWf4Pq2Z9GvExTY2L9ytnAtr4ik5TJl9gx8maZgQ9A4SM9KuPGxVZgVMoqKVWvHWhCqpQ==
X-Received: by 2002:a05:6000:4387:b0:42c:b8fd:21b3 with SMTP id ffacd0b85a97d-432c37a756bmr26203367f8f.57.1768283601377;
        Mon, 12 Jan 2026 21:53:21 -0800 (PST)
Received: from [10.221.200.118] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dfa6dc4esm20377651f8f.23.2026.01.12.21.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 21:53:21 -0800 (PST)
Message-ID: <9c8a5d43-2c1e-4a3b-8708-c92a11ad56ff@gmail.com>
Date: Tue, 13 Jan 2026 07:53:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Fix return type mismatch in
 mlx5_esw_vport_vhca_id()
To: Zeng Chi <zeng_chi911@163.com>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn
References: <20260109090650.1734268-1-zeng_chi911@163.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260109090650.1734268-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/01/2026 11:06, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 

Thanks for your patch.

Please specify target branch.

> The function mlx5_esw_vport_vhca_id() is declared to return bool,
> but returns -EOPNOTSUPP (-45), which is an int error code. This
> causes a signedness bug as reported by smatch.
> 
> This patch fixes this smatch report:
> drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca_id()
> warn: signedness bug returning '(-45)'
> 

Missing Fixes tag.

> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index ad1073f7b79f..e7fe43799b23 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -1009,7 +1009,7 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
>   static inline bool
>   mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>   {
> -	return -EOPNOTSUPP;
> +	return false;
>   }
>   
>   #endif /* CONFIG_MLX5_ESWITCH */


Regards,
Tariq

