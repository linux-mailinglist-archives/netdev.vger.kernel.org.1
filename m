Return-Path: <netdev+bounces-228240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142DBC5739
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF149189E736
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ECA2EBBB5;
	Wed,  8 Oct 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gcrsA+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEBC2EB870
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934305; cv=none; b=HPjjFCh1WFk5vKmMMYJZxUUssmmP9+RO+YMwL3/dRM3+fPQiABi/2TQ0gPaj9XlqSN1N3aGZUPsbW3e6SbkHJRR9xiEM42Ciji4S+IKxlod/b1/PNrhpwaCyEmF9nKdcMxE4V6d7hTe6pWKNd2cR352Oo/YWXFTUsBkywgAfuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934305; c=relaxed/simple;
	bh=SrtzxNYZutf6BwHG4n+K6AlkJu7JpINi17ZxbnnlwE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gh1LB+rkMPQmI8Gg32S/mlS4mnMrFz0GL2IKPiVfgSdlal37oaCUElbef+TLNUaGGHOrZ+9bZcqObN9/GEbVeIyB0+fB27h/ty84lC+hPgTU7quuCQUZK8oZ6s8FTVkAh2Ci03GN6nTucsMuGVnLoNgQfSWXAU6/8wUB7UA5r4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gcrsA+b; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4da7a3d0402so151831cf.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759934303; x=1760539103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQAe1RWYiO8eaSsTMxNUYAthxYIo/4FVZiTeoT4U2VE=;
        b=2gcrsA+bIZIXRf2l5HeATIHIz3sRjLiaeFXEYHmHNlcFakoVNI2/IXpHOqR23gDDsR
         jpRv6tCtXN3OwR3CGwoE5F92FIGnqrEJEeduRGRIEVtIt8yAMdwbqB0jHV6KgUvOSKB/
         YrN5MXn4dhwwngjP28ouYqgiVc5tkduceFFwRf8oCuCYAfASDjvRAM93xEQDUCw1bGd4
         nUWfhjgXlvnmrEPYgzje35e0p4b8B7RxwbjMMXh1tfmgVdUgCaFxOTLagWX7ooUkIHC+
         /YHc5yTCHMbeAN3H27MBJL+xiC+vGb0XCDJYNeWeGpso4m7yj4VvRlrtyiD8yuPsAm4a
         RioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759934303; x=1760539103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQAe1RWYiO8eaSsTMxNUYAthxYIo/4FVZiTeoT4U2VE=;
        b=ZH6Cse/7j2gM2AXUNeeLJDdj5Ha0ANAlnuvLFm4sQ569gX1+lDnvAB0TQJ2i2AdFav
         tVl836d9rvPya/stMOlfuydQ3Q3E4AyDJeXtSf6tiEDKUuXPq4Tx1A0oD3skgNBrUfAo
         1duHsxebegFNsGasVUJN/KGlMr0Z9Hk395EgZA+1neTa8Y1oqoMAUYamWTot7j4JwdrF
         cZHvr4VWOpOBkG4QjveHuiVb+fH0XWJgq2r1SeyZTpQFdwfRFyVfhbf7CTBc/1hkcHOH
         4Pso6x6dghwBj0tn5DSR+yzSCMmb08CFtRZw7MCYWDmiiEz+Y3tquS23VLqfuFO81yX7
         g4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcmx/QnDzC2zfjtvpRxKU/AaPLdbuqP3bsWKdtk5mXEXvwyQRPWAfQelXaG6mdIkOrgKqMbzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyadX2e6o5Dt1SqttrimfWGtMI7QmWZZJqW94TaXT1213asgbbM
	HSi3emeN1HxYPfp5yS6cy70lJ68X/VJzGkJBWV1QyrbruRw/XwbsXoPwvRQEwV05S1delNpB8Bu
	V7cd6yrnHRi4dJz8EZrjZKSaoC2LtMzuQc1ZO0ZKBZWfIVPgANPqQEI0E
X-Gm-Gg: ASbGncs3EBZoPoZXa67Ed8EZrxgcx7sS1NaBq/8XrVSPfEfqRIltQCOgqOkYspd9bLk
	frolfDGrsrZ4RKC/QZQXiKb9pBLZd1lfBXJvA5WFKCnVnGEtX/gtAXNXyN2MTZbAHtS6auXimvL
	fzTYiI+yPmDfUQL+Hm0TPwI30RJrDLJOiXDIfcdgmmFJazHvlg/UoX7q36beFqXUzhOloFDhc3V
	Wi9ZE8GakOcnwVTM5zBCJ68wQ2rJ21Pb38dCwTqif9kxgZ0/jeFBrLhfYrM4LvgDoK/F4ZZSVva
	f2tf+iU=
