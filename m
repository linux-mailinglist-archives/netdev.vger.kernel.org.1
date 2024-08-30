Return-Path: <netdev+bounces-123739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A439665D7
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2069B25442
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE61BA27E;
	Fri, 30 Aug 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="zfLFKynq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5A1BA26B
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032248; cv=none; b=t8hqhDUDxWN1yItXGk0GCuF6abf3h0GgsK9PRB1V9Bdei69VxaIWRx8bPpZ4hrA+n/4u68CcPuS7eSN3d5V5CMCfGV82KnjIPssBA2+7dz/2/0hvxutpdkFxgaUdtxbPUTs5x/ChlXmi3lM7qXtjjsLUurN90aMBV860AyDwoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032248; c=relaxed/simple;
	bh=bIlIxGS4Fkuh9sfbYzRI8/VSht+5Uqa65aoRCnzW4i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6gZt2KMXzTr3/0Ut0MUPdxmlKHZmP/zyJEcMk4xXBWFfx8/LaPVgP1V71v9Xbi0Yl6QMJ+sW5mXLG4qafQ6UttsW7aP08FxqTQw4Gl+J2k2euD7cKPGQ7CvjBlKRBBw/ETyymEBS2lavqnOvJ3arkaa6HMsn+3WRZmpBus797A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=zfLFKynq; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3df0df4814eso953239b6e.2
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1725032246; x=1725637046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIlIxGS4Fkuh9sfbYzRI8/VSht+5Uqa65aoRCnzW4i4=;
        b=zfLFKynqjU29a2cMs9WcefAmWEjzVlsj0ZkvZ+mslEIwJ6ub+ysM7wzqQfwi+imDTq
         uKELK6zNknTDlboSiWNs7s9lS6Rp6aiFnUsF2q+/KUglTbVKjAfsWfkadfneH4UzDRQZ
         Fn+C8TP2IjkNN1qSOHK7uYIuyn6pdd909al82SeMxu++ZnjsGJimrS9a1FphqVFdr5pL
         I1a0lIi4TLwwJhLC5uUyVXg1wv9czFFHL6jY3c2pCDvj5krAv7Uc3GZYSejvtCl/Ivvr
         QXUCzkYiyhJbh/dfiBnnMO71kx0141kVXeihXWnaP6bec3femOCXQP2NBs0fx/NniLVB
         OEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032246; x=1725637046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIlIxGS4Fkuh9sfbYzRI8/VSht+5Uqa65aoRCnzW4i4=;
        b=kdtUdvIyJWOR5XW+vtIWldrQ5jfEE9yrf0pWbaZPO5YxS2sGlxq7EEqZSwuhMhxmqr
         I77c0+2IPs2jJXM7+g+XltfSwpDgIIfK8lU36xz4o5HuxiFKdJoU3vI3mOtr9blmbia/
         xdrId81m9ywUyOH38eo6x+YxcxTd4ZBnWeq3dBsZwFkib4fxn4KK0iGg195eh8eux0Pq
         0PYh+ZNjUnl0tkBBAdMRmVqn5aI8NEPGTJkM6HZpbFyxoQSU5KyiIcYCc4EpvTXbiBLy
         drIvXoIXEgPhgHEF2bKXOLkcfj5ysBmifUT/8xC+EAZmWTSM/hBK40CadFXse6cLaTvG
         ZgsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/xLMLXBIjD4ULwZkrEiEYRKh0HZB8qdOyT7FKJmUaO+JrVnSlFiHnFfZl/5ObJuoHQlyrF50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dHOoBBDr7dEb1HEDjgEZpQDmAUGli/aCka/HTR/C61EONOWa
	gea132kNiD0/Y5n5n0Inv39JD0VVVSiVqvkvIrSQlR1jWEISEP+iYgBz0x3Dkombp86hzi/8E70
	mjIpurx7eMbNukzdnPvKgpkW+NKE/pNO579MDtQ==
X-Google-Smtp-Source: AGHT+IEMOsx1yecc59LL8pG1QfZoOW0iZYfdgobhiqUG7wbaHzr+b5PQVVwb40bArXCze4oH+3B75ekFZtbkA6nO5eU=
X-Received: by 2002:a05:6808:1645:b0:3db:23d3:8404 with SMTP id
 5614622812f47-3df05e6203bmr6189707b6e.42.1725032245774; Fri, 30 Aug 2024
 08:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240828214524.1867954-1-max@kutsevol.com>
 <20240828214524.1867954-2-max@kutsevol.com> <ZtGGp9DRTy6X+PLv@gmail.com>
 <CAO6EAnUe5-Yr=TE4Edi5oHenUR+mHYCh7ob7xu55V_dUn7d28w@mail.gmail.com> <ZtHTSexXueMjYGh/@gmail.com>
In-Reply-To: <ZtHTSexXueMjYGh/@gmail.com>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Fri, 30 Aug 2024 11:37:15 -0400
Message-ID: <CAO6EAnXu1LO=erZYcm9UEcNBxVk=MwA4kKxAwfKq3fLntXzt0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Breno,

On Fri, Aug 30, 2024 at 10:12=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Hello Maksym,
>
> On Fri, Aug 30, 2024 at 08:58:12AM -0400, Maksym Kutsevol wrote:
>
> > > I am not sure this if/else/endif is the best way. I am wondering if
> > > something like this would make the code simpler (uncompiled/untested)=
:
>
> > Two calls in two different places to netpoll_send_udp bothers you or
> > the way it has to distinct cases for enabled/disabled and you prefer to
> > have it as added steps for the case when it's enabled?
>
> I would say both. I try to reduce as much as possible the number of
> similar calls and #else(s) is the goal.
>
> At the same time, I admit it is easier said than done, and Jakub is
> usually the one that helps me to reach the last mile.
I see, ok.
I was more looking for possible (maybe impossible) compiler
optimizations in this case.

but access to nt->np probably makes it impossible anyway, I don't know
compilers well
enough to say.

I'll make it an if then, e.g.
if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)){

}

