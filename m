Return-Path: <netdev+bounces-182129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8FA87F41
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC223B8459
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8BC29AAFE;
	Mon, 14 Apr 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfFG4sTn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF429AB0A;
	Mon, 14 Apr 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630755; cv=none; b=HoOVf6nXy67p6daHyZekOVp+dnUvMxdy5V/fsA0qsjIPrQgfEFNGsc7ur2+Mu136MvOz6qj53EAHUiqLZIk91/ojyGEu6Z70sge/JQJA+IUCP+HrdC/GN/rIqSsxcwyxwCV3bq10Ofjp9kl5b5LeR3UzOt/O2jQNZ4RkYET+Czc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630755; c=relaxed/simple;
	bh=FyVWnpa4/PtbPKZcTFnoIrzLAhKqHQiTyYZCE5N8F+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtCOb4vUu4utr1lDt0vUOqkrcFrEcbnTECq5qFVTK/xQNx4pKHmYeRM2/bfmQ0o6QBxhI2DeBpcZfqBMDXfCC9NsM874AcsSdXHwxllFSqQiuuV3roNwt/XVjKQYpqD2PWCyz8X8gm1O7IytjSZgdO5AaaHG+ftVvU43g9Ge2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfFG4sTn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso810883966b.0;
        Mon, 14 Apr 2025 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744630752; x=1745235552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6PwPr4LZYXEj7QhUyvyfmnH+e+d5JgPgBGYKHOh478=;
        b=WfFG4sTnskXpXvNHRw6tl8LwiEDEl2/GXAgmQ/GsLPbTpF3Oj1l5t7KW2VXZ6kXJ1x
         nCCB1NAEhp3epTpXq9nWxGnRVxO5yj8kcriiVGUzkFRoWmzESMuZVNwIt5Af8ujvhyuB
         w54SqH9vbsGiuQABrZvHWLRnYHgxmPtVcDKgXzPgcwQ7Xln2Psv2VpqQyr2MLKb98NmV
         hgcKVPcuI8wZDrROtQFiwo4bBLKD7wkEyT2vcEwYqghcXI6UeJutXFtP5RqFFaNq+2qm
         fDg2soE9jsy3zmezIKvi0hTbcGiCY6iZcDOc//gjvBxiDnT/H1BdAiBJxFhKCg9h7l8o
         CmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744630752; x=1745235552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6PwPr4LZYXEj7QhUyvyfmnH+e+d5JgPgBGYKHOh478=;
        b=GJ1m8mDaGedkNAAL1JjUTqY9gKo7H8mFHcys52YpwF7eVg3LDt8ai9cUjzYB+UWa6l
         z1XZa+TqNOWig6wUYMOLMJYKH/sfg9wZdoaaHlBzPL4K/Y5EaCPP+3j8ZMPnjOqENJyj
         txk5fpsYc8Kz6KJR4vdaevnh+qDCcvkOmHkfyoOHX30ImZsErR8BIcwdVcyIhVcZZi7S
         F072vnh0FOzPw8EALf0h0mmY4AO3he7HYoGWc/Qn9kSlvqMU4LdPCoY8AaP8WzNZfhVE
         ubT3O04Rm6s77aii4kV/qT2d5pxBldD/0VFmIXEfMPExJTvplYTEAyVk237L6d1EEg/7
         WUdw==
X-Forwarded-Encrypted: i=1; AJvYcCWXIgOS3r/0neIOCS/5l8ADSzVRtUU7PEBrVASZYiK2rxGjqgSNTr/K0MLpbz/9/Bvf0BP6/yhyxeu/RHs=@vger.kernel.org, AJvYcCXKq3W0gn00QWbRa1n/8OMVhFqpKHi9UBmZlmkP4YN9WZ+I/O0DZLLKDSoCrCSe/8JtVvco96rF@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuclLajBE9PicHTqhBlE0KnpV9YIFXcVgShZWF8HqFCYCEYkG
	xDIj/xZFNnIgrX6BVjZfqVkdOGqrwiZee74u61PKvXCa/shc3GRLxSfBhAdosHpbIGdxfBCINcE
	L6ff6SoJAn+AqIwpk/5KVYIn6Th6qM5BDckc=
