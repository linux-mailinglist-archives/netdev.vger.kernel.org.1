Return-Path: <netdev+bounces-207241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04FFB06558
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA533B5089
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3722857D8;
	Tue, 15 Jul 2025 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INNqxjBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46782853EA
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601628; cv=none; b=YfOpaIcbG1wkMeJuN2oleVirZQxI1DmhBOpjeZVdo9r/TFZQqKrJZckYyceJ+u7X0ThwsJrNl6NsCItJQmByCzuhtkz1EjN4yoszudpP5pPk+Q07Ui+sjvytUiptCuDhgb1Hclk4J1wrAlj92KwIcFGTp2xKnoEpz77988xXyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601628; c=relaxed/simple;
	bh=SnLp5g3Y32T7s024ewMrU5KwBsImwIVTSS6wMI7KFus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UP4rqSMT8LBcHljNzRjNaV/ETgHUb0RyCOo5gISGruvAx01ZELA4CG88tTsonBNQlYtaMJ572Rf/prMUnZVJliO/I2pJw4XTuWOwwwC17jPdsD75QxqmcT3Mwf8na8Z/2rZopj6FTotekUljPeEQZ/aIJLJ6YN1WqPRFSAgfSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INNqxjBo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313a188174fso114208a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752601625; x=1753206425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtI5TVfeROksiTJdvjBPcnmRsk5SRUfXtKYI8vkVdQA=;
        b=INNqxjBoehDshkh8tBIM/8m8k7FOAGn+VAU6q8f6+2nBCunFqpoQR6ws0pk0blWMJQ
         Y4+TX2n9c1L2V6qphxSD/l75yqSStjS90lmNUnwevJ+qV8h3u1PLz4rWBQMyJLkHL5Xa
         b7QovEkK8H9Clemt1/1iwteFlR3C5PEVXwoROei0D7Fh1MswetoJdzrt+V2pa4vutB5c
         ZZIIqFGArtyQl83+0Ir3JmUfCeR8chZEe7DXibJ2qBtXrZ2vnexqBIeyqu+Nbcvq67B0
         WsRf+NsnmF8tL9SP5+b5Y5SfltY1I654v+XCknKKCeitlIxcoFzWh2Xw193n0beR1EYO
         qT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752601625; x=1753206425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtI5TVfeROksiTJdvjBPcnmRsk5SRUfXtKYI8vkVdQA=;
        b=Z8vFRggi4jSTq838dK4lZZQObXDc5WhX86P12B5Lyp8qFYGjMPd5DnsPrC3z4K3r7Q
         DtApZZo+wCOTCP1kfaL1pGTzd9byCT1Sqo/CwtTjCP7/xyEQnqqayzLpRHsP0UvFYZj0
         aWX0M+LfqDxqX6+xa2senblBKrRNCKqZVK4qNXCmZu7vEX3nHybMZBKW69nRk3nA4h8/
         cHfKN+/1NA3ffx0n6MDJMDAvvNT1vtqxr33uI7RMA1oH0eXLaREJmcukGceIH8CvZ/3M
         E9wq/8YT2YiRd8arMCv8h3Dm9RnlA67mtk159I1IAcNl+hMzwPi3JklhaGYs6roice2N
         N2sA==
X-Forwarded-Encrypted: i=1; AJvYcCXhuH5D59i5TKsf66EQsvSn+8YuFUyKm6yLIugNmvmvLUDE5QYR2e5tm4DTFjDY1GlzV7aoMkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySQVXc2yVv8ZiAs1QLcehp1JWG6x4Jzaaq99zy7zcq7fNu+I5
	h7wPV6MAB+nViN/cAX51ryHqxOlEW5PM0+TLRhlfWYTIg//IRnVVQiSXsXBQxKTXFV8UtVT8JZ9
	G0yjXOPXmSSi7j4fmiZgUFkRG1jGYUNbVf63VjtFi
X-Gm-Gg: ASbGncurImaihDMRm7G+JIYlBuieNaqUnXH/7pY9zvWym8E0w35HZc2As/zX7QhbrCO
	tAl5Y8IPqlN/9IIX97CQapQJZ0ddxcc9tQ23s+o9fKesM3sGl1+Htrg0k+ZtPA/ZeE4zf5awKeu
	G7j68OUiV83mAxq0TDsrHWfhpBSiUmPodou6qUQhXntRQLhTqaPlNxzQhocMFgbSmy07AdCsgBB
	MOIkFwoXOegHqyvSkpyyRQf/UvK9VL1FeZyLg==
