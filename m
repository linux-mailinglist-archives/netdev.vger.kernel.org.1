Return-Path: <netdev+bounces-182228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A485BA88476
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE6119022D4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF5288CB6;
	Mon, 14 Apr 2025 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XftFHVNK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B82749D8;
	Mon, 14 Apr 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638210; cv=none; b=C6BfSUdxT8eNnrbnOaYixOjBRUw8pcUFglDWjoDSb426WMQ0MTBMwGh0w5bLB1+MouhWl3pAkF0MsBOiAe0vpqLcwwAHk5+vWCd3M8fF82gGDLZy9126ObcI2eTK0u3NR0oMPVefty0r0a2CRYQGJtBb+YclimVBzTA8hLKwi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638210; c=relaxed/simple;
	bh=p8jcNjG+YENQNEfk3hLMJSOgALwsNYI5NHNTYAn1Cbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzckfZME1Gvd5X+3sP8rRo8YblrukVuAhDqJiFXzXyjZKbEkHc+KAAHuAhfp0GzssQOPIybBrVUeD30Bgt5PLCC3/e202OEBpmFSRrUPAAEDJcnow3z+RgLGLBZqplw1OQ0ch84ypP9F4B3fnnasqZqBEIJq2XaZ0VAQThIiFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XftFHVNK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so8122880a12.1;
        Mon, 14 Apr 2025 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744638207; x=1745243007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCg0q41Q1oTIolDKQucNc+JCqwuUZQ7/4IT71QAggp4=;
        b=XftFHVNK3dotypFJSVZFtvzyNAVKqS7uhQdvA09t+kVkt+v/w9DWfN4Hqvt6gS/80X
         bg9eQM8R/2fMrdQDVd4sxhIAHIYyMrqddLwbq+Cd70b79q9zMPThZNBPl8DsSl+ar0f+
         0fp9Z0nPEomb/WeljO5vDmKUW2iXCoDNlMPGfoKgV7bEc7UeDzTKQH8yqxmH0XJuudfd
         YmhTM/Opu6qilKuoQVVg5Wpn2TpIC5NvD/NKugsnloB3OgZwsBLqOQ+JaEPycI+KNSDY
         cr6XTpy3ImHKpUMEp3JwYW+LZ3V7OWMWaqw/Tj3XZxKJ6gFlbIl6JCIjPHxgNqgZOIc3
         YxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638207; x=1745243007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCg0q41Q1oTIolDKQucNc+JCqwuUZQ7/4IT71QAggp4=;
        b=HgCQ8IDuKSV8TeT5oVJQHFy6rAFYAuO7cdnBhRF7WLUF5w+ZMstllaolAmMI0AckOR
         OIP6i49HJ8vUxk5IHzOTHz3g3od37P4FVE1bAwtXDctxkgYhagiihrFxBxiMSkE2lEYp
         660wdAKiVcN3awj2mePBPghCGuCv6QqxW1cWh0xzTCYFYyBiDMtbsl4oWqvv0w5TM1ML
         wv80xiz5/Me4ljwXy55NwOJgKyaHPxVtGPNeba66gIIwwfZ9bo5Of4R3xB0cSPJDgb4Z
         qYaTXLKhEFU4T91b5uuNwNU0Fdpm9d/nZoK3LvEa1dbmtWEUVlGYf/dIX8ngnXCr5qt3
         wmZw==
X-Forwarded-Encrypted: i=1; AJvYcCVHw0ndXN8E9F1GMEp8VdZuAoppHoSxmw2B1GSt/seb9oyIz5LZu6u2qUA6jiobD3460Yt3O7oh@vger.kernel.org, AJvYcCVihWS/LzWaGL9izFjIZ14mlSh+HSSzwL8tRbYgsYhdzZ+Dg3X2D+ZXgpH6ONhvQ5Gx9w3xbMP4QT8s/yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3psKxrvcgLi5vL3poDyCFIjxQjx0w+q5jzxYpIw/G1B4p14nd
	meZa9B746PfGowbpH22Ic8iEgdqGJ7Ch4fursGiiDXF1jsXefc5o3Lfz1+zleeDiamQeYEJElmt
	IiQhpS2gdVV0PdOhdxvJsK5cqkB4=
X-Gm-Gg: ASbGncvXLh8T+dAiCUm10ZpYcKAgvUq1Ty2CdE7vNAoBANdG5DCmlnpKxRuyZkE0Zq3
	sf6ZRSJ+W2ZG07Om4lRWLu5Gxg0sihvM8NILiaJB601Nk8eWFa3sPnoxMiu3nz2pbiJZcsaR2Cy
	IG3gHMan/hN+YFp3/4HjNf
