Return-Path: <netdev+bounces-161134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC468A1D8F6
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6413A4A5A
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56704130A54;
	Mon, 27 Jan 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Spdst/6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FD4D8C8
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990205; cv=none; b=eXn1RE/7MKbJiqmXcG4dPbXbzJdPkzerLuqe6xKFxRGlYdID5qg9WO0SUQvIQ7Uqcr04qhub1BR/Ye7tXda+u09XwSCAIY/F0LPV0hxAzrf3/pUVYZG/XROTyEcEASDB/fT3iw2TalYNqq52M0EGNBgpRWGmtmgmRfVfLbf7e7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990205; c=relaxed/simple;
	bh=AeAi9kZJW2Rqbj0IdEpHm9Kw4t6+sytg1ubGnJr6/RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzNanTPrHBRBXqZdjbK5GYZsc6OxqTxig5kNB5cWEEbnnAZybMY9CyGE/Aomxzrm94DJwgIOI2Q9ARTDJ54gbG4yjm+PrSY97BEarf9VfDlJbfjDUkKPfINlbqqiSQEIP5q3yvCZHb+BH5LibzoXiF2o/AztzoN9KlQAhW4N6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Spdst/6s; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467abce2ef9so458111cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 07:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737990202; x=1738595002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbAYdFTBfb7doG73J1WAZ75UQhB7XRBXu5lFgptGDgc=;
        b=Spdst/6seOK98L8SeWIPz+ZBCnzkAOzWXTdbNSaZRDWE7/2FGIUre24qbiblZuszz+
         BWko1bQ4/g7u5OkUQxRK99iZO6anv6upHtb7aHwHGf/wMUIcZOk/RaEurEUFO3Tml0CC
         qIxosXShCmbu+/qCsJAwx/QpJrAlI6BjRGciYKj0ytIUkpU5kVANg6b22G3ZcFyyUtWM
         urJiC3xqnYd78/lFTh9HmbplK6ni+1DAcrcX8JJrV2PV52Y8roZty9lhB1F/hGKL+ayR
         P+zbvMSzoX1qebiFXbbsguRq3sfOWaOp4rzsc48CKISFB1h/dbVw++H1PsKsqOwrgxrg
         O6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990202; x=1738595002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbAYdFTBfb7doG73J1WAZ75UQhB7XRBXu5lFgptGDgc=;
        b=BTDJv6CgLypDS9r2UYEWWdk0dv4W3JQzmLnnRBQmEiLUW8TdfmbiJDFMyS6djrxk0T
         C443nRTlhfZ3ToHM4aWPkm/USBin3DpM9NYUelnMOHVRh4+rcHeduCMurHXeFIbznuaL
         TPgeGoNp/PYIuAf9BQeLOB/e761GUxZT8SdKqUYURJ7IRCAFOWj0zhVKzBkuzIUUJB/N
         e/BLiYXFV39qQeyczk7sz5JmLqJdo+VG+IME+v6YMW45YDG/klQvPZw2S7H0Wpv/JGYB
         OAivnkN1BnfMcHqYcWIuv0xWBA+fVR9iaP0dmOP0TBA0ihJmJf50BsupGVZ7pflwr/Ib
         WORQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBVANEQ9xeoUCvrK7DJ6YhBPdskiuZgBrcxWKRdBoe/pj/cKEEc/1+8itz+NhIa8gaW5zsjvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQYPGN/zYXkNTaB3c/b+2FAVS2IL0ODcWj8dX0YowvIjxQQ4y
	RLYucOmXB0A8gvVXtEFKngVMrEbpgKKfPu8k4rXU7MTZPLg91KpWXmPkhXguLtFqxHKjXRoCYRj
	Oa1mr0aeKUADNLtc6aqPPkzgZlZiF03y+49+Q
