Return-Path: <netdev+bounces-214367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1180B29278
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862DB487018
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61183221F26;
	Sun, 17 Aug 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="F+g5/sZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE11DF74F
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423614; cv=none; b=dHJTN+a0UGcZB588XaJeaM0rypL+fg9S/aVOji6/1EiuzgHRGmLDd93zXXlxe2bYNcle2sF1n0GQz55G4+KLI1IZTzHm63mY7xBmbOYVB4YGFK+bK3uBvF/e0NcWuuP7LOEp1FdU2bzvaIUW8R/YhoRPoywms7R9RmFY9mhfFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423614; c=relaxed/simple;
	bh=Y4b1Wey0Bzm9RnN7kiOzeEuSRoMo8KgO6GcwS5m6utw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bh0GcEWVtortwCH4J5W2cc5B6t5qYWrj3Yuzbc5dFmUkMTsiRHjQ6g3xcbmZt9SX9dGqTUVoPKiVhJVpj0uJUyb/T6DDh/iG9QzrsOT9FXj6aK7aBXHHIRRV7osFlaYdcZRzTR6NrRKUJ+P7LbDUikui1d1HOf0p+FIk8Y1423o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=F+g5/sZY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb731ca8eso536140766b.0
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1755423611; x=1756028411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qm4RPaa0FhsIq5Gi6bADCpXN7OJ5u1r+9fgBroRfJm8=;
        b=F+g5/sZYU+qjFVW0JAja9naKFcPUaxs22UPXqIuFR9yM7505RJjmzYp+Q/hNYtT9EQ
         zWMuEK7Rx+JQIZcfzoW44iYMQVxJ9T9722OBLSmPXG4nMy6R1KzVVm4C6GuorFugKs5L
         KlSziuNzgQ6berSsRR8o0KyFbKqghi6XkK618wqe3JTuAY5itwAb0Qwkqx4AvYxBzoHF
         Yr/Dsp2rKlaRJ4Bo9IzAfsAVMzE8obWoXBf+t85s6O45YcBpZGdasJa7D0B2QYcmmfyh
         KdnK18NbPXNA9PAus+pDRL8fb6ruDgjNpyk513h3VgQorWxqQRbbHcdsrfXwcXZtXW0m
         BYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755423611; x=1756028411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm4RPaa0FhsIq5Gi6bADCpXN7OJ5u1r+9fgBroRfJm8=;
        b=wkD45uT9NUnrdNUT4nq/CO002KxZfbz0KaZ8LozzG34kK4aRniQP3hyJhMs/iUENwo
         93/viQKB5JCg2iPXYg2Rx6DzFLddwNha/kkY+WM8iTghp1tdxcetYKbYn7x446btKYSy
         ceLo76RlOw4EhmeIDBAiGfkJhG0Rh/T9vhAK3/LIKpbqPnD5yZYPF9MQ0DBQiilHraNa
         AAC9xrG0qU/JIAN2lmJ3ok/cVaPYWYIN1uZyNkVeCyOA+2bjdg3EJg8PB0x6w9N1xpkP
         eKrv1eoHuWTa79v2O00U3oPDTFB4xE1+ixNEmVVyQcE+44blBA92L45G7L6AnDYMvcas
         Ia0w==
X-Gm-Message-State: AOJu0YzvQITVoajrPKeeeNspzMOP+9RQMAO7ewrdMv0lGIlDX/qaIdsF
	XBlHZf3ohOPtHdTq/DKRnUcW6/hnN73HSSnm7iSmn1vAHiDcWvPoQcqvgXMAAh7CDBk=
X-Gm-Gg: ASbGnctM6ZQNb1mDV5JY25TjCZrrSoeY7G/nxIxCQ8r3rIikJVEgUqGSyZdImQelNSI
	SkmvV5IWLbp4OQlzcR5SnKOHd2CV9uXSvsFtHchR2k/Dm8Kq4/e5FjG0wH/BarcxKScew2Qt2BI
	qaqXUF7tw4El5hQTutmHJtXOs0NPGh7A+22JZEGGX8Cr3KhchTlqdyWnfOREw76PMmhNg3vFpDm
	Y5OlZIHfNll2GBTUWJMSP2cpwbfdsmrNMkidsd+qcOY2s/G/OoLzjMEGbeCTwlOUZQoHFxFnzZy
	1cKioCVicqUkVRKLc+udeJ2c1yZjk4SgWEgMCJolTO5cWOU3nnMLqsGQp1vGW33PqptBQC3AiYM
	96Oux77PiObwKrnV14L4+LrCiP8S/lNfKBoTrYqCkV5Et4Rp9SPxWbA==
X-Google-Smtp-Source: AGHT+IGHLSmc20FUaq+pXnAxbhs85W77k0jJB8aw5RuDsIYFk+rfXk653aRmqm4W7siVHq5W0hJO1A==
X-Received: by 2002:a17:907:9628:b0:ae3:6d27:5246 with SMTP id a640c23a62f3a-afcdc3ab857mr701920266b.48.1755423610813;
        Sun, 17 Aug 2025 02:40:10 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53eccsm565094566b.19.2025.08.17.02.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 02:40:10 -0700 (PDT)
Message-ID: <bf2686f5-21a5-4654-9825-c883a626baad@blackwall.org>
Date: Sun, 17 Aug 2025 12:40:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: Make nexthop-dumps scale linearly
 with the number of nexthops
To: cpaasch@openai.com, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
 <20250816-nexthop_dump-v2-1-491da3462118@openai.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250816-nexthop_dump-v2-1-491da3462118@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/25 02:12, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> When we have a (very) large number of nexthops, they do not fit within a
> single message. rtm_dump_walk_nexthops() thus will be called repeatedly
> and ctx->idx is used to avoid dumping the same nexthops again.
> 
> The approach in which we avoid dumping the same nexthops is by basically
> walking the entire nexthop rb-tree from the left-most node until we find
> a node whose id is >= s_idx. That does not scale well.
> 
> Instead of this inefficient approach, rather go directly through the
> tree to the nexthop that should be dumped (the one whose nh_id >=
> s_idx). This allows us to find the relevant node in O(log(n)).
> 
> We have quite a nice improvement with this:
> 
> Before:
> =======
> 
> --> ~1M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 1050624
> 
> real	0m21.080s
> user	0m0.666s
> sys	0m20.384s
> 
> --> ~2M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 2101248
> 
> real	1m51.649s
> user	0m1.540s
> sys	1m49.908s
> 
> After:
> ======
> 
> --> ~1M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 1050624
> 
> real	0m1.157s
> user	0m0.926s
> sys	0m0.259s
> 
> --> ~2M nexthops:
> $ time ~/libnl/src/nl-nh-list | wc -l
> 2101248
> 
> real	0m2.763s
> user	0m2.042s
> sys	0m0.776s
> 
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  net/ipv4/nexthop.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 

Very nice,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


