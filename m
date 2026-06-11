Return-Path: <netdev+bounces-298241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SAgYNz7oKmq+zAMAu9opvQ
	(envelope-from <netdev+bounces-298241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:54:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7946A673BD7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:54:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=piQdKggZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298241-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298241-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEAB7302EDE1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D24266BF;
	Thu, 11 Jun 2026 16:54:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8A408601
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:54:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196858; cv=none; b=YSdi7SahmIwx/5f51pF1OpIoGBihnfG2PqG6r2R80TnlgS/2hLIHTMtkp2qR5ZBwz1MQi26HYPsLsXdxHwBqrZhKHz9u/DYhFmR6oytSIbvTMZ2UtucpAG/2pb4iOmUn1SXYp2EHwkwz+mCDC5qQJ55TLW0Fa3alX/vwCWTna6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196858; c=relaxed/simple;
	bh=xQ7CqVM6Cv/wUPHS4u37ELPAUEgOdL1GoqD+eDoxsTw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CXBdP87ufEYcoRn2D0CmRBCmHW2B8St5J8ohNFvtIuDYa2AhP/bEMdN/glMBN8rM5Nwtozv5hmhBSZRCE0ZvlcOXw9mPhcekDP32ec7iTV93pO4V68t9A6L+yS0Mlu8aeVKtNmziGq00DJAHXZ4uXHMJDGAzK6JDuRpD+a1c6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=piQdKggZ; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-307d0405e07so144703eec.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781196856; x=1781801656; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6ceVOGme5lPB581G5XFGTQ1yGvtSh529zyR2h7e/S8=;
        b=piQdKggZb7scrSLHx6CVg3bcoXXRmB70LzOUxA7VJ/k9a8e50JQE3GQZZ0xyGuhOzx
         fPXbi7Jb2abCZA/r6sXrdb7UpO1XBE8qIE7pFVSLBadLs8VbXVqFzZRagAtabVIfjx8M
         kGVUBxcDnm+LF13lASl8u1q/ExUhlCGfCnDr9/KFpeR1jx5mgGM9Li2oxPPC3dOTz85s
         /xF/MThN2/pD9/uvo5N8N7Ri9LYX763+B5f408FYJR+mmMcKEXWQyM69zohd0/1d2Yyj
         4FsWWx6OVZ/+At3P4QdESrGL9I6Y96r0o2BNMs9OSZkU96+Ki8OoqMLSvFUVlqW0+6Wd
         9Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196856; x=1781801656;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6ceVOGme5lPB581G5XFGTQ1yGvtSh529zyR2h7e/S8=;
        b=EUxO9kEgB8HqxUS5FC5jEz3UXKWcEtPWJ9iQ5owX8PetXUe4T7zmA5bfZydn61YgGV
         LW+bygTT/KbpkkSS7TrzCldtqmSjQ3cwuY3NJpZDMGP+/34drwdWFUxFYk+uzi4/mhhk
         +7ZyxTc0DB37XD58cBK+wIqkoUWbB4logsnImVOgKpiP6BsQatc9Hk9WEaD2d0I8x2eQ
         ljy6PM53jiL+vUiyypJklPvC1qf5OA2xpZ9uF+UIXu7tsVZ++ZmCYgkyO7de+QIKYboR
         vMWmCwnEDlzyt0BW2rr73w4tuCTesMbTbhqlcWLLezTA7l9k9kioyHVc+86BXtGV/SIH
         VE2w==
X-Forwarded-Encrypted: i=1; AFNElJ9z68pxDi9oiwofs4Lpz2aQ29EvQJIlOwUex7u2tWUrwmSlluDQRNnO3g94Do3Of/lgE6ZqdIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6l/PpwzjuBtEcJo/lrGgu+rGAyGluPFWJU4Zddp4RfjKmT8+
	i5Whmt7t8Odn74ZWAF+X1Qs4O4M5d6prmywkvaP/s55TWq6w4taV/LqYDG0JX0x0rIY=
X-Gm-Gg: Acq92OF4rCE7siLl9Yt1DblPwZIIhcDU4P+w01YXkwHrDmEJXHZByIxuNwLGAhFQsu0
	IN5h5WYdvVbHaoQPV0aSHgwSe/VRpRsl+EZ1rDgqR+9OlSwPjP2tH7LR2YhpZADkPoRlnTNXuwS
	a8alHsKYCawBrYcn2SUo9ALTEQiMBlIboWzI/lf497ihIuw5DQa0DFkGGRBfX5oPV3QyWLYQfPR
	eYguK1xdYdVZBmKpAHxlq39Y/9jm9wj8+dOutaQtJ4PILXEnXLpQuxZe3wRarSxPdIDGNw0sekX
	q37rBY1Uo/ev0oA2ujhIMoANCFbHjPhlJtOFyYpIydMjVFT8RKrU48v3zWCfMaPZK9CcUpahAbd
	MYJ4KhyczBrJ2hEIUaylZiJ7PtIlDbVJwLJe10q9EkwK5HYv/Qh3kcFidIv8RdW5Yg17s/smkDs
	5gyyFw
X-Received: by 2002:a05:7301:688c:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-308049fbd21mr2915715eec.22.1781196856367;
        Thu, 11 Jun 2026 09:54:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9f35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c2f3absm2523710eec.5.2026.06.11.09.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 12:54:12 -0400
Message-Id: <DJ6DL5UQ8RM8.15SYAIW57HN7I@etsalapatis.com>
Cc: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Shuah Khan" <shuah@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Cong Wang"
 <cong.wang@bytedance.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 6/7] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-7-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-7-jiayuan.chen@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298241-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	DMARC_NA(0.00)[etsalapatis.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7946A673BD7

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Sechang Lim <rhkrqnwk98@gmail.com>
>
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/core/filter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e35e681a15dca..742aeeea13c26 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3048,8 +3048,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, =
u32, start,
>  	   u32, len, u64, flags)
>  {
>  	u32 i =3D 0, l =3D 0, space, offset =3D 0;
> -	u64 last =3D start + len;
> -	int pop;
> +	u64 last =3D (u64)start + len;
> +	u32 pop;
> =20
>  	if (unlikely(flags))
>  		return -EINVAL;


