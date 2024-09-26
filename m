Return-Path: <netdev+bounces-129882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD56986C0D
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 07:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449192848F5
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 05:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9D72D600;
	Thu, 26 Sep 2024 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3IeSWHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38FBE6C;
	Thu, 26 Sep 2024 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727328668; cv=none; b=u62UIuvrdv0Eo9XRmGws3DyvjcBKP0jba4a91xiU9Ai1jueBQAY0IBCli+pOdeElybmkWtOe74DTZA0tDLIZQMrFtAahtbJh0DeYnfdWL/4T7jYZB6y7om+rBKn0GVfAF1CVH4Pcc3btlSz5IL68YMxjuZTy6Ap8l1HWWxrgG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727328668; c=relaxed/simple;
	bh=g+pxbbSKoeqeHK0uLZ4eJ+fdzHV5KPFjyS09Hxhu9sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs4oQKRN6mpU8Fj+Bnjk03/22kRfi67zIO5WRcHIRYgBybfCYZ46zhGlMsPHZ7BS2egS2E72Eg5Xb7QYBzhu4pTSXJqQMLrnEitJP5oG8XvAvtO1suhlHHbtQnSkqbPBo0ZVlqAXDFaNMYCCh7P4ZS7s1Ll26PkyFdxAvNQj5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3IeSWHs; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84ea1e5e964so152643241.0;
        Wed, 25 Sep 2024 22:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727328665; x=1727933465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+z2xtOdQq+QmiK5LU+Fqb/lGf1zKXnWuQ8AIy/I1c+Q=;
        b=K3IeSWHsczGM19kjIbQvblhXIkd65MgD/NUxodnE7dR6gT3H92kxINI9j1V3mPZqEU
         yTUIEAqT31fScRTMFfgipCydPzEDMYr8VMuiZ3hNmL6q5HS/GQ8PwmMZN3Pe9QZXp8vy
         P0owrKrDZTOdvZKFMGOHgZm0Gxf/tlQC9chbFo1oNqOEBAKEpfkw2OGeHV4dNKcmYAns
         IlIkx2s+5KTgHn9Ioda8W0Iu1Ce7bGCkBgifroZ9Rsz+lGrEMh7gLhHyFlXq1P5epsoD
         3prYeZSf1DaY+k9RiITnFfCNHslBBS4NLAxsfOv09iHawTvHdIvHGuEyET1KMJIFw9mN
         TWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727328665; x=1727933465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+z2xtOdQq+QmiK5LU+Fqb/lGf1zKXnWuQ8AIy/I1c+Q=;
        b=rwuFpaCGoVFBeUwggzJVHqbIN6tF1bbBq3lnh9O9OKCU6iEEOwvH2iixW2Y4072oAs
         +lXwEQgRiw1GXaVlbv2bw2Ta1xWrczlr/gE9xEU2e/Gx4rHd5qJA0lzWF4Ox/1gTmeYS
         Fe2STG2gDIJMNodSbuyDWkm5wTx9/lJWPIX5FSSVI+/faD43ETqECU6ZExrs+oh6+ECO
         n9jVh9sXeHmrfyJGVvFW062kX655gYgLhDAtIWiNHFw97w3O9QonW5lyxD7PvwOawKZA
         09IgWTWN17YQP4ywjaPuI77OOGU/DBVPoGlQCMaVKrhfafLq8Yt7I66TOIFE3clZxNt0
         B1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVycOPyaSr4U70b4SqTspxBgkWh7FkkOr24AD2sHVS73Xg+9tCcqkk03Ol8z+9chq8sHsomARcd3pRengY=@vger.kernel.org, AJvYcCXlLhXtxP+h+/vOQUoZd3ZKidviEojdslweHze8NqCPo1YAqGwvImtWG2Cd7CWXOAt+ysCBol6E@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXr9Ojh2tRsCxx82PG1fkonjtJKG/XIHvwNAeWhdFDRBcsTbV
	kJQZUl9Te+P6J2jvjgqq0iXxNBF3h6bCb5BuSwX4S+u8z1H1LrQJQoKIAy08w/wc6qbPpfZHRvy
	QtJRP6I3BSh6Hj2FEYjufjBMQMiE=
