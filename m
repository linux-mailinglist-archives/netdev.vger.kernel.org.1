Return-Path: <netdev+bounces-282908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEGTBxt682mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:49:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 375B64A51C7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5ECF3067609
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FB42EA151;
	Thu, 30 Apr 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L91qC2au"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9F2BD033
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563377; cv=none; b=rxg5cPU4j5BLuZYr1MyMfKW+v63D630MRAoYyBopKs1E1JrtdTPI9NGilX7yzC14SnPCk7zc9WDd0CjwA9R5W39ZjAc385pzO+W/5am//XzC/rbLHJuUhY7HHfV6pNlhjcnpynKggI2n8TMhBf+groox5Qc3MKr5VsbFfe8wbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563377; c=relaxed/simple;
	bh=b/ndH+AfS4jQYXgy0E5X4wv8eudyYsbdi6SXA45GkpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHPavBOgMhO33Sqi3ENUhvn82wtu9hyf0+45zhOkIy2aZAybbwva5K3dZWXRx3MzvDF+1T1yfYqPdoF6zStZSuH/z1mFMua6F5WaOZMJ5I93ilnv22QZk9mYzsRJ79f5/osj7U7BHif/+4Mu/UMmtH2+T2xKTwsvFHSHYkqtpj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L91qC2au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6283C2BCB3;
	Thu, 30 Apr 2026 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777563377;
	bh=b/ndH+AfS4jQYXgy0E5X4wv8eudyYsbdi6SXA45GkpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L91qC2aubWB3S6kaBRaW4TNHuvODxGT5it3fC5Z2nRbSTLs/UpMwbbf36HaAij+Q3
	 GjG6WXZX7QJAWkOshZ3C+1mMKGKBvC6Xe6tBfn2722XINuvqmdABh9B7XgfC5/Remf
	 hf64C5n5Wt2TAjtknS8UIpe3DhSKhExX0ugmUGRh1nPFaCXnhbP3NUvNHyT+VDvTy2
	 76PizSoZezKrFBCss+PdII0gP7lS1x1u2qZ53jMXu//PFGrBMYPoqV5EuREfIbvQJn
	 730niBhjuW52YXntyE/t6J9CLM05VSWu1L2fYecG+TlOnflygMk15SU8zLRKR3wvGT
	 Q880d5IcTZUmg==
Message-ID: <18134b6e-8944-49f4-9bb0-2903aa00d28a@kernel.org>
Date: Thu, 30 Apr 2026 09:36:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] tc: use ll_init_map() only when needed
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260428082851.3240821-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260428082851.3240821-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 375B64A51C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282908-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Jamal: waiting for your review ...

