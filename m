Return-Path: <netdev+bounces-163568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E03A2ABA1
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E1216B15C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58623645B;
	Thu,  6 Feb 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="sj28Y190"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A5236446
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852748; cv=none; b=FHiTKiQj7l4n87J11E4ylu3AAwRVQo7f5KI39erpd8sH4HIfMIw8uxV5cYLUooyxhAetsn7XS+6/Ba2lKyz7GQFPDhc3gzo3zMcNyugpwoNscz/rUT8/iZzZ7AE2FKcoYGjVxSKTJTgPsRyd/zMHLkMh1Xi3dntX7nK/oAMMuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852748; c=relaxed/simple;
	bh=ISXGN/k+kX7BuDCNrato4yYtVy7+BXIuaTBPg+6KtsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf+xVmYv3sv/c3Ukf5a+BEz5zeiWXmEMrCEjJnHRXtDEstz8pEaUt/NW3oZPmknK8++o+qKN+URMziWTYVtTFMFXWsR49/UfmCpDiv7Kf4MMFHRkxn5YxaQUVyr8VZ77DQkoxBlYJWbzvYHvcnoYvM8qdJ0kzjhgU2XFsROggMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=sj28Y190; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dce4a5d8a0so1697067a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852745; x=1739457545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0JkQI3U6f+a8v60Ya7beYBhUDwWewUAZsXtUyTx0ac=;
        b=sj28Y190ZWUnke3mXhBKqYOJYbdhMa0A2ghzlmCVtvr0hOmCUOxMC8mP4IR8QuuCMt
         zkLcvBspqAEdNQpX0Nnu08Ax+kuLBE0m51+33u1yrSbaJXgYVxDdfsT1vvA2DeeswjKT
         +tHgNclcpn09FV+Vd+qKX5xSb9uzGFrpELKMicmW4SdrYw8WgaQuFOMljzaSC89tvRqb
         jxgpiSu09FLGpxDaXZldZ6MsKnQleOV8DfwoArpRPIx3iPvBWNHKUc7dft3kGbxa3HSX
         MfrOFTrwPDedhP3yV+VPNtvlHAvEyE/mhu/RQDCqDWP3PQ4Vn63UfqiAj3j0ievDfI50
         osMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852745; x=1739457545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0JkQI3U6f+a8v60Ya7beYBhUDwWewUAZsXtUyTx0ac=;
        b=lzoc9wyNDBU0XcopSjMpPh5MvgpFB3GC3NpvRJDlouhI3N32UPr3RfiMy2uCmj4sJM
         ikaJQ9md4R4ehT+6+bp2nnjr6sLM4qaekBAItWOWqHR1es537MayvPryWRJk6w0Fc3ij
         3tMahXia+QACHJiAWCRE0dtsLjuBnrFY9jlgo1mCQ5TEmVUcsVVexaHmkR6x2SZf168d
         cDRxlO+RCM4m0qRJul4NHgWAsWLfL1ziUybWUOnql8lgSkvaXJCOiEpLFGK5x3MmtZCY
         PGLt971IzMwtSg69LAVLHcP4PLTA+Z6//Pd20zQp7A7tEoafHSn7ObCtMyTaVd1CsTux
         FtcQ==
X-Gm-Message-State: AOJu0YwbwAFHzgEufj/kUK+loQlbt4GPfkwT+gwpAscM4Z4qsQVGOcAJ
	yzMiSOEMN6RixyqCB7WVzUe4UgwxQJf3/o45XY/Urrk88NX5Lpn/bM/8dHPqp2A=
X-Gm-Gg: ASbGncsMHF4kRnABNR4ngmCeg8adrHjDXXiaiNMjV356FbFdLRGJxbg/4GyMgmff8BL
	6BHV0gyj/MJp7bMZOcO7Fcmex0WIbTiQ3Jju/n2/UA0SL+i+dlKASDAaIBWULkSBwAeMEHW2cDc
	ws8ixSF5OInKJh8BWT4tgZJUhakSDfHwMWkFy0YgNZOlCFvSpRy18zqd7/sy7jh3KTGEiwLWvzp
	+YvFof2dLDtE0w1E+wfjcW0cHI6x3j63pd2bKqHrzKeoh3z2RV37cVtuu5P06xLnOUJ3/KkaKIB
	BbblNQ3rFfteeEmT/05NsdTbNtuPqiBzBE6AHzqhZowwgmQ=
X-Google-Smtp-Source: AGHT+IFfccbgqNHY4pVflwA0HY/1yvIqL3O/a0V1EXaUtiholMev7dwDOL+lRjcs6CbBMFf4cXAhig==
X-Received: by 2002:a05:6402:2812:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5dcdb762d40mr15968196a12.23.1738852744810;
        Thu, 06 Feb 2025 06:39:04 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339349sm107647866b.146.2025.02.06.06.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:39:04 -0800 (PST)
Message-ID: <98c8cbec-28f4-4814-bce4-e07101553f92@blackwall.org>
Date: Thu, 6 Feb 2025 16:39:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 04/14] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
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
 <20250204194921.46692-5-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets in the bridge filter chain.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


