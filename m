Return-Path: <netdev+bounces-297624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jpv3Le1CKWq2TAMAu9opvQ
	(envelope-from <netdev+bounces-297624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:56:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 549616687B3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:56:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CDDndo9D;
	dkim=pass header.d=redhat.com header.s=google header.b=icr2JjsO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297624-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297624-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EB7C303269D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3A3EB0EC;
	Wed, 10 Jun 2026 10:52:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D93DB313
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:52:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088749; cv=none; b=A8nGIlglu3MJuT7yDXlZ75mcFgitHW9WH+HdMPOeyCTBoJJMQkegtEw8XEOTieq6rgh3Zz2NOPEtdp/WgyvujnYTvvyyram9dlPo75VuwBO5vH0Ka94mLa0m0KdV3iKNiO7/F6BWCEwO4D1LJIYuyXAusCnxearK6mFg4rEOROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088749; c=relaxed/simple;
	bh=c0evrJyy3gc7h3HbpxRgdXmZfk6aV6d3JmOCU+uSWj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpqrLUZZJGZdE/ggPp5cASjYu5h6XJFUsVLVULmsVAzXZ1V4v4FHOiFbF7g+NGdD22XGRS7onxq1/1sYW9/O6BCXDTrqpAx1A+HcGck2j91xyCNsDwE2pbq+zedjSnawdBAyJ+IMgLvZCyNRb84d3buVT2KyN0lmtDwfY+5rA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDDndo9D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=icr2JjsO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781088745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDfYzHZ/iAtjAqdLJHyxkbGm1bEccQWrFTq9p8hRVjQ=;
	b=CDDndo9DAMhPpktaGpxCfGN5piozxFWzvHrGohofODaeflV481FzvkAaqMz9UECrVuKVqn
	K6Lr8M0h3vuG9zZNJGW6F2gzs42Tah2SrhsNe7ch/tEoGxbq+bx5UUvvmZXMT66qetida1
	ps5isAkpokXqxRMOUOLJAoY3NxJKXAI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-aNxRMrnVP8SFTyIVr5BPOQ-1; Wed, 10 Jun 2026 06:52:24 -0400
X-MC-Unique: aNxRMrnVP8SFTyIVr5BPOQ-1
X-Mimecast-MFC-AGG-ID: aNxRMrnVP8SFTyIVr5BPOQ_1781088744
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4600c8cb13aso4059677f8f.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781088743; x=1781693543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDfYzHZ/iAtjAqdLJHyxkbGm1bEccQWrFTq9p8hRVjQ=;
        b=icr2JjsOXN8Zhl8A174DmyMp9E29Sw2cszww5tHSx7JCLdErn5sPSY/rE7t9JV7fnG
         V8Ad4ILdgz7U4DCSOUZRF62BUIit0IZPppt1QuKMrM4qVBPJ+1TVk/mspd+hTyC730ni
         sWrFJMDYe+VW+/H3Th3nmTomoNa+alI2dKe1fsdDDqWLg+y7psHoyewDFCotZmgMFc+a
         fwr1MB04CiLI1lg+9sF2px9PS8btulZa8Or16v6ds6Pc4gz8uX/zJqd1MhsQjya+UBKi
         YB2B7r/oP6Gk4WI4sDxoJrtNf92ThIwwPp25Wdt0VtfGSS7BfNFWaGx9UEBrC6X/NDKI
         2VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088743; x=1781693543;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TDfYzHZ/iAtjAqdLJHyxkbGm1bEccQWrFTq9p8hRVjQ=;
        b=mcO+DgP6eGFf9IeDMRawelxqVVO5FFYEgawZfyNXZg4iMG3/RpgFHxnunN7SCkJETY
         uYY+9dU4RyJOZ5tQ5UiywIW0cuD6LFbu4iRch1fcK2u36bSbd0i9PHkD8WcmRVKGoPMM
         J/CiBFiAxmIDTccJRtlb1W4l0WJZVkqocKDxiHizh0r3t5wPQzpbJmMOvql2REHubGp4
         57OXe/OIrsSaUOJDgrBGGFrWbYIMHycAp7PGSFDVj5OiLZp8kVnyJ1JdkH+FOj7tQSSg
         tsi5+lsbf/BdhqoNtydJUsI9+ODddtFXH6enveSoHeAQXliW1J40FO6E/T/PWVZHKsgX
         1mOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x3Eafsl6DuRtGGArU93cqL9f31AKpmzT+jnxO1KRs9oq7+OQqfcOnDT3zUzktxkjTHOr/1uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpk8LUAGvP6PZ/0LxwagTKoPdeB1BNRXhEW/CaRHIfIpcNlap
	AouSRPPcWmxIWqhnw08NkcvQxDlsG4uBfjiUNf9tRNM8ljEqBArlnhUWe5ofPY6cLAzYHnnOaWP
	O2vFKB1ocGYwqTlrB606cd/Dm2XA0l9vEla/5Xvd5X4Wef6gvE6JycavaNg==
X-Gm-Gg: Acq92OFZlGKft84M9YLoij26f2mtiD+LE1rN1OJOFc9IPNO5suR7pp5PwcyVSCo3zan
	zKmkcRVFL7PsoCxUd2uuXc1b88j9pIBgl38J1fHH8wCe/sO2DXLX7bnKFImYt4m3DBOjAEM5abb
	mT0wCOIB7ZtPQuAnH2bMK+hRisw0BggWhxVObvzrYUn3boXciuBlJ5xqC7GJvy0ES2ZHY1maeKP
	2a970UBf52UqVWetLxSRCppR+JNdPHg6neGipBpxuoy0nzQPJOYQZZBNScTO/yFT7ln/3nezEe0
	SPA6ftpRV9wnk4NSBZz46wOul69a3bRuixpyxNQxa0pHzfCdQHjdU05tCPYKUl25JslL3pD+mfj
	aeegCOgUzwSlSmXS2ipRKewvAm1G9dSVkyGkVfpXYQZVWaqfeJIo9IOIDhhw=
X-Received: by 2002:adf:ef88:0:b0:460:1e9d:31a5 with SMTP id ffacd0b85a97d-46030631ba3mr27398908f8f.35.1781088743523;
        Wed, 10 Jun 2026 03:52:23 -0700 (PDT)
X-Received: by 2002:adf:ef88:0:b0:460:1e9d:31a5 with SMTP id ffacd0b85a97d-46030631ba3mr27398861f8f.35.1781088743089;
        Wed, 10 Jun 2026 03:52:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm67667793f8f.18.2026.06.10.03.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:52:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 51F137BC7E2; Wed, 10 Jun 2026 12:52:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: Menglong Dong <menglong.dong@linux.dev>, Emil Tsalapatis
 <emil@etsalapatis.com>, Sun Jian <sun.jian.kdev@gmail.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: Run generic devmap egress prog on private skb
In-Reply-To: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
References: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 10 Jun 2026 12:52:21 +0200
Message-ID: <871peeacre.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297624-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,etsalapatis.com,gmail.com,kernel.org,iogearbox.net,davemloft.net,fomichev.me,vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,toke.dk:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 549616687B3

Sun Jian <sun.jian.kdev@gmail.com> writes:

> Generic XDP devmap multi redirect uses skb_clone() for the
> intermediate destinations and sends the last destination with the
> original skb. This can leave multiple destinations sharing the same
> packet data.
>
> This becomes visible when a devmap egress program mutates packet data.
> One destination can observe changes made for another destination. The
> last-destination path has the same problem: the last destination runs on
> the original skb, so its egress program can modify packet data still
> shared with earlier cloned skbs.
>
> Native XDP broadcast redirect does not have this issue because
> xdpf_clone() copies the frame data for each destination. Generic XDP
> should provide the same per-destination isolation before running a
> devmap egress program.
>
> Fix this by making cloned skbs private in dev_map_generic_redirect()
> before running the devmap egress program. Use skb_copy() instead of
> skb_unshare() so that allocation failure does not consume the skb and
> the existing caller error paths keep their ownership semantics.
>
> Add a selftest that covers the last-destination case where earlier
> destinations do not have a devmap egress program, while the final
> destination does.
>
> Tested with:
>   ./test_progs -t xdp_veth_egress
>   ./test_progs -t xdp_veth
>   ./test_progs -t xdp
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

With a few nits (see below):

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

> ---
> v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=3DNWi+N-0sJZWvMwY=3Df4iF6=
-3TVMS8=3Dm07Zmw@mail.gmail.com/
>
> Changes in v2:
> - Move the private-copy step into dev_map_generic_redirect() so the
>   last-destination path is covered as well.
> - Use skb_copy() instead of skb_unshare() to keep caller ownership
>   unchanged on allocation failure.
> - Add a generic XDP last-destination selftest case.
>
>  kernel/bpf/devmap.c                           |  10 ++
>  .../selftests/bpf/prog_tests/test_xdp_veth.c  | 151 +++++++++++++++++-
>  2 files changed, 158 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..59f267685bc6 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -700,12 +700,22 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, s=
truct net_device *dev_rx,
>  int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff=
 *skb,
>  			     const struct bpf_prog *xdp_prog)
>  {
> +	struct sk_buff *nskb;

nit: this definition could go inside the if statement block below, to
make it obvious that nskb is not used outside that branch.

>  	int err;
>=20=20
>  	err =3D xdp_ok_fwd_dev(dst->dev, skb->len);
>  	if (unlikely(err))
>  		return err;
>=20=20
> +	if (dst->xdp_prog && skb_cloned(skb)) {
> +		nskb =3D skb_copy(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		consume_skb(skb);
> +		skb =3D nskb;
> +	}
> +
>  	/* Redirect has already succeeded semantically at this point, so we just
>  	 * return 0 even if packet is dropped. Helper below takes care of
>  	 * freeing skb.
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/too=
ls/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> index 3e98a1665936..1f0b9ade12fe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c

It's customary to split changes to the selftests into their own commits.

-Toke


