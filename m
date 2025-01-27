Return-Path: <netdev+bounces-161232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAA7A201B9
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554B23A3DB1
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C31DB346;
	Mon, 27 Jan 2025 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn2l8FSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D76156F57;
	Mon, 27 Jan 2025 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020698; cv=none; b=r9h9NeAYhUgtPcsFgMjocxOMq+EMdPaaFgJL3yHA7sJrNMTeDl0LAcMKjGB2ku33H6zbZkUS0CxZsuaaY1Hx9vdRmE9gbDaVuhVxRiPF0iyD+GY036A76V7XTZZtXOyQD/tKmphdk7xOIQyuWdxwS81KIYIGunciw1/ttCZjY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020698; c=relaxed/simple;
	bh=QdvEnwBm3WHA0eZGYhCmkCRITu8gts8CSOmECjnksg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVxG+WMCRz/HGMqYjhGx6r3XmUBQCHaZ7zyETie9C40NiGofcjwxMYSQfwZk4CDVGnjaS+H5Emk/Ih8ZLgy1eHMFFmexmFALcs3IDLO6pbpeZYQgX12FQC2yNi21cHwnJu8fEy2JJkXODU/kEBIh1/y9RnGZ5+N3P6pbYgRxOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn2l8FSP; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cfc154874eso38574815ab.3;
        Mon, 27 Jan 2025 15:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738020696; x=1738625496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZOqx/J0Kg6rPZ87QZV09RctWlAEPVfvKjYcnmE4HwE=;
        b=Fn2l8FSPPVhUwzzndrG2wy9eRMVjeP9zWYkKHkkYbXuw39P69r/cXxSmAg+/fTru0S
         Nj7pBLhtwqRu66MdC/oDGI9xoEkDtawoRyOBgpRnmrnPIBd984/3cXz+fMHG5nuASYX8
         MnjjO61rjjPJqY7Vi/rqkdzgxZVRHndoYPMbywMlMT0UqdGygYyE1zBlJzjdPsTozT+4
         MUPk/aH9uBD3/C2mPgyi1s+U7YYVel/ue2+E0WBNZh5Pw5DOCoxAmaS0icH1PxtVxCC6
         yNF6n4DehgAcbEuM71C/BvlRdsXuVtmCHtG7zSer3w6UV67Q6fniIP25/ihuDSZrNauQ
         L19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738020696; x=1738625496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZOqx/J0Kg6rPZ87QZV09RctWlAEPVfvKjYcnmE4HwE=;
        b=sEjBBV5b9pE7Ce8/ES2bTb6YHOJzuGTGwqdF38+RbIG+cIXeyaVhdSrOsXoUkzkUxz
         cfSF/JhiMotYl1J0IHzxKP4591aI14ZES3qoxMO61CuJjWUq3jGTTWtQ0l0U/J93cAXV
         NjWEdedsz1/sK5sVfNVHPpBMP0rsm1QZHO2woFriqV6RsgdrlQYyY6eDh82ItpNgyGN7
         emiWVZ7zS2i4BY1R/cMUXYzT03MoPp6zbPzRKA/RBLJG8i6wKbtAg2AOicPTR0K3czQZ
         2Mt4qFIEADSJCmY91KcXONSPIa3vVo5vl30gNdm3abLLc3KZpqEa0n4ypZVbaoT0AIqT
         rg8A==
X-Forwarded-Encrypted: i=1; AJvYcCXGLkl0sHHop5gSnSyIJ+KvmiCOj92D4PqM7llAcllrpddOZRPggStFP3tFQTtO7F9kUFIlQjLk@vger.kernel.org, AJvYcCXLHvkmq26wbh7cx/+pWnDX/+MhFRjIYh7JHTKklplWALoMNMQzMomlS5PEmKXWw6xvLATnA29VAt60BfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGp8DIXAxdSQh9EBHdLxQ0QPLmRoB2R3r9eosUEzjAEk9yaUjE
	4WUwBaYGGM6gJHVGW83hpeO59b0F9NOIuhv3XilYRAtI0fX1j0OIIsOtK3RJfl5ioizQyt3yoBP
	wdlFcM8v+Jk70cD23LITLh8F5UW/ArbPC
