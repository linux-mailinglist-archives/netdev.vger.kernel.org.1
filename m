Return-Path: <netdev+bounces-110069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C294B92ADF0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FB51F21F48
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D081F2772A;
	Tue,  9 Jul 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBSZBzTD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B04A05
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720489808; cv=none; b=gofMf0i1AzM7Wb0YAcpV9UJ65OAFkCfslb5EkVh0XyIN1wf5IR0kucRI5tSdTgyUI5pwZp8bQT4LPLD2pXqqIMWOjoaIL+c21+TWJhK+3nTA7puKQSOhn+20VURw08TEJIDNICvW9W7DbNa/lLcKdc4VPfdkYlnySLsq/bjJL9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720489808; c=relaxed/simple;
	bh=VoXf/9poBzUyaZb5yvcIIvLKQFMTcMA03K/Nl/s86f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDeq+ERkk80261tjCmTn+6j7DuI5HIEk5spqXHGJSab3TFle/a4TBMVCONBWm5Qwv7IXUTt2bpRD0FF6sd+nsJ+zkQvxyVQjw7n59lVA/N+2cHEk1wpA4M3p382Zx8sieugxsNQOnjHsxu0fh8rOC5C4GraxgVHEsFB6mjiXx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBSZBzTD; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-380bfd7cdbfso22122325ab.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 18:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720489805; x=1721094605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95X+KQjG1EcAF+s4nXnBBH4JFb1AoTt7PneQ/KBaA0s=;
        b=EBSZBzTDzXBUIelsli55Ph7whBkm61wysfL819iF3UdnFblkVEoDp2OsJguER06qSY
         o1WuZlr5lTWCiy97r/2vA2CclcbueiOgAsARIcn/mwrFnQfEZlz8feGTetAhGYH6Hz7E
         +9UP5DhnaJJTVqf6LEcELqq0rrbwvliHiQB7yMLFkLX7wwW1uQnorTSTDmh62JDwS4PA
         bM+WtHoAgUlqOy6ik9+mpV3Rf+Q/exiXFMOkT5Ayp9IfAdaQ2nCqd4gOw2yydHQYv/ku
         M7VkoxyqDpBQNsouk0awxqAhHnvWCLxanqmFr6bSZ72OPG561sduBSrzXZts/Cqxu0cR
         3unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720489805; x=1721094605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95X+KQjG1EcAF+s4nXnBBH4JFb1AoTt7PneQ/KBaA0s=;
        b=Dw8qAV6Xu/B2i02AbPahjcp1lkKqVOREAtRKriy4LQgKe3CjUk0bj8s1jU67KqIjQ9
         bq2td5US4xEcD23Chj3Os33D4D3iRhMrcFXbU6BGtk+VQsQY3UGAM8asKifNTjO9ylkH
         /SHcj7+FoE49J6XaN7MPi+i0dvhSNicsT9tygOOZTjl+9sJPr23KA2tBrKkrokrGtSTN
         kxHqX3X5RHg1Nviq7CSR+f/zC5Ht6F6Kt7sCucAdzQaTK8+VOaL9MolsBn/vThYLnDJt
         ZAtiUl5i0fN7gouLtOxHRKAy9bNYjnWa0+EJVXAxVXfA4NoDPxdHplNr7y6GdcmfE6LN
         lqTw==
X-Forwarded-Encrypted: i=1; AJvYcCUXqSYSzzEKQlmy1qG80kjHpkvJznfBwpLq/iBou3SgdRaMEwltW0qMUfz+TmoxzREZMw21iMAQQOEr1FAMBvjHYZafDVyD
X-Gm-Message-State: AOJu0Yy9rE0mrxCyQ56QnL0KGp5dNLJcpxPR/BW+JzYfkyJdgsQkdEMO
	s2qGafkFZhIHCqvGSwAhVxDdJylSI18Q3EFGnCORosHZFiEJUgHIsXG6Ea5J8LOT1ZLXkWeNRQl
	CvtRMI1j2Wgh4byUbHR82xN5vfZ0=
X-Google-Smtp-Source: AGHT+IHC/D/Cj23tJjAFI6Ojkg9Ke4fMQwk+1Mzoacdllj+Tyv4TORkURzbEuMZ558ZsAwh5iePg5vSxV6zB/h0SS0w=
X-Received: by 2002:a05:6e02:1c22:b0:375:a185:f00f with SMTP id
 e9e14a558f8ab-38a5910a99bmr14794515ab.22.1720489805627; Mon, 08 Jul 2024
 18:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org> <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
 <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org> <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
 <20240619201959.GA1513@breakpoint.cc> <CADvbK_dAB3iHmM=nkbxGJca2c_1J-NK3R4241b3RAvV8Q9Q+QQ@mail.gmail.com>
 <20240619212030.GB1513@breakpoint.cc> <CADvbK_dPyPP3wwjLB4pD2o_AqpXEprkn70M7e=8aVoan+vTDGg@mail.gmail.com>
 <CADvbK_fqi=m99e5+5pkHZTuRz7kKWFLZ8CFG3q=mUEtaaKm2hQ@mail.gmail.com> <20240708223839.GA18283@breakpoint.cc>
In-Reply-To: <20240708223839.GA18283@breakpoint.cc>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 8 Jul 2024 21:49:54 -0400
Message-ID: <CADvbK_cYpB07dvyMSGOU3XsAJmZV_feb76hVg9tCJeFjs5iuxA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] openvswitch: set IPS_CONFIRMED in tmpl
 status only when commit is set in conntrack
To: Florian Westphal <fw@strlen.de>
Cc: Ilya Maximets <i.maximets@ovn.org>, network dev <netdev@vger.kernel.org>, dev@openvswitch.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Davide Caratti <dcaratti@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, kuba@kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Aaron Conole <aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 6:38=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Xin Long <lucien.xin@gmail.com> wrote:
> > I can avoid this warning by not allocating ext for commit ct in ovs:
> >
> > @@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct,
> > struct sw_flow_key *key,
> >         struct nf_conn_labels *cl;
> >         int err;
> >
> > -       cl =3D ovs_ct_get_conn_labels(ct);
> > +       cl =3D nf_ct_labels_find(ct);
> >         if (!cl)
> >                 return -ENOSPC;
ovs_ct_get_conn_labels() must be replaced with nf_ct_labels_find() in here
anyway, thinking that the confirmed ct without labels was created in other
places (not by OVS conntrack), the warning may still be triggered when
trying to set labels in OVS after.

> >
> > However, the test case would fail, although the failure can be worked a=
round
> > by setting ct_label in the 1st rule:
> >
> >   table=3D0,priority=3D30,in_port=3D1,ip,nw_dst=3D172.1.1.2,actions=3Dc=
t(commit,nat(dst=3D10.1.1.2:80),exec(set_field:0x01->ct_label),table=3D1)
> >
> > So I'm worrying our change may break some existing OVS user cases.
>
> Then ovs_ct_limit_init() and nf_connlabels_get() need to be called
> once on the first conntrack operatation, regardless if labels are asked
> for or not.
>
> Not nice but still better than current state.
Right, not nice, it undermines the bits check against NF_CT_LABELS_MAX_SIZE=
.

>
> ovs_ct_execute() perhaps?
ovs_ct_execute() is in the hot path, and a better place would be
ovs_ct_copy_action() where the ct for an ovs flow is added.

