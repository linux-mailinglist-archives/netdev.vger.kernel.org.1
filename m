Return-Path: <netdev+bounces-237745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F05C4FDE8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16CD034C7D1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580D32694E;
	Tue, 11 Nov 2025 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZdSMK1Qr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C0326951
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896871; cv=none; b=t29vWLNCADO+RKhJB54FotMHl/b8LbCx7/HW99qPmPUy9ziAkTpTYgUc3lAuMiPl9pSV/ciQ5wtdpBcl+aVNjcanXvhDTcy/9GKgzENXIgRD4ZPGtSPegFdMIyWtPfWa0QOn3q4ChzE3N7FU/EGO1WgP7NUGvR3pYcaAXUHWdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896871; c=relaxed/simple;
	bh=8ISVIKQfO78xo08XD55ShF3e7Tgvdus4g12TrOq3cnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jibjwwFn4tFcwn5uJmnAkX4nKMRNrgRp+k92BvhY1dhqm9TSOXdzI037oLbx0vDI9L3Uv+oR+eGJVcypNU76fwNqdIjAV8Bp1zJPeNweIfPh2PQaXxjmyQmJizSkAJgD3LKPFdzYIYVGmOqfRlEiyndpgJ6HaKxbF3eCMNINsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZdSMK1Qr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso93991a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762896869; x=1763501669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukH96olnWYwR6HgfvBJjpA/I9yriMbEJ4ZOqEcsaZVM=;
        b=ZdSMK1QrPJ5FbhD1fIjePkdNN3mkGkWeXnzP7PRj8QREug3JDToWIyUHaEyoz9trkq
         4R6BvpaOAjEbhYsDPU2IumYcXsRk/c6/bHDD7kS8J3VQtNOkLIhPWaKAyPgbAvtLLrcg
         bSgrRzEkU7haPPrW2BKLLM2FMJBPW/PBZ4wFWytR/jwZH8TtwJMUzsDAn0kuN3gvMLCV
         wEgF0sK2rTENUfDZobto6TQr01JFOBgD3bOc41vCmOEQH7TRwiUEGTW35mgcDYxYVVxv
         XuHVEEl/iJPw5ugqweJigba4xdPdfeKRWCkHEdL68LdHRNDC3T3xneS48/h348UhRxGI
         udOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896869; x=1763501669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ukH96olnWYwR6HgfvBJjpA/I9yriMbEJ4ZOqEcsaZVM=;
        b=Uz22aFKay9EYx0THvp0KqBFNkBIJgPp3OsYXtRUgmRwAMi8tSNM/e/CzLkDArVoxu8
         fN7HdIQjclhz37VM9y2Oazua02DnrdBVqHi3cyJL34gp2C/6w748fAn2RqOXQ6OAj4pa
         WJ/vRx2apFTfEH4RJh/+SpOgNM2dvs9pU8hFFyA7QKhNXedd1zRn6EAR46qDeH1zX414
         Glrhtp8FotO1ZnGRUl+nMepymy+FaAmXWB/euFpquJEOyxfzbzxWnPEWugBBIKFzGbvd
         gl8QzXBtIUMa18PRRyOJXj3CLIgzrytfi/OILjXK3e2l3F5L15RqPjciwP6M4qsAnFf1
         PdmA==
X-Forwarded-Encrypted: i=1; AJvYcCVGoiCzAa/YXuAJjtYOMQZ91Fj7Z8rDsVdN68CydgwvurzJtYcNUSZQhNGsz21zBEuaxA0taUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqbUD5XOPFhhvisZI+59ldmt9Eg0W3It2FruN96bcEnix70wv
	J9zB5O1KyOKC2Pq+3TJLEU2gbxxFzkajZdBuXsE24cYFjpxMJqCnRb3C79lMZJk5rqRCDi2qjy6
	dOz5JywE9LcTcx1SrHUT5PuxkoRTd+880XnGmOdY/
X-Gm-Gg: ASbGncuN3k9ME/iJp4MYi+DAD5S/xVDr3bsPY+x3pv4RuRUpRu1JXWN5eA+LdJBlTbB
	HE/ORBT7915hT2Id2IGRdkRYYRiiPOv+Kd72FC9n1iD2r5NB+3M773lqoeW+oBQ0ZTiKZvfJNOg
	VAYN0TB0990WO16nZPDR4DYS3ESGeRM2IYOdftdCb7pfVC2DI+He6v7ELWv4D607hIlu7q/co3C
	0YqrssR1ciC210ndpkoFIqXwtlChGdOKsK3s4IRGkJx24rPgahF/QWim+7eIWDBidzm
