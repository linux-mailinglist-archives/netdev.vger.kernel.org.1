Return-Path: <netdev+bounces-106896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C46917FDE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5412881DC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450E17F38B;
	Wed, 26 Jun 2024 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx9zBwwr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3E17F38D
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401938; cv=none; b=llv4Wk/WNqkjUfq/aFLaWgyHrfe1MWdiDiZbaM9JlBrTihZEX9dy6gTYG3qI8Tk3e7fPYP+9hTVl7M8Iix82E1IAKDxnHqntNvSzyOGrKkUkCXDBMCYfSEeKdFUKrrk4ND9LJFZVMbuDRvRbRQ7nLXXxgdSJKAUfspVbYQzKac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401938; c=relaxed/simple;
	bh=mUq588Qe4yRHMr1djrjz20YflZC4ltQzQso/AHedz14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caJQPIJ+3kXy4ZeWySG/S4x3p6SBebzTUOJDuCL872/Akuo5jWa3HMjZi8nxlWDxMFGIDYH1lmabJuAzpoJsDGBMXRrK/8uDLBofYVc0m2gwLS4rKp/5Tf364az7UmV99Mw1EyiATvGl3HfTVQBu4tZUDpnnVQIl45AOJzq0uL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx9zBwwr; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4ef64689d24so1353138e0c.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719401936; x=1720006736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuGRg0YqzzRFoyAljBwvAZcvEJ24Rf0t8BEeVXc6OfQ=;
        b=fx9zBwwr/2K7+k9RLq45chDdkv5Do1D8NVy/h/x6LWX2cFIpJjKc34+aXcsImrrtxV
         zThBfDLsZ/i45eohhcd/92xcY5pUkm/gO33ocL9e+aDb9+xVktDzWcDp/e6r5lRq5n2b
         IiQGmgHH3UHL3oFVqRMyoicma10Zu1HIeS+6VvF4uVYaskclNGGC/fxu73cGwnsP6Qb6
         1cqkHCT/nkSZXab6vCQfVeQ+RE1jKwpKzJ3lQ4T6DVFDCyAPXeWuT1IJY83xYRNFTx0C
         D54Im/cmoMzi01C3Li6jFJmBerpIT5tqwuTJh8FmyMsambqjZqbTqTIuW2uk8ch+3mqA
         DdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401936; x=1720006736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuGRg0YqzzRFoyAljBwvAZcvEJ24Rf0t8BEeVXc6OfQ=;
        b=ji9LJ3yoTh4kKlX/M5yCjZJow2mswTZdqzSNWB0thwcSezG+fiGRzMTbt4/mYgYVHF
         pOkDU4is1nqM8U+Y74dcHF1l8M4HD2ug3VbbKluY5OHQeBDV0yj8rrwBkVsxl9aO2fUH
         cpcWWq2iVwXjaeiJaxvLNK1EwDiNKtMlc4EyvDDUoo/ET8XHsSdEYkcs5lZIHOFnqUfo
         ID9TTTqPTL1lRHJvyKqcruFs6aK4YvPv+Kahv/zvHyt/JuUVhGyLxGJVYuu/jfqJsr1u
         LvoQ5WtZcZUY3xZ7eXVQXf/MgTijYBzbC9HSOIId6zcE96kfSJash/nZhAJ2TCaRJHt6
         qXrg==
X-Forwarded-Encrypted: i=1; AJvYcCWfcBPzkdvw+OKcQNORkvdc0M0uvP2ztlQtbzrYXs2SZAMX6vZf8bNyl9aFsRyEg3LFgdaMxgZ3pI92WOYoRodQrIvXSOrt
X-Gm-Message-State: AOJu0YyLQt3XqcsvhJQBA/8eWbl2MjDxEuOHB6sLb8qaobNuvOIyjSOW
	alZdR5QSAHOlyBj8NTZsi1piAZs14c+QA8zgq8mB77MQ4ElYSfisSAvFj2aEVnHa8tr4P+Bj1Gm
	7r3bo+2i40CwwDgHAQ9ix5YWvv4o=
