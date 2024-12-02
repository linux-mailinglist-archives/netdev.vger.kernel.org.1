Return-Path: <netdev+bounces-148112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A939E0629
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EA7282A9C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347621FDE1B;
	Mon,  2 Dec 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAuAwp/7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642C1D545
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151804; cv=none; b=Y5V2TVeBBTcfDZuNqwwbi46soCJZIGVhIbl5nj2vLTFXVKgmJzBoRH+qTNCen/Ugrp+RB8Z6X2hnfjD/GhqDCYWnpI6ZDB4xU0V2QHtrP1mNIDraOqeGFItM8yEj1bcZlH689uVAZpqvh0ex3FEJ6cS1XbJtA/0ITZ5uZBI8W/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151804; c=relaxed/simple;
	bh=r1BwUji3WRBDFLGiLL7BFsIN1FkP4OVmHskMKeHAX7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzjPp1e3fr+txNOYTLnzQ7F4XVSEEI17XCA7WZj4Q3u6Fesu/WX4BAzc8P6pm3jir57OlbnXLJZGWep1ra0Eypmk582k02AG17AOX5Jc7j5+YWvRuYw1ofYVUu7sEbL4W0pitlut6bI9D8vSv5WVYHftzV4sLKsQiiBL4riPH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAuAwp/7; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-84198253240so159421739f.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733151802; x=1733756602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWztPZdodoaLQuIjTwtiDTsnLD5QdGik5v5FirC4K3A=;
        b=CAuAwp/7krZ1126kB5snIlXrHN0lvKKPZR+SvreZOssI7GdusqMP0T6loakmOYgLoK
         DjBcm3tLHgnc3K2ZwriAtLqYj1qrla+ryJ53wWD3nw78PJjSmFhaqV9blwQX/fSSS6n7
         fsENyt8iHbCwAoSd7HHXIDzB6lhA5JY5YvZYK/hXLHp+xftWa9y1Ugm4EtlhqxDTbgAT
         +yjPtcf/ZuAj0b0N9UAXzNQyE9DpVIUdMoRiTJA+zUiF/65H9bjm/R9qW/hWk38KCy8K
         LgRaylPGz6rU6/EmLGFu7J3KXCcdssPaQSP41NF72j/HrCCBfvhmc/mr5I0lCzqHusQ5
         QD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151802; x=1733756602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWztPZdodoaLQuIjTwtiDTsnLD5QdGik5v5FirC4K3A=;
        b=pa7zE4Y/whd/yJpocQhhnh+5Je6uc7pUBmnjIMdk5FzamBSL0uhnPL8Z3WlQXk/NX2
         1AuWLphV9tWtRdRz3D1L+t9yJ+xP6O/73Z8ZqovTpFg8usjUcYWQFvyIvmB6S4+7il7Y
         gG2+KZ7Gtgmu5+4CrFy4T/nQM6oUXeLQyxSiQPEi4q57ir43KpW3Uomq9YLN90Ul8WaS
         9rG2sozHEXk5eck0sBoItDQLoOnUAgqVqvPp74jxlxNtFbEuw9IKl9MNew+iD0EuJ62f
         3lu7JUZoNeKTH99wdr1Fb96zvdvU26dwgWqnYuyL4WYnp1rqq761DYMQLR9UrMlxnwt7
         QrmA==
X-Gm-Message-State: AOJu0Yw4ZwbMygXMa8AX4fSWGZBB3/5zWuUCabgRUEs0Sub0DLLqIZDO
	KBlFl63nmtyhkMcSy6uYYmbA4cA24VsECOe8UYpZo736qif+/MfEdWBDrRZg1HcVMJR+vfoQgHO
	ULKHk5yGgU1HA/WTvU0RQgxFHYyk=
X-Gm-Gg: ASbGncujyrEne1+OoJDK5mbcDg2mvTAP5u9AD8796pkrLmJ+NZrA6xZLyeHcJBHYR2o
	hRfLUGOPLL2JYQEBazLmkwGh7FRgfuRDoXx9DVNk++D8x0KzQ/Ny//o8BccCPSfJh