X-Gm-Gg: ASbGncuYr5r5oGqf+JFAM4DTEcZO7VVzs1lqJG/TN2RlmbNI3COlKhx3PrIWO8R/EFo
	iMDI/eRSPDDMpBTeGXE0V4F4Bwncf7UqBC6mC0RDI2ua2p77DbCs5Yt5sI8atCiTEHcJZSREUft
	gX+6x4cx8hX66giSVqz1o=
X-Google-Smtp-Source: AGHT+IG6X10iFWqByvszIHPgMPWRI52DQt1qSd78hKZ9dYxLBn73U7n2AAPdc0t1NLQG2nySejRRrE62U4s70NdQkE0=
X-Received: by 2002:a05:622a:a19:b0:467:8416:d99e with SMTP id
 d75a77b69052e-46fc3df11c5mr44941cf.21.1737990201231; Mon, 27 Jan 2025
 07:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202501261315.c6c7dbb4-lkp@intel.com> <CAL+tcoBBjLsmWUt9PkzDhVtGLm-s53EyTzcHhpTkVnLpgz0FXw@mail.gmail.com>
 <CAL+tcoBmRVKUfhR8DiMryD4h5ZJeQpGuhPyzK3fexiEBvE_KDA@mail.gmail.com>
In-Reply-To: <CAL+tcoBmRVKUfhR8DiMryD4h5ZJeQpGuhPyzK3fexiEBvE_KDA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 27 Jan 2025 10:03:05 -0500
X-Gm-Features: AWEUYZkcows-F6LzFJgrVDYDJnqsX3XKh2hHY-stktIgVvLOUhs_-CO4w8C5Ic0
Message-ID: <CADVnQykLL+ZcY0Myg4n0_5PqtOJ9ifxh6nb2VW2txGNDFDF1jg@mail.gmail.com>
Subject: Re: [linus:master] [tcp_cubic] 25c1a9ca53: packetdrill.packetdrill/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, Mahdi Arghavani <ma.arghavani@yahoo.com>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 5:20=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sun, Jan 26, 2025 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Sun, Jan 26, 2025 at 2:30=E2=80=AFPM kernel test robot <oliver.sang@=
intel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/cub=
ic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail" on:
> > >
> > > (
> > > in fact, there are other failed cases which can pass on parent:
> > >
> > > 4395a44acb15850e 25c1a9ca53db5780757e7f53e68
> > > ---------------- ---------------------------
> > >        fail:runs  %reproduction    fail:runs
> > >            |             |             |
> > >            :6          100%           6:6     packetdrill.packetdrill=
/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4-mapped-v6.fail
> > >            :6          100%           6:6     packetdrill.packetdrill=
/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv4.fail
> > >            :6          100%           6:6     packetdrill.packetdrill=
/gtests/net/tcp/cubic/cubic-bulk-166k-idle-restart_ipv6.fail
> > >            :6          100%           6:6     packetdrill.packetdrill=
/gtests/net/tcp/cubic/cubic-bulk-166k_ipv4-mapped-v6.fail
> > >            :6          100%           6:6     packetdrill.packetdrill=
/gtests/net/tcp/cubic/cubic-bulk-166k_ipv4.fail
> > >            :6          100%           6:6     packetdrill.packetdrill=
/gtests/net/tcp/cubic/cubic-bulk-166k_ipv6.fail
> >
> > Thanks for the report. I remembered that Mahdi once modified/adjusted
> > some of them, please see the link[1].
> >
> > [1]: https://lore.kernel.org/all/223960459.607292.1737102176209@mail.ya=
hoo.com/
> >
> > I think we're supposed to update them altogether?
>
> Should the updated pkt scripts target net or net-next tree, BTW?

Those packetdrill scripts are not in the kernel tree yet in "net" or
"net-next". I suspect they are being pulled from
https://github.com/google/packetdrill ...

I will try to update those packetdrill scripts ASAP, using Mahdi's
updates as a starting point.

It seems that perhaps we should migrate all the Linux packetdrill
scripts to the Linux source tree, so we are not in this confusing
state where some tests are in https://github.com/google/packetdrill
and some are in the Linux source tree...

neal