X-Google-Smtp-Source: AGHT+IHfCsKu3lQSrTdI7OheuW7x5UPYOpr8U883CkFaQ3jyr7bhPNopPsIhMxRmBOJHKWhV7kmqmZMyKliyM7hEO/U=
X-Received: by 2002:a17:90b:4c8c:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-31c8f7a0009mr5495202a91.3.1752601624826; Tue, 15 Jul 2025
 10:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
 <20250714143613.42184-3-daniel.sedlak@cdn77.com> <CAAVpQUAsZsEKQ65Kuh7wmcf6Yqq8m4im7dYFvVd1RL4QHxMN8g@mail.gmail.com>
 <8a7cea99-0ab5-4dba-bc89-62d4819531eb@cdn77.com> <CAAVpQUDj23KHKpMFA4J7gV=H_BnvG4z0aVxf6-B04KsYtBL=1w@mail.gmail.com>
In-Reply-To: <CAAVpQUDj23KHKpMFA4J7gV=H_BnvG4z0aVxf6-B04KsYtBL=1w@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 15 Jul 2025 10:46:53 -0700
X-Gm-Features: Ac12FXwB4PCIKnOdMppbdcFbf-MhYkOWAqn6Sbv43aI2tWEjulnADX2xLPhXtBU
Message-ID: <CAAVpQUD=diV7aWqJqyQjL7MOZuC5xQ0AwJssPJ6vu4nYZPer+g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] mm/vmpressure: add tracepoint for socket
 pressure detection
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>, Daniel Sedlak <danie.sedlak@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Tue, Jul 15, 2025 at 12:01=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn=
77.com> wrote:
> >
> > Hi Kuniyuki,
> >
> > On 7/14/25 8:02 PM, Kuniyuki Iwashima wrote:
> > >> +TRACE_EVENT(memcg_socket_under_pressure,
> > >> +
> > >> +       TP_PROTO(const struct mem_cgroup *memcg, unsigned long scann=
ed,
> > >> +               unsigned long reclaimed),
> > >> +
> > >> +       TP_ARGS(memcg, scanned, reclaimed),
> > >> +
> > >> +       TP_STRUCT__entry(
> > >> +               __field(u64, id)
> > >> +               __field(unsigned long, scanned)
> > >> +               __field(unsigned long, reclaimed)
> > >> +       ),
> > >> +
> > >> +       TP_fast_assign(
> > >> +               __entry->id =3D cgroup_id(memcg->css.cgroup);
> > >> +               __entry->scanned =3D scanned;
> > >> +               __entry->reclaimed =3D reclaimed;
> > >> +       ),
> > >> +
> > >> +       TP_printk("memcg_id=3D%llu scanned=3D%lu reclaimed=3D%lu",
> > >> +               __entry->id,
> > >
> > > Maybe a noob question: How can we translate the memcg ID
> > > to the /sys/fs/cgroup/... path ?
> >
> > IMO this should be really named `cgroup_id` instead of `memcg_id`, but
> > we kept the latter to keep consistency with the rest of the file.
> >
> > To find cgroup path you can use:
> > - find /sys/fs/cgroup/ -inum `memcg_id`, and it will print "path" to th=
e
> > affected cgroup.
> > - or you can use bpftrace tracepoint hooks and there is a helper
> > function [1].
>
> Thanks, this is good to know and worth in the commit message.
>
> >
> > Or we can put the cgroup_path to the tracepoint instead of that ID, but
> > I feel it can be too much overhead, the paths can be pretty long.
>
> Agree, the ID is good enough given we can find the cgroup by oneliner.
>
> >
> > Link: https://bpftrace.org/docs/latest#functions-cgroup_path [1]
> > > It would be nice to place this patch first and the description of
> > > patch 2 has how to use the new stat with this tracepoint.
> >
> > Sure, can do that. However, I am unsure how a good idea is to
> > cross-reference commits, since each may go through a different tree
> > because each commit is for a different subsystem. They would have to go
> > through one tree, right?
>
> Right.

Sorry, I meant to say the two patches don't need to go along to a
single tree and you can post them separately as each change is
independent.

> Probably you can just assume both patches will be merged
> and post the tracepoint patch to mm ML first and then add its
> lore.kernel.org link and howto in the stat patch and post it to netdev ML=
.