X-Google-Smtp-Source: AGHT+IHpB7m5jsCRzf5tlRKmbjc00LZEl/Qd7lLpbbb5if/ikflmrshcqzqn3pu9c5XtY5WHO9O8fKAMgMsrDSWY+l0=
X-Received: by 2002:a05:6602:160b:b0:843:e507:3e32 with SMTP id
 ca18e2360f4ac-843ed0bdd63mr2417860839f.13.1733151801557; Mon, 02 Dec 2024
 07:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82b053724375528e82a4f21fe1778c59bb50c0.1732568211.git.lucien.xin@gmail.com>
 <Z0kf8QQjeHjDr6IU@pop-os.localdomain>
In-Reply-To: <Z0kf8QQjeHjDr6IU@pop-os.localdomain>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 2 Dec 2024 10:03:10 -0500
Message-ID: <CADvbK_dtGaAs1CofnWzMuhCkb4HBoj3xCWzVa1tEe1m2jE1NuQ@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: fix erspan_opt settings in cls_flower
To: Cong Wang <xiyou.wangcong@gmail.com>, Shuang Li <shuali@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Davide Caratti <dcaratti@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007970cc06284ad95b"

--0000000000007970cc06284ad95b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 8:59=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Mon, Nov 25, 2024 at 03:56:51PM -0500, Xin Long wrote:
> > When matching erspan_opt in cls_flower, only the (version, dir, hwid)
> > fields are relevant. However, in fl_set_erspan_opt() it initializes
> > all bits of erspan_opt and its mask to 1. This inadvertently requires
> > packets to match not only the (version, dir, hwid) fields but also the
> > other fields that are unexpectedly set to 1.
>
> Do you have a test case for this? Please consider adding one (in a
> separate patch) to tools/testing/selftests/tc-testing/.
>
Yes, Shuang Li has one (attached), I will check if she will be able to
add it to selftests.

> >
> > This patch resolves the issue by ensuring that only the (version, dir,
> > hwid) fields are configured in fl_set_erspan_opt(), leaving the other
> > fields to 0 in erspan_opt.
> >
> > Fixes: 79b1011cb33d ("net: sched: allow flower to match erspan options"=
)
> > Reported-by: Shuang Li <shuali@redhat.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  net/sched/cls_flower.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> > index e280c27cb9f9..c89161c5a119 100644
> > --- a/net/sched/cls_flower.c
> > +++ b/net/sched/cls_flower.c
> > @@ -1369,7 +1369,6 @@ static int fl_set_erspan_opt(const struct nlattr =
*nla, struct fl_flow_key *key,
> >       int err;
> >
> >       md =3D (struct erspan_metadata *)&key->enc_opts.data[key->enc_opt=
s.len];
> > -     memset(md, 0xff, sizeof(*md));
> >       md->version =3D 1;
> >
> >       if (!depth)
> > @@ -1398,9 +1397,9 @@ static int fl_set_erspan_opt(const struct nlattr =
*nla, struct fl_flow_key *key,
> >                       NL_SET_ERR_MSG(extack, "Missing tunnel key erspan=
 option index");
> >                       return -EINVAL;
> >               }
> > +             memset(&md->u.index, 0xff, sizeof(md->u.index));
> >               if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX]) {
> >                       nla =3D tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX];
> > -                     memset(&md->u, 0x00, sizeof(md->u));
> >                       md->u.index =3D nla_get_be32(nla);
> >               }
> >       } else if (md->version =3D=3D 2) {
> > @@ -1409,10 +1408,12 @@ static int fl_set_erspan_opt(const struct nlatt=
r *nla, struct fl_flow_key *key,
> >                       NL_SET_ERR_MSG(extack, "Missing tunnel key erspan=
 option dir or hwid");
> >                       return -EINVAL;
> >               }
> > +             md->u.md2.dir =3D 1;
> >               if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR]) {
> >                       nla =3D tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR];
> >                       md->u.md2.dir =3D nla_get_u8(nla);
> >               }
> > +             set_hwid(&md->u.md2, 0x3f);
>
> I think using 0xff is easier to understand, otherwise we would need to
> look into set_hwid() to figure out what 0x3f means. :-/
>
Right, will post v2.

