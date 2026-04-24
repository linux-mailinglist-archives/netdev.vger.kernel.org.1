Return-Path: <netdev+bounces-280995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCjoHeR262kQNAAAu9opvQ
	(envelope-from <netdev+bounces-280995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:57:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EE45FE2B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C19D7300FEF8
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349593D9DB9;
	Fri, 24 Apr 2026 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW5umCQo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2F3BA232
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039032; cv=none; b=Ln3bAYGh3dWzqfek/gWBfzH/ZAqHPPkp+WT4p4jdlhLBWOGM7020r/3Kt6LHcVxLqZyrQf7EVDc4goPoADoAszOR9aVBtXDb+Fa5dUhQQEarvJd5AX2uLbHp3RmaAugVqW2tTKwGlR5ZNDNUmVzdE3aYJUySPeiUCktpU2h/L4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039032; c=relaxed/simple;
	bh=YkV/gmu/iRF0QtidaJru1TGFWT+3DjghSB2koHn0JDo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=InvixpZhpxDg+lfOL4fcDjbYKfVvzX4Ni3i32hZu8WavDK4VPlgxyMNlJF7/276EsMqGpxJfEtSEuo1t7huedn4dJnb4uZoJV1dvQB5VVQPDddyOkHy/WdOWE229uNwFX06xE2b3rKJnCHSgY2yLiiV3yWO3L/Ty1kT4slaColY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW5umCQo; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dcdca9dd6cso3802591a34.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039028; x=1777643828; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4lmyNqo07GvwFuIjU1VCEb9Ql2ZQ/Si0G3lWH77Zr8=;
        b=IW5umCQoqLETi2iYdYdIhV8l5n/rEvRFo6Ou1Dw/d9co91mDhom5bx5teNAErLcps3
         AfMBtNjrjws9oBcVBXd/+IH//OYGLe63sBQUbc3zZIsA3TB4CV+IXj0jHhD+Lf213TLt
         RsVMDNE7+EVdvPd16ewRxrjVr6wEg9lXNkTGVOMClnHk+11Fq73BaWpzQAlIfJd0w9UE
         YqYHGbUwqXXKz2h4ipD8huBUF6XDX2AYCMcki6d8j9hPMTMQcS1Jdp26yIxgvdlIw60r
         ARQaqKTLZFxsyBFWxYPH41ah9qoj1fCXzZ5EhR0SezofxQR4gE1SuzAZbAh5jaYZkL+Q
         pGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039028; x=1777643828;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4lmyNqo07GvwFuIjU1VCEb9Ql2ZQ/Si0G3lWH77Zr8=;
        b=KRgYN5XS5e/YkVgW7eaaXrNIITySeqgr6kZAh8a0Z441DRO6OEdp/8hzAnjWDPTt4e
         8RmdXD/VASDF6Vyfo7n2KypZH1hkCEEQv3EgKgfE5xKB1JduFAbg/+DVrSg+RZrv1hAE
         r1pi50QTdOk/+/maezXLfwskH5JmjFNAcMdSbtEdZCuzG3ZYxVUkO8uIN2zX4de83ice
         qJajUtG50W/OGWPBKkxzBTX6HwLzyPcRkYYoTBIXlv/mhQl0cukGrD6vY23uVZMlnft0
         TgmAMpSfpxhF+JlRXEoJjOsbCjViEv89I/GA29qymq2nMwSBdI68UmrRaxjTOygqK2BB
         ssAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ujOoJi2LcMnjoTBIZzly2DL8S2C8KmL1tkheX16WmWR/IIHWuJDduZUvm1wiNm/B6trsPCZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFX+YKguGdXDa3p6xmBktz+ylK0sk8/orHJi9ytTQuqVVVauF
	jEqPfY30i8Cayiy3tWgkGCKmYtrO9gmAeDPZh5rCWr0vQDcNCU7Du/Fn
X-Gm-Gg: AeBDietPYxl23OyBDHn6C+YIWx1viHevSj/m57IUaWkb/cM++Jgm9TXLqHYSgTyEYk3
	moL3uqFfkzD7zFbZzuGR9r3gwKsvcf6FgC3skiX2zXM9omoGS4gfYcNwV9OCPgazPEukFQ+N6hC
	qzz1N9jou1XKkR1Q3iUQa6tKK3hfxxwJeVvlSzyLLTxRSE9nzp6Q6xKInWFooIL6K5Xnob0tpi8
	pl28vSUqx0TSGlrr75c1gdGgv1Yhj5owwz97Q283w2AfDTeAQqXkVBHerOeEdQdTRGtmXK0IGnf
	YWu6AmAJecv3sdtwY0aWTqrfMvt2UnPSw1ZlqL9MVX41009ejlZTAM90BaoUHRQS/3qyCecF6vR
	790F6tohfIeCWrd4Ohi51aZFSajoffWTSYETjhr3BjoinXSpAax61gIQ73NfS0TVm7xeTZ1D8vm
	zG8M43xLUTPDflmjZfh3x/V4hEyycECG72IlJiwaabBs6N7UzEtRU2wAv6kJisyngxZJ8RSjYhZ
	vf7bkpKO0Cp+3Vwhez5BoPMwfz9
X-Received: by 2002:a05:6830:439f:b0:7dc:da80:42be with SMTP id 46e09a7af769-7dcda80470bmr11350922a34.21.1777039028015;
        Fri, 24 Apr 2026 06:57:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9759bfa3sm19510471a34.13.2026.04.24.06.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 06:57:05 -0700
Message-Id: <DI1FREJRMGWT.M8JZJADKO6WJ@gmail.com>
Cc: "Yinhao Hu" <dddddd@hust.edu.cn>, "Kaiyan Mei" <M202472210@hust.edu.cn>,
 "Dongliang Mu" <dzm91@hust.edu.cn>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemb@google.com>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Hangbin Liu" <liuhangbin@gmail.com>, "Krishna Kumar" <krikku@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/3] bpf, tcx: reject offloaded programs on
 attach
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260424104201.217604-1-jiayuan.chen@linux.dev>
 <20260424104201.217604-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260424104201.217604-2-jiayuan.chen@linux.dev>
X-Rspamd-Queue-Id: CC4EE45FE2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280995-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[hust.edu.cn,iogearbox.net,blackwall.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,hust.edu.cn:email]

On Fri Apr 24, 2026 at 3:41 AM PDT, Jiayuan Chen wrote:
> An offloaded prog's bpf_func is replaced by bpf_prog_warn_on_exec(),
> since it's supposed to run on the NIC, not the host. But tcx doesn't
> check this and happily attaches it to the software path, so the first
> packet hits the WARN.
>
> XDP already guards this in dev_xdp_attach(); tcx just never got the
> same check. Add it to tcx_prog_attach(), tcx_link_attach() and also
> tcx_link_update() so the fix cannot be bypassed by loading a normal
> program and then swapping it out via BPF_LINK_UPDATE.
>
> Use bpf_prog_is_offloaded() rather than bpf_prog_is_dev_bound() +
> bpf_offload_dev_match() (as XDP does): bpf_prog_dev_bound_init()
> already rejects BPF_F_XDP_DEV_BOUND_ONLY for BPF_PROG_TYPE_SCHED_CLS,
> so a dev-bound SCHED_CLS program is always offloaded. The simpler
> check is sufficient and also rejects attaching a program offloaded to
> device A onto device B.
>
> Fixes: e420bed025071 ("bpf: Add fd-based tcx multi-prog infra with link s=
upport")
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@=
hust.edu.cn/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/bpf/tcx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> index 02db0113b8e7c..1144627483d53 100644
> --- a/kernel/bpf/tcx.c
> +++ b/kernel/bpf/tcx.c
> @@ -16,6 +16,9 @@ int tcx_prog_attach(const union bpf_attr *attr, struct =
bpf_prog *prog)
>  	struct net_device *dev;
>  	int ret;
> =20
> +	if (bpf_prog_is_offloaded(prog->aux))
> +		return -EINVAL;
> +

instead of sprinkling the check everywhere do it at the source of the bug.

pw-bot: cr

