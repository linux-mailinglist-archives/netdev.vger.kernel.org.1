Return-Path: <netdev+bounces-291394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 57NrE96OFGqaOQcAu9opvQ
	(envelope-from <netdev+bounces-291394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:03:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C85CD880
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6244301467C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E011B31B131;
	Mon, 25 May 2026 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUABLCMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F7282F3E;
	Mon, 25 May 2026 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732186; cv=none; b=kGCSzxl+QFwzmZkEt8ACiJihrOHVtxfYeqWoyNjJdfS0pmwv1lkyitcEQPYVo5KJHCIPdhB96bnlHs8Q4HQG0WC2FuRKarSAdInXKOHkRH0cbHf9Ve0PzejJWb2nobUydMzJnakjrZAIWRoacsCpiVmBPgI0NJ60XipdINQVJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732186; c=relaxed/simple;
	bh=MaK4IkgXYWyF3KGpYTyhroCCXobtVKieVSAnv1bUvVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ch+qXcsGkfpktEy34TLxVfpoCbQv4lplAlcbVXq0+e8tpNJV9NKsVgtkxZiY8uMz2DzuHtmmDvgRrH4ifK8oLOESVt8FBmqpVzfQTC99kkQW6tFUU/QeCXzIBxvHCC71mMR7XwoCYKopq6Z3waXMdcdTHJMH+vnSt5d9wBjfx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUABLCMN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84931F000E9;
	Mon, 25 May 2026 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779732185;
	bh=EZmKZj0tmNuNOpUMVsW1hFiX64ghV2P+heHD4ObW+3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cUABLCMNTVGQSG6D53si59rS97g9ujXoHktcUNg4KIrddzSVHm7X7j3iyz9Y5V0ZM
	 RHoFd9V6UICEHQPKm1o4vXPo2gsJI5S09BeeKDPrCFdIAdsbapzwXqWSgPi7icIgjw
	 LKdFhB8C68rGwgtpWe3wNMlgTnSGj4emutJ0QTspPuNfJPyY1H4VAHbT4ILXbNEQqw
	 Sgt5j2Pw91i6yBXLn53h85lrA3COMgwpuCHFeZUj3w3o5S9zaXcQzOd+T6FnC7MDjG
	 bc+yzk3kwIoailEuakA0wMAevL3/IcfQYSAtJbAd3Pb0Fy58olz06SBh5SeTMSH3K2
	 bbjJv/kBb1GfQ==
Date: Mon, 25 May 2026 11:03:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Jamal
 Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] net/sched: cls_bpf: prevent unbounded recursion in
 offload rollback
Message-ID: <20260525110303.4121f19b@kernel.org>
In-Reply-To: <20260522025854.341647-1-jiayuan.chen@linux.dev>
References: <20260522025854.341647-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,linux.dev,kernel.org,gmail.com,fomichev.me,mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 986C85CD880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 10:58:53 +0800 Jiayuan Chen wrote:
> -	if (prog && err) {
> -		cls_bpf_offload_cmd(tp, oldprog, prog, extack);
> +	if (prog && err && !is_rollback) {
> +		cls_bpf_offload_cmd(tp, oldprog, prog, extack, true);
>  		return err;
>  	}

Doesn't matter in practice but for code clarity we should only gate 
the call to cls_bpf_offload_cmd() not the entire error path.

With that:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

I'd take this via -next.