X-Gm-Gg: ASbGnctwCkhuhIFjSF57ptuDadM+yZ5obkoa53APEKKhI/yVXNWwWviKh9l5FSEPDNc
	yyApzqqzboyr8g+nifD+WMthGFNFnQfjkEjJilhHbbQctOYLkYTC/rNgEzWzFVtNue/D9L9RPMQ
	x+Y+ZgkFFYV2VgeDrqzaYnpiapBhe2+Jg=
X-Google-Smtp-Source: AGHT+IHgZ2/rXYU/OGDbcfayiE0rw+vTh3MWm4mOX17tRBHKvUWo5Qflea89DZfZ3iyLUiKBINgS89iXQlVnZIx3jkY=
X-Received: by 2002:a17:906:6a27:b0:ac8:1bb3:35b0 with SMTP id
 a640c23a62f3a-acad34a184dmr1017501966b.20.1744630751474; Mon, 14 Apr 2025
 04:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414085412.117120-1-maimon.sagi@gmail.com>
 <b6aea926-ebb6-48fe-a1be-6f428a648eae@linux.dev> <CAMuE1bG_+qj++Q0OXfBe3Z_aA-zFj3nmzr9CHCuKJ_Jr19oWEg@mail.gmail.com>
 <aa9a1485-0a0b-442b-b126-a00ee5d4801c@linux.dev>
In-Reply-To: <aa9a1485-0a0b-442b-b126-a00ee5d4801c@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Mon, 14 Apr 2025 14:38:45 +0300
X-Gm-Features: ATxdqUEpnPU3zu3s09tXz533FGAy5vpZCIylZKOeqAHMcDlPRDdFr6WOEbEI3xg
Message-ID: <CAMuE1bETL1+sGo9wq46O=Ad-_aa8xNLK0kWC63Mm5rTFdebp=w@mail.gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 2:09=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 14/04/2025 11:56, Sagi Maimon wrote:
> > On Mon, Apr 14, 2025 at 12:37=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 14/04/2025 09:54, Sagi Maimon wrote:
> >>> Sysfs signal show operations can invoke _signal_summary_show before
> >>> signal_out array elements are initialized, causing a NULL pointer
> >>> dereference. Add NULL checks for signal_out elements to prevent kerne=
l
> >>> crashes.
> >>>
> >>> Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and update sysf=
s nodes")
> >>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> >>> ---
> >>>    drivers/ptp/ptp_ocp.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> >>> index 7945c6be1f7c..4c7893539cec 100644
> >>> --- a/drivers/ptp/ptp_ocp.c
> >>> +++ b/drivers/ptp/ptp_ocp.c
> >>> @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, struct=
 ptp_ocp *bp, int nr)
> >>>        bool on;
> >>>        u32 val;
> >>>
> >>> +     if (!bp->signal_out[nr])
> >>> +             return;
> >>> +
> >>>        on =3D signal->running;
> >>>        sprintf(label, "GEN%d", nr + 1);
> >>>        seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%=
d",
> >>
> >> That's not correct, the dereference of bp->signal_out[nr] happens befo=
re
> >> the check. But I just wonder how can that even happen?
> >>
> > The scenario (our case): on ptp_ocp_adva_board_init we
> > initiate only signals 0 and 1 so 2 and 3 are NULL.
> > Later ptp_ocp_summary_show runs on all 4 signals and calls _signal_summ=
ary_show
> > when calling signal 2 or 3  the dereference occurs.
> > can you please explain: " the dereference of bp->signal_out[nr] happens=
 before
> > the check", where exactly? do you mean in those lines:
> > struct signal_reg __iomem *reg =3D bp->signal_out[nr]->mem;
>     ^^^
> yes, this is the line which dereferences the pointer.
>
> but in case you have only 2 pins to configure, why the driver exposes 4
> SMAs? You can simply adjust the attributes (adva_timecard_attrs).
>
I can (and will) expose only 2 sma in adva_timecard_attrs, but still
ptp_ocp_summary_show runs
on all 4 signals and not only on the on that exposed, is it not a bug?
> > struct ptp_ocp_signal *signal =3D &bp->signal[nr];
> >> I believe the proper fix is to move ptp_ocp_attr_group_add() closer to
> >> the end of ptp_ocp_adva_board_init() like it's done for other boards.
> >>
> >> --
> >> pw-bot: cr
>