X-Google-Smtp-Source: AGHT+IHrDT73sQ0QXFC8MwPNgI4Wy+AofMtGmgQFH/Y9CYSte5TPYdh6URd6OPaZyurPIk9z7jKjbYev4Ury6R0jDZE=
X-Received: by 2002:a05:6122:3193:b0:503:d876:5e0a with SMTP id
 71dfb90a1353d-5073bf2c77fmr1906010e0c.0.1727328664737; Wed, 25 Sep 2024
 22:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922185235.50413-1-kdipendra88@gmail.com> <20240923155606.GJ3426578@kernel.org>
 <CAEKBCKOYi6TuDdDf0GV+aKtiKSgjckEFhdpsywk175MqMgz7ww@mail.gmail.com>
In-Reply-To: <CAEKBCKOYi6TuDdDf0GV+aKtiKSgjckEFhdpsywk175MqMgz7ww@mail.gmail.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Thu, 26 Sep 2024 11:15:53 +0545
Message-ID: <CAEKBCKOY-nZhXCKOg3mnwj5=LbO0XbqcaATMt8p5bWEuhMUKGQ@mail.gmail.com>
Subject: Re: [PATCH] Staging: net: nic: Add error pointer check in otx2_flows.c
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Mon, 23 Sept 2024 at 21:48, Dipendra Khadka <kdipendra88@gmail.com> wrote:
>
> Hi,
>
> Thank you for the response.I had already sent the v2 patch. I will
> send v3 addressing all the issues.
>
> On Mon, 23 Sept 2024 at 21:41, Simon Horman <horms@kernel.org> wrote:
> >
> > On Sun, Sep 22, 2024 at 06:52:35PM +0000, Dipendra Khadka wrote:
> > > Smatch reported following:
> > > '''
> > > drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:123 otx2_alloc_mcam_entries() error: 'rsp' dereferencing possible ERR_PTR()
> > > drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:201 otx2_mcam_entry_init() error: 'rsp' dereferencing possible ERR_PTR()
> > > drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:236 otx2_mcam_entry_init() error: 'frsp' dereferencing possible ERR_PTR()
> > > '''
> > >
> > > Adding error pointer check after calling otx2_mbox_get_rsp.
> > >
> > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> >
> > Hi Dipendra,
> >
> > As noted by Andrew Lunn in relation to another patch [1],
> > this driver isn't in Staging so the subject is not correct.
> > And moreover, as Andrew suggested, please take a look at [2].
> >
> > [1] https://lore.kernel.org/all/13fbb6c3-661f-477a-b33b-99303cd11622@lunn.ch/
> > [2] https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> >
>
> > > ---
> > >  .../ethernet/marvell/octeontx2/nic/otx2_flows.c   | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > > index 98c31a16c70b..4b61236c7c41 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > > @@ -120,6 +120,11 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
> > >               rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
> > >                       (&pfvf->mbox.mbox, 0, &req->hdr);
> >
> > nit: No blank line here please.
> >      Similarly in the other hunks of this patch.
> >
> > >
> > > +             if (IS_ERR(rsp)) {
> > > +                     mutex_unlock(&bfvf->mbox.lock);
> >
> > This doesn't compile as bfvf doesn't exit in this context.
> >
> > > +                     return PTR_ERR(rsp);
> >
> > Looking at error handling elsewhere in the same loop, perhaps this
> > is appropriate instead of returning.
> >
> >                         goto exit;

Is this ok to follow?

if (IS_ERR(rsp)) {
                        allocated = PTR_ERR(rsp);
                        goto exit;
                }

> >
> > > +             }
> > > +
> > >               for (ent = 0; ent < rsp->count; ent++)
> > >                       flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
> > >
> >
> > ...
>
> Best Regards,
> Dipendra

Best regards,
Dipendra Khadka

