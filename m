Return-Path: <netdev+bounces-154297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB69FCB27
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 14:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45F57A13C4
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB21D5AD4;
	Thu, 26 Dec 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCRQH9g5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36F1B6CEB
	for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735219500; cv=none; b=LJipMY35+IL/g2JQdDCIeTMA7EE9dEzi8kIy0ahzukeRbjJpGhjbhm55D/OvP668JD9OIY5jzNDBW6uq3ySyNx/VdzCLVueiVg9DCnmK+6xcue772B5ZXc7w1QT/TvKfktjVkmizL85C/8WwTcPwnBAGqifMTpKdW0U2QAKlaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735219500; c=relaxed/simple;
	bh=fzr/y0By52LMwmidEnSfUqA91KlKWxY1fKTryC75b/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gklQq2vJ/iRyVXRlhltBfYX+4f9PTw2isbEUDPxZtBgEdhnbH1z1lN1sRCRQUZt/5r7oljJ8lGw8ZevwsFj+aMiBUORCqdYq8dzmWxh2mhb0QYOUqaOoMQ/Cz/TFik6+L2L1ICnE/4E3vnD0GeBtDVjPKIvQ54OOjbRc+RqDmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCRQH9g5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735219497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XT1lRnhXlXD21/E0zejBEol4+u5gRnt3P8KO+08FkPg=;
	b=gCRQH9g5VlX3za8hsEXl+Q2wK7FeQtRcUrL1OeYVXvqwHfzBr9PGykxce0DjXXrQWSW8AM
	lpzsbnHY7yACH/cOU7PDRhMxiL4f0dx8u9KkrbcXRYfc8j4PEEFpEOb08CFfhRSlnaihvP
	SzR7W67LeYVL3iltDnGrpfpXg/yNUWE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-DHc8DfwiOyabwU9HYP_R5g-1; Thu, 26 Dec 2024 08:24:56 -0500
X-MC-Unique: DHc8DfwiOyabwU9HYP_R5g-1
X-Mimecast-MFC-AGG-ID: DHc8DfwiOyabwU9HYP_R5g
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so11838013a91.2
        for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 05:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735219495; x=1735824295;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT1lRnhXlXD21/E0zejBEol4+u5gRnt3P8KO+08FkPg=;
        b=wI4yqH7VMLeYnwWCTRh9FdbSi9ydFTDkbgjpETsxwnGu+f6VDY5EaL/2mFY8yfvUCg
         k0GJGmZSU8zt6q77b+yfpSHoAjwzBs5787mo+4AuC8FrQXN0sVATZwMOxVu4slM40G+X
         YBURL+5U4AGzqbGIYos7tIO+euBG25ZluXezOLZrx6lD8qU4em8tJ0lZrbotnSUpFK9s
         mYMyVbUO99eFA/VPkwjzgVXjNtBvR52Mhb6j4Ahn6V1yGjhCc7jqX9IR6GWIYfETPQQ0
         0hK0Vu91MGO4U1hVkOv+yKxJUczoRDqaVTDx9+rqG1GIcfHpIbyjtAH2iOphXaUsIACQ
         CpRw==
X-Forwarded-Encrypted: i=1; AJvYcCXbNoVuVpUcoUvCpUEEavNMludSA0kJs0sgTBx6Jp84gzWs/dS7aVp55cVWbyMLtpWtafMnWq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wFTlwz/o5JClNCVEW5sUn8yWzsI6zT415CAE4t8Bjl28GV6z
	jgqsvOuXlf5xg/H3HrDo7r7sUvwFAk/1v0Q3oQrSC/U9N0jivSXLoaAyCtFBDFfPJujOvAki4Fv
	UPN7R9uBS9uFT1oDaacXASezIPnoeqrPN02i+ZE0z5u9knNovz5A4OfoOYWvI3jPAJTcOJtJY6+
	1jzoXLYtvbO+08r2CrehCNegWmC6kI
X-Gm-Gg: ASbGncsTsx+JyQHZQW63JddOvLfn+dfq3dv5fVRHKKZcNoMVkRyB2kjhY1592wndOU6
	yU8Ia67vKBsUrwezrNG8XvODjlr8FTX/Edo0EAQ==
X-Received: by 2002:a17:90b:534b:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-2f452dfccdcmr34514439a91.4.1735219495482;
        Thu, 26 Dec 2024 05:24:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu5/eqaIpVwwwa50DqmMKrB39NKhlZwdLHtsYGthsNbvbf6Td7aNviqn3EUtwWhqMcPArYWUXX5P9Nsr3evBk=
X-Received: by 2002:a17:90b:534b:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2f452dfccdcmr34514409a91.4.1735219495183; Thu, 26 Dec 2024
 05:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204114229.21452-1-wander@redhat.com>
In-Reply-To: <20241204114229.21452-1-wander@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 26 Dec 2024 10:24:43 -0300
Message-ID: <CAAq0SUmVn57F5hc=iJkS1-8WPrguOcEYrirZ7hFgiFxhcTCowQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net 0/4] igb: fix igb_msix_other() handling for PREEMPT_RT
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jeff Garzik <jgarzik@redhat.com>, 
	Auke Kok <auke-jan.h.kok@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 8:43=E2=80=AFAM Wander Lairson Costa <wander@redhat.=
com> wrote:
>
> This is the second attempt at fixing the behavior of igb_msix_other()
> for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> concerns raised by Sebastian [3].
>
> The initial approach proposed converting vfs_lock to a raw_spinlock,
> a minor change intended to make it safe. However, it became evident
> that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
> which is unsafe in interrupt context on PREEMPT_RT systems.
>
> To address this, the solution involves splitting igb_msg_task()
> into two parts:
>
>     * One part invoked from the IRQ context.
>     * Another part called from the threaded interrupt handler.
>
> To accommodate this, vfs_lock has been restructured into a double
> lock: a spinlock_t and a raw_spinlock_t. In the revised design:
>
>     * igb_disable_sriov() locks both spinlocks.
>     * Each part of igb_msg_task() locks the appropriate spinlock for
>     its execution context.
>
> It is worth noting that the double lock mechanism is only active under
> PREEMPT_RT. For non-PREEMPT_RT builds, the additional raw_spinlock_t
> field is ommited.
>
> If the extra raw_spinlock_t field can be tolerated under
> !PREEMPT_RT (even though it remains unused), we can eliminate the
> need for #ifdefs and simplify the code structure.
>
> I will be on vacation from December 7th to Christmas and will address
> review comments upon my return.
>
> If possible, I kindly request the Intel team to perform smoke tests
> on both stock and realtime kernels to catch any potential issues with
> this patch series.
>
> Cheers,
> Wander
>
> [1] https://lore.kernel.org/all/20240920185918.616302-2-wander@redhat.com=
/
> [2] https://lore.kernel.org/all/20241104124050.22290-1-wander@redhat.com/
> [3] https://lore.kernel.org/all/20241104110708.gFyxRFlC@linutronix.de/
>
>
> Wander Lairson Costa (4):
>   igb: narrow scope of vfs_lock in SR-IOV cleanup
>   igb: introduce raw vfs_lock to igb_adapter
>   igb: split igb_msg_task()
>   igb: fix igb_msix_other() handling for PREEMPT_RT
>
>  drivers/net/ethernet/intel/igb/igb.h      |   4 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 160 +++++++++++++++++++---
>  2 files changed, 148 insertions(+), 16 deletions(-)
>
> --
> 2.47.0
>

I had requested Red Hat Network QA to run regression tests on this,
and they recently reported that no issues were found.


