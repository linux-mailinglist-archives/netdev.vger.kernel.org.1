Return-Path: <netdev+bounces-77497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46726871F42
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA01B25C17
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3046C5F858;
	Tue,  5 Mar 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZESlcrHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEF58ABA
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641853; cv=none; b=pZ2y8GcYcPtddz2I29sH8lyQ9Qw63eDJ0eXhSKczqLScb0DmMKo5U6EDtl3b/oryiFAZH5rroopccKzoSMw7Zii9GEOHq1PQsAF1x6gZ+aoEIGAr8oPpdweFBsgULk0N430STKe5aso9z4XH8W8LOpj1VUf/bZMyu3W3P5RHirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641853; c=relaxed/simple;
	bh=SZLK8P2ADiENGbW04b9z23zC/UqppzTLuGKz8QEUmJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOoTBCxFLIcaRlvFpzHaB07h1v/j7s4K5q+ToTkw+uHeRreDQo7A4BoLQi6qIVAMWeu2OS3dIj+2DfxZSQ1AB6z2nKsEMz21oDBQcLhh660NkK1b3Hno+wdwR+5FSy4QWleGQSjCtOCJwbqtQvUlHNCI7cS+LQ83nkm8OQCaQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZESlcrHk; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4990740276.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 04:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709641848; x=1710246648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTEvrdVpxvNz6j/baH9InbN4N4UJFFvSmq9qNcU5dkY=;
        b=ZESlcrHkCePIs9tyuoszzVGUvNHk6a+7L+B+2njeoPkHInOTRlbhmRXosvNJxNplvx
         6Nrk0AZSQFkIswY/qPdueokzSfqj7wCZl8V4eDVNKCHc5P4TwYZAlgsVBdgUlYzIBp1N
         LNNswJg/US35Wfoy/A02RPH4EaT9Keno/08Hksb1eeug5+EydsMMmF4JNW1xdb7BkZTS
         2cVCuZUNtX5rlgEE8Xt/7gAuOreNe47eEOV7B7jLqdku7xKiDS88c3zILqruCiFz0HAg
         HC4iwKNrOXRUpY/VEhKDs/CSfBgs6nHuIUYE4kZdNovq/hv5RtriRPD71LTaTDFqPiq/
         L1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641848; x=1710246648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTEvrdVpxvNz6j/baH9InbN4N4UJFFvSmq9qNcU5dkY=;
        b=WIVA703vGUz4F3wvpw76XQoQq6gtIVbcKe6sfKKBa2kS7aUvCEQ+yc0Pn2mPUgt5ny
         D41Ll7cjRzOknWVtrFrQYc4OYa/C98CKGKRr/1zq1DADDe2xkvlLt16n3kOEPAM6fuso
         5GnMnNY9Y/NYThb5TQc95Dmb59BiaYh2S+dkeUqpgDiplPgkn/66aSe7b5G6NS4tJORz
         CXVEoqC8R6qmdPsjJeHh+wSYJAbXviN1ljUXO2tWewyMD8TlYnkC95y728/QgDSkQcCS
         eKZbiWF1yDOcPysSGOKOjOe3F59Yexa6JL53gMztPyaQEbWEe9f6dY3Yvo/zX6DLfTj/
         oEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcB4umNQWbr9UwJpWl07Ec56FBTTra3rAT1LIbDLrN0wFFToXiWCc4tAS2wRYP5C5kUcmehe53WMm/ShGJbTEJKnbD0QnV
X-Gm-Message-State: AOJu0YyWQze0udtHh/spzxpUilS3TgchWDIcVpiwT+4ATsZzw5W8UlTJ
	tqu56cJfz0RbzC8QYFPAyojw0Fel7je9EyVLCSzim7Ar4lEnt5NFkIUJ4KGKeCjoHA4FeHaxOEq
	ph6JgEIcQz4sfSfcFXyfOx2K9PpLxjAP9RcMq
X-Google-Smtp-Source: AGHT+IEiK4FnyRl5wMGbnd3eCLkbDlfnfgw31wOOQ1r6LU9gMsHDcT84GXZ2c4GKp0DwHfG51kgxez2P4bw8wfZi98w=
X-Received: by 2002:a25:d50b:0:b0:dc6:bcd5:9503 with SMTP id
 r11-20020a25d50b000000b00dc6bcd59503mr7911133ybe.48.1709641848686; Tue, 05
 Mar 2024 04:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-15-jhs@mojatatu.com>
 <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev> <CAM0EoMniOaKn4W_WN9rmQZ1JY3qCugn34mmqCy9UdCTAj_tuTQ@mail.gmail.com>
 <f88b5f65-957e-4b5d-8959-d16e79372658@linux.dev> <CAM0EoMk=igKT5ZEwcfdQqP6O3u8tO7VOpkNsWE1b92ia2eZVpw@mail.gmail.com>
 <496c78b7-4e16-42eb-a2f4-99472cd764fd@linux.dev>
