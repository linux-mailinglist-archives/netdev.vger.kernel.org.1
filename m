Return-Path: <netdev+bounces-303865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f1azFEGPRWqQCAsAu9opvQ
	(envelope-from <netdev+bounces-303865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:05:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A81706F203D
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:05:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=qTzrZfzH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303865-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303865-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B79C31494EF
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8613C10B9;
	Wed,  1 Jul 2026 22:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D66431E4E
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:02:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943354; cv=none; b=KrrvGrOXsDg3AG8DW2bBSk3/Gxx6bkfGFnki7eW1pQm/16ai2ue/MfHQVHMAseIr3jeLmOMnzhfJPLuNVMYci9WliPSQIubltXyIt5tlVqFee003EFP4rGxqOG6urscOh+rvkFFHh6BHWLms4qY6vEM5ePilZyZcmvHHLjYFEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943354; c=relaxed/simple;
	bh=eVypLHVgpYs6tf8E01MUjLp5Ab/fWW4yiCILeVsBp1U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=uM3ya8VzlahV6nJ9hw5CZzMuJjiCWx2ytCZAm2Brmt3actQph2PDVchPi+sh3itRk09Iiv2YUBo+Z2eakq0UkYCOqhHAeq6LsQ1cUDgeXTtiJK480D3Uz60tyC2Q2xveB2iFkamTpS4W5Hnhh0TgA1WH23W1CCdxALEHeNtKE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qTzrZfzH; arc=none smtp.client-ip=209.85.222.177
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e4fd65b2bso62520585a.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782943352; x=1783548152; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLVtzWFR2dQSLkUs2HwYG25dqTS2FGwULXJdwvU+iBE=;
        b=qTzrZfzHbaUJEWLCbu/VcXgWvZONswmngMnxBrt2qS/5ZcPbLb3JmW0K/35U2V0P8l
         N8MI2n/fxVrSvevTD743mxXzeoNOj15iOHQYKrm+XnzVMN5tKQC2VPWiOTxHFzhVKdiN
         rSg2UcD996fuKUzSuKkl/fqw5wSeu/InHrvPUei3F4YAcwOZRM4wCaNSb7eAAjukpzAr
         KLLGBudhzj+MnJEEzS9TiVu4dPZE6yYYIFgDmxs2tznBHOHpDpjm5cYjRmDdk6j/nys4
         3/XA0qvld6PK7DkEhyIwYBahij8c4/byMOUf/PS/GMl1yjH/175U4mIAHfzoxsceCOga
         0XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943352; x=1783548152;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLVtzWFR2dQSLkUs2HwYG25dqTS2FGwULXJdwvU+iBE=;
        b=sJ01O/hnWoB+1NI5ei57EDwTbMr0Vg8E4L5aLS+dUVRi5QJU8vpf0DMPfnb6qQ/0ic
         h5IreXwrqxp473TFy3jQuOYvbzmximfmQcHx7oXHbCCguRJmDz15vvWt/P6X3PaelSGm
         giyIAG3ODtNyEpn9K6G3q/ST8urawZIqJN/oR0PG8XsqfCSWIeLxdAm/UfeRHKfWPUDz
         oEZeCEy2aVjXsVrgKzDRKwTvuRHrejwfcHfPzHJwry2hUcJRWVZo8pEEW/Dm1kBhb28H
         ITy/pWmPFpbAo5ykUj5jUw1FAlggJE5H9BZYgY5mb7bmzUNLGYbQlLMjyVMg8G2nV1t6
         36OA==
X-Forwarded-Encrypted: i=1; AFNElJ8BS+NasHgNjOK/gdUF9A+gxvPNaZrXwfDgdvaBEHAVieXPyrLfFAn9C49vss3CuUJbiGXTntQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdjTS+TRww1KmQaiTNmHrAsby5az12I1XMOwYUT+vQTTDgJtDG
	gxG0/fzCvR5gl1SyfdC0lmjN8OkAm815Nfty49crE2QOzcTFpSlol8C6maiBkz6kQfI=
X-Gm-Gg: AfdE7clQZ3Kv3d0SH4hyT5vJaTMkz2fxizRCNkdMGdTw7Talo8N3eV7sB7HRlEOJ+VU
	URfc71T7Wq+y7T94vhPsEZa44lLsVW9YXqGVOpj7l2jrssYEg+35tnF0Nhb/Ls71zog8cW7tBQ4
	v6VhTCpxsjf3q7op4daWdscxbH1UvVIFP6IbAVDGrBHGngq2nk3+2zPE+kBWeE0KuBfTZkcwgox
	yq3EpuNvQjVUvloRMldKwJuv7gDMiYWDn4YxGCxrDs4OjbR3X8BCnbNX7QrwjaS+Gjkm3C4SU7D
	aMvLsIArQ2eCSnTwCej+ZCJuWzTpLXsXRT3hUn2bbLUc2R/gEsChCx1Nwy+RsRCOb0X/XjyFfHX
	ihYZHxL6ueo8HIrGlVYWhIEilUQVr2MfsIvvSOJnx0IE4pNyGZkzPp6vSkdePQN5iZHxKbw7PrK
	YIURYU+1u/q2w=
X-Received: by 2002:a05:620a:4489:b0:92e:5fe2:fd35 with SMTP id af79cd13be357-92e7b368d85mr406755685a.32.1782943351824;
        Wed, 01 Jul 2026 15:02:31 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80162220sm58215185a.25.2026.07.01.15.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 15:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 18:02:29 -0400
Message-Id: <DJNKO3H4C8CK.YM204DS9PVSN@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Varun R
 Mallya" <varunrmallya@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf, sockmap: disallow update and
 delete from tc, xdp, socket_filter and flow_dissector
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-2-rhkrqnwk98@gmail.com>
In-Reply-To: <20260630145410.3648099-2-rhkrqnwk98@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303865-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:shuah@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:varunrmallya@gmail.com,m:ihor.solodrai@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[etsalapatis.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,etsalapatis.com,fomichev.me,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A81706F203D

On Tue Jun 30, 2026 at 10:54 AM EDT, Sechang Lim wrote:
> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
> sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
> write. That gives the order stab->lock -> sk_callback_lock.
>
> The reverse order comes from the SK_SKB stream parser.
> sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
> verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
> __tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
> deletes from the sockmap and takes stab->lock:
>
>   WARNING: possible circular locking dependency detected
>   ------------------------------------------------------
>   syz.9.8824 is trying to acquire lock:
>   (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:42=
1
>   but task is already holding lock:
>   (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skms=
g.c:1173
>
>   -> #1 (clock-AF_INET){++.-}-{3:3}:
>          _raw_write_lock_bh
>          sock_map_del_link net/core/sock_map.c:167
>          sock_map_unref net/core/sock_map.c:184
>          sock_map_update_common net/core/sock_map.c:509
>          sock_map_update_elem_sys net/core/sock_map.c:588
>          map_update_elem kernel/bpf/syscall.c:1805
>
>   -> #0 (&stab->lock){+.-.}-{3:3}:
>          _raw_spin_lock_bh
>          __sock_map_delete net/core/sock_map.c:421
>          sock_map_delete_elem net/core/sock_map.c:452
>          bpf_prog_06044d24140080b6
>          tcx_run net/core/dev.c:4451
>          sch_handle_egress net/core/dev.c:4541
>          __dev_queue_xmit net/core/dev.c:4808
>          ...
>          tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>          strp_data_ready net/strparser/strparser.c:402
>          sk_psock_strp_data_ready net/core/skmsg.c:1174
>          tcp_data_queue net/ipv4/tcp_input.c:5661
>
>   Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>     rlock(clock-AF_INET);
>                                  lock(&stab->lock);
>                                  lock(clock-AF_INET);
>     lock(&stab->lock);
>
>    *** DEADLOCK ***
>
> A tc, xdp, socket_filter or flow_dissector program has no reason to
> update or delete a sockmap, and redirect does not go through here. Drop
> them from may_update_sockmap() so the verifier rejects it. It also
> closes the matching sockhash inversion.
>
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/verifier.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271cd0..83ea3b33ff67 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8488,12 +8488,7 @@ static bool may_update_sockmap(struct bpf_verifier=
_env *env, int func_id)
>  		if (func_id =3D=3D BPF_FUNC_map_delete_elem)
>  			return true;
>  		break;
> -	case BPF_PROG_TYPE_SOCKET_FILTER:
> -	case BPF_PROG_TYPE_SCHED_CLS:
> -	case BPF_PROG_TYPE_SCHED_ACT:
> -	case BPF_PROG_TYPE_XDP:
>  	case BPF_PROG_TYPE_SK_REUSEPORT:
> -	case BPF_PROG_TYPE_FLOW_DISSECTOR:
>  	case BPF_PROG_TYPE_SK_LOOKUP:
>  		return true;
>  	default:


