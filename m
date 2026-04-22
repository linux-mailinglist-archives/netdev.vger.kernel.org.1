Return-Path: <netdev+bounces-280559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPv9IdhQ6Wl2XgIAu9opvQ
	(envelope-from <netdev+bounces-280559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:51:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553244B5AF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 059F13031011
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB3377542;
	Wed, 22 Apr 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyI4fjzh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3581C701F
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898262; cv=none; b=WdD/9+skQEN9a526Py/C2yEFjkhvdsF+z1PGVX9V9mymRu9XD7cvYkj01qzYlOD3D32UR5b5riKYZLUiKzUmGDHBfzV/Qa7XDb+KEz9PtGK+loR7jyoBk+sctQ8UrSGL6RVchN6mbpvV/bp67Am+o0+8vWQ7iuHDnNSVJdV2vU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898262; c=relaxed/simple;
	bh=ks+dCualzOaqs77AbQPlKYXvBqKtbOBNZnorH0jGzJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KdH8xqPfFZzfTm2UyzQOqUL2+vYsKSwoWUCHwdGJP6abvzAtn55Kv3q+QRPpTFFiGgQG5m1DU6KZMwV9/hVc/eiI+2Wi7zvUDXaTQ1QH+8gB7Sl79Xx7ux5VPLACkWABta/+auL1+fT9C8MSS/KXLACfm0iLbQlsvYt4WNzgc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyI4fjzh; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c637089ccso3559892c88.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776898255; x=1777503055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EsIQHrEiJD5FzpoBONUuhlECKQYQ9gBcLPk2ubeY5ao=;
        b=EyI4fjzheJmLMslMftbiCJbsvExX5Z0TDiI4LyK3u+VBtkPbbiZIn/8dRL4qjmDVUJ
         dR1I2/q5zK1lx0X9MmwCAFjMwzzyNnoBKMrjsiyaM9jfot5Ixkylfsu82GNypNd11DP/
         4ULbjG39JJO28vJ+pshVr/fKvhIimhn3WwFbW3NZ6pUtiQ3OXm/6GNyL0qpygJdYIIwP
         3/th6UscbJSViPdI15cx4DsjDVSLViUJqaBRu0jABpSKLXSBRzTeTUZPASkpXrcEd0xC
         TcXva58x2fAgMFLxtqrB7VcjG4FJ5HjmUW+VdCYVPNLw2NiEI6b/Dppua2gROrxYjYoT
         2ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776898255; x=1777503055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsIQHrEiJD5FzpoBONUuhlECKQYQ9gBcLPk2ubeY5ao=;
        b=qIzMQl4eArnnNFLukEFIJeRXtPvz1kES0IG3XSZN5rlaU8StoSccnvSWb06ah8yS11
         rrLJScEXClk5CWlWx7fff9DgzGRZfKFwIrNuXE5HkTZWltUIPmDW32eUtrOaaJMUVwgj
         k2uhkZaYox2NfpUHZtb2Sy5ltetKAMMi+uUZVkkVTaRex6L0yD6OyLQsvXXZbX1JAmBq
         u5gZXNbpaQu/7zJamQO13SGOhzjooG+3GR3DNBontvyvg+3/jmuRSGxDn2A9FzezeVhn
         1X8jxIpauhH/LkLIT6kNbFcHeWbn8sd+FSMwwZZqXCTOt4jbiJ1Ehg0wdKwPrnhv2x9D
         NeKw==
X-Forwarded-Encrypted: i=1; AFNElJ9eCEE8UfNhbVJh0ev4Emr4KK0nWRISgcb5MRAh6aT0/fQK1CfJLGrVUDk6UXAmq6/P7BwTZzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiQ5L4dszlGbE4zDkhu85o9DRL3y+KlzgAxrTtva45xjBksa3
	Fwb2tu8AXrB8/Z/RDf7nhpA4xq9LrSPW07htUjltwVtr210hbA2GK3RP
X-Gm-Gg: AeBDievT1jQt+6IuoS9YxRdglzMXbKKroYcLVIGY7wWnMUCQN0s+jHrBbP6rRM9f8IW
	BOm9ZdWE5vXxB8Y6vSrw9CHrxziAvLO2B6eYtIAQjCGGezvmfOaSV5AVAJXaQKPnBISExma0ubN
	DMjRqFiLWFIB9sSyHJ52w1HsRiTeQgnQItbr7ukjL1nMyTSUtO+YB9ACffPwKCtaskyJdx7rYkM
	fuYIvEDxx4mJk/9SmMqCCFtM+jNHqWkuxBQJdxHyeHZ39+wVXYCdRi/CykS40OcsqbYFmvM1nlT
	9evfpbY3P7XeU27q7gevMvaZ5c6VnGHDXFNtH7TC9WKOrmDx7Gz7wnwQG8jKHaR9mPJywjOhV1N
	/B6jQZ+ORvqG7KcHmLASz6WuOneY62M+DYnJ2IGknLCa+w9jrYcqyW+4XkyA1Or4YYyzFdqSPwT
	xWzKyTtlelE1NcAWpR7N5Vx3ZFhO6gOqS+VoRtZJt7qlvN51l7bBdlrdx8LgsOffjjaA5ZOxIFS
	pSlkoBPz0xVXObfY55RnMjXWfBuJC8=
X-Received: by 2002:a05:7022:129:b0:12a:68cc:3efb with SMTP id a92af1059eb24-12c73f9303fmr14127409c88.16.1776898255008;
        Wed, 22 Apr 2026 15:50:55 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1053:1d3b:d6cb:4350? ([2620:10d:c090:500::2:bea8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dbaab165bsm5912690c88.6.2026.04.22.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:50:54 -0700 (PDT)
Message-ID: <c84a7beccd4ae527981797a6e5a6af840ba9c312.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Wed, 22 Apr 2026 15:50:52 -0700
In-Reply-To: <CAMB2axMzeQs3WzFd1PZFB=DgR6d2ye4qzHKhATK2895ryzAEog@mail.gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
	 <20260421221016.2967924-3-ameryhung@gmail.com>
	 <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
	 <CAMB2axMzeQs3WzFd1PZFB=DgR6d2ye4qzHKhATK2895ryzAEog@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-280559-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0553244B5AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 15:45 -0700, Amery Hung wrote:
> On Wed, Apr 22, 2026 at 2:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> > > Assign reg->id when getting referenced kptr from read program context
> > > to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track t=
he
> > > referenced skb in qdisc programs using a new field reg->parent_id in
> > > a later patch.
> > >=20
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 41e4ea41c72e..93003a2a96b0 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier=
_env *env, int insn_idx, u32 regn
> > >                       } else {
> > >                               mark_reg_known_zero(env, regs,
> > >                                                   value_regno);
> > > -                             if (type_may_be_null(info.reg_type))
> > > -                                     regs[value_regno].id =3D ++env-=
>id_gen;
> > >                               /* A load of ctx field could have diffe=
rent
> > >                                * actual load size with the one encode=
d in the
> > >                                * insn. When the dst is PTR, it is for=
 sure not
> > > @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifie=
r_env *env, int insn_idx, u32 regn
> > >                               if (base_type(info.reg_type) =3D=3D PTR=
_TO_BTF_ID) {
> > >                                       regs[value_regno].btf =3D info.=
btf;
> > >                                       regs[value_regno].btf_id =3D in=
fo.btf_id;
> > > +                                     regs[value_regno].id =3D info.r=
ef_obj_id;
> > >                                       regs[value_regno].ref_obj_id =
=3D info.ref_obj_id;
> > >                               }
> >=20
> > Hi Amery,
> >=20
> > Could you please help me double-check my understanding of this change?
> >=20
> > It adds a new behavior, if struct_ops method parameter is annotated
> > with __ref, then if a field is read from such struct_ops context
> > the destination register would now have it's .id =3D=3D ref_obj_id
> > allocated for the parameter at the beginning of do_check().
> > E.g. for `rB =3D *(T *)(rA + off)`, if `rA` is a pointer to struct_ops
> > context and parameter corresponding to `off` has `__ref` annotation
> > the `rB.id` will be assigned, contrary to old behavior, when it remaine=
d 0.
> >=20
>=20
> Right

Ack, thank you.

> > This change in behavior, however, becomes visible only after the
> > changes to release_reference() later in the series.
> > There the `rB.id` is used to initiate `mark_reg_invalid(env, reg)` for
> > the `rB`.
> >=20
>=20
> I probably should mention it in the commit message. The purpose of the
> patch is to make the implementation consistent with the design:
> parent_id tracks the id of the parent objects.
>=20
> Without this patch, it should still work since in this case ref_obj_id
> always equals to id. When release_reference() is called on a
> KF_RELEASE kfunc, the children objects will still be invalidated
> correctly.

bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_frame
fails if I comment out the line `regs[value_regno].id =3D info.ref_obj_id;`=
.
The added .id link is used to propagate invalidation triggered by
`free_skb(skb);` to  `hdr`.
The patch seem mandatory for the series.

