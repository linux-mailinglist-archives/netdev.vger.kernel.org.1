Return-Path: <netdev+bounces-97303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB098CAA75
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1237428328C
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF24F5FA;
	Tue, 21 May 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/AnxtBw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7E548E0
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282225; cv=none; b=IRX3glvAD5v0nBk1J2vU+o/YX1jZ6DWlcsrWl3Lc8Qcn2strH8yj7JUJbfWv6WN/csGSpf8Dn36SP/VJuA0RQW4WZ5u47yMGkkjeM5qwDDQpcmYMdKHb7snXznYS+8WWVSwyJswcJlfSwk+f8Sy2tfRqZqMzd5qkZ+T3mwVPF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282225; c=relaxed/simple;
	bh=WwubyTck14hSYWNd+EZHq+sIN0JioSBlvg43BrUZZ3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WqS7t9Oo6p12OutE2boYWJk/aTia3Rb1sCVTn+WM3bSiYnbGohSda2WYPWC+R1P9ZwDOXCcbeVdm3DZVlNiB4mdoallic7vtRtelaAXPhs3gacYhpyfzDxgrHzy9v3Fj3VQP0qXDaMOIqSxGu4OuCmUp9gYXTJg5CtdtbqjmDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/AnxtBw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716282223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh7W8N7Kjlu+sUoloK6kktcE+ERzsp6+vlPGr92bmBc=;
	b=N/AnxtBwSe9NXPfQNlj6KsmMMdCg6LsLqyO067buGSNQcn99rJfHGWpou+VLtocsUPC3kt
	j0JXklvf8dCWaphmDQlRRYSWSEObsNMl9b7PF2AczI0tqgdOKULXKanVqSQbftnpFbGm50
	VMXdElzCNiQ8jJYn2z1N30wr/jL0+sM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-RC60Rxx6OTiJU_rmksuHEA-1; Tue, 21 May 2024 05:03:42 -0400
X-MC-Unique: RC60Rxx6OTiJU_rmksuHEA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5a8f3bc8e0so430888466b.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 02:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282221; x=1716887021;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh7W8N7Kjlu+sUoloK6kktcE+ERzsp6+vlPGr92bmBc=;
        b=QznMWQJ1DPoBTJAoOoMVqH9wwFIo5ud9mlnxFSrBc+pg1pbexlCeQjkMWhlyKmMV1T
         hMg6DSRMCMLVEmifUMxMzIxRpgtvknDs8CvXfOfVPZYcG8sasG+nSdlQB8ov2ARQnuah
         Xi8Nn0XNXcXIgPl0GPfQkkpwYcD7b7pQOuFHuVUXFFODlihWyNyJdco6++XW+4xTSxcE
         FD/AznDJhoOHsWxVszW9goS6BvntzBLRVBkTC1Eu3xMNzgW+JwalDKgCu6QM2TVFG5fZ
         1WkkpuvkFQy8dY3htz98fxxtN9BBVxXUKJ9XxVqnOnn/y6yULVY+IjsVOs44rKm91wRB
         jHOA==
X-Forwarded-Encrypted: i=1; AJvYcCVc5sq2FCl3zbJTFZvuqNe3Yy3M56tpOmXmhiMVUrvGdYO4D91r2ueIYG+9nPhmkUZzH9MeJtwTeeSnFcsGZUtGiwlebqWI
X-Gm-Message-State: AOJu0Yzn2C7/0Zan9uLc/KUFmuGTgLmH+8M+yhLPB8F+ak84jpzQtX9U
	ABUvQbNwLCB+YtFTZsn6qfeu1ubhXAogPYPUWUHu6ytzgnHtLLQqXc1/jXTyTombkVDcHhN/N+D
	GMNmwIMHmDqookU8ifwq2SNsd+E2i+SggmbOILYSQquhIqpY/kQew9w==
