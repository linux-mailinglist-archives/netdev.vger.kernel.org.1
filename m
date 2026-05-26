Return-Path: <netdev+bounces-291691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOswHOucFWr9WgcAu9opvQ
	(envelope-from <netdev+bounces-291691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:15:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79E5D6332
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B16EF30652C1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D82D6E58;
	Tue, 26 May 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWnlT3L7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43708248F7C
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800895; cv=none; b=u+LmYlP/llWtXRtCvQeP5qHXLd5UKgIQxadDRE4cYVL4z9yeqjT4imGq3o+41Tv45ffSeQlmeCP1aJ3y7fhNdRvFQOb50dAES3uJEwJ81gbHWIDzKalAS254KNHPeQe7ozCKD3TpLCx3FNFuyegDcvRPcK8bP3aX5JzS7WV92qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800895; c=relaxed/simple;
	bh=/U2qww7yt1Wl8N6H8ivSsVd80lCCGCk1TDEpFLTb0AY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzkm7qKrPJjwPBNkOKikuLpK0IW99g4S7Vs7hTqPEHpLcO1tnDFO//LwyIuYnJv0SZ7JR0kKcNtSWxEdlaHREw3S6yFtaTcNLC+2CgrICGwRv4Tb5ikPPaA/lSQ7I4IICdXRqhhzO9lOw/zZdaI5SadQz1hTY22Zlc4KFFcM+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWnlT3L7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49068493267so14933465e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779800893; x=1780405693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQRRbRktni/kN8xPiqqslrIE1X5Ly2uPCl7+5+JDxjc=;
        b=WWnlT3L7m1lHqVqQB0up6ygt2bgyV2zS8mh791BCOUUXWr112O9Bguawo674SOoL1e
         lZke/yaR2lSqLqC2NdJZqxq2nfxl5CSpAIw7V96mPZg4fiH10UdQkNv+kewRwkDmIpE+
         V0XYm9dJFrbmSfEtZn+S5MURcjDNC1MhQEt9kZwgFtM9SKb5meCfPW2ckFbKvfvdhry7
         B+K1v+chQN5KZMm552WnCVtVa6EHL+93Bil7GJTgogSd9QNKE2JLpbQzxMRz3GQELZlQ
         MnmPv1A2NdM3giUxpr0UVStRfA7k6ohJ/hwafXdmr9cS/JvLS31GpU50rSbdwtMmzHqO
         8LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800893; x=1780405693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQRRbRktni/kN8xPiqqslrIE1X5Ly2uPCl7+5+JDxjc=;
        b=eaGfbREZ6JoL8xAzvA22yJiXyMFsGQptQWBCukVSiuk3NjpkAl0ln53Aha14G4CD6T
         SJRuVGSY6SM/ms8PSCdk3B2bYp7z2tljYcg4Qom9L8vDlR01NC2RZdKgj6Ws9zZCj1HN
         Icx6yZ5iG0opyViGFAmwJ8tuCkFLjrc+kJT3FFSN2EhYV6jGLPGSBFaif0ilUokHedPx
         TsX33ULwINrn2aK80T0xwdB5pGZo15Z7WjE2AEZTjqMkv8na1yrzXc0cM1hkmwpOGdli
         uEgYuoe5fv+rdlVWs1+ShEhqsV5cTyJQM6t9t+UDVraXnNXFgM85/WGb9x+XGDxou/Qz
         ZpUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZuMB7bYETMwQOyz9UB4yQBOP3gvIQPPF0M/L/PtpE89p55eTLwIL80FThs2pB9Is3z2aX/Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxJdSiopFriaHHjuPDBNEpnFh308dUgH2YeboWrVuV3wosFb/
	7dv+IVzt4NLskSh9LG8T1HLJg132RRtrIoB77DN5XmoouOP9lm3FDcOk
X-Gm-Gg: Acq92OH2C9V9TKxC7vv/WLw/KCd6+gS6c0YfIuzjwGj7wkEnL/JRUGbI8axOuqZJIc2
	zgyUffKMc22LBr/R77EcKgisy5H/y5jq1DlRYuArQvSIXxlwaeOTM6wb9lNqq5yUE1d82Lx/lA9
	zfmAmQdRjutrrvTiio6IyMPzua2udsjgVKMduzryL2eBkYkn4fHp2CwfVOTCQOa1rd2wbGnO3fj
	6JDqxHjWJVUEcr5uosv/1cIiw7itKbC1+ePpoqjm//Vk+jrENdglUidj2DMMVuSc18JyebEzg5V
	hvzfas/XiqvE9TtDhbEaZSzHxzdCoki8hAzKY95plpX+QbLcs0mRxGOQpLyJZAAQVopftK71O2c
	oA96Naums0TG2ktSCIaJlPjIBc5xRShfN/LKhMXWEBpW19ToidDXHhGWIcamvtIBVBMm2/mK2CL
	GWk1Q3PqEA+so/yFL5g6VcFRbgZBvRq71E7h9gwdUGT2RCIGMd590yPgLbwTN4r+DVdDkYbHHmG
	QE=
X-Received: by 2002:a05:600c:3496:b0:48e:6f39:f7be with SMTP id 5b1f17b1804b1-490424a683bmr324884685e9.10.1779800892313;
        Tue, 26 May 2026 06:08:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm342367955e9.9.2026.05.26.06.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:08:12 -0700 (PDT)
Date: Tue, 26 May 2026 14:08:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Rajat Gupta
 <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260526140810.0219955b@pumpkin>
In-Reply-To: <CAM0EoMmF-f1ofy9rgktKC+fvuyT8=2Q5sWpYLktfkWxwm=9Mng@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
	<20260521084640.683c1ee6@kernel.org>
	<CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
	<20260522084611.390fd0a6@kernel.org>
	<CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
	<CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
	<20260522175507.02b4fe83@kernel.org>
	<CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
	<CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
	<20260523094641.2bef6580@kernel.org>
	<CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
	<20260526104821.6eedb8ac@pumpkin>
	<CAM0EoMmF-f1ofy9rgktKC+fvuyT8=2Q5sWpYLktfkWxwm=9Mng@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291691-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC79E5D6332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 07:57:08 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Tue, May 26, 2026 at 5:48=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sat, 23 May 2026 12:57:08 -0400
> > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > =20
> > > On Sat, May 23, 2026 at 12:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.=
org> wrote: =20
> > > >
> > > > On Sat, 23 May 2026 08:13:21 -0400 Jamal Hadi Salim wrote: =20
> > > > > > > @@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struc=
t sk_buff *skb,
> > > > > > >                 }
> > > > > > >
> > > > > > >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> > > > > > > -               if (ptr =3D=3D &hdata)
> > > > > > > -                       skb_store_bits(skb, hoffset + offset,=
 ptr, 4);
