Return-Path: <netdev+bounces-263449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFJcAwVkp2mvhAAAu9opvQ
	(envelope-from <netdev+bounces-263449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:43:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA611F81C2
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952D0304D97A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F3338F942;
	Tue,  3 Mar 2026 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/GOrEKL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41938C40F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577790; cv=none; b=YYv3OXddhxkuGNTKtubRzpxHcAfJc5Z8v9yvS0N4urZ/f/Mf/m3WLYmiv4Pco5zj1nMk4tbRAlstlqXKxRH9kEP91E9dZz1pIvs3pwVKkaEeamrn6OjGDApMNmHVMaJQH9CJYAm/3oO2WIZiCg5vCBcNWFARjYIKx3snL+jWz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577790; c=relaxed/simple;
	bh=iRzTm4HZX6p9XF+OOGdafL6UcWV2KOdLvI4VUy9DbI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ft+dBMPnvL3CGbM5f63i8Wt9iwFhMlp1321E5Rx8AG3KvU9cXGGcBjARFZwcdNMWVikT7dwOeppafxtUZ6YIVyLqz6XW+44JJjYmygTHXnoifhKIG+OnWhDQANyksl0aK7PTZMKgFyEWAf2xp8Sa9raVIwgibxQc2qHWr/5urFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/GOrEKL; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3607180eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 14:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772577785; x=1773182585; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+g++eAKNPgksF/0EobVZq+2vjzSAkpXPfK7PhSs7l5I=;
        b=Z/GOrEKLhYYDcpMAgAX0nCKHVWMfEjkVH/gJtOLCBuGGgzv3r+MncZE1SfOdwxqSf8
         EhgCwi0+A1/H7T2wsrypWCA+9357xB7UtkByf8WoKwLKvXTjRatSjqdFnZq6sBtqVHtV
         1AJHElA8+dtaHZV4+ch9/d8e0+69WhEndwymNikyv4T7PYinjw/v2db8xJ179zAMad/6
         aUJJWwl42oq99wsSFmtLzfbnKmlh+2rD12cI6LlqdCWHbbOxVAXs2x9Z8orPKXhX3L+r
         00ewyXgVSeO2XeOrS0P5yItlRt95mQ6bZWr1iRSv+voL2Q5ZjvA+ZG/Y5TRjw9NL65+6
         Rkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577785; x=1773182585;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g++eAKNPgksF/0EobVZq+2vjzSAkpXPfK7PhSs7l5I=;
        b=sXYXPy+YpegOnhHPOdHWY6CUopadcSCofgkhB7Qfi/AzjdfN33aq3zU7W5uWN5Al5h
         RNndvdPMBjRFwUAgvGlAUtrdrMT3vSHe5sLSUuClilcH1vLTsEZnlib5LMxb4dHEhCBY
         rtUiKztGKxu7F6JUj2xGboPkOpfP+rQRk3X0JJtwSP0aRhuyG0MZXi/LJLLKUjwSeGiS
         EJfthuUrG+3DEcCf5mnPv+QoYp4YtioUU4GDeksm1a7xRGJKMwejc7qkjewZaPhi4IoR
         uR4XdumZJWnALC+2itF0s5MGUWx2+ejOF9heS1/HoNphIGy0E/gQHmrhBiV+186vjYZX
         rB5g==
X-Forwarded-Encrypted: i=1; AJvYcCVSkQuvaJFIL+9fblQ9GUvhDmK0+I6GfFd3UwHrLvlU5ITLrlV33xxdIKdmL9o0pDKoF4BCnTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQLcqKWa+RNWd1NmsdKKAqIRDeJ4OrZaDl50YQsQ43OE6myBe
	XpBS1RiXcKU/72AUAUXKcLS/hWMj72o/KXTuDNItGLPPIFaQaX7KG/WnZQ98H2Qt
X-Gm-Gg: ATEYQzz4G/8I4/cIiMUKpV/oYMwApm20o3Q+2HASerO8XITTsRC4ofeYWjLrwbY+URF
	bHOJu4SrIC/pk9I3XA3Om2HFbWAC4xVljTx5XCD53FLX34d2+7rK0gib+ziKAyKa3haeqBBYLr8
	BQxU1VvihxBr45PXX1WalxvT5tOSyOdqLaEAK90PVvuJj0nyLLfGj2nI0V6+Amue8coI6+pq/7b
	OalDSlR+4PPLbckyNfcEy/Wpv5Kc1OeeVIEgDPkq4FKYjaPnk+ltspt4/50fQsqaaSSxpcugxaj
	ljNX7uXLX8c2Wi4pUjK69QL7pO06fPvdyNUpSq8fQdsbdgAa9fYTzPLjXMFZNYPZdkztLvnFUWv
	RztUkeC/OJDRMB1oj2k9YIc49//zBiDbPgMnEOq8CUp9RGaBYfY/SxmcLS071b6/v9TTs8i0Iis
	hxEiPXosj7fPxvyZkfDy/Rhwb9/KnHYf0fNsJiKjKO87r8KxL6uQHa1K5H0QGKR63cVs+EyZxXz
	uPLbbwh
X-Received: by 2002:a05:7300:dc83:b0:2b7:bc31:11ff with SMTP id 5a478bee46e88-2be2345bc93mr1332769eec.8.1772577784573;
        Tue, 03 Mar 2026 14:43:04 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfba0df2fsm10054683eec.7.2026.03.03.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:43:03 -0800 (PST)
Message-ID: <84c687e56ed8f04f3f318f090272fb5ef7520e96.camel@gmail.com>
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
Date: Tue, 03 Mar 2026 14:43:01 -0800
In-Reply-To: <20260303214929.8208-1-slava.imameev@crowdstrike.com>
References: <c40dd219ea60f810d52576f998e68cc0d731f761.camel@gmail.com>
	 <20260303214929.8208-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5FA611F81C2
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
	TAGGED_FROM(0.00)[bounces-263449-lists,netdev=lfdr.de];
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

On Wed, 2026-03-04 at 08:49 +1100, Slava Imameev wrote:
> On 2026-03-03 20:05 UTC, Eduard Zingerman wrote:
>=20
> > > @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enum bp=
f_access_type type,
> > >               }
> > >       }
> > >=20
> > > -     /*
> > > -      * If it's a pointer to void, it's the same as scalar from the =
verifier
> > > -      * safety POV. Either way, no futher pointer walking is allowed=
.
> > > -      */
> > > -     if (is_void_or_int_ptr(btf, t))
> > > +     if (is_ptr_treated_as_scalar(btf, t))
> > >               return true;
> >=20
> > I'm probably missing a point here, but what's wrong with Alexei's
> > suggestion to do this instead:
> >=20
> >         if (is_ptr_treated_as_scalar(btf, t))
> >                  return true;
> > ?

