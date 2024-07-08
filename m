Return-Path: <netdev+bounces-110038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F592ABB9
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 00:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F19281D20
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A69314D717;
	Mon,  8 Jul 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYnit1iz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3647146D40
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476224; cv=none; b=dyLVGw/rsrt0CEozRh4Yy/7IFQYNd/Rk7pcPGqC8Oor7VZMDNo/h97DyoVJ5xOmUlYRD2oQ1+MNWBgUtdP1O1lLJZxHvQKqQ8H8LKMglUzXeejEFqZqXd6PnFntLE58mZlS/zLmGtgcqs6Me318nNeFKEj8y9HvdGVLe/Ov53VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476224; c=relaxed/simple;
	bh=kvxWMTQtQ1MbgWDL+lt50s8J8/B3eXFMVbWPJCsRg2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxqQ8PXkNrdPDNrtx2bPQFfnKIkzFmxH8ChETzw2nyHBRH7bhF1r433Igtbz5gs5dr/ogxIBgCLN1wlIPvlP0g18eS+FMwRX4KBdSsZlfVWDO9+oYqYgDZs6NCA3qPyLVplVkxqeKKnKE3BeR0S28laNCSu/AXYPHC9N43KSKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYnit1iz; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-376208fbe7bso18076205ab.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720476222; x=1721081022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIHpWYM8VwqHJC3AfVaOtlJLrCIKLGCHNp/hpnQ8nSQ=;
        b=lYnit1izdLeeBqDFX5cVNKetssfQCnse0td5ZG5YfzAol2VshX16PTx/x/+MOTkkQE
         q/GJx41NE4a0PdOxXj2aIj5uDWPULj9V6IMSC8zKoDAGxkdL9wDOv2B3AWIO2rGNO86C
         8iYN2S6qyuJ6+0IInaaRZ7h2Qq1EOdwfcNzyQrWOsuN6/DFr6CosZja+bNs2Ycyp7MmZ
         kU8D0ahuLbRTt422S4otHfKpw1wv+J//hkIJzV9oHhR9LmDu4pcUh/lRWd9YNJOSg0hs
         2wWFKLskugOdVr84677ahuFd//0HxlatV3QQxjgGEOXzkX0afTM6uMZqSSpZwriwebrv
         ZMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476222; x=1721081022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIHpWYM8VwqHJC3AfVaOtlJLrCIKLGCHNp/hpnQ8nSQ=;
        b=gMFlyO6DmF96Pv2u1xHtyXc91Xhy7Q1Wags+RD+YA79/G3AVvBxikYuoC+oLm9hlXe
         U5plQah0OOpkNLRFOo0tj9MgHn2NX/qBzEpmnm9YRWJ2TO6prhpfBnWz3x73dnDZjUyh
         IBmJz2xoSByyj0BrzFYuNKzoOSZkZVVEor4X8oIMtiWBYSd0B9Off9+Iv7nxrOt9MVWn
         nZD10S3iVKyjTJ/V84czCDyZ8ETI12Hti5rsCK6IxWTW3bPH0m1q0QeOODQgWopZS3Py
         qD2xlv0pnzWb9eEAtsjIfY5OztOKLcPPxfgRahjYRrIU6YViSlxv6YrKrl8sq6MFaKU2
         eviA==
X-Forwarded-Encrypted: i=1; AJvYcCWJjvkNcskL9yIILZsKIlmdAW4x2OdYHgSc5ho9lc/NGHlJoNVEswmsmJRODxrPkENutr1rn3GAxN8Zj2ng+VnVwPRovUPt
X-Gm-Message-State: AOJu0YxG405Wj8jIFT1QKfqSMl5SUd9SnuBcy3T1efiJzjOFjevrnz4n
	81u2YNLT6w0PljU6V7SaFGTd1LWWaswc8VQsflcdzI/+RveTtJoc1BfqofriMaEUtpitIX1aInU
	4dock+sjmG/4Aq4Lprz++W5IW//c=