X-Google-Smtp-Source: AGHT+IFJ/BR/i/JqQOX1uHPtiLvN/QaSvor2OfIp2ScXyjYPgvPn5BjAneTqFWIHa1iChxNLBlMqgE+VewtZUCWFrWY=
X-Received: by 2002:a17:902:da88:b0:295:f95a:5122 with SMTP id
 d9443c01a7336-2984ed3700amr9450215ad.15.1762896868989; Tue, 11 Nov 2025
 13:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com> <6913437c.a70a0220.22f260.013b.GAE@google.com>
 <CANn89iKgYo=f+NyOVFfLjkYLczWsqopxt4F5adutf5eY9TAJmA@mail.gmail.com>
 <CANn89iJ5p3xY_LJcexq8n2-91A6ERPV6yqjPGphD_w6wr_NHew@mail.gmail.com>
 <CANn89iKLDetsEpMrFU4F_XbTF_N0ranLkzJvf1qG=o-ecfseZg@mail.gmail.com> <CA+NMeC9boCccv944JsADbbkp8T8rRDy_ce__m_ETut0059o7DQ@mail.gmail.com>
In-Reply-To: <CA+NMeC9boCccv944JsADbbkp8T8rRDy_ce__m_ETut0059o7DQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Nov 2025 16:34:17 -0500
X-Gm-Features: AWmQ_bk8LvlqKlzMpgUJkMWo3TH82gab_1CI2vi5Ouc84qxG7n0RGNZDR1tPFOk
Message-ID: <CAM0EoMkx3rpiATyoqirtsiRhGALVcMvT_DL4yicLCQmB3_ZUAQ@mail.gmail.com>
Subject: Re: [syzbot ci] Re: net_sched: speedup qdisc dequeue
To: Victor Nogueira <victor@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	syzbot ci <syzbot+ci51c71986dfbbfee2@syzkaller.appspotmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, eric.dumazet@gmail.com, 
	horms@kernel.org, jiri@resnulli.us, kuba@kernel.org, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, toke@redhat.com, 
	willemb@google.com, xiyou.wangcong@gmail.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:04=E2=80=AFPM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> Hi Eric,
>
> On Tue, Nov 11, 2025 at 4:44=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Nov 11, 2025 at 11:23=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Tue, Nov 11, 2025 at 8:28=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Tue, Nov 11, 2025 at 6:09=E2=80=AFAM syzbot ci
> > > > <syzbot+ci51c71986dfbbfee2@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > syzbot ci has tested the following series
> > > > >
> > > > > [v2] net_sched: speedup qdisc dequeue
> > > > > [...]
> > > > > and found the following issue:
> > > > > WARNING in sk_skb_reason_drop
> > > > >
> > > > > Full report is available here:
> > > > > https://ci.syzbot.org/series/a9dbee91-6b1f-4ab9-b55d-43f7f50de064
> > > > >
> > > > > ***
> > > > >
> > > > > WARNING in sk_skb_reason_drop
> > > > > [...]
> > > struct bpf_skb_data_end {
> > >   struct qdisc_skb_cb qdisc_cb;
> > >   void *data_meta;
> > >    void *data_end;
> > > };
> > >
> > > So anytime BPF calls bpf_compute_data_pointers(), it overwrites
> > > tc_skb_cb(skb)->drop_reason,
> > > because offsetof(   ..., data_meta) =3D=3D offsetof(... drop_reason)
> > >
> > > CC Victor and Daniel
> >
> > Quick and dirty patch to save/restore the space.
> >
> > diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> > index 7fbe42f0e5c2b7aca0a28c34cd801c3a767c804e..004d8fe2f29d89bd7df82d9=
0b7a1e2881f7a463b
> > 100644
> > --- a/net/sched/cls_bpf.c
> > +++ b/net/sched/cls_bpf.c
> > @@ -82,11 +82,16 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_bu=
ff *skb,
> >                                        const struct tcf_proto *tp,
> >                                        struct tcf_result *res)
> >  {
> > +       struct bpf_skb_data_end *cb =3D (struct bpf_skb_data_end *)skb-=
>cb;
> >         struct cls_bpf_head *head =3D rcu_dereference_bh(tp->root);
> >         bool at_ingress =3D skb_at_tc_ingress(skb);
> >         struct cls_bpf_prog *prog;
> > +       void *save[2];
> >         int ret =3D -1;
> >
> > +       save[0] =3D cb->data_meta;
> > +       save[1] =3D cb->data_end;
> > +
> >         list_for_each_entry_rcu(prog, &head->plist, link) {
> >                 int filter_res;
> >
> > @@ -133,7 +138,8 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_bu=
ff *skb,
> >
> >                 break;
> >         }
> > -
> > +       cb->data_meta =3D save[0];
> > +       cb->data_end =3D save[1];
> >         return ret;
> >  }
>
> I think you are on the right track.
> Maybe we can create helper functions for this.
> Something like bpf_compute_and_save_data_end [1] and
> and bpf_restore_data_end [2], but for data_meta as well.
> Also, I think we might have the same issue in tcf_bpf_act [3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/i=
nclude/linux/filter.h#n907
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/i=
nclude/linux/filter.h#n917
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/n=
et/sched/act_bpf.c#n50
>

Digging a bit - when you send the fixes, this overwritting i believe
was introduced in:
commit db58ba45920255e967cc1d62a430cebd634b5046

+Cc Alexei

> cheers,
> Victor

