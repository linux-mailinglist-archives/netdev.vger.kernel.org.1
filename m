Return-Path: <netdev+bounces-165383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8892A31C8E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7486816782B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8541D5146;
	Wed, 12 Feb 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqDiZ5Gn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B427182B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330093; cv=none; b=YS9YF0aQjQzrYLPuGZ1n7udVS7QEvdCxcPJYl9nfpl/hKaZeAUEzyfMKJd5ZJKo4ODRuGIwvs93laqcWJrBeBuFO+W/Rgt/d1wS1XzUi9xjRut2uC6bX+pykCKpnzXP3HIXtNPeAME6EIItwW9JnfxoB+wZLtOlYnXlX5GUCvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330093; c=relaxed/simple;
	bh=ukfWYSMicySGhmGTJ0cacv4uHmKuEc8XbxCGbO3PH9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgDUo8WcP5HZTlHANWRtfYKac3+UDUUowOCW1sh7OW3Vw7UhvCP+5pdOAQGomiMXT5o+lwrVyk3DSlZUaD7WNxDuLuvaCzkruBYiPY6at6COVRcMvsHjqxOKzF7F8hiylR1nkHNHV1FhJaUuHH3ZpV9cDkGnpwVp8VfVFYhtJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqDiZ5Gn; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d050fdf2ffso18591155ab.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330091; x=1739934891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5BC//duDvrA9RlzNkQTngZyS8dOxX7DGarHOZYfXlk=;
        b=CqDiZ5GnafFBeSidkhxyM0g4K3CjKI1jvf0Ct8a30M7ua21ByEA8kQxOLGM6v1wxRA
         7QNa8sMv/lUJhE4IWLSlidqcoFEkC1suoUgALigmW+VDcxX6Z9pf3lTgue/fkXf63w9u
         uT5AYSUZX6rRZla3d6NwWR6LXK3pCn0nM6qcGomYUH0hK0gr55NMlES4U/f+H+JYbLfl
         VhTByfhKEntx7qudkeNHEbdJx8ESE3o3itMEv/H2WJxq8b+OE2QoDdJ9b3gdcExmgzbn
         Eq6Wa82ortYfp94HEvWlNV2xeAOuQ3TVIfqSdiXynV7Vg27uPVOsIX1snyG3SSzNdFVr
         s57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330091; x=1739934891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5BC//duDvrA9RlzNkQTngZyS8dOxX7DGarHOZYfXlk=;
        b=IUMPyIKyWLUHpPIFdDW5RmwTha5adVs5Uh50ZoqeczmlrurbvxYiepgdPYmIJUvt8e
         eHtf2bWDAQRo23xz0LhtQ6j97NkMXq8lerPYifmRBNiqtQkA7QXRyZjDLxphi8hh9mrH
         j3GeEilGwjTNxEfr1AhR9QlnVc4YrErhKgW3vhzSlFUP6255Pn5sB+uz1VbMPbik8BhB
         9Ws0ryWYizp8XbijATdv3QWl0bh8zNVIhw8hvfWrVISP95HicBchJAyFT3iVry7K82XP
         d4F3gK6R71MOYCVdxK48xRP7jP3RiXPN51H4NxZg1PmKt8yee0pZztu1yjzk2YUWy3Fa
         nDnA==
X-Forwarded-Encrypted: i=1; AJvYcCW6VQksTMcYWJvp6URJl1N8ZDDzZ0VRm1oUKgogl3cQrSbcINDWXC53Q0NtEa46sV05Jy2PyOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsl+KFmihsN8KcgX1KziZ+PJNJXFdXKC/vUH68HEK3YOcOah6Z
	hLBs7ri3CVAF2RQBlxpYNZqT1kNiwNfSQ1A82/AOUr005oTXd/jcaAo2ETO/Bm6XGbEn/k6GagA
	ENlFbG+ozHWlbPKpskG2GyBQleBs=
X-Gm-Gg: ASbGnctGYUrq3BP0bUT20+CNno/MHLgBQtOJTcydyV6/TZxO6CbYQH2eZNWBis2EY1l
	fMgrt/RwCh1yawVLOqNKrGCNYz2svmFJprN2WcljPiTYabxGeG6xFiJXDA0aKs8jVqSTKs1aH
X-Google-Smtp-Source: AGHT+IFU124OcCYXtWcribYqSnTxptXUaKeW0PoJ34UkY4VesZB1s/ooAG26Cblao25AGglj035xOMs0wVpvytfoOmU=
X-Received: by 2002:a05:6e02:1708:b0:3d0:ca2:156d with SMTP id
 e9e14a558f8ab-3d17bffe7ecmr15853145ab.14.1739330090661; Tue, 11 Feb 2025
 19:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com> <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
In-Reply-To: <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 12 Feb 2025 11:14:13 +0800
X-Gm-Features: AWEUYZnGnGZmxvPdrphw9nA4xf4k2uBtC149C4a8p7geeimYAB-hq51eoPxdaWk
Message-ID: <CAL+tcoDrxSgGU3G0a=OqpYVD2WAayLKGy=po5p7Tm+eHiodtNw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:37=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Mon, Feb 10, 2025 at 5:10=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > If the buggy driver causes the inflight less than 0 [1] and warns
>
> How does a buggy driver trigger this?

We're still reproducing and investigating. With a certain version of
driver + XDP installed, we have a very slight chance to see this
happening.

>
> > us in page_pool_inflight(), it means we should not expect the
> > whole page_pool to get back to work normally.
> >
> > We noticed the kworker is waken up repeatedly and infinitely[1]
> > in production. If the page pool detect the error happening,
> > probably letting it go is a better way and do not flood the
> > var log messages. This patch mitigates the adverse effect.
> >
> > [1]
> > [Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
> > [Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
> > ...
> > [Mon Feb 10 20:36:11 2025] Call Trace:
> > [Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
> > [Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
> > [Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
> > [Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
> > [Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
> > [Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
> > [Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
> > [Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  net/core/page_pool.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 1c6fec08bc43..8e9f5801aabb 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1167,7 +1167,7 @@ void page_pool_destroy(struct page_pool *pool)
> >         page_pool_disable_direct_recycling(pool);
> >         page_pool_free_frag(pool);
> >
> > -       if (!page_pool_release(pool))
> > +       if (page_pool_release(pool) <=3D 0)
> >                 return;
>
> Isn't it the condition in page_pool_release_retry() that you want. to
> modify? That is the one that handles whether the worker keeps spinning
> no?

Right, do you mean this patch?
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 8e9f5801aabb..7dde3bd5f275 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1112,7 +1112,7 @@ static void page_pool_release_retry(struct
work_struct *wq)
        int inflight;

        inflight =3D page_pool_release(pool);
-       if (!inflight)
+       if (inflight < 0)
                return;

It has the same behaviour as the current patch does. I thought we
could stop it earlier.

>
> I also wonder also whether if the check in page_pool_release() itself
> needs to be:
>
> if (inflight < 0)
>   __page_pool_destroy();
>
> otherwise the pool will never be destroyed no?

I'm worried this would have a more severe impact because it's
uncertain if in this case the page pool can be released? :(

Thanks,
Jason

>
> --
> Thanks,
> Mina

