Return-Path: <netdev+bounces-81424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31A887D77
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 16:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081C21C20A01
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D75A1862F;
	Sun, 24 Mar 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gWhvM8q0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A40182DD
	for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711294077; cv=none; b=NipUkp5ZVibcVxjVn4vBS9EIQC8gj/Bj4GWvBDEVMoIy/WjShkpvJMJ5iE7KKBaVmz06piPeWjtGJzu4TdknsvrIbjP37mz93oJkSOB/md1wVf/SlvjuQKNiQI4JFFUObCftFiSFSiTHPsrqIhbnk+hPQHszw+BWXNILl/nUKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711294077; c=relaxed/simple;
	bh=mSCBOw/+Vv8CWDJ/wf+82gt091FWI0Z0M3RsNYvE71A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4U88R86cfolxx5pQ9tc9+16BvlMhiYFrqaBT7G95hIzDTod16bvh3FBUZoZnQcOUsSOmumXK7EqoO8fvLF6Dw/a4pDpoLpqdKuwsCxuXZUwvy2qCWtwxOzG2tkBBUFNsFo6AXyYJt/TLZtcbM7P11aAhWoqE0uG79O0PrXie2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gWhvM8q0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609fb19ae76so42146467b3.2
        for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711294074; x=1711898874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4tdufT5SpUPLSeoERSbRNSW0UFEDVdM9ThDHhDoc+U=;
        b=gWhvM8q0IsImhefz/ihJUrDOBCV57VTdwpWurHK5W3zw0vZibS8KX/1g0GKUx6G4sD
         PdlDU65uQWgcULiTS4dTkIOPTTYAWlz03phd4/4mAzmvkVjCqvxRbUoU9zeiL+Xe6Ll+
         gHBKVLDv93qd85falUONYTBSgt9oyH4+J+T0MIg2XCT5hD7aAB3ER0C18Pt6oV+FrTau
         KXT+XdQOLnkGq7vBuLyxUpRUQdF5nyEukRLMSTheuuf/dDpjTexxsbOaHc0VssmEPdTn
         R1gkv9zqiMkIusnYCSBTZBqCtlWE85Vxi2hE1gRy7p4zSD14Bk5KlSQLhZlQKfTpvTai
         mT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711294074; x=1711898874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4tdufT5SpUPLSeoERSbRNSW0UFEDVdM9ThDHhDoc+U=;
        b=Vu471KTVV6dyQ0qCZaLgLTbhev9gAtZapWU9mCquNecBdfqFMYmvp6UpwWq5gdVXBu
         teGNtXLlySbmAgeRD7PPg68KR00v3d2v9c03FGmEqi0Ni640DkIGHuIMBOsolfMWYWC7
         UV04Mzm1U4LyN6QIQbhHQnUrB15JbDdP1D/QgKK5IbyOaj9ZYmbmmp0QuqgY7lOw9Ld0
         THFVcgIYlvYP6fjwG0KvdFky45Ye242jHnIldraeLy9CPHU3bRpzUhjD5tnw1iw8V1Sg
         HZduYX061fqaq4JOYmeXtP/lWvOE9Sgbm6nobrUuC3jpIgw8T93SrmwbTzR6qtdQwtgs
         TR+g==
X-Forwarded-Encrypted: i=1; AJvYcCW8uNCFOYAmmbsdNmXYORDwkRbavw0tRwYcl/8yaLQRlsF8dO9ereY6HxQ8QgaZK/66ebfog1GFi9YwUjHl/GRookBCKpm2
X-Gm-Message-State: AOJu0Yw0pWS9+Hsfj03zHNeIL5Qaet6xv+q0mCfc2XEnxEQegEj/4fgX
	exzjS6/pKtW13vP+D3T5Dxz3hE6gpb59EKtJtKPRA8XL4dIk8l5U1+Ov5hxL1hfUdSvCEbwer8z
	REndlSSFxJe1j/MbnHtP3gb68TrKzJfFC4ctvW8J67CbFrgo=