Thanks.

--0000000000007970cc06284ad95b
Content-Type: application/x-sh; name="erspan.V3.sh"
Content-Disposition: attachment; filename="erspan.V3.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_m475r2ee0>
X-Attachment-Id: f_m475r2ee0

IyEvYmluL3NoCnNldCAteAoKaXAgLWFsbCBuZXRucyBkZWwKcm1tb2QgdmV0aApybW1vZCBpcF9n
cmUKcm1tb2QgaXA2X2dyZQpybW1vZCBncmUKCmlwIG5ldG5zIGFkZCB0Y2YxX2MKaXAgbmV0bnMg
YWRkIHRjZjFfcwppcCBuZXRucyBhZGQgdGNmMV9mCgojCiMgdGNmMV9mOgojICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoYnIwKQojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvICAg
IFwKIyAgICAgICAgICAgICAgICAgICAgICAgIChldGgxKSAgICAoZXRoMikKIyAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICB8CiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwt
LS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBIT1NUOiAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICB8CiMgICAgICAgICAgICAgICAgICh2X3RjZjFfcmVw
MSkgICAgKHZfdGNmMV9yZXAyKQojCiMgICAgICAgICAgICAgICAgICAgICAgICAgICAoZXJzcGFu
MSkKIwojICAgICAgICAgICAgICAgICAodl90Y2YxX3BmMSkgICAgICh2X3RjZjFfcGYyKQojICAg
ICAgICAgICAgICAgICBbMTcyLjE2LjQ1LjFdICAgIFsxNzIuMTcuNDUuMV0KIyAgICAgICAgICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8CiMgICAgICAgICAgICAgICAgICh2X3Rj
ZjFfc3cxKSAgICAgKHZfdGNmMV9zdzIpCiMgICAgICAgICAgICAgICAgICAgICAgICAgICAgXCAg
ICAgLwojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoYnIwKQojICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC8gICAgIFwKIyAgICAgICAgICAgICAgICAgKHZfdGNmMV9jKSAgICAgICAg
ICh2X3RjZjFfcykKIyAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICB8
CiMtLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIyB0Y2YxX2M6ICAgICAgICAgICB8ICAgICAgICAgICAgfCAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgdGNmMV9zOgojICAgICAgICAgICAgICAgICAgKGV0aDEp
ICAgICAgICB8ICAgICAgIChldGgxKQojICAgICAgICAgICAgICAgICBbMTcyLjE2LjQ1LjJdICB8
ICAgICAgIFsxNzIuMTcuNDUuMl0KIyAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgfCAg
ICAgICAgICB8CiMgICAgICAgICAgICAgICAgIChlcnNwYW4xKSAgICAgIHwgICAgICAgKGVyc3Bh
bjEpCiMgICAgICAgICAgICAgICAgIFsyMC4yMDcuNDUuMl0gIHwgICAgICAgWzIwLjIwNy40NS4x
XQojICB7MTcyLjE2LjQ1LjIgLT4gMTcyLjE2LjQ1LjF9ICB8ICAgICAgIHsxNzIuMTcuNDUuMSA8
LSAxNzIuMTcuNDUuMn0KIwojIGVyc3BhbjEgLT4gdl90Y2YxX3JlcDE6CiMgICBtYXRjaCBlbmNf
c3JjX2lwIDE3Mi4xNi40NS4yIGVuY19kc3RfaXAgMTcyLjE2LjQ1LjEgZW5jX2tleV9pZCAxMDAw
IGVyc3Bhbl9vcHRzIDI6MDoxOjYzIC0+IHZfdGNmMV9yZXAxCiMgZXJzcGFuMSAtPiB2X3RjZjFf
cmVwMjoKIyAgIG1hdGNoIGVuY19zcmNfaXAgMTcyLjE3LjQ1LjIgZW5jX2RzdF9pcCAxNzIuMTcu
NDUuMSBlbmNfa2V5X2lkIDEwMDAgZXJzcGFuX29wdHMgMjowOjE6NjMgLT4gdl90Y2YxX3JlcDIK
IwojIHZfdGNmMV9yZXAxIC0+IGVyc3BhbjE6CiMgICBzZXQgc3JjX2lwIDE3Mi4xNi40NS4xIGRz
dF9pcCAxNzIuMTYuNDUuMiBpZCAxMDAwIGVyc3Bhbl9vcHRzIDI6MDoxOjYzIC0+IGVyc3BhbjEK
IyB2X3RjZjFfcmVwMiAtPiBlcnNwYW4xOgojICAgc2V0IHNyY19pcCAxNzIuMTcuNDUuMSBkc3Rf
aXAgMTcyLjE3LjQ1LjIgaWQgMTAwMCBlcnNwYW5fb3B0cyAyOjA6MTo2MyAtPiBlcnNwYW4xCiMK
CmlwIGxpbmsgYWRkIG5hbWUgdl90Y2YxX2MgdHlwZSB2ZXRoIHBlZXIgbmFtZSBldGgxIG5ldG5z
IHRjZjFfYwppcCBsaW5rIGFkZCBuYW1lIHZfdGNmMV9zIHR5cGUgdmV0aCBwZWVyIG5hbWUgZXRo
MSBuZXRucyB0Y2YxX3MKaXAgbmV0bnMgZXhlYyB0Y2YxX2MgaXAgbGluayBzZXQgZXRoMSB1cApp
cCBuZXRucyBleGVjIHRjZjFfcyBpcCBsaW5rIHNldCBldGgxIHVwCmlwIGxpbmsgYWRkIG5hbWUg
dl90Y2YxX3BmMSB0eXBlIHZldGggcGVlciBuYW1lIHZfdGNmMV9zdzEKaXAgbGluayBhZGQgbmFt
ZSB2X3RjZjFfcGYyIHR5cGUgdmV0aCBwZWVyIG5hbWUgdl90Y2YxX3N3MgppcCBsaW5rIGFkZCBu
YW1lIGJyMCB0eXBlIGJyaWRnZQppcCBsaW5rIHNldCBicjAgdXAKZm9yIHZ2SUZhY2UgaW4gdl90
Y2YxX2Mgdl90Y2YxX3Mgdl90Y2YxX3N3MSB2X3RjZjFfc3cyOyBkbwoJaXAgbGluayBzZXQgJHZ2
SUZhY2UgbWFzdGVyIGJyMAoJaXAgbGluayBzZXQgJHZ2SUZhY2UgdXAKZG9uZQppcCBsaW5rIGFk
ZCBuYW1lIHZfdGNmMV9yZXAxIHR5cGUgdmV0aCBwZWVyIG5hbWUgZXRoMSBuZXRucyB0Y2YxX2YK
aXAgbGluayBhZGQgbmFtZSB2X3RjZjFfcmVwMiB0eXBlIHZldGggcGVlciBuYW1lIGV0aDIgbmV0
bnMgdGNmMV9mCmZvciB2dklGYWNlIGluIHZfdGNmMV9yZXAxIHZfdGNmMV9yZXAyIHZfdGNmMV9w
ZjEgdl90Y2YxX3BmMjsgZG8KCWlwIGxpbmsgc2V0ICR2dklGYWNlIHVwCmRvbmUKaXAgbmV0bnMg
ZXhlYyB0Y2YxX2YgaXAgbGluayBhZGQgbmFtZSBicjAgdHlwZSBicmlkZ2UKaXAgbmV0bnMgZXhl
YyB0Y2YxX2YgaXAgbGluayBzZXQgYnIwIHVwCmlwIG5ldG5zIGV4ZWMgdGNmMV9mIGlwIGxpbmsg
c2V0IGV0aDEgbWFzdGVyIGJyMAppcCBuZXRucyBleGVjIHRjZjFfZiBpcCBsaW5rIHNldCBldGgy
IG1hc3RlciBicjAKaXAgbmV0bnMgZXhlYyB0Y2YxX2YgaXAgbGluayBzZXQgZXRoMSB1cAppcCBu
ZXRucyBleGVjIHRjZjFfZiBpcCBsaW5rIHNldCBldGgyIHVwCgppcCBuZXRucyBleGVjIHRjZjFf
YyBpcCBhZGRyIGFkZCAxNzIuMTYuNDUuMi8yNCBkZXYgZXRoMQppcCBuZXRucyBleGVjIHRjZjFf
cyBpcCBhZGRyIGFkZCAxNzIuMTcuNDUuMi8yNCBkZXYgZXRoMQppcCBhZGRyIGFkZCAxNzIuMTYu
NDUuMS8yNCBkZXYgdl90Y2YxX3BmMQppcCBhZGRyIGFkZCAxNzIuMTcuNDUuMS8yNCBkZXYgdl90
Y2YxX3BmMgppcCBuZXRucyBleGVjIHRjZjFfYyBpcCByb3V0ZSBhZGQgMTcyLjE3LjQ1LjAvMjQg
dmlhIDE3Mi4xNi40NS4xIGRldiBldGgxCmlwIG5ldG5zIGV4ZWMgdGNmMV9zIGlwIHJvdXRlIGFk
ZCAxNzIuMTYuNDUuMC8yNCB2aWEgMTcyLjE3LjQ1LjEgZGV2IGV0aDEKCmlwIGxpbmsgYWRkIGVy
c3BhbjEgdHlwZSBlcnNwYW4gdHRsIDY0IGV4dGVybmFsCmlwIGxpbmsgc2V0IGVyc3BhbjEgdXAK
CiMgRVJTUEFOIFR5cGUgSUlJIGNvbmZpZ3VyZQppcCBuZXRucyBleGVjIHRjZjFfYyBpcCBsaW5r
IGFkZCBlcnNwYW4xIHR5cGUgZXJzcGFuIGxvY2FsIDE3Mi4xNi40NS4yIHJlbW90ZSAxNzIuMTYu
NDUuMSBzZXEga2V5IDEwMDAgdG9zIEMgdHRsIDY0IGVyc3Bhbl92ZXIgMiBlcnNwYW5fZGlyIGVn
cmVzcyBlcnNwYW5faHdpZCA2MwppcCBuZXRucyBleGVjIHRjZjFfcyBpcCBsaW5rIGFkZCBlcnNw
YW4xIHR5cGUgZXJzcGFuIGxvY2FsIDE3Mi4xNy40NS4yIHJlbW90ZSAxNzIuMTcuNDUuMSBzZXEg
a2V5IDEwMDAgdG9zIEMgdHRsIDY0IGVyc3Bhbl92ZXIgMiBlcnNwYW5fZGlyIGVncmVzcyBlcnNw
YW5faHdpZCA2MwppcCBuZXRucyBleGVjIHRjZjFfYyBpcCBsaW5rIHNldCBlcnNwYW4xIHVwCmlw
IG5ldG5zIGV4ZWMgdGNmMV9zIGlwIGxpbmsgc2V0IGVyc3BhbjEgdXAKCmlwIG5ldG5zIGV4ZWMg
dGNmMV9jIGlwIGFkZHIgYWRkIDIwLjIwNy40NS4yLzI0IGRldiBlcnNwYW4xCmlwIG5ldG5zIGV4
ZWMgdGNmMV9zIGlwIGFkZHIgYWRkIDIwLjIwNy40NS4xLzI0IGRldiBlcnNwYW4xCgppcCBuZXRu
cyBleGVjIHRjZjFfYyBwaW5nIC1JIDE3Mi4xNi40NS4yIDE3Mi4xNi40NS4xIC1jIDMKaXAgbmV0
bnMgZXhlYyB0Y2YxX3MgcGluZyAtSSAxNzIuMTcuNDUuMiAxNzIuMTcuNDUuMSAtYyAzCgoKdGMg
cWRpc2MgYWRkIGRldiB2X3RjZjFfcmVwMSBpbmdyZXNzCnRjIHFkaXNjIGFkZCBkZXYgdl90Y2Yx
X3JlcDIgaW5ncmVzcwp0YyBxZGlzYyBhZGQgZGV2IGVyc3BhbjEgaW5ncmVzcwoKdGMgZmlsdGVy
IGFkZCBkZXYgdl90Y2YxX3JlcDEgaW5ncmVzcyBmbG93ZXIgc2tpcF9odyBhY3Rpb24gdHVubmVs
X2tleSBzZXQgc3JjX2lwIDE3Mi4xNi40NS4xIGRzdF9pcCAxNzIuMTYuNDUuMiBpZCAxMDAwIGVy
c3Bhbl9vcHRzIDI6MDoxOjYzIG5vY3N1bSBhY3Rpb24gbWlycmVkIGVncmVzcyByZWRpcmVjdCBk
ZXYgZXJzcGFuMQp0YyBmaWx0ZXIgYWRkIGRldiB2X3RjZjFfcmVwMiBpbmdyZXNzIGZsb3dlciBz
a2lwX2h3IGFjdGlvbiB0dW5uZWxfa2V5IHNldCBzcmNfaXAgMTcyLjE3LjQ1LjEgZHN0X2lwIDE3
Mi4xNy40NS4yIGlkIDEwMDAgZXJzcGFuX29wdHMgMjowOjE6NjMgbm9jc3VtIGFjdGlvbiBtaXJy
ZWQgZWdyZXNzIHJlZGlyZWN0IGRldiBlcnNwYW4xCnRjIGZpbHRlciBhZGQgZGV2IGVyc3BhbjEg
aW5ncmVzcyBmbG93ZXIgc2tpcF9odyBlbmNfc3JjX2lwIDE3Mi4xNi40NS4yIGVuY19kc3RfaXAg
MTcyLjE2LjQ1LjEgZW5jX2tleV9pZCAxMDAwIGFjdGlvbiB0dW5uZWxfa2V5IHVuc2V0IGFjdGlv
biBtaXJyZWQgZWdyZXNzIHJlZGlyZWN0IGRldiB2X3RjZjFfcmVwMQp0YyBmaWx0ZXIgYWRkIGRl
diBlcnNwYW4xIGluZ3Jlc3MgZmxvd2VyIHNraXBfaHcgZW5jX3NyY19pcCAxNzIuMTcuNDUuMiBl
bmNfZHN0X2lwIDE3Mi4xNy40NS4xIGVuY19rZXlfaWQgMTAwMCBhY3Rpb24gdHVubmVsX2tleSB1
bnNldCBhY3Rpb24gbWlycmVkIGVncmVzcyByZWRpcmVjdCBkZXYgdl90Y2YxX3JlcDIKCmlwIG5l
dG5zIGV4ZWMgdGNmMV9jIHBpbmcgLUkgZXJzcGFuMSAyMC4yMDcuNDUuMSAtYyAzCmlwIG5ldG5z
IGV4ZWMgdGNmMV9zIHBpbmcgLUkgZXJzcGFuMSAyMC4yMDcuNDUuMiAtYyAzCgp0YyBxZGlzYyBk
ZWwgZGV2IGVyc3BhbjEgaW5ncmVzcwp0YyBxZGlzYyBkZWwgZGV2IHZfdGNmMV9yZXAxIGluZ3Jl
c3MKdGMgcWRpc2MgZGVsIGRldiB2X3RjZjFfcmVwMiBpbmdyZXNzCgojIEVSU1BBTiBUeXBlIElJ
SSB0ZXN0aW5nCnRjIHFkaXNjIGFkZCBkZXYgdl90Y2YxX3JlcDEgaW5ncmVzcwp0YyBxZGlzYyBh
ZGQgZGV2IHZfdGNmMV9yZXAyIGluZ3Jlc3MKdGMgcWRpc2MgYWRkIGRldiBlcnNwYW4xIGluZ3Jl
c3MKCnRjIGZpbHRlciBhZGQgZGV2IHZfdGNmMV9yZXAxIGluZ3Jlc3MgZmxvd2VyIHNraXBfaHcg
YWN0aW9uIHR1bm5lbF9rZXkgc2V0IHNyY19pcCAxNzIuMTYuNDUuMSBkc3RfaXAgMTcyLjE2LjQ1
LjIgaWQgMTAwMCBlcnNwYW5fb3B0cyAyOjA6MTo2MyBub2NzdW0gYWN0aW9uIG1pcnJlZCBlZ3Jl
c3MgcmVkaXJlY3QgZGV2IGVyc3BhbjEKdGMgZmlsdGVyIGFkZCBkZXYgdl90Y2YxX3JlcDIgaW5n
cmVzcyBmbG93ZXIgc2tpcF9odyBhY3Rpb24gdHVubmVsX2tleSBzZXQgc3JjX2lwIDE3Mi4xNy40
NS4xIGRzdF9pcCAxNzIuMTcuNDUuMiBpZCAxMDAwIGVyc3Bhbl9vcHRzIDI6MDoxOjYzIG5vY3N1
bSBhY3Rpb24gbWlycmVkIGVncmVzcyByZWRpcmVjdCBkZXYgZXJzcGFuMQp0YyBmaWx0ZXIgYWRk
IGRldiBlcnNwYW4xICAgaW5ncmVzcyBmbG93ZXIgc2tpcF9odyBlbmNfc3JjX2lwIDE3Mi4xNi40
NS4yIGVuY19kc3RfaXAgMTcyLjE2LjQ1LjEgZW5jX2tleV9pZCAxMDAwIGVyc3Bhbl9vcHRzIDI6
MDoxOjYzIGFjdGlvbiB0dW5uZWxfa2V5IHVuc2V0IGFjdGlvbiBtaXJyZWQgZWdyZXNzIHJlZGly
ZWN0IGRldiB2X3RjZjFfcmVwMQp0YyBmaWx0ZXIgYWRkIGRldiBlcnNwYW4xICAgaW5ncmVzcyBm
bG93ZXIgc2tpcF9odyBlbmNfc3JjX2lwIDE3Mi4xNy40NS4yIGVuY19kc3RfaXAgMTcyLjE3LjQ1
LjEgZW5jX2tleV9pZCAxMDAwIGVyc3Bhbl9vcHRzIDI6MDoxOjYzIGFjdGlvbiB0dW5uZWxfa2V5
IHVuc2V0IGFjdGlvbiBtaXJyZWQgZWdyZXNzIHJlZGlyZWN0IGRldiB2X3RjZjFfcmVwMgoKaXAg
bmV0bnMgZXhlYyB0Y2YxX2MgcGluZyAtSSBlcnNwYW4xIDIwLjIwNy40NS4xIC1jIDMKaXAgbmV0
bnMgZXhlYyB0Y2YxX3MgcGluZyAtSSBlcnNwYW4xIDIwLjIwNy40NS4yIC1jIDMKCnRjIC1zIGZp
bHRlciBzaG93IGRldiBlcnNwYW4xIGluZ3Jlc3MKdGMgLXMgZmlsdGVyIHNob3cgZGV2IHZfdGNm
MV9yZXAxIGluZ3Jlc3MKdGMgLXMgZmlsdGVyIHNob3cgZGV2IHZfdGNmMV9yZXAyIGluZ3Jlc3MK
CnRjIHFkaXNjIGRlbCBkZXYgZXJzcGFuMSBpbmdyZXNzCnRjIHFkaXNjIGRlbCBkZXYgdl90Y2Yx
X3JlcDEgaW5ncmVzcwp0YyBxZGlzYyBkZWwgZGV2IHZfdGNmMV9yZXAyIGluZ3Jlc3MK
--0000000000007970cc06284ad95b--

