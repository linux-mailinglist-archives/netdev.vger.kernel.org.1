Return-Path: <netdev+bounces-298222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3CUEE5jmKmpBzAMAu9opvQ
	(envelope-from <netdev+bounces-298222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:47:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CFB673AC6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:47:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=ZRdybbqo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298222-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298222-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19EC833E4EE8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227594279E3;
	Thu, 11 Jun 2026 16:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B5201278
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:27:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195264; cv=none; b=KFG192jJBJsnXuw+ng1AJ6e5LyKY1HOQHvHHu8tBrv4cUaOQiEvdhY932e68fO1wfkSIdLOYM8NeZlj/UlHplTtv7ZQX78hFgp8shIbu9KkL8gxt4zl2MoxbKOl9U1q88vaabQEb7dZU7TgnK2j+SzuHiDcGxzcKPgoOo2nTbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195264; c=relaxed/simple;
	bh=o6+f15UBh3/yTDV9eUcXAhmyyH3yJMXjUp0vK+0tjRo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=nL8d/0hb2qqRkRcz3aEAC7ufrTDGFdDEWpZiniQA0PID7eIIul8/mwegcVyIcXiZoUvHbrM99QM/3nbzo2dbs35KEtpSiQ7VbwZiG9SO2H8UJ3I+mPnY6o2XPyyQrYFhE9KXXq09m1bNBFVRSyxFq8i1cOO1h9qGja2I2lhN+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZRdybbqo; arc=none smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1382533d428so58270c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781195261; x=1781800061; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHOgJn/4y6N8Z6nRlIY4TDWtqDPGGDCIQEUNbW0Y9Ng=;
        b=ZRdybbqol5AdhTR0qOBDpYqif3qwT0nKMSbxUWBx89q5/fO5PpOCMsZkcLfD9dZxkv
         1HTW57Divqu5vCbcrSlmQWq4/N7k1g8FoTi/cKdn2PUlJK7zjp1LxV/TI0mVTz6Dug48
         Yym0XhMxlX/wLyOqAnGD56obI/tp6bys5v2D2P2kpWzv+sxV1GH6qcNduDZgTAra8/ay
         YOjVm/5AVJuXTYM1i+6ChGkG8NVaWFrMlvIqQFF3ctYVUFAwPT+AGxZxPceMQW72iVyy
         rFy8U1/xQGmtpEpn/DDY+A9LoKfTEsQKpk2wRA9w8R2HFY12/x6p112HEimbLz8F3wi2
         BNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195261; x=1781800061;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHOgJn/4y6N8Z6nRlIY4TDWtqDPGGDCIQEUNbW0Y9Ng=;
        b=Tvyr4tWopjQ4UD6ZHdAzdfTiftYmst7D7oUINOyMJmJOzzIO86mw7NDNUoxZ+r5+jP
         pwKEDtc6IDbt3/JkYkd81ytFkun+fI7QhywPZj7IoRwj//wMvcLiOmM4tojM1VfljG6G
         QrMkInU4brkJJ0Eh4MAoNgM/l9o4+2wzEHb9L0ROjKx4zRMRqELJQVeBouKWhmHQJOqc
         tjJqR6dvVxIjSeIIyJSvCDB/b5GwesGcdJRoyzR0nlCFc5u33M2DGf6w+syPBv+rBS1X
         lqiMzvBhBl3sw+mqydGElB7oysr+/3t1jr52/5ltXOfnp2TcEPUykXOAKwW+iDKlwHPo
         tbIA==
X-Forwarded-Encrypted: i=1; AFNElJ/CUCfxYD6FJ2RXfQk6M/x4t+R0U+pFdaCWMlhgchXNTnRgx6ac0peKADBG5lXZNQI91bqTK5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKbnT5nmGxITVuNKKLpKbnfx213VWVXQ7lGCG1TaXCS9hKe3G
	O9tIdPLyRc7dipgYOKojWg4leOWe8X/PA7/wla17p26chYhgRqC7oVNRCDNWqCuBWKQ=
X-Gm-Gg: Acq92OH1dZeINsEToUq5AW/md9eqLj0tVfFkMTpSecdW8tTC0+NQDpCXzG5oAEyAb7p
	h6/YwONggU+S0U9FTxdqQtn7MyltUfGgLgO5bO6o4zlpqW9h3KHvljK4HmOvzsdB4EibzR4iyqh
	+y5ckqPVz7CmwQTFc68w81RNtDX9vn5oG0AJ3HtGhnq2G2ke9XjT99AC5SZSHo+xdXOQ9QPpJ7A
	nMrrGIgDHqxudUviEKfblb+G/Mb5xzuxoPceHVeQKSE4QU6Vb8OFUa/AAC2BRtHTxBhnfDEwNg7
	Q1NDiPqsFbFpW5wburjX3ZYkVlQ/FWtf1VO+YsQb3UNqYecUW2s/I9f+Ld5OyEf0rARAJulOMRX
	lNBgCSiWhHLEn/QVFeTOWvMG+EhmWvx5dicceWrxxN655ONhohDgTTSqOKqqqOc28GCEH9PDxlk
	buR4kl
X-Received: by 2002:a05:7023:a56:20b0:138:576:fd with SMTP id a92af1059eb24-138421833f5mr1484959c88.2.1781195260827;
        Thu, 11 Jun 2026 09:27:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9f35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384303a312sm2857258c88.12.2026.06.11.09.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 12:27:37 -0400
Message-Id: <DJ6D0SSBHB0K.3B83F5Z3EBQWN@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-2-jiayuan.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298222-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:mmmxny@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:rhkrqnwk98@gmail.com,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	DMARC_NA(0.00)[etsalapatis.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,asu.edu,kernel.org,iogearbox.net,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime,vger.kernel.org:from_smtp,asu.edu:email,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38CFB673AC6

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.=
org
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Tested-by: Xinyu Ma <mmmxny@gmail.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> To sashiko:
>
> Regarding bpf_msg_push_data() reading "copy =3D msg->sg.data[i].length" w=
ith
> i =3D=3D msg->sg.end (appending at the very end of a full/near-full ring)=
:
>
> This is pre-existing code, not touched by this series, and reproducing it=
 needs
> a narrow combination -- a pure append at the end so the loop exits with
> i =3D=3D msg->sg.end, a full/near-full ring, plus a prior push/pop histor=
y that
> leaves a stale length in the otherwise-unused end slot. A freshly built r=
ing
> zeroes that slot, so copy stays 0. We don't consider it practically repro=
ducible.
>
> Even then it's already covered: the overflow check in patch 1 ("copy + le=
n <
> copy") rejects the dangerous case, and __GFP_ZERO in patch 3 prevents any=
 data
> exposure. Not worth fixing here.
> ---
>  net/core/filter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..3c8f1cedb217f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2829,6 +2829,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (!space || (space =3D=3D 1 && start !=3D offset))
>  		copy =3D msg->sg.data[i].length;
> =20
> +	if (unlikely(copy + len < copy))
> +		return -EINVAL;
> +
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));
>  	if (unlikely(!page))


