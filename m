Return-Path: <netdev+bounces-92726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF258B870F
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 11:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA091C216DD
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E0150290;
	Wed,  1 May 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xHlegFPw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4F50282
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554057; cv=none; b=dak8J4y1fuxffI2EHfH+cfO3uHu8l/7+gie8w67tH9889L+wEZU3PhyG4b+NjDY5J+fbPvbQM/3XeSGrnCKfIZImwfV2yHoCJLgUGwnX1EtnUm2vZQrIBXtg0/YRUE1CSv6I+calZWKld4Dqy7O/ZTq30hcADO6IL/zrRVxAgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554057; c=relaxed/simple;
	bh=RvlWpLEFaTjb+9r8GV4kOWTTNkCATCgpD5gAqvzy9as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+dkCCDw5JI6YznjZkrOtWVqZ52P8OjQZO6/iXw+MvWhYIC1zj8ZqgkV+43vxTRf5zsMAzfa1DNcBCykOyf5xV3fE0xYcnC2P2QSnWjyPzW3hyfhYYMl08Mmh0pSxdNfLOQ6Zp7j1ixhKPTfy9pDyEczsSRi1T3MkzHFmPQLgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xHlegFPw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e0a2870bceso37733961fa.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1714554054; x=1715158854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Z/cUhjxZbZcBp200s+T3WFXuwoGui/XESvwGtAV7pU=;
        b=xHlegFPwN/OLwxjrnK5gQrF50SoPXUSJ40WMxsjVI18FkwEfVrc+tV6XmJM5WrNJxn
         602lktCye3J1+eJzzdYlAPeSAY6tUpDixPN5PD2JwK9aQn8Buy/RR2767n6nbFmOFERs
         PXoBZVDmr9AGlLlXm1YpI0LqLfxE+GAtC4t7HChb5fPMc4xVsMwaTV927hORz5phdGWn
         Ib0ThVG4mtIJ4Rlm4e9cxoSqasi6ZbyGrCiWe3Zq3tRZDqVz5o33oikggvqfQ5/CX25U
         63prh0yZoX9G+b/HJizuJibXAEKvIXS7T06yQlkw5p7ywVT0uqO7/eU03JcSpGemsxIZ
         aLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714554054; x=1715158854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z/cUhjxZbZcBp200s+T3WFXuwoGui/XESvwGtAV7pU=;
        b=gLSSD74Xyz5udSSJPiXaRAQnyJrFZOgEefYJr+y2e81YMGppF0brH80X4UwYvoZU6x
         itAdx0ovcC4xxubHnpsOJ2wfkb0txnbG0T8Y5xBl7iL/EamvCngR0Trh4u/xwEJgRn7y
         TZqTwerta27gAtnNjEdF+PEqzoKwqmIoJRvkX/POji9/3CPyblFLa/gI+haHBipaa+eL
         P0KHgjeeGwuKXvoBi0I2U64Gv6mumTF4QP4INH4m3IJHYP9WMfirqHMMObQm/od2MFME
         721OACwF3vsh4WvRt38Y/T9fQC+KvLpjzGowQ1DLiKQm2GpKNjNHbCqXu8UFPI+96tAf
         YlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcWp9sdxX+MGF0wuJwxL6iFuzPlxQefQi5cbJhopieDyR8irMMw2X/PIZ04bgKnaymjWh7f+UxhrnOvu8WrgVlDAPHN/TH
X-Gm-Message-State: AOJu0YydDtbwWh9AnPzxMOT1sYKkMYH2XiAaHCKyHAU9XJeHAxKhbnUp
	4Q0mQcqfiTZmu8REQFikmFcUfQAEmGz/wYbaxbYZPPoCPfhuHVPQUEfAX3w5psM7GSX9w50dNHv
	5nIY=
X-Google-Smtp-Source: AGHT+IE6du7GtGa4yWJTPKJ9+hxmuTCQMBAnDfeiG7v0iH1S+LQsBmxd6vnFIJ8yJppXhTWsJgTwMg==
X-Received: by 2002:a2e:3a1a:0:b0:2dc:b1c7:514e with SMTP id h26-20020a2e3a1a000000b002dcb1c7514emr1350558lja.8.1714554054077;
        Wed, 01 May 2024 02:00:54 -0700 (PDT)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05600c3ca100b0041c14e42e2bsm1533485wmb.44.2024.05.01.02.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 02:00:53 -0700 (PDT)
Message-ID: <07cc48d8-658b-4eee-a72d-efe3cdbed967@blackwall.org>
Date: Wed, 1 May 2024 12:00:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: fix multicast-to-unicast with
 fraglist GSO
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240427182420.24673-1-nbd@nbd.name>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240427182420.24673-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2024 21:24, Felix Fietkau wrote:
> Calling skb_copy on a SKB_GSO_FRAGLIST skb is not valid, since it returns
> an invalid linearized skb. This code only needs to change the ethernet
> header, so pskb_copy is the right function to call here.
> 
> Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/bridge/br_forward.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 7431f89e897b..d7c35f55bd69 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -266,7 +266,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
>  	if (skb->dev == p->dev && ether_addr_equal(src, addr))
>  		return;
>  
> -	skb = skb_copy(skb, GFP_ATOMIC);
> +	skb = pskb_copy(skb, GFP_ATOMIC);
>  	if (!skb) {
>  		DEV_STATS_INC(dev, tx_dropped);
>  		return;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

