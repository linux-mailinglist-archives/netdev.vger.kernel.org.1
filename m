Return-Path: <netdev+bounces-93077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ED68B9F17
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BE5B21C3B
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D0516F90F;
	Thu,  2 May 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhZoXX6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178CA16D327
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669135; cv=none; b=XUzqkhXNa83718WggELGyy+E6dNhwxlu6qjBhpyMIrzhpcnKPfKRCSfdmRNs+YGiZpnn4cwn/Qy8vSRMKKiwSf7Eii/WRI7r8PMgMHgc07xO9CbDFJzdNCnhyKjlfGVGyQnPs3KMxEABijQwo/scobOTDeErrer7begvcFdhpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669135; c=relaxed/simple;
	bh=ie1KPSOz4FrYOwrrKo7ciPrcoe7jbZBI83i3BRSUY28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDkEu/m2yLOaeLIhgLkbuIkxH6b6ZnXkC34zHiQ0IlKno9h+5IPDcZLVp5oz4f7GezfJRhjghLT4Btfy0LkWEGTAWNDVEoA3ye8PtI0+LMia0/0rLtua5INmwo8UWPdWHo/3KLWpyN8aisQjrOgfWbvSEJvYMIUW45GqYb0iXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhZoXX6/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso367694966b.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714669132; x=1715273932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INqzaWaUz55i16qaUTBnal/q/AGeXCeOSHiT7C6b5pA=;
        b=yhZoXX6/NGXYijx3yWQLflQ6nyvd0OjUwthdK/9NnUTjYvHTyKPDrj3fiZFtVIPmxc
         LTWkrtblm/N5oxQlFFh86ew51lMU5VzcbrwSVDWHIm6Y1giml5l5dZd4I3MAnyd6Ln00
         uqF+nCctPpArHBHJTdxNPh37usrKDPppNUpMxKjDuqIOqCP6Hm4eOAKbcaFaGkLsPqqj
         B+lsSAuClINX7SnU2mmmQDyTcQincxT2Flf+zkizKNVfdoRy0SJ4dNOM23dTu/qkcXIq
         nl7dZ/07oTYBZL+0yenYqj+yS6cflFVi33MXbZ05DM3B3QZJhxWZKatoNkaKndmhYiTe
         qqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714669132; x=1715273932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INqzaWaUz55i16qaUTBnal/q/AGeXCeOSHiT7C6b5pA=;
        b=sFwxPE+QIOSd1SuoELG1NUA+mji/QRdp/tNynsw43U61Ey8GH1AbZrtE3jwDLJvymw
         4ii/25/AfcgRbw5MJVbx1E5MGsA+ebDJwWuPdalXfGIgJxFz4m346S2XsvMEbvz2xwpx
         Dj94xIAsOKib+331SGeqE9GdsJAErHRtg2qXW5MGmTh4+vlp4qZlpiwpqY+iUo0gb0U9
         gp5wAs2Nz/VP+1grcWat7LCzBsPjgfGLGzidb7z4hV11jigHXjPXSqd5jSAMIBcaZn63
         XMSc3R3XPj4XGUpyTewnqk+YjZvxQHuYowh0swgJ/iD69Va6OBzXsYGHBxYEHkeW0XVx
         fjGA==
X-Gm-Message-State: AOJu0Yw6h3I/OCfHDipB7j2VQc32ppXdL4zzbA3Ol+Z5cSxwT/TCSzKL
	75Pj8wSkOL63mCfh6CvVWGXuHxkGCeqZa1JP3Mq1YgLvFobycZBwdauzUchFWuOiwJrKZq1V8JL
	5cEX5OaP+HOKpT1J5gGU0+LE57BBNwyqRTj4/
X-Google-Smtp-Source: AGHT+IF0JAymuzlHhqw7f3h76M7jfcUvC4KNDoLdYbLMpSEE50zN5SwVQOWQa/sNV/1tj5GgWGP8HqhX8Bi0c43/mC4=
X-Received: by 2002:a17:906:1398:b0:a55:ab13:5471 with SMTP id
 f24-20020a170906139800b00a55ab135471mr294222ejc.13.1714669132071; Thu, 02 May
 2024 09:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430010732.666512-1-dw@davidwei.uk> <20240430010732.666512-2-dw@davidwei.uk>
 <CAHS8izOsZ+nWBRNGgWvT46GsX6BC+bWPkpQgRCb8WY-Bi26SZA@mail.gmail.com> <80adf4dc-6bfd-4bef-a11b-c2f9ef362a2d@davidwei.uk>
In-Reply-To: <80adf4dc-6bfd-4bef-a11b-c2f9ef362a2d@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 2 May 2024 09:58:40 -0700
Message-ID: <CAHS8izP8M2GtAuCNb-8uzwbdxgLs8VRy=p2-1KNXa_4mqf-PmQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 1/3] queue_api: define queue api
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Shailend Chand <shailend@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 6:00=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-04-30 11:00 am, Mina Almasry wrote:
> >
> > Sorry, I think we raced a bit, we updated our interface definition
> > based on your/Jakub's feedback to expose the size of the struct for
> > core to allocate, so it looks like this for us now:
> >
> > +struct netdev_queue_mgmt_ops {
> > +       size_t                  ndo_queue_mem_size;
> > +       int                     (*ndo_queue_mem_alloc)(struct net_devic=
e *dev,
> > +                                                      void *per_queue_=
mem,
> > +                                                      int idx);
> > +       void                    (*ndo_queue_mem_free)(struct net_device=
 *dev,
> > +                                                     void *per_queue_m=
em);
> > +       int                     (*ndo_queue_start)(struct net_device *d=
ev,
> > +                                                  void *per_queue_mem,
> > +                                                  int idx);
> > +       int                     (*ndo_queue_stop)(struct net_device *de=
v,
> > +                                                 void *per_queue_mem,
> > +                                                 int idx);
> > +};
> > +
> >
> > The idea is that ndo_queue_mem_size is the size of the memory
> > per_queue_mem points to.
>
> Thanks, I'll update this.
>
> No race, I'm just working on the bnxt side at the same time because I
> need feedback from Broadcom. Hope you don't mind whichever one merges
> first. Full credit is given to you on the queue API + netdev queue reset
> function.
>

Thanks! No concerns from me on what gets merged first. By 'raced' I
just meant that we were incorporating your feedback while you were
working on the older version :D

--=20
Thanks,
Mina

