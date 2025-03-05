Return-Path: <netdev+bounces-171945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693F2A4F8CB
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9CF3A3218
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF11F8736;
	Wed,  5 Mar 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="C/AInHnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D91EF0BC
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163380; cv=none; b=nGUo1u6SYkBPJ2UxgFWV5RnNZkmv1E9eSr53SMsUnbnE2eYnvYfUwG2CHGlqPmsBtaM3Ket8FecjrApZe7L/281hXLvfWNz2RNP5/9VMt1V1om0FmkGYiQfQFCc9sCS1YeTVam2brzQHK1jYbwtGy9bn+NMK6zjOeAQQlqjQaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163380; c=relaxed/simple;
	bh=BIb8PPjZHUval8yQxPaR2VI3OQirSDX4w545WCXSCig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNEh3aIMRTTjN8Md70w0zfDv9cRhPD9lOykS8oOxZ96d0fmVNpqH2+7yU6HlDrTsBYRhV6FsN+N+9/pmJJLq1myh3Oh8j9CaCwVOfQxgNjVCKXrfqPD+RWZSIa9dna9Nko4xPfGuEeOuFHRPfsuvUZGM8bztZTO9eImjHz03d/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=C/AInHnP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaecf50578eso1251186266b.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741163377; x=1741768177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS635IvOc12Hbl5A1UFbpTyLqQYfDtGYrejudL0pBtc=;
        b=C/AInHnPu6QEjteXzTU/Y+8cXSDnlwTkiooAJDKunOxZzuyXInimEwnJpecJbpBo3o
         S0UwivWB0GwvIyxeMHaN7kHTe8v9oWO8YEWbnI+3h9H+r6sM9huilXAF30fpcyuJxNry
         vQHWkiNk5GpMBotSLwAx8VmIyzmnw31+gj2/wYmyQ9aohqYul/YubmdUtV1YULJ3ueUf
         FZSqkMhgWVa4aibkSIeJZkFHujC/3ywr1mpvpJ70ptJ9X3Voog5WLOfvXh2hdfwIEPpk
         cvKKZhVCj0ZGtNxECF8jjfftN1S7xScxZbWrwuJLw1Zf9y0aK/TKDnTgPwJSsBEVb3Ez
         mWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163377; x=1741768177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iS635IvOc12Hbl5A1UFbpTyLqQYfDtGYrejudL0pBtc=;
        b=VgXOQ+W0dp6CmWg++7u54UHzH6NKdtOM8a4RHUMsqg1LshBxQdmDAsVOaDx6VjEBEi
         z1fv1CAfQR9uDss3NZyeqBBVvepvom6q6/LNliZTESN+3yyfjuKPs7XoNQ78VXlwIffB
         HYHi8ZIolKDe+CVuCzEIiVYcV89nBez53lKpzbdJ9Vpnjo0NFYrD8nnQ3iqL0lV3YcW9
         c2b1uVuy4YNceQzfk70FJor/kzAoXP/rqWiI/84TmQEXcJV/XkSw6fvRnZ/EscnWpFEB
         3mtE6JqJ9EYX6Yly95BcRq7YBwmnEt/Sa7CmoB54anKp1I1aNw258SoEQO7Vtp4yNcxB
         7N2Q==
X-Gm-Message-State: AOJu0Yxms416Fi4nY2U+FeaSY393vYI/XJFYWFY9RtPZLCc8rj3fBFQV
	9yyc2p8GGB+QgifqTYBmnIG4cLFwVK3iQxkhuz6/f+hf+yDxscSQ0GJQZgrouUk=
X-Gm-Gg: ASbGncvfrBc9wLRmeQAUeX8oYbpwmCDcWWjGhS6tPfps/xtyOMKhQGrku+m9cJ5tGy8
	quESzqQF2VULb20Zl2GS/D7RczWrT3JXEgckWW5MfuWKuRV48WIFFI4tgR9vUK5BQSE8l+CdqDQ
	xY3gBycrsLHIvGBqlZ0R3eqDHSxMMXKuilfQ1P8becM4XM4OHHg9VbBnkgZWfgHk3TrbIJG13dk
	EJIlA0i9tkTGRIZymYE0LjIHPMVQL9Ef6XVNcANNKdM1CwnR74lCeK+I4bnsD+tufz+V48Xs9oA
	XYMOkKMFp4VYV8tVWXKItYwwLVrqggv1FLcR8K0/lxeTBwImidYt5FQPWKAaEMofg9/TTzh4p4c
	r
X-Google-Smtp-Source: AGHT+IEjj5zOJcj1/OsRfe5VF46uWo7cJGLTZaHw0tlhP7T8cxub/kFHcc4MiHV1iodJ3D5MAmAOeQ==
X-Received: by 2002:a17:907:9446:b0:ac2:b73:db3d with SMTP id a640c23a62f3a-ac20da4c87fmr226467166b.4.1741163376857;
        Wed, 05 Mar 2025 00:29:36 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abfa393dd6dsm453290666b.96.2025.03.05.00.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:29:36 -0800 (PST)
Message-ID: <1975f2a1-9461-400d-8b3f-f40e8b94be80@blackwall.org>
Date: Wed, 5 Mar 2025 10:29:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 15/15] netfilter: nft_flow_offload: Add
 bridgeflow to nft_flow_offload_eval()
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-16-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-16-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> Edit nft_flow_offload_eval() to make it possible to handle a flowtable of
> the nft bridge family.
> 
> Use nft_flow_offload_bridge_init() to fill the flow tuples. It uses
> nft_dev_fill_bridge_path() in each direction.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 142 +++++++++++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


