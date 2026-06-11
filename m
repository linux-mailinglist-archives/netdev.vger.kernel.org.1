Return-Path: <netdev+bounces-298239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3zTfEXToKmrMzAMAu9opvQ
	(envelope-from <netdev+bounces-298239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:55:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC9673C04
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:55:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LKQVYimn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298239-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298239-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F2AC3016294
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F24192FE;
	Thu, 11 Jun 2026 16:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9A405844
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:53:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196816; cv=none; b=aUZGuEzM644LrtvUSMBLSfDkLrjR7G5EE5Yjv5pbMfNLAYam/RR+ac54ZsgM9tE0G81OGFS0q0RuWXkmrkvMH1xCH2IOBHvHisGpFU4csax4XWME9lnJlRntD+5tHkgbcAGXM/7kRYouJlE7ANkSj1qfy8x5iD1VzGk5+JVPY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196816; c=relaxed/simple;
	bh=uwl27xER1N3ExBcQz8DVI3o7oLFjRiI18UHcNqtO6cw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VnMf2VaFnsShiCFLHseWkXgOeLV+YWtlWcjiLv5m7nKAAd1AUxLwv86uaju4cQLI8Nr7ngC55D+IrCBcm6+FobRt4UWJMrC88TkfbOkHrtfcytWKjxVzxm/FcY0/GokYnTPdDNeELT/Z4P8+JKy8+wO+7sDdqo6Q4+4GucfYuQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKQVYimn; arc=none smtp.client-ip=209.85.210.41
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6d14aaef8so43223a34.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781196814; x=1781801614; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIeyQioPSS+ypmU64tqp46eHDd1B4WTlu7Q2LysWAls=;
        b=LKQVYimnENtgP6ahsni+MYrsF4pXC8Deu15pJhfJAXmSzejHALx7VNjhUdQ3r/zPt3
         ZOH1niUkf/OiFf0JPuXSdwRLnUqAHTVri8f78KDewjXBXvhuwd878nEP8x8K6f1bO5n0
         7dyDVNA0Y73Peia0vF5lXG+xoQYkL2QYbpKtvx3fsbjeerPjb37qNA9+J2l8R1vAEqny
         mjfTsof+R0DGVNmGKRBWjseM4D75V2PdQ4XYtxBv+vtcqMFdvlort4votJxas0ojomNc
         PeFTkq56vT2lnQWYRKmnC5oFp7hKNt1BCAhgZgqC6EJDVNv7fUyd+QcKSFujVUOe/rwy
         UUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196814; x=1781801614;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIeyQioPSS+ypmU64tqp46eHDd1B4WTlu7Q2LysWAls=;
        b=WZnSTNOzxlcwJGu8T/4ftdQ32W3BEYQCs32rOCMtelOLx8+mMxcVCZk+5TK4/YA2F4
         NYyWa1FzKcN5lgpfZ3oll6jhgF3YmlvX7FEQAmeyytrPvNItKfBY/G27ln6aUdN/QBCm
         jt71FoD2U/DciNcACmVrBCDK3nM3bU1ZDlqd3X9+HDrRkhxymzfE1DTvz8qKLFuZOYoq
         T3dqKuwzJAfpgW09kbilHmz/i676qZQpk7Cx+IfhUG48vtyRMXeR4yIYIaxgR2Mmvf6y
         E1iKG6dqWo5bhTHD2fNNC3dBH1Z1K88kMJxUI+cH9vmrijvCh+nKtTLQ+Nv1Wvf1H1Yr
         eQdg==
X-Forwarded-Encrypted: i=1; AFNElJ/SYaBjIsjc2jypGvYi+//sJdR1CuArjwOpIw8xOaYKfiNl2Qf4Vke3fxCePFCLO+N4QekriZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYvgMQ70rMM3YeQvtJ4Tbghi5Vp2HzjH8XtnQb+Jcp5WgVLyg
	9ZP7lK5HcREw8QxW7sX3+xyN2KniSOkREq6nQjtp2TRr6HDjMAFKGC2t
X-Gm-Gg: Acq92OGecASxEgL/fjqCffbrST8INxH9RQwd2HgvClv+BcAci8H9KHdkHkN8iTocSgR
	HxiL/mKkDH5P9YMxsXc3dh2pkaAEs2h+vQvJUoux5e0V8xrT7NF82feA++hDDGiwnuEWgEfoIEz
	NlMuObhepWfmv/UPpGWEVgFTNnEwHeWtr3CvmoDC14bY0ADxPz1hcVuVq8A6aQGu+tIc34vlZeE
	9ckScJHnLURefz6JitmpN4AKcQmDQqjDopRPu93n41z3aTZAFX0aRodTi/Z9Xu2qwGpJLDZIU20
	TdvT7nn4V8nGSbeGtcNoOve6qGi4frXWs6qYIUNqgqWVP4dcLZ1UHE2jKncv8sa/MJD577HmKMQ
	1JH7N2ou0YU3q+GXbQfQR4GOrkl8iQoP3KgArs6DkcI01FJosH9dq7qaDDJpN494EWSi1qZN1q9
	yj+smF5Q/o1LSNNeD2Pg7F/v88LztPCTUIKVjJDjAPPbjEtNA622YbpYL1e4/fCWj68mbic7xWj
	F2yH6lcw/4JmOxKdQ==
X-Received: by 2002:a05:6830:640d:b0:7dc:c7aa:22c7 with SMTP id 46e09a7af769-7e7731bef18mr2745759a34.0.1781196814289;
        Thu, 11 Jun 2026 09:53:34 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:15::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e774812262sm1656901a34.0.2026.06.11.09.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 09:53:31 -0700
Message-Id: <DJ6DKMNBR4UX.27HEZMGEPEF7T@gmail.com>
Cc: "Weiming Shi" <bestswngs@gmail.com>, "Xiang Mei" <xmei5@asu.edu>, "Xinyu
 Ma" <mmmxny@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Shuah Khan" <shuah@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Sechang Lim" <rhkrqnwk98@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Cong Wang" <cong.wang@bytedance.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/7] bpf, sockmap: reject overflowing copy + len
 in bpf_msg_push_data()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-2-jiayuan.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:xmei5@asu.edu,m:mmmxny@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:rhkrqnwk98@gmail.com,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,asu.edu,kernel.org,iogearbox.net,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,asu.edu:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9CC9673C04

On Thu Jun 11, 2026 at 5:34 AM PDT, Jiayuan Chen wrote:
> From: Weiming Shi <bestswngs@gmail.com>
>
> When the scatterlist ring is full or nearly full, bpf_msg_push_data()
> enters a copy fallback path and computes copy + len for the page
> allocation size. Since len comes from BPF with arg3_type =3D ARG_ANYTHING
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
> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.=
org
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Tested-by: Xinyu Ma <mmmxny@gmail.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

That's not the right way to post somebody else patches.
You need to keep their authorship and SOB (as you did),
but you also need to add your SOB after theirs.

also pls target bpf-next.

pw-bot: cr

