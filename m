Return-Path: <netdev+bounces-116667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79994B55B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC5D2813E7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA3347B4;
	Thu,  8 Aug 2024 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPgQbCRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B426AF7;
	Thu,  8 Aug 2024 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086748; cv=none; b=hU0rJcS8VGLduXY8vvQtMjHfZKQboODW+JL5kYqUWUPuiZu4uGFVgtPreky4ppGunqTdmB+RDEZlUUA0OO2s+k74OYYLJAODNjqTfpR2GD20vlirwlapjwTEFjoXqVFvMuaCZ+EhXNsMAONd7iAaxvM0tL3H/duLD/DlQjgS74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086748; c=relaxed/simple;
	bh=REQ10ttwDm6+wLDtnnbaYk1jPt+ny07DuQ1uUFe41S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFivhjgJrtiCkqpLMOyS/BozEwnFSEyabNiUJB5G0rXuzO41MUb/CCSW0MAwvLIeFBVbHMjUM7EkKyV/ExwOkqaB+HZmwbSBuZnobHpqo946pRi//dm2tu6+BqEx3LyCEOkTDnBxrnCN/z58BF2dWob4wTcHJYKOxvzXwUqNnfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPgQbCRk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0bfa541c05so420460276.0;
        Wed, 07 Aug 2024 20:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723086746; x=1723691546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4DkdzQoqwKRIlXhrGYGqNQwqX5jYc4OCqRp67sl0j4=;
        b=UPgQbCRkwO9fSrUdQnBTB32udbKIskmDI4/Gusfl9QOO9qigeqIehm/v6QV4LfXgL9
         W0MMvvAnpCc6Jkf6CaLO3SFPSD6hL4SUcfX57Nt3RihEHHbr1DTH+kDEGh+c8/AwNqab
         QP6yWJuX7wi1vuSH3Z+ZDUK6FXBlDcmM/tZWdDLNg3L3AI/6/UANxyDj8d01qEPNApRq
         GZvJa3OSDkmWoIugAfB75CD4OmGqhJ+ZRjbKc9VvUDDYJD2vBO6DBJrtyYfDfg1s/w47
         cA1CYoajxpNQcecnO6dKKsYlwrSaiV/41xgETOlXcxYsjxOWOwTdB5fWDp1Njux1kdZv
         vVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723086746; x=1723691546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4DkdzQoqwKRIlXhrGYGqNQwqX5jYc4OCqRp67sl0j4=;
        b=r1dTN/rLNWAZaX+9JFNb4ZQSPpDSlHknd0T54Qef/SvnF+zssuI8V22rr1T7fRMMN0
         VmYPRg52oJkyEygzFQlToas5HFhn5PP0RmLsFtTBD8Hk/VQe5naMnwRLyoQAxU2PiHQ/
         xECNfMyshEa8CcF/We0EWk2tEPQTjsi3e5KIzm9bH2s5EqT1YkBfdsIbdbwpF9EILpZe
         2GTOkW4ae29Iy3qT9rB3b9ihjs0x21wKG7GfpHTGMbXzvkJVO32y22c7AbWSB1lXVS++
         YTZyP2YoLbEaikM0EYMwadqsr6aXEgvHAxLVHsjvYRv4i/+1XEfJH0v8NbCyrvS3oz9U
         SYhA==
X-Forwarded-Encrypted: i=1; AJvYcCUTiBK7KAaechIuDxOoemWEuxYnMzAsVAQrekOIITeKqoyrD6tL86lY6mjKN869m9gbXtONU8n4owK7RlpiYDbMexZeUnd6rDW0yQNum3VjchWyp88CwUW7WfHqUW6wx1YKfqYf
X-Gm-Message-State: AOJu0YyvuiFtL679OdNQLRueWBEqyoNJhRc5IEglCl9K9lcwTVL58IWJ
	2QDt4pbDVl+WRo5XWd2j/polrxydZC+0ApoJHMUICqqZH91TuvFWN19d8IBgVr8B//1G5Iti6w8
	KXLTlM9bUJGf/2Ck2EoLq8RhGxLA=
X-Google-Smtp-Source: AGHT+IFk0P+JwCiw/ZTL3GQ4sABkzgtJYiUerrFPXoP+c3n7lTYmmD7bpds5kZLhZnd3aEuNyX8E97Vt0l7Nxvvh7hE=
X-Received: by 2002:a05:6902:15c4:b0:e0e:9189:6b2a with SMTP id
 3f1490d57ef6-e0e9db9b5eamr738484276.35.1723086745887; Wed, 07 Aug 2024
 20:12:25 -0700 (PDT)
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
 <CACGkMEtMHn1yympWO5TpWUArVVOkxL6aaKpSVLVmAMcCNxkJag@mail.gmail.com>
In-Reply-To: <CACGkMEtMHn1yympWO5TpWUArVVOkxL6aaKpSVLVmAMcCNxkJag@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Aug 2024 23:11:48 -0400
Message-ID: <CAF=yD-+2SnOzALmisVVBZAKNKrCMv07FdEDP1ov35APNMYOTew@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
To: Jason Wang <jasowang@redhat.com>
Cc: Randy Li <ayaka@soulik.info>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > In that case, a tc egress tc_bpf program may be able to do both.
> > Again, by writing to __sk_buff queue_mapping. Instead of u32 +
> > skbedit.
> >
> > See also
> >
> > "
> > commit 74e31ca850c1cddeca03503171dd145b6ce293b6
> > Author: Jesper Dangaard Brouer <brouer@redhat.com>
> > Date:   Tue Feb 19 19:53:02 2019 +0100
> >
> >     bpf: add skb->queue_mapping write access from tc clsact
> > "
> >
> > But I suppose you could prefer u32 + skbedit.
> >
> > Either way, the pertinent point is that you want to map some flow
> > match to a specific queue id.
> >
> > This is straightforward if all queues are opened and none are closed.
> > But it is not if queues can get detached and attached dynamically.
> > Which I guess you encounter in practice?
> >
> > I'm actually not sure how the current `tfile->queue_index =
> > tun->numqueues;` works in that case. As __tun_detach will do decrement
> > `--tun->numqueues;`. So multiple tfiles could end up with the same
> > queue_index. Unless dynamic detach + attach is not possible.
>
> It is expected to work, otherwise there should be a bug.
>
> > But it
> > seems it is. Jason, if you're following, do you know this?
>
> __tun_detach() will move the last tfile in the tfiles[] array to the
> current tfile->queue_index, and modify its queue_index:
>
>         rcu_assign_pointer(tun->tfiles[index],
>                                    tun->tfiles[tun->numqueues - 1]);
>         ntfile = rtnl_dereference(tun->tfiles[index]);
>         ntfile->queue_index = index;
>         rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
>                                    NULL);
>
>         --tun->numqueues;
>
> tun_attach() will move the detached tfile to the end of the tfiles[]
> array and enable it:
>
>
>         tfile->queue_index = tun->numqueues;
>         ....
>         rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
>         tun->numqueues++;
>

Ah right. Thanks. I had forgotten about that.

So I guess an application that owns all the queues could keep track of
the queue-id to FD mapping. But it is not trivial, nor defined ABI
behavior.

Querying the queue_id as in the proposed patch might not solve the
challenge, though. Since an FD's queue-id may change simply because
another queue was detached. So this would have to be queried on each
detach.

I suppose one underlying question is how important is the mapping of
flows to specific queue-id's? Is it a problem if the destination queue
for a flow changes mid-stream?

