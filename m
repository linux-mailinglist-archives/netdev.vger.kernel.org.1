Return-Path: <netdev+bounces-139141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512859B0603
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D150D1F21406
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735A320102B;
	Fri, 25 Oct 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DBe6wk82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C121219A
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867236; cv=none; b=ai05+iWDuaYhiy1VXljwGZEay51VnKTqH24cgOmGykV0lH5EErNXybIJGbk+ovrl1i1VYBbZCJNnauikoW3KY6nuVBx68+SgiQ9fUBwg4VGuKciaCU0wHOt6Z/rzM/xufTOjC2vODR098BpPeHRuZTDR5D3dS9AVHBwmHtcBYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867236; c=relaxed/simple;
	bh=+RT9hoqZqIb5AVhDbOeohlp/KMU+bYxKx1VxuKwZ81A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg+XsBwnV7NsSu+bzP6LDS8W6vNtkTLGSiTG4RqvIC3EnrmNViQnbbBAIC7WtJPztQOQ2rFn1zlfDIZnJSpEqugvcOuxGsDGvFneq5Adrnk9lgeCbekZhFGTD/5VzuxFXI1YbpcAQhQOOPV7ma/fgh5Yq/XtwOZAmFfnJd6dE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DBe6wk82; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0cee600aso271044766b.1
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729867232; x=1730472032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaTKOO/p7n37Wess7b/cHlgRzYv00NAj3iqUWFUgaUw=;
        b=DBe6wk82wdxpCyAD5RnAC4wF3FEn7vEHHDv7eddfghk+mWpjyAQxBviOZ/5MuZPHxn
         fjiS5VAbYYeKRWqTdApklmgCYJ+bXXqhYv9wwZKY93mJILuAWltooU4228C6Zhp66cOW
         hOQLY7mlN8dpy2xICZNzO+9Ye/o4k4CQGdyWRUNy7oETCDLZ4wM2LCtrFPtsXjqR5if5
         A0SLWWa5zaQyqX+3spP90C4M7w1wHNwc0tg8cg0oaILOlyr4zAQAbd+YNLJgDOSfa96h
         7QRa/2ZpBCF8vsoKEYzRMW3JvltmpwEsulOYL2WW6RPKWJkxP4OLF3/4pfVUMaz32Hgz
         5TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867232; x=1730472032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaTKOO/p7n37Wess7b/cHlgRzYv00NAj3iqUWFUgaUw=;
        b=j83G10cn+TjLzV8b7AWT/yeJElUhweE/8P1a4OSckCPT88R5wTlEc6EO9QDQaS5RqI
         omFDBZFCPnZWWHTWAZznmLqNDln8JrLzm5uED/vMwfw8Bt3NhDnSc+hsC9PZww4AXW4M
         k8SeGuvfX5v4172pdgXVc0h/0OWUItUr4iIwHfmMnW9iCYkISOBd9R2//SYWDytNtzjH
         xl8dPxzTizK37+f+XkIx8JcCUCFdcVgxP4IoLKzbryqCRALdvDYnCIhvDQFPY3DpHHEJ
         1MU4JJxR/f5uUfKP7/bN2eE61lxPy69kNsZhQeUQQit7Hn4S6knK6IRtAe35Ur7m7qzO
         ADJA==
X-Forwarded-Encrypted: i=1; AJvYcCVUsruAYQ5NIS9f6/HJIRfowaQtCwwta0TCYPZ0o2u4+l10O8Anp9TFcRJigDZnsHkJbJsBWIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/MQpUKY+apROgFAu0UW87WnCMewrSWLLtO3IA8Rh8YW31O1s
	09/EUhT0q6vkVYCxRC66oUrQ0oyynbsyxB0K6ha7kzhG7zmBf2dLOl7iUU+wHsY=
X-Google-Smtp-Source: AGHT+IHEFKp7A2c7UpCkDyhy0HvpZcpS0trMZxbBjBmBmN2DTUngDsl+V5A6JjioGBTIe6U00EOY/g==
X-Received: by 2002:a17:907:7291:b0:a99:caf5:c897 with SMTP id a640c23a62f3a-a9abf8930b2mr913957466b.20.1729867230909;
        Fri, 25 Oct 2024 07:40:30 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0298cfsm77911566b.74.2024.10.25.07.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 07:40:30 -0700 (PDT)
Message-ID: <8241100a-dd0d-4a74-9360-527a93282642@blackwall.org>
Date: Fri, 25 Oct 2024 17:40:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de
References: <20241025142836.19946-1-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241025142836.19946-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/10/2024 17:28, Fabian Pfitzner wrote:
> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
> 
> ip -d link show [dev]
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>  ip/iplink_bridge.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

Please CC bridge maintainers for bridge patches.
That being said, thank you! I've had a similar patch in my tree forever
and didn't get to upstream it after I added the querier state dump. :) 

A few minor nits below,

> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index f01ffe15..fb92a498 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -661,6 +661,54 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			   "mcast_querier %u ",
>  			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
>  
> +	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> +		SPRINT_BUF(other_time);
> +		memset(other_time, 0, sizeof(other_time));

Move this memset below, please don't mix declarations and code.
> +
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];

Please declare the local variables at the start of the block.

> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER_STATE]);
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_addr",
> +				"mcast_querier_ipv4_addr %s ",
> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv4_port",
> +				"mcast_querier_ipv4_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_other_timer",
> +				"mcast_querier_ipv4_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +		open_json_object("mcast_querier_state_ipv6");
> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_addr",
> +				"mcast_querier_ipv6_addr %s ",
> +				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv6_port",
> +				"mcast_querier_ipv6_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_other_timer",
> +				"mcast_querier_ipv6_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +	}
> +
>  	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>  		print_uint(PRINT_ANY,
>  			   "mcast_hash_elasticity",


