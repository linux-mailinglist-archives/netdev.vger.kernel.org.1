Return-Path: <netdev+bounces-163571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD41EA2ABAF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810EF7A5C8C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F6C1E5B6B;
	Thu,  6 Feb 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="sCrBn029"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8D1A3171
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852815; cv=none; b=P2G6H5tiAxmBVx8gQRen5rt0PFW3ZsfAiDHOQHPldC60sVmH19VjAS5SsgJo9+tbgWeskoGDmmuNz6GaLipGlrYs9+LI5f2LoK1leuunW+KAW2/qSWdyXRR3je7EWDNjd0HpV3qDdfl5EK7TgdtTdTctjci/5zNs6xace01VDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852815; c=relaxed/simple;
	bh=JpAxptbFMmyvPyTMd0gAMzXIKL0NcJG3/A4LZYoGB/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iN9ZkSSTuFgaaA6Kv3d47sk9Gu4s1AWhuyYn+HQDUrU6S57OULZEB6HZiAvOXMxGNJ5Qgnr+DCVi+Oyf0KwXmkuJKZfFm4JYDdVsxCKdd6A5YjctwnMmpQxHconEvPV1MzsjCSqyg47WN8bSDLN4A8vlUps6oXER52Ok380Dots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=sCrBn029; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab77e266c71so60919566b.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852811; x=1739457611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaF9oK+ht+6PJAmQa8x2eJ5jIN8d/CbjvcAD/HIVPi4=;
        b=sCrBn029BhjtsO/DxGgNgmMUmPc7iFLB2gBSREVV8cGvrOeDOqYoTHAAP6rIoAcUu5
         SpYfBVtWDHs7NSfEKod6rDPXt8fR7ya4Q2XeokVLsNs11AXbgOnH29Nvz1E4mHpdRxau
         tn0E+9DQrTqu1q/WGmJBh0znqUcWkGQW/bOM+VTaVCuLKSzH0bjR7TS5lTVk0c9gJjyB
         rOCCcLJzTFkfA1KoW4x0QxiK7IDCNSAj+iLtOKJY6Odu43VC1UpnnrEbj97OPKQwvZk9
         Ek4dy1bIbJ/bNhts//XYyEkG7tTrbXP20fhvYkC2CdDJt+B0WAZQrLbJh1tGJmSVWnua
         g26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852811; x=1739457611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaF9oK+ht+6PJAmQa8x2eJ5jIN8d/CbjvcAD/HIVPi4=;
        b=j8nC7hoZOjIhV2G8fzRIwseT/YMnFgT9uSFlRDxiuCBqXDwBRHksZmwQm82Wd/qgYQ
         /q2sWJ6Kmmz7PhQQAU9WtEJLKN+fH2Qf26+IbkB+dd3J6hOYme6F+af7UmsCkik+A2Ro
         W+HKj/girtF00jhNxEKfKoL8+0M9fpCln1O4nnddSMRmNdd7v1tmlbWTyM6CoulsFDe1
         tpj48XpN1zQiyNCGphDAN1AgcsAcIb+Y0Hky576Egb4hSezaKqpC4BNYS05lL8QZOqvd
         a8BtFy1kWkJB4yPovPunAr29+b4iQkAfOr50KX/buFfQcES3vqIVpNorwSMe0jo0tEZl
         UNEQ==
X-Gm-Message-State: AOJu0YzKw2vQF8bGcSnrQRiFwbJQkPjL6MkBFB5iNKBg9a76ygmFyf5X
	sstP7LDQ7CaUbJdRuNO/wQionLVMsLYfrPo9a8ZAcIPBPzWt0jTvwPHxGvyGKWA=
X-Gm-Gg: ASbGncvI34qdkzKIwImWTIu0VFsIR46vV5TsvC7VSq3moRmUB/KBLR7lIZ4D3uAGIR3
	m2tA3ewPhj3+p56ZB2ISXr88mBkFGt314KUPI2F7HCkdFVkRLzB+/pzzGDmDE1cSS5m8MHn3Rlw
	YBGjrQij0cy+oIvkdkrIaOlllMHO2C1a39aUkm6Ozp175YEaF5kojZC+aSbkLNGhvmdJDeJo9hn
	TyCNCbtyFegv7vFuB5CTC6GvIDDCYJ0K8Zrr1FSKVRfTILEs8xrqahgD04G5pc3m3zWz48Y0HW4
	KqQS9d11R45JC62gYZKDk68V4TzQYuUvmlyPupMd66gmF6A=
X-Google-Smtp-Source: AGHT+IHgsuIEgT7GkKcahm86w7XZdDg7vZ/AvkvTuqQKdmdxISVptZgStfdEuYmSzkdA2CsT8SZ/Jw==
X-Received: by 2002:a17:907:7d90:b0:aaf:74d6:6467 with SMTP id a640c23a62f3a-ab75e347a2dmr784608966b.42.1738852811550;
        Thu, 06 Feb 2025 06:40:11 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7826ed43esm24954566b.58.2025.02.06.06.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:40:11 -0800 (PST)
Message-ID: <6cd38146-aec2-40ac-9372-13064dd99363@blackwall.org>
Date: Thu, 6 Feb 2025 16:40:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 09/14] netfilter: nft_flow_offload: Add
 NFPROTO_BRIDGE to validate
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-10-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-10-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> Need to add NFPROTO_BRIDGE to nft_flow_offload_validate() to support
> the bridge-fastpath.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


