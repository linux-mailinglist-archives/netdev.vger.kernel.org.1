Return-Path: <netdev+bounces-292411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNNwFlQnF2qu6wcAu9opvQ
	(envelope-from <netdev+bounces-292411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:18:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C85E841C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3178B3048F16
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663C44E027;
	Wed, 27 May 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aJ5YCDKp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+4Eax1g"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09944A711
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902272; cv=none; b=Zayltp1zCcQTcHblBuqjt+9AZE1vYpyZ2G88hVnHzs0IQnvXeKSCeKnZAuZP/H8jfST7KySMLIrFl8Hk8hOESoCRVKv46ITeP1P91mt0qe3WgPyREZaYagk1d7wX0ChjmZisJk3qnGXItppUOGjqIrQXbyigi+7RtmbpIfe/NQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902272; c=relaxed/simple;
	bh=LdhMy2TqDpVEh/bRpQRsnqODDlgDJiWCSgmfU1rRCnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIjJ8YOwG/S7xrAHozQ2KwCQyQHtJizDUIBcjczfoOzCmUeAP30Vc0Sxb6XEzml+yhPX8rQ0WZL+JjxMqulH3E2Zqp9PjQAUqP5w5S5NKYq1MhhDUwF4wIq/Uz0Gvn/JpVlDec2yUdzM5tCnCmdYqeTl0zSpPhSpJmnlQKcfDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aJ5YCDKp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+4Eax1g; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AD218EC01AD;
	Wed, 27 May 2026 13:17:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 13:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779902269; x=
	1779988669; bh=wdl/cunxDmv57X3cGLjkJUXZCQvKZ6HhT3sbER7iTRo=; b=a
	J5YCDKpl10Apausf766oIm/HGpDrKjX2Qms0cyp5E4+XOgyWNmhsOr4W3DphC6Da
	+RtwXpuGOrwQ18VrpEROwyLUgdd/oAFxMpgeME+kgToUlM0t/RIBt3e+R8Tj7sLd
	AEznD+5edGO+wM5BErsbEONIFCQXGCZP2medACq2mLTczvLl/k00GTuLMz8QtRzi
	CaUNLrHEin2IqcgLUmwp4n7obWCpcTHqaLk7/vsSTJCFkfBCzfJNXhNpyK9svE1C
	lOXgz8620miirWqZ1d6+EdZGwmz1EBfknWqrWwVNOJc2I4klOmq5ZQMk+vbxlI3t
	G/ciTtJj6Ja5laHfbv2KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779902269; x=1779988669; bh=wdl/cunxDmv57X3cGLjkJUXZCQvKZ6HhT3s
	bER7iTRo=; b=d+4Eax1ghTyo7vB3jvZIXS7aXXPcg/2uxDUIva/Ej1oJtMTGIvO
	KBCAkKNgYfX8HKJMduBfWJ48q9B10ixjbDfEgrlzPWYYIYMmQIiQcMgOPSWEQmDW
	N9xmfGvBnXESo/LH32AKB92zGPYPvCEaTEI8Hf96DWmj889Avyua6fYo74CML4Yw
	R6qU6I4Cl/bq7JkeqQkzFCf3+BYDayvc/bAKGOavSk7V5NRg0WhpkFiT2LSIP8Xe
	I4F1Tljix5JvPLhHvjFxNVcIlrWRaRxOWnidxhhUfxELEUcmEeNuFYnaYgJ4aB2a
	3+eQWp3Dnviw086Vq3TI6tgWZGPelKrdv3Q==
X-ME-Sender: <xms:PScXao6J_1ClONqschl5yxZmcK_79ultpR-DelV2sTpqZLHpq8ihdw>
    <xme:PScXas8mwDUIajVzg1YnyBAY2lGmuoq6D6XqUWYerhaq-ZUCCwYfy0mUVVm9fDdHu
    IW87uYr23lR0nDWQzklXxowmE9DLyv-z6q9HAgAoMHZuj7tEY_AAyU>
X-ME-Received: <xmr:PScXaiFYoCqNqyhquvWWK4ZJlkWnO7LY_A7YL3iqU6VJyOwT7huMNFwF1H013yPnDE4XxBZtV_aR6bDuRSgPHmA>
X-ME-Proxy-Cause: dmFkZTESGwvqnssqQRHdcUGRa1d/ir4+l5c53sBVWmZ7sFhh9Gg1YbhXbWMsdSofRNpw4c
    8X6J1yBG8lJGORS4H8ug7yBzAc+zJXo1+DWSanUCh4gNx7UTHEo6p5pZtLHG0B2DYHcNcI
    kBqRQRn6NjJANtiUSk111tXRv/axeMy1Bbu3636hoyR0B7dL52NEHerAiB1BTichNksFvo
    5bl2CePXEQk7tl5auoLoaqH4ht+sosG91Xcy0d1bo9eWFzLSyfnBPrCwLRIqHCESF8Y2en
    ypi4ksgraJsQHzvDGXDv/kXjATuQ2TZI2FT/4xkwe9yE2HKJ8tIdiVhwNxWqWc6rYOTuil
    OhFYR77hInXgn7wWbGRaf1cmUVmEVv6diDPPQoJgpiVbEmhfZpNY0pG4AlVi6njSBeRdV/
    afZjO35rhXDYh+tsoyCWobBsELSvkIwug5EFyR3EGbfMG6SJvRknyQN07+25UFAJUHAXV2
    YyHYN926848eG4xitdPSzmV7KNDEU8QOa3d1A2p5WZXcljCnCZY8uVHSe3OOQAk3NRqSph
    /eXcKMJg/HseBARJROJQY/V1sRrLMp1eyamkks03HP6UURdj3M9h5FKutar3O+yh2GRvxB
    8dvXf6lOUA0BUckPY56V92C3fz6epg061ciU0hSTVQLnzTFizXnkNFh0y19A
X-ME-Proxy: <xmx:PScXapWj4epWigcjJVwLv3FjYcbR0L5z1g6qKSlGClxFq8dnRjuZYA>
    <xmx:PScXam_tJlL1pZ6amVFtyZS1mkD84_ymSKPX3_xq8_V4ZEfnHPI69A>
    <xmx:PScXau7iqtovfWdmK0UEpDGSdUBBYTg6tuoOMTdROUE6VKDpobQFZw>
    <xmx:PScXank1h8M_JFw1VPUrTGFKgPFvodoZkZ8aqXiMGXZjSXrxZj1hxQ>
    <xmx:PScXagU8rrwNdO_Qq6IO5nAAJR7FoYGtNWrbmIiJsbIkgG3KG5mfwajR>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 13:17:48 -0400 (EDT)
Date: Wed, 27 May 2026 19:17:47 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH net-next v11 1/6] tls: Avoid evaluating freed skb in
 tls_sw_read_sock() loop
Message-ID: <ahcnO2S7QfhTBNhK@krikkit>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
 <20260526-tls-read-sock-v11-1-244fe1dc4abd@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526-tls-read-sock-v11-1-244fe1dc4abd@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292411-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,grimberg.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,grimberg.me:email]
X-Rspamd-Queue-Id: DE4C85E841C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-26, 10:21:31 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> tls_sw_read_sock() ends its receive loop with while (skb), but
> the else branch in the body calls consume_skb(skb) before the
> predicate is re-evaluated. A pointer becomes indeterminate when
> the object it points to reaches end-of-lifetime (C2011 6.2.4p2),
> and using an indeterminate value is undefined behavior (Annex
> J.2). The pointer is not dereferenced today -- the predicate
> either exits the loop or skb is overwritten at the top of the
> next iteration -- but any future change that adds a dereference
> between consume_skb() and the predicate would silently introduce
> a use-after-free.
> 
> Replace the do/while form with an explicit for(;;) loop so
> termination happens through a break statement rather than
> predicate evaluation of a freed pointer.
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

