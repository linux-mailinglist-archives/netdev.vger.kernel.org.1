Return-Path: <netdev+bounces-109595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E2C928FF9
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 03:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464901C21771
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8807C5C99;
	Sat,  6 Jul 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uSjLIBaH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C03A927
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720230141; cv=none; b=VlJrQLh8ncCU7Ss0VxhSChOha9uNd59+M2MH+P8pyocMT4e8ZZhAEn6ECrqcWs2dMBTXgCvw7qenaE3F/ycTJIW5jYF8NCPCYQ9prVkRKWkKYletk0plU6Fz+5eXxarhZ/LYfm721iRuh8hPqrrteO1NxCHL3NMgu243b34nFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720230141; c=relaxed/simple;
	bh=ex1DgW/ugHLSPdwkHXbUFL/F/HftU3SgsiKaObspFpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ud9OGoqhawQtfC4PcI8du6jUchQfrvSV0dqoY4F5+LlzRr0R0Yh5YW3It6F0uc4THD5tIPUxEA6j/QrO7PB0b3ggKRhPtrEvAmWGrF553MJYtR5VIoqesqu9d6KIwiJlE8jzzhOcZz3p6jb2muNhxZgx4FpZi/A2u1ngLOOWC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uSjLIBaH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 28BFD3F460
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 01:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720230132;
	bh=3XZ/I8/29Q9OqWgdwL7m4G683taXQm9BCOiYZ403b1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uSjLIBaHFAyyDJKIQisgfh/b+1FTaLDKca0hSv2lhh+KE2KilZlRmgZrI8O6ShUze
	 37Xwe0fQ7z5HHm+nq2gdgR1Sdn7CFDWz157yl0yc1W9uyBMP4tIuCWBkDSScwLEluS
	 CSZmHJk4zLlXz9pni8N023SvRUUvKOIviuiarfRB9gWJeMkZdPmJJ3TCke4QURyri0
	 xRZASQeWlDLw9MgQPAvWq6Mqzws/s1X5hetp00L+osKqB3u2+oQnTyW+YNJ4Uhv7Hv
	 6hQcCSKnFq/1+7CkUKFkEyX2u7dtNYfR5r0Z+tKzL6JGaOwlGynamq5uhWiP10vnzn
	 kUHT3uAwfT57g==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57c93227bbeso2328212a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 18:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720230131; x=1720834931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XZ/I8/29Q9OqWgdwL7m4G683taXQm9BCOiYZ403b1I=;
        b=X9ma5POhxjjy02dcZvAsufKv4KSh6mKbbUrIyn0T7PU68eKt2BJEvqmk5liXPPAD1P
         ONLDZ7JU5KAB8mwq9ivMslelUtybmq2R3GJvKm86n+r9lXGdZMn4smbWaGSzXrlwtT3M
         r0XhdGClHW87pBpIixc3/gQEHmJGQiemUAdZpvMZq7krSL0YGTNh1uqC7BoVh6+zwL8I
         lFTL5I9Yyhkn2COI0bL0BfTQ5Cg74NVDwtntX5QaPM3xjXdBLGfdc7fPSv7m1+xex4ei
         nPPqTj3YzS2YzRghQIXdZUQK9gvAKonhTDFSRGsv0OxqTyqyXw6rcXizf8d2lbv/d0ai
         YQnA==
X-Forwarded-Encrypted: i=1; AJvYcCXPc+Fus8urHS/0cfXa0RlNjpgwEjR2qQJzNLQ3AoFAKsA34FwFusa4EhQkc0tgtaUozjA9Jag1kWyatIEBCskVYzKuCtIP
X-Gm-Message-State: AOJu0Yxbb6D/SOkxzf6EVilypEYgoGgpGEvHEaVh5WP3Gj1Aq0+Ruv1d
	GIxmJWErVk8zSsyXx4ihJtNQ/gD0+B1XSINm/92K9lh/57OFw/nfw84PCLS/uy8t0IKAaLw6yoC
	fx4dCUsfBpddbKrFLdgN/koIOrEVlYMpQ8EiFl0CSoSzvEVRLTf44C/bbxnXQSwTt8dcXRLy3sc
	V6YkOJ+qxW20qeUfXonw4cn20BEWIG2AnHCi0IPuDY/Krq