X-Google-Smtp-Source: AGHT+IF9p36fid8TUnDFINF+ddkLUM5sXuszTaTX5hwTUT32+lzMBf0Ty/MLhz+D887Aw0sEMlDvrsNpCkP9+XAr39Y=
X-Received: by 2002:a05:6122:1789:b0:4eb:5f62:d605 with SMTP id
 71dfb90a1353d-4ef663f9a1fmr9867742e0c.10.1719401936203; Wed, 26 Jun 2024
 04:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+V-a8s6TmgM4=J-3=zt3ZbNdLtwn5sfBP6FdZVNg09t634P_w@mail.gmail.com>
 <DM4PR12MB5088D67A5362E50C67793FE1D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
 <CA+V-a8vOJmwbK6Oauv4=2nRXZcOVR2GDH8_FBQQ1dpE8298LKQ@mail.gmail.com>
 <DM4PR12MB50886C5A72024A6F5D990F86D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
 <CA+V-a8vwaCt-hspXhdrVSKzTYDnpn6ppHpGcpbD5NSgiQrGeTA@mail.gmail.com> <DM4PR12MB5088B2F2D3A1E8AB1FB34424D3D62@DM4PR12MB5088.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5088B2F2D3A1E8AB1FB34424D3D62@DM4PR12MB5088.namprd12.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 26 Jun 2024 12:37:59 +0100
Message-ID: <CA+V-a8uf2v=PzcXyuGkGSh9QcjUHcCM3_YCNKuaYwotNFKHcVA@mail.gmail.com>
Subject: Re: STMMAC driver CPU stall warning
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jose,

On Wed, Jun 26, 2024 at 11:54=E2=80=AFAM Jose Abreu <Jose.Abreu@synopsys.co=
m> wrote:
>
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Date: Tue, Jun 25, 2024 at 16:15:15
>
> > Hi Jose,
> >
> > On Tue, Jun 25, 2024 at 1:11=E2=80=AFPM Jose Abreu <Jose.Abreu@synopsys=
.com> wrote:
> > >
> > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > Date: Tue, Jun 25, 2024 at 10:30:41
> > >
> > > >     mtl_tx_setup0: tx-queues-config {
> > > >         snps,tx-queues-to-use =3D <4>;
> > > >         snps,tx-sched-sp;
> > > >
> > > >         queue0 {
> > > >             snps,dcb-algorithm;
> > > >             snps,priority =3D <0x1>;
> > > >         };
> > > >
> > > >         queue1 {
> > > >             snps,dcb-algorithm;
> > > >             snps,priority =3D <0x2>;
> > > >         };
> > > >
> > > >         queue2 {
> > > >             snps,dcb-algorithm;
> > > >             snps,priority =3D <0x4>;
> > > >         };
> > > >
> > > >         queue3 {
> > > >             snps,dcb-algorithm;
> > > >             snps,priority =3D <0x1>;
> > > >         };
> > > >     };
> > >
> > > Can you try this queue3 with priority 0x8?
> > >
> > Thanks for the pointer, but unfortunately that didt help (complete
> > boot log https://urldefense.com/v3/__https://pastebin.com/5Fk0vmwa__;!!=
A4F2R9G_pg!dXl2MXrv1PQeNlAlV9-E-gEBgEF2xNPOWUC8pCa0WFor9hC-KFRIJl8clk7v1sLg=
pAeReI0cfH9wNOHrdHqP0mi0sDevxQ$ )
>
> Ok. Then I would suggest you try with just x1 queue and confirm if it sti=
ll happens.
>
I did confirm, this still happens with the 1x queue.

> If it does, then maybe a bisect will help.
Yes I think that's the only way to resolve this.

Cheers,
Prabhakar

