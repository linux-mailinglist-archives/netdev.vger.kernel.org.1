Return-Path: <netdev+bounces-299945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z25RC/2lMWoyowUAu9opvQ
	(envelope-from <netdev+bounces-299945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB200694FC7
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:37:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GC8Anh5V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299945-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299945-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3A683024CB1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CAF3DFC6D;
	Tue, 16 Jun 2026 19:36:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA573DA7C2
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 19:36:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638598; cv=none; b=jYEHKg8Ner2gW9TmfuQ4NJqY5GhwHGUZt0rvMd5RcEgC9skQJK2c91idZFxRab9WMjrFd4pYoKRykHSZwF27pz0hAmOK7FowwtiKUmZDPwCns+2ll/e0iukNMCcX2cv/42YCYmaWIOlkg8ydWniODLmqaXKYuAP2E5ry+zJ5Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638598; c=relaxed/simple;
	bh=x4vuvjMjK3Siqy6TliGJe8+jhWlv6O6RxnFPsOmVF7A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e13aoDZZZvxoCUsGoi/K0Ggdh+H3MNUjwidJu8nJzjmY0dU2hZHCKi8e4jf6qquU481C4G7MuTLLY8MHbkCvAq/JjAbQMPMBoVvMMNLKEilLVsVkDsncqf8toEdYJghtfr+YF0w6lba8azZuhUn5BLtGuy/0MidtgAcRt0P7r74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC8Anh5V; arc=none smtp.client-ip=209.85.167.170
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-48611ccd5aeso3145301b6e.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781638596; x=1782243396; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EO/9z4OOJVGQlHYYaBZaNw8VQwWazXkqSJi3LxEM90=;
        b=GC8Anh5VfSrdFDAjBCA+t3VBlW9IQNj5CS2020mtctSOl0TPtqgqnGjyN+MItcjWCE
         R0j+pM5rZJAV44nYdGQv7jC3qjGRKFk5ryfZPJP6ggkny9bOvT5PsAWDBqNcZnOUDHzW
         55at24VAlGj21mPIJaKOSHd4NigWRARptROZhFH3vPAFtWHmD3Dcc2orE/BzygvegpF8
         MYKIXU7AGLmA1BXhbVVUIyvaoI5TvJOVe0/vMdnU4AZCkGAi3uDlSMlvfvJARjsCEL6h
         eT6d5OdfnVWITLk0Pho0d6JAb83fB8Ys9lco4IUXjCHAL6DfOFBC6BEmxTmI4sb3ZPRt
         MAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781638596; x=1782243396;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EO/9z4OOJVGQlHYYaBZaNw8VQwWazXkqSJi3LxEM90=;
        b=dR1uRkNqd2Bi2nTJgrdfURE/kKDGiCXN/tHkGtv0Zv1Fgvu5TxuhT9nRyPIiQGtv2f
         ml+aFXM33KiG9Iu9NOumXjZmk9hx5Iu8wpP7J2ZIbO7PeVyxUwIo9wtxtlmXKnZofxBg
         8JPqEs/CZGLonUHojYsgV7O1n1EnZ3kL38nxRXSYiiS1JPTbiAQmyJiwqjdR/eEOA8ep
         Rm3d6DYXQD/J7iDLQS4nJySL4OUXIjmYhcogn8gFJoRLd17b3Cs5m4NgriePtJWGuaDe
         Lerjev2998wOiolE7nqc+cX5Ja/4bAKsQKeMg5H8xd5Bpa6unG42Vwvk0G6yZz9feJcu
         /Xig==
X-Forwarded-Encrypted: i=1; AFNElJ/NMWqvSaBoficXrXhMJfuqpbHcKDvT/PBDEpvwhgfB683wlY8vihWP5RmDigrpUc2zQ3BShMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydnH5msC6ui91d+vj0ejLMzwth9JyF5kX6eMUFdQxkjWx5K1bK
	Ur22BrLEHluNsYey+nLkoLXi0z50U5UpvwDjYQS08XmCcIZpAdThPrAJ
X-Gm-Gg: Acq92OHUib1m3hwOqjrlBKaFtUtusEsvSbc3tab/+JEkbnEXoQbky2WgRP53ZC5gVVH
	5koATT4/aFdZcUgkD8u7iAfiDMcCpfLDjmNm/sIoNK4zi1JEg4ebINPI0eWNS9X/akGwfzJ+DrN
	Oz/AVEK0jB6w1BVDMqhXbqR8EG6qLQKlHCPGXm813/yO4mxbaF1w9afA2EZ1REGM5QmhV6paqBM
	AHNqxbNQfZN54c4uazDftIQ7v3peigsCa+RP7rHLv2M7lPW4YFN/RruASMMrbtdwgPtmqmvd7Fg
	wb6/VFBirNQjfp046RUiuoKdvVOxxEkybwAkZwc2dI3df5DUBg7gQO5LC1K4rMGM7Ki7gfBXbUC
	IozDNemaJ+ELceGmYZnblhhUQjeo3DjimnmYAiu2DAUAMpSKMWBQdm2lloPCfyloA1Lf6UvlEJ8
	5zFgTQ+LAra7amPcAe3LvZ1As2AL+8+8sXAKUoeeknpgWpSqnULiZ0qgbKVpBvIVcGXjt2hOpy0
	AHoJBQBrb5uab6lyQ==
X-Received: by 2002:a05:6808:1b28:b0:479:faf5:ef4c with SMTP id 5614622812f47-48944641750mr389992b6e.32.1781638595545;
        Tue, 16 Jun 2026 12:36:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddda6b6sm4881214b6e.8.2026.06.16.12.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 12:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 12:36:31 -0700
Message-Id: <DJAQ65ZVYAN7.2Z8DNW7Z0JE7V@gmail.com>
Cc: <pablo@netfilter.org>, <fw@strlen.de>, <phil@nwl.cc>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <shuah@kernel.org>, <kartikey406@gmail.com>, <coreteam@netfilter.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Guard conntrack opts error writes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, <bpf@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>
X-Mailer: aerc
References: <cover.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
 <70aeec0ab762aebe65129cf6052e132c7329edc2.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <70aeec0ab762aebe65129cf6052e132c7329edc2.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:kartikey406@gmail.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:chenyy23@mails.tsinghua.edu.cn,m:bpf@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,etsalapatis.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tsinghua.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB200694FC7

On Mon Jun 15, 2026 at 10:42 PM PDT, Yiyang Chen wrote:
> The conntrack lookup and allocation kfuncs take an opts pointer
> together with an opts__sz argument. The verifier checks only the memory
> range described by opts__sz, but the wrappers unconditionally write
> opts->error whenever the internal lookup or allocation helper returns an
> error.
>
> For an invalid size smaller than the end of opts->error, that write can
> land outside the verifier-checked range. Keep returning NULL for invalid
> arguments, but only report the error through opts->error when the
> supplied size includes the field.
>
> This preserves error reporting for the supported 12-byte and 16-byte
> layouts, and for other invalid sizes that still include opts->error.
>
> Fixes: b4c2b9593a1c ("net/netfilter: Add unstable CT lookup helpers for X=
DP and TC-BPF")
> Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert C=
T")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  net/netfilter/nf_conntrack_bpf.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index 40c261cd0af38..3c182024ec509 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -65,6 +65,11 @@ enum {
>  	NF_BPF_CT_OPTS_SZ =3D 16,
>  };
> =20
> +static bool bpf_ct_opts_has_error(u32 opts_len)
> +{
> +	return opts_len >=3D offsetofend(struct bpf_ct_opts, error);
> +}
> +
>  static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
>  				 u32 tuple_len, u8 protonum, u8 dir,
>  				 struct nf_conntrack_tuple *tuple)
> @@ -298,7 +303,8 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_s=
ock_tuple *bpf_tuple,
>  	nfct =3D __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev), bpf_tuple, tup=
le__sz,
>  				       opts, opts__sz, 10);
>  	if (IS_ERR(nfct)) {
> -		opts->error =3D PTR_ERR(nfct);
> +		if (bpf_ct_opts_has_error(opts__sz))
> +			opts->error =3D PTR_ERR(nfct);

LLMs have no taste.

Above two lines could have been one helper
   bpf_ct_opts_set_error(opts, opts__sz, PTR_ERR(nfct));

Or we can do a step further and simplify the code more.
Turn this:
   if (IS_ERR(nfct)) {
           opts->error =3D PTR_ERR(nfct);
           return NULL;
   }
   return (struct nf_conn___init *)nfct;
into:
   return (struct nf_conn___init *)bpf_ct_opts_result(opts, opts__sz, nfct)=
;

static void *bpf_ct_opts_result(struct bpf_ct_opts *opts, u32 opts__sz, voi=
d *ret)
{
  if (!IS_ERR(ret))
    return ret;
  if (opts__sz >=3D offsetofend(struct bpf_ct_opts, error))
    opts->error =3D PTR_ERR(ret);
  return NULL;
}

This kind of small improvements should be obvious to any human developer.
Please do NOT send us patches straight out of LLM.
Review it first and think how to improve it.

pw-bot: cr

