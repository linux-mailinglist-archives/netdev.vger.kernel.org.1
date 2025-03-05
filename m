Return-Path: <netdev+bounces-171940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A492BA4F896
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0903A035B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F451F4611;
	Wed,  5 Mar 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="EBExajNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EC1E5B9E
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162825; cv=none; b=sZx/N1vbnOq/QAHcpz8vp3o3872yhqZ+2cDJJasbtRxY6mi1T1gutth5plG7LGnNT9Inncc4Z2rhkTr0pCPS9K2hNOuHLdgFVp38BxBDzxdDbyIsqr1o99EGnSF5r1uymk9k8CdO/S38+4s1ndImFD5VYIgKlRdXu/SBWnCWs7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162825; c=relaxed/simple;
	bh=RWpWc+faJ0YZsTPx4jkXwG1vJYFHTnCeCj6HQ2ZWZ8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiVO7ONyc+vniUsl668B534jSRB1+Ul385S0NgsBvdJMIiJoXObW40ONaK6E2ap7rIkpj7fycKzsCZXrGaYsvwM7O/pV1ehR2hWaK2fsy/xZZbOqgoS0Vz6BactflOjJGrOGOytvcIYzYoILFlWU15UxsisO7i3WjsBi1F07dco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=EBExajNi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so423939466b.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 00:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162822; x=1741767622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZ9TMmWBCnKwhuUOANBJp50uacRGJFZ/d6Ba0SS8K6o=;
        b=EBExajNiIM+RE21rykwHM8Hsryx+hZ2qs2w+FIHm/MFasRGdr1njjv4vx3ODuWMYVO
         vvU5DVeUATrMUTl9K+fQqZayCq1QOjmmsuxXeTrFaSj2oc1zF5ytNjPfYkyZOCXDTzr/
         do9YvSsbGQtq6r+sd+rfUPdK6vT+sPFZSriu8dZJZH6NlbGd4MhQah8y+/fDwp+iX0ye
         ZAKPvazoHzAm7ZUmPdEAfG2gkd0ou5z8VXAtrlehL8/CKUxW/wV1fcd4Okw6swonSdkJ
         /GKzzEADKyen3YR8wGmLDf0IWhG609nWsNx6kJEJobP4maE7jxqxnwGHWTCMLv2zr+b5
         FPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162822; x=1741767622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ9TMmWBCnKwhuUOANBJp50uacRGJFZ/d6Ba0SS8K6o=;
        b=d4r1BGC6CHfhzhwOEDnqx/iai3p/nwdqTY8kYYWztAmB8+UepIAQf/TEjwRwLYeSjI
         Bh26H6tdHCHcynZx93DbheFdVW+GCJEXyAHZf4dFOBwjWXUASQe0rj3OWJSlLEc+MdZm
         5WEsxFLYAxRF9pdnRiXUBTwzpUfYF/cBMfn02vMUOM44jQ495WIBCZefCJ+uPhUd1b1L
         MJdnC/iNI7tiKcJ2tJvtxIZc4hInIvn2O3NEEaPTOYCjbLQstZrjig8krdXslT4Y/Mni
         YNz7e/m3f1Q+RXdrlFOOKsjVT4eG4ZWQj0WtnGuFZ/OYt36izK4la8jheHdZfFrAhYXa
         ZIBA==
X-Gm-Message-State: AOJu0YxNnd3ucRFMRanmBag8ginGKVdqIU6Fl2zA2L/WlLm1EA2c6h/W
	93HietFb4LjZ+7VyIM+OrGUH3JNH4pmYrCWZEcfMcLXDJUhSl/g4Pb0kZEiNpZU=
X-Gm-Gg: ASbGncsfwvuBY5+3MTQRgc64NNSXFtIx2yNBEz3fnvzVDMr3nsKpMvlmhga0GpJwlNK
	UMyE80j04jy77BOjoRwt+E2mOX9U+E0rzocKJm53+CNq2RXTVBvHteV/DpDvLwoysE6LvQxuatM
	7kij5kEzbiB5dpTeHfldSvRwxrDH2f9ZJ4HgDvfKL9wdt29e72OcTWAdjgjbc+5W8WCjDceu8N6
	RxE6a+hjO39Hj2P66YZuXqyFksqLWpPr/dOI+As+J/iwTFgDtxAdSpDQ1NUSfttXuxxdF9a+TH+
	uRE61XbtJG/onivALJsYO8bKFZYfZnzKER+WoP3+y+kUHMS82Wo7/iNyo4dH5CJzEJhKcJO91L3
	R
X-Google-Smtp-Source: AGHT+IG3uX4osOFdkeIE8BVoOkaHQ2eM06ismAlJEsM6OrJRVb5spjiMCAH7SqlSZ6VKBFc01zjVCQ==
X-Received: by 2002:a05:6402:2714:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5e59f47ced8mr4078134a12.24.1741162821234;
        Wed, 05 Mar 2025 00:20:21 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3f3bbfb3sm845989066b.77.2025.03.05.00.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:20:20 -0800 (PST)
Message-ID: <2690fc33-0646-4aff-aacf-2760706139e1@blackwall.org>
Date: Wed, 5 Mar 2025 10:20:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 04/15] netfilter: bridge: Add conntrack double
 vlan and pppoe
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
 <20250228201533.23836-5-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets that are passing a bridge.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
>  1 file changed, 71 insertions(+), 12 deletions(-)
>

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


