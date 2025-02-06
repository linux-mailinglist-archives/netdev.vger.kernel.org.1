Return-Path: <netdev+bounces-163566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D23A2AB93
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D3D3A8A2F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C123643B;
	Thu,  6 Feb 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yxb82rKu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7423642F
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852704; cv=none; b=AlWWGMssYDsNebld4X8Bh1HgAuVOtpLandI/RLnUqrac9lT+0KNNqchcXFn/77ZtTff5QVr1Wc2cR+BALpAzbVBy6fkeZhlW2SqV10nr6xVCjMNCst9EVFwe+S++epaqbdCEJNpmdVmcTHH5ly+YrbUOgvGAeHpWwtFSxJVjKCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852704; c=relaxed/simple;
	bh=wQw2TdeuTizcqF3Q9lrwzFprE3cAuiPJ1x44hiY1wKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbTJM/GQyZmfm/g9JkaptuMSG6zI+vtyUPI3Bkyrv+yaR89R5jU0XWbWObhCOw9+BY5l+ujjOzoaS/SfgeYlB+I26+dWXEwq81NeOwno/4sakGZKJCZTmemgfjySCwJGzUN15AS0wLqUSyW0SmLVDOaWOXMPxF7sNMWoOcxPDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yxb82rKu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab69bba49e2so144641666b.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852700; x=1739457500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGl8f7Yf7qIHwGS9qrFDj3Wy7/eEHYp4eEWPnG5nI64=;
        b=yxb82rKu7CGO8G07j/nAb1pq0YotoiKsSjDIi2m6WtE2gsVSmYeofNivkzv/ed/QyN
         6u0KAfju5eoAdlVjIAxZ2H4NBfVy4ZoOn1r8+ufYb12uRJY8ZER7DB2tfI33M5934ULa
         w5sWx5OQC/QRdHQMVxbssiGkuZR/916UrR03G9M4Diz5oG/H6qdoIxKifH74XzyWl31B
         P8fPQOgV1y9unbfi3N5pV9lTUynGDSofFaC2XAfZyg1zLbb7XjN5pDA8BuN5UZNV9WV2
         1c5JhseQIEaPvM0ES7qm07gT+SvcOYbcXRQfNZSkowtyXOOL9O+sklVTQbbnpUg5/L1C
         wBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852700; x=1739457500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGl8f7Yf7qIHwGS9qrFDj3Wy7/eEHYp4eEWPnG5nI64=;
        b=JF7nhY/WnrR8qCSFmQKns0BVVer7neWrgteS5mDMpDTDt4QwhHeo5ovSQOw1w0aD66
         P2ih8PupBlgfcNDrZ1WOTpHVQBY0nap8qyNbMlgE8jldkPUTMvpFE9ymRJmVV3kWksRC
         UiCiWBmKAUcPw3P+/j9q0OP2ooeOPjqHD/PmiEZoEvzKA1IIRZDFKtptvNTrybF8kyor
         grOXIFcBdhOKeeSV6sFtabFNphOtPd+I2YDcaTyZfedGVpCHpl3QlSupJoY8/GjNDqco
         YcKJhkn0oPqNmKXMB+6B/o6lu28FWu0tDd+x2C5w7PVUbmOVjtv1kX/Gy/4lirPEztBA
         6K2A==
X-Gm-Message-State: AOJu0Yx45m+oN7+pLWC5t+xo3E63OPCQezEJhKfp9x+kgT/L4hfuBNz6
	DNMw5uU1YH/Lxfl7SfCn0sHzSEbBVCu0yz2uJGOr1kO6d4uqizQmNncbvomU6sY=
X-Gm-Gg: ASbGncsmkoOvEa7G53Yq22CqZivfyIq1tZAsD6KX5ZWJv1JtWgAihZSPocixQX1qz94
	/05Z3jRH0H1QSPigj2IQFR4uqY+XKUjMCDXcq5VUAio8AV167OI3m1s5e/8I85eFx2ZIkM+jzWJ
	TxFSpoWVL6g0L/U5ARp7tzYzFHa/zGX5HsTKiTUU6uZZOd0Wi/Tlq8Ox8nSpQQ6afSF7GDmn3rY
	P/fwPbJV/qHxUgZy93wOsPAT+jNd1zwZipcR+D5AgGPtV+dEavjBVVvR5ijUVteHYB9x1KvsQ74
	RyTLd2G+8wpTd5aZqUJWYU9/befVotPnTrgQSAYXwE1uDNo=
X-Google-Smtp-Source: AGHT+IHtlKzpr7zCul0guNkxORZKS7E5zmeQUNtvu4QsPr2PA2enKb+nYgF0UWob2xBe5euOje74bg==
X-Received: by 2002:a05:6402:35c8:b0:5dc:89e0:8ea5 with SMTP id 4fb4d7f45d1cf-5dcdb6f9f8cmr18518934a12.3.1738852700066;
        Thu, 06 Feb 2025 06:38:20 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e7120sm108661666b.91.2025.02.06.06.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:38:19 -0800 (PST)
Message-ID: <568586b4-aeb4-43b8-b645-a2a0517e3fc7@blackwall.org>
Date: Thu, 6 Feb 2025 16:38:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 01/14] netfilter: nf_flow_table_offload: Add
 nf_flow_encap_push() for xmit direct
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-2-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> Loosely based on wenxu's patches:
> 
> "nf_flow_table_offload: offload the vlan/PPPoE encap in the flowtable".
> 
> Fixed double vlan and pppoe packets, almost entirely rewriting the patch.
> 
> After this patch, it is possible to transmit packets in the fastpath with
> outgoing encaps, without using vlan- and/or pppoe-devices.
> 
> This makes it possible to use more different kinds of network setups.
> For example, when bridge tagging is used to egress vlan tagged
> packets using the forward fastpath. Another example is passing 802.1q
> tagged packets through a bridge using the bridge fastpath.
> 
> This also makes the software fastpath process more similar to the
> hardware offloaded fastpath process, where encaps are also pushed.
> 
> After applying this patch, always info->outdev = info->hw_outdev,
> so the netfilter code can be further cleaned up by removing:
>  * hw_outdev from struct nft_forward_info
>  * out.hw_ifindex from struct nf_flow_route
>  * out.hw_ifidx from struct flow_offload_tuple
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nf_flow_table_ip.c | 96 +++++++++++++++++++++++++++++++-
>  net/netfilter/nft_flow_offload.c |  6 +-
>  2 files changed, 96 insertions(+), 6 deletions(-)
> 

Too bad the existing vlan push helpers can't be used. :)
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