X-Received: by 2002:a17:907:7854:b0:a75:25b8:ffc with SMTP id a640c23a62f3a-a77ba7123b6mr362612066b.57.1720230131602;
        Fri, 05 Jul 2024 18:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmye3zDFCxfH2ABGVOnpWkEeJ46xAZ4skOiFrNEtrKcYgmlyPkMNAQ9s/pH4j97WHa+Qnh9GKBHYVavatRWO4=
X-Received: by 2002:a17:907:7854:b0:a75:25b8:ffc with SMTP id
 a640c23a62f3a-a77ba7123b6mr362609966b.57.1720230131096; Fri, 05 Jul 2024
 18:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705025056.12712-1-chengen.du@canonical.com>
 <ZoetDiKtWnPT8VTD@localhost.localdomain> <20240705093525.GA30758@breakpoint.cc>
In-Reply-To: <20240705093525.GA30758@breakpoint.cc>
From: Chengen Du <chengen.du@canonical.com>
Date: Sat, 6 Jul 2024 09:42:00 +0800
Message-ID: <CAPza5qdAzt7ztcA=8sBhLZiiGp2THZF+1yFcbsm3+Ed8pDYSHg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
To: Florian Westphal <fw@strlen.de>
Cc: Michal Kubiak <michal.kubiak@intel.com>, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ozsh@nvidia.com, paulb@nvidia.com, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gerald Yang <gerald.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 5:35=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Michal Kubiak <michal.kubiak@intel.com> wrote:
> > On Fri, Jul 05, 2024 at 10:50:56AM +0800, Chengen Du wrote:
> > The ct may be dropped if a clash has been resolved but is still passed =
to
> > > the tcf_ct_flow_table_process_conn function for further usage. This i=
ssue
> > > can be fixed by retrieving ct from skb again after confirming conntra=
ck.
>
> Right, ct can be stale after confirm.
>
> > > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > > index 2a96d9c1db65..6f41796115e3 100644
> > > --- a/net/sched/act_ct.c
> > > +++ b/net/sched/act_ct.c
> > > @@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buf=
f *skb, const struct tc_action *a,
> > >              */
> > >             if (nf_conntrack_confirm(skb) !=3D NF_ACCEPT)
> > >                     goto drop;
> > > +
> > > +           /* The ct may be dropped if a clash has been resolved,
> > > +            * so it's necessary to retrieve it from skb again to
> > > +            * prevent UAF.
> > > +            */
> > > +           ct =3D nf_ct_get(skb, &ctinfo);
> > > +           if (!ct)
> > > +                   goto drop;
> >
> > After taking a closer look at this change, I have a question: Why do we
> > need to change an action returned by "nf_conntrack_confirm()"
> > (NF_ACCEPT) and actually perform the flow for NF_DROP?
> >
> > From the commit message I understand that you only want to prevent
> > calling "tcf_ct_flow_table_process_conn()". But for such reason we have
> > a bool variable: "skip_add".
> > Shouldn't we just set "skip_add" to true to prevent the UAF?
> > Would the following example code make sense in this case?
> >
> >       ct =3D nf_ct_get(skb, &ctinfo);
> >       if (!ct)
> >               skip_add =3D true;

The fix is followed by the KASAN analysis. The ct is freed while
resolving a clash in the __nf_ct_resolve_clash function, but it is
still accessed in the tcf_ct_flow_table_process_conn function. If I
understand correctly, the original logic still adds the ct to the flow
table after resolving a clash once the skip_add is false. The chance
of encountering a drop case is rare because the skb's ct is already
substituted into the hashes one. However, if we still encounter a NULL
ct, the situation is unusual and might warrant dropping it as a
precaution. I am not an expert in this area and might have some
misunderstandings. Please share your opinions if you have any
concerns.

>
> It depends on what tc wants do to here.
>
> For netfilter, the skb is not dropped and continues passing
> through the stack. Its up to user to decide what to do with it,
> e.g. doing "ct state invalid drop".

