Return-Path: <netdev+bounces-293467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEHRBiqBHGpFOwkAu9opvQ
	(envelope-from <netdev+bounces-293467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:42:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76106617876
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 20:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4E7B300AEDB
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749F328611;
	Sun, 31 May 2026 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwZCoq1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329731B838
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780252967; cv=none; b=f5Sht43/czVLNeZGINyuPkVvsqiVPjfKWi7uJ5iHiFbSbghObEvZ8RN4J08wb7HMFyFrNf690z0bq8xkIWMoatw/rtpRJSJsODCGaWPfoDbfQbk76tPkVejBUE1hMA9d3zaTKGex2pdaeAK9SK6x+xjeduNwBVoyRpRrX6QCIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780252967; c=relaxed/simple;
	bh=CNzpiRhpfuPzcKEUIwnY4kkFQqLMVOHm9Ne5aNy1g1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0YndUABxcRZqCuN9VJc+0aN0m/6XUToA9j60IdJSz1Xb7FKen2ECtfBgRsdSTK/ni3sUyD2XrfNHd/M623p3GKVmkNfpMlaeuECEf3/EQKNdlSUeIOZxWGk9ndZqLcrCIsAiXrqF7E7o/YoA4WOAvdvWCwuEtjKDjendDjECdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwZCoq1Z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490426d72f7so82555795e9.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780252963; x=1780857763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2SlFFo6diRYYfxsx0kAwufOP2L3yUPuj6mjAbPBnSw=;
        b=QwZCoq1ZbQYEJZDvXfUfsO39Ti0VRMaQtjQTa27hfcVJDREZUyiLliya8td8f4RAu1
         /HFGq50HmyxE63KBSo6PyoEE9hsAS0FKTlYsCgxH/AnCZGtBubggVuvzZp1hTO1sB3Ij
         ko4HcjMNbRoJ9+gHYI3F7b9/k8H8jP5/gHbxTEqxmsJwfc8Ifl7XwfgeDmSQyGKtTI+/
         L1MxUkeqZ56iUGxR1jDmz0t0hIp8HPQlqhUvSIeF6D7OvmvrMZyMIrHsivYSugaDOGVG
         p6fnz5TTjc/gakxB/9kH7NZNGZnlWHJHavTt04kMEtFlAe8vYW+AwzJBXuQ2Kkput3xy
         lrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252963; x=1780857763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x2SlFFo6diRYYfxsx0kAwufOP2L3yUPuj6mjAbPBnSw=;
        b=O/FkmSaQC59QbV0ZoJ+QdWjOt61mdMNUoTTSlY1qqpsi7CysntPjoy+KUYUgDsFMak
         3T3+rA77tyaX5hepOhuG383BPNhSzju38BG6Im1RC4Tt3n1tYmoG+6/BKSfUp8bQ4xuP
         0PzjzBn1n7JpPXvTTj4Ydfta8OsSfzg3MlaFedqui9ZunrQj0E8j6I9KJDO9D/jq7vTQ
         X2nfW9pmi97bLVQfasOh1FZoAt4ZHZQh8wnDunUvmMkxwR2Y8WcDHoAqU4We58Oo1pKM
         3/sU0EHvUGeJeDtTA6LLOfts++HoVyJyFHp/OdZBZxks0IRPN9f/mYPXocjGUh6HfgZG
         ytuw==
X-Gm-Message-State: AOJu0YyooTTqXwwJQSqEYNggXThchIIVbPMZqgxXY0HPW/mbwen0WfGv
	P7MxBx+u1jjmz7yOa7ksNOqBYGGGDh2vkw7BB9s3lM6+dsMrxV5di/3I
X-Gm-Gg: Acq92OEziccg7sik+uYcvKIxwwKAS/32yOZmskT6LXehpW4rm0jAwixwvbaSL75cKJd
	KJQEXFczvsFtkT7isHm9zZdzMZo4V8qoeHbz7jx+8+2aV47utcrSwcN/juzCkkxHRd2C71IIDVP
	/uaS7NC9g4BJLHHZyAoC7ir8nv/5bD+rOHTyEJIhp/hUnr6fcrVJ08RkfABCyI9usprTEKEsJqB
	2ajykgz/9lywST/H9njesJj5sBzlSxLwbGLr0lyb/o/A4AYvhVWLAuypOWi5CiiKePBNueT37p9
	ANqt4m61f5yFOwDuMRfdoGuWKZi+NdQ8/zHNqUVwbH4RQ/+veJNlFLAig5RroODzVQtEzFVOhD9
	wAEIgpvt9IaHZVU+QOFZeCpnDA6gxE8t9YwDlQAkygsAxeOcvac41FLM+hY1MZ3GABVvSDpoeIQ
	srTN0+t2X90yEU3inqJKD3ZhFg85jGoNO3HmL86wLtG45iwf07XtDKvvxuf7S5Ut0NSuQj8VY=
X-Received: by 2002:a05:600d:848c:10b0:490:a1a9:4ffe with SMTP id 5b1f17b1804b1-490a291197bmr105662405e9.12.1780252963189;
        Sun, 31 May 2026 11:42:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c3081sm19799463f8f.15.2026.05.31.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:42:42 -0700 (PDT)
Date: Sun, 31 May 2026 19:42:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com,
 2045gemini@gmail.com, rollkingzzc@gmail.com, toke@redhat.com,
 dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
Message-ID: <20260531194241.7d5d7e6e@pumpkin>
In-Reply-To: <CAM0EoMnKxEuexh43U7v8s3UwNfr5B=jXUQxw_fCw_tB-Li39cA@mail.gmail.com>
References: <20260531123221.48732-1-jhs@mojatatu.com>
	<20260531171534.6aae381a@pumpkin>
	<CAM0EoMnKxEuexh43U7v8s3UwNfr5B=jXUQxw_fCw_tB-Li39cA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293467-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Queue-Id: 76106617876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 31 May 2026 13:25:36 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Sun, May 31, 2026 at 12:15=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun, 31 May 2026 08:32:21 -0400
> > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
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
> > > offset_valid() against INT_MIN, where negation is undefined. =20
> >
> > This code has all got out of hand somewhere.
> > I've only been looking at offset_valid() code.
> > =20
> > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is =
writable")
> > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > > Reported-by: Han Guidong <2045gemini@gmail.com>
> > > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > > Reviewed-by: Han Guidong <2045gemini@gmail.com>
> > > Tested-by: Han Guidong <2045gemini@gmail.com>
> > > Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> > > Tested-by: Davide Caratti <dcaratti@redhat.com>
> > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > ---
> > > v4->v5:
> > >  1) Dead code removal obsoleted after removing tcfp_off_max_hint as i=
dentified
> > >     by sashiko-claude[1]. Remove dead code updating "cur".
> > >  2) Addition of hoffset at tkey->at promotes hoffset to unsigned int,
> > >     wraps on overflow. Claim made by both sashiko-claude[1] and sashi=
ko-gemini[2]
> > >     I think this is far fetched but possible. Cast tkey->at to int.
> > >  3) Signedness mismatch in min() macro may potentially cause build is=
sues.
> > >     Claim made by both sashiko-claude[1] and sashiko-gemini[2].
> > >     Go back to min_t() for now. David L. can make a better proposal l=
ater..
> > >
> > > [1]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260530080643=
.1345521-1-jhs%40mojatatu.com
> > > [2]https://sashiko.dev/#/patchset/20260530080643.1345521-1-jhs%40moja=
tatu.com
> > > ---
> > >  include/net/tc_act/tc_pedit.h |  1 -
> > >  net/sched/act_pedit.c         | 77 +++++++++++++++++++--------------=
--
> > >  2 files changed, 41 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pe=
dit.h
> > > index f58ee15cd858..cb7b82f2cbc7 100644
> > > --- a/include/net/tc_act/tc_pedit.h
> > > +++ b/include/net/tc_act/tc_pedit.h
> > > @@ -15,7 +15,6 @@ struct tcf_pedit_parms {
> > >       struct tc_pedit_key     *tcfp_keys;
> > >       struct tcf_pedit_key_ex *tcfp_keys_ex;
> > >       int action;
> > > -     u32 tcfp_off_max_hint;
> > >       unsigned char tcfp_nkeys;
> > >       unsigned char tcfp_flags;
> > >       struct rcu_head rcu;
> > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > index bc20f08a2789..bd3b1da3cd63 100644
> > > --- a/net/sched/act_pedit.c
> > > +++ b/net/sched/act_pedit.c
> > > @@ -16,6 +16,8 @@
> > >  #include <linux/ip.h>
> > >  #include <linux/ipv6.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/overflow.h>
> > > +#include <linux/unaligned.h>
> > >  #include <net/ipv6.h>
> > >  #include <net/netlink.h>
> > >  #include <net/pkt_sched.h>
> > > @@ -242,7 +244,6 @@ static int tcf_pedit_init(struct net *net, struct=
 nlattr *nla,
> > >               goto out_free_ex;
> > >       }
> > >
> > > -     nparms->tcfp_off_max_hint =3D 0;
> > >       nparms->tcfp_flags =3D parm->flags;
> > >       nparms->tcfp_nkeys =3D parm->nkeys;
> > >
> > > @@ -268,14 +269,6 @@ static int tcf_pedit_init(struct net *net, struc=
t nlattr *nla,
> > >                                                  BITS_PER_TYPE(int) -=
 1,
> > >                                                  nparms->tcfp_keys[i]=
.shift);
> > >
> > > -             /* The AT option can read a single byte, we can bound t=
he actual
> > > -              * value with uchar max.
> > > -              */
> > > -             cur +=3D (0xff & offmask) >> nparms->tcfp_keys[i].shift;
> > > -
> > > -             /* Each key touches 4 bytes starting from the computed =
offset */
> > > -             nparms->tcfp_off_max_hint =3D
> > > -                     max(nparms->tcfp_off_max_hint, cur + 4);
> > >       }
> > >
> > >       p =3D to_pedit(*a);
> > > @@ -318,15 +311,12 @@ static void tcf_pedit_cleanup(struct tc_action =
*a)
> > >               call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
> > >  }
> > >
> > > -static bool offset_valid(struct sk_buff *skb, int offset)
> > > +static bool offset_valid(struct sk_buff *skb, int offset, int len)
> > >  {
> > > -     if (offset > 0 && offset > skb->len)
> > > -             return false;
> > > -
> > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > +     if (offset < -(int)skb_headroom(skb))
> > >               return false;
> > >
> > > -     return true;
> > > +     return offset <=3D (int)skb->len - len;
> > >  }
> > >
> > >  static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, co=
nst int header_type)
> > > @@ -393,18 +383,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
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
> > > @@ -412,10 +394,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >       tkey_ex =3D parms->tcfp_keys_ex;
> > >
> > >       for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> > > +             int write_offset, write_len;
> > >               int offset =3D tkey->off;
> > >               int hoffset =3D 0;
> > > -             u32 *ptr, hdata;
> > > -             u32 val;
> > > +             u32 cur_val, val;
> > > +             u32 *ptr;
> > >               int rc;
> > >
> > >               if (tkey_ex) {
> > > @@ -433,13 +416,15 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >
> > >               if (tkey->offmask) {
> > >                       u8 *d, _d;
> > > +                     int at_offset;
> > >
> > > -                     if (!offset_valid(skb, hoffset + tkey->at)) {
> > > +                     if (check_add_overflow(hoffset, (int)tkey->at, =
&at_offset) || =20
> >
> > There is no real reason for checking the add.
> > All that matters is that offset_valid() and skb_header_pointer() are
> > passed the same offset.
> > Assigning it to a local would make that clearer. =20
>=20
> You are technically correct - but earlier discussion was I believe
> that signed integer overflow as undefined behavior and those checks
> are there to avoid that and logic bypasses.

The kernel is compiled with -Wno-strict-overflow so that integers wrap
the way you might expect (and hope).
A lot of code relies on that.
So not only is signed integer overflow going to wrap (rather than saturate,
fault, add 0 (a cobol interpreter I once used did that - annoying to debug),
return a random value) the compiler is also not allowed to assume it doesn't
wrap.

If you are feeling really pedantic:
	at_offset =3D hoffeset + key->at; OPTIMZER_HIDE_VAR(at_offset);
will ensure that the value that is tested is the value that is used.

>=20
> > =20
> > > +                         !offset_valid(skb, at_offset, sizeof(_d))) {
> > >                               pr_info_ratelimited("tc action pedit 'a=
t' offset %d out of bounds\n",
> > >                                                   hoffset + tkey->at);
> > >                               goto bad;
> > >                       }
> > > -                     d =3D skb_header_pointer(skb, hoffset + tkey->a=
t,
> > > +                     d =3D skb_header_pointer(skb, at_offset,
> > >                                              sizeof(_d), &_d);
> > >                       if (!d)
> > >                               goto bad;
> > > @@ -451,31 +436,51 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_b=
uff *skb,
> > >                       }
> > >               }
> > >
> > > -             if (!offset_valid(skb, hoffset + offset)) {
> > > -                     pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n", hoffset + offset);
> > > +             if (check_add_overflow(hoffset, offset, &write_offset))=
 {
> > > +                     pr_info_ratelimited("tc action pedit offset ove=
rflow\n");
> > >                       goto bad;
> > >               }
> > >
> > > -             ptr =3D skb_header_pointer(skb, hoffset + offset,
> > > -                                      sizeof(hdata), &hdata);
> > > -             if (!ptr)
> > > +             if (!offset_valid(skb, write_offset, sizeof(*ptr))) {
> > > +                     pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n",
> > > +                                         write_offset);
> > >                       goto bad;
> > > +             } =20
> >
> > Again all that matters is that the same value is passed to offset_valid=
()
> > and skb_header_pointer(). =20
>=20
> Same comment as earlier.
> Note: we replaced skb_header_pointer() with direct memory access "ptr
> =3D (u32 *)(skb->data + write_offset)" further down.
> so extra validation of write_offset is justifiable, no?

AFACT offset_valid() does all the required checks.
I did initially miss that skb_ensure_writable() has a side effect of pulling
all the data into the header.
I don't 100% know all the forms an skb can have, I have used (and designed)
too many buffer schemes for my brain to just know the answers.
I don't see an obvious reason why it shouldn't be valid to write
into data that isn't in the header.

>=20
>=20
> > > +
> > > +             if (write_offset < 0) {
> > > +                     if (skb_cow(skb, -write_offset))
> > > +                             goto bad;
> > > +                     if (write_offset + (int)sizeof(*ptr) > 0) {
> > > +                             if (skb_ensure_writable(skb,
> > > +                                                     min_t(int, skb-=
>len,
> > > +                                                           write_off=
set + (int)sizeof(*ptr)))) =20
> >
> > That min isn't needed (same as below). =20
>=20
> Ok - yes, i see that. Same with the min(). Why did we think we needed
> min/min_t() before?
>=20
> > > +                                     goto bad;
> > > +                     }
> > > +             } else {
> > > +                     if (check_add_overflow(write_offset, (int)sizeo=
f(*ptr),
> > > +                                            &write_len)) =20
> >
> > That can't fail because of the 'return offset <=3D (int)skb->len - len;=
' check. =20
>=20
> True.
>=20
> > =20
> > > +                             goto bad;
> > > +                     if (skb_ensure_writable(skb, min_t(int, skb->le=
n,
> > > +                                                        write_len)))=
 =20

You've completely missed that the above has to include the write_offset.

> >
> > Similarly that min_t() will return 'write_len'.
> > But is that even correct?
> > The code wants to write 4 bytes at skb->data + write_offset.
> > I can't see where the offset is used.
> > All the overflow tests have made the logic far too hard to follow.
> >
> > I think that whole lot can just be:
> >         hoffset +=3D offset;
> >         if (offset_valid(skb, hoffset, sizeof(hdata)))
> >                 goto bad;
> >
> >         /* Ensure any needed headroom is writeable */
> >         if (hoffset < 0 && skb_cow(skb, -hoffset)
> >                 goto bad;
> >         /* Ensure the skb is writeable to the end of the area to be wri=
tten.
> >          * The data is pulled into the skb header. */
> >         if ((hoffset >=3D 0 || hoffset + (int)sizeof(hdata) > 0) &&
> >             skb_ensure_writable(skb, hoffset + (int)sizeof(hdata))
> >                 goto bad;
> > The call to offset_valid() does all the other checks.
> > (The hoffset >=3D 0 check is the inverse of the earlier check and will
> > be optimised away - skipping the second second test which is then
> > always true.) =20
>=20
> Yes, that code is more readable.
>=20
> > If you really want a warning message, put a generic one on 'bad;'.
> > =20
> > > +                             goto bad;
> > > +             }
> > > +
> > > +             ptr =3D (u32 *)(skb->data + write_offset);
> > > +             cur_val =3D get_unaligned(ptr); =20
> >
> > Given you are doing an unaligned read you could remove the check in the
> > 'offmask' path that the final offset is a multiple of 4.
> > Nothing checked that tkey->off is a multiple of 4, and I suspect that
> > is user-specifiable? =20
>=20
> The only reason i will keep that check is because we have always
> checked for the 32b alignment from an API perspective. I am less
> worried about than potentially breaking something in the hardware
> offload path when a user passes unaligned offsets down given that
> these code paths (towards hardware) have been well vetted.
>=20
> I am trying to get this security fix in. Do you see anything in what
> you stated as a show stopper? IOW introducing regression or plain
> wrong?

One thing I'm not sure about is whether applications might be setting
a mask in order to update a single byte.
If that byte is one of the last three of the skb data then the RMW
will read/write bytes beyond the end.
That used to be ok, but will now be rejected.

-- David

> If not, I will wait for the AI review or if someone finds an issue
> which breaks something - and if it is worth going back then i will
> consider your suggestions as part of the next update.
> Does that sound reasonable?
>=20
> cheers,
> jamal
>=20
> > I'm also not entirely that the mac_header is aligned.
> >
> > -- David
> > =20
> > >               /* just do it, baby */
> > >               switch (cmd) {
> > >               case TCA_PEDIT_KEY_EX_CMD_SET:
> > >                       val =3D tkey->val;
> > >                       break;
> > >               case TCA_PEDIT_KEY_EX_CMD_ADD:
> > > -                     val =3D (*ptr + tkey->val) & ~tkey->mask;
> > > +                     val =3D (cur_val + tkey->val) & ~tkey->mask;
> > >                       break;
> > >               default:
> > >                       pr_info_ratelimited("tc action pedit bad comman=
d (%d)\n", cmd);
> > >                       goto bad;
> > >               }
> > >
> > > -             *ptr =3D ((*ptr & tkey->mask) ^ val);
> > > -             if (ptr =3D=3D &hdata)
> > > -                     skb_store_bits(skb, hoffset + offset, ptr, 4);
> > > +             put_unaligned((cur_val & tkey->mask) ^ val, ptr);
> > >       }
> > >
> > >       goto done; =20
> > =20


