Return-Path: <netdev+bounces-279216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHWdFvqf4WkJvwAAu9opvQ
	(envelope-from <netdev+bounces-279216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:50:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9E641658C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9418F3088D86
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35A2367D9;
	Fri, 17 Apr 2026 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxJPuUx2"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6C261B8A
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393870; cv=none; b=BoQ3QPaDAiBPWQ8X9kvoYoLysk8Tsn3d5+0DWNDF6eQrmV8h54In0k/SiNYuN7B9PWhpARdU14fs2L8+OJ1+k6MkfC2c6TLiqYLV1fekub0dzl0cC6bWk47+YKE3Gys57uDu0y6mgLDuGRVsCGxJsb/u0lQizIZ/gRC8vGLFs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393870; c=relaxed/simple;
	bh=jzABcSaSqpM9aDL5CV4XBeoe9jOOv4UbXdZhfHL2GsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE8cLxZeCNIIbPOPGXdK0Dsph1M51kV8JfzUnBqulOfpVwCR/7vNtWa2XzF/Qsl2Ibz6CShQi5hvDPC59N0vFzti84cZpnN3xWjoyg4TX/6GU2fAQDtkK0vtG7YUJ4lnnpbxSvUiH8UGK/6JNhp8Tu1jYmua0jVgd4wNMT7pro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxJPuUx2; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce2019d0-c127-4c0a-8d2a-f373a68d1bd2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776393857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhyqLmxrfpiB9Kg4xW6jUc4n1FOcmNDlAeTxwpau2IY=;
	b=FxJPuUx2aMLHRTnvt7uIlBLwZx1dW2wbeQSbTSxz+aicICgaowi+CYcFNEqX+KX0dIGxE/
	IC/sm8Ai5sN/JL9Bw6NXB9l8+SSwUfYZ8JrXeS2xwXWMG4A9dHoyIKE1DljqwwjD8PQo1V
	f6/dXP96dK2wK9D3G3srrFGs+/6BpYU=
Date: Fri, 17 Apr 2026 10:43:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Reject TCP_NODELAY in TCP header option
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
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
 <20260416112308.1820332-2-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260416112308.1820332-2-kafai.wan@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-279216-lists,netdev=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.805];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uestc.edu.cn:email,hust.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: AD9E641658C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/16/26 7:23 PM, KaFai Wan wrote:
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
> ---
>   net/core/filter.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index fcfcb72663ca..911ff04bca5a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5833,6 +5833,11 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>   	if (!is_locked_tcp_sock_ops(bpf_sock))
>   		return -EOPNOTSUPP;
>   
> +	if ((bpf_sock->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> +	     bpf_sock->op == BPF_SOCK_OPS_WRITE_HDR_OPT_CB) &&
> +	    IS_ENABLED(CONFIG_INET) && level == SOL_TCP && optname == TCP_NODELAY)
> +		return -EOPNOTSUPP;
> +
>   	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
>   }
>   

A simple comment is recommended:

/* TCP_NODELAY triggers tcp_push_pending_frames() and re-enters these 
callbacks. */


Also like Martin pointed before, BPF_SOCK_OPS_HDR_OPT_LEN_CB / 
BPF_SOCK_OPS_WRITE_HDR_OPT_CB

can only be produced under CONFIG_INET so IS_ENABLED(CONFIG_INET) is dead.


