Return-Path: <netdev+bounces-287327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NdANVecA2qF8AEAu9opvQ
	(envelope-from <netdev+bounces-287327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:32:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F74652A518
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 592FF302BBB5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9357382F14;
	Tue, 12 May 2026 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2zFekzq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BC2857EE
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621367; cv=none; b=spW0sKELgPeo03CC410hJqddpdILgBJcw+q1uxv4QgGMklizC8465Hs4XenVwK90t+C0TXeOT9K7DZVKRqtgU2j6UAeIJUXYYWFnHec8oL5LR/mJf3f9cltiqgt5L1m5EUKh6n762L1d5ZAoNOuryV09S1fa+De58hsUzufNyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621367; c=relaxed/simple;
	bh=TtDr2in+DcEaaN4EBs2I542LVM/WW3zR0M6EH1I3nq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uemCIM3Pt5/QiLqqo2GMZtJqrdpWT/H7hzUMicsC8EmPrTz9Sl4Xi8ox+yiYN6ktUq5Flpii3tJlr//X4i2IWeD+9OerLYr7t0pKNl+FPn8l5mp1XayDN+U+0GD0KUYljcFEs3GnX/cGrzUPQ962gmXBKA5yUB/wkqJUWo/CyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2zFekzq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-83ef1d17904so1014664b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621366; x=1779226166; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xcIGRYfY0KEc/4dSgMtJtnr1ER8sLsZiDBFTGwIcLKw=;
        b=I2zFekzqndQ0k0nii2KD6lnG7wxZC/WD11lrNrnx+jER1DGCOjtszfTzygL3f2qIJF
         53gdkV0xQ0vILe+30RliKHeYbZc7G+yY07kbwopOF325DlFSz5PKGU1XIYwPpaicU2dI
         veDl32aJ8ZtWLc+JEdlS28KSrgw5pfah7CzCaNk4Br+P63U3/2ae7BNqNlNAqkyvCc9f
         Cl0T+erkrxUqECwNGCNkugNMpWQgihfsoDqf27Ptt1qQ7OBmGNguU4CTAsQF6PcMe3tt
         +gKWIK3L5FLaSrjWkbQukFxR6a0NKLL8uX2zGKQEXSBv+gQKmU/LkCh/QM3+R6pcfBFy
         /a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621366; x=1779226166;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcIGRYfY0KEc/4dSgMtJtnr1ER8sLsZiDBFTGwIcLKw=;
        b=NLN/e2ZFI3w33awUz9kWRG6bU1V/yNPDxULbbubcD46g5zkyGpUVLgtbKFs42o8RbD
         7nsjzKQZ5ZW6+ryHUICH1Y8dJH/ekt2BI7tGZOmfIMUH5BNHEeS79mXuTjue34KysxUY
         Fr0nCnwWMoWe0Yo958Q3M6rkb0PhZAu34xbWVwJIXGhfIRHch2PstLjnzPBZLHdyeFuY
         /HmjwAdYeJ14ZiXL7WSvlZpQtCIdheBUPinsjMPeCzCaJU9/eDUjK1B6l7dyphWalIVU
         YNIZR7Etyg/NpEAFq6iW+J8yJ3hkYy3Z5Us2Ejlagh4LLzMl2xrjj1uDdb0po3Z9Bvvn
         yi6g==
X-Forwarded-Encrypted: i=1; AFNElJ/ou2fUiiLj70EKoSWTgD8SvSdGf9PeKaH+kVtaBZQaHhwRtB4CFkL2piE/OCxLA6yg+7XuCWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt96pIxE51aAcb5VTd1vdVHjutSdwezdYsQIADdu7Z3O0oQuOh
	U1mMkj2qZP+vMYQJSQZ4zZ5TzCXCbwAOC1XXFVr7dmVjfPRKJnQXTzpC
X-Gm-Gg: Acq92OE4u6+EgL35Sd8IlnOYz9uBp2qMdybKE8W/FYS1yqNAJ9Xabzx7Qd+MAgap69J
	m9mM10IZMu368RWXtAN9tgAbgPPp1OrCnnmf7luz9rs1vwEvWPpSKMYauveE+iseUyKaiyEou4W
	8Hp9m0dzLzj3G8o5BjRHCrv76OhFaPyqFXnekBNTlEpCNQH8XtHC04a9CpPomWYHqGhh2WUmV20
	DC2snAa+oTF3qu79SzmdP6xQlN3AqVvrGU4iGUlyEJO7DoEj/QOURCCiNZMMysPi4tE/a7bSwTx
	EmscHIFPlxkhEmaayNjSHJCS0x/hvetAIdP1O3YpJI4cxnzbSU4X2qSHw1YkslIxITdlInslFnk
	JOpDZIG0+4+Y8UEltBXwOADW980o/ve2vG2QULMZilYrwlSQ4/oVXRKgXPPM3LFt2oHucCmfoHG
	V5/yK/KZ2Pgh+jnDTXUaJf3iZV+u+BhdLzWI0dBUDB6xdaiO60A9QO
X-Received: by 2002:a05:6a00:1c94:b0:838:1ece:9716 with SMTP id d2e1a72fcca58-83f0548bb4dmr54663b3a.22.1778621365629;
        Tue, 12 May 2026 14:29:25 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c00sm22912429b3a.32.2026.05.12.14.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:29:25 -0700 (PDT)
Message-ID: <073fd24d1220adccec5248b094f4f80fd5e66f93.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Tue, 12 May 2026 14:28:50 -0700
In-Reply-To: <CAMB2axOsnVj=PBuMU8utqKsSj7DsVhWNi9Vddytx6BKfFGs0JQ@mail.gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-8-ameryhung@gmail.com>
	 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
	 <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
	 <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
	 <CAMB2axOsnVj=PBuMU8utqKsSj7DsVhWNi9Vddytx6BKfFGs0JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2F74652A518
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-287327-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 23:27 +0200, Amery Hung wrote:
> On Tue, May 12, 2026 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2026-05-12 at 22:37 +0200, Amery Hung wrote:
> > > On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > >=20
> > > > On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> > > >=20
> > > > LGTM, a nit below.
> > > >=20
> > > > [...]
> > > >=20
> > > > > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_veri=
fier_env *env, u32 arg,
> > > > >       }
> > > > >=20
> > > > >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XC=
HG_DEST) {
> > > > > -             if (meta->ref_obj_id) {
> > > > > -                     verbose(env, "more than one arg with ref_ob=
j_id R%d %u %u",
> > > > > -                             regno, reg->ref_obj_id,
> > > > > -                             meta->ref_obj_id);
> > > > > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > > > > +                     verbose(env, "more than one arg with ref_ob=
j_id %s %u %u",
> > > > > +                             reg_arg_name(env, argno), reg->ref_=
obj_id,
> > > > > +                             meta->ref_obj.ref_obj_id);
> > > >=20
> > > > I think this should be reported from update_ref_obj() itself,
> > > > it is more consistent logically and also avoids reporting code
> > > > duplication in check_kfunc_args() and check_kfunc_call().
> > > > Also, technically the reg_arg_name() is an independent fix.
> > >=20
> > > We have kfuncs that have more than one ref_obj. This is not a problem
> > > unless ref_obj is referenced in the verification and is ambiguous
> > > (e.g., used it to tie the lifetime of the allocated memory with
> > > ref_obj). Therefore, it is kept at the location of use instead of
> > > update_ref_obj() to prevent breaking existing kfuncs.
> >=20
> > Ack, thank you for explaining.
> >=20
> > > >=20
> > > > > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/=
bpf: Negative
> > > > > test case for ref_obj_id in args=E2=80=9D) since the verifier no =
longer
> > > > > complains about ambiguous ref_obj if it is not used.
> > > >=20
> > > > On the other hand, if you think that this property is worth having,
> > > > then maybe wrap the check with in some utility function?
> > >=20
> > > A utility function like below makes sense if we fold ref_obj_id into
> > > id. It would be too cumbersome for v3 as we may need two of this for
> > > ref_obj->ref_obj_id and ref_obj->id.
> > >=20
> > > static int get_ref_obj_id()
> > > {
> > >         if (ref_obj->cnt > 1) {
> > >                 verifier_bug(env, "function expects only one
> > > referenced object but got %d\n", ref_obj->cnt);
> > >                 return -EFAULT;
> > >         }
> > >         return ref_obj->id;
> > > }
> >=20
> > Maybe just like this:
> >=20
> >   static void validate_ref_obj(struct ref_obj_desc *d) { ... }
> >=20
>=20
> Do you mean:
> static int validate_ref_obj(struct ref_obj_desc *d) { ... }
>=20
> Then to use it:
> err =3D validate_ref_obj(meta.ref_obj);
> if (err)
>         return err;
>=20
> regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj.ref_obj_id;
>=20
> > ?

Yes, like that, sorry.

