Return-Path: <netdev+bounces-163570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B43A2ABB0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2491C16BDC0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63D236433;
	Thu,  6 Feb 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JWdmmSnz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF223644B
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852785; cv=none; b=UV98/hvtMGMhAX+odxA1iCoBaa/zF0Gf5bB9onYHKAXzx07tl9Un7RcEUHpv75vNkmipmDDOiEN04fkidwxjFG4hU+CdtHF+IwHHomaYx9xkmfzTa8aCyvtA2fE3p8EBXOmqS8ZHQ+IXfkW8Dq2lCwocLnf0kiVtemcL0NBydEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852785; c=relaxed/simple;
	bh=czZSa8RE8rPjUA6bt67Tw98QD1nGxDQA7k8TsCfdCzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtIs+FXpaVfzesCcLSALMua7Q6zCKcoQ3ejIdb2WhvkZnmClWboF8/EruLC+woNKDY0u3YRWXpKGWEKJ6Fz4RblnB5NtHV6OQ0RYIFTlW+HeIgOxi2TOeArcNca/aIpSUYjnBbKb6cjt0aXuHdtvW9ey/QSsPEr40uLpDNN2pDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JWdmmSnz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab744d5e567so182865066b.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852782; x=1739457582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwM9ak9hrD3h4qVx1yCYkLliO4mOGlB4YCv6ISmSjO4=;
        b=JWdmmSnzoZq5RGgbQpuszpn6O6rOYZkznr+oAMvxumyfsRzbSEpzqR6aBqRCsbunXa
         FAgAiHFq3lWqSe+H5cw1nOEPAgTYGQMhhgqjNQsyNJrsNT0yAi+h+BhvupGYxOmzvfQ4
         eRXLZIj7fmgKXb22Gno2eEJw9qh0DTnkkUoJCezfRCp7ZXq7ekIf+pJpW10hh+l0qs2i
         69hdisIWk9h27wElBpCz++2PhbJiPLBw9dxwO2KGXL0PZ+D90zQZjQktwxvCZnxq8WsU
         iCcz/1vlzXs2Xku9lK//QhQcVGiqRcmgwQACQbq7GJsHtetRWXVex8KrWo5lt+YqNkaI
         egyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852782; x=1739457582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwM9ak9hrD3h4qVx1yCYkLliO4mOGlB4YCv6ISmSjO4=;
        b=nzONnreHGDoVAtzMLUyrPkZNIB++anCmmUZLwsFXewAWNAqmCaqf2GLKOuJk3jA5It
         dk1UoNxskURDfqpHTfFxxwPPgJcynr0VnTwEeKdJNf3WCBiInWjGoyEqi213wOlam7GO
         m8cIDx8gPjq0GqJWIbsQxPSDGifz84iSfTskowzGKPD5MNSN23TzFCgByxdEkwRMwTrT
         TcuwxNp0zIp0at/vZhstt1L77KqqA1ydAK8qwvkzur9gp4LpqvY3W/M4//Knc1kUsX7E
         FHALkEjaL3uWIwIenHvhEE3dhIzhRmjY32W8ChR+IQzogBKAMmfGAlBZv/XxUh1F4X0M
         fg/A==
X-Gm-Message-State: AOJu0YzLr9XZbgxa+XNLbZ+LIuG+cGkkE6yrvnxgpIGf4244qI2mXOCv
	fsznDJt5BLEXpkCxvN5sZeMMNqR1HfN1YNCUVNDx3xnaGwkay/weZqN5P8b0sFw=
X-Gm-Gg: ASbGnct+mZQOPLuaRqmha0h/UmW59ar/WFzFG1bsRhSw0X2IjwzQJpk8qIX2WORgY26
	JRVoTIPs6pVbZHEAb4kW0n4oA4tFlJhVdeW9qBfOrKv37lt8549xS2AXQ9QdbelFPvxSvvuZKdW
	BfecCrlMPVLkm8DQ8W+8rNqgdjY8oO/MBRAvU7RFZF0Uq2Hc1OhjAWJDwoXie5eoJq1lfguBQ3I
	L9rvbX+tjubwMuiiHG9uYi/MRbLkOr/q7S9VP18o5JftHBtaWIwUdZIuKDHTjk4fbcz2uMgyXzJ
	l+npLCiE0TZutKiFnRuLzhprXXI7V59qMRj2dYWeeLBMzak=
X-Google-Smtp-Source: AGHT+IGWp5+1BVne358ySyNOgZ1qVjbCgfUJUnYbiNP8cDVB4maBnu+CTyhvHYo+RSuyGyXRNdH4eA==
X-Received: by 2002:a17:907:9611:b0:ab3:61e2:8aaf with SMTP id a640c23a62f3a-ab76e9dbe8amr395071966b.25.1738852782052;
        Thu, 06 Feb 2025 06:39:42 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e70e7sm108777266b.87.2025.02.06.06.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:39:41 -0800 (PST)
Message-ID: <46b7042c-8284-4523-b54f-38f97e70075a@blackwall.org>
Date: Thu, 6 Feb 2025 16:39:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 08/14] netfilter: nf_flow_table_inet: Add
 nf_flowtable_type flowtable_bridge
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
 <20250204194921.46692-9-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-9-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> This will allow a flowtable to be added to the nft bridge family.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nf_flow_table_inet.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


