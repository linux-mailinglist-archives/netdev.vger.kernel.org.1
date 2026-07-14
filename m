Return-Path: <netdev+bounces-307364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ikUDgTWVWqXuAAAu9opvQ
	(envelope-from <netdev+bounces-307364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:24:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9168A751757
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:24:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=M7z8CGqy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307364-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307364-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 228C3303CD30
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8453D5222;
	Tue, 14 Jul 2026 06:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311F281525
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:23:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010214; cv=none; b=Met8rp7WyUc5ytNpST9+4gIWU9vKLU0/n51iJJizQgJY0NwSeJ1YbQcD+epN5m/bmE1n8CZI8xqt7Y9/IBp5RSFZwUmV635Aa+zYCpjtiIOg3DL6xnoh4fgovrEBiErGq37XLMBEt5NXAkJskYY+HyBSlqaviUulYmBsjj2cddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010214; c=relaxed/simple;
	bh=mrLR48Akm9GQ2K04C7ZMgBaqTqlOBP8oQOM8nbOCalE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UZ/8IDp90SDSjgaIDgjWJyPW+gIIS9mxqE0TnbnsLDgZNGQDoysyeA0lnluscF1qVQqcQw38rDTN+1K1jypn9i5PCcphVJCuer2mW/6FufJmKc26ZlMkFNIscKSj/ABkG8dHSwxyR3d1pvDsP1jXLhyPRJnhaCCevApy98xPSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=M7z8CGqy; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84867f07d63so4371020b3a.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784010213; x=1784615013; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w4wsNoFBM5WdmRxP3Hm6ojL5xYGbiFYjA567+qOElRI=;
        b=M7z8CGqyc9WAJzkAQ4rQajfi/AheoIgOU2BGTgaxzRgra1R7xAUpus7T/c+KwnPEhk
         Mru+b4Sb8C33cspJ7E+UV1mzYj4VxY9/YLdRnhHw2mSw3YYf5qUV4gJd0KvdBGYoI0Lq
         YrriGplFLUCNUnnlhOdEl0scqklRNKM/Wffx5t/DkRy7B54nLlu30BS/fGQnQKD9uLA/
         P82EBFwm9RdK1+JH0dREcBRYPrElEoqRnirLgmo5wuOwOuHAeWxoh9c3RX9mPpS28S4d
         zPPyA7BCA+qwhqCilvEgqMwZYD13t9uC6g+lRlBHK5YlIFY+PFOYX3pIUNot0UY644uj
         Zx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010213; x=1784615013;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4wsNoFBM5WdmRxP3Hm6ojL5xYGbiFYjA567+qOElRI=;
        b=TQx3fkWa9MH2Eb5LgZVjKrBrXEjgp4ugUoznmlyjUZGx9GVpRDoNWS/VQxSm5q0na+
         6d1jfcum3wFMs/m9jpd2gnYmYq58/7EPmbL+i+4ZB01xwYWMA1NXRDalByGDERVKUrjm
         Lks1AR0REx8qzu7uZy3TYImyrNpkvxmFsXBJz9B6ibka7l/0iE1dLFpgGyXV82pTTRiC
         Z+ZIkwUP5PLNdipxNSwsL+5ZxW2qDtGF7NG1TQ07x6L9+JkBibPStadTe/A9GPIVHVUd
         maOsdObWLc7iraahGTIkIbXq3j2/IUESX9GGepclAXZYF0ggCg/BBiNEcyOxY5lsQFMC
         1qtA==
X-Gm-Message-State: AOJu0YxwuNhK/8FmaEpVF7fe7o//JgEEW0w80uyZEbBz+PylS0T5Y5mB
	ZZd/NsDCxaGpXLJ/HDnTyayGKSTegfXJJYaSlsNE3VA0VeHa/6UNFHht0PrRx+3n/nw=
X-Gm-Gg: AfdE7ckvzSepGYpck8hDuhCfJ6YLAfRm6r21KVeoOgY1R5madLhjSVpdZy3xbMjZNgF
	cUCEdoaMqATm8i0yJPPzQWRO4Nq6QarfBvNpDe4Lcqaof4sXLvHW5q0Zja4RrIF0EXzNnHmq1AC
	8tUypWcwvG4/5qwjI3M74kNgalST614SpQ3Owf/Skm5Yq9swM33VvpGM+DpO6V1AsBy2hDKs55C
	YCeSswjgu4wEfvYAEaibaXFsXZy0lexddN/jegXEt+BSysKlciA5xYdHe14jm6J4xLR7xik2C2Y
	hhLvsqwHSol7m/l3gljjn/Cn+/mf+1PxGlD5PXmT/RDbagFMuxdep5FmWt7+JyPjRSDfbhuUFKh
	P6VvMfQu5Y4F5Hn0ZQ9TBir1yyiFw6KzKrSbb1biswdLYfk/s+l3+ogKGmbXT0K9bkYADFbPaSI
	L4xCRh2Vz2lSyexr57RzhT0wFnV1dJAYBxWEWgLawVvQ==
X-Received: by 2002:a05:6a00:14c2:b0:847:b2e4:9f68 with SMTP id d2e1a72fcca58-848895dc8ffmr11323221b3a.9.1784010212598;
        Mon, 13 Jul 2026 23:23:32 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7de23asm902775b3a.49.2026.07.13.23.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 02:23:31 -0400
Message-Id: <DJY2U8WBO9RL.Y30LKYAJB2AM@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 10/15] bpf: Allow all struct_ops to use
 bpf_dynptr_from_skb()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-11-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-11-ameryhung@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307364-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9168A751757

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> bpf_dynptr_from_skb() was only made available to bpf_qdisc, so far the
> only struct_ops type that needs to read an skb. The upcoming bpf_tcp_ops
> header-option hooks (parse_hdr/write_hdr_opt) also want to access the TCP
> options of an skb through a dynptr.
>
> All struct_ops programs share BPF_PROG_TYPE_STRUCT_OPS, so register
> bpf_kfunc_set_skb (which holds bpf_dynptr_from_skb) for that program type
> once, instead of per struct_ops. This makes bpf_dynptr_from_skb()
> available to bpf_tcp_ops and any future struct_ops.
>
> With the kfunc now provided to all of struct_ops, the bpf_qdisc-specific
> registration becomes redundant and is dropped: bpf_qdisc_kfunc_filter()
> only constrains kfuncs listed in qdisc_kfunc_ids, so removing
> bpf_dynptr_from_skb from that set (and from qdisc_common_kfunc_set) lets
> it fall through the filter unchanged, and bpf_qdisc keeps access via the
> generic struct_ops registration.
>
> Widening the registration is safe: a struct_ops that does not receive an
> skb in its context has nothing to pass to the helper.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  net/core/filter.c     | 1 +
>  net/sched/bpf_qdisc.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4f5cbcac3e78..05f492c215e0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12635,6 +12635,7 @@ static int __init bpf_kfunc_init(void)
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &=
bpf_kfunc_set_skb);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_=
kfunc_set_skb);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kf=
unc_set_skb);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf=
_kfunc_set_skb);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_=
kfunc_set_skb_meta);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_=
kfunc_set_skb_meta);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_=
set_xdp);
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index 098ca02aed89..5691c13781a8 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -280,7 +280,6 @@ BTF_KFUNCS_START(qdisc_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_skb_get_hash)
>  BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
>  BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
>  BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
>  BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
> @@ -290,7 +289,6 @@ BTF_KFUNCS_END(qdisc_kfunc_ids)
>  BTF_SET_START(qdisc_common_kfunc_set)
>  BTF_ID(func, bpf_skb_get_hash)
>  BTF_ID(func, bpf_kfree_skb)
> -BTF_ID(func, bpf_dynptr_from_skb)
>  BTF_SET_END(qdisc_common_kfunc_set)
> =20
>  BTF_SET_START(qdisc_enqueue_kfunc_set)


