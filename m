Return-Path: <netdev+bounces-116659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5390E94B523
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4891B20DAB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F221119A;
	Thu,  8 Aug 2024 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMc0U4MM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361144C97
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085397; cv=none; b=YP6BLPLvGuT+HTqupfC0ZXsBjIEu5hQ8XQCiJgN7uNxhIqVwrzTuiN6gm36KDrNenCn0nyFlji2JA8sNOXZm0U7CkGNd1A9EJ0tE5gaOyCU1UQyOwD+pZEx3RHmFE25jJJdncRNags5nTyRe+2k0XwtTSO8XCxguJXoMbsqyCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085397; c=relaxed/simple;
	bh=ofSfh0QpBoOjYIP0WEpNH6irf0lpZJ7e9CMTqc9dCx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yp+z8pc3Kp4+bszV/D4XuRB3c2BZAdiyueMgLfe+q6k42AoakkCD7Dfk9QXmYqw+wVNXR86/7iHNT/BYt44fR8iD4l6lB7tZfoWyFrGDJMmDMMHiHAgTvPhdEZAHwSuHHRSeeact8f0EIt4J7hWjPJ5PSvi3YVkKbt9Dxy7G3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMc0U4MM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723085395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Oj53tlzRjk+NzdEKzGd1tP6PFtbWyq+udmkPmf3q+c=;
	b=ZMc0U4MMLXIpioe3hdzoX2EleGUgvqvABmWpwkc22P5qIoBlBHArcyhJ6lpf8f0ugRfi/v
	yweCER3ccI2eLzsI8bBhQQ3m0kAr35RNof85EYrbu4zVpk0UrfdZgfjxxxHFDwznM6lF5E
	sv6GUrDLW1TQSoMFQCvZAv4+SI4Fx+s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-i32bP_0MPHaQE6ooT3HTiQ-1; Wed, 07 Aug 2024 22:49:53 -0400
X-MC-Unique: i32bP_0MPHaQE6ooT3HTiQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb54eac976so666493a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 19:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723085392; x=1723690192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Oj53tlzRjk+NzdEKzGd1tP6PFtbWyq+udmkPmf3q+c=;
        b=qSeSv1eoACrnfKGTn7Qp0vkyYLBOxsmujj2UCxJcuV2JK0JX6EPDDHrKFI2sVbNnuh
         5q7XVViSvxHEQe2TKvnhjzHKgemsASgkk3dLARW2Ui5Jze06yFMQcOqpV/gh3NsQXKCc
         vaVMbrnqxzAaIZo3QfDq5B42tyDmrQOu8dCHVVU5vrtpSQZCKju5xrgbn2+yhwMkAVch
         6uDcdlzvqzIoXP8aCnrtkAqQ+OpPRI36kcTzsIyvSbFtcuLHc9++o6b/3IgLqsAI3Ugs
         /z5AuraNpvNhOOn+hDBGfv66erCOrGQPPlnUEscexHQdfDIWmMhJzi9pqpYEYZ2lt3fF
         WgDw==
X-Forwarded-Encrypted: i=1; AJvYcCW1YP/8qKzK8nWM/cgPZfu2/B4bFdR/mZwg0e/HAL0wnHXf2LJR7dLw7ZA6yZ7K0HRf/qqOywjEQFalFh3IChEVZyVm5Tzc
X-Gm-Message-State: AOJu0YyYlAO3RqULm31PTpEgSTAmm5lh6zEXqYsGrGShtZEPRFZnHU7R
	jMr8JaiypTebXqBgasx3atf6aj1b2vtu3MbnQdZM5NCQGGGApToarZgXfABnHJ2W/qotavFEEUx
	sta2LKG43/pOLDsN1hwfSqNFFHQRnX62KEKtXgavZTTXn7vh45ya3E6wcjquv1rhH5252WAWv6G
	//65wS9muoaljTZMQJTs/r31h1vowv
X-Received: by 2002:a17:90a:9a92:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2d1c337141amr583058a91.5.1723085392561;
        Wed, 07 Aug 2024 19:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBQdjC19LWWSLMg/X5OpdFzsGd1uKQ3nx1S3pP9KLj+JnhQ/oqhDzZGwvF+OLrrtnH3247qa6G/oQL35owmsE=
X-Received: by 2002:a17:90a:9a92:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2d1c337141amr583034a91.5.1723085391934; Wed, 07 Aug 2024
 19:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731111940.8383-1-ayaka@soulik.info> <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
 <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info> <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
 <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info> <66ab87ca67229_2441da294a5@willemb.c.googlers.com.notmuch>
 <343bab39-65c5-4f02-934b-84b6ceed1c20@soulik.info> <66ab99162673_246b0d29496@willemb.c.googlers.com.notmuch>
 <328c71e7-17c7-40f4-83b3-f0b8b40f4730@soulik.info> <66acf6cc551a0_2751b6294bf@willemb.c.googlers.com.notmuch>
 <3a3695a1-367c-4868-b6e1-1190b927b8e7@soulik.info> <CAF=yD-+9HUkzDnfhOgpVkGyeMEJPhzabebt3bdzUHmpEPR1New@mail.gmail.com>