In-Reply-To: <496c78b7-4e16-42eb-a2f4-99472cd764fd@linux.dev>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 5 Mar 2024 07:30:37 -0500
Message-ID: <CAM0EoMmB0s5WzZ-CgGWBF9YdaWi7O0tHEj+C8zuryGhKz7+FpA@mail.gmail.com>
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

On Tue, Mar 5, 2024 at 2:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 3/3/24 9:20 AM, Jamal Hadi Salim wrote:
>
> >>>>> +#define P4TC_MAX_PARAM_DATA_SIZE 124
> >>>>> +
> >>>>> +struct p4tc_table_entry_act_bpf {
> >>>>> +     u32 act_id;
> >>>>> +     u32 hit:1,
> >>>>> +         is_default_miss_act:1,
> >>>>> +         is_default_hit_act:1;
> >>>>> +     u8 params[P4TC_MAX_PARAM_DATA_SIZE];
> >>>>> +} __packed;
> >>>>> +
> >>>>> +struct p4tc_table_entry_act_bpf_kern {
> >>>>> +     struct rcu_head rcu;
> >>>>> +     struct p4tc_table_entry_act_bpf act_bpf;
> >>>>> +};
> >>>>> +
> >>>>>     struct tcf_p4act {
> >>>>>         struct tc_action common;
> >>>>>         /* Params IDR reference passed during runtime */
> >>>>>         struct tcf_p4act_params __rcu *params;
> >>>>> +     struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
> >>>>>         u32 p_id;
> >>>>>         u32 act_id;
> >>>>>         struct list_head node;
> >>>>> @@ -24,4 +40,39 @@ struct tcf_p4act {
> >>>>>
> >>>>>     #define to_p4act(a) ((struct tcf_p4act *)a)
> >>>>>
> >>>>> +static inline struct p4tc_table_entry_act_bpf *
> >>>>> +p4tc_table_entry_act_bpf(struct tc_action *action)
> >>>>> +{
> >>>>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf;
> >>>>> +     struct tcf_p4act *p4act =3D to_p4act(action);
> >>>>> +
> >>>>> +     act_bpf =3D rcu_dereference(p4act->act_bpf);
> >>>>> +
> >>>>> +     return &act_bpf->act_bpf;
> >>>>> +}
> >>>>> +
> >>>>> +static inline int
> >>>>> +p4tc_table_entry_act_bpf_change_flags(struct tc_action *action, u3=
2 hit,
> >>>>> +                                   u32 dflt_miss, u32 dflt_hit)
> >>>>> +{
> >>>>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf, *act_bpf_old;
> >>>>> +     struct tcf_p4act *p4act =3D to_p4act(action);
> >>>>> +
> >>>>> +     act_bpf =3D kzalloc(sizeof(*act_bpf), GFP_KERNEL);
> >>>>
> >>>>
> >>>> [ ... ]
>
>
> >>>>> +static int
> >>>>> +__bpf_p4tc_entry_create(struct net *net,
> >>>>> +                     struct p4tc_table_entry_create_bpf_params *pa=
rams,
> >>>>> +                     void *key, const u32 key__sz,
> >>>>> +                     struct p4tc_table_entry_act_bpf *act_bpf)
> >>>>> +{
> >>>>> +     struct p4tc_table_entry_key *entry_key =3D key;
> >>>>> +     struct p4tc_pipeline *pipeline;
> >>>>> +     struct p4tc_table *table;
> >>>>> +
> >>>>> +     if (!params || !key)
> >>>>> +             return -EINVAL;
> >>>>> +     if (key__sz !=3D P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
> >>>>> +             return -EINVAL;
> >>>>> +
> >>>>> +     pipeline =3D p4tc_pipeline_find_byid(net, params->pipeid);
> >>>>> +     if (!pipeline)
> >>>>> +             return -ENOENT;
> >>>>> +
> >>>>> +     table =3D p4tc_tbl_cache_lookup(net, params->pipeid, params->=
tblid);
> >>>>> +     if (!table)
> >>>>> +             return -ENOENT;
> >>>>> +
> >>>>> +     if (entry_key->keysz !=3D table->tbl_keysz)
> >>>>> +             return -EINVAL;
> >>>>> +
> >>>>> +     return p4tc_table_entry_create_bpf(pipeline, table, entry_key=
, act_bpf,
> >>>>> +                                        params->profile_id);
> >>>>
> >>>> My understanding is this kfunc will allocate a "struct
> >>>> p4tc_table_entry_act_bpf_kern" object. If the bpf_p4tc_entry_delete(=
) kfunc is
> >>>> never called and the bpf prog is unloaded, how the act_bpf object wi=
ll be
> >>>> cleaned up?
> >>>>
> >>>
> >>> The TC code takes care of this. Unloading the bpf prog does not affec=
t
> >>> the deletion, it is the TC control side that will take care of it. If
> >>> we delete the pipeline otoh then not just this entry but all entries
> >>> will be flushed.
> >>
> >> It looks like the "struct p4tc_table_entry_act_bpf_kern" object is all=
ocated by
> >> the bpf prog through kfunc and will only be useful for the bpf prog bu=
t not
> >> other parts of the kernel. However, if the bpf prog is unloaded, these=
 bpf
> >> specific objects will be left over in the kernel until the tc pipeline=
 (where
> >> the act_bpf_kern object resided) is gone.
> >>
> >> It is the expectation on bpf prog (not only tc/xdp bpf prog) about res=
ources
> >> clean up that these bpf objects will be gone after unloading the bpf p=
rog and
> >> unpinning its bpf map.
> >>
> >
> > The table (residing on the TC side) could be shared by multiple bpf
> > programs. Entries are allocated on the TC side of the fence.
>
>
> > IOW, the memory is not owned by the bpf prog but rather by pipeline.
>
> The struct p4tc_table_entry_act_(bpf_kern) object is allocated by
> bpf_p4tc_entry_create() kfunc and only bpf prog can use it, no?
> afaict, this is bpf objects.
>

Bear with me because i am not sure i am following.
When we looked at conntrack as guidance we noticed they do things
slightly differently. They have an allocate kfunc and an insert
function. If you have alloc then you need a complimentary release. The
existence of the release in conntrack, correct me if i am wrong, seems
to be based on the need to free the object if an insert fails. In our
case the insert does first allocate then inserts all in one operation.
If either fails it's not the concern of the bpf side to worry about
it. IOW, i see the ownership as belonging to the P4TC side  (it is
both allocated, updated and freed by that side). Likely i am missing
something..

> > We do have a "whodunnit" field, i.e we keep track of which entity
> > added an entry and we are capable of deleting all entries when we
> > detect a bpf program being deleted (this would be via deleting the tc
> > filter). But my thinking is we should make that a policy decision as
> > opposed to something which is default.
>
> afaik, this policy decision or cleanup upon tc filter delete has not been=
 done
> yet. I will leave it to you to figure out how to track what was allocated=
 by a
> particular bpf prog on the TC side. It is not immediately clear to me and=
 I
> probably won't have a good idea either.
>

I am looking at the conntrack code and i dont see how they release
entries from the cotrack table when the bpf prog goes away.

> Just to be clear that it is almost certain to be unacceptable to extend a=
nd make
> changes on the bpf side in the future to handle specific resource
> cleanup/tracking/sharing of the bpf objects allocated by these kfuncs. Th=
is
> problem has already been solved and works for different bpf program types=
,
> tc/cgroup/tracing...etc. Adding a refcnted bpf prog pointer alongside the
> act_bpf_kern object will be a non-starter.
>
> I think multiple people have already commented that these kfuncs
> (create/update/delete...) resemble the existing bpf map. If these kfuncs =
are
> replaced with the bpf map ops, this bpf resource management has already b=
een
> handled and will be consistent with other bpf program types.
>
> I expect the act_bpf_kern object probably will grow in size over time als=
o.
> Considering this new p4 pipeline and table is residing on the TC side, I =
will
> leave it up to others to decide if it is acceptable to have some unused b=
pf
> objects left attached there.

There should be no dangling things at all.
Probably not a very good example, but this would be analogous to
pinning a map which is shared by many bpf progs. Deleting one or all
the bpf progs doesnt delete the contents of the bpf map, you have to
explicitly remove it. Deleting the pipeline will be equivalent to
deleting the map. IOW, resource cleanup is tied to the pipeline...

cheers,
jamal

