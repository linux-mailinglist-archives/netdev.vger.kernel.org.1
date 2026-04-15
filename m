Return-Path: <netdev+bounces-278861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKU+GYvg32kzZwAAu9opvQ
	(envelope-from <netdev+bounces-278861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 21:01:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB06A407418
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 21:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34DD2315F674
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C09384246;
	Wed, 15 Apr 2026 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fzYxV+y4"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD0367F3C;
	Wed, 15 Apr 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279358; cv=none; b=e6PFUD5FARqF9aY+jaPBLUl6JD7tuU1qkz6QIp8iAZmP6VOKGE9kZaS+R9RkMw0a7O4v/ZMjliiGtx2LlTIymsixeuHpItldyPjIwLvUySO6uIZZs98s5eUis0Ezgbt/wXZwFb+9sxt3+0C+qnCAvRd8cHtUFzdVWytqCr42sPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279358; c=relaxed/simple;
	bh=d7HDCHlfPHMSEJBcmaZKe18Vvx67Ei5xQjkmXpACwf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crbNK+L3QovsmdvoNb922HSUhdL8h2RC+0w2scRaCd9IMP6tu+F/TcCz2sehTuvXyUR1214dHvM5jMKNfyt6GwfWNk1McIVb8rEH5Y2WOMaB49hqmcbcM3c8ShKV/y+qhZ0qkKy6S6YejdcQe1S1XNhlD8dz8mDCwvP6bA8ehLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fzYxV+y4; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Apr 2026 11:55:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776279353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tHMuDGDqeRqZTISBkfQrfUInooZ5oSER0Tkzkf4P5Pc=;
	b=fzYxV+y4RadUsTRwF1/2GBnbPHyGieoAH0rO8okhzSU0soXIw0qYxW0SKH4lR7diZRFZ1I
	LNshEC6Duel7JiG/WFrETZLnE1c9HKSUadudH5h9zwfDJ8yuDLcwevEJTNaqljtoQ+LYIN
	zu4NFl3fFmX3s6RsryakztldT+J1+XA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Quan Sun <2022090917019@std.uestc.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf,tcp: avoid infinite recursion in
 BPF_SOCK_OPS_HDR_OPT_LEN_CB
Message-ID: <2026415181939.1bue.martin.lau@linux.dev>
References: <20260414105702.248310-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414105702.248310-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278861-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	RCVD_COUNT_THREE(0.00)[3];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[vger.kernel.org,std.uestc.edu.cn,hust.edu.cn,google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,iogearbox.net,gmail.com,linux.dev,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.811];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,uestc.edu.cn:email,hust.edu.cn:email]
X-Rspamd-Queue-Id: AB06A407418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 06:57:00PM +0800, Jiayuan Chen wrote:
> A BPF_PROG_TYPE_SOCK_OPS program can set BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG
> to inject custom TCP header options. When the kernel builds a TCP packet,
> it calls tcp_established_options() to calculate the header size, which
> invokes bpf_skops_hdr_opt_len() to trigger the BPF_SOCK_OPS_HDR_OPT_LEN_CB
> callback.
> 
> If the BPF program calls bpf_setsockopt(TCP_NODELAY) inside this callback,
> __tcp_sock_set_nodelay() will call tcp_push_pending_frames(), which calls
> tcp_current_mss(), which calls tcp_established_options() again,
> re-triggering the same BPF callback. This creates an infinite recursion
> that exhausts the kernel stack and causes a panic.
> 
> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>   -> bpf_setsockopt(TCP_NODELAY)
> 	-> tcp_push_pending_frames()
> 	  -> tcp_current_mss()
> 		-> tcp_established_options()
> 		  -> bpf_skops_hdr_opt_len()
>                            /* infinite recursion */
> 			-> BPF_SOCK_OPS_HDR_OPT_LEN_CB
> 
> A similar reentrancy issue exists for TCP congestion control, which is
> guarded by tp->bpf_chg_cc_inprogress. Adopt the same approach: introduce
> tp->bpf_hdr_opt_len_cb_inprogress, set it before invoking the callback in
> bpf_skops_hdr_opt_len(), and check it in sol_tcp_sockopt() to reject
> bpf_setsockopt(TCP_NODELAY) calls that would trigger
> tcp_push_pending_frames() and cause the recursion.
> 
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn/

Thanks for the report and fixes suggested across different threads.

Using has_current_bpf_ctx() to avoid tcp_push_pending_frames() should
work but it may change the expectation for bpf_setsockopt(TCP_NODELAY).
e.g. A bpf_tcp_iter does bpf_setsockopt(TCP_NODELAY).

Adding another bit in the tcp_sock is not ideal either. I agree with
Alexei that it is better to reuse the existing bit if we go down this path.
We also need to audit more closely if there are cases that two different
type of bpf progs may call bpf_setsockopt(). e.g.
bpf_tcp_iter does bpf_setsockopt(TCP_CONGESTION) to switch
to a bpf_tcp_cc and the new bpf_tcp_cc->init() will also do
bpf_setsockopt(xxx) which then will be rejected.

Another fix could be, the bpf_setsockopt(TCP_NODELAY) is always broken
for BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB unless
the bpf prog is doing some maneuver to avoid the recursion. Thus,
this use case is basically broken as is and I don't see a use case
for bpf_setsockopt(TCP_NODELAY) when writing header also.
How about checking the bpf_sock->op, level, and optname in
bpf_sock_ops_setsockopt() and return -EOPNOTSUPP?

