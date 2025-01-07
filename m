Return-Path: <netdev+bounces-156052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A890A04BF8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FE63A4428
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE11F7097;
	Tue,  7 Jan 2025 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="W7WJrR/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012E56446
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287129; cv=none; b=NmDm5w03+PSISueHrsP3xSHERAT3/ZA6SxIqOdvnOS4JFLRfAtIqd8vayDrhYMtTEhS7h64gy+y97p8x2LtIv+hmQM4Km6AgxNoGnGIChPYXEa3B5q2RWQ686FHQrJrfYZskCcx8GGSjO2TcFVT8/7N4l7+KuBjggTUPN7Ft2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287129; c=relaxed/simple;
	bh=as/Ajqfmjj/jLkUv/FaMfZLZP/D8FmfdAhkBkS7tB9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z++mwyZOl9GQKvJcgv/SV+zKblGyg5nR8yiBjb4YxSkLSIhsGJes5xNtDtB0ER3yu1v4YzLekLq2wFu6LLGgCgA4E6ZiXAVtyhQXnBtMDyVteNNmESvHrRst/a6UBLrlYImFmEnvOW9vVtpKxdaGWYOgTJUqowZnmRCiDUSUC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=W7WJrR/9; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=as/Ajqfmjj/jLkUv/FaMfZLZP/D8FmfdAhkBkS7tB9A=; t=1736287127; x=1737151127; 
	b=W7WJrR/9ZfjQKcGQWdC0G43ZXHiMk6h1O+HIPDo79DYgrwKZymK7dBtUeXWNlLx6vmtymFBMw/U
	tkNoRyRrq2z+1T/oH5J89hSVC/bPXsgr5jdV1OKPKEGAwhr56uleWUJsjueP3AR1mDLS3LZoj1XqZ
	q/P4tLykQihG+fnO4VvECac3Mk2ZU+d0TSasYfBbK+gLm1S0yTR4820TuJ0zZiCN6blqemCUcSk+/
	UdxlMIDG+5oDOueVgPVeiSQfuUiwS0rJt1H+hMeOPFGGYNpHbV5sB1INja+DaUfZ53eW1zrSoqfRu
	a35tOTph4laCUMW5tXtFnGozWHcsR6N/ySEw==;
Received: from mail-ot1-f49.google.com ([209.85.210.49]:52528)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tVHb3-0006JN-4s
	for netdev@vger.kernel.org; Tue, 07 Jan 2025 13:58:46 -0800
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e36b27b53so8315177a34.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 13:58:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+uV7ssd8pgeypK7RK8lvNZyxmEt87CKlA+HfNj1abu7FCyxYjzJO7T37xsoPJozdixy+1urA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXbXKkmIH6xu349uloxquEQ7rSGzdLEUd5+2shRXOW0IoBnwM
	/+L46SOzGBbDEU1WfnZ0aEBHg+lyfDNQFmJkMXNSx3PZnksspyHvYhhcD15uDdDCuawGGmII7Dk
	fnjTbE7k4mnRsAzz1XcnJzQgXtv8=
X-Google-Smtp-Source: AGHT+IFQiv81HUHyWFW5sJzxoNWLBEeoxHebPoHJrfrgC1maJ2NlHYWMNU8MktMlHF0/Zr6iIefkyVZKG5WjJw1WYSs=
X-Received: by 2002:a05:6870:e391:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-2aa066ed9b9mr294788fac.12.1736287124616; Tue, 07 Jan 2025
 13:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-7-ouster@cs.stanford.edu>
 <20250107061510.0adcf6c6@kernel.org> <CAGXJAmz+FVRHXh=CrBcp-T-cLX3+s6BRH7DtBzaoFrpQb1zf9w@mail.gmail.com>
 <CANn89iJKq=ArBwcKTGb0VcxexvA3d96hm39e75LJLvDhBaXiTw@mail.gmail.com> <20250107132425.27a32652@kernel.org>
In-Reply-To: <20250107132425.27a32652@kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 7 Jan 2025 13:58:07 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzt3xypxdM7=6LSQL7rn++mv-033CLcw3LGS0PxCV8d5A@mail.gmail.com>
X-Gm-Features: AbW1kvZZc4W8axXacDBXA2Fz7mWz66z2jpEAJ14qVpQTGggZToAU_bXIrAvdJ4I
Message-ID: <CAGXJAmzt3xypxdM7=6LSQL7rn++mv-033CLcw3LGS0PxCV8d5A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 06/12] net: homa: create homa_peer.h and homa_peer.c
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 764eb63bb4c91aa8ddbf2de6f9e489d2

On Tue, Jan 7, 2025 at 1:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 7 Jan 2025 22:02:25 +0100 Eric Dumazet wrote:
> > While you are at it, I suggest you test your patch with LOCKDEP enabled=
,
> > and CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> >
> > Using GFP_KERNEL while BH are blocked is not good.
>
> In fact splice all of kernel/configs/debug.config into your
> testing config.

Will do. Does "splice" mean anything more than copying
kernel/configs/debug.config onto the end of my .config file?

Is there general advice available on managing multiple configs? Sounds
like I'll need different configs for development/validation and
performance testing.

-John-

