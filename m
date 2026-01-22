Return-Path: <netdev+bounces-252539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH69FCSWcmmSmwAAu9opvQ
	(envelope-from <netdev+bounces-252539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:27:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B56DBF3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57F3930010FA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6BA3C0881;
	Thu, 22 Jan 2026 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVnMwMLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1533B6F4
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117213; cv=none; b=BIvLMvi0Zs+eQ+uVRcoydKiXRS9zqCEq+Af8OIO2RhSdyAdR9QgByuTuQKIB3ciq96rF9RWKMQ2frgmI/nkpzJDvtKGrXtOeL4uSlBIQ6UiaV4UYHU1tAwUtMiBMvprk3TbL37GbvJR0Her3YcClcMfWvU/FBFLyH8XjHx/wjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117213; c=relaxed/simple;
	bh=dc2WxEhMKXrurgWU1N6VFMevo2L5nPOxGcK0DhUlIOA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nlx+6rvaZvPxLMTXJAub57/bU1bwWghYH/5WGnaepKcWIREEzGpMNgedzKKRfja9eiV1lu95iXZANw7gCL18odki7T3tZT4ESmRKk5XTZ0gdFEIr10DP8YqC6LlaveOaR9y/fDTQb5IF0V8PKK4PG9AQmMFojfTdh2Rl/wHOwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVnMwMLO; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-790b7b3e594so15584527b3.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769117206; x=1769722006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYFJzzeiiJbQS6gVd8JY6D5XsVotuGeuQ3+GqVmgfjc=;
        b=jVnMwMLOLFiO9Ow4Y2Zf4FEUgt979uloeErVXWA/FmWHVp/atgsTewfZuVZVLPiI4w
         XXnTiY+tcUbEAiwlKQPixhJ78bJz/VLtdxcdw8i3y2F29UGasHnAkMkBAFUec8kz56eL
         GOx3eW8IckzGdCA6jiRBuTrEX5YkUUaoJdl8o6cponTK6LLqL3Wzt/DxUjeUxiUHPS/1
         fXtDFd+s8jfJCMhW3xUKz+BRgj0jtT1UCV0R8+fT2JlIoFAQk6YRLWmM4AGgCAvI1no+
         wiGLUGl/IVQLhFXb0xCDnpP2nya+N5XHRvr0w7fJ7Xi/3CbXJ4Ko5IB1ysYXF6pnJDlv
         rm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117206; x=1769722006;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYFJzzeiiJbQS6gVd8JY6D5XsVotuGeuQ3+GqVmgfjc=;
        b=eWmBAQ+4DNRkDjURNgkI55mL2b0jlNAQxQMpWKHtErKbR59e/KEBVFrKhv1phQHx8k
         6aX9lCIUZwEL7cgymQQEHMenj4/6tAUtOcZWzj22HvmkVS08KCtP/2KAjgD368MjQCjj
         raetiLWrPOcf52fz9gxREMLKVPaAGR2wuOhSQjPTvnWDQqfeOYEgqyg+1HH/Izs1fmg8
         uW9LlnLu4VvB4LhJERlv3diauEkTZBSTwQEUzoMgPeeg5Vx7DZBiTzZYPKITTOUlz94i
         Tp6QCJjZSPqH5hOfqsQirWF7kqtSTSLTSXaPKv4AZk0tTGndrm5I8v8Z+foJuPqK0qoi
         v9Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWZwinuJRxGzbECxhLw+d8f/w/skATWMwf6iPNHBewttJYzGZXWw/DlUueggH0/TwjR0Ww43Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36bsYJVbnst0LvBryQozI1QfxPux30ssNBKCwsYRZTurZ/F0X
	8lpj6nsEy3aJSwhJAOdo9rsZissKCTPVYQePOmy/Tj7ecp5hTFolRU/T
X-Gm-Gg: AZuq6aKAbO5cvWXloYXezkBzJwxWBPb9Oo56eBFlhwm706zwSNi0jWXkOtNhzMU/0JI
	UCk/7LK1UJYbvZmS3NlgOAoeyyog9CC0HrmeTmvlh2WQV7DbNNVtad77cpuBHvw39HH63gZ29X0
	1roQb000Ctej80hb2IBeH6md549s2J/UoapGq+/HgtdrkGDy6Vj1AV9a8hoa8evToawJ1Mhjogp
	tx8d/3pu3AH+tNQtn0wtLEJkk5LfCaGu3QpSJpZypex8UHiQ7PhtBCqZSeKyPS14qfshH2JtAjs
	rIaerMAYE9Uznjsah9ReIPCR0sckMd2E+cc4kp02Fwj0IXZ5vhP8wz1pFyazMqP6UyxC9B/7uUL
	OhZWAemhqoTeSydPccQkuMnxhweIDzje7Q2tpcUR2ZVQLG6QKGjdD4cq9Vux6c5RlnRGayGhDai
	idVoX8MnaoBO/XnpkfRfowJ5BsOavw+z8+lQQuL3wNpV751yOOzmWrk/J9Z9M=
X-Received: by 2002:a05:690c:6005:b0:790:afc0:4951 with SMTP id 00721157ae682-794398eefc0mr8434937b3.5.1769117206513;
        Thu, 22 Jan 2026 13:26:46 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943b2cddf3sm1849457b3.53.2026.01.22.13.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 13:26:45 -0800 (PST)
Date: Thu, 22 Jan 2026 16:26:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kshitiz.bartariya@zohomail.in, 
 Mahdi Faramarzpour <mahdifrmx@gmail.com>
Message-ID: <willemdebruijn.kernel.1682586fd684e@gmail.com>
In-Reply-To: <20260122185357.50922-1-mahdifrmx@gmail.com>
References: <20260122185357.50922-1-mahdifrmx@gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252539-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,zohomail.in];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F39B56DBF3
X-Rspamd-Action: no action

