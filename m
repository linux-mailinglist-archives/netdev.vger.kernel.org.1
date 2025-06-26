Return-Path: <netdev+bounces-201590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88747AEA039
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BEB188C136
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278882ECE8C;
	Thu, 26 Jun 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="1lVzs9fI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250A2E92DC
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947201; cv=none; b=ajEmd5V7lBmYKAqMTMLH9Jqm5KdDIzWwxXX9KoKEiMehpiAKBnhye5zFlZS0LZOD3SeHiFKjlXnWhz7v/yWb6nLnFuj0DxhuIW80HfVM17riLRYDjoHwdrhodU1F2jEl8MmfRKlbArHhoMPmuSRtEx8YDJ8pz1v6nxQOMDU/Tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947201; c=relaxed/simple;
	bh=2uW7mr3AwSWZ0YhCQ4TlQPdqi8tTo3hjJ6HqfnwoLbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0SchIKNnWuc19xpsrAx9lDG67pTERGxma6hxv6pEst00jVqrj4JY3nPG4JlzcHSQlRhbj6thNfSFbRgPh1EqYTtvreIz9xbYt5FK8LEGN36ESb1J9EklWfUfS0U4MT85lPiYP5rKVBlYm6Rxqci7cGkfs0z478rOe7GlnMDtMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=1lVzs9fI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so1919446a12.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750947198; x=1751551998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJ2PJVqfDGm4OQOg/KbzIbimx3XGnSxegyPGjOUia2w=;
        b=1lVzs9fI9ZziCMw2J58hz0mNDRthndSvUXTMn3e961YbO3ggTUwDCVpJ8iAvhvOh4S
         bTVzaIY4CrtsMvTcEITtQc7zLZrY1frZw73duL1ptXQWjikY5vEsZaUNNPTfbp+mp7uh
         jczpVGY4gxsC8eNY6TiN9c3yNvwm5I76eYRvwxlHTZ+RMhu8tyqi3kGIdS7p0MsDppjR
         EZ+dtXfu93UdONK60PQTWidCfaBIfuB7fLL8jGM0Ik6m/KkECpDNvcACHx0Taf7/bFR5
         Hk5qDKpW7iX/KfmN7aEGnIxem+QspRQYKaojUHievsjLVSbQq66XfgpLVxbfFRCGsjLQ
         ke8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750947198; x=1751551998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ2PJVqfDGm4OQOg/KbzIbimx3XGnSxegyPGjOUia2w=;
        b=bu0YS51shhvyTgeooy5P6onvgEWN/NHDylbZ/L1iz1W68wLEBoAlN4y7b8UM4OoEfV
         893z/xPMtc6JujOMV6drPBqOzRZmEvYutxQEJDgZOeSdbXoNC1s/gqzLdK8ALgDUXvFb
         scaflbT9+O+h1aU7dl7ohoTdinQdooiAzC/3OBtMtjtHGgiIRpklDW2fofriJm7s06RN
         jc2E3f2R+Td8OLLvy7EyZtS+0WOy4eeIMMbI7WrMpVKvx1za1Cn40eS7EJfInAhhUqpX
         Z0lNh9ZZexxbVpQSOA2U4udhl+snaEGerkx6GUcnCYZxzA5fCu4H4tnf4UwubSJ8whk+
         sa0g==
X-Forwarded-Encrypted: i=1; AJvYcCUqYZRZRmns9/bDFBQcCt8LNaka3jSyN3q7IVhsoQNTDsegAlO0zTkne0sKNkLbQXfMzH+wKTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjDYlCKEeBWLbfsGJPRyqH9XVNEsRROw+nlHJjeij/YbQCY/4
	8VZopFc/ZeV7VRO1gone3nijRkViycBO0CCuGkPjImWrS27V64XS6A2s4Bs4k7jNJjtPS7rSiP9
	/d7AV
X-Gm-Gg: ASbGncsBTR9LeHUHTzfLUOzNn9SrCsAx2+i63Q6bkVwiT5nF76GZJ5+tnPu0WSv7LZ+
	LtxWPUfEeE3PHPcQC5Gdvct+HsVHdyXeVBzRBStGfHn87SsxD4XO1vxnfVqSN9xC/NAyySI/dep
	3ZjFgz21TkkzRiTgGgU0pkaDusuArcypiTmIDqYDBdV4U0XMeRdtxRzc7Yid5P+yyU3Im+r0F5z
	9OJXLy0iXSbgrE+4qs10fj42ftqWIDINX6Kcl04mT9wGAM54OR+VL9XVhuGZRp5IM+LHo6qcooL
	s23gLtLlY5/rDcsmpFOAzhcH8i1i7Js7BxP3b9P7rz2l8CLruD18PJcPVeHak7pELpDMoBs2K1w
	uzTde4IKfknXJcNeP7g==
X-Google-Smtp-Source: AGHT+IHrsJwMdRecFYeO5kMWyxa+93mQu3IMbqpTUGhTM2xDeR8OoSQK9g3BgCy3C40rSD7QWHk3Qg==
X-Received: by 2002:a05:6402:26d6:b0:608:64ef:3807 with SMTP id 4fb4d7f45d1cf-60c4d192b6amr6065767a12.0.1750947197726;
        Thu, 26 Jun 2025 07:13:17 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319b155sm46545a12.52.2025.06.26.07.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 07:13:17 -0700 (PDT)
Message-ID: <58f65a46-1f3f-4d1a-965d-6c0457e93d58@blackwall.org>
Date: Thu, 26 Jun 2025 17:13:16 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] bond: fix stack smash in xstats
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: z30015464 <zhongxuan2@huawei.com>, nikolay@cumulusnetworks.com
References: <20250626140124.39522-2-stephen@networkplumber.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250626140124.39522-2-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 17:01, Stephen Hemminger wrote:
> Building with stack smashing detection finds an off by one
> in the bond xstats attribute parsing.
> 
> $ ip link xstats type bond dev bond0
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> bond0
>                     LACPDU Rx 0
>                     LACPDU Tx 0
>                     LACPDU Unknown type Rx 0
>                     LACPDU Illegal Rx 0
>                     Marker Rx 0
>                     Marker Tx 0
>                     Marker response Rx 0
>                     Marker response Tx 0
>                     Marker unknown type Rx 0
> *** stack smashing detected ***: terminated
> 
> Program received signal SIGABRT, Aborted.
> 
> Reported-by: z30015464 <zhongxuan2@huawei.com>
> Fixes: 440c5075d662 ("ip: bond: add xstats support")
> Cc: nikolay@cumulusnetworks.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  ip/iplink_bond.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
> index 19af67d0..62dd907c 100644
> --- a/ip/iplink_bond.c
> +++ b/ip/iplink_bond.c
> @@ -852,7 +852,7 @@ static void bond_print_stats_attr(struct rtattr *attr, int ifindex)
>  	const char *ifname = "";
>  	int rem;
>  
> -	parse_rtattr(bondtb, LINK_XSTATS_TYPE_MAX+1, RTA_DATA(attr),
> +	parse_rtattr(bondtb, LINK_XSTATS_TYPE_MAX, RTA_DATA(attr),
>  	RTA_PAYLOAD(attr));
>  	if (!bondtb[LINK_XSTATS_TYPE_BOND])
>  		return;

Oops :)
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