X-Gm-Gg: ASbGnctKYCGGvZ+qeu6mfoH0n/nZz67SaHeYQ6tMrmwzMgWgYTFuOAfz1TLBnHXu8ZL
	GLMOSArwFvhOVOjefKNkB+1cUYy8YTgKYccPhd0db0OkR3S/1NdHdlTTQAtVMiQ==
X-Google-Smtp-Source: AGHT+IHkVROSrMtvrGqkVRp+DnfGJpy6y2NxGYw+B7VLdsSbgTKsQxmZi5I+AhGuEDOeaWcVYkfuCoamUKI/egKkgZw=
X-Received: by 2002:a05:6e02:3993:b0:3cf:cca4:94f9 with SMTP id
 e9e14a558f8ab-3cfcca49785mr126238985ab.5.1738020696043; Mon, 27 Jan 2025
 15:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501261315.c6c7dbb4-lkp@intel.com> <CAL+tcoBBjLsmWUt9PkzDhVtGLm-s53EyTzcHhpTkVnLpgz0FXw@mail.gmail.com>
 <CAL+tcoBmRVKUfhR8DiMryD4h5ZJeQpGuhPyzK3fexiEBvE_KDA@mail.gmail.com> <CADVnQykLL+ZcY0Myg4n0_5PqtOJ9ifxh6nb2VW2txGNDFDF1jg@mail.gmail.com>
In-Reply-To: <CADVnQykLL+ZcY0Myg4n0_5PqtOJ9ifxh6nb2VW2txGNDFDF1jg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 Jan 2025 07:30:59 +0800
X-Gm-Features: AWEUYZkMM4WJlm5flMtdwfyWqSBI-w-8wlnWd--6HCufXodcclkB1wTsmbIQgI8
Message-ID: <CAL+tcoDP6VCp45dJHWmgbL3W+OxD9-N2J-qUYEKkLSYTMupNzA@mail.gmail.com>
Subject: Re: [linus:master] [tcp_cubic] 25c1a9ca53: packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail
To: Neal Cardwell <ncardwell@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, Mahdi Arghavani <ma.arghavani@yahoo.com>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 11:03=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Mon, Jan 27, 2025 at 5:20=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Sun, Jan 26, 2025 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Sun, Jan 26, 2025 at 2:30=E2=80=AFPM kernel test robot <oliver.san=
g@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/c=
ubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail" on:
> > > >
> > > > (
> > > > in fact, there are other failed cases which can pass on parent:
> > > >
> > > > 4395a44acb15850e 25c1a9ca53db5780757e7f53e68
> > > > ---------------- ---------------------------
> > > >        fail:runs  %reproduction    fail:runs
> > > >            |             |             |
> > > >            :6          100%           6:6     packetdrill.packetdri=
ll/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail
> > > >            :6          100%           6:6     packetdrill.packetdri=
ll/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4.fail
> > > >            :6          100%           6:6     packetdrill.packetdri=
ll/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv6.fail
> > > >            :6          100%           6:6     packetdrill.packetdri=
ll/gtests/net/tcp/cubic/cubic-bulk-166k_ipv4-mapped-v6.fail
> > > >            :6          100%           6:6     packetdrill.packetdri=
ll/gtests/net/tcp/cubic/cubic-bulk-166k_ipv4.fail
> > > >            :6          100%           6:6     packetdrill.packetdri=
ll/gtests/net/tcp/cubic/cubic-bulk-166k_ipv6.fail
> > >
> > > Thanks for the report. I remembered that Mahdi once modified/adjusted
> > > some of them, please see the link[1].
> > >
> > > [1]: https://lore.kernel.org/all/223960459.607292.1737102176209@mail.=
yahoo.com/
> > >
> > > I think we're supposed to update them altogether?
> >
> > Should the updated pkt scripts target net or net-next tree, BTW?
>
> Those packetdrill scripts are not in the kernel tree yet in "net" or
> "net-next". I suspect they are being pulled from
> https://github.com/google/packetdrill ...
>
> I will try to update those packetdrill scripts ASAP, using Mahdi's
> updates as a starting point.

Thanks, Neal. I can also contribute to it if needed as I've already
started to implement hystart++ one or two days ago (after
communicating with Mahdi Arghavani).

>
> It seems that perhaps we should migrate all the Linux packetdrill
> scripts to the Linux source tree, so we are not in this confusing
> state where some tests are in https://github.com/google/packetdrill
> and some are in the Linux source tree...

Agreed.

Thanks,
Jason

