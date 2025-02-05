Return-Path: <netdev+bounces-163137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5EAA2965F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B15416904B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57911F8908;
	Wed,  5 Feb 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvsaUyhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDEE1DDC0D
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772974; cv=none; b=mO1pJl2DuIKeMuGyx3XvAn7T/Skbjoq3/7wBvnChAK51xPlvqS5P7U2DzlbfGxUG1Y/PT0gums3Jyx3C1WN6tbCQETO/cJZ1lZrS8a4OnEhpUoGoG3dJ7WOT8pkLbx7vWbet2hd9EdqtgXq/cncF2WGbieLTJTJ6cz2r9PLO2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772974; c=relaxed/simple;
	bh=81Whz4QdjiEdA7tzatts/lNmM5xEwNvcLid0g3dgLmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpfvBg9xEZrp3hiWokcX3Nm3D9nwVQ7WMi3bN2GbXJ+lrUUo5fpHwINcUnuyJw5YCRvt7AoL2W1nNfIp/S1/wAR4d0hOuyWsF95bW3fM/sEj4evJ4xpGnxtMmQOO8F8RdswvofzI1hNL0QdwyPNxIfz+IkRr/l3YodEnN8laU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvsaUyhK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab6ed8a5a04so1169427466b.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738772971; x=1739377771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS07zK3WtW0i35Mv850vUPe3U+mJCMwq9hR++rRfHbA=;
        b=uvsaUyhKe2L76apW7124UBmgVAn06T8A6o+REAHDgpdjL6omShWqGCKejKTRan6En4
         1E1jYseSHY2XZFdyfYB92BEtuj16Zn3R1KKV0ZPJDww3J37eBdUDh1N2hDjW4jnPP1Kn
         61wzn560nrDdHshS83GVv0X3qxy/N/m/uNQV//QCn/Iz3gAMvhC0lTKcUq9w5YuxuyRI
         Yz62j4eiV8/vaL55QRPgmv7tJLlspCRWh6h3xGzjZh06/0ozWrdH6wBEOvy+EZ+XppOK
         fXEDcd3gaVWZndBDhlCZzCSPDvDzTJPrZ8swF6yu7B5A884KKoGpgqY+aDroQ8jEifY7
         fzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772971; x=1739377771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS07zK3WtW0i35Mv850vUPe3U+mJCMwq9hR++rRfHbA=;
        b=O1H/qEpcNe1Fksk2wGp2OajoiV8Wgk4POrIfY4v8Q/v0MfWiYa245wFhsYkKETs3O4
         OuvdThZHyIJ4Xtb0Vfzd2DZHN3W2M5MNfh7vea971t8VA+VsxccujLreut0yuKjhx85g
         r41gbsg0vcBTWW49raCjxH2Se+VE1TkcTOkBY8xZhkBcbdutmDGIzEjFsCWHACVSURmA
         5DaHucg7hk4uhSpXA3aAGEtC6XhPLC6mQfKotQ0EiNQj4XK49H+0Kym+80qk4eA2t3gy
         7kA8B2eXeOkeejtA0YfheIgSeXI1C4bRY49yVEvVyyiDUeDRK6mbjmNW1w/n0COMo8Xm
         9URg==
X-Forwarded-Encrypted: i=1; AJvYcCX8hEn8R2KuKtpXvBzxriNja1jLe4p6unSwEBf78gxDb9fVgXII69oITFW4wfIx7g6hm8uXNfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrInyHkbAbt0lElzb/7ZNrLb2xsbKdi/divxfD1WvJ2AbxbR+0
	ReEiOB2zuIHexg0e7cKkDlKLWCmNgMZRpYtUW129J1DkWMpUvn4JLMUuIIMG21Zt+P7Bm1oMfKr
	jxsmiqGyjEA5/nts1iYumqtQAHdunIRVCPHSP
X-Gm-Gg: ASbGncusAwCK5DujqAfJww4Vl4ru3zU8TNjef7xVXXOsLpC7ODAONVUqto6qWshg61Z
	Z0bc9rb4/CEdPHDxw45Na1vuOkUh3Tunb2+NLInRFr2KmJeGn96SVSB1VFVPlY/BAoNRtpsxu
