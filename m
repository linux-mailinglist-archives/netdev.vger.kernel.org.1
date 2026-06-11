Return-Path: <netdev+bounces-298224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Re2iHtnnKmqrzAMAu9opvQ
	(envelope-from <netdev+bounces-298224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:52:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E51673BA7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:52:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=gO86XJ5l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298224-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298224-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9F0364E2C4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36394BCAB5;
	Thu, 11 Jun 2026 16:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3F4BC00F
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:28:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195337; cv=none; b=UfShPDj5hdWhnd3Bj+tmAJBxf3bbWUj14kO6g/TXROhYOTdh/wzUp3IRFANSVzfU6YqPZ1rVZY/mBC2eyLJVMUaL7ZyB5euQ0I9wcUcfnnTnsa+Y41wYDvK8TVOSFPzgCvD+gpJWzWOhcsWrQpG2RrFET5jXV7hpeUIl/g1k9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195337; c=relaxed/simple;
	bh=Dq8U4JeMLdDJZCai9rkKpCchuv1uUA+lqZN3PGfqBIk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QfUi92R/TYvHp/qccIUQjvnzQCJpHU1MFy88Ky1n9GjmuN5gMkgQUyPb3ldAulwe1SEw4bKVx7p2m06XzPG2gGTjWEnj6HkD6TcUl+16/OkgNRNMa/qsC/EvGer81QP3wpWSXCK5iQ5OaC/6ZXPGqDGkObMFiSQExEneMxikq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gO86XJ5l; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30759632453so110673eec.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781195336; x=1781800136; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmILQTIhg4C2xaf23uaTPKYf63Qsqb45amOoW42QXJM=;
        b=gO86XJ5lX2WhRMfkazLeKXLf7wv1CkXPx9mPNdIgUvnRG0+aMS1WTVPTkSFyz2/uju
         f+dl+CDOeVOGYozPh+AO0+g+AgA2I7Wj8aG25z9PsB5fyPphzH2PzL8g7p25qK12h4XW
         RE1fBgpAck3lEoD+tHqqnHXIFLFe91oecgiTgsV3/5L8YMOhIhmK+3xqnQ5wyeTr6DNp
         NveThIDMWV2oQieMoMTS/P4+oOR4X/CFU0JecME9HoQLWnVGGNzexXvEn+NmYX+57mMD
         8/SRfSGfQ2vSlSUKCnOoHLyi5Jb8wCP3EWlntz/vDnyKTNzvb+FWamw5uieCRTuHLSlo
         G9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195336; x=1781800136;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmILQTIhg4C2xaf23uaTPKYf63Qsqb45amOoW42QXJM=;
        b=oR2ipy+PNnsdX0qla+vkZhuPO97224/BZD047fi5sShNFC+ivj50RsebbnVB8t3alW
         QUKm93XMaVz1nXlcPX3oZpUNPC7ihk+YT8d+o1IfxLk6LeJ7dMiPsuuT6HlE89NQXspL
         kL4uVbJwbXnEvZnza8iE4sJTGHzhmOeKnmQ4Tv++j/7faIY2d1l6lG53ewU/3ON/CavT
         nufi0qEdW2rC6j2Dh86JFUMqKSlW93qM6j+Rkeo6nyCcXJw4A4rqaroq9GE376yVc2xP
         CFrSYx4aox6wm6+7xnG5DDlELTu/q1rm2ePylndiu7RZwuLfCushpxO0cL0sL+coSoCc
         3ycg==
X-Forwarded-Encrypted: i=1; AFNElJ/X5j9MeUaZjPpmsirvmKvl8Y82LtcdvUAQjARWkhvF3ZTWkssBgCq70MehHiqoh4TqPXPaNEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyscwOvm4AXQHnyCJIp3+GHP06umiInagCAlmFpvVJLtJ9skQpG
	DSnKO5BBOsGhOqlki4SMKwmcuNKYEpGBPxsPFHRTq6p8hguUbYhid2/D2g3locD1lbM=
X-Gm-Gg: Acq92OFYpYe2EiiV0p+z4sFK+yrGobhMM7GoURLkPC65DFrKK3m3gOrk5b/qT7OXUFN
	UeWBBuCl2I2UK5jYfcfk0z2NDa9OKfaH6pE9SfmJllCufH1YEkvLlhTlMSF5cajZYYkLgUadLZz
	/1ZRv+4GksvhC7HERBW1lZ+IofdTd0iDzo/uWZEh4/qhZXF6h8XyEidVCRuJuLZwE4m6b80RO1Q
	dHdNDZNGRL3HjOL71c6sJnUzxsCe/TcKCg9wZYgVSe33/4RrC911rnfdtmE1QB85QKXZagFxI5I
	6d1SSqws0tHIHIHAJcDZJ/DsR7GIg3wndw29MBKE9tapZ8P38aowM3BvqQN2exD57eiG2FHBfjC
	N2mj49YMJbIwgmkMJKOfX+6l7+9cGWP0XO+KtwkcMDheZxHGf0MxOKRujYVfM2jhS51zt7dZE5R
	DBn2qUUX0cs0Ce14U=
X-Received: by 2002:a05:7301:1292:b0:2fc:9ae6:e5a8 with SMTP id 5a478bee46e88-308049eb931mr2752590eec.20.1781195335328;
        Thu, 11 Jun 2026 09:28:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9f35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c47afbsm3701418eec.10.2026.06.11.09.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 12:28:51 -0400
Message-Id: <DJ6D1R10KDES.B0BC2FOSLNCH@etsalapatis.com>
Cc: "Weiming Shi" <bestswngs@gmail.com>, "Xiang Mei" <xmei5@asu.edu>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Shuah Khan" <shuah@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "Sechang Lim" <rhkrqnwk98@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Cong Wang" <cong.wang@bytedance.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v2 2/7] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-3-jiayuan.chen@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-298224-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:xmei5@asu.edu,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:rhkrqnwk98@gmail.com,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	DMARC_NA(0.00)[etsalapatis.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,asu.edu,iogearbox.net,fomichev.me,linux.dev,kernel.org,etsalapatis.com,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email,vger.kernel.org:from_smtp,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime,linux.dev:email,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3E51673BA7

On Thu Jun 11, 2026 at 8:34 AM EDT, Jiayuan Chen wrote:
> From: Weiming Shi <bestswngs@gmail.com>
>
> When bpf_msg_push_data() splits a scatterlist element into head and
> tail, the tail's page offset is advanced by `start` (absolute message
> byte offset) instead of `start - offset` (byte position within the
> element). This makes rsge.offset overshoot by `offset` bytes, pointing
> to the wrong location within the page or beyond its boundary. Consumers
> of the corrupted entry either silently read wrong data or trigger an
> out-of-bounds access.
>
>  BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:=
2728)
>  Read of size 32752 at addr ffff8881042f0010 by task poc/130
>  Call Trace:
>   __asan_memcpy (mm/kasan/shadow.c:105)
>   bpf_msg_pull_data (net/core/filter.c:2728)
>   bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
>   sk_psock_msg_verdict (net/core/skmsg.c:934)
>   tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
>   sock_sendmsg_nosec (net/socket.c:727)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Reported-by: Xiang Mei <xmei5@asu.edu>
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
>  net/core/filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3c8f1cedb217f..3e555f276ba80 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2872,7 +2872,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
> =20
>  		psge->length =3D start - offset;
>  		rsge.length -=3D psge->length;
> -		rsge.offset +=3D start;
> +		rsge.offset +=3D start - offset;
> =20
>  		sk_msg_iter_var_next(i);
>  		sg_unmark_end(psge);


