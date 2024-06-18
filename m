Return-Path: <netdev+bounces-104581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9D490D662
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F6D1C23BFA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1E763E7;
	Tue, 18 Jun 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwln0OYA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949512139AC
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722748; cv=none; b=brphWOIqdV/Slf4RgEXxbZe+ynWeD3Q0H4olShW1mM41KeFTHsSBLLP2nULbZcgdkyUKkpw7IkvL5lqq2443tTwceEJ3XrTGN8m3ezTIQrJzQnEv/MhXzM8JQbLNFoCcRaLhkdwydapv4cU/U4dpc2JtB66KcgfpGc3hgClYROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722748; c=relaxed/simple;
	bh=IxQMXHXeOGZKBgkQ2Ybm3j0OEUrvm388zuZbxDVyAq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u521FANsxc4LL+n5oTA3/0fNPlcfJOGXNkuOFRBrKiFc6/LuJqFmVjZUucduSRwyU4/XCYWBz5pxXABHlp+/PTcNgh0TWyaG/qPumPl8LuXSKv5O4O5n1f69YInqc2XZ6dPIagJgoEvlbWkny8oKLNIceJ/5WPsWKD5W9yxEX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwln0OYA; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36dd56cf5f5so20925685ab.3
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718722745; x=1719327545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZCBJu7by7YY6CygAmQG0JhwqLkfMCcYUyo78G4Y96c=;
        b=Pwln0OYA+Zp+ppX0L9ufO+35EO6Hi9XEIMh9tpIjvfXAkQOgSBgM1agjNQ46v9sFkF
         Mk4/euZj3cumla/EuehOUe3BUCKTGqePXfQbS2hCeofNppvzr/c0dxcrQp4RcNkN/uag
         GtSAfA6lUfBh6v1OR67jwcrRNWfhEwPIFD4fjxSpQ62stRl0K1ERWXDUOzi88HzYyZ72
         j4D702JEkQk8F9QK31D4k/NN09L2VzwLy0hm8O9IzpYn8hJpFJ0bWLb4aINUtcSCUC07
         au097ia+s40A4Tcooo0mbxn9m7P3kAd2ih9IC4odE6oxNCDPNJI20cA5Wn/EBqWMCiRt
         H+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718722745; x=1719327545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZCBJu7by7YY6CygAmQG0JhwqLkfMCcYUyo78G4Y96c=;
        b=kf5SiSXvHOKYjYyzEDF5MwrMORctyjEc95mqgtbrqOQGoooIKzvMIAHQzHVluy6xBw
         SO7xqv2lQglONXc4VWU05Km/HmGHDzx/MAWERYO1DcT7sh1M7lf0I6bcLmiKhfOO1d2t
         U6ByLckzsTsvq2QUOxOudon2S08+Z6c6VJFYPSVUIBevaSCFiA8QCNlCADeJ+22LMsZK
         rnqfF0kFZMtLMBqJ9cTKbuw9EzTX/LQ3GseY6VeBQR6LwZGd8UJkH+PIVn1elO8ZvNFG
         iKHDH7wrVrl4l2SGlTXCzGBquiop9iGM1XH6lLSnxkLLw6djzrfqKzp2agqdy/erZW0W
         BPAQ==
X-Gm-Message-State: AOJu0YzZeNq7dG2O7w/LL5WenuQN9VkR8yPmyWqfEtcLl3Z7N5rq+FQL
	YGpo6CjD/E8C5YQ06Te3yNf/Kc7BHlsKBavvWn1lUiLSiwDAly4kmLeniYrNqw74XbVKDSI3L9O
	YSYqwPMeNeAHzV+PaCvYOqaAM4D4=
X-Google-Smtp-Source: AGHT+IHjkf33G0pWh8uFFybSmixdsQN9VEFjMfG8MP7QYcU/H6Aw37WlDgpKvP4/aCEr5lhyorEhGxBjJ5gApcc/cDg=
X-Received: by 2002:a05:6e02:216f:b0:375:c443:9883 with SMTP id
 e9e14a558f8ab-375e0e9e29bmr135673895ab.21.1718722745429; Tue, 18 Jun 2024
 07:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689541664.git.lucien.xin@gmail.com> <cf477f4a26579e752465a5951c1d28ba109346e3.1689541664.git.lucien.xin@gmail.com>
 <d35d01d9-83de-4862-85a7-574a6c4dc8f5@ovn.org> <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
In-Reply-To: <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 18 Jun 2024 10:58:54 -0400
Message-ID: <CADvbK_f9=smg+C7M3dWWj9nvv7Z7_jCLn=6m0OLhmF_V0AEFsg@mail.gmail.com>
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