> > > > > > >         }
> > > > > > >
> > > > > > >         goto done; =20
> > > > > >
> > > > > > I see you are trying to get rid of the skb_header_pointer() /
> > > > > > skb_store_bits() piece. Sure looks cleaner if we must linearize=
. =20
> > > > >
> > > > > The other thing (i may be over thinking) with pskb_may_pull is: i=
f the
> > > > > data is already linear (in a clone), wouldn't we corrupt the shar=
ed
> > > > > linear data of the clone? =20
> > > >
> > > > I said
> > > >
> > > >   for the portion of the problem that's "we are writing to frags"
> > > >
> > > > IOW not replacing the rest of the patch (assuming we care). =20
> > >
> > > So as an alternative to the piece i posted? i.e this:
> > >
> > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > index 79921b8d89ba..8f0f84b50c85 100644
> > > --- a/net/sched/act_pedit.c
> > > +++ b/net/sched/act_pedit.c
> > > @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_bu=
ff *skb,
> > >                 if (write_offset < 0) {
> > >                         if (skb_cow(skb, -write_offset))
> > >                                 goto bad;
> > > +                       if (write_offset + (int)sizeof(hdata) > 0) {
> > > +                               if (skb_ensure_writable(skb,
> > > +                                               min_t(int, skb->len,
> > > +                                                     write_offset +
> > > (int)sizeof(hdata)))) =20
> >
> > I don't think that needs to be min_t(), a plain min() will do.
> > (Possibly with the (int) cast removed from the sizeof.)
> > =20
>=20
> what is the benefit? would min() allow a mixed type (eg skb_len not being=
 int)?

min_t() is really a broken idea.
You wouldn't really write:
	if ((int)skb->len < (int)(write_offset + (int)sizeof(hdata)))
which it what it effectively expands to.
IMHO it was always better to cast the one side that was 'wrong'.
Then there wouldn't be all the broken/pointless max_t(u8, x, 255).

Here min(skb->len, write_offset + (int)sizeof(hdata)) is actually likely to
be allowed even though they types are unsigned and signed because the
compiler knows the preceding 'if' stops negative values getting through.
(Sometimes the KASAN (etc) builds (randomly) error such cases.)

But min(skb->len, write_offset + sizeof(hdata)) will always be fine.
Both sides are unsigned, a negative 32bit write_offset is sign extended
to 64bits before being converted to unsigned (as 2s compliment) and the
sum is positive.
But the compiler might not do CSE with the previous condition.

-- David

>=20
> cheers,
> jamal
>=20
> > -- David
> > =20
> > > +                                       goto bad;
> > > +                       }
> > >                 } else {
> > >                         if (unlikely(check_add_overflow(write_offset,
> > >                                                         (int)sizeof(h=
data),
> > >
> > > cheers,
> > > jamal
> > > =20
> > =20


