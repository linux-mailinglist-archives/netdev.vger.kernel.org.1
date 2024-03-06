Return-Path: <netdev+bounces-78109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B32874151
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39DD28301C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024B140E5B;
	Wed,  6 Mar 2024 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Sh54lByy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5E140384
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756548; cv=none; b=W+9lzW/s8XVclrF13QH/6gkZIJy/0fWXFW3KGdEwb1r2VRDtcI7WiL7gnbK2pmgMVjmpxHsjPLZMlzAwrI7IzJ1MSYX0yx+jVLKQ+1Rvzqm+M9VZD+22CAc31oMeH0blh3QeNyzKXQlbnIC2qiuUi4WhjkAiNC0Gb1mXhmLR22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756548; c=relaxed/simple;
	bh=hCKskeWjcP7GWg7M756l+RD7uiiLsJPgNH2f+iFWmzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXXUczdX54LdJFGvO1DnCJlPCbiChdSTMzeMz7wmVJWGh7KKaGwwUz8QwhFgzE9Pw7uMN4+TPPp+zYpUR+1ZmyNz6Cor52WeFu6qmGp7YSwsY+wYiOEjL6cVMZp9Dj7wRSMNIpw8Tu+ZsZZzXTPqI8ACWLxEAkJ1z46T5X992ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Sh54lByy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6095dfcb461so1399557b3.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709756544; x=1710361344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub2+wSpjjuXiMSyu0LAxMbix1pDCmSnWkN5wg/KKB1Q=;
        b=Sh54lByy+oRIfx3LWp4yy+P/yrf259vP0PAWIUtTQ777kaaGfq7MKHa0/dyfxjpbyQ
         Z84WQXoxIxQXQawgyriiPdgmW75RcY/LIQVKO3cyOEHpu3j2kNI4WxGtUitsPMi+AonZ
         mnOeOHi5jcXMDrSuA4f/b8mAb7PDRMmcwH8ooaBUgcjRFtC6SWAKlL65Q4aDZXFV4xp9
         X6O/II3zKv5RMpe5kjbwDttwLAzapdOsBhyojqCT/0O2MNxi6x77Y5M900ljGRRrsbQT
         fFVwZRiY52Px/U8ZSPpFO6tRkY1f+BXoiQ0eQ1tgHjlTDmHpYWkpdwRjDMXKDMSnkSSa
         PM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709756544; x=1710361344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ub2+wSpjjuXiMSyu0LAxMbix1pDCmSnWkN5wg/KKB1Q=;
        b=GRXUDDrjoFn+da2amzeA7Qg023LbBdyEhNpt6lcqENxyVDq8Llw9jyouZ5m86a7feR
         Lo1dDGKFkDmfrSNDwx+qKtLfPyhwtqDinKB/pNzEejCOPRrcTDvKB/lmljpvSNfOmzmO
         VBHBF5B6Zij3+JyXag0OWvj1W4hpOH51OYI8If9DuNqRPY7TLPpjTqYo+Yzi4luR+Pmy
         jTrLGwM7dKM81Vjk2l/s+h2IK7ytFx/CdRzIRXPRMBXb7zEpv126Kf+7eXWHdfz9Tawa
         kVQzOIzXZ9hi+C/42xQpQLioDp0Wm7I0j2OM908idcLEjtsCMv7yuwTJs7nEqf8KRcru
         FWSg==
X-Forwarded-Encrypted: i=1; AJvYcCWe2yhJ8qukxyRkU3OBo0vQVmTOi/kfUsOxm4SzNq05KVX6DsmnBejt21xNZwc6bwuLtWUJQEqHiDB20OBFKjzUBOeuL8tg
X-Gm-Message-State: AOJu0YwQwd0iKvV76z+4vq9qoMtiBY0jnzqWhXQQ2vIpZgRuUXpSRREF
	SnT4EioYaZmhL1F83GRq7cha9oFAXgjlK21Ne1FANNUzEdWIwBRMOurFclXxN9OihuIxtq9JMTK
	NAmi36sA3pb34EsR9M3viWHvx0ovWCwhi0N/loJgh2qctOPoW6A==
