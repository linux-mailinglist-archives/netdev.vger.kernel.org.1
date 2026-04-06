Return-Path: <netdev+bounces-275709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG2yOmAC1GkwpQcAu9opvQ
	(envelope-from <netdev+bounces-275709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:58:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8AF3A6731
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F3B930215A4
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB79A39658A;
	Mon,  6 Apr 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ah/GrS9C"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6CE38C410
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501916; cv=none; b=nStaNhhEjgWyv8uvz/fwSEWQJpjUtfEoYZQQvADp8C5t+u9nDrVa3eal8vEW901i1Ite+Q5epAM6OPnHqnNJkM/mG9uH1sAjVlQYV6w6G/dPjho4bUOx9BP8Pkc/GgX+VwheBnMiIfw+WXSwEn1OAuUCaX1LOla78m6bAvs01XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501916; c=relaxed/simple;
	bh=hgw9sRfXdg6RT/7PmSCdsEyl8RCMBqe7LGIoW2bxXyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lub8iLhX+mysHozWAgsXqFmLBWzACDR/ug7cc6UPn/xWxQWdjnj4NQxzRDdM5w2Bx4XJP58qaQdxHB7tIewpGnlD9Cl+CvGtBfnxTCcTVGvf6m6/PQhglRbZmqkHmVwXvy3G4nZNu6TXlqtvX9YJzOFchMy3s+i2LSm3UVwV4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ah/GrS9C; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 Apr 2026 11:58:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775501903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mt8iv95JuZBHekXx21skkTZqy3R/vFa6V8nPNb1+4yc=;
	b=ah/GrS9CgjCDFSW5REb/RKHUgvKDSzcv9kfWxpnqA1yjmqzr4DJceJKdIJ41Rgn/Af8fVu
	wb2T+aZu/39nV/l1Bfny1frTN7v1uAdhcmk6ObZ7wcV+4Pkjm7GQFK8Yivf1FfycJRHbVy
	ttRj6Hjs+2K/pctTC2NdmcVIt2rVR04=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: reject short IPv4/IPv6 inputs in
 bpf_prog_test_run_skb
Message-ID: <202646183934.lJx5.martin.lau@linux.dev>
References: <20260402160147.215499-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402160147.215499-1-sun.jian.kdev@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275709-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,syzkaller.appspotmail.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A8AF3A6731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:01:47AM +0800, Sun Jian wrote:
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..300e2bfc5a62 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1120,19 +1120,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IP):
> -		sk->sk_family = AF_INET;
> -		if (sizeof(struct iphdr) <= skb_headlen(skb)) {
> -			sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
> -			sk->sk_daddr = ip_hdr(skb)->daddr;
> +		if (skb_headlen(skb) < sizeof(struct iphdr)) {
> +			ret = -EINVAL;
> +			goto out;
>  		}
> +		sk->sk_family = AF_INET;
> +		sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
> +		sk->sk_daddr = ip_hdr(skb)->daddr;
>  		break;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	case htons(ETH_P_IPV6):
> -		sk->sk_family = AF_INET6;
> -		if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
> -			sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
> -			sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
> +		if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
> +			ret = -EINVAL;
> +			goto out;
>  		}
> +		sk->sk_family = AF_INET6;
> +		sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
> +		sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
>  		break;
>  #endif
>  	default:
> diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> index 438583e1f2d1..d53567e9cd77 100644
> --- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> +++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> @@ -12,6 +12,8 @@ void test_empty_skb(void)
>  	struct bpf_program *prog;
>  	char eth_hlen_pp[15];
>  	char eth_hlen[14];
> +	char ipv4_eth_hlen[14];
> +	char ipv6_eth_hlen[14];

The eth_hlen_pp and eth_hlen needs to memset zero now.

Instead of adding two more ethhdrs, just reuse the current eth_hlen and
define it as 'struct ethhdr eth_hlen;' instead of a char array.
Add 'h_proto' to the anonymous 'struct { } tests[]'.  Initialize
the eth_hlen.h_proto based on the tests[i].h_proto.

Also, this test does not actually reproduce the reading uninit memeory.
It needs a bpf prog to actually trigger it by calling bpf_skb_adjust_room()
based on the report in the "Closes" link. The test should be able
to trigger it without the change in test_run.c

The ai-review has flagged again that it is missing a "Fixes" tag. This
probably started since the bpf_skb_adjust_room helper was introduced.

The selftests should also be in a separate patch 2 following the patch 1
changes in test_run.c.

pw-bot: cr

