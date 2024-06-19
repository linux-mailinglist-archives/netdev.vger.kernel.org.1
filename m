Return-Path: <netdev+bounces-105033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E390F76B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED568B21130
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED33B158A08;
	Wed, 19 Jun 2024 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFJ+zTU5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDDA55
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827933; cv=none; b=rey9b137za9MLykEChrypMA3w7p+36Q+GjodhOowsjWcrieyN/se8m34JuhVnut0071BC7bymMlw20WXjb8JUaypPGvCTU1RO95NGH8Jtu8/MY6gs4x310hadwPYCpwp9pon2giK7zuy1daSYXKjzCks4DMtKcOTw9o53lwTQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827933; c=relaxed/simple;
	bh=XnTdO4bQfkgcSbJLEmlMp0/C0MWxDOhYflhO2rjILPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfmtTqIw2z9ejRT/X1uUdlVT3BFD10rxKpdLyA8KrwwqRf/XHePdxCELMQQPkqtcYSBXIytN640bNaUd4VaLACgfy9/oUrpNhPCXWRdmXK6lANSN5mPNuxce/SXL6H00gyTCYfflMY6RF+kPlxLXxWgFj7DEi3/k7BXFz6//NKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFJ+zTU5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-375df5af253so583585ab.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718827931; x=1719432731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwKLFMPHjVgEn/Jk1Soiswu3btgo5ZcldqVdCLVyjf4=;
        b=eFJ+zTU5YM//KCSTW21cez95M5QsszXrrL7a83b4g2cfFL0BOS+I6+J9e9Jhbg5aJ9
         g+rIPYKx/pVD1SDtKKD81HoRxTIW9DtSRnntJEwwrtYnjHCzGcx6Xye7nZBothUwLs+A
         CZiFkSP51BLlTOpLZRoT8A4WeMxOf78rJr0IQ9bBxTRFJIQ+3dlIBRwbJDFxvzdBqQLI
         6b9WkLSsrEJWhF+48ejsV7RJwNl7+IZeMkMXieYLMG/Leh5K2Yvf5l9Bs98q7VPJWs/s
         QDaJklNKUCjvNvwuc3NEQebMqZDkPbpsm0oD5kEW2NhDs57BGPyxpo2KkEVx37X61BRH
         CYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718827931; x=1719432731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwKLFMPHjVgEn/Jk1Soiswu3btgo5ZcldqVdCLVyjf4=;
        b=EUBKZ/HLeQQ/LBkBfR5BqT2KcLBHLDPq71aJ3l1OxQRSD921SlNW47jDqfmtmAO1+7
         8UZtexqQfzXQrfIcIn5mSowqJsdcm+IZNKlD68Oqlww3hVmjPAl+7FBzyDe0WSrgA3x7
         tYR2hL6GFvTH28/YasCJ0xupNVbIqm5iJwjzcsNOLOkoDpStkCopJMR+fOmatm9LCFn+
         eB+VCz41DG+CpH5WCbm350kRRsMd/rU2ZLafobj4jZtmWqlf/7nc/G/sT1huw+tNjMt2
         Fvz55pPZPWqJBvWjzSzce7hzvvHzGoY+ZgBh8GGtt//ukhIaJenal6EJEukPNjYftgv8
         Vopg==
X-Gm-Message-State: AOJu0YwyJJMM+yxlIaSNhYDNcKBD0zZDWFv2ytXdr+/BMrNBvS33KnJ1
	PryPdveRC5olMsaDDvxEAe+Hc85/OqpAqplf2CH58L9ky4pgU6b77XCbvXGxQY7b4DqFohgX3n7
	CATuwwcvzuPrjwZzIjKycu9h2bbo=
X-Google-Smtp-Source: AGHT+IHnS2jCNHyXC1HoJxgHi0O5vst2S6fG6U8J8l4xmCszPd80P8uH4vy45bWK2S94VMdEZHNy0T9Mh/EAU6+NMqc=
X-Received: by 2002:a05:6e02:16c9:b0:374:a542:6ac6 with SMTP id
 e9e14a558f8ab-3761d65560fmr42359825ab.1.1718827931124; Wed, 19 Jun 2024
 13:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689541664.git.lucien.xin@gmail.com> <cf477f4a26579e752465a5951c1d28ba109346e3.1689541664.git.lucien.xin@gmail.com>
 <d35d01d9-83de-4862-85a7-574a6c4dc8f5@ovn.org> <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
 <CADvbK_f9=smg+C7M3dWWj9nvv7Z7_jCLn=6m0OLhmF_V0AEFsg@mail.gmail.com>
 <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org> <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com> <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org>
