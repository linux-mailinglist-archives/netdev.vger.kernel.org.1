Return-Path: <netdev+bounces-268188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCRsFmohuGmdZQEAu9opvQ
	(envelope-from <netdev+bounces-268188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:27:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53E29C531
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF0D30FD774
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511483A451F;
	Mon, 16 Mar 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5Kodbfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF303A451C;
	Mon, 16 Mar 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674283; cv=none; b=ACSOAWuBM0RTgU2P5lYcsj9enGSa39VkasNHcOlDI+pzxjG9Ib4LS1KfEAfT2iY43B4hPDeh/++Ls/2VroMWkv5/Z+PcdcQZ3i0ncIL6jvUtNJqCcfz8y4XtL4DMUXq8BxTwDF2T7YfW70XRrCSuNzRCKPqQwBVuFzF9cZLEV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674283; c=relaxed/simple;
	bh=UQ2FizDH/N8F9XjfQQCAOr3SnosbPEtZuV9pGho7oQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdE4dHqYGS31LULOtxIcYEPhnXm91iI5F9up/1MYlLlKdzC+EMbL1NiiLMupc17BzUY38OXgJ10jMMggOBahTiS2TYxD4TvTb7pz2HPaHZWHyeHkk7qElgTOsRxwbavHYJbs6A0mnVXOdDw5+67udmkEjc/0ntv1jpRPLZFkAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5Kodbfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43407C2BC87;
	Mon, 16 Mar 2026 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674283;
	bh=UQ2FizDH/N8F9XjfQQCAOr3SnosbPEtZuV9pGho7oQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R5Kodbfv1XDDcrLoTnvBCdhSW+vqPhiyR7yfbF/NyilNtjFOHIl81gxZduBpbkYr4
	 c7pOz1yN6PBNfWrMTa+4gV+FB+AYty9w9sPn1/R6G84W7V7vh6eDGVmneKuZD1mh4p
	 0N/+up76bY07p1TRdupvfitbobBCNqCoZLEU/rPrsvX9f85pYU0aogDB6dqcFbp21s
	 n2f3yKDZlwZ/EFaxHrTTDT3xDoVCytEizahCpIiwZhPreO6ZN0rurQEOXPaeIRJNoZ
	 9kq/pQWq3GAAnQTUcTVTHiBCi7d+ZaLPW7GH/ZUil1PJlRULUO4wBnkgMTx6BfNN/X
	 UKGZO5YobrVCw==
Message-ID: <49679362-a6b3-47ad-8fac-3126aae3dc07@kernel.org>
Date: Mon, 16 Mar 2026 16:17:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: scale alloc cache with PAGE_SIZE
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nimrod Oren <noren@nvidia.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20260309081301.103152-1-noren@nvidia.com>
 <20260311175602.62629255@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260311175602.62629255@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF53E29C531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 12/03/2026 01.56, Jakub Kicinski wrote:
> On Mon, 9 Mar 2026 10:13:01 +0200 Nimrod Oren wrote:
>> The current page_pool alloc-cache size and refill values were chosen to
>> match the NAPI budget and to leave headroom for XDP_DROP recycling.
>> These fixed values do not scale well with large pages,
>> as they significantly increase a given page_pool's memory footprint.
>>
>> Scale these values to better balance memory footprint across page sizes,
>> while keeping behavior on 4KB-page systems unchanged.
> 
> Jesper WDYT? I'm of course happy with this simple approach.
> https://lore.kernel.org/all/20260309081301.103152-1-noren@nvidia.com/

Sorry for the slow response, LGTM.
Patch is already applied.

--Jesper

