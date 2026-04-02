Return-Path: <netdev+bounces-274322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF8NH9zRzWnVhwYAu9opvQ
	(envelope-from <netdev+bounces-274322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:18:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE4382921
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 402C6303EFD7
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707127816C;
	Thu,  2 Apr 2026 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J5veQgjK"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3164A0C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775096268; cv=none; b=cDl00vdTGlNiy4GKGkgTK3raDuyK5f6doDvcOwTLg7X/z36Ui1Eq1sqaaptrdZxqyysJnLcEfnYrGKWjPejSs0g8XWif1ViXuIE0B1ms0PsQ5K0TYmho0kVLbshyFGrIA3nRfXi/IKPkLhSUimfnXSig1vrgDkwbp3sWN0V2D/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775096268; c=relaxed/simple;
	bh=t/3PCQ77RVTzsLWO49aW4TsbfaYGT6vsXCBya5Wm5ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVORD+SjilDtCiaJXa2MrHf/t9xg2qxDPrMPRaHx3BDgGSDlY+Q+zhvAFq/YCYQ3Pj7VkbyxW8C63/VCAhanyRwoKYXH2USMdiFVUpwCIcNalFctL3xLpFderEoV1XL1Rc23gVVdQAeqDJL/QusiXhRF7QE7JpZb7KAfX/4WKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J5veQgjK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 Apr 2026 19:17:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775096254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0u6s/x6J9vqcdbP68jS2tltPgzB3C0+ejZgmXVkHZqE=;
	b=J5veQgjKkRywUQO/b4lbGjPKwwU+uNF5UqhHO5Y90LESxJbSBJV+cDa7nLLZSmYoRqHn3g
	z0wbvua6175pp+XWoD0fC7IJQnkwej2uXSvwlF27yQJeTnyPDXTRCjuhPdTiCnwOMibVhs
	kZuHnyJLEiI83tADHelIEPGuJAodP+k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test
  input
Message-ID: <ac2ccb5NBAB3Zq1D@devbig1721.ftw5.facebook.com>
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devbig1721.ftw5.facebook.com:mid]
X-Rspamd-Queue-Id: E8EE4382921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 12:17:51AM +0800, Sun Jian wrote:
> bpf_prog_test_run_skb() derives skb->protocol from the Ethernet header
> through eth_type_trans(), but it does not verify that the provided
> linear input is long enough to contain the corresponding L3 base header.
> 
> This can result in an inconsistent skb being passed to test_run helpers
> such as bpf_skb_adjust_room(), where inferred protocol offsets can lead
> to operating on uninitialized memory, triggering KMSAN errors.
> 
> To reject such malformed test input, we check that the linear head is
> sufficiently large to contain the corresponding L3 base header (IPv4
> or IPv6) before running the program.
> 
> Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> v2:
>  - Ensured that the linear head is large enough to accommodate the corresponding L3 base header (IPv4 or IPv6), before running the program.
> 
> Link: <https://lore.kernel.org/bpf/129d235b04aca276c0a57c7c3646ce48644458cdc85d9b92b25f405e2d58a9ae@mail.kernel.org/>
> 
>  net/bpf/test_run.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..4790bee535b9 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1118,6 +1118,25 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	skb->protocol = eth_type_trans(skb, dev);
>  	skb_reset_network_header(skb);
>  
> +	switch (skb->protocol) {

The implementation is poor.

> +	case htons(ETH_P_IP):
> +		if (skb_headlen(skb) < sizeof(struct iphdr)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		break;
> +#endif
> +	default:
> +		break;
> +	}
> +
>  	switch (skb->protocol) {

There is an exact same switch and it has the same check
on skb_headlen(skb).

A selftest is needed. Check if the tests in empty_skb.c need to be
changed also. imo, This can be bpf-next.

pw-bot: cr

>  	case htons(ETH_P_IP):
>  		sk->sk_family = AF_INET;
> 
> base-commit: cbfffcca2bf0622b601b7eaf477aa29035169184
> -- 
> 2.43.0
> 

