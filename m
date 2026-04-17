Return-Path: <netdev+bounces-279295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLlSKMIM4mkg1AAAu9opvQ
	(envelope-from <netdev+bounces-279295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:34:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB241A287
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 240213145392
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470A3B8BCD;
	Fri, 17 Apr 2026 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oa6qtvm6"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DB32A3E5
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421648; cv=none; b=l0uFgHGiJdTMmcR8Fpc2GNIjOlv8T6sJIKdT7ZtXH+5zcAJV9jqHI6wJQcDI87ZoEQc+6IIuScqiaUf80JGgdMUHZyw2gdFrvpewHsmvlQCmZO/tfOaNvw24CVAzXOcL6fmqEyN/v2IuU6rVwO1OdNhxvI/z6ItUA7NA5YG7iG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421648; c=relaxed/simple;
	bh=IaXeKln7M9N7HcvTCKtwJ4tn/m+fj0Km4rcVmVH7hD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTNS1ChCu0Jhmxoin6pUS6PcQTWseAQhIymtDCI5K4bSJ7RG64pdyUdDMSqlEBDJUqXGKD+iHEYDg1dMnyQ2NH/14eE642Lpf3jXa9nuF2ulb6imyokU8EerCTqGQVRBYocCVgzIoRGC+4uoYMqB2RzIPN3TAbPYm0YWmNYaYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oa6qtvm6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d25b0b7-5560-482c-a626-fc43abb045b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776421631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8L1TXwxJHEz1sfg1EUcrGf2kt7J7QaV9bX1WaMgGMU=;
	b=Oa6qtvm642n96GU5TT04Z7xtWs1T0GAdrjl61vbOlvZmKZHrwCGxsdOfZSRdpn+/yn+hu2
	L4E5GSx89h9FmPwpy15PDmLRne3CoyX/PtEIMAgfyxkPE1Ge2yeZmEwSdSWfCdZijQma2o
	Mo0sHyoi3R5jlGGtVXd/mJOKoIMVE/k=
Date: Fri, 17 Apr 2026 18:26:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
To: KaFai Wan <kafai.wan@linux.dev>, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 jiayuan.chen@linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>
References: <20260417092035.2299913-1-kafai.wan@linux.dev>
 <20260417092035.2299913-2-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260417092035.2299913-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279295-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.670];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uestc.edu.cn:email,hust.edu.cn:email,linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49AB241A287
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/17/26 5:20 PM, KaFai Wan wrote:
> A BPF_SOCK_OPS program can enable
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG and then call
> bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB or
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB.
>
> In these callbacks, bpf_setsockopt(TCP_NODELAY) can reach
> __tcp_sock_set_nodelay(), which can call tcp_push_pending_frames().
>
>  From BPF_SOCK_OPS_HDR_OPT_LEN_CB, tcp_push_pending_frames() can call
> tcp_current_mss(), which calls tcp_established_options() and re-enters
> bpf_skops_hdr_opt_len().
>
> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>    -> bpf_setsockopt(TCP_NODELAY)
>      -> tcp_push_pending_frames()
>        -> tcp_current_mss()
>          -> tcp_established_options()
>            -> bpf_skops_hdr_opt_len()
>              -> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>
>  From BPF_SOCK_OPS_WRITE_HDR_OPT_CB, tcp_push_pending_frames() can call
> tcp_write_xmit(), which calls tcp_transmit_skb().  That path recomputes
> header option length through tcp_established_options() and
> bpf_skops_hdr_opt_len() before re-entering bpf_skops_write_hdr_opt().
>
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB
>    -> bpf_setsockopt(TCP_NODELAY)
>      -> tcp_push_pending_frames()
>        -> tcp_write_xmit()
>          -> tcp_transmit_skb()
>            -> tcp_established_options()
>              -> bpf_skops_hdr_opt_len()
>            -> bpf_skops_write_hdr_opt()
>              -> BPF_SOCK_OPS_WRITE_HDR_OPT_CB
>
> This leads to unbounded recursion and can overflow the kernel stack.
>
> Reject TCP_NODELAY with -EOPNOTSUPP in bpf_sock_ops_setsockopt()
> when bpf_setsockopt() is called from
> BPF_SOCK_OPS_HDR_OPT_LEN_CB or BPF_SOCK_OPS_WRITE_HDR_OPT_CB.
>
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn/
> Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

I think the result of AI review is false-positve.



