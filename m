Return-Path: <netdev+bounces-119113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32495417C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7C42858AB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D980045;
	Fri, 16 Aug 2024 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="cyxia4CW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DD7E782
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788378; cv=none; b=kWsqBC6gCRsHJFAKmCWX8rC9/3u2HxT8+SB3u+iIQYPHlU4t31BljJQ/UxHES28DfbrB7on7xLbNhDXed2FWt+iBaK4zujb6IgEAzihnF2wFjlnPTPaksAP3Pp9r07F64WThyhz5lFvC2udlVQFjtODhC25FdPeCAWyygVk3kyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788378; c=relaxed/simple;
	bh=SDz7zrZTPfudtZQCn3RyH7W4X5tTnGsGyWf1+oUsbWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnNOV40KSffkex/+I9Uy9o8kDO9vpkrBxGYLmL9qF35vYXEGxbAAUk43z9NunvVOja3ZLdafLZE+5KifjQDfbbConXjTyaqy62FyDlORkBBwOXix76mJdcNX7hMFaIqac1H+gsTinSEAIAe7D9xj9tp2SeAvN15hkPYquGGuICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=cyxia4CW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so189585366b.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723788375; x=1724393175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeXKTZOpKW3wvtXqmbcaFt3a/lJXibaZyacfa5UJkyI=;
        b=cyxia4CWO2J+4L9Kz6+tyWidZC7SIBhWvyKAthHiPVSRC8UU87TC0xDf/v9bLd1MU3
         f3OAszFYeUfH+rBWE0akKe8rVbQ/4+ClCFSZ535f6QBJA9XUBR48XQp25Wv/PNNNOcHY
         oa7MPEtH6EUs+EjU43h/Gy+xJsLxNNApPiOimIf3KYr3sok+vus+uik2xfM5MtI83WpE
         6+Ou+FXIxG99n/OTKGyjeU+iAyAalwLiQKHFUukyajT7fcYS89z3uNg8LTgX9n0L5sSJ
         tDpfkw5UcX+9PWJ6ycBK8A7qKtmbIa9h9Xrxnji/mia9AqCtRprxjcoTVBfaM0V/9Wrw
         7qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723788375; x=1724393175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeXKTZOpKW3wvtXqmbcaFt3a/lJXibaZyacfa5UJkyI=;
        b=cEv2phjipm8P4AcERNQY/XyMpoZZqNyvmGfwgIMa0YgByINZsg+DQHAF1y6+A6qmrQ
         ePGsGcoWgvVWwfvl4x9KypZSUgPVPno+AU1yM1CKm9VojtKyJFMZB0OvAIaVcfIUb/1D
         JNFIGdUmtVGVeaJ7fXxMD8PCb1DWIjzWqgJvlwmZ7Zds5+73aSWlENVWwcOch49ht7l9
         4Avsm4IbNkRymw7kzIPKDhgmg2LM/o17z9K6hj5vTN3XZJgX2VVAKfib0zKcdUKana7p
         gJ3A0iFk5caGFDNb5bOHhem67VE4MjVWjwz4nqMv8Lu2KKwQcGnS5pK9SElLyy4Abfyo
         UtpA==
X-Forwarded-Encrypted: i=1; AJvYcCUniE3PjzU7z0YZHhUjl1x8ZtocGpC566rz1z12yD1zefrUCZSkfdVrfTAnQnYM01+RGiOgVs9/3FhDfrXMYShok1Whyg2A
X-Gm-Message-State: AOJu0Yy6IX54XwC/Fq77DUCbmEIsygu4bhDYGNEa30b9NkHraBATwZad
	t2P2PupgKBUUv1fgr07Gy9Am3C4g0usQJ7Du6yvkr2sv77O+EOb58bvWVVL/i8Y=
X-Google-Smtp-Source: AGHT+IF5hdvaFHq0dFYdGtKjKdSMtDMsDQMomJAZnLGGzfhUZDIV9RLyJBPGCQms+41/DW4a/MWN0A==
X-Received: by 2002:a17:907:e642:b0:a77:cca9:b21c with SMTP id a640c23a62f3a-a8392954492mr143711366b.34.1723788374409;
        Thu, 15 Aug 2024 23:06:14 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839356c9sm206256066b.120.2024.08.15.23.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 23:06:13 -0700 (PDT)
Message-ID: <334c87f5-cec8-46b5-a4d4-72b2165726d9@blackwall.org>
Date: Fri, 16 Aug 2024 09:06:12 +0300
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

(not related to this set, but to bond xfrm)
By the way looking at bond's xfrm code, what prevents bond_ipsec_offload_ok()
from dereferencing a null ptr?
I mean it does:
        curr_active = rcu_dereference(bond->curr_active_slave);
        real_dev = curr_active->dev;

If this is running only under RCU as the code suggests then
curr_active_slave can change to NULL in parallel. Should there be a
check for curr_active before deref or am I missing something?

Cheers,
 Nik





