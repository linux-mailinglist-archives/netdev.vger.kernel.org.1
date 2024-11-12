Return-Path: <netdev+bounces-143992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA9A9C505D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BFD1F22A37
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEEA20BB21;
	Tue, 12 Nov 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOoMLL9P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345B20B210
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399392; cv=none; b=jGBszoY/De5wcYuk607xD4JpU9SADW2gmJEooyf4E6jwl36wOIEWaX9LhogZgewcVBKlVyUi+lrCkhYDxierf9fVpsXOzmKrzXeeq2ckolywdwqS2LZdNxyS2yN0c4ykJl5G9i2phuyzY6OudtAQOE7uqWfA5/zXU9cSlxbJlnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399392; c=relaxed/simple;
	bh=7Jw4gzO4ApX7cSmGDlDzGFY5iS78Ixw67qfbU1eoTbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kubpKYe5i9QOPX6d0aoDbCU1fziH46K5S1ZXnnxN/ChgwM96k16WjlohJgctEDW8ShWxxqAAHdpu8QiB5VsjJugVp93zxji6RZrmji4xRrhUy2GjRn7lli1w0P8+HxvYbx1LRJ40GpN0M6NYNpGscsUGQEY8gA9O6PAedPz50XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOoMLL9P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731399389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iw5zEH+WVurjSbYYg4DwClE0mzq9PladqDfxhWSI+Fs=;
	b=hOoMLL9PuqEX+vz5kHRcdJaNmfRk/rECNu8HvHn2yxD5X0rllXRfet1XGpB5sjFqp0k4y2
	KOsp3BIV5UvIrp+NeSzFO7jr+mBU3a9jDxYfCjmmP6jfSQBzEsuIkkStkkEecokmEWr23d
	p2b+DyZoIdIQQScoih61j5uMnTq+D1I=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-vGmKoO97M5KKIRGxYj2iJg-1; Tue, 12 Nov 2024 03:16:24 -0500
X-MC-Unique: vGmKoO97M5KKIRGxYj2iJg-1
X-Mimecast-MFC-AGG-ID: vGmKoO97M5KKIRGxYj2iJg
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5eb7a63c9f3so4235663eaf.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 00:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731399384; x=1732004184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw5zEH+WVurjSbYYg4DwClE0mzq9PladqDfxhWSI+Fs=;
        b=JpO8kxdyb+mvvWfquj8kEANFLi7XZeV9eo0c+tBMcPn9Zz0BvGG5Irwhq2FvhPsqDV
         Z7hz9STsx7f3dLAg3m5r42h5+DoiGTWHpkA8g0eDi4YoExVsLGNkRa7sCU2oGYBPEOPY
         T5Itg+WRGFeUi4vSxv8UqHfi0+6ovpit4Ixocxw9uCWfYfmckYAZlDjhKWjplJ5Cm4ZP
         hEIxZMynVkEJZE0AELzfnOoO6BjFE+amadHUcdWk8Xfb6u9tRor0IfzZP5x3fK7/DwIj
         Iqo5cTxkKTfBNmuMhDsHU0plNxTLjbVog2bkufChvZWyXm6oDlqfM8SelFGZ8fFurM00
         YIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHIW6GCKS3gLuoL52HcHq9FjdyFKiH3d3TjdC7SHPcePSbNJ0DKWrhzi3kZ+ZT+qxvt251D3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZeSRUCcTUKaOTtFtDi/vtwJ5vxSA93oKrBrIg0zyNyY8HV2tZ
	epBz3+2ULiIdsliPs+u9pMnAtdYiqELYTd03hUnUugJEMcZnVrA/tHk/kqWd6takindUFvCf7C1
	T1G783Jc8gbCdwW9f8hFxsmyAGI36DTjmOVTp3TlfTNhZ7jV48Oy/cy4oQSn+rptczBl1YJt+k/
	MoYvmq2qE9xgUpEHc35jaI+gsY7H2x
X-Received: by 2002:a05:6870:d148:b0:25e:1610:9705 with SMTP id 586e51a60fabf-2955ffe9a41mr12962443fac.2.1731399384242;
        Tue, 12 Nov 2024 00:16:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/lkXoMosE+vuhIZsKXSh6dnadfy80lrNwb31674RxlGAcwJ4kamrDbeIz/w57LrTzLzjmHpBdNA68ePwAClg=
X-Received: by 2002:a05:6870:d148:b0:25e:1610:9705 with SMTP id
 586e51a60fabf-2955ffe9a41mr12962433fac.2.1731399384018; Tue, 12 Nov 2024
 00:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730976866.git.jstancek@redhat.com> <20241111155246.17aa0199@kernel.org>
In-Reply-To: <20241111155246.17aa0199@kernel.org>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Nov 2024 09:16:07 +0100
Message-ID: <CAASaF6zsC59x-wCRKNmdPEB7NOwtqLf6=AgJ-UO1xFYxCG11gQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] tools: ynl: two patches to ease building with rpmbuild
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 11 Nov 2024 14:04:43 +0100 Jan Stancek wrote:
> > I'm looking to build and package ynl for Fedora and Centos Stream users=
.
>
> Great to hear!
>
> > Default rpmbuild has couple hardening options enabled by default [1][2]=
,
> > which currently prevent ynl from building.
>
> Could you rebase on:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
> and resend? I see some fuzz:
>
> Applying: tools: ynl: add script dir to sys.path
> Using index info to reconstruct a base tree...
> M       tools/net/ynl/cli.py
> M       tools/net/ynl/ynl-gen-c.py
> Falling back to patching base and 3-way merge...
> Auto-merging tools/net/ynl/ynl-gen-c.py
> Auto-merging tools/net/ynl/cli.py
> Applying: tools: ynl: extend CFLAGS to keep options from environment
>
>
> With that fixed feel free to add to the patches:
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Will do.

>
>
> One thing I keep thinking about, maybe you already read this, is to
> add  some sort of spec search path and install the specs under /usr.
> So the user can simply say --family X on the CLI without specifying
> the fs full path to the YAML file. Would you be willing to send a patch
> for this?

I can look at adding--family option (atm. for running ynl in-tree).

One thing I wasn't sure about (due to lacking install target) was whether
you intend to run ynl always from linux tree.

If you're open to adding 'install' target, I think that should be something
to look at as well. It would make packaging less fragile, as I'm currently
handling all that on spec side.

Thanks,
Jan


