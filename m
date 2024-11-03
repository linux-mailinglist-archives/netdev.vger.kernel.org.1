Return-Path: <netdev+bounces-141352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDF89BA866
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E373428151C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C3718C01B;
	Sun,  3 Nov 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mewEIfEK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4D7494;
	Sun,  3 Nov 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730670872; cv=none; b=kPUknphpkgZB0rzbKKJzq8zH0cy2nyJtjWjvwpRsjSE0Rf+6s5h7Za/J+23a086V6/xUeRYIm+a9AqBHrWIbLAheu8bMv1a2AuYZZ4b4Ppq1+byCzassvryNLfz/ozWUEz1LBSlXXlDzSTKCFRMnlQ6jLIXP/opJIKQ9p7OzL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730670872; c=relaxed/simple;
	bh=v9w0BxpsLDNVbOMlKTirUxvhokjy+UsTVK8rJ2/Y5jM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEakdaAm3sUwiaPh6mDBfrioH4JIv9qfsYcquZ3yJ3jwAO8Lq2BDq01nFcZoj6y3Y1HrOu1qs0g0bKKXO1S0GTO/VDvwOkV7dNSlozP1nvOw5JR9AsiUjUSPchn+Q5rtFMHegl1A/LPaapKcKlE4vxW8vsOR1pIvFkZkI2kj+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mewEIfEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657B2C4CECF;
	Sun,  3 Nov 2024 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730670871;
	bh=v9w0BxpsLDNVbOMlKTirUxvhokjy+UsTVK8rJ2/Y5jM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mewEIfEKvP3WGyLzLY3uE31CS5QORB6FotFSSb/iyU4gFkHNIoD9q7GY7d3UG30Id
	 gRbEvsgBnFk+qcGGzvK4gR2FX0DCEeZb651Ao3BnnFD6xeGmA+TuOsnkEQvEuTv6dr
	 oHayGrC4E/c84sDg2hc4tSuBzAkzm1SUxURWsGTtQ+OnXWiXQnsFImEjUrB+kiR+Nv
	 V752QK/y+lJECavsXkhnqPfSJBArU1Wd3VNYDhv/hmpVhla+8Nk3wwBJpvpE1mdzOw
	 efNeHHkZAw29pgD+LbRs9xIJGiSGtDxTe7t3xdsV/O7gmLYcSdrkVIq7lWF7ItbX+l
	 wt4N2wZxztxSA==
Date: Sun, 3 Nov 2024 13:54:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Jian Shen <shenjian15@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jijie Shao <shaojijie@huawei.com>, Wei Fang
 <wei.fang@nxp.com>, Louis Peens <louis.peens@corigine.com>,
 "justinstitt@google.com" <justinstitt@google.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Hongbo Li <lihongbo22@huawei.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Ahmed Zaki <ahmed.zaki@intel.com>, Arnd
 Bergmann <arnd@arndb.de>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Simon Horman <horms@kernel.org>, Jie Wang <wangjie125@huawei.com>, Peiyang
 Wang <wangpeiyang1@huawei.com>, Hao Lan <lanhao@huawei.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: hisilicon: use ethtool string helpers
Message-ID: <20241103135429.1556ea05@kernel.org>
In-Reply-To: <20241030220746.305924-1-rosenp@gmail.com>
References: <20241030220746.305924-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 15:07:46 -0700 Rosen Penev wrote:
> -static void *hns3_update_strings(u8 *data, const struct hns3_stats *stats,
> -		u32 stat_count, u32 num_tqps, const char *prefix)
> +static void hns3_update_strings(u8 **data, const struct hns3_stats *stats,
> +				u32 stat_count, u32 num_tqps,
> +				const char *prefix)
>  {
>  #define MAX_PREFIX_SIZE (6 + 4)

This define can also go away

> -	u32 size_left;
>  	u32 i, j;
> -	u32 n1;
>  
> -	for (i = 0; i < num_tqps; i++) {
> -		for (j = 0; j < stat_count; j++) {
> -			data[ETH_GSTRING_LEN - 1] = '\0';
> -
> -			/* first, prepend the prefix string */
> -			n1 = scnprintf(data, MAX_PREFIX_SIZE, "%s%u_",
> -				       prefix, i);
> -			size_left = (ETH_GSTRING_LEN - 1) - n1;
> -
> -			/* now, concatenate the stats string to it */
> -			strncat(data, stats[j].stats_string, size_left);
> -			data += ETH_GSTRING_LEN;
> -		}
> -	}
> -
> -	return data;
> +	for (i = 0; i < num_tqps; i++)
> +		for (j = 0; j < stat_count; j++)
> +			ethtool_sprintf(data, "%s%u_%s", prefix, i,
> +					stats[j].stats_string);
>  }
-- 
pw-bot: cr

