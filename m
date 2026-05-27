Return-Path: <netdev+bounces-292368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 41OAL1oaF2rV4wcAu9opvQ
	(envelope-from <netdev+bounces-292368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:22:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C05E7B3B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFF623024286
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2B1426D19;
	Wed, 27 May 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPXduZJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536E42B74A
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898400; cv=none; b=VqLHTYXq+juoiKGzw371NMei8E+AY9Osb0SW3YV7UAdvBHv7f5uB5lX2gVEfHO0YnSNrSP6SnfH6eAqlazFL7UXEG/xA2kE6ZeV3rhJ0YXgujbTmiXdkfPlcA5SUIv791i22d9yHoUXyYcZ+hrOE+69/RKoYF0QPhtQlwZOpC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898400; c=relaxed/simple;
	bh=0RJh0S8l5yIgnyegYNtR3CavG8N99KUxlqvuNYBFCS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpVCvRpspDVKGI2P5m7Hz4BqbX0UWIpyJmb4YE8Hjt9ETUgEZ8cfEy6/F4eunP12fL4HXwBhM58PZ79szDcekOQy9VlT8/5r7WeV5oNZ6HcZ8VXglGn9fkfuIVCqHh3FpqjyiGjUnsp1sOOfHdtssUW8hDlWqz32MJ09axfK5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPXduZJ8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso56574265e9.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779898393; x=1780503193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igoUmofFPc+XYuWpnSdFf7iBLvvTLIfNw8ud4q4N9Jk=;
        b=aPXduZJ85pyu17YhfNmIVL7U7DKgC3hZhZyAjhrBHTnhUrFw0db9OYDmtS+ynphlIs
         Mvk33RgqSRD1LyFz7QZtue5+VJFsRQI8VmLsuNssC7iVnypQwN4HrtSCtAWGMSucNJcY
         pa3m4riwfMULSgtiiBGu9l5oVD5EP/8Xd5/YbaEXYuMnJOwEjuI5cxbySy4EeBSQNcnt
         Q9oYr+8HyOsAYzTAvV4+Hj9TVtQ6Uv6GpF/qSAsJjt6MHf5tfXjf8DqMyV6O/Wh68j7H
         MvKk4sfWX5tVYWjtlB4UGi+my/jgI0WUR06HWhJ5vKUb5HkeT7wL0RfFkG7p5zqaOLBf
         pPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898393; x=1780503193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igoUmofFPc+XYuWpnSdFf7iBLvvTLIfNw8ud4q4N9Jk=;
        b=O9ayr6tjJRnVz6/k3hr5ov1EUm03cRWL5ymStP1aGxnt+cCMkG3llAiNzS0h3aIBcI
         OBN2ypr5CQTJwdMJebCrQy82sXDlMvqmyiNGTQzfpbu3BJMe7/Fz+OX38+QyaowHgYNU
         2yHH7ryihtifQtuSo7ex51EKu05VD3fHmKsCIfCJJ0IlIUir9M8md+xiETkadY9Wzzeb
         W9ESBDMsMzT026Tm33f6biNTlOR9LqlXYvQZMp52b0cy9dzfwhMs34Hjfa5DCCg2ytcz
         AmXvAz0Suw6647180Ki6RnsaJ2b3PI+pbV4DF00ttEHQTYRa4MTR0RIAXcbT1AaparIj
         khhw==
X-Forwarded-Encrypted: i=1; AFNElJ9/a4z5L6poWqa4yL+8ioJXOe8NsEmFAtX/6UKp5gBTlFMHMt5ekfXnygok1MnRvppgPBSGGVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOQk7dpaky2z6uRLfX+hsDycNMdQQ1sYe09c6EokoKPf5Vrmk
	9F8zQEiHqBdAbonGPLzEX8e+ypx+Dzcs/UzYGSXMucYEcUeLOCz+CdXh
X-Gm-Gg: Acq92OECAS0NbwYnsoUTL2nTw639NJaSxCPioNEMisWpXn0i1JhFkTwL3hu5qASxtBI
	2MYCREpaPKGSNo0BWLLUhRh8cLpp4MFiYH47o80GTYond+zYS2H/lnLwe4rMjVskNiRVKHTIvjn
	DKYbJmtF13PtFjhZ7cfjaZYSuzh63EEICi53TKDZJqwEdPFtO6DF6VV8LBL4klz9BjKB/pcRUHk
	pDosNM/lJ/nHynWVC3mQKlibP8r/4J+4GOo8DDHerb2aUTZpgOQHchi1wjul9albLTeLdKwzqKV
	aT8wNesyE6acKK4TzHRmmqmosYr4ykPlmG8gIkCVnxXI5QjTDKvP/km0UCQuvvH43Lf9RA/QVhG
	QzUs+iUlYlymroSCsU0hIvu2+TGQTjLJmBxhp+HjcYpbVonMs1m9AQdz60Z+aWLiBUUlVY1SGzX
	PA+EOvZvsxF5ArbzBIsQtSyWVVpvMA6TKks19oscWM6aSFwadBlZiTEMTDth03c12yViPx1/8UV
	+Q=
X-Received: by 2002:a05:600c:3b02:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-490424b3938mr408178225e9.10.1779898392535;
        Wed, 27 May 2026 09:13:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490809c785asm20103535e9.32.2026.05.27.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:13:12 -0700 (PDT)
Date: Wed, 27 May 2026 17:13:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com,
 2045gemini@gmail.com, rollkingzzc@gmail.com, dcaratti@redhat.com,
 security@kernel.org, linux-kernel@vger.kernel.org, Rajat Gupta
 <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
Message-ID: <20260527171310.0d5ed340@pumpkin>
In-Reply-To: <CAM0EoMm_FcS0xSNmCjdXaRMfZh12jU71xM92Z50eVE8uk7tKFQ@mail.gmail.com>
References: <20260526155913.1060694-1-jhs@mojatatu.com>
	<87wlwq2cxf.fsf@toke.dk>
	<CAM0EoMm_FcS0xSNmCjdXaRMfZh12jU71xM92Z50eVE8uk7tKFQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292368-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Queue-Id: BF1C05E7B3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 10:56:57 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

>  &&
>=20
> On Tue, May 26, 2026 at 3:22=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
> >
> > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> > =20
> > > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > >
> > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > not account for the runtime header offset added by typed keys. This
> > > can leave part of the write region un-COW'd.
> > >
> > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > the actual write offset is known, and add overflow checking on the
> > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > offset_valid() against INT_MIN, where negation is undefined.
> > >
> > > Additionally, linearize skbs with shared frags upfront to prevent
> > > silent data corruption when pedit operates on zero-copy pages
> > > (e.g. from sendfile).
> > >
> > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is =
writable")
> > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > > Reported-by: Han Guidong <2045gemini@gmail.com>
> > > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com> =20
> >
> > Re-ran the tests, and everything looks good, so:
> >
> > Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >
> > Also looked at the code, and I have a few nits below, but I'm really
> > nitpicking here, so whether you end up fixing those or not:
> >
> > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >
> >
> > [...]
> > =20
> > > @@ -323,7 +324,7 @@ static bool offset_valid(struct sk_buff *skb, int=
 offset)
> > >       if (offset > 0 && offset > skb->len)
> > >               return false;
> > >
> > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > +     if (offset < 0 && offset < -(int)skb_headroom(skb))
> > >               return false; =20
> >
> > This change makes it really obvious that this is really just:
> >
> >         if (offset < -(int)skb_headroom(skb))
> >                 return false;
> >
> > so, well, that would be clearer, IMO.
> >
> > But then I guess the same could be said of the positive case, so:
> >
> > static bool offset_valid(struct sk_buff *skb, int offset)
> > {
> >         if (offset > skb->len || offset < -(int)skb_headroom(skb))
> >                 return false;
> >
> >         return true;
> > }
> > =20
>=20
> Yes, that improves readability. If i understood the discussion between
> you and David L. something like this one liner would be reasonable?
>=20
> if (offset > (int)skb->len || offset < -(int)skb_headroom(skb))

I doubt it will be measurable whatever you pick.

Thinks, can 'we' get away with the much more readable:
	offset + (int)skb_headroom(skb) < 0
No need to worry about the '+' wrapping, the first test will fail.
Large -ve offset are going to stay negative.
So it does look all right.

>=20
>=20
> > > @@ -393,18 +394,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >       struct tcf_pedit_key_ex *tkey_ex;
> > >       struct tcf_pedit_parms *parms;
> > >       struct tc_pedit_key *tkey;
> > > -     u32 max_offset;
> > >       int i;
> > >
> > >       parms =3D rcu_dereference_bh(p->parms);
> > >
> > > -     max_offset =3D (skb_transport_header_was_set(skb) ?
> > > -                   skb_transport_offset(skb) :
> > > -                   skb_network_offset(skb)) +
> > > -                  parms->tcfp_off_max_hint;
> > > -     if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > > -             goto done;
> > > -
> > >       tcf_lastuse_update(&p->tcf_tm);
> > >       tcf_action_update_bstats(&p->common, skb);
> > >
> > > @@ -412,9 +405,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_bu=
ff *skb,
> > >       tkey_ex =3D parms->tcfp_keys_ex;
> > >
> > >       for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > > +             int write_offset, write_len;
> > >               int offset =3D tkey->off;
> > >               int hoffset =3D 0;
> > > -             u32 *ptr, hdata;
> > > +             u32 *ptr;
> > >               u32 val;
> > >               int rc;
> > >
> > > @@ -451,15 +445,38 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >                       }
> > >               }
> > >
> > > -             if (!offset_valid(skb, hoffset + offset)) {
> > > -                     pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n", hoffset + offset);
> > > +             if (unlikely(check_add_overflow(hoffset, offset, =20
> >
> > It's a bit weird that this has the unlikely(), but the offset_valid()
> > check doesn't?
> > =20
>=20
> I focused on the bigger solution and worried more about timeliness to
> get this patch in - but it seems the distros had already picked up the
> first posted patch, so hakuna matata (Still, I should have caught
> these unlikelies ;->). Yes on the second one you pointed out.
> Will remove them.
>=20
> > > +                                             &write_offset))) {
> > > +                     pr_info_ratelimited("tc action pedit offset ove=
rflow\n");
> > >                       goto bad;
> > >               }
> > >
> > > -             ptr =3D skb_header_pointer(skb, hoffset + offset,
> > > -                                      sizeof(hdata), &hdata);
> > > -             if (!ptr)
> > > +             if (!offset_valid(skb, write_offset)) {
> > > +                     pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n",
> > > +                                         write_offset);
> > >                       goto bad;
> > > +             }
> > > +
> > > +             if (write_offset < 0) {
> > > +                     if (skb_cow(skb, -write_offset))
> > > +                             goto bad;
> > > +                     if (write_offset + (int)sizeof(*ptr) > 0) {
> > > +                             if (skb_ensure_writable(skb,
> > > +                                                     min(skb->len,
> > > +                                                         write_offse=
t + sizeof(*ptr)))) =20
> >
> > Combining these with && instead of the double indentation would be more
> > readable IMO (shorter lines, aligning the 'goto bad' labels). =20
>=20
> hrm. So:
> if ((write_offset < 0 && ((skb_cow(skb, -write_offset)) &&
> (write_offset + (int)sizeof(*ptr) > 0) &&
> (skb_ensure_writable(skb,min(skb->len,write_offset + sizeof(*ptr)))) {
>             goto bad;
> else {
>   ...
> }
>=20
> Not sure which is more readable.

I think he meant just the last two 'if'.

-- David

>=20
> cheers,
> jamal
> > =20
> > > +                                     goto bad;
> > > +                     }
> > > +             } else {
> > > +                     if (unlikely(check_add_overflow(write_offset,
> > > +                                                     (int)sizeof(*pt=
r),
> > > +                                                     &write_len))) =
=20
> >
> > Same comment wrt unlikely()
> > =20


