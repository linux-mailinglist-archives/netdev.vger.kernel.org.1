Return-Path: <netdev+bounces-300416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2nT0EBDdM2rHHQYAu9opvQ
	(envelope-from <netdev+bounces-300416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:57:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2604469FDAC
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=b2kfGjID;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300416-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29EE83029A5D
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6873ECBFB;
	Thu, 18 Jun 2026 11:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911C3F23A3
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:56:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783820; cv=none; b=Wlp9S7mZ1UdM59QAk1DwOKQM09HxM7Une1K2iB+f53PoFR9XSPKa1oaomzL+ma8UWE7r25kZ25mGxFn6WMf8l2srpN+fGUZaeEqEPZ3MqfvaXX0MUv8k7vk+Az8zdRc6Oh8unE7zaxWtyWwJq3cUcTiAllEnXldF6aMeox8BNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783820; c=relaxed/simple;
	bh=EmKLrmuw0L1SJA8xGx0is8Bar9U5MW7fs6K0yUE5+CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4MKFrJEsILeQal3blZaJVRCvzEwlT1H08GE6rLfI6GYgFTbco6O33QdpFLBEwlO5y2nVVy3ZpHN1G4dcMzPT6DivoPa/dHjSkFlvbyyuhki/usTA7Z4E5IZgG8DLIu7hMBm5l9XUMzb4IUkFux7f1eiDPsjSmAgmsNRU8zks7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b2kfGjID; arc=none smtp.client-ip=91.218.175.172
Message-ID: <34f330b8-60d2-4647-a6b4-a5b001c3715d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781783814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIDgjJc0kDWVk21VQMDvaZz53upB9zqPpo8g1ntXG+I=;
	b=b2kfGjIDPXddkJPr1tI/nwGwhr8kHHcavSP+y/Rpez7K103Jrloy2+xgVctuso45fzDV/8
	1hmzOfbHqTa21l0XQXO8QTBzXiICkx7Wh1jq/uy8yr3QvLJL7kJUz0rrniQFNyW4qDsFRj
	+LKi9n3VbYY4RyTbvnI+Wq1zQhgnX1A=
Date: Thu, 18 Jun 2026 19:56:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: fix use-after-free when the
 stream parser resizes the skb
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sechang Lim <rhkrqnwk98@gmail.com>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
 <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260618102718.2331468-2-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:rhkrqnwk98@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2604469FDAC


On 6/18/26 6:27 PM, Sechang Lim wrote:
> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
> to find the length of the next message. strparser assembles a message out
> of several received skbs by chaining them onto the head's frag_list and
> recording where to append the next one in strp->skb_nextp:
>
> 	*strp->skb_nextp = skb;
> 	strp->skb_nextp = &skb->next;
>
> and then calls the parser on the head:
>
> 	len = (*strp->cb.parse_msg)(strp, head);

[...]

> unaffected and may still modify the skb.
>
> Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")

Is the Fixes tag correct ?

Anyway, I don't think this patch is a fix; it's more of a hardening. So 
no Fixes tag needed, IMO.


> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>   net/core/sock_map.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 99e3789492a0..c60ba6d292f9 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1515,6 +1515,17 @@ static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_prog ***ppr
>   	return 0;
>   }
>   
> +static int sock_map_prog_attach_check(enum bpf_attach_type attach_type,
> +				      struct bpf_prog *prog)
> +{
> +	/* A stream parser must not modify the skb, only measure it. */
> +	if (prog && attach_type == BPF_SK_SKB_STREAM_PARSER &&
> +	    prog->aux->changes_pkt_data)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   /* Handle the following four cases:
>    * prog_attach: prog != NULL, old == NULL, link == NULL
>    * prog_detach: prog == NULL, old != NULL, link == NULL
> @@ -1533,6 +1544,10 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>   	if (ret)
>   		return ret;
>   
> +	ret = sock_map_prog_attach_check(which, prog);
> +	if (ret)
> +		return ret;
> +
>   	/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
>   	 * exists for that prog.
>   	 */
> @@ -1776,6 +1791,11 @@ static int sock_map_link_update_prog(struct bpf_link *link,
>   		ret = -EINVAL;
>   		goto out;
>   	}
> +
> +	ret = sock_map_prog_attach_check(link->attach_type, prog);
> +	if (ret)
> +		goto out;
> +
>   	if (!sockmap_link->map) {
>   		ret = -ENOLINK;
>   		goto out;


CI failed:
https://github.com/kernel-patches/bpf/actions/runs/27754218839/job/82113319982
    Failed stream parser bpf prog attach

Hi John
I noticed that bpf_skb_pull_data was added to the skmsg test:
https://github.com/torvalds/linux/commit/82a8616889d506cb690cfc0afb2ccadda120461d

Can we drop bpf_skb_pull_data in parser prog(sockmap_parse_prog.c‎) ?
And are there any scenarios where we need to modify skb len when using 
strparser ?



