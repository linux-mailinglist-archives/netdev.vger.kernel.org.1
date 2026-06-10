Return-Path: <netdev+bounces-297785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6F9ZO52hKWruawMAu9opvQ
	(envelope-from <netdev+bounces-297785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:40:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECAF66C041
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:40:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mKvri2hf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297785-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297785-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893E9316E4E6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E5349B1C;
	Wed, 10 Jun 2026 17:35:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2565348C77
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:35:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112916; cv=none; b=bry6cUprJhQY5xPqxsygB13Y3kCi0snnSon69dnSQkXze62VUBRExOa2n7nY3ss6cPmW9j90kGUszltv74gIBjnx76vqkueAuHmdXYkyAO/9IGt5dkC5dKZFiKVHIOdm1dDz2J8gDYhM+l9jGTFHcGJG/NA1lwQOmKiI50fjbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112916; c=relaxed/simple;
	bh=GC4dbUj72/CzNM//E7ZABcGs/pl4qLAV5yt/OMal3/E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u9QxNkfQHHsappMXMtKx5xPI2ZtWQag+Av932D2G+I2UAcHTteM9Eyf7aCeSwKRVfS0s4uyMnjh6Rki0tS2wapz5w4Do+3sMmLktafUBLH7FVzYuxFbc1nOTAntoxXUTTGuhY4RXAP8Emjzxx532Srexn2Wj9ns2Q5ItNFtgiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKvri2hf; arc=none smtp.client-ip=209.85.160.49
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43d16405b54so3126331fac.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781112914; x=1781717714; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKXcTAXyiY5MMHqAfWwxOYdso2q+yhhH5j2phXAXPxw=;
        b=mKvri2hfaIpYBPgrMl5ojn1pAFQQ4qGrSeuxtj39iQ7QolwSgmurRK3KTHszE3dvt0
         stkf7MCF7zu2AFFOS2U0s6a2QiNQB3avcmI3uZEmItSwsyhplQ3RLWREwIWIyi8PYpf8
         OudqskRW2+FJ8yIQBiVs5QVZunlYwQm7iT0fcZeR+F+YwhPZKPZO2bKZ3M/pPsKChH1U
         XCXZbDiRArSO913o2Es+6kaJNM9cKKkA56Y4xcyEmuze2m4zbunOefHj4ZxeX/CEwkE8
         B2Q7Z/Jmut6f+RQ3uYKo58BKeaEk4xxznPgZNL/CIMtJOxKzOm3+tMVHfaGXPAae4Jq7
         0C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112914; x=1781717714;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKXcTAXyiY5MMHqAfWwxOYdso2q+yhhH5j2phXAXPxw=;
        b=LtO3EGt4TXpBpBFpsASpq0YvgLD1EH33fFOEPBwprssa1dCrYjkuEAW/9MQvG1wLPc
         3Tf6SW/LHO97xWm9OfPpVKA6IU1IUdA3nxO+M60pHpZJrg9G71Bc+S7+MbbIzFvMZZ1T
         cx+CrxlJpv2WJvgxhkZPZTT6lHPFjChbjjZ8HouL8LV3hAs22BADJhGYN8ZyNlOyMA24
         9ULjFSv+RV87HfsfRwrTjCgK5K+uAB0MoTc+e3clxdn9C4rHtxrGfeyiztqRBxRPEnlY
         uQQocrLAGkedrrj1rHkxWix48kwX3v4aI/La8tEDlYgnE1GIyL0QSG5P+2STEJMmNtZq
         e5gw==
X-Forwarded-Encrypted: i=1; AFNElJ+o/VaOJuh4qnsNxUoOhBzeyAsrsOqAxlULJ78atVSQwzznnGVGwFQeSlDMEFP1aIq1PcqY8TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMiOEh4MLTA9mM1zMPUQR66+ljMLwE4nriQUhs/YXcSt+ko5X
	akCUa+WGEdGzoIdmAjM+lfujvUemM9iVJX9/JPjgUs/D3wlkpfk+OPsb
X-Gm-Gg: Acq92OGkOnnpYMBwLd982FA+ov4B+WV5epb9UkF5tEdELgvot2IM2DJXhuQFzlRgt0m
	SSEU6gYO4xJFOPqA0CuYVc9ZiJyKTraYkGkZhqC0Voe5BMi3Wm25mZebFYT2nBk1NiZ+SkUPzy6
	03XrVf0ogrQSB+jp9UiaKGscuaWS73GGEZbuOuZCSnEHw4A2z5mYqWoivvoBqa6YjttSze8JXPz
	+RQiXojhEgnZ399omTFSw5pFHabBR2bf4cgbFD3wRcpV5WCZ3jKN3vtv1/mLyM3jNcRQrXq1mCJ
	54Z2Ve2aaHJN8W7VGnnaWE9NwDEEQ1MQysfhMU7xd42jv8gyMIzl79vURi02fxuVN0XqRyoQuGa
	TxBFOBzrEN1DlNks1DvpIS4Bwl/d9Os85Zr67jAC8tpGC71coN1KU0Zw64+s0wahZfL0vk8jgir
	72fbq/hXIyn52fUlsDclZ3QVwPoGyfxMSrYwncjq9/MMg7eHISsQGMGT+xvrAM27CRoA0ksMtAw
	Ry4w8EPoQWkNzM1xB5MLkHdUiRv
X-Received: by 2002:a05:6871:606:b0:442:3434:7dd6 with SMTP id 586e51a60fabf-4423434e34emr404867fac.14.1781112913657;
        Wed, 10 Jun 2026 10:35:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7263efcsm22580309fac.0.2026.06.10.10.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 10:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 10:35:10 -0700
Message-Id: <DJ5JTZ788GDY.FXAAY47YDG3N@gmail.com>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Cong Wang" <cwang@multikernel.io>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>
X-Mailer: aerc
References: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
 <20260610081218.506709-2-rhkrqnwk98@gmail.com>
In-Reply-To: <20260610081218.506709-2-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eddyz87@gmail.com,m:sdf@fomichev.me,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cwang@multikernel.io,m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297785-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,multikernel.io,etsalapatis.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ECAF66C041

On Wed Jun 10, 2026 at 1:11 AM PDT, Sechang Lim wrote:
> start and len are u32, so
>
> 	u64 last =3D start + len;
>
> evaluates start + len in 32-bit and wraps before storing it in last.
> The bounds check
>
> 	if (start >=3D offset + l || last > msg->sg.size)
> 		return -EINVAL;
>
> can then be passed with an out-of-range start/len, after which the pop
> loop runs off the end of the scatterlist and sk_msg_shift_left() calls
> put_page() on the empty msg->sg.end slot:
>
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
>   RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
>   RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
>   Call Trace:
>    <TASK>
>    bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
>    bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
>    sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
>    tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
>    tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
>    __sock_sendmsg+0x153/0x1c0 net/socket.c:802
>    __sys_sendto+0x326/0x430 net/socket.c:2265
>    __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
>    do_syscall_64+0x14c/0x480
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> Widen the addition with a (u64) cast so the bound is evaluated in
> 64-bit and a len near U32_MAX no longer wraps below msg->sg.size.
>
> While here, change pop from int to u32. It counts bytes against the
> unsigned scatterlist lengths and can never be negative, so the signed
> type only invites sign-confusion in the pop loop.
>
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/core/filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 80439767e0ee..9cdfec2ca11e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2974,8 +2974,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, =
u32, start,
>  	   u32, len, u64, flags)
>  {
>  	u32 i =3D 0, l =3D 0, space, offset =3D 0;
> -	u64 last =3D start + len;
> -	int pop;
> +	u64 last =3D (u64)start + len;

sashiko is correct that there are 4 other issue in very similar code path
all in skmsg. Please fix them all in one go.

pw-bot: cr

