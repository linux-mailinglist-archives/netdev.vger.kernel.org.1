Return-Path: <netdev+bounces-119112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8811954178
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7631528461E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490282E859;
	Fri, 16 Aug 2024 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pdhCOcd/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548137E76F
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788024; cv=none; b=qGbttze2zz8Hs44OCZPh9Z2CYnHCxBJqlWK97SFjXrcT5OThs6zY8pmx2U4fFVZ+7mY74Sv4EDqlI/l681HD9jBtX7RweLjld1keV6JchEEtGTMa5OsL+4xrbg84WDELiKH3gbXrARNHkk4xPsCFWGJ6maqFF2qP1nPak2ICMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788024; c=relaxed/simple;
	bh=e9yz6ZQBfZnfk2go0f9i5+blu3XCBXk+1lqTmpjOIYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbrxLP4yDDfuOEmIfPBlJvxm6qvQjyCAI8zaQGOrsEZNgQiuZGwZcU8vqAxUrP/06XinGCF//vY8aabCl1n0Xolyknnjz20LSlya+iUrpse9eazJqLp/U3voEWWlA+RBGZhl5FG20njCtItZX1J9P3SsbpdsW3r9jMUSqWGXrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pdhCOcd/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01afa11cso2072158e87.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 23:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723788020; x=1724392820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PPJj6B3JCJcDozDfVyk9M2OAVsC+0bO9GKkzZoODw0=;
        b=pdhCOcd/whMDoamIwlNjQVOVV5lPH2aqrsxMiP0+bK7p31FIn7rD5Gh/HMDYc+KpA7
         9wij3Myu7ZybQ8XvtrUhk2/HdhmWXMTGveUd/EZEy6PUxI5kFNazpKFqy64OOydwCG3J
         pekKPCrCak1iNbFcT2yyah72mg/IlwwmRfRRvCoC/MWo2x/Apx01L1HCntxBqAfbjodM
         gMjx6qJXpfiRKO8UsSC7uQ/IpMJoSHlxjoLykzRBsl9xLK0w9GjoGn8NuWLwAxk2JD2X
         J3EVW/mkh+RUDgWi91sq1ttPugoAJoEidA07CleQXaAb83pcKd2y+KcExM3vrLECbLN4
         3ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723788020; x=1724392820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PPJj6B3JCJcDozDfVyk9M2OAVsC+0bO9GKkzZoODw0=;
        b=WktYq6UcGUj6WwT8SKZr0xSvqVCY4suC4krKMNEbRdoXnOHbo2NFqwxs7zSLGNPhud
         zeHbCcl0p0oMblaPlxYTlCbR8sx4wzcFbS4fP9ZblQHdiGz5pF7BTO59goVdbP4pXPWI
         nkCH/70UKsBnarDVcI20xmHWoxbIvs26es5AY5iL5fDpv/iII0zMBZq5QxR2+SvHuRnp
         YWH+yBxCPfghUx0aA7+6SQ/PGgs+oJqALojJa/KNn1QZZD0i6ZS483ElZXaIW17Tz06o
         hsIzSk4ledC6+g4KrHqy9RlTME1mDNxcuXvNSEnV+5eWgkJnAvgup1is3SjnXev8acwn
         Xv6g==
X-Forwarded-Encrypted: i=1; AJvYcCUQZ6jVAzqX3MM3fCl4YCnj1U6mtZ/koMUHfg9FQ8XWPbvC1Kq6emBwODCQizMT4GyNmToNs2pV0gJZkOV+zs2z60u+TBC2
X-Gm-Message-State: AOJu0YwKn6vmNXrxMrw0I4J0aJqbmCJ/RNX0KpLSgezkDjB/UVN1N0Tm
	dEl+lXL+cFrqeXYMiutbo9FkuTPbq8CrMRkm1UVg5NdAZkVQA+YU6NVHzG65sWE=
X-Google-Smtp-Source: AGHT+IGabvFEL9MAI779F8W9pjnr+v/wMowuRpfBqy3dzWjH6G8dyLW5p6b7WwyA89ktturnhgusxw==
X-Received: by 2002:a05:6512:3b81:b0:52e:be84:225c with SMTP id 2adb3069b0e04-5331c6ba239mr989732e87.33.1723788019635;
        Thu, 15 Aug 2024 23:00:19 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c15asm203974966b.197.2024.08.15.23.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 23:00:19 -0700 (PDT)
Message-ID: <ab09bdf3-e67b-4548-87a9-acf9a08806c6@blackwall.org>
Date: Fri, 16 Aug 2024 09:00:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Bonding: support new xfrm state offload
 functions
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240816035518.203704-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 06:55, Hangbin Liu wrote:
> I planned to add the new XFRM state offload functions after Jianbo's
> patchset [1], but it seems that may take some time. Therefore, I am
> posting these two patches to net-next now, as our users are waiting for
> this functionality. If Jianbo's patch is applied first, I can update these
> patches accordingly.
> 
> [1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com
> 
> Hangbin Liu (2):
>   bonding: Add ESN support to IPSec HW offload
>   bonding: support xfrm state update
> 
>  drivers/net/bonding/bond_main.c | 76 +++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 

the set looks good to me, one minor cosmetic nit is that the two
functions look very much alike only difference is the actual call
can you maybe factor out the boilerplate?





