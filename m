Return-Path: <netdev+bounces-58114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8658E815175
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 21:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B504D1C21CFE
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 20:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025846558;
	Fri, 15 Dec 2023 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gL0tFLy+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AE4654D
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e4f221d7abso3727087b3.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702673930; x=1703278730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZjpXCVq9rAErEVoW3aY8wed0E5j1Ft7UBhuszEpMDY=;
        b=gL0tFLy+paclfVWsVowA5LRxcbAZhHpFT4pr40OG1bEVvyKIpDpQozsPqDdMhrRGGi
         csFKG1fhIFh1q2JhcfyazRr88CnBdwbniWTxz1d/pV2kLTU6Z4KJvpnBWiUj74osiHag
         sQMMPpsXkdp8GkAxaZJMoeLHcYywzUBOjBW79av3dZII+9OfJBfz/BqwuFakUxYJUOEo
         h/N68d4Ip4qjUvww/YqQEHPASVW9HH4wk6EES9ah7j4NQZI5Zcupp9eNbW4rGpIwyU3L
         /d5IZkTFK22MgqvzL+2MbUlieX1zHe3KG/B82xRDVPeuLuw5wu8N0QuwiUEzQKg84SF8
         EIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702673930; x=1703278730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZjpXCVq9rAErEVoW3aY8wed0E5j1Ft7UBhuszEpMDY=;
        b=OYvYGC5vMHsetoK2dNJaS7V4OTEoy5/3RivjrnzsWNfFoa8I4h7cWOTGutZCS9NRc8
         0sQ8cbidFUU+UM45kfuG35fo9sYJywBDHSJxeDXzhraRgM0bSi1rmj/BR782F9HkBSgv
         0HO8Kft8AC5oyJvVmmY+juSBpIzaD+bsVxP1n62zJJ4SVy6tWWY5XTL0ZAWkdbiS6ucz
         i7pyex2szXWpo0i7Z9ngIN7r+q+nJHGpNerXJoKnew71INMfgEIZLsrzfPIlVRXm7tmz
         CetHwnm1qsajfv5MuOXklqrdazi/GYY8t2X/ihbmCgOmb0OPtZtUy5H1Lxhw22S1UoJc
         S5Dw==
X-Gm-Message-State: AOJu0Yz0gQc3h0AWOc5ixEdJuFiqDWAuVQWYc2nJ6pkHOYIfLIV9ndh0
	i12d/Ed6y5ayDw451NLTpdau/tvraeRpKIUk5AjSKw==
X-Google-Smtp-Source: AGHT+IG1A97yY34a691MlIK8KMYIbemOV/PRhMO1q9AkacOL6szwefP3hsIeSqUfwEBjkZifzfpRwB1KQz0+87YMAH4=
X-Received: by 2002:a0d:c083:0:b0:5d7:1941:357a with SMTP id
 b125-20020a0dc083000000b005d71941357amr9176990ywd.97.1702673929785; Fri, 15
 Dec 2023 12:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215111050.3624740-1-victor@mojatatu.com> <20231215111050.3624740-2-victor@mojatatu.com>
 <ZXxVQ0E-kd-ab3XD@nanopsycho> <CAAFAkD8Tx9TALNdHrwH19dKzRNaWNKKeQ-Tvd1DrwgT0MfxdJA@mail.gmail.com>
 <ZXx2Ml5m4I4v4J33@nanopsycho> <CAAFAkD9t-b_gs8AWOCHOF_8Qr5NTrWJVLJJhqcE1uv+XVs_7Bw@mail.gmail.com>
 <ZXyXAjWrWh_Zstyt@nanopsycho>
