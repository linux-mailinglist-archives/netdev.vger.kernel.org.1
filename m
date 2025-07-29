Return-Path: <netdev+bounces-210883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F97B153E1
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB0C5626A3
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D10E1E3DED;
	Tue, 29 Jul 2025 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rJtJVOk/"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2BA1F956
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818468; cv=none; b=ay67R49uvDz5y4Vnu75BxgfFkbDVA22O2pZeXuVhkYX0EaUlcN2H2gxwL+wciuyYT+3K9VsGjdPZ1IX2/D5Ez8nFHkd37aK6woNMJ01D+SGpdSQpP0+e1OlnI14YIn4C9RF3U6DMwPTMZ+sfxKnpsfwLZYw+2Rl0EpEJNweswb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818468; c=relaxed/simple;
	bh=9i9vN5GM8dqdb5Kz/C2mWajqmbur7JcdFE0pBG8ro/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jO/vr2pWuDNvn6C8lUNKeB7MtvY1RzjusmKS1u2rZ3tFeW0vrlK4UAJxzoLIdse65bqU6Y+gffBRBSHKp06DoF6ELAG57wcVwSEsxtZTczIYa5DQhwUqXHomBo9PKP04PuKe53IbhyOgYZcRmNroc8crmXI69vgvJFBXnkdV35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rJtJVOk/; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4eaf6d02-6b4e-4713-a8f8-6b00a031d255@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753818454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNiE8rCbFLOmAQ8sf5S2SkbL/VAUCf+aI3z/mergUbM=;
	b=rJtJVOk/bZ3rsIBWrocc6O/BE6XFClolElg7S5DnQ3jZNJAw9MaeCnsOVlUfkOlME4lZ1r
	M0uzqkabB+l4XuBJz8z7VJ93rdVYnNoJyF7v/Thz49ay+9A93QlN1mrY06I6JSkpMh1qM+
	8C2/2meSjPexK4XC+5oBcZ1wyxw31hQ=
Date: Tue, 29 Jul 2025 12:47:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Andrew Rzeznik <arzeznik@cloudflare.com>
References: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch> <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch> <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
 <20250717182534.4f305f8a@kernel.org>
 <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
 <20250721181344.24d47fa3@kernel.org> <aIdWjTCM1nOjiWfC@lore-desk>
 <20250728092956.24a7d09b@kernel.org>
 <b23ed0e2-05cf-454b-bf7a-a637c9bb48e8@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b23ed0e2-05cf-454b-bf7a-a637c9bb48e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 4:15 AM, Jesper Dangaard Brouer wrote:
> That idea has been considered before, but it unfortunately doesn't work
> from a performance angle. The performance model of XDP_REDIRECT into
> CPUMAP relies on moving the expensive SKB allocation+init to a remote
> CPU. This keeps the ingress CPU free to process packets at near line
> rate (our DDoS use-case). If we allocate the SKB on the ingress-CPU
> before the redirect, we destroy this load-balancing model and create the
> exact bottleneck we designed CPUMAP to avoid.

iirc, a xdp prog can be attached to a cpumap. The skb can be created by that xdp 
prog running on the remote cpu. It should be like a xdp prog returning a 
XDP_PASS + an optional skb. The xdp prog can set some fields in the skb. Other 
than setting fields in the skb, something else may be also possible in the 
future, e.g. look up sk, earlier demux ...etc.