X-Google-Smtp-Source: AGHT+IHD7bpKDD6ms90iGDtFELqAGYMH/XlJhvbVS3nXmz0Y0jGhI4sVinBekUBW9scC2cf1dFKe8ea4QhmCa43d5nk=
X-Received: by 2002:a81:a012:0:b0:609:e844:97bf with SMTP id
 x18-20020a81a012000000b00609e84497bfmr826356ywg.12.1709756544051; Wed, 06 Mar
 2024 12:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-15-jhs@mojatatu.com>
 <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev> <CAM0EoMniOaKn4W_WN9rmQZ1JY3qCugn34mmqCy9UdCTAj_tuTQ@mail.gmail.com>
 <f88b5f65-957e-4b5d-8959-d16e79372658@linux.dev> <CAM0EoMk=igKT5ZEwcfdQqP6O3u8tO7VOpkNsWE1b92ia2eZVpw@mail.gmail.com>
 <496c78b7-4e16-42eb-a2f4-99472cd764fd@linux.dev> <CAM0EoMmB0s5WzZ-CgGWBF9YdaWi7O0tHEj+C8zuryGhKz7+FpA@mail.gmail.com>
 <7aaeee73-4197-4ea8-834a-2265ef078bab@linux.dev>
In-Reply-To: <7aaeee73-4197-4ea8-834a-2265ef078bab@linux.dev>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 6 Mar 2024 15:22:12 -0500
Message-ID: <CAM0EoMnkJpBnD5G3CfWnGkzE1cQKDp_mz02BW+aHK4rbTnOQCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 14/15] p4tc: add set of P4TC table kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:58=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 3/5/24 4:30 AM, Jamal Hadi Salim wrote:
> > On Tue, Mar 5, 2024 at 2:40=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >>
> >> On 3/3/24 9:20 AM, Jamal Hadi Salim wrote:
> >>
> >>>>>>> +#define P4TC_MAX_PARAM_DATA_SIZE 124
> >>>>>>> +
> >>>>>>> +struct p4tc_table_entry_act_bpf {
> >>>>>>> +     u32 act_id;
> >>>>>>> +     u32 hit:1,
> >>>>>>> +         is_default_miss_act:1,
> >>>>>>> +         is_default_hit_act:1;
> >>>>>>> +     u8 params[P4TC_MAX_PARAM_DATA_SIZE];
> >>>>>>> +} __packed;
> >>>>>>> +
> >>>>>>> +struct p4tc_table_entry_act_bpf_kern {
> >>>>>>> +     struct rcu_head rcu;
> >>>>>>> +     struct p4tc_table_entry_act_bpf act_bpf;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>>      struct tcf_p4act {
> >>>>>>>          struct tc_action common;
> >>>>>>>          /* Params IDR reference passed during runtime */
> >>>>>>>          struct tcf_p4act_params __rcu *params;
> >>>>>>> +     struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
> >>>>>>>          u32 p_id;
> >>>>>>>          u32 act_id;
> >>>>>>>          struct list_head node;
> >>>>>>> @@ -24,4 +40,39 @@ struct tcf_p4act {
> >>>>>>>
> >>>>>>>      #define to_p4act(a) ((struct tcf_p4act *)a)
> >>>>>>>
> >>>>>>> +static inline struct p4tc_table_entry_act_bpf *
> >>>>>>> +p4tc_table_entry_act_bpf(struct tc_action *action)
> >>>>>>> +{
> >>>>>>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf;
> >>>>>>> +     struct tcf_p4act *p4act =3D to_p4act(action);
> >>>>>>> +
> >>>>>>> +     act_bpf =3D rcu_dereference(p4act->act_bpf);
> >>>>>>> +
> >>>>>>> +     return &act_bpf->act_bpf;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static inline int
> >>>>>>> +p4tc_table_entry_act_bpf_change_flags(struct tc_action *action, =
u32 hit,
> >>>>>>> +                                   u32 dflt_miss, u32 dflt_hit)
> >>>>>>> +{
> >>>>>>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf, *act_bpf_old=
;
> >>>>>>> +     struct tcf_p4act *p4act =3D to_p4act(action);
> >>>>>>> +
> >>>>>>> +     act_bpf =3D kzalloc(sizeof(*act_bpf), GFP_KERNEL);
> >>>>>>
> >>>>>>
> >>>>>> [ ... ]
> >>
> >>
> >>>>>>> +static int
> >>>>>>> +__bpf_p4tc_entry_create(struct net *net,
> >>>>>>> +                     struct p4tc_table_entry_create_bpf_params *=
params,
> >>>>>>> +                     void *key, const u32 key__sz,
> >>>>>>> +                     struct p4tc_table_entry_act_bpf *act_bpf)
> >>>>>>> +{
> >>>>>>> +     struct p4tc_table_entry_key *entry_key =3D key;
> >>>>>>> +     struct p4tc_pipeline *pipeline;
> >>>>>>> +     struct p4tc_table *table;
> >>>>>>> +
> >>>>>>> +     if (!params || !key)
> >>>>>>> +             return -EINVAL;
> >>>>>>> +     if (key__sz !=3D P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
> >>>>>>> +             return -EINVAL;
> >>>>>>> +
> >>>>>>> +     pipeline =3D p4tc_pipeline_find_byid(net, params->pipeid);
> >>>>>>> +     if (!pipeline)
> >>>>>>> +             return -ENOENT;
> >>>>>>> +
> >>>>>>> +     table =3D p4tc_tbl_cache_lookup(net, params->pipeid, params=
->tblid);
> >>>>>>> +     if (!table)
> >>>>>>> +             return -ENOENT;
> >>>>>>> +
> >>>>>>> +     if (entry_key->keysz !=3D table->tbl_keysz)
> >>>>>>> +             return -EINVAL;
> >>>>>>> +
> >>>>>>> +     return p4tc_table_entry_create_bpf(pipeline, table, entry_k=
ey, act_bpf,
> >>>>>>> +                                        params->profile_id);
> >>>>>>
> >>>>>> My understanding is this kfunc will allocate a "struct
> >>>>>> p4tc_table_entry_act_bpf_kern" object. If the bpf_p4tc_entry_delet=
e() kfunc is
> >>>>>> never called and the bpf prog is unloaded, how the act_bpf object =
will be
> >>>>>> cleaned up?
> >>>>>>
> >>>>>
> >>>>> The TC code takes care of this. Unloading the bpf prog does not aff=
ect
> >>>>> the deletion, it is the TC control side that will take care of it. =
If
> >>>>> we delete the pipeline otoh then not just this entry but all entrie=
s
> >>>>> will be flushed.
> >>>>
> >>>> It looks like the "struct p4tc_table_entry_act_bpf_kern" object is a=
llocated by
> >>>> the bpf prog through kfunc and will only be useful for the bpf prog =
but not
> >>>> other parts of the kernel. However, if the bpf prog is unloaded, the=
se bpf
> >>>> specific objects will be left over in the kernel until the tc pipeli=
ne (where
> >>>> the act_bpf_kern object resided) is gone.
> >>>>
> >>>> It is the expectation on bpf prog (not only tc/xdp bpf prog) about r=
esources
> >>>> clean up that these bpf objects will be gone after unloading the bpf=
 prog and
> >>>> unpinning its bpf map.
> >>>>
> >>>
> >>> The table (residing on the TC side) could be shared by multiple bpf
> >>> programs. Entries are allocated on the TC side of the fence.
> >>
> >>
> >>> IOW, the memory is not owned by the bpf prog but rather by pipeline.
> >>
> >> The struct p4tc_table_entry_act_(bpf_kern) object is allocated by
> >> bpf_p4tc_entry_create() kfunc and only bpf prog can use it, no?
> >> afaict, this is bpf objects.
> >>
> >
> > Bear with me because i am not sure i am following.
> > When we looked at conntrack as guidance we noticed they do things
> > slightly differently. They have an allocate kfunc and an insert
> > function. If you have alloc then you need a complimentary release. The
> > existence of the release in conntrack, correct me if i am wrong, seems
> > to be based on the need to free the object if an insert fails. In our
> > case the insert does first allocate then inserts all in one operation.
> > If either fails it's not the concern of the bpf side to worry about
> > it. IOW, i see the ownership as belonging to the P4TC side  (it is
> > both allocated, updated and freed by that side). Likely i am missing
> > something..
>
> It is not the concern about the kfuncs may leak object.
>
> I think my question was, who can use the act_bpf_kern object when all tc =
bpf
> prog is unloaded? If no one can use it, it should as well be cleaned up w=
hen the
> bpf prog is unloaded.
>
> or the kernel p4 pipeline can use the act_bpf_kern object even when there=
 is no
> bpf prog loaded?
>
>
> >
> >>> We do have a "whodunnit" field, i.e we keep track of which entity
> >>> added an entry and we are capable of deleting all entries when we
> >>> detect a bpf program being deleted (this would be via deleting the tc
> >>> filter). But my thinking is we should make that a policy decision as
> >>> opposed to something which is default.
> >>
> >> afaik, this policy decision or cleanup upon tc filter delete has not b=
een done
> >> yet. I will leave it to you to figure out how to track what was alloca=
ted by a
> >> particular bpf prog on the TC side. It is not immediately clear to me =
and I
> >> probably won't have a good idea either.
> >>
> >
> > I am looking at the conntrack code and i dont see how they release
> > entries from the cotrack table when the bpf prog goes away.
> >
> >> Just to be clear that it is almost certain to be unacceptable to exten=
d and make
> >> changes on the bpf side in the future to handle specific resource
> >> cleanup/tracking/sharing of the bpf objects allocated by these kfuncs.=
 This
> >> problem has already been solved and works for different bpf program ty=
pes,
> >> tc/cgroup/tracing...etc. Adding a refcnted bpf prog pointer alongside =
the
> >> act_bpf_kern object will be a non-starter.
> >>
> >> I think multiple people have already commented that these kfuncs
> >> (create/update/delete...) resemble the existing bpf map. If these kfun=
cs are
> >> replaced with the bpf map ops, this bpf resource management has alread=
y been
> >> handled and will be consistent with other bpf program types.
> >>
> >> I expect the act_bpf_kern object probably will grow in size over time =
also.
> >> Considering this new p4 pipeline and table is residing on the TC side,=
 I will
> >> leave it up to others to decide if it is acceptable to have some unuse=
d bpf
> >> objects left attached there.
> >
> > There should be no dangling things at all.
> > Probably not a very good example, but this would be analogous to
> > pinning a map which is shared by many bpf progs. Deleting one or all
> > the bpf progs doesnt delete the contents of the bpf map, you have to
> > explicitly remove it. Deleting the pipeline will be equivalent to
> > deleting the map. IOW, resource cleanup is tied to the pipeline..
>
> bpf is also used by many subsystems (e.g. tracing/cgroup/...). The bpf us=
ers
> have a common expectation on how bpf resources will be cleaned up when wr=
iting
> bpf for different subsystems, i.e. map/link/pinned-file. Thus, p4 pipelin=
e is
> not the same as a pinned bpf map here. The p4-tc bpf user cannot depend o=
n the
> common bpf ecosystem to cleanup all resources.
>

I am not trying to be difficult. Sincerely trying to understand and
very puzzled - and it is not that we cant do what you are suggesting
just trying to understand the reasoning to make sure it fits our
requirements.

I asked earlier about conntrack (where we took the inspiration from):
How is what we are doing different from contrack? If you can help me
understand that i am more than willing to make the change.
Conntrack entries can be added via the kfunc(same for us). Contrack
entries can also be added from the control plane and can be found by
ebpf lookups(same for us). They can be deleted by the control plane,
timers, entry evictions to make space for new entries, etc (same for
us). Not sure if they can be deleted by ebpf side (we can). Perusing
the conntrack code, I could not find anything  that indicated that
entries created from ebpf are deleted when the ebpf program goes away.

To re-emphasize: Maybe there's something subtle i am missing that we
are not doing that conntrack is doing?
Conntrack does one small thing we dont: It allocs and returns to ebpf
the memory for insertion. I dont see that as particularly useful for
our case (and more importantly how that results in the entries being
deleted when the ebpf prog goes away)

cheers,
jamal

> It is going back to how link/fd and the map ops discussion by others in t=
he
> earlier revisions which we probably don't want to redo here. I think I ha=
ve been
> making enough noise such that we don't have to discuss potential future c=
hanges
> about how to release this resources when the bpf prog is unloaded.

