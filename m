Return-Path: <netdev+bounces-129362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E1197F09E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 20:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4311C21822
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742711A0705;
	Mon, 23 Sep 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8DCt5R5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BB13B7BD
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115998; cv=none; b=NmtUtfAzh7NcbNNWos1ajZ15QUP2lPrtd6C/CiVBcnfIzj2xKeTJqBuZS2RWg1fbbDFtT4M+rauv8ecILrmw/4uSMt46npeLLgHsz6uqSXbwht/lg02hYvX3MZVcf2LoEAr4J9tttCs9DvApClGNEZG84qxKc6hgSi7PnqWD5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115998; c=relaxed/simple;
	bh=LBQjKcQJHfj6KfyEbdS4KeUX1KmB+J6aO1IaEMXQuDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJcd5F32waEhAyUBimvuNGwoaEsrUjihFxrN2tlxhe+RClpe0oyBHOX9fYrCcFzwVvjpXTcq0CYY4qcDLCHkJc/GcH7viH0Axxu2Rz7+ZyE+Cnu8Zxf+4X5t2nmuKBJO874d0kxEQxcgL2efOC7k7vaqLXIs0zvCo/UQiP5kN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8DCt5R5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so3815139a91.1
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727115996; x=1727720796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IxOIgCiDwAlI5BsJXbRFB+p+EJ+owU47MZoiRodnoGo=;
        b=m8DCt5R5qagCpL64ku4oKhB+yWAyex+0zzU7oGSpp1VcfRIk1V9MqL4fXz6VVwXS8/
         8NU20lVtZ6Ix6cEtBuqptOrmowfPhGoEAzVzF4yD4Z+pTJ33NSJ36uh06tfjDcJ+bBDo
         nb1InOMojVRDKD4IiDDZnE97kAn9SNubSnEfyTSURMFC8eZjAuuYZ50qfHXUkQ2lYWw6
         wFLkOu/28KS3EP6tTkln1BxcwgmM2GZZtsxjDjQVxsfjgXW8FPZHv/K1S2MUOqtIvMDB
         pNcV+iRUfqNWx9Kkm6/YyQoKbvNywC3B1qdST49cIk/eMlUPRFs7RMjYy/A9yhk96IQ4
         WWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115996; x=1727720796;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxOIgCiDwAlI5BsJXbRFB+p+EJ+owU47MZoiRodnoGo=;
        b=R0HdVR5iI33y/WVJ/BeWlzhGDL9JtCDry85sZyGSSvDVtwJGsZWqqhZ3DnweUu0HK1
         fzx36jTcYzI+3ZYS+Ps7/39xb2vGoHG6rNgvBFO8FDrEegkBImCcwUzRDVADbk7JFZxc
         dFJSJ0CoB8/QmN1k+HMJ3dFK+o5BrrXyyZZQ5hBRNXvcUjrvMsLsYrWFDudsC1Vfsuee
         5sWdkVhfBCbCVTO+nh8tKqB9ey/aoqe/z5S4ZYtf2Xu/Wu7lQlnEqGHSg04bBcbsCTm0
         NJcx6tl9kN+TAxyMsJtc8w7KGdTgRhJZNQML/SD+fwxJYkMBu2GDGIEkGFNn2IPU0Vfh
         37Aw==
X-Gm-Message-State: AOJu0YwvZN9VeYHC8s3GD81VpYFVCqb3wKnXPHDl3AsPsouHG0DVRBGw
	AgoG6K7noV+JzctXuCN9kDBc9qyA23hPewNIcLuRTCgW0BbM8ra5
X-Google-Smtp-Source: AGHT+IEH+P+NM/vujLCJApizs4agJjG6OWJvfXatE5N+go7p2vlt6wscx95L3VibOVqjkZRsuVP+fQ==
X-Received: by 2002:a17:90b:4b0d:b0:2d8:f3e7:a177 with SMTP id 98e67ed59e1d1-2dd7f37f504mr14206996a91.6.1727115996121;
        Mon, 23 Sep 2024 11:26:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f825733sm7732426a91.17.2024.09.23.11.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 11:26:35 -0700 (PDT)
Message-ID: <4037d375-191f-4e7b-ba87-f5ec9f0e32a2@gmail.com>
Date: Mon, 23 Sep 2024 11:26:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: Switch back to struct
 platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
References: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 09:22, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert ethernet clk drivers to use .remove(), with the eventual goal to drop
> struct platform_driver::remove_new(). As .remove() and .remove_new() have
> the same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> I converted all drivers below drivers/net/ethernet in a single patch. If
> you want it split, just tell me (per vendor? per driver?). Also note I
> didn't add all the maintainers of the individual drivers to Cc: to not
> trigger sending restrictions and spam filters.
> 
> Best regards
> Uwe
> 
>   drivers/net/ethernet/8390/ax88796.c                        | 2 +-
>   drivers/net/ethernet/8390/mcf8390.c                        | 2 +-
>   drivers/net/ethernet/8390/ne.c                             | 2 +-
>   drivers/net/ethernet/actions/owl-emac.c                    | 2 +-
>   drivers/net/ethernet/aeroflex/greth.c                      | 2 +-
>   drivers/net/ethernet/allwinner/sun4i-emac.c                | 2 +-
>   drivers/net/ethernet/altera/altera_tse_main.c              | 2 +-
>   drivers/net/ethernet/amd/au1000_eth.c                      | 2 +-
>   drivers/net/ethernet/amd/sunlance.c                        | 2 +-
>   drivers/net/ethernet/amd/xgbe/xgbe-platform.c              | 2 +-
>   drivers/net/ethernet/apm/xgene-v2/main.c                   | 2 +-
>   drivers/net/ethernet/apm/xgene/xgene_enet_main.c           | 2 +-
>   drivers/net/ethernet/apple/macmace.c                       | 2 +-
>   drivers/net/ethernet/arc/emac_rockchip.c                   | 2 +-
>   drivers/net/ethernet/broadcom/asp2/bcmasp.c                | 2 +-
>   drivers/net/ethernet/broadcom/bcm4908_enet.c               | 2 +-
>   drivers/net/ethernet/broadcom/bcm63xx_enet.c               | 4 ++--
>   drivers/net/ethernet/broadcom/bcmsysport.c                 | 2 +-
>   drivers/net/ethernet/broadcom/bgmac-platform.c             | 2 +-
>   drivers/net/ethernet/broadcom/genet/bcmgenet.c             | 2 +-
>   drivers/net/ethernet/broadcom/sb1250-mac.c                 | 2 +-

For drivers/net/ethernet/broadcom/:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

