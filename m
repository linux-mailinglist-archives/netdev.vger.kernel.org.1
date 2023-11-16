Return-Path: <netdev+bounces-48454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D17EE620
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6620B1C208A3
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F01482D3;
	Thu, 16 Nov 2023 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRoDn6uG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D7A5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 09:48:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc30bf9e22so8255805ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 09:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700156887; x=1700761687; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VDVOkFM35A6XlieuXe05/rvDEFLMVMfOweYDBT9mYaY=;
        b=XRoDn6uGlWFLL1+qIHl/gN3vLT+8OD3sx8tR0syd6WJb5ecmIN7ERB1yUKYA2ibvCp
         uv9KA8j55c9UDmYRH1EG/sZQBnMPcr8WmySVBmkpChm4vivuT4M46JJ07UdbLpQ0KoZ+
         Ymj7hCSIiL6+u+UH4lEW7v3QAqoD5Vx3Byiz05DRdg+KvQQjeIDKZMVd5ATXv8P9uWF8
         ALMr4A1PyYS80vLU5yQImKDv1+OXmvFqFoq2sFAkAOS0FUaCPJa5E+rVc56R9DVMRNUc
         GER83Wdx71blWIy0LBJIs7yFbXfA47Ueo5YzCyjBTkteSYcyPi7DTEProRAm/A4RCOut
         qxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700156887; x=1700761687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDVOkFM35A6XlieuXe05/rvDEFLMVMfOweYDBT9mYaY=;
        b=Ko76uC9DZehta+hUhPSTwFegXf+YHeyN6rX1Bren9ux3in2Ay/Je333jFM3iB33Z5D
         jLAYnRqF5LEtlX9HrURLMAYbY0hnFtbK8KR9TB6U6wpYhPM3wUE+K8WIs+prig0xGTPv
         UyTap148tOVzApvHdMPv8ayxt+w1iNjUnM2IUXwOiVdVb0ZKYgU7D8Xs47QBppbyescT
         5trtbiDjOY2G8u+4bzzfl6G8KM/xmP+sDZuPCAxriyd4elyE4v7xJ/D9si4QXAXbLzRH
         qd3+g0HkhsJXcNdfKspyYrLCxfxWRAq5bCwFf09EGg0/xLgAyUaht9thbIEuP5XWY/Tw
         wdfQ==
X-Gm-Message-State: AOJu0Yw7zbj3K7DD5qC+mnQB7Xq/YpjmrJXq+U/naXB1+dd8YJaFeTVy
	XTGSQArStiiKu/24IzTC4hk=
X-Google-Smtp-Source: AGHT+IGvl28KPsX61xqrmIZHifidx5iAS1CeHTgQ/OWzDEYw9wOkqecutJjJSYonwCuZNJsGgptZwA==
X-Received: by 2002:a17:902:e5cd:b0:1cc:33e7:95f5 with SMTP id u13-20020a170902e5cd00b001cc33e795f5mr3474726plf.33.1700156887114;
        Thu, 16 Nov 2023 09:48:07 -0800 (PST)
Received: from t14s.localdomain ([2804:29b8:5086:6485:61b4:61a6:e9fe:e6ca])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db8600b001cc4e477861sm9440823pld.212.2023.11.16.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 09:48:06 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 467C07D7C55; Thu, 16 Nov 2023 14:48:04 -0300 (-03)
Date: Thu, 16 Nov 2023 14:48:04 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net] net: sched: do not offload flows with a helper in
 act_ct
Message-ID: <ZVZV1KLhmuC/Nb2V@t14s.localdomain>
References: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
 <CAM0EoMmnzonWhGY7Di2wgrt--hJf5TrcCObPnkOuehLuiziKdw@mail.gmail.com>
 <CADvbK_fBwMohTb7eHBC5gosgfBUoeRw2uOPmE6SFRUC0isCL7A@mail.gmail.com>
 <CAM0EoMmMMMyxsktxCezjw-oePU-Lqsw2MMwMA5_hOLXiv5i4WA@mail.gmail.com>
 <ZVX+prlJ2EfB3kuF@t14s.localdomain>
 <CAM0EoMkue6_7G-_BWEDbjuEYPfjSCXdnmvMsEG+QUWAfJNoz4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkue6_7G-_BWEDbjuEYPfjSCXdnmvMsEG+QUWAfJNoz4A@mail.gmail.com>

On Thu, Nov 16, 2023 at 10:29:39AM -0500, Jamal Hadi Salim wrote:
> Hi Marcelo,

heya!