X-Google-Smtp-Source: AGHT+IGVUpjJchPu+vPamAJhw8xsrfE9y3+Pkxcl6IrNWNKXnIBP+rCUEhatTUFXvPuOjFhH2r3W4mp1YS41ZQ1/6jM=
X-Received: by 2002:a05:622a:109:b0:4c7:a8ed:af3e with SMTP id
 d75a77b69052e-4e6eb068d26mr55279861cf.40.1759934301269; Wed, 08 Oct 2025
 07:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com> <20251008104612.1824200-5-edumazet@google.com>
 <willemdebruijn.kernel.5c18588531fd@gmail.com>
In-Reply-To: <willemdebruijn.kernel.5c18588531fd@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Oct 2025 07:38:09 -0700
X-Gm-Features: AS18NWCboG3OVnA0r7i0GTLYz_uYK6ygB8UYXSfoYEaaKEyq1KxH80Nq6jHcGQ8
Message-ID: <CANn89iJQzoaP1-o-GLDGcGPRTAuZxGX0H8FSV+CxJ=dPEWnB_g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 4/4] net: allow busy connected flows to
 switch tx queues
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 6:38=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > This is a followup of commit 726e9e8b94b9 ("tcp: refine
> > skb->ooo_okay setting") and to the prior commit in this series
> > ("net: control skb->ooo_okay from skb_set_owner_w()")
> >
> > skb->ooo_okay might never be set for bulk flows that always
> > have at least one skb in a qdisc queue of NIC queue,
> > especially if TX completion is delayed because of a stressed cpu.
> >
> > The so-called "strange attractors" has caused many performance
> > issues, we need to do better.
> >
> > We have tried very hard to avoid reorders because TCP was
> > not dealing with them nicely a decade ago.
> >
> > Use the new net.core.txq_reselection_ms sysctl to let
> > flows follow XPS and select a more efficient queue.
> >
> > After this patch, we no longer have to make sure threads
> > are pinned to cpus, they now can be migrated without
> > adding too much spinlock/qdisc/TX completion pressure anymore.
> >
> > TX completion part was problematic, because it added false sharing
> > on various socket fields, but also added false sharing and spinlock
> > contention in mm layers. Calling skb_orphan() from ndo_start_xmit()
> > is not an option unfortunately.
> >
> > Note for later: move sk->sk_tx_queue_mapping closer
> > to sk_tx_queue_mapping_jiffies for better cache locality.
> >
> > Tested:
> >
> > Used a host with 32 TX queues, shared by groups of 8 cores.
> > XPS setup :
> >
> > echo ff >/sys/class/net/eth1/queue/tx-0/xps_cpus
> > echo ff00 >/sys/class/net/eth1/queue/tx-1/xps_cpus
> > echo ff0000 >/sys/class/net/eth1/queue/tx-2/xps_cpus
> > echo ff000000 >/sys/class/net/eth1/queue/tx-3/xps_cpus
> > echo ff,00000000 >/sys/class/net/eth1/queue/tx-4/xps_cpus
> > echo ff00,00000000 >/sys/class/net/eth1/queue/tx-5/xps_cpus
> > echo ff0000,00000000 >/sys/class/net/eth1/queue/tx-6/xps_cpus
> > echo ff000000,00000000 >/sys/class/net/eth1/queue/tx-7/xps_cpus
> > ...
> >
> > Launched a tcp_stream with 15 threads and 1000 flows, initially affined=
 to core 0-15
> >
> > taskset -c 0-15 tcp_stream -T15 -F1000 -l1000 -c -H target_host
> >
> > Checked that only queues 0 and 1 are used as instructed by XPS :
> > tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
> >  backlog 123489410b 1890p
> >  backlog 69809026b 1064p
> >  backlog 52401054b 805p
>
> Just in case it's not clear to all readers, this implies MQ + some
> per queue qdisc, right. Here MQ + FQ.
>
> > Then force each thread to run on cpu 1,9,17,25,33,41,49,57,65,73,81,89,=
97,105,113,121
> >
> > C=3D1;PID=3D`pidof tcp_stream`;for P in `ls /proc/$PID/task`; do taskse=
t -pc $C $P; C=3D$(($C + 8));done
> >
> > Set txq_reselection_ms to 1000
> > echo 1000 > /proc/sys/net/core/txq_reselection_ms
>
> Just curious: is the once per second heuristic based on anything. Is
> it likely to set another (more aggressive) value here?

Just an initial number, I do not have a strong opinion on the precise numbe=
r.

More for discussion would be to decide if the default should be set to
<disable>,
but I suspect it will take five years for everybody to catch up.

Note that in RFC, <disable> would be a big value, we could also decide
to reserve 0 as "this feature is disabled".

