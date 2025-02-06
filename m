Return-Path: <netdev+bounces-163569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF50A2ABAC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F47D16AA58
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC01624FF;
	Thu,  6 Feb 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="nS58+4LO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303E236449
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852765; cv=none; b=oeTVSmI4JGHthlTvWgUuKOfFkAHCVlYyz5XrCCD8C4JC51jcRdOJQioXSB5S7skdOqwlP7XV7v4+rpI5uGzmnMzfc9PRrbVrcxummkYOOjQUo2K7Z/YnZP4IMS2N94gRX5pPq3DzIyQ4/R1YZkxusU2rWBPeBzgNZviANjw2E2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852765; c=relaxed/simple;
	bh=Uu8aEP8VA8t1pCN7nvIDtXe9YZ0sStLUfZzdpt3Xdwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COUqeYSh+daDYPHhnEjswrYtbyRUsB6lLxKJugkoYhWu5Hln3YKK6Ri3G+9zNnn0aiu342xnLqaFHDfK+tBXrVllk3wQflKnobTORh+8VGLcFoN+xdKreOCyy704YqVLfHIO9uUahtjdvkp04JapEAhS/jkjT/bgJxeSsM4bOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=nS58+4LO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab77e266c71so60767166b.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852761; x=1739457561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THjRLKw27fymwkm9c9udCcZ4ry8EIlt6eJdjpKX8aMI=;
        b=nS58+4LOG6u/Q5ccdch9G5EWZXlco1ayiEjfSMtXeD4KHtM0gHL3VN6RGk38uCmt5t
         Oc1QT11cxpBtlZ7J6cMHsPLGuIWjxT8hf/GUer0jGV6PneXcnspl8Rx9f29MHYVY1knt
         BODAkrTcImAboCfJIwCA7ot+15ooIr7DmrqOX0VyCEkeDCMNx1Q1YlaPhCrlwMKtE6qG
         5vMd9IF3RURy/IG87UyUoWMOoDmZ4soLRScIXcgoTKVgUouv08GdLpqzxXE6rIfwPhwx
         vd80oxE8H8nGLHk2HHU4TJclxaz0kZi4YTpb3h8w4X7fmMHz2ouYinsEs6FF5XwqF4Cv
         UO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852761; x=1739457561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THjRLKw27fymwkm9c9udCcZ4ry8EIlt6eJdjpKX8aMI=;
        b=XwVpBNHxi4lOGFTprBgE0jC40IakGvAl6YqK68KETJ5EoyXAt7yX6z/ozOttgbqigW
         3ZphyvUv3huXb0tghttgG9GGpXAUqo8f0GGukXhWV72ANis4wQ5NtlYjdOVXAQgMz2/Z
         mbrV2y7RysFNTxzswESKa157t1WTnUJUStcMVD6I1CkqsOHYq9FPqKhr4P1cnYs+Zeps
         4IWwhkrMZXe+wc+CgMMFwtQXE4dedTly9cmKajdnEtjuFiAUFm21mQtpetLo6h0C65or
         85W8tpOY1YNAp1XD3Z8yAD+XkS55LTs7ybv9+OzEiGBvxBWwvkf/Vrk4Tqp1+/Q87kV4
         Gt9Q==
X-Gm-Message-State: AOJu0Yy/WrpptdVpeW1m4zdqJVwYrWYNSZzRZdTU6H9CYHJ1rJRfSGd3
	ibnAJ6dnnimWkKS66U8EaMVnd+dKBs76ySBT2CkPHt9VR269Wmakw+QU5VtvxcA=
X-Gm-Gg: ASbGncvWBFnya8k7R+vBlVRmrxvSbANxhziI2BUahffbCiPn6DcUwbFWtpZNzZayw5u
	T4i7yFm/LQo+Jn1W9GubI5n3IJSWrJVXAP/DKlWq8g2qBLKXXW4xJMBItpzbn9XjZ04TL8OoLDs
	AKb1v+mv7+GpcpjYzYHFL8sz9jydqj2b0mIVX8NdgRXhk4oYyBd70vDKJgywWZCIQZbNCBcSQ1u
	dG4he/PUnM5A5bw2lZf/CTYdKJ20/KOgId4zrdnf+As4VbEz/qrjb5eC0Yhw2BMOO2nTuVrJ3KO
	z6QXa82VKDkJ4wnDT/rc3RFiZTJsCUEbcsEUxFacmVHc0k0=
X-Google-Smtp-Source: AGHT+IFlbmeulV0zbsnKd23pIgbY7sXFFTYPJ1StMcXHIPOGJvEQyfJ18rL8z1Xxot6BGyZS0rrfLw==
X-Received: by 2002:a17:906:ca48:b0:ab7:6e14:c03f with SMTP id a640c23a62f3a-ab76e14c0d5mr312575166b.21.1738852761390;
        Thu, 06 Feb 2025 06:39:21 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f843a9sm109650266b.67.2025.02.06.06.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:39:20 -0800 (PST)
Message-ID: <114ff1da-c7f4-4851-af3e-1a4fdabde9f5@blackwall.org>
Date: Thu, 6 Feb 2025 16:39:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 07/14] netfilter :nf_flow_table_offload: Add
 nf_flow_rule_bridge()
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
 <20250204194921.46692-8-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-8-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> Add nf_flow_rule_bridge().
> 
> It only calls the common rule and adds the redirect.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/net/netfilter/nf_flow_table.h |  3 +++
>  net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


