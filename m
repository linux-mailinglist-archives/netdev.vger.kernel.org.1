Return-Path: <netdev+bounces-298837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v62LBlukLGrtUAQAu9opvQ
	(envelope-from <netdev+bounces-298837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:29:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A467D4C7
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:29:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GgfahnZQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298837-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298837-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDD1030074ED
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1E1FF5E3;
	Sat, 13 Jun 2026 00:29:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9E1F3BA4
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:29:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310549; cv=none; b=hClQ3Dq6Cuq9PsGaBbPOu1OeAdatGsNWDpZeNm5lYzwI4VvICpWQM5e3bgsBprtyqZ9Obd6GTyCrwKw9l/m0ruXgxlvDuojDwqNYZXLjwuPThKtaWQiMNsy9HQuqZX0gh7zXWX/HngzRC5mOylkjt48l4btJLcJSNsXE3k60KI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310549; c=relaxed/simple;
	bh=QgXc4ODljJhWTTpaw445TVamF/nyBWaAo/I/wBG/rxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YP/jBQ5WnaI7loB4BCVNW7WYEorAx1EOyOdkltQRHFgVusmisQc1lvbN3cB5c4h8kliJ7gS77j5zy6jSadJkZK7sRqdi+IKgOlJnH1zcx2m6FD+0n7k6OZgroDCw9hluIOlUg5DedcNymUW1xdj10nYUPvyBeeugXQNg/5SmrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgfahnZQ; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2a4babe45so8803705ad.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310548; x=1781915348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUh6D4rBcGOJpXdbW9cjRObx5ZfnYBi6zdUUzwINyao=;
        b=GgfahnZQrDLbK9ff4h7onSM3J8k8edLC0IeZsMQ3zTs5hIgSLN33JCo0G5hnVRPAxI
         yI6hhCsAOFWhLQWph7JAtLchoGGadyXAigHE6ktPTnaaqz8MVKNp/aG6tf1y+k8IcXrr
         aVdCYn4H4xGMV+EZd2tvnjosIPW1I5pmMSaf9agrPjKTjKP/dnP6SnDDLq2Z1sKGQ8hQ
         WyZQNb9VXzm77534zFmH77B/P82tH0F6YK+qkI4wRqKBaVD9kojNaaQ5egLJNuPJ75er
         d3YTaM+NZWQ31AfMvFWD7pIXbxOyxGno0gtrHkdDRBdNn+GLUl4WBy4lGk2jmcBsQwaa
         Y8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310548; x=1781915348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUh6D4rBcGOJpXdbW9cjRObx5ZfnYBi6zdUUzwINyao=;
        b=C2pnlfeDc/WjUtHwE6cIYuZsAE/3JY04TLJ5EPS5MpijUVnYbC0u7Q10R9ZgrfMroI
         GjQPSfkA3k/H+H/gvLCAjgHIFBU/kY3ZdCmarP6xPBfq6PHz7rRpulLAg7W2PI/89hs3
         +OHkjTjazdrJL+bZ6gEKf76mTSHXADu81s0kLjdxxNyNzfvIFR8OnixYO6TsZNpDuCUo
         ZbVNG+XD0s2tQ6SAe5zYgv9bReYK0B9SLpO4w70XKugVOjkx1E4W2xLLM7SXx4iyIwQg
         SnWzrNvpc1Ar325vMo7q8msTH7DgOC4KcyRw76S0hCVO8RZsgKFdOoYNzjyCd51esez7
         nixw==
X-Forwarded-Encrypted: i=1; AFNElJ/aQmcCJLdXP8dK/srXDDMYdxFAizPdCJTMDuGmTSFvZZe8k5+Do9BezlgBJo2kqCrT4z4rRFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhG2QTC6fJWDwNstNLs5zg79BAUdQnjW8L1c2K7hwFxgoRFKDl
	rxFWUDL4e0PLaUULPIyu0LV8ENfQPuUXw6iWGBrKDHcj35ki9tqUJrYpFV74BNH0edYBuwST5d6
	3gC1xWw==
X-Received: from plbjx9.prod.google.com ([2002:a17:903:1389:b0:2bd:9bd8:749b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec7:b0:2c1:f29a:b554
 with SMTP id d9443c01a7336-2c664271df6mr18671095ad.21.1781310547424; Fri, 12
 Jun 2026 17:29:07 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:28:38 +0000
In-Reply-To: <20260612130919.299124-4-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612130919.299124-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002906.1336958-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf, sockmap: zero-initialize pages
 allocated in bpf_msg_push_data
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jiayuan.chen@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bestswngs@gmail.com, 
	bpf@vger.kernel.org, cong.wang@bytedance.com, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	emil@etsalapatis.com, hawk@kernel.org, horms@kernel.org, 
	ihor.solodrai@linux.dev, jakub@cloudflare.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mmmxny@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	rhkrqnwk98@gmail.com, sdf@fomichev.me, shuah@kernel.org, song@kernel.org, 
	xmei5@asu.edu, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298837-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:bestswngs@gmail.com,m:bpf@vger.kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:hawk@kernel.org,m:horms@kernel.org,m:ihor.solodrai@linux.dev,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:mmmxny@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rhkrqnwk98@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:xmei5@asu.edu,m:yonghong.song@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,bytedance.com,iogearbox.net,davemloft.net,google.com,etsalapatis.com,linux.dev,cloudflare.com,redhat.com,fomichev.me,asu.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,asu.edu:email,vger.kernel.org:from_smtp,etsalapatis.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F21A467D4C7

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Fri, 12 Jun 2026 21:07:47 +0800
> From: Weiming Shi <bestswngs@gmail.com>
> 
> bpf_msg_push_data() allocates pages via alloc_pages() without
> __GFP_ZERO. In the non-copy path, the entire page of uninitialized
> heap content is added directly to the sk_msg scatterlist, which is
> then transmitted over TCP to userspace via tcp_bpf_push(). In the
> copy path, a gap of len bytes between the front and back memcpy
> regions is similarly left uninitialized.
> 
> This leads to a kernel heap information leak: stale page content
> including kernel pointers from the direct-map and vmemmap regions
> is transmitted to userspace, which can be used to defeat KASLR.
> 
> Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
> page is always zeroed before it enters the scatterlist.
> 
> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Tested-by: Xinyu Ma <mmmxny@gmail.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3e555f276ba80..6e345ca65ca14 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2832,7 +2832,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  	if (unlikely(copy + len < copy))
>  		return -EINVAL;
>  
> -	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> +	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,

This is a red flag.

We have a bunch of KMSAN reports due to raw/packet sockets,
which requires CAP_NET_ADMIN, and leave them unfixed although
some people attempted to "fix" them by adding __GFP_ZERO to
__alloc_skb().



>  			   get_order(copy + len));
>  	if (unlikely(!page))
>  		return -ENOMEM;
> -- 
> 2.43.0