Mahdi Faramarzpour wrote:
> This commit adds SNMP drop count increment for the packets in
> per NUMA queues which were introduced in commit b650bf0977d3
> ("udp: remove busylock and add per NUMA queues"). note that SNMP
> counters are incremented currently by the caller for skb. And
> that these skbs on the intermediate queue cannot be counted
> there so need similar logic in their error path.
> 
> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> ---
> v5:
>   - check if drop counts are non-zero before increasing countrers
> v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gmail.com/
>   - move all changes to unlikely(to_drop) branch
> v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/
>   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail.com/
>   - change ENOMEM to ENOBUFS
> v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmail.com/
> ---
>  net/ipv4/udp.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index ffe074cb5..41cf8f7ab 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1793,14 +1793,31 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	}
>  
>  	if (unlikely(to_drop)) {
> +		int err_ipv4 = 0;
> +		int err_ipv6 = 0;

nit: whitespace between variable definition and code block

>  		for (nb = 0; to_drop != NULL; nb++) {
>  			skb = to_drop;
> +			if (skb->protocol == htons(ETH_P_IP))
> +				err_ipv4++;
> +			else
> +				err_ipv6++;

No need for separate counters.

All counters will either update IPv4 or IPv6 stats. Similar to how
the caller of _udp_enqueue_schedule_sk is either __udp_queue_rcv_skb
or __udpv6_queue_rcv_skb and chooses the SNMP stat based on that.

Can check sk_family == PF_INET6 once.

>  			to_drop = skb->next;
>  			skb_mark_not_on_list(skb);
> -			/* TODO: update SNMP values. */
>  			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
>  		}
>  		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> +		if (err_ipv4 > 0) {
> +			SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS,
> +				       err_ipv4);
> +			SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS,
> +				       err_ipv4);
> +		}
> +		if (err_ipv6 > 0) {
> +			SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS,
> +				       err_ipv6);
> +			SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS,
> +				       err_ipv6);
> +		}
>  	}
>  
>  	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
> -- 
> 2.34.1
> 



