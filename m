Return-Path: <netdev+bounces-286093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEeOOryc/mnItwAAu9opvQ
	(envelope-from <netdev+bounces-286093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:32:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346F4FDA88
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC0D3014BDA
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0A191F91;
	Sat,  9 May 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lgKel6yr"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EABF9D9
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293945; cv=none; b=jrFvHDZTYLprYrocZjxA3U3u57UTnDDDxPLCca3h53UpK0hAf2a5Y1c5mwearH2lCGbeMPATFHIqRyDV/TPM15t50BFloHDQA7Ib02jilGdiD+5x4PDsp1l14mcyXIrCi7z/+oWBpOmSqkP3BotWkx2RUnNXVCWUxPwr3xr/o/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293945; c=relaxed/simple;
	bh=NA3J8CVX190SnWizDscAU6d2j1q73oPsXQnxKuwsjxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjBzRThn8RnUidB4KxL6EZEvjLxXjmtmRk5kCsoaBBK/WEivHl62neaG6xsiJ6VXij3Btxjc1J0V4Vv0ZJlu953EKZMfAZXg9q13NPsfm4T1Jg3JG9BSfhjDFsOo6AIzrVSzHhg2echGMlT175IBrDYSVD1zceN7laGNBJ1wpYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lgKel6yr; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <252e4742-34db-4a04-8c9d-560625df1e70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778293942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyJGZ9D3wyqlqwlSKI43nO6MG5PTxXwtHtoSkGYi3VQ=;
	b=lgKel6yrheeXANVmo5p2Ax81k2zKx3tw+XgPekPncCyqVRu3OaCtMvmffkJQlNTYGpKNX+
	bwpmfWTg1ZJ4JlzJ6jU/R+WBCEqYm2gQkdXZsvHQra9j2or6cU4P+zABOqxsBmSvCyVbdT
	S/lhOTp+zaoC6eGyi3b6WwJmmlh1sX0=
Date: Sat, 9 May 2026 10:32:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
To: Hyunwoo Kim <imv4bel@gmail.com>, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, qingfang.deng@linux.dev
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <af2kdW2F1gJ9U-Gg@v4bel>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <af2kdW2F1gJ9U-Gg@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3346F4FDA88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,auristor.com,davemloft.net,google.com,kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286093-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/8/26 4:53 PM, Hyunwoo Kim wrote:
> The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> handler in rxrpc_verify_response() copy the skb to a linear one before
> calling into the security ops only when skb_cloned() is true.  An skb
> that is not cloned but still carries externally-owned paged fragments
> (e.g. SKBFL_SHARED_FRAG set by splice() into a UDP socket via
> __ip_append_data, or a chained skb_has_frag_list()) falls through to
> the in-place decryption path, which binds the frag pages directly into
> the AEAD/skcipher SGL via skb_to_sgvec().
>
> Extend the gate to also unshare when skb_has_frag_list() or
> skb_has_shared_frag() is true.  This catches the splice-loopback vector
> and other externally-shared frag sources while preserving the
> zero-copy fast path for skbs whose frags are kernel-private (e.g. NIC
> page_pool RX, GRO).  The OOM/trace handling already in place is reused.


To be clear, frag_list is not empty for SKB_GSO_FRAGLIST and the skb 
will go through the copy path.

It's just tradeoff.

>
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v3:
> - Use skb_has_frag_list() || skb_has_shared_frag() instead of skb_is_nonlinear()
> - v2: https://lore.kernel.org/all/af2F1FU5d4Q_Gn1W@v4bel/


Others lgtm, it makes sense to keep this as the ESP fix, since both 
patches address your Dirty Frag vulnerability.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


