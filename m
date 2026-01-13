Return-Path: <netdev+bounces-249641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FBD1BB92
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422203049C68
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82E36AB65;
	Tue, 13 Jan 2026 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDHagSbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9935580E
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346790; cv=none; b=aI0cIjvZlG4flF5JCK5cFpSstCfFLln6XFiP6sLCVO6bsZA660hB7CUEjzS8ve6YoWnFR4pJ8aZXUm5lkEym5oNHnipB4JjNIMho2YCjkVm+CCYcPj80nsiTxXhd/GJENvlTZbpg6LumuNZwXaTot1xhQIeV6xIIlxwI9uVhUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346790; c=relaxed/simple;
	bh=3y+bk/MJ2poSwYsFVrenX8t8LScuLKE/QqLdiQeYYzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pO2y5ZR8P3NRlIBTf50jBxksaWwOr5tgeDr7TspIdlxiFAId+YVYnvobaLfO9CJnB0L5OiC0vB66sr0vwdFE9IjDhI3iibRS0D+XtRJym0L2eL8z5ZxLIrMQz1PKNoTAtaxAui5pb1a8oorHog0dyaAym7sLBhfO07p9OFPA7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDHagSbB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so4763777a91.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 15:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768346788; x=1768951588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk8oA44ICG5vF7hOIh71S9DCMNMJEV8Knkk8c5MK7oM=;
        b=BDHagSbBxApMmxT+gdwbrzdf29fHeXXGthMFxFtspMTtwuUJJmpgzPu1RErOXxkPgs
         pWYQVande4Wu9it5hL+fi49k6PtAqA1AnCvI7f10d0FKbMtY5GOSzczMZHbeplUBma6D
         vxFEQpqO5i5L9Yc2+xbW6WEgtiZb1goUI9EixuO9J9v5EUqxUJCgRPfdEw7Wvs0H5dc4
         tBtkwFJtg/I7kmz3w7tPYRj2V/9R8pbIcdjcWS2Oktv8dnfSK6vNx0PSfuC1EPlJZLAI
         laY2sgflB0V6l8j8S7O411JEJwRlLoE6+vZMOr7IjfQTrUl3YGZn31knVwcwnWjPTPdz
         /L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346788; x=1768951588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qk8oA44ICG5vF7hOIh71S9DCMNMJEV8Knkk8c5MK7oM=;
        b=rqwovXpc+EKNcQWDE04xfomiIMuyahe9ffJCFraOI9wgMy26A6XtPS2GGn/aiUgji5
         rVGxs9d+Ds5LcqrrhYZbSkztbKwZXfP/EW/msYo6ejV7ajDYxGox1IsBUVI8psXrKk2m
         PA+lT0jXn7D3rn8kxodU6jiLYVjynbm79xD7bd0Gf9kyEhAAJTysk8iqdPnjTFf5Vvcz
         E6kuyMG7NkJYQPcpzhC7XrIVPiVmz7pfXfdTSAW+KEaLb8AqCxGhlru9p2HbvY/BTHLA
         grNRNCM/hzNRC1XHcow6ckAYFDq7IIV0wcxhpEN2a6/ljS6XfnVu/KP8Fif7rqVOPFAC
         Qykg==
X-Forwarded-Encrypted: i=1; AJvYcCUAcmDey80UxC8/ex3qF/b5c5xlIALhZwa0Sv1UDy8mG77JskQz2LlDqi6XOYGSXUPBvO4z6zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylg8zHGHxMns6d402+xhuuIJyUpYU4vRa1PIF5jKZ0/htydmSm
	W1R5Z8yz7I1FmU4BF+o5cfJD0VcgrLbWhaKv46wXEhRZHDXvQ9YKG5g2Z/qSY2+lkIEXaxQbD79
	m58UPh3LaX7vR1UoWPoj0n0rgV+XGl8k=
X-Gm-Gg: AY/fxX7R9XYQg5g4gQR9L+nlyEcWt5//S8YAvTH0/yAGGIXcVe8iiIpT0RpNnMs329+
	QQa19cHFftOL3e0syhuToMrl58f/lDTj/R2w7ev8IGy4CXGa25cPs3vazlIouI1ys3pBOxYNZhs
	JIa29AyVEqM/36Ysnp1NDTTh4VfugBHF/YVhxtlzVy44RhhRCx1LqaUpz/c9RWRif6oqU/l5hU/
	8TJZNLa76/hpGnKOJqG4wca+tHrdbGX81tUyzoB32KgRi/NoGmCA/gyvuSei4kOW8cJkeylX43r
	UE6/+Cd/Pvo=
X-Received: by 2002:a17:90b:134f:b0:34c:3cbc:db8e with SMTP id
 98e67ed59e1d1-35109131d4cmr585428a91.25.1768346788364; Tue, 13 Jan 2026
 15:26:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200818223921.2911963-1-andriin@fb.com> <20200818223921.2911963-4-andriin@fb.com>
 <2249675.irdbgypaU6@7940hx>
In-Reply-To: <2249675.irdbgypaU6@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 15:26:16 -0800
X-Gm-Features: AZwV_QgxH4FXvpvlBSjSBp25Kg_vI2UVSYICc-R2vbjGt5ITBE9M2KmYnV9d5ZY
Message-ID: <CAEf4Bzb04C97K=S1av_6EKG3jKHoG+mKwaxVw3cCnNsbyiDzmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/9] libbpf: improve relocation ambiguity detection
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com, 
	daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 11:36=E2=80=AFPM Menglong Dong <menglong.dong@linux=