In-Reply-To: <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 19 Jun 2024 16:11:59 -0400
Message-ID: <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] openvswitch: set IPS_CONFIRMED in tmpl
 status only when commit is set in conntrack
To: Ilya Maximets <i.maximets@ovn.org>, Florian Westphal <fw@strlen.de>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Davide Caratti <dcaratti@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, kuba@kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Aaron Conole <aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 1:30=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 6/19/24 16:07, Xin Long wrote:
> > On Wed, Jun 19, 2024 at 8:58=E2=80=AFAM Ilya Maximets <i.maximets@ovn.o=
rg> wrote:
> >>
> >> On 6/18/24 17:50, Ilya Maximets wrote:
> >>> On 6/18/24 16:58, Xin Long wrote:
> >>>> On Tue, Jun 18, 2024 at 7:34=E2=80=AFAM Ilya Maximets <i.maximets@ov=
n.org> wrote:
> >>>>>
> >>>>> On 6/17/24 22:10, Ilya Maximets wrote:
> >>>>>> On 7/16/23 23:09, Xin Long wrote:
> >>>>>>> By not setting IPS_CONFIRMED in tmpl that allows the exp not to b=
e removed
> >>>>>>> from the hashtable when lookup, we can simplify the exp processin=
g code a
> >>>>>>> lot in openvswitch conntrack.
> >>>>>>>
> >>>>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >>>>>>> ---
> >>>>>>>  net/openvswitch/conntrack.c | 78 +++++--------------------------=
------
> >>>>>>>  1 file changed, 10 insertions(+), 68 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntr=
ack.c
> >>>>>>> index 331730fd3580..fa955e892210 100644
> >>>>>>> --- a/net/openvswitch/conntrack.c
> >>>>>>> +++ b/net/openvswitch/conntrack.c
> >>>>>>> @@ -455,45 +455,6 @@ static int ovs_ct_handle_fragments(struct ne=
t *net, struct sw_flow_key *key,
> >>>>>>>      return 0;
> >>>>>>>  }
> >>>>>>>
> >>>>>>> -static struct nf_conntrack_expect *
> >>>>>>> -ovs_ct_expect_find(struct net *net, const struct nf_conntrack_zo=
ne *zone,
> >>>>>>> -               u16 proto, const struct sk_buff *skb)
> >>>>>>> -{
> >>>>>>> -    struct nf_conntrack_tuple tuple;
> >>>>>>> -    struct nf_conntrack_expect *exp;
> >>>>>>> -
> >>>>>>> -    if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb), proto, =
net, &tuple))
> >>>>>>> -            return NULL;
> >>>>>>> -
> >>>>>>> -    exp =3D __nf_ct_expect_find(net, zone, &tuple);
> >>>>>>> -    if (exp) {
> >>>>>>> -            struct nf_conntrack_tuple_hash *h;
> >>>>>>> -
> >>>>>>> -            /* Delete existing conntrack entry, if it clashes wi=
th the
> >>>>>>> -             * expectation.  This can happen since conntrack ALG=
s do not
> >>>>>>> -             * check for clashes between (new) expectations and =
existing
> >>>>>>> -             * conntrack entries.  nf_conntrack_in() will check =
the
> >>>>>>> -             * expectations only if a conntrack entry can not be=
 found,
> >>>>>>> -             * which can lead to OVS finding the expectation (he=
re) in the
> >>>>>>> -             * init direction, but which will not be removed by =
the
> >>>>>>> -             * nf_conntrack_in() call, if a matching conntrack e=
ntry is
> >>>>>>> -             * found instead.  In this case all init direction p=
ackets
> >>>>>>> -             * would be reported as new related packets, while r=
eply
> >>>>>>> -             * direction packets would be reported as un-related
> >>>>>>> -             * established packets.
> >>>>>>> -             */
> >>>>>>> -            h =3D nf_conntrack_find_get(net, zone, &tuple);
> >>>>>>> -            if (h) {
> >>>>>>> -                    struct nf_conn *ct =3D nf_ct_tuplehash_to_ct=
rack(h);
> >>>>>>> -
> >>>>>>> -                    nf_ct_delete(ct, 0, 0);
> >>>>>>> -                    nf_ct_put(ct);
> >>>>>>> -            }
> >>>>>>> -    }
> >>>>>>> -
> >>>>>>> -    return exp;
> >>>>>>> -}
> >>>>>>> -
> >>>>>>>  /* This replicates logic from nf_conntrack_core.c that is not ex=
ported. */
> >>>>>>>  static enum ip_conntrack_info
> >>>>>>>  ovs_ct_get_info(const struct nf_conntrack_tuple_hash *h)
> >>>>>>> @@ -852,36 +813,16 @@ static int ovs_ct_lookup(struct net *net, s=
truct sw_flow_key *key,
> >>>>>>>                       const struct ovs_conntrack_info *info,
> >>>>>>>                       struct sk_buff *skb)
> >>>>>>>  {
> >>>>>>> -    struct nf_conntrack_expect *exp;
> >>>>>>> -
> >>>>>>> -    /* If we pass an expected packet through nf_conntrack_in() t=
he
> >>>>>>> -     * expectation is typically removed, but the packet could st=
ill be
> >>>>>>> -     * lost in upcall processing.  To prevent this from happenin=
g we
> >>>>>>> -     * perform an explicit expectation lookup.  Expected connect=
ions are
> >>>>>>> -     * always new, and will be passed through conntrack only whe=
n they are
> >>>>>>> -     * committed, as it is OK to remove the expectation at that =
time.
> >>>>>>> -     */
> >>>>>>> -    exp =3D ovs_ct_expect_find(net, &info->zone, info->family, s=
kb);
> >>>>>>> -    if (exp) {
> >>>>>>> -            u8 state;
> >>>>>>> -
> >>>>>>> -            /* NOTE: New connections are NATted and Helped only =
when
> >>>>>>> -             * committed, so we are not calling into NAT here.
> >>>>>>> -             */
> >>>>>>> -            state =3D OVS_CS_F_TRACKED | OVS_CS_F_NEW | OVS_CS_F=
_RELATED;
> >>>>>>> -            __ovs_ct_update_key(key, state, &info->zone, exp->ma=
ster);
> >>>>>>
> >>>>>> Hi, Xin, others.
> >>>>>>
> >>>>>> Unfortunately, it seems like removal of this code broke the expect=
ed behavior.
> >>>>>> OVS in userspace expects that SYN packet of a new related FTP conn=
ection will
> >>>>>> get +new+rel+trk flags, but after this patch we're only getting +r=
el+trk and not
> >>>>>> new.  This is a problem because we need to commit this connection =
with the label
> >>>>>> and we do that for +new packets.  If we can't get +new packet we'l=
l have to commit
> >>>>>> every single +rel+trk packet, which doesn't make a lot of sense.  =
And it's a
> >>>>>> significant behavior change regardless.
> >>>>>
> >>>>> Interestingly enough I see +new+rel+trk packets in cases without SN=
AT,
> >>>>> but we can only get +rel+trk in cases with SNAT.  So, this may be j=
ust
> >>>>> a generic conntrack bug somewhere.  At least the behavior seems fai=
rly
> >>>>> inconsistent.
> >>>>>
> >>>> In nf_conntrack, IP_CT_RELATED and IP_CT_NEW do not exist at the sam=
e
> >>>> time. With this patch, we expect OVS_CS_F_RELATED and OVS_CS_F_NEW
> >>>> are set at the same time by ovs_ct_update_key() when this related ct
> >>>> is not confirmed.
> >>>>
> >>>> The check-kernel test of "FTP SNAT orig tuple" skiped on my env some=
how:
> >>>>
> >>>> # make check-kernel
> >>>> 144: conntrack - FTP SNAT orig tuple   skipped (system-traffic.at:72=
95)
> >>>>
> >>>> Any idea why? or do you know any other testcase that expects +new+re=
l+trk
> >>>> but returns +rel+trk only?
> >>>
> >>> You need to install lftp and pyftpdlib.  The pyftpdlib may only be av=
ailable
> >>> via pip on some systems.
> >>>
> >>>>
> >>>> Thanks.
> >>>>>>
> >>>>>> Could you, please, take a look?
> >>>>>>
> >>>>>> The issue can be reproduced by running check-kernel tests in OVS r=
epo.
> >>>>>> 'FTP SNAT orig tuple' tests fail 100% of the time.
> >>>>>>
> >>>>>> Best regards, Ilya Maximets.
> >>>>>
> >>>
> >>
> >> Hmm.  After further investigation, it seems that the issue is not abou=
t ct state,
> >> but the ct label.  Before this commit we had information about both th=
e original
> >> tuple of the parent connection and the mark/label of the parent connec=
tion:
> >>
> > Make senses. Now I can see the difference after this commit.
> > We will need a fix in __ovs_ct_update_key() to copy mark & label from
> > ct->master for exp ct.
> >
> > @@ -196,8 +196,8 @@ static void __ovs_ct_update_key(struct sw_flow_key
> > *key, u8 state,
> >  {
> >         key->ct_state =3D state;
> >         key->ct_zone =3D zone->id;
> > -       key->ct.mark =3D ovs_ct_get_mark(ct);
> > -       ovs_ct_get_labels(ct, &key->ct.labels);
> > +       key->ct.mark =3D 0;
> > +       memset(&key->ct.labels, 0, OVS_CT_LABELS_LEN);
> >
> >         if (ct) {
> >                 const struct nf_conntrack_tuple *orig;
> > @@ -205,6 +205,8 @@ static void __ovs_ct_update_key(struct sw_flow_key
> > *key, u8 state,
> >                 /* Use the master if we have one. */
> >                 if (ct->master)
> >                         ct =3D ct->master;
> > +               key->ct.mark =3D ovs_ct_get_mark(ct);
> > +               ovs_ct_get_labels(ct, &key->ct.labels);
> >                 orig =3D &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
> >
> >                 /* IP version must match with the master connection. */
> >
> > We may need to run some regression tests for such a change.
>
> Thank, Xin!  This seems like a change in the right direction and it fixes
> this particular test.  But, I guess, we should get mark/labels from the
> master connection only if it is not yet confirmed.  Users may commit diff=
erent
> labels for the related connection.  This should be more in line with the
> previous behavior.
>
> What do you think?
>
You're right.
Also, I noticed the related ct->mark is set to master ct->mark in
init_conntrack() as well as secmark when creating the related ct.

Hi, Florian,

Any reason why the labels are not set to master ct's in there?

Thanks.

>
> >
> > Thanks.
> >
> >> system@ovs-system: miss upcall:
> >> recirc_id(0x2),dp_hash(0),skb_priority(0),in_port(3),skb_mark(0),ct_st=
ate(0x25),
> >> ct_zone(0x1),ct_mark(0),ct_label(0x4d2000000000000000000000001),
> >> ct_tuple4(src=3D10.1.1.1,dst=3D10.1.1.2,proto=3D6,tp_src=3D50648,tp_ds=
t=3D21),
> >> eth(src=3Dde:d9:f3:c8:5a:3a,dst=3D80:88:88:88:88:88),eth_type(0x0800),
> >> ipv4(src=3D10.1.1.2,dst=3D10.1.1.9,proto=3D6,tos=3D0,ttl=3D64,frag=3Dn=
o),
> >> tcp(src=3D57027,dst=3D38153),tcp_flags(syn)
> >>
> >> But after this change, we still have the original tuple of the parent =
connection,
> >> but the label is no longer in the flow key:
> >>
> >> system@ovs-system: miss upcall:
> >> recirc_id(0x2),dp_hash(0),skb_priority(0),in_port(3),skb_mark(0),ct_st=
ate(0x25),
> >> ct_zone(0x1),ct_mark(0),ct_label(0),
> >> ct_tuple4(src=3D10.1.1.1,dst=3D10.1.1.2,proto=3D6,tp_src=3D34668,tp_ds=
t=3D21),
> >> eth(src=3D66:eb:74:c6:79:24,dst=3D80:88:88:88:88:88),eth_type(0x0800),
> >> ipv4(src=3D10.1.1.2,dst=3D10.1.1.9,proto=3D6,tos=3D0,ttl=3D64,frag=3Dn=
o),
> >> tcp(src=3D49529,dst=3D35459),tcp_flags(syn)
> >>
> >> ct_state(0x25) =3D=3D +new+rel+trk
> >>
> >> Best regards, Ilya Maximets.
>

