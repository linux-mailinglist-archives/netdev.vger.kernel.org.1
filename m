Return-Path: <netdev+bounces-233495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ACEC146D1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6E2466D4C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB930B511;
	Tue, 28 Oct 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN/IF4hv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6930ACF0
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651798; cv=none; b=ZH5ScSG/FA33mGn28EypOSy/DznItr2O1tK2CvgbvEsPRTO9o+8Jqfb5C6BKe0Z9s4dWKGpbOodU3oU0/2AhPLa/FOjYNCO9sa6A2GnXUnHC8Yoa9glxh/iuOkymyieQPPlDhnFCi5d4yVIyYZ5tD4uW3Y7N1UI+GrvbpdrKBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651798; c=relaxed/simple;
	bh=yGVq8gF2tUQexob86KGNBoc3W0yZw6td9K+Fy7ylHo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGARqr86USPU8dSFVzJ7FjH4e7JhiewPa9hepNIOlSWqj5UP/hyRYU7Oen1oI7aUHn5Abg2RLeeaOpQ3JYwe2TvnO3Pj3F8OiuoaC3wfOea5H1Slt5mFwh7H8RgOl1d4tjNITIRafilWaDp0soTuoA+CdtPhZbKSLKIHI0ap/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN/IF4hv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so70890166b.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761651794; x=1762256594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnZs2RMUETbMZcfBovNxnautSVDoIsvh/Vcc2VRjKM0=;
        b=hN/IF4hvDxuuXsbRaa9PL/Is/CtrzJUsQwfHUVvAcvaTamtVUoVAn6+gCdFiTJcJT7
         K79egEEQGnKbah9N0sOciTo3v+ZkEAXWYL4dnJDum7CL/+bEnrUA6ijFhDIK6tJpw0nB
         XaqanuqgFCRTd6B/baa5cERb0pH5k862iGpiVAilJGxyI9dFG6yf2P75Q3MYY2yVUXTa
         njtuxGUiAWcezijrgnB/4T5Wnh+IU89XtLdP5p/cuxCrOnhFRK55mhZ1elVpzLCDhk9c
         8vOWvI+O4lEU8TupawjpK+eVNUuuPnnN18mNE9RhTYVl1yxQR9IPXvwz0mALPQWQpWrU
         iqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651794; x=1762256594;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnZs2RMUETbMZcfBovNxnautSVDoIsvh/Vcc2VRjKM0=;
        b=XxKMQXeAERDyX0i2c8H+49YlsmoImQ3G62zsaZrGwJL0MwFHzy1UYlKIC/S/+vL/8P
         JByKKYCOkbHJDUsohWSHqNR0KllC6LQSubTM88iFTWsyifpP2qXP8xRtWh42HSeUFRPQ
         ETFENS/Dt6Uqy8jy0uLaO8psBbJLh2CCr1ppPZq3ZPSkJDrGCoaSNNgWz6/K4diMcDKf
         YN3FQ/yMYIk2l7pT7Hhq3au5D70cjD0zi6+8M3h5CgM5n7sWcN/2oB7s65q3TJn+CzPq
         aPbN0JEkujwymY1rGsJeCtDAOkouAGKO5t4hmFPPhKtpL+Uth8qebnvbYb9yQk7zn3sW
         /18g==
X-Forwarded-Encrypted: i=1; AJvYcCUKQ1FeJ46MvL3+5162LhU1E9H3I37ivTZUj21F2wMR7kMckcGrdZmMGJDW30ZGkGCLM83w37U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0SFqtelRQ6KpunyzXvnRSYXDQdm1Qfc2ifVdiygqi8LGm9Gb
	8AApU0hgeX8xNoBvWrhqlqdm4ZC7ttWNaDaj/0BQiaoyytKtjzicRfIt
X-Gm-Gg: ASbGncuSOcsGYFOXe4bX14g33lJSGRa9tQkW5nJ5SzKBOvIm+JqxCU7ciAIfr+Q5ugF
	waJ0pAG6Tn/UecPRoq6nQyqgQ9UEiQCLeDJ8iVTcb5EhB0svJm8n2hr+/EC2ZQ2zAOo4/oU0QXG
	cxXlICRc0NPAN+GohCKeRA/j5W3ePB5ZUUZ++lZlgQUnnmkxD7oofvG+D8CyVxLPREvqFHW36/B
	AXdcSejtJoG/o4KcRANBQfrwof1B8jwI8EMzl5PwOnI7CbuvsilUznYQ6srhsduKW7a1VQB0WlK
	eyM5wc8shbKiShgBVdYZVtpa/QUjB4O9s6O0hJo2ApRxyhdA5IMUJWkhrUfS99SbE/3ZKDxP3/H
	DjruHuyJ8JMNRkZv3ZKtSdg8iPHxLDKgMDK1Jl5prNXzSEUv2UD5G3zQacqXt5wNGOFVIhwYZuk
	TeGQPfGaMztbPrQ60kE4BpiNnioW/xWtLU//PhTmfNcVLd312oOL5qhudHGtBRM8KzLVOgzs+9b
	wYnCjDX56TFmskRkNs6liRq05j7jmyndkHok55ZD/IuyPY8jVAdZw==
X-Google-Smtp-Source: AGHT+IF3bVuUSQU+alNARg7/R6qmJGQ06NbQbI0VrYE7H37TwU5eAm2jU1tQRdun4pLRt3QQNki5aQ==
X-Received: by 2002:a17:907:958f:b0:b6d:f416:2f3 with SMTP id a640c23a62f3a-b6df416071fmr70842766b.19.1761651794317;
        Tue, 28 Oct 2025 04:43:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548ed8fsm1084055466b.73.2025.10.28.04.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:43:13 -0700 (PDT)
Message-ID: <a4a3dce4-0f2c-4153-abbe-81e5d2715bbe@gmail.com>
Date: Tue, 28 Oct 2025 12:43:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 nf-next 3/3] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org, bridge@lists.linux.dev
References: <20250925183043.114660-1-ericwouds@gmail.com>
 <20250925183043.114660-4-ericwouds@gmail.com> <aN425i3sBuYiC5D5@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aN425i3sBuYiC5D5@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/2/25 10:25 AM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
>> packets in the bridge filter chain.
> 
> Same comment as previous patch, this needs to explain the why, not the what.
> 
> nft_do_chain_bridge() passes all packets to the interpreter, so the
> above statement is not correct either, you can already filter on all of
> these packet types.  This exposes NFT_PKTINFO_L4PROTO etc, which is
> different than what this commit message says.

So I have corrected the commit messages now, but:

> I also vaguely remember I commented that this changes (breaks?) existing
> behaviour for a rule like "tcp dport 22 accept" which may now match e.g.
> a PPPoE packet.
> 
> Pablo, whats your take on this?  Do we need a new NFPROTO_BRIDGE
> expression that can munge (populate) nft_pktinfo with the l4 data?
> 
> That would move this off to user policy (config) land.
> 
> (or extend nft_meta_bridge, doesn't absolutely require a brand new expression).
> 
Did you get any answer on this somewhere? I think that answer may affect
this commit, so I'll wait before sending the next version for now.


