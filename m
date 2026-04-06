Return-Path: <netdev+bounces-275772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJz7EOo71GlqsQcAu9opvQ
	(envelope-from <netdev+bounces-275772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:04:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78003A800A
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B4A730071F7
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8383E39F192;
	Mon,  6 Apr 2026 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xuTJIJhj"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719938F951
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516646; cv=none; b=V4Yeg0ZUjI2QP7dS/IN3pqKeVOOqRseTGG7j9z2QemzkFjXU3k9fYw0UgRK/zdw2s7iWMQfPs5ukmwjoVAW+kbt1uQ5mnmTR/MW5QUHQCJawH2tL6YwCZlAiD5BNp/zTSHIAq+dIoPlUcQVgRsubAHYUty/eqbIMRoIuZ5oDZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516646; c=relaxed/simple;
	bh=nOXZ/qAN6W7udkeDm6idzt5SGPmk+S+wX8zvfg7ThUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3TMLZ9lDUW4f0SQdhtAscSdNjRIATN0bmlLAjQIPFEzr8bp2sygxaONbKK4pWpvWgaxxnxPLjKiwIWYJQksKZnzER/X0Q37tUbFCGUtAiUlRCzG7fasxnYSQqbX/8dpYylitwfKGhnRKl1h263EEyirYkX4ka5IcmVgF72pZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xuTJIJhj; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 Apr 2026 16:03:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775516643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qUf5YDck2DrUiN+WT+6OlM1LYCDSCEbtT+zInFZMOIU=;
	b=xuTJIJhj6Gdlc4tZh7RoJknEjqWf3RhBqwRrpkg42+IkPvOa8P35OD3W7+Yt+oVePnaJ8M
	V5vvwcdKEfRNTQtc6Cv/CN75MngNKHMMbNMc/goPdQIp8fzcBlTTfHuKzWvU3qZeLYRdom
	k/2OiQLrdCxFGt6JwW+RXM4Y//H1iVw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Quan Sun <2022090917019@std.uestc.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix same-register dst/src OOB read and
 pointer leak in sock_ops
Message-ID: <20264623229.qO5V.martin.lau@linux.dev>
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406031330.187630-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275772-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,std.uestc.edu.cn,hust.edu.cn,etsalapatis.com,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: D78003A800A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 11:12:50AM +0800, Jiayuan Chen wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb05..53ce06ed4a88e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10581,10 +10581,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  				      si->dst_reg, si->dst_reg,		      \
>  				      offsetof(OBJ, OBJ_FIELD));	      \
>  		if (si->dst_reg == si->src_reg)	{			      \
> -			*insn++ = BPF_JMP_A(1);				      \
> +			*insn++ = BPF_JMP_A(2);				      \
>  			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>  				      offsetof(struct bpf_sock_ops_kern,      \
>  				      temp));				      \
> +			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \
>  		}							      \
>  	} while (0)
>  
> @@ -10618,10 +10619,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  				      si->dst_reg, si->src_reg,		      \
>  				      offsetof(struct bpf_sock_ops_kern, sk));\
>  		if (si->dst_reg == si->src_reg)	{			      \
> -			*insn++ = BPF_JMP_A(1);				      \
> +			*insn++ = BPF_JMP_A(2);				      \
>  			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>  				      offsetof(struct bpf_sock_ops_kern,      \
>  				      temp));				      \
> +			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

