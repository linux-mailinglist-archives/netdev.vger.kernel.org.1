Return-Path: <netdev+bounces-135457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38F99E00E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6879E2818D1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D41AC420;
	Tue, 15 Oct 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SiFa5Dgm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD218A6D9
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979170; cv=none; b=hzQ3kb4OSB8owE24shDwQSZXkzdKzBTe367IV24zOCTNyLMLDfCcrrIzzPep/+0ldqc0Xovpxq6c235i5R5yxA9hwqajkVrYLa2EvA73TqHTOlCs8GZIC4DtYKlkr53H1hLEBwylBirczyHDknn0Qk+ABEJqRjD3RgpbbnTJ26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979170; c=relaxed/simple;
	bh=xlWlC3kfibrqAbBKaNacGr6U8U95C9Eu0+PCs1qPnmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=As55pMrLnx3Sp2QHWjTa9BLwkmkUgHaCwHbvH+riNuXq7Zw9B0qCD207ntq16me1QaUmkaetgBSrkgrYprxGt1Xz5YNCds5MydHl02xyw7CC4JN8wpl0UCKlQ1+EgJVMiP83ZUrEdSlMm8iMmspk63ypfoCeU5fHn73PgzZOHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SiFa5Dgm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so2771193a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979167; x=1729583967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlZNzs803DGWbhd4/eehLQQE+sTqtjOgRm3We4JvNr8=;
        b=SiFa5DgmQ7UlmefOtdUY+NjFZblzP0IHwFgwUPR9WyDkxFyNTSKPFkALiQ1/3zNUh7
         nM4mgr4qt91dsMhgt1s+W0wCx+dTPrwlqLL22JsZSNgII5i0lzCzZgab1wPZAAhNDoLI
         uWLgXrOXNQKkMQLsoZ/OzP9im9LgwAZ1WMqrcbV/L/zDutuq7xOaIuYivLanx7Fo6Af0
         RBe9awkfi+v6kFBN7odFxCSzBLe2ZKqrjlzEWyBJzQ6+gKn4t31L7xoG0KkLVVy3RVjS
         X9US4kK83eK9gbdrvzg3d49m+6Y6tz35VcF9BFIH4axW7E//Nsg6fbQez3+XIGnS1hd0
         0vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979167; x=1729583967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlZNzs803DGWbhd4/eehLQQE+sTqtjOgRm3We4JvNr8=;
        b=dadMzXGHTfhzvPl7o1csqEV0WwjsLCaMe30ptBWsZPeDLPq4qPNmvX1/9gjNsf6S4W
         PRr4r235vseZNTK29NrLAr+5G1RRwOAWye207MK1HfLGVW6EBTg2Q5F8k45idMU025WA
         kPLrctmiwAmjyp2hYNeSmJs5/3iyXab0YiWvQ4ZNwo6NlgtPU4YvZv9BsYUVw8/yKo4N
         i64nemKG0Nn0yy4TisE6xjzDU9dfPmcVF+Z16J5ZdEjS4+V91RBbU6S2MRKBHLyWh/D3
         17BpK1T/ia4PjJcR9a6wCPtrNOk/4HSAXgtGkvezTB/2W4cCK+D/rbqeqEZnpoh/mijV
         ASfg==
X-Forwarded-Encrypted: i=1; AJvYcCXF5U418MHewqz66nNdC9HOVVCThW9eqcXT+pf15QUXbWU+rPT9VI9jsyI5eiLt8GVAVXPIfio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzguFDreip1UfSkXChSEnsR5rOmGoIB0iQQxhbwMLWjroI5XQDE
	GsjitN/6ZDXTqQb1BJi+lGG+T3t0Z9c12v6xhYD3rLLWfNq2W+cuEVV+ydEqmFP73xD9MAkJrr/
	J7uzB/uLqt6lOiSceWX89jxQh7mGTo/sSi+Ok
X-Google-Smtp-Source: AGHT+IE1CTqjAPxPfWw8B1+o+7xBm/fZYJ4PStZ0AWyQHdTmksS1YwK0UPfLXtTSfQ09srrvtufXUoIMZwedHghjPLo=
X-Received: by 2002:a17:906:7312:b0:a9a:139:5ef3 with SMTP id
 a640c23a62f3a-a9a01396165mr773988466b.55.1728979167060; Tue, 15 Oct 2024
 00:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829175201.670718-1-oneukum@suse.com> <CANn89i+m69mWQw+V6XWCzmF84s6uQV15m_YdkPDQptoxUks4=w@mail.gmail.com>
 <fd906211-7f31-4daf-8935-2be1378a75f8@suse.com> <CANn89iJWATVhMVDgq3fcV9zpZRt8nd_bWp3=qRHo8L3tJP==Kg@mail.gmail.com>
 <93a8a951-7e0f-4504-8407-15d920236f9c@suse.com>
In-Reply-To: <93a8a951-7e0f-4504-8407-15d920236f9c@suse.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 09:59:15 +0200
Message-ID: <CANn89iJn_irj15UBeKZja7k9ViLGTxL3+fkgCERoAS2NM1hOZg@mail.gmail.com>
Subject: Re: [PATCHv2 net] usbnet: modern method to get random MAC
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org, 
	John Sperbeck <jsperbeck@google.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 9:49=E2=80=AFAM Oliver Neukum <oneukum@suse.com> wr=
ote:
>
>
>
> On 15.10.24 01:00, Eric Dumazet wrote:
> > On Tue, Oct 15, 2024 at 12:24=E2=80=AFAM Oliver Neukum <oneukum@suse.co=
m> wrote:
> >>
> >> On 14.10.24 21:59, Eric Dumazet wrote:
> >>
> >>> As diagnosed by John Sperbeck :
> >>>
> >>> This patch implies all ->bind() method took care of populating net->d=
ev_addr ?
> >>>
> >>> Otherwise the following existing heuristic is no longer working
> >>>
> >>> // heuristic:  "usb%d" for links we know are two-host,
> >>> // else "eth%d" when there's reasonable doubt.  userspace
> >>> // can rename the link if it knows better.
> >>> if ((dev->driver_info->flags & FLAG_ETHER) !=3D 0 &&
> >>>       ((dev->driver_info->flags & FLAG_POINTTOPOINT) =3D=3D 0 ||
> >>>        (net->dev_addr [0] & 0x02) =3D=3D 0))
> >>> strscpy(net->name, "eth%d", sizeof(net->name));
> >>>
> >>
> >> Hi,
> >>
> >> you need to have a MAC to be an ethernet device, don't you?
> >
> > Before or after your patch, there was/is a MAC address, eventually rand=
om.
> >
> > The problem is about the test, which is now done while dev->dev_addr
> > is full of zeroes, which is not a valid address,
> > as shown by :
>
> Hi,
>
> I am sorry I misunderstood you. Yes, I overlooked the test for whether
> the MAC has been altered. I am preparing a patch. Could you give me
> John Perbeck's address, so I can include him in "reported-by"?
>

Reported-by: Greg Thelen <gthelen@google.com>
Diagnosed-by: John Sperbeck <jsperbeck@google.com>

Thank you.

