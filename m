Return-Path: <netdev+bounces-280312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL2zB1tX6GmwJQIAu9opvQ
	(envelope-from <netdev+bounces-280312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:06:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AAD4420D3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 228CE3020804
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBA72D238F;
	Wed, 22 Apr 2026 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gFIoN/Ud"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08212D5932
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776834390; cv=none; b=Nj5uc70A/onmtYb8ZyY91NVFl/uZjlpUk5MFaXxlXu/8Fh6+IuVVm6emIIu4JouPUsCkgSJ1EImBPBU1cD4Kg5BD2p1oteelYgzlta9Hiu33J9o2ECAkAcYkSN2A+bVIHN6Oe+xLKcjdevQJkMgSg6C0SDMa4MdLgDxer49SrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776834390; c=relaxed/simple;
	bh=xGwKfExeAyRXOcJ9GqvA135TODWRUCOjYTSeqSRO3tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pxIO+IkYWyvpxdve5fHcwbZaS++E1udKRxrWUcQwrfxvepijsEF2B3tkOuZp54rAI6tA4NDtLFr3cAIQacJoq7Qpcxk8wWv0qOabka7iAa8Y/a3eaHsTqAxJOAVmuG1B1PB0GTEvBeE0BfWwkW3ll+pUdtbpZ1UlU/VlTlbStSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gFIoN/Ud; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e03558e0-e097-4480-b5d7-de2979b576ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776834376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nfAE9HDuK/37R4UeC9uZx1HVQgNy9RzoW9NqfXCYkU=;
	b=gFIoN/UdmOPN1lvj/8mKp0lTDirpRzVIDOJz5k70LlRc+dhmH451Auhnf0kV8ciLm5bamh
	K3zrTwrSqY9ohs8GJ1LCTksVqaF4UHSjKucqsd0nhpGQgY5AwkrOJoGe1F4sbnSwfC9JOX
	LouxPukElF/CPePyvfVxYM7X/A4MVsA=
Date: Wed, 22 Apr 2026 13:05:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Reject TCP_NODELAY in bpf-tcp-cc
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, shuah@kernel.org,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev, hoyeon.lee@suse.com,
 ameryhung@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260421155804.135786-1-kafai.wan@linux.dev>
 <20260421155804.135786-3-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260421155804.135786-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280312-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,fomichev.me,davemloft.net,google.com,redhat.com,suse.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6AAD4420D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/21/26 11:58 PM, KaFai Wan wrote:
> A BPF TCP congestion control program can call bpf_setsockopt() from
> its callbacks. In current kernels, if it calls
> bpf_setsockopt(TCP_NODELAY) from cwnd_event_tx_start(), the call can
> re-enter the TCP transmit path before the outer tcp_transmit_skb()
> has completed and advanced the send head.
>
> This can re-trigger CA_EVENT_TX_START and lead to unbounded recursion:
>
>    tcp_transmit_skb()
>      -> tcp_event_data_sent()
>        -> tcp_ca_event(sk, CA_EVENT_TX_START)
>          -> cwnd_event_tx_start()
>            -> bpf_setsockopt(TCP_NODELAY)
>              -> tcp_push_pending_frames()
>                -> tcp_write_xmit()
>                  -> tcp_transmit_skb()
>
> This leads to unbounded recursion and can overflow the kernel stack.
>
> Reject TCP_NODELAY with -EOPNOTSUPP for bpf-tcp-cc by introducing
> a dedicated setsockopt proto for BPF_PROG_TYPE_STRUCT_OPS TCP
> congestion control programs.
>
> Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