On Tue, Jun 18, 2024 at 7:34=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 6/17/24 22:10, Ilya Maximets wrote:
> > On 7/16/23 23:09, Xin Long wrote:
> >> By not setting IPS_CONFIRMED in tmpl that allows the exp not to be rem=
oved
> >> from the hashtable when lookup, we can simplify the exp processing cod=
e a
> >> lot in openvswitch conntrack.
> >>
> >> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >> ---
> >>  net/openvswitch/conntrack.c | 78 +++++-------------------------------=
-
> >>  1 file changed, 10 insertions(+), 68 deletions(-)
> >>
> >> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> >> index 331730fd3580..fa955e892210 100644
> >> --- a/net/openvswitch/conntrack.c
> >> +++ b/net/openvswitch/conntrack.c
> >> @@ -455,45 +455,6 @@ static int ovs_ct_handle_fragments(struct net *ne=
t, struct sw_flow_key *key,
> >>      return 0;
> >>  }
> >>
> >> -static struct nf_conntrack_expect *
> >> -ovs_ct_expect_find(struct net *net, const struct nf_conntrack_zone *z=
one,
> >> -               u16 proto, const struct sk_buff *skb)
> >> -{
> >> -    struct nf_conntrack_tuple tuple;
> >> -    struct nf_conntrack_expect *exp;
> >> -
> >> -    if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb), proto, net, =
&tuple))
> >> -            return NULL;
> >> -
> >> -    exp =3D __nf_ct_expect_find(net, zone, &tuple);
> >> -    if (exp) {
> >> -            struct nf_conntrack_tuple_hash *h;
> >> -
> >> -            /* Delete existing conntrack entry, if it clashes with th=
e
> >> -             * expectation.  This can happen since conntrack ALGs do =
not
> >> -             * check for clashes between (new) expectations and exist=
ing
> >> -             * conntrack entries.  nf_conntrack_in() will check the
> >> -             * expectations only if a conntrack entry can not be foun=
d,
> >> -             * which can lead to OVS finding the expectation (here) i=
n the
> >> -             * init direction, but which will not be removed by the
> >> -             * nf_conntrack_in() call, if a matching conntrack entry =
is
> >> -             * found instead.  In this case all init direction packet=
s
> >> -             * would be reported as new related packets, while reply
> >> -             * direction packets would be reported as un-related
> >> -             * established packets.
> >> -             */
> >> -            h =3D nf_conntrack_find_get(net, zone, &tuple);
> >> -            if (h) {
> >> -                    struct nf_conn *ct =3D nf_ct_tuplehash_to_ctrack(=
h);
> >> -
> >> -                    nf_ct_delete(ct, 0, 0);
> >> -                    nf_ct_put(ct);
> >> -            }
> >> -    }
> >> -
> >> -    return exp;
> >> -}
> >> -
> >>  /* This replicates logic from nf_conntrack_core.c that is not exporte=
d. */
> >>  static enum ip_conntrack_info
> >>  ovs_ct_get_info(const struct nf_conntrack_tuple_hash *h)
> >> @@ -852,36 +813,16 @@ static int ovs_ct_lookup(struct net *net, struct=
 sw_flow_key *key,
> >>                       const struct ovs_conntrack_info *info,
> >>                       struct sk_buff *skb)
> >>  {
> >> -    struct nf_conntrack_expect *exp;
> >> -
> >> -    /* If we pass an expected packet through nf_conntrack_in() the
> >> -     * expectation is typically removed, but the packet could still b=
e
> >> -     * lost in upcall processing.  To prevent this from happening we
> >> -     * perform an explicit expectation lookup.  Expected connections =
are
> >> -     * always new, and will be passed through conntrack only when the=
y are
> >> -     * committed, as it is OK to remove the expectation at that time.
> >> -     */
> >> -    exp =3D ovs_ct_expect_find(net, &info->zone, info->family, skb);
> >> -    if (exp) {
> >> -            u8 state;
> >> -
> >> -            /* NOTE: New connections are NATted and Helped only when
> >> -             * committed, so we are not calling into NAT here.
> >> -             */
> >> -            state =3D OVS_CS_F_TRACKED | OVS_CS_F_NEW | OVS_CS_F_RELA=
TED;
> >> -            __ovs_ct_update_key(key, state, &info->zone, exp->master)=
;
> >
> > Hi, Xin, others.
> >
> > Unfortunately, it seems like removal of this code broke the expected be=
havior.
> > OVS in userspace expects that SYN packet of a new related FTP connectio=
n will
> > get +new+rel+trk flags, but after this patch we're only getting +rel+tr=
k and not
> > new.  This is a problem because we need to commit this connection with =
the label
> > and we do that for +new packets.  If we can't get +new packet we'll hav=
e to commit
> > every single +rel+trk packet, which doesn't make a lot of sense.  And i=
t's a
> > significant behavior change regardless.
>
> Interestingly enough I see +new+rel+trk packets in cases without SNAT,
> but we can only get +rel+trk in cases with SNAT.  So, this may be just
> a generic conntrack bug somewhere.  At least the behavior seems fairly
> inconsistent.
>
In nf_conntrack, IP_CT_RELATED and IP_CT_NEW do not exist at the same
time. With this patch, we expect OVS_CS_F_RELATED and OVS_CS_F_NEW
are set at the same time by ovs_ct_update_key() when this related ct
is not confirmed.

The check-kernel test of "FTP SNAT orig tuple" skiped on my env somehow:

# make check-kernel
144: conntrack - FTP SNAT orig tuple   skipped (system-traffic.at:7295)

Any idea why? or do you know any other testcase that expects +new+rel+trk
but returns +rel+trk only?

Thanks.
> >
> > Could you, please, take a look?
> >
> > The issue can be reproduced by running check-kernel tests in OVS repo.
> > 'FTP SNAT orig tuple' tests fail 100% of the time.
> >
> > Best regards, Ilya Maximets.
>