X-Received: by 2002:a17:906:97c8:b0:a5a:a2b6:ba8b with SMTP id a640c23a62f3a-a5aa2b6bf6fmr1116719366b.0.1716282220793;
        Tue, 21 May 2024 02:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxqKRsunIxFaw1bjjhsPptQS1sOpnXosxR5QnsbZTH38nqbmmFGPIDoOXWZ5Q5DFr5QtCfCg==
X-Received: by 2002:a17:906:97c8:b0:a5a:a2b6:ba8b with SMTP id a640c23a62f3a-a5aa2b6bf6fmr1116716766b.0.1716282220404;
        Tue, 21 May 2024 02:03:40 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a51eea36dsm1334475466b.58.2024.05.21.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:03:39 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, mleitner@redhat.com, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/2] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <xhsmhbk618o4y.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20240415113436.3261042-1-vschneid@redhat.com>
 <CANn89iJYX8e_3Or9a5Q55NuQ8ZAHfYL+p_SpM0yz91sdj4HqtQ@mail.gmail.com>
 <xhsmhmspu8zlj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CANn89iJRev5Kn_jEgimDfyHosmiyYeaz2gHRGS2tcFC-yMbGaQ@mail.gmail.com>
 <xhsmhbk618o4y.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Tue, 21 May 2024 11:03:38 +0200
Message-ID: <xhsmho78z7d05.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

On 22/04/24 16:31, Valentin Schneider wrote:
> Apologies for the delayed reply, I was away for most of last week;
>
> On 16/04/24 17:01, Eric Dumazet wrote:
>> On Mon, Apr 15, 2024 at 4:33=E2=80=AFPM Valentin Schneider <vschneid@red=
hat.com> wrote:
>>>
>>> On 15/04/24 14:35, Eric Dumazet wrote:
>>> > On Mon, Apr 15, 2024 at 1:34=E2=80=AFPM Valentin Schneider <vschneid@=
redhat.com> wrote:
>>> >> v4 -> v5
>>> >> ++++++++
>>> >>
>>> >> o Rebased against latest Linus' tree
>>> >> o Converted tw_timer into a delayed work following Jakub's bug repor=
t on v4
>>> >>   http://lore.kernel.org/r/20240411100536.224fa1e7@kernel.org
>>> >
>>> > What was the issue again ?
>>> >
>>> > Please explain precisely why it was fundamentally tied to the use of
>>> > timers (and this was not possible to fix the issue without
>>> > adding work queues and more dependencies to TCP stack)
>>>
>>> In v4 I added the use of the ehash lock to serialize arming the timewait
>>> timer vs destroying it (inet_twsk_schedule() vs inet_twsk_deschedule_pu=
t()).
>>>
>>> Unfortunately, holding a lock both in a timer callback and in the conte=
xt
>>> in which it is destroyed is invalid. AIUI the issue is as follows:
>>>
>>>   CPUx                        CPUy
>>>   spin_lock(foo);
>>>                               <timer fires>
>>>                               call_timer_fn()
>>>                                 spin_lock(foo) // blocks
>>>   timer_shutdown_sync()
>>>     __timer_delete_sync()
>>>       __try_to_del_timer_sync() // looped as long as timer is running
>>>                        <deadlock>
>>>
>>> In our case, we had in v4:
>>>
>>>   inet_twsk_deschedule_put()
>>>     spin_lock(ehash_lock);
>>>                                           tw_timer_handler()
>>>                                             inet_twsk_kill()
>>>                                               spin_lock(ehash_lock);
>>>                                               __inet_twsk_kill();
>>>     timer_shutdown_sync(&tw->tw_timer);
>>>
>>> The fix here is to move the timer deletion to a non-timer
>>> context. Workqueues fit the bill, and as the tw_timer_handler() would j=
ust queue
>>> a work item, I converted it to a delayed_work.

Does this explanation make sense? This is the reasoning that drove me to
involve workqueues. I'm open to suggestions on alternative approaches.