X-Google-Smtp-Source: AGHT+IHTOQJo96pMcJPovgLe2E8BYbg6/nOasSTOt632iTFRUV+26I6+nMiY3Q75lGkUBVjaF+l6Oc7jcRL7/MZMtn4=
X-Received: by 2002:a05:6e02:1c04:b0:375:adcd:e6c3 with SMTP id
 e9e14a558f8ab-38a583981cemr7792625ab.14.1720476221974; Mon, 08 Jul 2024
 15:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d35d01d9-83de-4862-85a7-574a6c4dc8f5@ovn.org> <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
 <CADvbK_f9=smg+C7M3dWWj9nvv7Z7_jCLn=6m0OLhmF_V0AEFsg@mail.gmail.com>
 <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org> <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
 <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org> <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
 <20240619201959.GA1513@breakpoint.cc> <CADvbK_dAB3iHmM=nkbxGJca2c_1J-NK3R4241b3RAvV8Q9Q+QQ@mail.gmail.com>
 <20240619212030.GB1513@breakpoint.cc> <CADvbK_dPyPP3wwjLB4pD2o_AqpXEprkn70M7e=8aVoan+vTDGg@mail.gmail.com>
In-Reply-To: <CADvbK_dPyPP3wwjLB4pD2o_AqpXEprkn70M7e=8aVoan+vTDGg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 8 Jul 2024 18:03:30 -0400
Message-ID: <CADvbK_fqi=m99e5+5pkHZTuRz7kKWFLZ8CFG3q=mUEtaaKm2hQ@mail.gmail.com>
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

On Wed, Jun 19, 2024 at 6:10=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Wed, Jun 19, 2024 at 5:20=E2=80=AFPM Florian Westphal <fw@strlen.de> w=
rote:
> >
> > Xin Long <lucien.xin@gmail.com> wrote:
> > > Got it, I will fix this in ovs.
> >
> > Thanks!
> >
> > I don't want to throw more work at you, but since you are
> > already working on ovs+conntrack:
> >
> > ovs_ct_init() is bad, as this runs unconditionally.
> >
> > modprobe openvswitch -> conntrack becomes active in all
> > existing and future namespaces.
> >
> > Conntrack is slow, we should avoid this behaviour.
> >
> > ovs_ct_limit_init() should be called only when the feature is
> > configured (the problematic call is nf_conncount_init, as that
> > turns on connection tracking, the kmalloc etc is fine).
> understand.
>
> >
> > Likewise, nf_connlabels_get() should only be called when
> > labels are added/configured, not at the start.
> >
> > I resolved this for tc in 70f06c115bcc but it seems i never
> > got around to fix it for ovs.
Hi, Florian,

I noticed the warning in nf_ct_ext_add() while I'm making this change:

   WARN_ON(nf_ct_is_confirmed(ct));

It can be triggered by these ovs flows from ovs selftests:

  table=3D0,priority=3D30,in_port=3D1,ip,nw_dst=3D172.1.1.2,actions=3Dct(co=
mmit,nat(dst=3D10.1.1.2:80),table=3D1)
  table=3D1,ip,actions=3Dct(commit,nat(src=3D10.1.1.240),exec(set_field:0xa=
c->ct_mark,set_field:0xac->ct_label),table=3D2)

The 1st flow creates the ct and commits/confirms it, then the 2nd flow is
setting ct_label on a confirmed ct. With this change, the connlabels ext
is not yet allocated at the time, and then the warning is triggered when
allocating it in nf_ct_ext_add().

tc act_ct action doesn't have this issue, as it returns an error if the
connlabels is not found in tcf_ct_act_set_labels(), instead of allocating i=
t.

I can avoid this warning by not allocating ext for commit ct in ovs:

@@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct,
struct sw_flow_key *key,
        struct nf_conn_labels *cl;
        int err;

-       cl =3D ovs_ct_get_conn_labels(ct);
+       cl =3D nf_ct_labels_find(ct);
        if (!cl)
                return -ENOSPC;

However, the test case would fail, although the failure can be worked aroun=
d
by setting ct_label in the 1st rule:

  table=3D0,priority=3D30,in_port=3D1,ip,nw_dst=3D172.1.1.2,actions=3Dct(co=
mmit,nat(dst=3D10.1.1.2:80),exec(set_field:0x01->ct_label),table=3D1)

So I'm worrying our change may break some existing OVS user cases.