X-Google-Smtp-Source: AGHT+IGPz9CEyPXhYp84m8FnzV+bmjB6tWewOpQhx0WF7bbz/TcYqBlYLG284icE3/3AhtZXHRRizI9CsZPVVjlM03k=
X-Received: by 2002:a0d:f901:0:b0:60a:4c79:c429 with SMTP id
 j1-20020a0df901000000b0060a4c79c429mr3602867ywf.30.1711294074335; Sun, 24 Mar
 2024 08:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314111713.5979-1-renmingshuai@huawei.com>
 <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
 <CAM0EoMkZKvvPVaCGFVTE_P1YCyS-r2b3gq3QRhDuEF=Cm-sY4g@mail.gmail.com>
 <CAM0EoMm+W3X7TG8qjb8LWsBbAQ8_rntr7kwhSTy7Sxk=Yj=R2g@mail.gmail.com>
 <CANn89iL_hfoWTqr+KaKZoO8fKoZdd-xcY040NeSb-WL7pHMLGQ@mail.gmail.com>
 <CAM0EoMkqhmDtpg09ktnkxjAtddvXzwQo4Qh2-LX2r8iqrECogw@mail.gmail.com>
 <CANn89iK2e4csrApZjY+kpR9TwaFpN9rcbRSPtyQnw5P_qkyYfA@mail.gmail.com>
 <CAM0EoMkDexWQ_Rj_=gKMhWzSgQqtbAdyDv8DXgY+nk_2Rp3drg@mail.gmail.com>
 <CANn89iLuYjQGrutsN17t2QARGzn-PY7rscTeHSi0zsWcO-tbTA@mail.gmail.com>
 <CAM0EoM=WCLvjCxkDGSEP-+NqEd2HnieiW8emNoV1LeV6n6w9VQ@mail.gmail.com>
 <CANn89iLjK3vf-yHvKdY=wvOdEeWubB0jt2=5d-1m7dkTYBwBOg@mail.gmail.com>
 <CAM0EoMmYiwDPEqo6TrZ9dWbVdv2Ry3Yz8W-p9u+s6=ZAtZOWhw@mail.gmail.com>
 <CAM0EoMnddJgPYR75qTfxAdKsN3-bRuqXrDMxuwAa3y95iahWFQ@mail.gmail.com>
 <CANn89iKrW4em3Ck=czoR32WBkhqXs7P=K3_dMX9hdv7wVGvKJA@mail.gmail.com>
 <CANn89iLzc7onLZ6c9OJ-8GW8DpoGHFNWagqttZ99hkhRzVpSOg@mail.gmail.com> <CAM0EoM=1DyZsgYnuTjXB88L=41g00pjat+Jq4jThpciXzcEKJQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=1DyZsgYnuTjXB88L=41g00pjat+Jq4jThpciXzcEKJQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 24 Mar 2024 11:27:42 -0400
Message-ID: <CAM0EoM=28nsomF9PniYNtpjD4+=+hVi-dA2befgW0OCz+v0y3Q@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: Eric Dumazet <edumazet@google.com>
Cc: renmingshuai <renmingshuai@huawei.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, vladbu@nvidia.com, netdev@vger.kernel.org, 
	yanan@huawei.com, liaichun@huawei.com, caowangbao@huawei.com, 
	Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000687b0f061469b357"

--000000000000687b0f061469b357
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:34=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Mar 20, 2024 at 2:26=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Mar 20, 2024 at 7:13=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Mar 20, 2024 at 6:50=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> >
> > > Nope, you just have to complete the patch, moving around
> > > dev_xmit_recursion_inc() and dev_xmit_recursion_dec()
> >
> > Untested part would be:
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 303a6ff46e4e16296e94ed6b726621abe093e567..dbeaf67282e8b6ec164d00d=
796c9fd8e4fd7c332
> > 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4259,6 +4259,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> > net_device *sb_dev)
> >          */
> >         rcu_read_lock_bh();
> >
> > +       dev_xmit_recursion_inc();
> > +
> >         skb_update_prio(skb);
> >
> >         qdisc_pkt_len_init(skb);
> > @@ -4331,9 +4333,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> > net_device *sb_dev)
> >                         HARD_TX_LOCK(dev, txq, cpu);
> >
> >                         if (!netif_xmit_stopped(txq)) {
> > -                               dev_xmit_recursion_inc();
> >                                 skb =3D dev_hard_start_xmit(skb, dev, t=
xq, &rc);
> > -                               dev_xmit_recursion_dec();
> >                                 if (dev_xmit_complete(rc)) {
> >                                         HARD_TX_UNLOCK(dev, txq);
> >                                         goto out;
> > @@ -4353,12 +4353,14 @@ int __dev_queue_xmit(struct sk_buff *skb,
> > struct net_device *sb_dev)
> >         }
> >
> >         rc =3D -ENETDOWN;
> > +       dev_xmit_recursion_dec();
> >         rcu_read_unlock_bh();
> >
> >         dev_core_stats_tx_dropped_inc(dev);
> >         kfree_skb_list(skb);
> >         return rc;
> >  out:
> > +       dev_xmit_recursion_dec();
> >         rcu_read_unlock_bh();
> >         return rc;
> >  }
>
> This removed the deadlock but now every packet being redirected will
> be dropped. I was wrong earlier on the tc block because that only
> works on clsact and ingress which are fine not needing this lock.
> Here's a variation of the earlier patch that may work but comes at the
> cost of a new per-cpu increment on the qdisc.
>
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3789,6 +3789,11 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>         if (unlikely(contended))
>                 spin_lock(&q->busylock);
>
> +       if (__this_cpu_read(q->recursion_xmit) > 0) {
> +               //drop
> +       }
> +
> +       __this_cpu_inc(q->recursion_xmit);
>         spin_lock(root_lock);
>         if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
>                 __qdisc_drop(skb, &to_free);
> @@ -3825,6 +3830,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                 }
>         }
>         spin_unlock(root_lock);
> +       __this_cpu_dec(q->recursion_xmit);
>         if (unlikely(to_free))
>                 kfree_skb_list_reason(to_free,
>                                       tcf_get_drop_reason(to_free));
>

