Return-Path: <netdev+bounces-116746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB92F94B8FF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 10:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F49B2324F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2CC1891BD;
	Thu,  8 Aug 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W+760Asx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854B189517
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105685; cv=none; b=HsI5tMW9cD1E34LCyQ15PCNv9nvKkIXPXVikF1Q60qZjpBmteWMb4QjYwLsQWGdZKrdtaets/XgocTPVZV7tOPv8HEm6gg31x7lxphja3naFflN7hjTKLQhN/EbH0mMVvzS73du+5SyWyj4+J9527UmEZUqw9+UlkevBJgcUWPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105685; c=relaxed/simple;
	bh=puzHVjWtw/EwIPBsg1NnWRoNZL0Jl29QkrfmRRWA3sA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HDgGlFSp+5+qjuLAFoeIHE/G9isHNLdBAx7Du1wXuIlpBBLQVPoVrQvjeopxBI4eCJqoz+Lk0LjgDg3i1Pjc3RXHN+MqF6sFhDepthHhm8YCWDUAbOgg8WRFvHEob6DtQBEYODef7l+ufdimLkliRpcZwSKvqP4BUhDMnetQShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W+760Asx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so680218a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723105682; x=1723710482; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNTmZJ3uoMueniwsSmNFmWugheJDlxUW4IOjiI6Jlx0=;
        b=W+760AsxIsBroZWlAjDGDbjtSrYNUGh8F2iv0bDr/DhkNqj9TfPxJXfmm7bXboo7Vv
         fvQvUeqLUzrkbN/QJxGibg4/6W0Fr7AjBSiXadoUVXA+escucSR5yWK9fPGZhDYa3UeE
         oMuQx87sweyVoOlY/h9pifAysgLWOa/MTyexcSHnHvLS9ImHnuaIO+dMx/sW/m7JRZKr
         w5ZIZd1GS/ifThq9KYvO55V7izczgSvS1EuFggUho+Crts+zsvqKx74tusiU5bYBr9yS
         sXGhwraWk+2mD41P7gDo5RJEc6K3N1HAU+k7NMdkJwgD1t3Wo7ELpyTAyaCpi4D80Lh6
         6aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723105682; x=1723710482;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNTmZJ3uoMueniwsSmNFmWugheJDlxUW4IOjiI6Jlx0=;
        b=UkimHqu/0VL8hBT+B4k6rg9+CuDlQT2YmjTYbfsaBE8xjog/t8tb4oHT5aciJYFuWN
         ZBXY0Gnds1ro5n+wXFGdHDmi3ILZ1tQmSUpt5cclxC+kRsc5TDMJFY+v6s2WLMHoF3gz
         q6dCBLiInWJjXTL6Ns1AF0vJjlivP7w399256qYgWjQKBZ33LbjWF7efCISXiw/u8Kg6
         lnE/VyqGctxBYKmzcB+lDz9xbLh2CoIOWmTgnR+DsN7bxpAWFUGFq4gsdsS1vPyRjvvn
         yZW8r3Kqk65id4Ibz8/D5HHA0+TwTWGMcJcaJrEuhG4HSRCEGhKGjTvA9gmrDnOmI5+t
         2ogQ==
X-Gm-Message-State: AOJu0YwGwiZiO9VRMb8CaW2BWxvzDSc/3zDJNOS6EkzaWOs7dLbRkXkg
	hL+AR+8iqYEBJkUxTvrL9vSLK/jWuIeUFmwfv8wkZApOr+U4owJI2ZMEU2NAqsI=
X-Google-Smtp-Source: AGHT+IHWZQ7tx1+ayAAXKkbUtqkpGO2StjaOhkASopvZIg/o804BlXNF56Am68lWbWgMdlXHUreNZA==
X-Received: by 2002:a05:6402:27cd:b0:5ba:83d:3294 with SMTP id 4fb4d7f45d1cf-5bbb21f3804mr908005a12.2.1723105681861;
        Thu, 08 Aug 2024 01:28:01 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf9b02sm403984a12.6.2024.08.08.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:28:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  kernel-team@cloudflare.com
Subject: Re: [PATCH net v3 1/3] net: Make USO depend on CSUM offload
In-Reply-To: <66b42d7ee8ab0_3795002940@willemb.c.googlers.com.notmuch> (Willem
	de Bruijn's message of "Wed, 07 Aug 2024 22:29:18 -0400")
References: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
	<20240807-udp-gso-egress-from-tunnel-v3-1-8828d93c5b45@cloudflare.com>
	<66b42d7ee8ab0_3795002940@willemb.c.googlers.com.notmuch>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 08 Aug 2024 10:28:00 +0200
Message-ID: <87plqjxvu7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07, 2024 at 10:29 PM -04, Willem de Bruijn wrote:
> Jakub Sitnicki wrote:
>> UDP segmentation offload inherently depends on checksum offload. It should
>> not be possible to disable checksum offload while leaving USO enabled.
>> Enforce this dependency in code.
>> 
>> There is a single tx-udp-segmentation feature flag to indicate support for
>> both IPv4/6, hence the devices wishing to support USO must offer checksum
>> offload for both IP versions.
>> 
>> Fixes: 83aa025f535f ("udp: add gso support to virtual devices")
>
> Was this not introduced by removing the CHECKSUM_PARTIAL check in
> udp_send_skb?

Makes sense. It only became a problem after that change. Will update.

>
>> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  net/core/dev.c | 27 ++++++++++++++++++---------
>>  1 file changed, 18 insertions(+), 9 deletions(-)
>> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 751d9b70e6ad..dfb12164b35d 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -9912,6 +9912,16 @@ static void netdev_sync_lower_features(struct net_device *upper,
>>  	}
>>  }
>>  
>> +#define IP_CSUM_MASK (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)
>> +
>
> Perhaps NETIF_F_IP_CSUM_MASK in netdev_features.h right below
>
> #define NETIF_F_CSUM_MASK
>
> Then again, for a stable patch we want a small patch. Then I'd define
> as a constant netdev_features_t inside the function scope.
>
> Minor: still prefix with netdev_ even though it's a static function?


Will apply all feedback. Thanks.

[...]