In-Reply-To: <ZXyXAjWrWh_Zstyt@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 15 Dec 2023 15:58:38 -0500
Message-ID: <CAM0EoMnK1eTJaFAYaKKO=nDmzP0JSSkv3pYJtMq274iYYp1kJw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net/sched: Introduce tc block netdev
 tracking infra
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com, 
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:12=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Dec 15, 2023 at 06:17:27PM CET, hadi@mojatatu.com wrote:
> >On Fri, Dec 15, 2023 at 10:52=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> Fri, Dec 15, 2023 at 03:35:01PM CET, hadi@mojatatu.com wrote:
> >> >On Fri, Dec 15, 2023 at 8:31=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> >> >>
> >> >> Fri, Dec 15, 2023 at 12:10:48PM CET, victor@mojatatu.com wrote:
> >> >> >This commit makes tc blocks track which ports have been added to t=
hem.
> >> >> >And, with that, we'll be able to use this new information to send
> >> >> >packets to the block's ports. Which will be done in the patch #3 o=
f this
> >> >> >series.
> >> >> >
> >> >> >Suggested-by: Jiri Pirko <jiri@nvidia.com>
> >> >> >Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >> >Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >> >Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> >> >> >Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> >> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >> >> >---
> >> >> > include/net/sch_generic.h |  4 +++
> >> >> > net/sched/cls_api.c       |  2 ++
> >> >> > net/sched/sch_api.c       | 55 ++++++++++++++++++++++++++++++++++=
+++++
> >> >> > net/sched/sch_generic.c   | 31 ++++++++++++++++++++--
> >> >> > 4 files changed, 90 insertions(+), 2 deletions(-)
> >> >> >
> >> >> >diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> >> >> >index dcb9160e6467..cefca55dd4f9 100644
> >> >> >--- a/include/net/sch_generic.h
> >> >> >+++ b/include/net/sch_generic.h
> >> >> >@@ -19,6 +19,7 @@
> >> >> > #include <net/gen_stats.h>
> >> >> > #include <net/rtnetlink.h>
> >> >> > #include <net/flow_offload.h>
> >> >> >+#include <linux/xarray.h>
> >> >> >
> >> >> > struct Qdisc_ops;
> >> >> > struct qdisc_walker;
> >> >> >@@ -126,6 +127,8 @@ struct Qdisc {
> >> >> >
> >> >> >       struct rcu_head         rcu;
> >> >> >       netdevice_tracker       dev_tracker;
> >> >> >+      netdevice_tracker       in_block_tracker;
> >> >> >+      netdevice_tracker       eg_block_tracker;
> >> >> >       /* private data */
> >> >> >       long privdata[] ____cacheline_aligned;
> >> >> > };
> >> >> >@@ -457,6 +460,7 @@ struct tcf_chain {
> >> >> > };
> >> >> >
> >> >> > struct tcf_block {
> >> >> >+      struct xarray ports; /* datapath accessible */
> >> >> >       /* Lock protects tcf_block and lifetime-management data of =
chains
> >> >> >        * attached to the block (refcnt, action_refcnt, explicitly=
_created).
> >> >> >        */
> >> >> >diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> >> >> >index dc1c19a25882..6020a32ecff2 100644
> >> >> >--- a/net/sched/cls_api.c
> >> >> >+++ b/net/sched/cls_api.c
> >> >> >@@ -531,6 +531,7 @@ static void tcf_block_destroy(struct tcf_block=
 *block)
> >> >> > {
> >> >> >       mutex_destroy(&block->lock);
> >> >> >       mutex_destroy(&block->proto_destroy_lock);
> >> >> >+      xa_destroy(&block->ports);
> >> >> >       kfree_rcu(block, rcu);
> >> >> > }
> >> >> >
> >> >> >@@ -1002,6 +1003,7 @@ static struct tcf_block *tcf_block_create(st=
ruct net *net, struct Qdisc *q,
> >> >> >       refcount_set(&block->refcnt, 1);
> >> >> >       block->net =3D net;
> >> >> >       block->index =3D block_index;
> >> >> >+      xa_init(&block->ports);
> >> >> >
> >> >> >       /* Don't store q pointer for blocks which are shared */
> >> >> >       if (!tcf_block_shared(block))
> >> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >> >> >index e9eaf637220e..09ec64f2f463 100644
> >> >> >--- a/net/sched/sch_api.c
> >> >> >+++ b/net/sched/sch_api.c
> >> >> >@@ -1180,6 +1180,57 @@ static int qdisc_graft(struct net_device *d=
ev, struct Qdisc *parent,
> >> >> >       return 0;
> >> >> > }
> >> >> >
> >> >> >+static int qdisc_block_add_dev(struct Qdisc *sch, struct net_devi=
ce *dev,
> >> >> >+                             struct nlattr **tca,
> >> >> >+                             struct netlink_ext_ack *extack)
> >> >> >+{
> >> >> >+      const struct Qdisc_class_ops *cl_ops =3D sch->ops->cl_ops;
> >> >> >+      struct tcf_block *in_block =3D NULL;
> >> >> >+      struct tcf_block *eg_block =3D NULL;
> >> >>
> >> >> No need to null.
> >> >>
> >> >> Can't you just have:
> >> >>         struct tcf_block *block;
> >> >>
> >> >>         And use it in both ifs? You can easily obtain the block aga=
in on
> >> >>         the error path.
> >> >>
> >> >
> >> >It's just easier to read.
> >>
> >> Hmm.
> >>
> >> >
> >> >> >+      int err;
> >> >> >+
> >> >> >+      if (tca[TCA_INGRESS_BLOCK]) {
> >> >> >+              /* works for both ingress and clsact */
> >> >> >+              in_block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRES=
S, NULL);
> >> >> >+              if (!in_block) {
> >> >>
> >> >> I don't see how this could happen. In fact, why exactly do you chec=
k
> >> >> tca[TCA_INGRESS_BLOCK]?
> >> >>
> >> >
> >> >It's lazy but what is wrong with doing that?
> >>
> >> It's not needed, that's wrong.
> >>
> >
> >Are you ok with the proposal i made?
>
> Not sure what you mean here.

I was referring to the suggestion I made. Ok, this is going nowhere;
we'll just do _exactly_ what you said ;->

>
> >
> >>
> >> >
> >> >> At this time, the clsact/ingress init() function was already called=
, you
> >> >> can just do:
> >> >>
> >> >>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >> >>         if (block) {
> >> >>                 err =3D xa_insert(&block->ports, dev->ifindex, dev,=
 GFP_KERNEL);
> >> >>                 if (err) {
> >> >>                         NL_SET_ERR_MSG(extack, "Ingress block dev i=
nsert failed");
> >> >>                         return err;
> >> >>                 }
> >> >>                 netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL=
);
> >> >>         }
> >> >>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >> >>         if (block) {
> >> >>                 err =3D xa_insert(&block->ports, dev->ifindex, dev,=
 GFP_KERNEL);
> >> >>                 if (err) {
> >> >>                         NL_SET_ERR_MSG(extack, "Egress block dev in=
sert failed");
> >> >>                         goto err_out;
> >> >>                 }
> >> >>                 netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL=
);
> >> >>         }
> >> >>         return 0;
> >> >>
> >> >> err_out:
> >> >>         block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >> >>         if (block) {
> >> >>                 xa_erase(&block->ports, dev->ifindex);
> >> >>                 netdev_put(dev, &sch->in_block_tracker);
> >> >>         }
> >> >>         return err;
> >> >>
> >> >> >+                      NL_SET_ERR_MSG(extack, "Shared ingress bloc=
k missing");
> >> >> >+                      return -EINVAL;
> >> >> >+              }
> >> >> >+
> >> >> >+              err =3D xa_insert(&in_block->ports, dev->ifindex, d=
ev, GFP_KERNEL);
> >> >> >+              if (err) {
> >> >> >+                      NL_SET_ERR_MSG(extack, "Ingress block dev i=
nsert failed");
> >> >> >+                      return err;
> >> >> >+              }
> >> >> >+
> >> >
> >> >How about a middle ground:
> >> >        in_block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >> >        if (in_block) {
> >> >                err =3D xa_insert(&in_block->ports, dev->ifindex, dev=
,
> >> >GFP_KERNEL);
> >> >                if (err) {
> >> >                        NL_SET_ERR_MSG(extack, "ingress block dev
> >> >insert failed");
> >> >                        return err;
> >> >                }
> >> >                netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL)
> >> >      }
> >> >       eg_block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >> >        if (eg_block) {
> >> >                err =3D xa_insert(&eg_block->ports, dev->ifindex, dev=
,
> >> >GFP_KERNEL);
> >> >                if (err) {
> >> >                        netdev_put(dev, &sch->eg_block_tracker);
> >> >                        NL_SET_ERR_MSG(extack, "Egress block dev
> >> >insert failed");
> >> >                        xa_erase(&in_block->ports, dev->ifindex);
> >> >                        netdev_put(dev, &sch->in_block_tracker);
> >> >                        return err;
> >> >                }
> >> >                netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
> >> >        }
> >> >        return 0;
> >> >
> >> >> >+              netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL=
);
> >> >>
> >> >> Why exactly do you need an extra reference of netdev? Qdisc is alre=
ady
> >> >> having one.
> >> >
> >> >More fine grained tracking.
> >>
> >> Again, good for what exactly?
> >
> >We do xa_insert(&eg_block->ports, dev->ifindex, dev,...) which calls
> >for a hold on the dev.
>
> Why you need to take a reference for it exactly? You already hold a
> reference for qdisc, why is that not enough?
>

Justification is:
We added the device on a new list/xarray (as you saw on the patch). To
keep track of it we incr the refcnt when it's added to the xarray and
decr when it is removed. It certainly helped when we were debugging
the code - in case of failures the trace was very nicely descriptive.
We could remove it.

cheers,
jamal

>
> >Then we need to track that for debugging; so, instead of incrementing
> >the same qdisc tracker again for each of those inserts we keep a
> >separate tracker.
> >
> >cheers,
> >jamal
> >
> >>
> >> >
> >> >>
> >> >> >+      }
> >> >> >+
> >> >> >+      if (tca[TCA_EGRESS_BLOCK]) {
> >> >> >+              eg_block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS=
, NULL);
> >> >> >+              if (!eg_block) {
> >> >> >+                      NL_SET_ERR_MSG(extack, "Shared egress block=
 missing");
> >> >> >+                      err =3D -EINVAL;
> >> >> >+                      goto err_out;
> >> >> >+              }
> >> >> >+
> >> >> >+              err =3D xa_insert(&eg_block->ports, dev->ifindex, d=
ev, GFP_KERNEL);
> >> >> >+              if (err) {
> >> >> >+                      NL_SET_ERR_MSG(extack, "Egress block dev in=
sert failed");
> >> >> >+                      goto err_out;
> >> >> >+              }
> >> >> >+              netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL=
);
> >> >> >+      }
> >> >> >+
> >> >> >+      return 0;
> >> >> >+err_out:
> >> >> >+      if (in_block) {
> >> >> >+              xa_erase(&in_block->ports, dev->ifindex);
> >> >> >+              netdev_put(dev, &sch->in_block_tracker);
> >> >> >+      }
> >> >> >+      return err;
> >> >> >+}
> >> >> >+
> >> >> > static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlat=
tr **tca,
> >> >> >                                  struct netlink_ext_ack *extack)
> >> >> > {
> >> >> >@@ -1350,6 +1401,10 @@ static struct Qdisc *qdisc_create(struct ne=
t_device *dev,
> >> >> >       qdisc_hash_add(sch, false);
> >> >> >       trace_qdisc_create(ops, dev, parent);
> >> >> >
> >> >> >+      err =3D qdisc_block_add_dev(sch, dev, tca, extack);
> >> >> >+      if (err)
> >> >> >+              goto err_out4;
> >> >> >+
> >> >> >       return sch;
> >> >> >
> >> >> > err_out4:
> >> >> >diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> >> >> >index 8dd0e5925342..32bed60dea9f 100644
> >> >> >--- a/net/sched/sch_generic.c
> >> >> >+++ b/net/sched/sch_generic.c
> >> >> >@@ -1050,7 +1050,11 @@ static void qdisc_free_cb(struct rcu_head *=
head)
> >> >> >
> >> >> > static void __qdisc_destroy(struct Qdisc *qdisc)
> >> >> > {
> >> >> >-      const struct Qdisc_ops  *ops =3D qdisc->ops;
> >> >> >+      struct net_device *dev =3D qdisc_dev(qdisc);
> >> >> >+      const struct Qdisc_ops *ops =3D qdisc->ops;
> >> >> >+      const struct Qdisc_class_ops *cops;
> >> >> >+      struct tcf_block *block;
> >> >> >+      u32 block_index;
> >> >> >
> >> >> > #ifdef CONFIG_NET_SCHED
> >> >> >       qdisc_hash_del(qdisc);
> >> >> >@@ -1061,11 +1065,34 @@ static void __qdisc_destroy(struct Qdisc *=
qdisc)
> >> >> >
> >> >> >       qdisc_reset(qdisc);
> >> >> >
> >> >> >+      cops =3D ops->cl_ops;
> >> >> >+      if (ops->ingress_block_get) {
> >> >> >+              block_index =3D ops->ingress_block_get(qdisc);
> >> >> >+              if (block_index) {
> >> >>
> >> >> I don't follow. What you need block_index for? Why can't you just c=
all:
> >> >>         block =3D cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
> >> >> right away?
> >> >
> >> >Good point.
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >>
> >> >> >+                      block =3D cops->tcf_block(qdisc, TC_H_MIN_I=
NGRESS, NULL);
> >> >> >+                      if (block) {
> >> >> >+                              if (xa_erase(&block->ports, dev->if=
index))
> >> >> >+                                      netdev_put(dev, &qdisc->in_=
block_tracker);
> >> >> >+                      }
> >> >> >+              }
> >> >> >+      }
> >> >> >+
> >> >> >+      if (ops->egress_block_get) {
> >> >> >+              block_index =3D ops->egress_block_get(qdisc);
> >> >> >+              if (block_index) {
> >> >> >+                      block =3D cops->tcf_block(qdisc, TC_H_MIN_E=
GRESS, NULL);
> >> >> >+                      if (block) {
> >> >> >+                              if (xa_erase(&block->ports, dev->if=
index))
> >> >> >+                                      netdev_put(dev, &qdisc->eg_=
block_tracker);
> >> >> >+                      }
> >> >> >+              }
> >> >> >+      }
> >> >> >+
> >> >> >       if (ops->destroy)
> >> >> >               ops->destroy(qdisc);
> >> >> >
> >> >> >       module_put(ops->owner);
> >> >> >-      netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
> >> >> >+      netdev_put(dev, &qdisc->dev_tracker);
> >> >> >
> >> >> >       trace_qdisc_destroy(qdisc);
> >> >> >
> >> >> >--
> >> >> >2.25.1
> >> >> >

