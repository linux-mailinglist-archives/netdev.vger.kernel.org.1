Return-Path: <netdev+bounces-263501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLZBMFB/p2kyiAAAu9opvQ
	(envelope-from <netdev+bounces-263501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:39:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4481F8F58
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F4F0305260E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581972F83A0;
	Wed,  4 Mar 2026 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDr12r/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097222F6565
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772584743; cv=none; b=hnZipnn1TdE7GCG7nBZhks+wpzxD29hu+ImgC6SHyZC3I6I9AzG5y9T/hrRBttQSOGu06+BooI4UGBBq3pRG4V2ZcOu0h9KlIfa8SjomatLeshFPaAsnsQSorXgYG6/gfyZaiZlPLJArsZQTmZ5y7MTq3mVJD/AUDKuEhnRWejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772584743; c=relaxed/simple;
	bh=J9/w+GV109IEcn1Q+0SdEFxbwYJRkVeVL/l+ILzuzio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mveEX/6vt2sQln2y+Rv/TjO6NrIQ4sIveMCjfF2u2/mPMn3kdbKdNWQx2ad5mxkt/xWe5yG1UlnxPo6ntBmdIBaHBeCdatJDrDy+XeioIVYxl38nSe97W4wwJS9dy/KVHK5KMdaVQGeK2XWjtOGDMfKvjnwKQCfcjS80SM0F/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDr12r/5; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be1d9c356cso3457279eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772584741; x=1773189541; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=stECg2pbCtjFcE+bnNiaYSS9evhqc17B1DW1uTxR+o8=;
        b=bDr12r/5mUbgnorNLOflO+Eglp059pPtKNvr5h2Gd4ivamKxPFmiQUqxKoEYGEu0/x
         5nNdrPsW4WSyytKuP/r+9NHobz45IRuoCeH9t4LWzuqhXU3QZRy9MNqOdyzViNexxTo3
         lmiJRu6lboPBgLmyRLBWeWKdwNLAUitUp72i7/LY3iz5viZ3SzGbom86RMBmG41plqER
         dmBhb8b909peqfqPby0cwd9JVdvNnoJvsyrY2wRsrv/E+teDzyjBzvZgJ2xoxIef8wD5
         vgMv0VCNwP6w5n3zzTxkELll0POge4G1F5JAV3fEhbwEwQeUbYbdZGe7Zf7GPsGywz1a
         FKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772584741; x=1773189541;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stECg2pbCtjFcE+bnNiaYSS9evhqc17B1DW1uTxR+o8=;
        b=iAiQDiIEmM9axsJrYon1SfdZZaO3Eq3VUc3GRGYSTz8oF7DA6B2lqLvV46VR/okxWV
         rG6sOXi4R8Wsu2wSIe8GWDpolQLA21OATxZy3OyuRSGhzDIdw9dp1UcrIqS27EGO9MhB
         8pqDn6L/cqR3EcWuBs6fW9ikF43NnPK2wFNP6SvrRI14z9R+0WGuCltkaUX0zehRxtWQ
         Jh5KzUqFs21lHftWlhKAQV23z8A/CcTDzFKJwRz0pM7bFLWUZl14NCIew+sQwLUQvEY8
         nBu0fOHPMe5DKNgU/n+A0PiNAg/QdDROAnzkb9GrBO0VBxFVxRxVRV8TCNhY69ZA0CRx
         dJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwRtyXj4A7FFI1gD/9W76sP0yIu0CN7xPUqHpt1qW+rkkMuIqZ4VQB31OeTXAwz2onuvecYe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUCQbfdOPxYu9LpTTz9dZPmTruHLCo19NXd0cKFRMPSWQtuw6
	kyhsWObW2zyeRrhk7vZQ1jAPl1eP+pwEVuoDpGyU7qwibF2kONzdOUVz
X-Gm-Gg: ATEYQzyzZbwFIj668sOkbGpf+mzoNg5a/3VjHqsq8RNKGF96WGdFABuAn9deVeO+ezr
	6gdyAWZOjSnpzOIYuxhQ0BOiV96VnufsahLwjq5I3NIKvn9jirQP3+PvUpRUOgT1Qc3a7BiW3ig
	v7zYkMzZ7Cq3bjky/mJ1O9cLeq2ZPyiVnXS6/4jfW1VUnitA2PvFLb2+wR815HfuMtYOs86Y/Zx
	WXhGV+TmttAmDu/sRaCjrsH5nd08sHAzlQ7iJnn+/a4afxx94Po/9ov1kovZOYtucGvbjnmMrXG
	0lHZP+Qj1zb/IuWg/Qp66q6nXw4pNb/Yz0VEgDG0G6JaFirxTOrdp8WBiRQ0UH9qGVj6iNlAIi9
	llKrJmxFrK5Y9DyWQUSW+KlzEOE3dcn3PLdcVRKJylGVERuHrzKWNsmEjrJiPi8TRHpy0lNFF+Z
	pxKo3U6UFEeziYtGfe9vkvef9DTpRNoRNwHtnCu3YCZte1KOa7DwyAv8kZmt9IZuZdxk2ZGGwwQ
	WIDHOsSjJU/6s5tbak=
X-Received: by 2002:a05:7300:fb96:b0:2bd:d157:6786 with SMTP id 5a478bee46e88-2be3108dacbmr114547eec.25.1772584740993;
        Tue, 03 Mar 2026 16:39:00 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0d7e0d40sm6942494eec.12.2026.03.03.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 16:39:00 -0800 (PST)
Message-ID: <c4f4e99f83a98179c3413dd7afe5e7e73a98e4d3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types
 via SCALAR_VALUE for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	davem@davemloft.net, edumazet@google.com,
 haoluo@google.com, horms@kernel.org, 	john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-open-source@crowdstrike.com, martin.lau@linux.dev,
 netdev@vger.kernel.org, 	pabeni@redhat.com, sdf@fomichev.me,
 shuah@kernel.org, song@kernel.org, 	yonghong.song@linux.dev
Date: Tue, 03 Mar 2026 16:38:57 -0800
In-Reply-To: <20260304002205.15728-1-slava.imameev@crowdstrike.com>
References: <84c687e56ed8f04f3f318f090272fb5ef7520e96.camel@gmail.com>
	 <20260304002205.15728-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2B4481F8F58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263501-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 11:22 +1100, Slava Imameev wrote:
> On Tue, 03 Mar 2026 14:43:01, Eduard Zingerman wrote:
> > On Wed, 2026-03-04 at 08:49 +1100, Slava Imameev wrote:
> > > On 2026-03-03 20:05 UTC, Eduard Zingerman wrote:
> > >=20
> > > > > @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enu=
m bpf_access_type type,
> > > > >               }
> > > > >       }
> > > > >=20
> > > > > -     /*
> > > > > -      * If it's a pointer to void, it's the same as scalar from =
the verifier
> > > > > -      * safety POV. Either way, no futher pointer walking is all=
owed.
> > > > > -      */
> > > > > -     if (is_void_or_int_ptr(btf, t))
> > > > > +     if (is_ptr_treated_as_scalar(btf, t))
> > > > >               return true;
> > > >=20
> > > > I'm probably missing a point here, but what's wrong with Alexei's
> > > > suggestion to do this instead:
> > > >=20
> > > >         if (is_ptr_treated_as_scalar(btf, t))
> > > >                  return true;
> > > > ?
> >=20
> > Uh-oh, I copy-pasted the wrong snippet, sorry.
> > The correct snippet is:
> >=20
> >          if (btf_type_is_struct_ptr(btf, t))
> >                   return true;
> >=20
> > With it the selftests pass (except for `float` tests noted earlier).
> > And regardless of selftests, the code below this point will
> > error out if `t` is not a pointer to struct.
>=20
> I think you tested with
>=20
> 	if (!btf_type_is_struct_ptr(btf, t))
> 		return true;
>=20
> I decided on a narrower condition, as
>=20
> - if (!btf_type_is_struct_ptr(btf, t)) -

