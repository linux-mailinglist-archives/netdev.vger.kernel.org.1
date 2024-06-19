Return-Path: <netdev+bounces-104888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F890EFB4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53B0B243AE
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592F1514DE;
	Wed, 19 Jun 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9jaVW9I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6215217B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806081; cv=none; b=Rer/gzivHsAy52rmysRXI4tc3HET6BMMdsQs/ht7yjFL8VqSWuuksLTXekx7c0Az1hlCIdBUolQdpSTPBlrjNQiUvH7R9xfjlLunbaC8Kfvv7aEK04cAdWVQozkQ/xYKxoQNCVSh1JyGQxQQ4Q6kuMHqlsl++8d7ykGcg9JO8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806081; c=relaxed/simple;
	bh=Q1p2iqZp42YK67bdypupYU/aUcMf52kYnDs2TSkcUCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2dnV6FnQmK6ieX6gPak18+JMN1gtWE8ylAEhbCy7HDUd0jpadfUKwTJPzJo5sGAhHTo0vLAF927EvG23bD5n6pcs4ZEKiO3WrW+Zb29hEzS5NOz32rAIqMtokI9fEVrz1D6uUBFaDPXnkdo9VLZx749oPAsnAAaOVi6PNAOtjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9jaVW9I; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3737dc4a669so26718385ab.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718806079; x=1719410879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaT41GNFysed6i2xFhMEl7AEu7n3RvuUw38yuTNzdWI=;
        b=a9jaVW9I9inisM6oCEyy/Y4aEYiAIbqNWknjhm18vAEqEaBeYG+g+70UCDFQRspFSB
         jfG0K4nKFKRsriPty3/BZonniExSlJdkZN4R8DVtjUESm6cQm0BMHwyY+BMMhela6AH1
         gvqSMA9cI10qayMP/EmB1sWAQpEeATllQcUQ52HhVkpIMu/tLnrmJiTX6/g5DXJImNtf
         1Id9z4w3oX8CIR3h6Wi+rsNoLHrpSW2huLYcwKXLb3ejs8x5fWJWXjsZcPD2vNfDT2fb
         0JJIS2CfXY+TB9ATfkuJrbb4owol5MpXffFD35VXGHIYEboa1Tug0BsP2PSykEf9avCm
         ZZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806079; x=1719410879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaT41GNFysed6i2xFhMEl7AEu7n3RvuUw38yuTNzdWI=;
        b=SQ2B/kWZGN7MaaZKxcsYMpPEMC/zFMtweGM+/6miN7CpkiW3mMYMVlnVQhU2eEGXe1
         BphMBasozfp3oY887cef2V7CTXCjBV2YBbT+MO+mcaQWmcP/vQqaUSKI8VfGRdgTUMxM
         M/AU54CLsmIv+ka7DlRFIXmm/kuwqW1m9C+mI86M12moZaxdYhxHHc/5o0UskvuGK/cw
         YrHcECBTe6zVp93kTECkqmFTADvQZiQGmP2tcTUmfRIjf/rvWjTwawOkSCi0j6cgqqV1
         UBvASy7HZ9VqoR/eUlAl0J4aN8/HBov72nsHUHaqELw8aNOeg6PLXRk362jpB3340JMH
         2mtg==
X-Gm-Message-State: AOJu0YykwzqDwLGGG+V43oTf6yTO7NA1Cn1Odgyfhgz7PGXvAc1w7AlL
	ySQ9QC2xQQgsVroUu3tZoXj+QWshZWkoFewqkECeEHl2CdZvn4Ue562gTUQkwbZpj8kb07wapG0
	8ODYOXnMRtULc7qxrtxMrOgyuwkE=
X-Google-Smtp-Source: AGHT+IF1i/Sol9sPusH9tccIOTIZ9ylsJVyt8rVrzB1BAWCAgFZ3aL4k/E9o8l47RGzffdb6cdxGEngQyyXw8h8hwyg=
X-Received: by 2002:a92:cdad:0:b0:376:24b1:174f with SMTP id
 e9e14a558f8ab-37624b11a42mr6390105ab.6.1718806078992; Wed, 19 Jun 2024
 07:07:58 -0700 (PDT)
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
In-Reply-To: <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 19 Jun 2024 10:07:47 -0400
Message-ID: <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] openvswitch: set IPS_CONFIRMED in tmpl
 status only when commit is set in conntrack