X-Google-Smtp-Source: AGHT+IGXFplZGqRdVX2D7MYbEISUf/7dT2WtG1aRsrEYm+bhaDghZFZ1grZG1CUZxigGPlyk6cuZazW0F6fTPhtxivE=
X-Received: by 2002:a17:906:415:b0:ab7:6bb5:9541 with SMTP id
 a640c23a62f3a-ab76bb59782mr83618466b.2.1738772971032; Wed, 05 Feb 2025
 08:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204144825.316785-1-edumazet@google.com> <CAL+tcoDCoSVdV_doreW9mqxxfxfn2oGw3ucNKCDFuLmDzkK=cQ@mail.gmail.com>
 <CANn89i+c_3C5FFv_M+jOPupyMULprP5=GhV97ZW=3za+ToCejw@mail.gmail.com> <CAL+tcoA-fwcq7LRPx7z=42YC_CNsrNMoUznCPf8OkkSdWyiJAA@mail.gmail.com>
In-Reply-To: <CAL+tcoA-fwcq7LRPx7z=42YC_CNsrNMoUznCPf8OkkSdWyiJAA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 17:29:20 +0100
X-Gm-Features: AWEUYZlzrVq9_KRwy0hED4lAR0ptEIMHAMN6LT8_r2rFGzyipr3FhNJzVRXQ_Uo
Message-ID: <CANn89iLOWBqpsj1d+KdDSx_fSBFviPfyEsKX_vXZ9=aH23ESag@mail.gmail.com>
Subject: Re: [PATCH net-next] net: flush_backlog() small changes
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:17=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Feb 6, 2025 at 12:00=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Feb 5, 2025 at 4:22=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > Hi Eric,
> > >
> > > On Tue, Feb 4, 2025 at 10:49=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > Add READ_ONCE() around reads of skb->dev->reg_state, because
> > > > this field can be changed from other threads/cpus.
> > > >
> > > > Instead of calling dev_kfree_skb_irq() and kfree_skb()
> > > > while interrupts are masked and locks held,
> > > > use a temporary list and use __skb_queue_purge_reason()
> > > >
> > > > Use SKB_DROP_REASON_DEV_READY drop reason to better
> > > > describe why these skbs are dropped.
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > ---
> > > >  net/core/dev.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index c0021cbd28fc11e4c4eb6184d98a2505fa674871..cd31e78a7d8a2229e3d=
c17d08bb638f862148823 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -6119,16 +6119,18 @@ EXPORT_SYMBOL(netif_receive_skb_list);
> > > >  static void flush_backlog(struct work_struct *work)
> > > >  {
> > > >         struct sk_buff *skb, *tmp;
> > > > +       struct sk_buff_head list;
> > > >         struct softnet_data *sd;
> > > >
> > > > +       __skb_queue_head_init(&list);
> > > >         local_bh_disable();
> > > >         sd =3D this_cpu_ptr(&softnet_data);
> > > >
> > > >         backlog_lock_irq_disable(sd);
> > > >         skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
> > > > -               if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING=
) {
> > > > +               if (READ_ONCE(skb->dev->reg_state) =3D=3D NETREG_UN=
REGISTERING) {
> > > >                         __skb_unlink(skb, &sd->input_pkt_queue);
> > > > -                       dev_kfree_skb_irq(skb);
> > > > +                       __skb_queue_tail(&list, skb);
> > >
> > > I wonder why we cannot simply replace the above function with
> > > 'dev_kfree_skb_irq_reason(skb, SKB_DROP_REASON_DEV_READY);'?
> >
> > Because this horribly expensive thing pushes packets to another perc-cp=
u list,
> > and raises a softirq to perform the freeing later from BH.
>
> Agreed about this case. How about changing kfree_skb_reason(skb, ...)?
>
> >
> >
> > >
> > > >                         rps_input_queue_head_incr(sd);
> > > >                 }
> > > >         }
> > > > @@ -6136,14 +6138,16 @@ static void flush_backlog(struct work_struc=
t *work)
> > > >
> > > >         local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
> > > >         skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
> > > > -               if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING=
) {
> > > > +               if (READ_ONCE(skb->dev->reg_state) =3D=3D NETREG_UN=
REGISTERING) {
> > > >                         __skb_unlink(skb, &sd->process_queue);
> > > > -                       kfree_skb(skb);
> > > > +                       __skb_queue_tail(&list, skb);
> > >
> > > Same here.
> >
> > Please read the changelog, I think you missed the point.
>
> I meant why not directly use kfree_skb_reason(skb, ...) here? It's
> simpler, right? Then don't bother to use a temporary list.

Because we are blocking BH here, for a potential long time.

This was mentioned in the changelog. Please read it again.

