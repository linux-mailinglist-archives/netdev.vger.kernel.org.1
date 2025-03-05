Return-Path: <netdev+bounces-171942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BFA4F8A6
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5723AD53D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AAB1F4282;
	Wed,  5 Mar 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="A2bhTYH2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C41DE8A5
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162898; cv=none; b=OoAGbmj+pqVWU7SR+IXhD2WLnzsKuvPSZQ1S6ybv926k10ZvVZkednw5kI0VdLQhr4ceNjVsBhO+0UYTauGoFONhyIpZrvLGCZQiEhtgNwdZ91M+bcyo94b4vNjpLLWRdjXZbAdI9SCnoxvjQFFKCgBw7aJeRvKGOZ2nqEVItZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162898; c=relaxed/simple;
	bh=Dd3fU7x3Zyy9J91IPT2gBtr3RmiUZhQvAeaOmlAbIPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdWqWr57aHkhHl2Oo4MBIzKZL52B8oeU20J4I0dgc3WSfQ6td9nXA34dQEht7DKev0isLxWG+9MHf5nLbaNkX8garBqBOhwdG6tCs5Huf+poG0E4X/7g5sHcJ9j8dVuhTfmOq1bnIsfXna05rZ6whkTvvTJPEjJPoGIuxdmzU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=A2bhTYH2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaeec07b705so999277566b.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 00:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162896; x=1741767696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsv6iruxF/55s5GG7wPPBagKb4juSNlpcghKgAFq1qg=;
        b=A2bhTYH2IUKPMamHYkFV5kaQY8j11XM1Rkzkh8OksbViihKIHdIyYaOl68RIpO6mJ9
         0hS5ZGLixOaBzMhOI+yG6WhYFTQ4GvqL9Nc/G3etuoWG7vQVXGzS+zuwOJPAXifC/UTl
         XF/kDOlaCo9md4uupo/S3HQC0igucI4fKqBDm52qzqnPbGZwkujc/SsZj7uw3a/yqdsK
         R2R5d+LjtiqUYkiv8EgQiG4rLJm21gZmemC1eIyLxXGlwhxKO3jmhAf8UIXj0PwCpkfj
         sGTOddwdQTN5kI4jOrmHFMWg2zZHCLBhrGM/Fzp0lRv+M3RkPsvVT00gLuCjUT+aoHAy
         Qp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162896; x=1741767696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsv6iruxF/55s5GG7wPPBagKb4juSNlpcghKgAFq1qg=;
        b=NciIYmyjdK+I40IGad59sUTHgOqSYUlP6hqsjXy2Io9KKS8JYUs7Y28jNqLVZbytTm
         ng8PI6eb6T5NYK2RV9Vs8piPzG7RlCM1r7UdOv3JLOS0UPpgufGFisAaXKvC0zKZ3FW7
         ZwgshpKzYeOj05Dhh1edx/bPeK39mNGlMzBfPzr7890cf3L8rJByFoljxWvbC2FaEld9
         ln7NWxtPBaKe48JRFcBRfIU3eH5APcWsrELLmomTsHmF4pFopEjPGG24MC28WjgfhS1/
         ZU5AtIJII+0dhkBhHnY/+TXgLw2xUzxHNCclx5hnzcAi59bsqKzRWeCvpJKgdTjEvco8
         Lfxw==
X-Gm-Message-State: AOJu0YxZfmUSM+fvay8n1FxPHxNTLzOGI46yhf22icgef3BwsVqTXX8u
	2pDOtGr5342YuWCAalxo+vDqnh/8sBZsRU8sIlq1nlJZ+25OQOTCSr5tNi50n4I=
X-Gm-Gg: ASbGnctN35EAwyOVlQZNTyTbB4M9IwgLjo269FCcJRp40laTNFwc9EEdu+tLgYwxU9W
	z7NLwclr6xwG27ht4mouzCc3nhX6fo6159yOomY0mKiX/vTi5ziIkHfH5VvmzMRpJzBBdK9hvcU
	29V4ql0HItyOgAwgNt5I8h7JSMS/5h71jBWRSE/QXo2GH03JzhAUv4QeQUeVc7IoOjJrzAUTokC
	TI1TKrnQVda28zaOal3QqWVvVtlTyYY+JFJc0ZPOqHyly/a7TVrT+G3537cMpiRm2DCf3qoDXWO
	/nR79ofgsPotOiNWIx21kHSN6INaYfa3ra/fQp77q3VuwVir96QaphwYFdydUGkg0huTbrPiJPU
	f
X-Google-Smtp-Source: AGHT+IGaoXnq3lSxzaaUwAuVfK+jenlYaXFrv+TPSgSHSnmbmoUQLeCI462sahYSphebEzq/qYnUHQ==
X-Received: by 2002:a17:907:7f0b:b0:ac1:fb60:2269 with SMTP id a640c23a62f3a-ac20d925048mr217259766b.27.1741162895402;
        Wed, 05 Mar 2025 00:21:35 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf58804b49sm693744066b.26.2025.03.05.00.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:21:34 -0800 (PST)
Message-ID: <b3b5418c-65d5-48bf-8868-2d9abcb4f758@blackwall.org>
Date: Wed, 5 Mar 2025 10:21:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 01/15] net: pppoe: avoid zero-length arrays in
 struct pppoe_hdr
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-2-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> Jakub Kicinski suggested following patch:
> 
> W=1 C=1 GCC build gives us:
> 
> net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
> ../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
> ../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
> 153:29: warning: array of flexible structures
> 
> It doesn't like that hdr has a zero-length array which overlaps proto.
> The kernel code doesn't currently need those arrays.
> 
> PPPoE connection is functional after applying this patch.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/net/ppp/pppoe.c       | 2 +-
>  include/uapi/linux/if_pppox.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


