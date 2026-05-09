Return-Path: <netdev+bounces-286129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCW3Bun5/mng0gAAu9opvQ
	(envelope-from <netdev+bounces-286129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 612EC4FEED6
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9492300DDD5
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D7397691;
	Sat,  9 May 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc4YlmP/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3E396590;
	Sat,  9 May 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317797; cv=none; b=PrIBAhIkan6Aspk5PghHu0eYoG2qSvYPAPKP6JJ+Iymh3TVKBxiNuqGwC4Y7aB3mePPzHP9Iz2ttcg7BUPNGKw10yj8SsDNSgFr8ZiyjUCc/KsHF3SEtXmwfxz4h8rpHz67gQG1P567aC+N56Hs7g8RDVNkrCi8mm1Kx/v+HoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317797; c=relaxed/simple;
	bh=I9xmCKGHzYxSSinS9IY36jR9jBt7BmV4S2kZeKuaUp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSKteQMDLX3FLUHnoV0e6EoLMZHnzFQv0RKVSyN0i0t/g6DV6176zSjkw0oVjznajpvVQFWS4Bq9DUIr4MSKR4QpTIv+M5j4PHcFhZFC1guNODoQ2WAalzLDBddH1BOx3NihCvbnMvdybEA+VZoSNm9VX0W2DrJ3JRL5wB+Xprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc4YlmP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F360C2BCB2;
	Sat,  9 May 2026 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778317796;
	bh=I9xmCKGHzYxSSinS9IY36jR9jBt7BmV4S2kZeKuaUp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bc4YlmP/sUpsEYe9VaGxXj/JScjxIU7hY0Wddht5Pg+tOeTnpG2tGATpEs0M9yEa+
	 eyTFeaTdXirU9ts2g9Vmqfc/np6rgLyUWVH/YE1ru+g0hRibmzs1t0vBTigHyUxN9n
	 I8NtAtvB9iZhFn/ZoLCqheoEcAVPh6DGPPx9EkAZnuLyCSkgmPjFM/FRWFHfwKLMWw
	 xMkxrNZpmXidWaFfkFChQhnAn25o17jJk8RFDQDD7A0rnm+PjDPAuwKVTVfw5c4vdD
	 FFSZaL934Stwmlhq7vc6z0+xrzMBYaRuvFnlmefKIUju4po6E7arf4N3BCDBY4JpBV
	 e9MmHdtGZmIzg==
Message-ID: <f459b95c-80d5-4e05-84b2-f574c92724de@kernel.org>
Date: Sat, 9 May 2026 11:09:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Schippers <simon@schippers-hamm.de>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
 <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
 <e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
 <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
 <20260508190626.4285fac0@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260508190626.4285fac0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 612EC4FEED6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286129-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[schippers-hamm.de,redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action




On 09/05/2026 04.06, Jakub Kicinski wrote:
> On Thu, 7 May 2026 21:09:09 +0200 Jesper Dangaard Brouer wrote:
>>>>> I still think first that adding an option to modify the hard-coded
>>>>> VETH_RING_SIZE is the way to go.
>>
>> Not against being able to modify VETH_RING_SIZE, but I don't think it is
>> the solution here.
> 
> Was it evaluated, tho?
> 
> It's obviously super easy these days have AI spew no end of complex
> code. So it'd be great to have some solid, ideally production-like
> data to back this all up.
> 
> VETH_RING_SIZE seems trivial, ethtool set ringparam

No, unfortunately we cannot just decrease the VETH_RING_SIZE.  The
reason is that XDP-redirect into veth don't have any back-pressure and
would simply drop packets if queue size becomes less than the NAPI
budget (64). (Yes, we use both normal path and XDP-redirect in
production).  My benchmarking shows that an optimal BQL limit is
dynamically adjusted between 17-55 depending on veth consumer namespace
overhead/speed, when balancing throughput and latency.

--Jesper

