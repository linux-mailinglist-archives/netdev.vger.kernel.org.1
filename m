Return-Path: <netdev+bounces-293164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANZ1LJK+GWq0yggAu9opvQ
	(envelope-from <netdev+bounces-293164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:28:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E84060594B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F408C3016693
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F73C1992;
	Fri, 29 May 2026 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="tFKhuz7u"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7536607D;
	Fri, 29 May 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071330; cv=none; b=Sa3gVAYJmoxRaJx1L4rTn1HzZ6oLbY9PHtOX1ZzFaswwACXo0aI0LT2Cya8XU+3mrX7PE0H9Lz/FgSoCzFFFj4saeWcoZNsjboVzmhIfD0sxLPJNOI65GPwcX4zj9mb7RsUqUr7GiwDfbcPqMHQqh6jLtUvaWvmax11oGuF3HcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071330; c=relaxed/simple;
	bh=uL/G0eLfOk3tPLysZ/3wSHOxP3/9s1fHmc95jIWh9Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHbIdwpbVUuoX6zRbz+Or6rR1AV2p5BRc5YbFeT4wY2lExzYTTcBCtC00d7Q7687RcjXE0eH4tqHqTbwwkN2PSSqGigYco5EhRyfDgkADpYuv8GuwXMj1h5Y4r3E3Tyz+Z5O9Fvm7mvk7C15Z1bLeCxW0leWcxTCV0ePY61U0dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=tFKhuz7u; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1780066303;
	bh=uL/G0eLfOk3tPLysZ/3wSHOxP3/9s1fHmc95jIWh9Fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tFKhuz7u2kk9/OBJF7dXUwCKT5j3ebFa90CpfFcs/ZRH+a9xo0FWeV3Or6WzbqGQv
	 DzCESRaHuRWtcbpSc2JaXdg0U2Kpi+ZPVsuNZAfIW1EViO8DYBQIFHukyhsYm16J3j
	 gtQZj/UwCJHnFiG9k/YsEi07l5mCG1QdyyjW4Sww=
Received: from [129.217.186.252] ([129.217.186.252])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64TEpf6Q021874
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 16:51:41 +0200 (CEST)
Message-ID: <c8650d3a-e488-4279-b28f-549d766c23a1@tu-dortmund.de>
Date: Fri, 29 May 2026 16:51:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260527135418.1166665-6-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293164-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tu-dortmund.de:email,tu-dortmund.de:mid,tu-dortmund.de:dkim]
X-Rspamd-Queue-Id: 9E84060594B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 15:54, hawk@kernel.org wrote:
> From: Simon Schippers <simon.schippers@tu-dortmund.de>
> +	/* If the ring is now empty and the peer TX queue is stalled by DQL
> +	 * backpressure, release completions immediately to unblock it.
> +	 */
> +	if (peer_txq && state->n_bql && __ptr_ring_empty(&rq->xdp_ring)) {
> +		/* Pairs with smp_wmb() in __ptr_ring_produce(); ensure ring
> +		 * emptiness is observed before reading peer_txq->state.
> +		 */
> +		smp_rmb();
> +		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
> +			veth_bql_complete(state, peer_txq);
> +	}

"Does this leave coalesced BQL completions pending indefinitely if the
receive ring is empty but the peer TX queue isn't stalled by DQL? [...]"

Regarding this by [1]: Yes, this is desired behavior IMO.

From my understanding there should not be a BQL stall caused by
this (needs to be tested though).

A minor nit is that the observation of the minimum amount of
slack found over several iterations of the completion processing
(saved in dql->lowest_slack) is inaccurate and therefore the limit
might be set to a too low value once (at the next completion call).
I think it does not matter though.


Overall The AI reviews [1] [2] have some valid points.

Apart from that I would consider joining patch 2 and 5.

[1] Link: https://sashiko.dev/#/patchset/20260527135418.1166665-1-hawk%40kernel.org
[2] Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260527135418.1166665-1-hawk%40kernel.org



