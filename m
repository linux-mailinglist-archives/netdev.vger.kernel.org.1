Return-Path: <netdev+bounces-278572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAdYKR6b3mlrGQAAu9opvQ
	(envelope-from <netdev+bounces-278572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:53:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A13FE22A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388CB305932D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C77317160;
	Tue, 14 Apr 2026 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wKLGMMmp"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5E39FD4
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196291; cv=none; b=h+1zNlAqOT3idtS4qA8rm8qnwkgfkgJvHRAxq5c+EMFGyY+EKecTVxT6zb312UkhZVGoLTEgPVHSQz0gLXxujekqvPub6Qa68ITRfO943CLyT8QcBb3l1rxsLedfYw5/mY/Vs8U2TaoS577BeLU6uDOxGy5oioQYD4qntjIyeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196291; c=relaxed/simple;
	bh=Ktyo/tmwj8hKfjyIiy6TVXwWZHzA2TsM7aZHkNix6T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGCwSaUEYKExdjr3XYnL0v+vV8/7cZYFk0vGh7y78IHZy/Yn4yHELogIDdHLWghG4YTpOEgjIEvDcQDCpz2GoN6bALsTAgwzZSd7b8jZ0CUJlk6WiDWl+QEcbDUNFMev14yHYon7HGjCn/FSu9GNQucnaaMmbpgtG/61OByY1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wKLGMMmp; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Apr 2026 12:51:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776196278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEtLnsJn3BqMpUymKETuHSwe/D/AvMKw4t2nNlXY6lI=;
	b=wKLGMMmpP2+jRWxM5XMZBAgY1PXFs44BBFZiRRb2OJR67N5FlNbPPN9FTdV8yUz7Vzp61W
	lqqnWq6LS+Afz9W5flfgI18REp0fGymKsrGBmPiNE2FcBgo/G4jeSW8O23vdxirS0IhyVp
	AG66u7qKnwdnRL2Z+zsghjkdoJPhSKM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: add missing syncookie statistics
 for BPF custom syncookies
Message-ID: <2026414194421.camy.martin.lau@linux.dev>
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411013211.225834-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,fomichev.me];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 485A13FE22A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 09:32:04AM +0800, Jiayuan Chen wrote:
> 2. Remove the CONFIG_BPF_SYSCALL guard around struct bpf_tcp_req_attrs.
>    This struct is referenced by bpf_sk_assign_tcp_reqsk() in
>    net/core/filter.c which is compiled unconditionally, so wrapping
>    the definition in a config guard could cause build failures when
>    CONFIG_BPF_SYSCALL=n.

A typo and CONFIG_BPF is removed instead?

but the reason is probably not because of a build error.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6156d1d068e1..570a8836c2ba 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -598,7 +598,6 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
>  					    struct tcp_options_received *tcp_opt,
>  					    int mss, u32 tsoff);
>  
> -#if IS_ENABLED(CONFIG_BPF)
>  struct bpf_tcp_req_attrs {
>  	u32 rcv_tsval;
>  	u32 rcv_tsecr;
> @@ -612,7 +611,6 @@ struct bpf_tcp_req_attrs {
>  	u8 usec_ts_ok;
>  	u8 reserved[3];
>  };
> -#endif