To: Ilya Maximets <i.maximets@ovn.org>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Davide Caratti <dcaratti@redhat.com>, Florian Westphal <fw@strlen.de>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, kuba@kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Aaron Conole <aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 8:58=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 6/18/24 17:50, Ilya Maximets wrote:
> > On 6/18/24 16:58, Xin Long wrote:
> >> On Tue, Jun 18, 2024 at 7:34=E2=80=AFAM Ilya Maximets <i.maximets@ovn.=
org> wrote:
> >>>
> >>> On 6/17/24 22:10, Ilya Maximets wrote:
> >>>> On 7/16/23 23:09, Xin Long wrote:
> >>>>> By not setting IPS_CONFIRMED in tmpl that allows the exp not to be =
removed
> >>>>> from the hashtable when lookup, we can simplify the exp processing =
code a
> >>>>> lot in openvswitch conntrack.
> >>>>>
> >>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >>>>> ---
> >>>>>  net/openvswitch/conntrack.c | 78 +++++----------------------------=
----
> >>>>>  1 file changed, 10 insertions(+), 68 deletions(-)
> >>>>>
> >>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrac=
k.c
> >>>>> index 331730fd3580..fa955e892210 100644
> >>>>> --- a/net/openvswitch/conntrack.c
> >>>>> +++ b/net/openvswitch/conntrack.c
> >>>>> @@ -455,45 +455,6 @@ static int ovs_ct_handle_fragments(struct net =
*net, struct sw_flow_key *key,
> >>>>>      return 0;
> >>>>>  }
> >>>>>
> >>>>> -static struct nf_conntrack_expect *
> >>>>> -ovs_ct_expect_find(struct net *net, const struct nf_conntrack_zone=
 *zone,
> >>>>> -               u16 proto, const struct sk_buff *skb)
> >>>>> -{
> >>>>> -    struct nf_conntrack_tuple tuple;
> >>>>> -    struct nf_conntrack_expect *exp;
> >>>>> -
> >>>>> -    if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb), proto, ne=
t, &tuple))
> >>>>> -            return NULL;
> >>>>> -
> >>>>> -    exp =3D __nf_ct_expect_find(net, zone, &tuple);
> >>>>> -    if (exp) {
> >>>>> -            struct nf_conntrack_tuple_hash *h;
> >>>>> -
> >>>>> -            /* Delete existing conntrack entry, if it clashes with=
 the
> >>>>> -             * expectation.  This can happen since conntrack ALGs =
do not
> >>>>> -             * check for clashes between (new) expectations and ex=
isting
> >>>>> -             * conntrack entries.  nf_conntrack_in() will check th=
e
> >>>>> -             * expectations only if a conntrack entry can not be f=
ound,
> >>>>> -             * which can lead to OVS finding the expectation (here=
) in the
> >>>>> -             * init direction, but which will not be removed by th=
e
> >>>>> -             * nf_conntrack_in() call, if a matching conntrack ent=
ry is
> >>>>> -             * found instead.  In this case all init direction pac=
kets
> >>>>> -             * would be reported as new related packets, while rep=
ly
> >>>>> -             * direction packets would be reported as un-related
> >>>>> -             * established packets.
> >>>>> -             */
> >>>>> -            h =3D nf_conntrack_find_get(net, zone, &tuple);
> >>>>> -            if (h) {
> >>>>> -                    struct nf_conn *ct =3D nf_ct_tuplehash_to_ctra=
ck(h);
> >>>>> -
> >>>>> -                    nf_ct_delete(ct, 0, 0);
> >>>>> -                    nf_ct_put(ct);
> >>>>> -            }
> >>>>> -    }
> >>>>> -
> >>>>> -    return exp;
> >>>>> -}
> >>>>> -
> >>>>>  /* This replicates logic from nf_conntrack_core.c that is not expo=
rted. */
> >>>>>  static enum ip_conntrack_info
> >>>>>  ovs_ct_get_info(const struct nf_conntrack_tuple_hash *h)
> >>>>> @@ -852,36 +813,16 @@ static int ovs_ct_lookup(struct net *net, str=
uct sw_flow_key *key,
> >>>>>                       const struct ovs_conntrack_info *info,
> >>>>>                       struct sk_buff *skb)
> >>>>>  {
> >>>>> -    struct nf_conntrack_expect *exp;
> >>>>> -
> >>>>> -    /* If we pass an expected packet through nf_conntrack_in() the
> >>>>> -     * expectation is typically removed, but the packet could stil=
l be
> >>>>> -     * lost in upcall processing.  To prevent this from happening =
we
> >>>>> -     * perform an explicit expectation lookup.  Expected connectio=
ns are
> >>>>> -     * always new, and will be passed through conntrack only when =
they are
> >>>>> -     * committed, as it is OK to remove the expectation at that ti=
me.
> >>>>> -     */
> >>>>> -    exp =3D ovs_ct_expect_find(net, &info->zone, info->family, skb=
);
> >>>>> -    if (exp) {
> >>>>> -            u8 state;
> >>>>> -
> >>>>> -            /* NOTE: New connections are NATted and Helped only wh=
en
> >>>>> -             * committed, so we are not calling into NAT here.
> >>>>> -             */
> >>>>> -            state =3D OVS_CS_F_TRACKED | OVS_CS_F_NEW | OVS_CS_F_R=
ELATED;
> >>>>> -            __ovs_ct_update_key(key, state, &info->zone, exp->mast=
er);
> >>>>
> >>>> Hi, Xin, others.
> >>>>
> >>>> Unfortunately, it seems like removal of this code broke the expected=
 behavior.
> >>>> OVS in userspace expects that SYN packet of a new related FTP connec=
tion will
> >>>> get +new+rel+trk flags, but after this patch we're only getting +rel=
+trk and not
> >>>> new.  This is a problem because we need to commit this connection wi=
th the label
> >>>> and we do that for +new packets.  If we can't get +new packet we'll =
have to commit
> >>>> every single +rel+trk packet, which doesn't make a lot of sense.  An=
d it's a
> >>>> significant behavior change regardless.
> >>>
> >>> Interestingly enough I see +new+rel+trk packets in cases without SNAT=
,
> >>> but we can only get +rel+trk in cases with SNAT.  So, this may be jus=
t
> >>> a generic conntrack bug somewhere.  At least the behavior seems fairl=
y
> >>> inconsistent.
> >>>
> >> In nf_conntrack, IP_CT_RELATED and IP_CT_NEW do not exist at the same
> >> time. With this patch, we expect OVS_CS_F_RELATED and OVS_CS_F_NEW
> >> are set at the same time by ovs_ct_update_key() when this related ct
> >> is not confirmed.
> >>
> >> The check-kernel test of "FTP SNAT orig tuple" skiped on my env someho=
w:
> >>
> >> # make check-kernel
> >> 144: conntrack - FTP SNAT orig tuple   skipped (system-traffic.at:7295=
)
> >>
> >> Any idea why? or do you know any other testcase that expects +new+rel+=
trk
> >> but returns +rel+trk only?
> >
> > You need to install lftp and pyftpdlib.  The pyftpdlib may only be avai=
lable
> > via pip on some systems.
> >
> >>
> >> Thanks.
> >>>>
> >>>> Could you, please, take a look?
> >>>>
> >>>> The issue can be reproduced by running check-kernel tests in OVS rep=
o.
> >>>> 'FTP SNAT orig tuple' tests fail 100% of the time.
> >>>>
> >>>> Best regards, Ilya Maximets.
> >>>
> >
>
> Hmm.  After further investigation, it seems that the issue is not about c=
t state,
> but the ct label.  Before this commit we had information about both the o=
riginal
> tuple of the parent connection and the mark/label of the parent connectio=
n:
>
Make senses. Now I can see the difference after this commit.
We will need a fix in __ovs_ct_update_key() to copy mark & label from
ct->master for exp ct.

@@ -196,8 +196,8 @@ static void __ovs_ct_update_key(struct sw_flow_key
*key, u8 state,
 {
        key->ct_state =3D state;
        key->ct_zone =3D zone->id;
-       key->ct.mark =3D ovs_ct_get_mark(ct);
-       ovs_ct_get_labels(ct, &key->ct.labels);
+       key->ct.mark =3D 0;
+       memset(&key->ct.labels, 0, OVS_CT_LABELS_LEN);

        if (ct) {
                const struct nf_conntrack_tuple *orig;
@@ -205,6 +205,8 @@ static void __ovs_ct_update_key(struct sw_flow_key
*key, u8 state,
                /* Use the master if we have one. */
                if (ct->master)
                        ct =3D ct->master;
+               key->ct.mark =3D ovs_ct_get_mark(ct);
+               ovs_ct_get_labels(ct, &key->ct.labels);
                orig =3D &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;

                /* IP version must match with the master connection. */

We may need to run some regression tests for such a change.

Thanks.

> system@ovs-system: miss upcall:
> recirc_id(0x2),dp_hash(0),skb_priority(0),in_port(3),skb_mark(0),ct_state=
(0x25),
> ct_zone(0x1),ct_mark(0),ct_label(0x4d2000000000000000000000001),
> ct_tuple4(src=3D10.1.1.1,dst=3D10.1.1.2,proto=3D6,tp_src=3D50648,tp_dst=
=3D21),
> eth(src=3Dde:d9:f3:c8:5a:3a,dst=3D80:88:88:88:88:88),eth_type(0x0800),
> ipv4(src=3D10.1.1.2,dst=3D10.1.1.9,proto=3D6,tos=3D0,ttl=3D64,frag=3Dno),
> tcp(src=3D57027,dst=3D38153),tcp_flags(syn)
>
> But after this change, we still have the original tuple of the parent con=
nection,
> but the label is no longer in the flow key:
>
> system@ovs-system: miss upcall:
> recirc_id(0x2),dp_hash(0),skb_priority(0),in_port(3),skb_mark(0),ct_state=
(0x25),
> ct_zone(0x1),ct_mark(0),ct_label(0),
> ct_tuple4(src=3D10.1.1.1,dst=3D10.1.1.2,proto=3D6,tp_src=3D34668,tp_dst=
=3D21),
> eth(src=3D66:eb:74:c6:79:24,dst=3D80:88:88:88:88:88),eth_type(0x0800),
> ipv4(src=3D10.1.1.2,dst=3D10.1.1.9,proto=3D6,tos=3D0,ttl=3D64,frag=3Dno),
> tcp(src=3D49529,dst=3D35459),tcp_flags(syn)
>
> ct_state(0x25) =3D=3D +new+rel+trk
>
> Best regards, Ilya Maximets.

