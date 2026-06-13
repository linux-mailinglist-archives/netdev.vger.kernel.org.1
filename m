Return-Path: <netdev+bounces-298833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BD9lFyegLGr2TwQAu9opvQ
	(envelope-from <netdev+bounces-298833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:11:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AB67D30C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=neJDuHKN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298833-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298833-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6059B301E57B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D5E571;
	Sat, 13 Jun 2026 00:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CF1C01
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:10:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309438; cv=none; b=qCLL4w2lBGdG2gQ9I81oE7xsbkIUftGgqknNsn0RdHRIBh6HgIl9L55B86iV/68g2C1AlT8swRg+foOon6P23UYHsP038dA8Xtzi8tyTnmnCwHSUTCgy91QUye7aBUtXzP3iSO7Br5h+bjc3Q/0Urcf6n5hFn4WkYV5MHFQxWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309438; c=relaxed/simple;
	bh=bNMsgYGyF4Tc6YjEZ9ElAv1ahEqg8OKorBlOU3Fmhfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nj4su/B4IwNX4RjAfy7GdIOO3sUbDDV++8M6fcQsRf41zDFb9u7eSANvCiqv8sJ9fdv5OGdSlPXOq9BHp37qvpCxruvSSO9JYoJ9TE0sBHlH77pmGfWAeEOF2cXBYpSOulyoCWBmNzq8NOMG0P7OfSZQWgPweh9yGscxdzie1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=neJDuHKN; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so25054545ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309436; x=1781914236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyks4UFOUwCvj/2wr5bJ0bF+lU7UlWavCSZG1GuENqE=;
        b=neJDuHKNODfH4YLs8X5yESc74jXRcypOMa4MlCO0H3J0GADKfHQVrWxGqXrRx+nsKt
         2mjhbayTupb/EYmvEQzgVD8HzGEnUIfK4w4IlelsqUm5uuagIbpi5R8Cx54MIv1Zjqi+
         gh1LooHxi+sd7smSQSZbOWA8JzA/auc5k/eTucyFKO2XQv+lOVWOdCjaDe6Aw9Z9tZwr
         EpElC3P3VWDdzJAeEhFln5+++w/dYNwKFYoQ97Dgxx23elc30PKD8i9+r6w+OHRIPAv6
         1kLkksUi+LfqYt7mLfVLNF6R/APHhw+rcZAxsGyG2NR77XbzgScbytsXJNVglAah5dqs
         ADew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309436; x=1781914236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyks4UFOUwCvj/2wr5bJ0bF+lU7UlWavCSZG1GuENqE=;
        b=RMmhKg3x4k0oyEQ0KzcAhFVBJDusn6LOMs2TBOE6gfNrqwk91c1lDTfh9IUSom7U+t
         oDmZVFMwbisdsDs5HylW6Ep0qfSqVQso+6C3ky6zJvlf0AHcAiM7C8whyQ6OksLyrUR3
         gj4j3h5hm3BuCjqOsvwlWcLiYJTyLz294PHeNTjGMR7sYjrNetzC1Ao8JbgS4MTOovnZ
         pE08f7ZQ6Rmp7gTF6bB6RIhSOSdPocLsc2lr8s0fqVGljZ1kDX0vk/1KWnOQRzfVYdO3
         fFmI4X6VGdcp9FlX/pT8M/EN3zZmSmcchHQcz0Gx1BWP9VieCpvQEmEwtPk2GKkJTFXN
         l+OA==
X-Forwarded-Encrypted: i=1; AFNElJ9Qw9Z6P9+4wi9MiFDjpoYtKRuzB+kpMko6ujdyFsfTrCQ2AL51pvd/oO9opFJ1BL35pcecsj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0igzegeJ4+J1i55xv8v5RV4Du+8bSHZIuigLob6qWocy+6A8
	O/22PZ0bUrJV+N2b7cKbuQAY7T2YuLSXVj9rWC770LMeeQ2Tqrk+dPoKhhsZeZNifqKJSAfvaAZ
	6evZpQg==
X-Received: from plpn16.prod.google.com ([2002:a17:902:9690:b0:2bc:bb0f:91a1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4587:b0:2bf:2e93:c624
 with SMTP id d9443c01a7336-2c41284101amr59144935ad.27.1781309435945; Fri, 12
 Jun 2026 17:10:35 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:09:38 +0000
In-Reply-To: <20260612130919.299124-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612130919.299124-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613001033.1323846-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf, sockmap: reject overflowing copy +
 len in bpf_msg_push_data()
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
	xmei5@asu.edu, yonghong.song@linux.dev, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:bestswngs@gmail.com,m:bpf@vger.kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:hawk@kernel.org,m:horms@kernel.org,m:ihor.solodrai@linux.dev,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:mmmxny@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rhkrqnwk98@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:xmei5@asu.edu,m:yonghong.song@linux.dev,m:kuniyu@google.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298833-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,bytedance.com,iogearbox.net,davemloft.net,google.com,etsalapatis.com,linux.dev,cloudflare.com,redhat.com,fomichev.me,asu.edu];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,asu.edu:email,vger.kernel.org:from_smtp,etsalapatis.com:email,ebpf.io:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF1AB67D30C

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Fri, 12 Jun 2026 21:07:45 +0800
> From: Weiming Shi <bestswngs@gmail.com>
> 
> When the scatterlist ring is full or nearly full, bpf_msg_push_data()
> enters a copy fallback path and computes copy + len for the page
> allocation size. Since len comes from BPF with arg3_type = ARG_ANYTHING
> and both are u32, a crafted len can wrap the sum to a small value,
> causing an undersized allocation followed by an out-of-bounds memcpy.
> 
>  BUG: unable to handle page fault for address: ffffed104089a402
>  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>  Call Trace:
>   __asan_memcpy (mm/kasan/shadow.c:105)
>   bpf_msg_push_data (net/core/filter.c:2852 net/core/filter.c:2788)
>   bpf_prog_9ed8b5711920a7d7+0x2e/0x36
>   sk_psock_msg_verdict (net/core/skmsg.c:934)
>   tcp_bpf_sendmsg (net/ipv4/tcp_bpf.c:421 net/ipv4/tcp_bpf.c:584)
>   __sys_sendto (net/socket.c:2206)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> Add an overflow check before the allocation.
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
> To sashiko:
> 
> Regarding bpf_msg_push_data() reading "copy = msg->sg.data[i].length" with
> i == msg->sg.end (appending at the very end of a full/near-full ring):
> 
> This is pre-existing code, not touched by this series, and reproducing it needs
> a narrow combination -- a pure append at the end so the loop exits with
> i == msg->sg.end, a full/near-full ring, plus a prior push/pop history that
> leaves a stale length in the otherwise-unused end slot. A freshly built ring
> zeroes that slot, so copy stays 0. We don't consider it practically reproducible.
> 
> Even then it's already covered: the overflow check in patch 1 ("copy + len <
> copy") rejects the dangerous case, and __GFP_ZERO in patch 3 prevents any data
> exposure. Not worth fixing here.
> ---
>  net/core/filter.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..3c8f1cedb217f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2829,6 +2829,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  	if (!space || (space == 1 && start != offset))
>  		copy = msg->sg.data[i].length;
>  
> +	if (unlikely(copy + len < copy))
> +		return -EINVAL;

Who wants to push E2BIG "metadata or option" ? :(
https://docs.ebpf.io/linux/helper-function/bpf_msg_push_data/

I feel this is the same class of "bug" we discussed recently,
but given the change is just small validation,

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