Uh-oh, I copy-pasted the wrong snippet, sorry.
The correct snippet is:

         if (btf_type_is_struct_ptr(btf, t))
                  return true;

With it the selftests pass (except for `float` tests noted earlier).
And regardless of selftests, the code below this point will
error out if `t` is not a pointer to struct.

> This reflects my belief in a cautious approach: adding support
> only for selected types with tests added for each new type. That said,
> I can add the suggested broader condition and make it pass the tests,
> but I cannot be sure it will be future-proof against conflicts.
>=20
> I think the broader check like
>=20
> 	/* skip modifiers */
> 	tt =3D t;
> 	while (btf_type_is_modifier(tt))
> 		tt =3D btf_type_by_id(btf, tt->type);
> 	if (!btf_type_is_struct(tt))
> 		return true;

btf_type_is_struct_ptr() is almost identical to the snippet above.

> might have some incompatibility with future changes, compared to
> explicit type checks for selected types. This condition is
> open-ended, including anything instead of selecting specific types.

What potential incompatibility do you expect?
Two things change:
- types other then `struct foo *` or `int` can be read:
  - do you expect we would want to deny reading some ctx
    fields in the future?
- the value read is marked as scalar:
  - not much can be done with a scalar, except for leaking it to
    e.g. some map or ring buffer. Do you expect this to problematic?

Note that the above are selected based on type, not on the
function/parameter combination, which is already not a very effective
filter if some parameters need to be hidden.

> This broader check also needs to be moved down closer to the exit
> from btf_ctx_access; otherwise, btf_ctx_access can exit early
> without executing the following code. In my case, this resulted in
> existing test failures if the above !btf_type_is_struct(tt) replaces
> current master's branch condition
>=20
> 	if (is_void_or_int_ptr(btf, t))
> 		return true;
>=20
> The result for:=20
>=20
> ./vmtest.sh -- ./test_progs
>=20
> was:
>=20
> 	Summary: 617/5770 PASSED, 80 SKIPPED, 82 FAILED
>=20
> with a lot of:
>=20
> 	unexpected_load_success
>=20
> Compared to:
>=20
> 	Summary: 692/6045 PASSED, 80 SKIPPED, 7 FAILED
>=20
> for the master branch.
>=20
> As I noted this diff, closer to the exit from btf_ctx_access,
> makes tests to pass:
>=20
>         if (!btf_type_is_struct(t)) {
> -               bpf_log(log,
> -                       "func '%s' arg%d type %s is not a struct\n",
> -                       tname, arg, btf_type_str(t));
> -               return false;
> +               info->reg_type =3D SCALAR_VALUE;
> +               return true;
>         }
>=20
>=20
> > Only two new tests fail:
> > - #554/62  verifier_ctx_ptr_param/fentry/pointer to float - invalid ctx=
 access:FAIL
> > - #554/63  verifier_ctx_ptr_param/fentry/double pointer to float - inva=
lid ctx access:FAIL
>=20
> > But I'd say this shouldn't matter.
> > This will also make selftests much simpler.
>=20
> Yes, I decided not to add support for pointers to float.