X-Google-Smtp-Source: AGHT+IHBKai4hTiuuz7fgaIpw5CrF4/y6ESvZ6lBc0Xyp0erRglMZFuqA7qlxIgDj5nEv4p5lze2WGYBDpBcRjg5EQY=
X-Received: by 2002:a17:907:60d0:b0:ac2:2ba5:5471 with SMTP id
 a640c23a62f3a-acad34a2f53mr1078321566b.24.1744638206565; Mon, 14 Apr 2025
 06:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414085412.117120-1-maimon.sagi@gmail.com>
 <b6aea926-ebb6-48fe-a1be-6f428a648eae@linux.dev> <CAMuE1bG_+qj++Q0OXfBe3Z_aA-zFj3nmzr9CHCuKJ_Jr19oWEg@mail.gmail.com>
 <aa9a1485-0a0b-442b-b126-a00ee5d4801c@linux.dev> <CAMuE1bETL1+sGo9wq46O=Ad-_aa8xNLK0kWC63Mm5rTFdebp=w@mail.gmail.com>
 <39839bcb-90e9-4886-913d-311c75c92ad8@linux.dev>
In-Reply-To: <39839bcb-90e9-4886-913d-311c75c92ad8@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Mon, 14 Apr 2025 16:43:00 +0300
X-Gm-Features: ATxdqUFheaLcNBvxKZc-9VetpJLUgftYHI2jRhqXyQE-taAumEvII3I0dU9QJyE
Message-ID: <CAMuE1bHsPeaokc-_qR4Ai8o=b3Qpbosv6MiR5_XufyRTtE4QFQ@mail.gmail.com>
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:01=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 14/04/2025 12:38, Sagi Maimon wrote:
> > On Mon, Apr 14, 2025 at 2:09=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 14/04/2025 11:56, Sagi Maimon wrote:
> >>> On Mon, Apr 14, 2025 at 12:37=E2=80=AFPM Vadim Fedorenko
> >>> <vadim.fedorenko@linux.dev> wrote:
> >>>>
> >>>> On 14/04/2025 09:54, Sagi Maimon wrote:
> >>>>> Sysfs signal show operations can invoke _signal_summary_show before
> >>>>> signal_out array elements are initialized, causing a NULL pointer
> >>>>> dereference. Add NULL checks for signal_out elements to prevent ker=
nel
> >>>>> crashes.
> >>>>>
> >>>>> Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and update sy=
sfs nodes")
> >>>>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> >>>>> ---
> >>>>>     drivers/ptp/ptp_ocp.c | 3 +++
> >>>>>     1 file changed, 3 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> >>>>> index 7945c6be1f7c..4c7893539cec 100644
> >>>>> --- a/drivers/ptp/ptp_ocp.c
> >>>>> +++ b/drivers/ptp/ptp_ocp.c
> >>>>> @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, stru=
ct ptp_ocp *bp, int nr)
> >>>>>         bool on;
> >>>>>         u32 val;
> >>>>>
> >>>>> +     if (!bp->signal_out[nr])
> >>>>> +             return;
> >>>>> +
> >>>>>         on =3D signal->running;
> >>>>>         sprintf(label, "GEN%d", nr + 1);
> >>>>>         seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu po=
l:%d",
> >>>>
> >>>> That's not correct, the dereference of bp->signal_out[nr] happens be=
fore
> >>>> the check. But I just wonder how can that even happen?
> >>>>
> >>> The scenario (our case): on ptp_ocp_adva_board_init we
> >>> initiate only signals 0 and 1 so 2 and 3 are NULL.
> >>> Later ptp_ocp_summary_show runs on all 4 signals and calls _signal_su=
mmary_show
> >>> when calling signal 2 or 3  the dereference occurs.
> >>> can you please explain: " the dereference of bp->signal_out[nr] happe=
ns before
> >>> the check", where exactly? do you mean in those lines:
> >>> struct signal_reg __iomem *reg =3D bp->signal_out[nr]->mem;
> >>      ^^^
> >> yes, this is the line which dereferences the pointer.
> >>
> >> but in case you have only 2 pins to configure, why the driver exposes =
4
> >> SMAs? You can simply adjust the attributes (adva_timecard_attrs).
> >>
> > I can (and will) expose only 2 sma in adva_timecard_attrs, but still
> > ptp_ocp_summary_show runs
> > on all 4 signals and not only on the on that exposed, is it not a bug?
>
> Yeah, it's a bug, but different one, and we have to fix it other way.
>
Do you want to instruct me how to fix it , or will you fix it?
> >>> struct ptp_ocp_signal *signal =3D &bp->signal[nr];
> >>>> I believe the proper fix is to move ptp_ocp_attr_group_add() closer =
to
> >>>> the end of ptp_ocp_adva_board_init() like it's done for other boards=
.
> >>>>
> >>>> --
> >>>> pw-bot: cr
> >>
>

