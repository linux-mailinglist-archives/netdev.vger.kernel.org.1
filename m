Return-Path: <netdev+bounces-74443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD0D86156B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD7B21A56
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4210B81ACB;
	Fri, 23 Feb 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="b1I+FUFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF11DFF9
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701682; cv=none; b=uIgrS3CEBKTCeSd2jDtzeC5kEG8xymH18LjDbubb/IuBLGABepPrWcAr5jhORZfD4cMzG2vh1n+zhVxFgJLF0+r4dj63oWfQCQy5yNJpxAxnwi18X73PGFkONtz92knsvbYjdowzw5w7xlA88GHv8mgIjn/vXweU3y9DG9RaA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701682; c=relaxed/simple;
	bh=GSv1P4CuD0tc50Phr/0AD3addECJXHQpnR1YmAn60vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI+zth8n6ZKZQpReq/KDp4XDpFRCYEcQKppY4d/06n7CO/Sa36gqyK3VU4XTUBVEgpAIJcWiwRxdjJbwsFETcoN2zCd2tPb088fS+IZ1PbnwV2mAcx1AB27ycgx5iX3sKMYMzJLbSpdjHObm2mERlg1s5gvDVRd9MmMzdJwR5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=b1I+FUFF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d244b28b95so5686251fa.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708701678; x=1709306478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iFcgDpvIbdtXxyzpKg9PCDl+LOGbshxnHc9hrf9S0DI=;
        b=b1I+FUFFhQLsTXQB2PKKMdpR3CnRvgZQ2iohvummwAvcpp519COqOPIjntxnfWmvfy
         6TNa/cvYNhU2sF/3GeUstrs40dNMxGtVaAutiSt9lk40T8UFwkCW7jwqIe0sFiE85Vc9
         03M2PybsFh9zuCEYqECY2MWL+86uCSgvMDQTC5U078gMD1qxzn2qre7w72moa9zHO+Sy
         vSpb6ruKacvCSJWtz3n1SC0kP8QUVEc5ZxrLBSxp1glyW7CgpK4TElUF5jtnw7V1R02H
         SlkgIrnG4ZMTT9L5LoBPjlqVnxTyPKENWLSmnIO2fV6CqvizSH4gxeyCER8Sm9iliNpu
         r4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701678; x=1709306478;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFcgDpvIbdtXxyzpKg9PCDl+LOGbshxnHc9hrf9S0DI=;
        b=NOc39oPV7yuvXpqvulNaHZP9piQax6980RJ9y0bDV36BwspPPQDdN8BoPC/nO6ft82
         4A0lj7/I3tttulQ8eoRHP2znjNFK269QoVR1ZHptjD2dHw/icdCNl6ng9wD80ds/pHXR
         L5J4R7X69cIWBRe60MidVMZya+gxGg0taJXUB1GjferO07l92L8bWfqL1jvWmRkUUox4
         82RK8duLMYIYq6LYnrO10xKvQ4ybax2bYRYBxM/6WaPdGmDkUtvOMHnPczf+PT3gxzZR
         TUitUhsOz8jPtnFOt8CESqTbSnv5zgFp4duzTKPBTNYvLbh2w3A7xEBPoTHaWVenJJRh
         o2Fw==
X-Gm-Message-State: AOJu0Yz/fyvDRmdGozxraUjBKTlM2getBQDwSsEHa3X2NxURI2ShxTuk
	/w0hU8tAVw5EfB2lkJMK4rPZH36TMe3tfmAgvpnb0AnOATJ2vj/F9V840atOkow=
X-Google-Smtp-Source: AGHT+IENBrTOXbfit0ii2fTZ8zUoq3Q0ptYFJlJ2w+krO4wNzserntSwtugTf1BPKObINOqqUvkOzA==
X-Received: by 2002:a2e:3c03:0:b0:2d2:6ea8:32e3 with SMTP id j3-20020a2e3c03000000b002d26ea832e3mr82599lja.44.1708701678589;
        Fri, 23 Feb 2024 07:21:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c190f00b0041298352a95sm326244wmq.9.2024.02.23.07.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:21:18 -0800 (PST)
Message-ID: <befb7e01-bb82-4693-9bb1-354cfcab3cc9@6wind.com>
Date: Fri, 23 Feb 2024 16:21:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 05/15] tools: ynl: create local ARRAY_SIZE()
 helper
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-6-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> libc doesn't have an ARRAY_SIZE() create one locally.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