And here's a tested version(attached) that fixes both the A->A and A->B->A.

cheers,
jamal

--000000000000687b0f061469b357
Content-Type: text/x-patch; charset="US-ASCII"; name="qdisc-rec-xmit-var-fix.patch"
Content-Disposition: attachment; filename="qdisc-rec-xmit-var-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lu5oa9vf0>
X-Attachment-Id: f_lu5oa9vf0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmggYi9pbmNsdWRlL25ldC9zY2hf
Z2VuZXJpYy5oCmluZGV4IGNlZmUwYzRiZGFlMy4uZjlmOTlkZjAzN2VkIDEwMDY0NAotLS0gYS9p
bmNsdWRlL25ldC9zY2hfZ2VuZXJpYy5oCisrKyBiL2luY2x1ZGUvbmV0L3NjaF9nZW5lcmljLmgK
QEAgLTEyNSw2ICsxMjUsOCBAQCBzdHJ1Y3QgUWRpc2MgewogCXNwaW5sb2NrX3QJCWJ1c3lsb2Nr
IF9fX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9zbXA7CiAJc3BpbmxvY2tfdAkJc2VxbG9jazsKIAor
CXUxNiBfX3BlcmNwdSAgICAgICAgICAgICp4bWl0X3JlY3Vyc2lvbjsKKwogCXN0cnVjdCByY3Vf
aGVhZAkJcmN1OwogCW5ldGRldmljZV90cmFja2VyCWRldl90cmFja2VyOwogCS8qIHByaXZhdGUg
ZGF0YSAqLwpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZGV2LmMgYi9uZXQvY29yZS9kZXYuYwppbmRl
eCA5YTY3MDAzZTQ5ZGIuLjJiNzEyMzg4YzA2ZiAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvZGV2LmMK
KysrIGIvbmV0L2NvcmUvZGV2LmMKQEAgLTM3ODksNiArMzc4OSwxMyBAQCBzdGF0aWMgaW5saW5l
IGludCBfX2Rldl94bWl0X3NrYihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgUWRpc2MgKnEs
CiAJaWYgKHVubGlrZWx5KGNvbnRlbmRlZCkpCiAJCXNwaW5fbG9jaygmcS0+YnVzeWxvY2spOwog
CisJaWYgKF9fdGhpc19jcHVfcmVhZCgqcS0+eG1pdF9yZWN1cnNpb24pID4gMCkgeworCQlfX3Fk
aXNjX2Ryb3Aoc2tiLCAmdG9fZnJlZSk7CisJCXJjID0gTkVUX1hNSVRfRFJPUDsKKwkJZ290byBm
cmVlX3NrYl9saXN0OworCX0KKworCV9fdGhpc19jcHVfaW5jKCpxLT54bWl0X3JlY3Vyc2lvbik7
CiAJc3Bpbl9sb2NrKHJvb3RfbG9jayk7CiAJaWYgKHVubGlrZWx5KHRlc3RfYml0KF9fUURJU0Nf
U1RBVEVfREVBQ1RJVkFURUQsICZxLT5zdGF0ZSkpKSB7CiAJCV9fcWRpc2NfZHJvcChza2IsICZ0
b19mcmVlKTsKQEAgLTM4MjUsNyArMzgzMiw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fZGV2X3ht
aXRfc2tiKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBRZGlzYyAqcSwKIAkJfQogCX0KIAlz
cGluX3VubG9jayhyb290X2xvY2spOworCV9fdGhpc19jcHVfZGVjKCpxLT54bWl0X3JlY3Vyc2lv
bik7CiAJaWYgKHVubGlrZWx5KHRvX2ZyZWUpKQorZnJlZV9za2JfbGlzdDoKIAkJa2ZyZWVfc2ti
X2xpc3RfcmVhc29uKHRvX2ZyZWUsCiAJCQkJICAgICAgdGNmX2dldF9kcm9wX3JlYXNvbih0b19m
cmVlKSk7CiAJaWYgKHVubGlrZWx5KGNvbnRlbmRlZCkpCmRpZmYgLS1naXQgYS9uZXQvc2NoZWQv
c2NoX2FwaS5jIGIvbmV0L3NjaGVkL3NjaF9hcGkuYwppbmRleCA2NWUwNWIwYzk4ZTQuLjZjM2Jj
MWFmZjg5YSAxMDA2NDQKLS0tIGEvbmV0L3NjaGVkL3NjaF9hcGkuYworKysgYi9uZXQvc2NoZWQv
c2NoX2FwaS5jCkBAIC0xMjYwLDYgKzEyNjAsNyBAQCBzdGF0aWMgc3RydWN0IFFkaXNjICpxZGlz
Y19jcmVhdGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKIAlzdHJ1Y3QgUWRpc2MgKnNjaDsKIAlz
dHJ1Y3QgUWRpc2Nfb3BzICpvcHM7CiAJc3RydWN0IHFkaXNjX3NpemVfdGFibGUgKnN0YWI7CisJ
aW50IGNwdTsKIAogCW9wcyA9IHFkaXNjX2xvb2t1cF9vcHMoa2luZCk7CiAjaWZkZWYgQ09ORklH
X01PRFVMRVMKQEAgLTEzNzYsMTEgKzEzNzcsMjIgQEAgc3RhdGljIHN0cnVjdCBRZGlzYyAqcWRp
c2NfY3JlYXRlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCiAJCX0KIAl9CiAKKwlzY2gtPnhtaXRf
cmVjdXJzaW9uID0gYWxsb2NfcGVyY3B1KHUxNik7CisJaWYgKCFzY2gtPnhtaXRfcmVjdXJzaW9u
KSB7CisJCWVyciA9IC1FTk9NRU07CisJCWdvdG8gZXJyX291dDU7CisJfQorCWZvcl9lYWNoX3Bv
c3NpYmxlX2NwdShjcHUpCisJCSgqcGVyX2NwdV9wdHIoc2NoLT54bWl0X3JlY3Vyc2lvbiwgY3B1
KSkgPSAwOworCiAJcWRpc2NfaGFzaF9hZGQoc2NoLCBmYWxzZSk7CiAJdHJhY2VfcWRpc2NfY3Jl
YXRlKG9wcywgZGV2LCBwYXJlbnQpOwogCiAJcmV0dXJuIHNjaDsKIAorZXJyX291dDU6CisJaWYg
KHRjYVtUQ0FfUkFURV0pCisJCWdlbl9raWxsX2VzdGltYXRvcigmc2NoLT5yYXRlX2VzdCk7CiBl
cnJfb3V0NDoKIAkvKiBFdmVuIGlmIG9wcy0+aW5pdCgpIGZhaWxlZCwgd2UgY2FsbCBvcHMtPmRl
c3Ryb3koKQogCSAqIGxpa2UgcWRpc2NfY3JlYXRlX2RmbHQoKS4KZGlmZiAtLWdpdCBhL25ldC9z
Y2hlZC9zY2hfZ2VuZXJpYy5jIGIvbmV0L3NjaGVkL3NjaF9nZW5lcmljLmMKaW5kZXggZmY1MzM2
NDkzNzc3Li5hZmJiZDJlODg1YTQgMTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9zY2hfZ2VuZXJpYy5j
CisrKyBiL25ldC9zY2hlZC9zY2hfZ2VuZXJpYy5jCkBAIC0xMDcwLDYgKzEwNzAsOCBAQCBzdGF0
aWMgdm9pZCBfX3FkaXNjX2Rlc3Ryb3koc3RydWN0IFFkaXNjICpxZGlzYykKIAltb2R1bGVfcHV0
KG9wcy0+b3duZXIpOwogCW5ldGRldl9wdXQoZGV2LCAmcWRpc2MtPmRldl90cmFja2VyKTsKIAor
CWZyZWVfcGVyY3B1KHFkaXNjLT54bWl0X3JlY3Vyc2lvbik7CisKIAl0cmFjZV9xZGlzY19kZXN0
cm95KHFkaXNjKTsKIAogCWNhbGxfcmN1KCZxZGlzYy0+cmN1LCBxZGlzY19mcmVlX2NiKTsK
--000000000000687b0f061469b357--