In-Reply-To: <CAF=yD-+9HUkzDnfhOgpVkGyeMEJPhzabebt3bdzUHmpEPR1New@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Aug 2024 10:49:40 +0800
Message-ID: <CACGkMEtMHn1yympWO5TpWUArVVOkxL6aaKpSVLVmAMcCNxkJag@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Randy Li <ayaka@soulik.info>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 10:11=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > >> I think this question is about why I do the filter in the kernel not=
 the
> > >> userspace?
> > >>
> > >> It would be much more easy to the dispatch work in kernel, I only ne=
ed
> > >> to watch the established peer with the help of epoll(). Kernel could
> > >> drop all the unwanted packets. Besides, if I do the filter/dispatche=
r
> > >> work in the userspace, it would need to copy the packet's data to th=
e
> > >> userspace first, even decide its fate by reading a few bytes from it=
s
> > >> beginning offset. I think we can avoid such a cost.
> > > A custom mapping function is exactly the purpose of TUNSETSTEERINGEBP=
F.
> > >
> > > Please take a look at that. It's a lot more elegant than going throug=
h
> > > userspace and then inserting individual tc skbedit filters.
> >
> > I checked how this socket filter works, I think we still need this
> > serial of patch.
> >
> > If I was right, this eBPF doesn't work like a regular socket filter. Th=
e
> > eBPF's return value here means the target queue index not the size of
> > the data that we want to keep from the sk_buf parameter's buf.
>
> TUNSETSTEERINGEBPF is a queue selection mechanism for multi-queue tun dev=
ices.
>
> It replaces the need to set skb->queue_mapping.
>
> See also
>
> "
> commit 96f84061620c6325a2ca9a9a05b410e6461d03c3
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Mon Dec 4 17:31:23 2017 +0800
>
>     tun: add eBPF based queue selection method
> "

Exactly.

>
> > Besides, according to
> > https://ebpf-docs.dylanreimerink.nl/linux/program-type/BPF_PROG_TYPE_SO=
CKET_FILTER/
> >
> > I think the eBPF here can modify neither queue_mapping field nor hash
> > field here.
> >
> > > See SKF_AD_QUEUE for classic BPF and __sk_buff queue_mapping for eBPF=
.
> >
> > Is it a map type BPF_MAP_TYPE_QUEUE?
> >
> > Besides, I think the eBPF in TUNSETSTEERINGEBPF would NOT take
> > queue_mapping.
>
> It obviates the need.
>
> It sounds like you want to both filter and steer to a specific queue. Why=
?
>
> In that case, a tc egress tc_bpf program may be able to do both.
> Again, by writing to __sk_buff queue_mapping. Instead of u32 +
> skbedit.
>
> See also
>
> "
> commit 74e31ca850c1cddeca03503171dd145b6ce293b6
> Author: Jesper Dangaard Brouer <brouer@redhat.com>
> Date:   Tue Feb 19 19:53:02 2019 +0100
>
>     bpf: add skb->queue_mapping write access from tc clsact
> "
>
> But I suppose you could prefer u32 + skbedit.
>
> Either way, the pertinent point is that you want to map some flow
> match to a specific queue id.
>
> This is straightforward if all queues are opened and none are closed.
> But it is not if queues can get detached and attached dynamically.
> Which I guess you encounter in practice?
>
> I'm actually not sure how the current `tfile->queue_index =3D
> tun->numqueues;` works in that case. As __tun_detach will do decrement
> `--tun->numqueues;`. So multiple tfiles could end up with the same
> queue_index. Unless dynamic detach + attach is not possible.

It is expected to work, otherwise there should be a bug.

> But it
> seems it is. Jason, if you're following, do you know this?

__tun_detach() will move the last tfile in the tfiles[] array to the
current tfile->queue_index, and modify its queue_index:

        rcu_assign_pointer(tun->tfiles[index],
                                   tun->tfiles[tun->numqueues - 1]);
        ntfile =3D rtnl_dereference(tun->tfiles[index]);
        ntfile->queue_index =3D index;
        rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
                                   NULL);

        --tun->numqueues;

tun_attach() will move the detached tfile to the end of the tfiles[]
array and enable it:


        tfile->queue_index =3D tun->numqueues;
        ....
        rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
        tun->numqueues++;

>
> > If I want to drop packets for unwanted destination, I think
> > TUNSETFILTEREBPF is what I need?
> >
> > That would lead to lookup the same mapping table twice, is there a
> > better way for the CPU cache?
>
> I agree that two programs should not be needed.
>

Thanks


