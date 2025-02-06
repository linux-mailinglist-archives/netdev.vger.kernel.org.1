Return-Path: <netdev+bounces-163567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10082A2AB98
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD923AA588
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91307236441;
	Thu,  6 Feb 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NMSmi6RD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7799236437
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852721; cv=none; b=qjrAAElVcyB3FLu7LlbICnzfjzllkG+SyeAkDPhlAErnEBjcpCdL8QR59qQqpKCwITHV6aP1HavnelI8FK/ID1njARC33//GKA5DRLrhCmoQ4ZunKbayCaS3PKn6IW8rIDOcMB2Lyy1cQ0nEBFPx+NE0ygUUCKQFNcVMcGyddqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852721; c=relaxed/simple;
	bh=TPNQfdWjJ8Yhd7t0wOyWnRcoTfWf/QHkmP+F+4/taO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlxzuiHyQXbv+/TQhHfrRNPi7zAXfh/jTtz0jTrd1v8R0U/GfP2L2TEstC1XPuqf1rEj5zZPNT0KrL4kiXLoACu1ga9TXCqRvH5tlOk2vbX+fszZhJPxnfyTTPHdr8wL23lQgLA7NOc0YzhjHkeLq6aHliz+tBlZ/8YMluudb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=NMSmi6RD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7814aa2adso34303966b.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852718; x=1739457518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uw/h4QDTlZnL53fcJ2QvA+6Beq+Nqrk3rFi+DoZZ9Nk=;
        b=NMSmi6RDF4GepyN+EBquenJO1zbLQ/wmk/R2ozAwND2+Gq47VoCD3AxzJOwR8GhaqU
         61+4u72xadfiqZyjKQowKV/z52nb8phvkoagidthO0yHoI82JEk7clZtwA6Msxmhbl2j
         Yf6gsnUHUYdpaQBUa02Qj+64pPHCDA7j4ymqkWd52S3J7CMIW/Qqmmp1psVjjY3QvnHI
         5NTkjJ4SqaAR8zkeV3jq7DgmRx/PwSr6GaSOt34x6E5rMXwXLbJ6Dt7szsy6gO2WvMxA
         GVrhUiUlBgC8Aehh/4QwlLuijO7lQh7/yyWt9T4v8RTuROhUYBNAThj8G4BGtA+Qc2yx
         lEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852718; x=1739457518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw/h4QDTlZnL53fcJ2QvA+6Beq+Nqrk3rFi+DoZZ9Nk=;
        b=M4OcCpbotUmTBceqvPnxXzrSZkDprVvGuijwMIOZK4TOLZicp8MF0Pirg1A7qdsQmJ
         GltIwiRpDph3Qh10WXQDhgUMni60Aw+E6/rkGtPtXbyFOv5ijMoQZStyImaASPCyHnw7
         yI7BwqrIi5u2ObSoljjcYdky921D7+NACYOyGuhDa2dlM8saSB560jtwtCg0+LuJWYN/
         EANuaVF36fBb0mBL3GhNXdnhlz8MdF+AG0dzwOs8Iy0JuTqjqiMYZVpPl6+XOQwDwN0T
         6ylWawlVwHxhszGYT6cKVHQgixefrrj19VY5srFlTMt8E8duEq0HGa73Y121Mb3zwJPb
         QDhw==
X-Gm-Message-State: AOJu0YzsZrV1vcctdwk5eAxFDDrQNJZ+hYxkx87Dh8s41Tihf5vy4RH6
	9t3zO6vtp9fGi3KIMgKgR17iVRKFi0Awm+pYs9+6Gqy9wg1AW8h4D2EapZdD6P0=
X-Gm-Gg: ASbGncvL+oPN5jNVM0h0vb2QXbEJE/MXtVwZFXrDwJ7K1awCnzZwzn+FhqgO6PKzhic
	Oax+OTDPzRLNNkpUushk5h3aYwmfZAudQaa33053Sp4xUJmX0xJ2ddbSMYxGhYKV+u+h/QauSFJ
	qRYQ4IdUIuUysELsytJhXkf619IcJ7BwHmuTkF9HWatLF5Jx5EyOuuEV8yErpxk4G5MAjiDNUZC
	nNqnZnfg7DH/rgUKXu7MjepgQBnblgMIadnY1HbzsYQrbETHtNj2c0qlm5p5kQiscOlcRa58G0n
	493p9OXhbenss4TJ6pu6yej5fQlhWMwdCywlgUHCQU17+7Y=
X-Google-Smtp-Source: AGHT+IE870Ofos2AH3n3TMWHfx6tIRQtGQ55FfR3imiLRJSMot66fT9h5iAgoSCOr6Lm1A/3Jqz+PQ==
X-Received: by 2002:a05:6402:4486:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5dcdb762a5fmr17852032a12.24.1738852718101;
        Thu, 06 Feb 2025 06:38:38 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e7196sm106659366b.89.2025.02.06.06.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:38:37 -0800 (PST)
Message-ID: <2f58633a-83a4-4128-9a1a-bd0612793bbf@blackwall.org>
Date: Thu, 6 Feb 2025 16:38:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/14] netfilter: flow: remove hw_outdev,
 out.hw_ifindex and out.hw_ifidx
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
 <20250204194921.46692-3-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-3-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> Now always info->outdev == info->hw_outdev, so the netfilter code can be
> further cleaned up by removing:
>  * hw_outdev from struct nft_forward_info
>  * out.hw_ifindex from struct nf_flow_route
>  * out.hw_ifidx from struct flow_offload_tuple
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/net/netfilter/nf_flow_table.h | 2 --
>  net/netfilter/nf_flow_table_core.c    | 1 -
>  net/netfilter/nf_flow_table_offload.c | 2 +-
>  net/netfilter/nft_flow_offload.c      | 4 ----
>  4 files changed, 1 insertion(+), 8 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