.dev> wrote:
>
> On 2020/8/19 06:39 Andrii Nakryiko <andriin@fb.com> write:
> > Split the instruction patching logic into relocation value calculation =
and
> > application of relocation to instruction. Using this, evaluate relocati=
on
> > against each matching candidate and validate that all candidates agree =
on
> > relocated value. If not, report ambiguity and fail load.
> >
> > This logic is necessary to avoid dangerous (however unlikely) accidenta=
l match
> > against two incompatible candidate types. Without this change, libbpf w=
ill
> > pick a random type as *the* candidate and apply potentially invalid
> > relocation.
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 170 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 124 insertions(+), 46 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 2047e4ed0076..1ba458140f50 100644
> > --- a/tools/lib/bpf/libbpf.c
> [......]
> > @@ -5005,16 +5063,31 @@ static int bpf_core_reloc_field(struct bpf_prog=
ram *prog,
> >               if (err =3D=3D 0)
> >                       continue;
> >
> > +             err =3D bpf_core_calc_relo(prog, relo, relo_idx, &local_s=
pec, &cand_spec, &cand_res);
> > +             if (err)
> > +                     return err;
> > +
> >               if (j =3D=3D 0) {
> > +                     targ_res =3D cand_res;
> >                       targ_spec =3D cand_spec;
> >               } else if (cand_spec.bit_offset !=3D targ_spec.bit_offset=
) {
> > -                     /* if there are many candidates, they should all
> > -                      * resolve to the same bit offset
> > +                     /* if there are many field relo candidates, they
> > +                      * should all resolve to the same bit offset
> >                        */
> > -                     pr_warn("prog '%s': relo #%d: offset ambiguity: %=
u !=3D %u\n",
> > +                     pr_warn("prog '%s': relo #%d: field offset ambigu=
ity: %u !=3D %u\n",
> >                               prog_name, relo_idx, cand_spec.bit_offset=
,
> >                               targ_spec.bit_offset);
> >                       return -EINVAL;
> > +             } else if (cand_res.poison !=3D targ_res.poison || cand_r=
es.new_val !=3D targ_res.new_val) {
> > +                     /* all candidates should result in the same reloc=
ation
> > +                      * decision and value, otherwise it's dangerous t=
o
> > +                      * proceed due to ambiguity
> > +                      */
> > +                     pr_warn("prog '%s': relo #%d: relocation decision=
 ambiguity: %s %u !=3D %s %u\n",
> > +                             prog_name, relo_idx,
> > +                             cand_res.poison ? "failure" : "success", =
cand_res.new_val,
> > +                             targ_res.poison ? "failure" : "success", =
targ_res.new_val);
> > +                     return -EINVAL;
> >               }
>
> Hi, Andrii. This approach is not friend to bpf_core_cast() if the struct
> is not used in the vmlinux, but the kernel modules.
>
> Take "struct nft_chain" for example. Following code will fail:
>     struct nft_chain *chain =3D bpf_core_cast(ptr, struct nft_chain).
>
> The bpf_core_cast() will record a BPF_CORE_TYPE_ID_TARGET relocation
> for "struct nft_chain". The libbpf will find multi btf type of nft_chain
> in the modules nf_tables, nft_reject, etc, and it will fail the verificat=
ion
> due to the "new_val", which is btf type id, not the same, even if all
> the "struct nft_chain" are exactly the same in different kernel modules.
>
> I think this is a common case. So how about we check the consistence of
> struct nft_chain in all the candidate list, and use the first one if all =
of
> them have exactly the same definition?

BTF type ID for some type in some kernel is not meaningful without
also capturing module's BTF ID or FD, so we'd be just capturing some
relatively random and meaningless type ID.

I'm actually not sure bpf_core_cast() can work with BTF types defined
in module's BTF. Can you please check what we do if we have
non-ambiguous BTF type defined only in module's BTF?

>
> We can check all the members in the struct iteratively, and make
> sure they are all the same.
>

It's not even clear what "same" would mean here, btw. None of the
issues you bring up are easy to solve :)

> Thanks!
> Menglong Dong
>
> >
> >               cand_ids->data[j++] =3D cand_spec.spec[0].type_id;
> > @@ -5042,13 +5115,18 @@ static int bpf_core_reloc_field(struct bpf_prog=
ram *prog,
> >        * verifier. If it was an error, then verifier will complain and =
point
> >        * to a specific instruction number in its log.
> >        */
> > -     if (j =3D=3D 0)
> > +     if (j =3D=3D 0) {
> >               pr_debug("prog '%s': relo #%d: no matching targets found\=
n",
> >                        prog_name, relo_idx);
> >
> > -     /* bpf_core_reloc_insn should know how to handle missing targ_spe=
c */
> > -     err =3D bpf_core_reloc_insn(prog, relo, relo_idx, &local_spec,
> > -                               j ? &targ_spec : NULL);
> > +             /* calculate single target relo result explicitly */
> > +             err =3D bpf_core_calc_relo(prog, relo, relo_idx, &local_s=
pec, NULL, &targ_res);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     /* bpf_core_patch_insn() should know how to handle missing targ_s=
pec */
> > +     err =3D bpf_core_patch_insn(prog, relo, relo_idx, &targ_res);
> >       if (err) {
> >               pr_warn("prog '%s': relo #%d: failed to patch insn at off=
set %d: %d\n",
> >                       prog_name, relo_idx, relo->insn_off, err);
> > --
> > 2.24.1
> >
> >
>
>
>
>