> 
> On Thu, Nov 16, 2023 at 6:36 AM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Wed, Nov 15, 2023 at 11:37:51AM -0500, Jamal Hadi Salim wrote:
> > > Hi Xin,
> > >
> > > On Tue, Nov 14, 2023 at 10:18 AM Xin Long <lucien.xin@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 13, 2023 at 4:37 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > > > >
> > > > > On Mon, Nov 13, 2023 at 12:53 PM Xin Long <lucien.xin@gmail.com> wrote:
> > > > > >
> > > > > > There is no hardware supporting ct helper offload. However, prior to this
> > > > > > patch, a flower filter with a helper in the ct action can be successfully
> > > > > > set into the HW, for example (eth1 is a bnxt NIC):
> > > > > >
> > > > > >   # tc qdisc add dev eth1 ingress_block 22 ingress
> > > > > >   # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
> > > > > >     dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
> > > > > >   # tc filter show dev eth1 ingress
> > > > > >
> > > > > >     filter block 22 protocol ip pref 49152 flower chain 0 handle 0x1
> > > > > >       eth_type ipv4
> > > > > >       ip_proto tcp
> > > > > >       dst_port 21
> > > > > >       ct_state -trk
> > > > > >       skip_sw
> > > > > >       in_hw in_hw_count 1   <----
> > > > > >         action order 1: ct zone 0 helper ipv4-tcp-ftp pipe
> > > > > >          index 2 ref 1 bind 1
> > > > > >         used_hw_stats delayed
> > > > > >
> > > > > > This might cause the flower filter not to work as expected in the HW.
> > > > > >
> > > > > > This patch avoids this problem by simply returning -EOPNOTSUPP in
> > > > > > tcf_ct_offload_act_setup() to not allow to offload flows with a helper
> > > > > > in act_ct.
> > > > > >
> > > > > > Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> > > > > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > > >
> > > > > I didnt quite follow:
> > > > > The driver accepted the config, but the driver "kind of '' supports
> > > > > it. (enough to not complain and then display it when queried).
> > > > > Should the driver have rejected something it doesnt fully support?
> > > > Hi, Jamal,
> > > >
> > > > The sad thing is now it does not pass the 'helper' param to the HW in
> > > > tcf_ct_offload_act_setup() via struct flow_action_entry, in fact
> > > > flow_action_entry does not even have a member to keep 'helper'.
> > > >
> > > > Since no HW currently supports 'helper', we can stop it setting to HW
> > > > from here for now. In future, if HWs and struct flow_action_entry
> > > > support it, we can set it to the entry and reply on HWs to reject
> > > > it when not supported, as you mentioned above.
> > >
> > > That makes sense - so i am wondering why that was ever added there to
> > > begin with. Would there be any hardware that would have any helper
> > > support? If no, Shouldnt that code be deleted altogether?
> >
> > Not sure if I follow you, Jamal. There's no code at all to pass the
> > helper information down to the drivers. So drivers ended up accepting
> > this flow because they had no idea that a helper was attached to it.
> >
> 
> So is the goal:
> a) if there's a helper it doesnt make sense to offload the flow or
> b) if there's a helper then it(the helper) works in s/w only but the
> flow offload is still legit?

It is #a.

> 
> If it is #a then my question was why is that code even there in the
> offload path...
> Likely i am missing something..

And the part I am missing is, which code are you referring to? :D

This check is being done at tcf_ct_offload_act_setup() because that's
the callback that gets executed when it tries to
serialize/export/whatever act_ct info into flow_action_entry. With
this, it notices that for this instance it can't serialize and aborts
it. AFAIK there isn't an earlier moment on which this check can be
done.

Cheers,
Marcelo

> 
> cheers,
> jamal
> 
> > Then yes, ideally, it should be driver the one to reject the flow that
> > it doesn't support. But as currently zero drivers support it, and I
> > doubt one will in the future [*], this patch simplifies it by instead
> > of adding all the helper stuff to flow_action_entry, to just abort the
> > offload earlier.
> >
> > [*] it requires parsing TCP payload, including over packet boundaries.
> > This is very expensive in hw. And leads to another problem: the HW
> > having to tell the SW stack about new conntrack expectations.
> >
> 
> 
> > Chers,
> > Marcelo
> >
> > >
> > > In any case, to the code correctness:
> > > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > >
> > > cheers,
> > > jamal
> > > > Thanks.
> > > > >
> > > > >
> > > > > cheers,
> > > > > jamal
> > > > >
> > > > > > ---
> > > > > >  include/net/tc_act/tc_ct.h | 9 +++++++++
> > > > > >  net/sched/act_ct.c         | 3 +++
> > > > > >  2 files changed, 12 insertions(+)
> > > > > >
> > > > > > diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
> > > > > > index 8a6dbfb23336..77f87c622a2e 100644
> > > > > > --- a/include/net/tc_act/tc_ct.h
> > > > > > +++ b/include/net/tc_act/tc_ct.h
> > > > > > @@ -58,6 +58,11 @@ static inline struct nf_flowtable *tcf_ct_ft(const struct tc_action *a)
> > > > > >         return to_ct_params(a)->nf_ft;
> > > > > >  }
> > > > > >
> > > > > > +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_action *a)
> > > > > > +{
> > > > > > +       return to_ct_params(a)->helper;
> > > > > > +}
> > > > > > +
> > > > > >  #else
> > > > > >  static inline uint16_t tcf_ct_zone(const struct tc_action *a) { return 0; }
> > > > > >  static inline int tcf_ct_action(const struct tc_action *a) { return 0; }
> > > > > > @@ -65,6 +70,10 @@ static inline struct nf_flowtable *tcf_ct_ft(const struct tc_action *a)
> > > > > >  {
> > > > > >         return NULL;
> > > > > >  }
> > > > > > +static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_action *a)
> > > > > > +{
> > > > > > +       return NULL;
> > > > > > +}
> > > > > >  #endif /* CONFIG_NF_CONNTRACK */
> > > > > >
> > > > > >  #if IS_ENABLED(CONFIG_NET_ACT_CT)
> > > > > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > > > > index 0db0ecf1d110..b3f4a503ee2b 100644
> > > > > > --- a/net/sched/act_ct.c
> > > > > > +++ b/net/sched/act_ct.c
> > > > > > @@ -1549,6 +1549,9 @@ static int tcf_ct_offload_act_setup(struct tc_action *act, void *entry_data,
> > > > > >         if (bind) {
> > > > > >                 struct flow_action_entry *entry = entry_data;
> > > > > >
> > > > > > +               if (tcf_ct_helper(act))
> > > > > > +                       return -EOPNOTSUPP;
> > > > > > +
> > > > > >                 entry->id = FLOW_ACTION_CT;
> > > > > >                 entry->ct.action = tcf_ct_action(act);
> > > > > >                 entry->ct.zone = tcf_ct_zone(act);
> > > > > > --
> > > > > > 2.39.1
> > > > > >

