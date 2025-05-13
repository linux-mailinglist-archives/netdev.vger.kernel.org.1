Return-Path: <netdev+bounces-189998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63FAB4D5B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3ED717BEF3
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F261F0E32;
	Tue, 13 May 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoTz9IoN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454717578
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122834; cv=none; b=qb6f8ujXeF5NGjXaDQIs5nCiKJTK89atQZ2ix5n6tvDfGuHKyYW5flD2rZjCaYPcr1+yQ0HZU9mCWduMMWW8OiDkRPx6ZcRmPI1eTb4FH48Ve8Ef+hlAFN3xYCesdwBvK86YzoXVn3F5Xs5gn3yQym4SSGf5MJ2dD4iQydW54OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122834; c=relaxed/simple;
	bh=c1oZODB5g+2NOwrP7U3z+PiEbKTloAsovbeyXS8fl9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn8gKJnLG2UXBFsfxmzrr/l4xnzB4PiXLndXx4vrx19/VlDasF1NU1QG/cz+EyvgzmAliiQMqToApoem6FXFngrbJMu3wcHDcS/y9/pDmznNObTgZjZ0k0vGwzhgOeqyI0WwHTYJiStnPrK9h4WIlSSU0ybD2Ny3alEHU828gx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoTz9IoN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747122831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtkk50KB1D30O6d5m7nJaK6v6fUgkCaMiVXva7OhUXY=;
	b=VoTz9IoNhChEL0qGW4+7m4qCgbO+zQ3nIdw0ndErbs+LF2ZhRdg39FfxFeVaHKXOgW6S5p
	gQ560ne0+XVB4e8PhfHDturk82LP4gMvnEyhwtH/RnFZ5wmenN1E14H/9yUKfAMQNnQjeL
	bezoyEcABje5cORGw3O1IZXdUcGFmiU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-5sKCN0ibO9OOeMzgwbQSVw-1; Tue, 13 May 2025 03:53:50 -0400
X-MC-Unique: 5sKCN0ibO9OOeMzgwbQSVw-1
X-Mimecast-MFC-AGG-ID: 5sKCN0ibO9OOeMzgwbQSVw_1747122829
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so21258085e9.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122828; x=1747727628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtkk50KB1D30O6d5m7nJaK6v6fUgkCaMiVXva7OhUXY=;
        b=SwTABKTfMEgitgkC+9UdCWK59k+9AcJQeM/iVka0rUDtwxWow50nejSXb4ko1FaIEY
         yVAXR8SXXqaViMgbYNSTPav1yie6F9nwi/Y49twuOAZbvqTkwPBLEXUcYJeBO3coidRb
         EeW7I8JYOmo4RooE/B7VuDHXdh109qCuSPLdm0A8RhWV0Lqe3V8Guw4eNCo+r+wBr3Wy
         1t4C0tdjSavh1tujfbGTHTObfrDhtwEbcDBVa8/Tr4HixO90kD9UtFB7g+7Gw2LnEVq1
         Ny+f51K2LI0XqYVzezp/pA6yNPuhkdpdq8nmkRNsVXvKGa5cE7wBZq/Irq0Z0cFXqeAk
         XQqg==
X-Forwarded-Encrypted: i=1; AJvYcCVieHbRCuuMw+vDSwoI+vwA3tJ7RdDNN/vkzvqbupEGkdqMA1K7Kai0MDTguu1k6TN3JO1mmUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfRGV21Dkur2XVHOeeaI61LIo4opjtA+Q+e1tSm5f97EfHJmG
	wfmCLGsbhcGdsydcpSC+MT4d7hKp8hrRR9wPg07df7GNhh1G2ibSsNrH8mUf6VWbATcniaVfc2a
	f58YOrKReMpi3s33Hp7xdTaKfrPmEllXdOwEiOwuEH5TbGYiKtG5l4rkAAdPQoeMR
X-Gm-Gg: ASbGncvCaA7gakbYO/kSlqpFQU7eCVoLX6VkPjFUMrGzCPhV5Q/Yn8Q1qthbGpenyPr
	/gIP7qENgpPUVcUIkXUTdnfhjXadfWDW8TyI4QcHqIqzCwCQwu5TilGTrFSHi/ChbQ8gkt+g1hq
	aFPzlDQq4Pzx7BfaRlfy8/5qkV9bDnvxZbIUaNWOlj2d44l4Hl3Q5s+j2gotaE8cKjwJQu28Bmi
	sadZdmMfNny44p4bgefOrgGAeymdWWrIxjHiSOPOid/fxryrS19fYnHIYm7rdHXx02MqtthxW65
	sHiop7b3LE/mIMDnyBg=
X-Received: by 2002:a05:600c:8119:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-442eaccf713mr22456495e9.10.1747122828599;
        Tue, 13 May 2025 00:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS+Wm5c4ZDeo37+oLc2ufT5+KNWKQNW9kReiaYw3xNC+kujR1vTzTTBi2VpuYMU789tw9sdQ==
X-Received: by 2002:a05:600c:8119:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-442eaccf713mr22456265e9.10.1747122828306;
        Tue, 13 May 2025 00:53:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d961sm15498164f8f.62.2025.05.13.00.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 00:53:47 -0700 (PDT)
Message-ID: <a5b65bc4-3684-4314-b88b-4b78c919cb6c@redhat.com>
Date: Tue, 13 May 2025 09:53:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] ovpn: improve 'no route to host' debug
 message
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-10-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509142630.6947-10-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 4:26 PM, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 24eb9d81429e..a1fd27b9c038 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -258,7 +258,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>  		 */
>  		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
>  					      &ipv6_hdr(skb)->daddr))) {
> -			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
> +			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c)\n",
>  					    netdev_name(peer->ovpn->dev),
>  					    peer->id, &bind->local.ipv6,
>  					    &ipv6_hdr(skb)->daddr);

Since you have to repost it's better to move this chunk to a separate
patch, as it's unrelated to the previous one - or at very least mention
it explicitly in the commit message.

/P