Yes, sorry again.

> changes the existing selection condition from "treat only these types
> as scalar" to "treat as scalar any type that is not a pointer to
> structure". Technically both approaches cover the problem I'm trying
> to solve - multilevel pointer support for structures, but the latter is
> open-ended and changes the current approach, which checks for pointers
> to int and void. So I'm extending this to int, void, enum 32/64,
> function, and corresponding multilevel pointers to these types and
> multilevel pointers to structures.

BTF is defined for the following non-modifier types:
- void        [allowed already]
- int         [allowed already]
- ptr         [multi-level pointers allowed by your patch]
- array       [disallowed?]
- struct      [single level pointers allowed already,
- union		   multi-level allowed by your patch]
- enum/enum64 [allowed by your patch]
- func_proto  [allowed by your patch]
- float       [disallowed]

And a few not reachable from function fields (I think BTF validation
checks that these can't be met, but would be good to double-check.
If it doesn't, it should):
- func
- var
- datasec

So, effectively you disallow reading from tracing context fields of
type: struct (non-pointer), array, float and a few types that can't be
specified for struct fields.

Does not seem necessary, tbh.

> It seems - if (!btf_type_is_struct_ptr(btf, t)) - works, but it's
> challenging to strictly prove it's sufficiently future-proof.
>=20
> > > This reflects my belief in a cautious approach: adding support
> > > only for selected types with tests added for each new type. That said=
,
> > > I can add the suggested broader condition and make it pass the tests,
> > but I cannot be sure it will be future-proof against conflicts.
> > >=20
> > > I think the broader check like
> > >=20
> > >       /* skip modifiers */
> > >       tt =3D t;
> > >       while (btf_type_is_modifier(tt))
> > >               tt =3D btf_type_by_id(btf, tt->type);
> > >       if (!btf_type_is_struct(tt))
> > >               return true;
> >=20
> > btf_type_is_struct_ptr() is almost identical to the snippet above.
> >=20
> > > might have some incompatibility with future changes, compared to
> > > explicit type checks for selected types. This condition is
> > > open-ended, including anything instead of selecting specific types.
> >=20
> > What potential incompatibility do you expect?
> > Two things change:
> > - types other then `struct foo *` or `int` can be read:
> >   - do you expect we would want to deny reading some ctx
> >     fields in the future?
> > - the value read is marked as scalar:
> >   - not much can be done with a scalar, except for leaking it to
> >     e.g. some map or ring buffer. Do you expect this to problematic?
> >=20
> > Note that the above are selected based on type, not on the
> > function/parameter combination, which is already not a very effective
> > filter if some parameters need to be hidden.
>=20
> I do not think any of these represent a real problem. As I said,
> my approach is based mostly on narrowing the supported types to
> reduce potential conflicts.
>=20
> I do not have a good example of such conflicts.
> The added tests for pointer to float, which failed with -
> if (!btf_type_is_struct_ptr(btf, t)) - might be an example when adding
> a new type might silently pass this check because of missing tests.

Yes, but that does not really matter if verifier treats floats as
unbound scalars.

> I  was not able to convince myself a conflict will not  happen.
>=20
> That said, changing
>=20
> 	if (is_ptr_treated_as_scalar(btf, t))
> 		return true;
>=20
> 	to
>=20
> 	if (!btf_type_is_struct_ptr(btf, t))
> 		return true;
>=20
> just makes the scope of these changes wider. This was
> my initial approach to this problem, but I was worried
> by its wide scope.

Let's see what Alexei would say, but I'd say there is no need to
complicate things w/o clear necessity.