On 4/28/26 2:28 AM, Eric Dumazet wrote:
> Some setups can have thousands of devices.
> 
> ll_init_map() is rather expensive for them.
> 
> Only call ll_init_map() in the following cases:
> 
> 1) tc runs in batch mode.
> 2) tc runs in monitor mode.
> 3) tc dumps qdiscs/classes/filters for all netdev.
> 
> This greatly reduces RTNL pressure on common operations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  tc/f_route.c   |  1 -
>  tc/m_mirred.c  |  2 --
>  tc/tc.c        |  1 +
>  tc/tc_class.c  |  6 ++----
>  tc/tc_filter.c | 32 ++++++++++++++++----------------
>  tc/tc_qdisc.c  |  5 ++---
>  6 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/tc/f_route.c b/tc/f_route.c
> index 96b99b06be179c90dfb0d24d9577b5206dd98ef1..c234ddf0cb9309556844c85047d0f9ef53a2fd7b 100644
> --- a/tc/f_route.c
> +++ b/tc/f_route.c
> @@ -76,7 +76,6 @@ static int route_parse_opt(const struct filter_util *qu, char *handle, int argc,
>  			__u32 id;
>  
>  			NEXT_ARG();
> -			ll_init_map(&rth);
>  			if ((id = ll_name_to_index(*argv)) <= 0) {
>  				fprintf(stderr, "Illegal \"fromif\"\n");
>  				return -1;
> diff --git a/tc/m_mirred.c b/tc/m_mirred.c
> index f4da3c76284460d7f4bb73c7c3c172732f054632..e9ae5199432e828026f15ce226c5f5f84998c660 100644
> --- a/tc/m_mirred.c
> +++ b/tc/m_mirred.c
> @@ -213,8 +213,6 @@ parse_direction(const struct action_util *a, int *argc_p, char ***argv_p,
>  	if (d[0])  {
>  		int idx;
>  
> -		ll_init_map(&rth);
> -
>  		idx = ll_name_to_index(d);
>  		if (!idx)
>  			return nodev(d);
> diff --git a/tc/tc.c b/tc/tc.c
> index 0fc658c881f0f553f1f1f8d87b46943d4d0eed8f..7d69e4d533a98b9c071cb954443a049a52252f2c 100644
> --- a/tc/tc.c
> +++ b/tc/tc.c
> @@ -243,6 +243,7 @@ static int batch(const char *name)
>  		return -1;
>  	}
>  
> +	ll_init_map(&rth);
>  	ret = do_batch(name, force, tc_batch_cmd, NULL);
>  
>  	rtnl_close(&rth);
> diff --git a/tc/tc_class.c b/tc/tc_class.c
> index 6d707d8c924f4b5e90201d4de8e9779f82ce17f3..9aace019e6c8b96fb51edb4fe89bea5b7469beed 100644
> --- a/tc/tc_class.c
> +++ b/tc/tc_class.c
> @@ -136,11 +136,11 @@ static int tc_class_modify(int cmd, unsigned int flags, int argc, char **argv)
>  	}
>  
>  	if (d[0])  {
> -		ll_init_map(&rth);
> -
>  		req.t.tcm_ifindex = ll_name_to_index(d);
>  		if (!req.t.tcm_ifindex)
>  			return -nodev(d);
> +	} else {
> +		ll_init_map(&rth);
>  	}
>  
>  	if (rtnl_talk(&rth, &req.n, NULL) < 0)
> @@ -437,8 +437,6 @@ static int tc_class_list(int argc, char **argv)
>  		argc--; argv++;
>  	}
>  
> -	ll_init_map(&rth);
> -
>  	if (d[0]) {
>  		t.tcm_ifindex = ll_name_to_index(d);
>  		if (!t.tcm_ifindex)
> diff --git a/tc/tc_filter.c b/tc/tc_filter.c
> index 7db850bda11a3408ec66b457c9fc590f3a734f65..be70e360849e5058192640da0f061810a99e2ea8 100644
> --- a/tc/tc_filter.c
> +++ b/tc/tc_filter.c
> @@ -188,16 +188,17 @@ static int tc_filter_modify(int cmd, unsigned int flags, int argc, char **argv)
>  		addattr_l(&req.n, sizeof(req), TCA_KIND, k, strlen(k)+1);
>  
>  	if (d[0])  {
> -		ll_init_map(&rth);
> -
>  		req.t.tcm_ifindex = ll_name_to_index(d);
>  		if (req.t.tcm_ifindex == 0) {
>  			fprintf(stderr, "Cannot find device \"%s\"\n", d);
>  			return 1;
>  		}
> -	} else if (block_index) {
> -		req.t.tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
> -		req.t.tcm_block_index = block_index;
> +	} else {
> +		ll_init_map(&rth);
> +		if (block_index) {
> +			req.t.tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
> +			req.t.tcm_block_index = block_index;
> +		}
>  	}
>  
>  	if (q) {
> @@ -539,8 +540,6 @@ static int tc_filter_get(int cmd, unsigned int flags, int argc, char **argv)
>  	}
>  
>  	if (d[0])  {
> -		ll_init_map(&rth);
> -
>  		req.t.tcm_ifindex = ll_name_to_index(d);
>  		if (!req.t.tcm_ifindex)
>  			return -nodev(d);
> @@ -704,21 +703,22 @@ static int tc_filter_list(int cmd, int argc, char **argv)
>  
>  	req.t.tcm_info = TC_H_MAKE(prio<<16, protocol);
>  
> -	ll_init_map(&rth);
> -
>  	if (d[0]) {
>  		req.t.tcm_ifindex = ll_name_to_index(d);
>  		if (!req.t.tcm_ifindex)
>  			return -nodev(d);
>  		filter_ifindex = req.t.tcm_ifindex;
> -	} else if (block_index) {
> -		if (!tc_qdisc_block_exists(block_index)) {
> -			fprintf(stderr, "Cannot find block \"%u\"\n", block_index);
> -			return 1;
> +	} else {
> +		ll_init_map(&rth);
> +		if (block_index) {
> +			if (!tc_qdisc_block_exists(block_index)) {
> +				fprintf(stderr, "Cannot find block \"%u\"\n", block_index);
> +				return 1;
> +			}
> +			req.t.tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
> +			req.t.tcm_block_index = block_index;
> +			filter_block_index = block_index;
>  		}
> -		req.t.tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
> -		req.t.tcm_block_index = block_index;
> -		filter_block_index = block_index;
>  	}
>  
>  	if (filter_chain_index_set)
> diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
> index 7eb9a31baa31fb91a8141c9eca1135e76a52fa8b..252ea861f249a5a71cf782389776e68c3e48c6cc 100644
> --- a/tc/tc_qdisc.c
> +++ b/tc/tc_qdisc.c
> @@ -193,8 +193,6 @@ static int tc_qdisc_modify(int cmd, unsigned int flags, int argc, char **argv)
>  	if (d[0])  {
>  		int idx;
>  
> -		ll_init_map(&rth);
> -
>  		idx = ll_name_to_index(d);
>  		if (!idx)
>  			return -nodev(d);
> @@ -411,13 +409,14 @@ static int tc_qdisc_list(int argc, char **argv)
>  		argc--; argv++;
>  	}
>  
> -	ll_init_map(&rth);
>  
>  	if (d[0]) {
>  		req.t.tcm_ifindex = ll_name_to_index(d);
>  		if (!req.t.tcm_ifindex)
>  			return -nodev(d);
>  		filter_ifindex = req.t.tcm_ifindex;
> +	} else {
> +		ll_init_map(&rth);
>  	}
>  
>  	if (dump_invisible) {


