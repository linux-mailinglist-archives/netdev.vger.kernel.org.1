Return-Path: <netdev+bounces-280550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK9JIMZB6WlXWwIAu9opvQ
	(envelope-from <netdev+bounces-280550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:46:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5744B1D3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E86C3002D18
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA73A1697;
	Wed, 22 Apr 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvwzmaEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766139DBE3
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894399; cv=none; b=rwgHm+YLX45RNTiPiX6Vax6SgAbSh93nxWlzuI0xOl1Xl1NpfqGBueblJtICphaJyaAw50e+Yh0DrjGT0mR1ROK/G02FAEU4AtCY2Bo8qPNYxuroRxANpLZQ/dEKhCa6Ep8ZTXWKCg5xQ537xgE4+s+ok2X7ku7kef+opxBH2F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894399; c=relaxed/simple;
	bh=LXWQ/zZQDB6esYihcq2rAbd9DbZBVCewYrXWURJ5WH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWHl6wt1bSOaabYuWNjaIVk+nNmUcwHiRlrKnJjDsK9A2DmzXcm5flpgHl6wLYZrQzRKM+b2ucEdiTZ+FNRWceQET7fXzWYTymYXnJxxkVhgIi1E0OLQw0BOb2NZnKg9kJDWeFqUciyEXgfjUJz/FzF2H9KI5KL9dZcPBeCIn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvwzmaEB; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c726f46baso7386883c88.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776894390; x=1777499190; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Ad2LzfHEjcYKktkgeY/57KxF86FA1ViCeeANnpbQLY=;
        b=UvwzmaEBSSn7ZdPhMuaqFXVXa+UEbGh/8NPI7BGBtqn+pvi3gxZPAiuKZkRpPDi8t1
         yC6EEOVBe7lHQ7UcfphG0Me1yrEI5PeZK/h5DBgm6YSse08io3+DQJOT2tzW8HTIj39t
         bPdLjyhT5pab1aeBmDAx8V983ryPwj+t94nxpuQqq1GClwCqbRwzA8bArvXyLShKPwBw
         3qiR0jQ3QM757cQyewIgMWweoCD10JDicnyHbjjVqpuW11/diANo/kMVK3yxN9OVrR+y
         JFA7gsIYJ6zlPYgbuBAyQp7JEgaRPETcdfiMtyFDT8rkmFC6V4jPGZoY97pQkIJte4m1
         +Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894390; x=1777499190;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ad2LzfHEjcYKktkgeY/57KxF86FA1ViCeeANnpbQLY=;
        b=EriQTWpd7Z2kBlLVoP81WdeJ88QN3YukyWdcMTfSzZlatWeprWH5gmScmFO7wZhsHN
         45EcpJmFKzCswHTGd4hYuWNU/QT/voB14W1PJzMzbo72eKgjo0uFKEjgtaGwHPI4HWua
         LtvnqT+HktyKLbozbGAoyeyTaFNLjgp302Q4v1O7Y6qrP6AOw9YYuTkjiRx+6C8cFjQW
         X2O1pE8TRx6EVMM53Ti3OPUWSfgu/4S8f7EZwznULZccD8NgKDXMxN952AIn5fN+epDR
         WUjxHa6T5KbzGStKoR2zkQBXWTT0lxDkLMDAT6yHTnYbbiXCwoTo++i1oAuGNG44WGnI
         sTrw==
X-Gm-Message-State: AOJu0Yxmrd+C8ePROJaiym3fBT4ULkVF/c+5dnDwLGyKHZZgVFrk2tyw
	kvGQBRyJnQ5WUPC4l4hSzRfuOea3DKKmfLhaTmN/2tLdLXEmCRyr+x72
X-Gm-Gg: AeBDieulx1wn8tnbla2yCmWSRN/nC/hHuBAi+MMIIzuL8N3Jf82HhQIXv6hfdQ12eNz
	79ntp0GmVR30uAMmMDynVsAIKkRzHSlHuO5fHZ/HjI0T9qYofp6SJ/qp1aFTZ8ejxml9YFlc2Jl
	F4S3iAyDy8De6TvqbH4DGY7VorLRiyNZbISbLoV4Z1xJDvY8mnS4rZINyAfvMhocr7s29xei8Lw
	bqUEK8kfECeQSILF5LE86RrbJfB9uxY4gOQ6E/ecuUYtjjdDUuhEAuLH7SqNIZMhO+dD4vjuE/4
	nhNMcHCRUiviBAXDB8UOXQF9krFSc0LUaJk5jaklaFJVddSoqJ8IkigWcVf8++mZMxd8TE0GV/q
	hClRGjR9FYbc8oBeB1ZBiZw+iFN2+EOQMYy2n3ZhmR1o8rFl9EyGnbRACdIP0lCFqhI16yRf324
	pdWen+HVix1iwS8MBvbkUng6dX1cuUwA2/LztiXdPUR2OtttIpgPyk6vHtnQF59GdbCtOv9eoHT
	etS5zehRIAAChuokjvQ
X-Received: by 2002:a05:7022:b87:b0:128:d375:f1d4 with SMTP id a92af1059eb24-12c73f98f83mr12823895c88.28.1776894389872;
        Wed, 22 Apr 2026 14:46:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1053:1d3b:d6cb:4350? ([2620:10d:c090:500::2:bea8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dbaab165bsm5640680c88.6.2026.04.22.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:46:29 -0700 (PDT)
Message-ID: <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Wed, 22 Apr 2026 14:46:27 -0700
In-Reply-To: <20260421221016.2967924-3-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
	 <20260421221016.2967924-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c15:e001:75::12fc:5321:from];
	TAGGED_FROM(0.00)[bounces-280550-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,2620:10d:c090:500::2:bea8:received,74.125.82.45:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 85E5744B1D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> Assign reg->id when getting referenced kptr from read program context
> to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> referenced skb in qdisc programs using a new field reg->parent_id in
> a later patch.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 41e4ea41c72e..93003a2a96b0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>  			} else {
>  				mark_reg_known_zero(env, regs,
>  						    value_regno);
> -				if (type_may_be_null(info.reg_type))
> -					regs[value_regno].id =3D ++env->id_gen;
>  				/* A load of ctx field could have different
>  				 * actual load size with the one encoded in the
>  				 * insn. When the dst is PTR, it is for sure not
> @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>  				if (base_type(info.reg_type) =3D=3D PTR_TO_BTF_ID) {
>  					regs[value_regno].btf =3D info.btf;
>  					regs[value_regno].btf_id =3D info.btf_id;
> +					regs[value_regno].id =3D info.ref_obj_id;
>  					regs[value_regno].ref_obj_id =3D info.ref_obj_id;
>  				}

Hi Amery,

Could you please help me double-check my understanding of this change?

It adds a new behavior, if struct_ops method parameter is annotated
with __ref, then if a field is read from such struct_ops context
the destination register would now have it's .id =3D=3D ref_obj_id
allocated for the parameter at the beginning of do_check().
E.g. for `rB =3D *(T *)(rA + off)`, if `rA` is a pointer to struct_ops
context and parameter corresponding to `off` has `__ref` annotation
the `rB.id` will be assigned, contrary to old behavior, when it remained 0.

This change in behavior, however, becomes visible only after the
changes to release_reference() later in the series.
There the `rB.id` is used to initiate `mark_reg_invalid(env, reg)` for
the `rB`.

Are the above observations correct?

> +				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
> +					regs[value_regno].id =3D ++env->id_gen;
>  			}
>  			regs[value_regno].type =3D info.reg_type;
>  		}

