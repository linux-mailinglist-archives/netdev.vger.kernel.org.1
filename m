Return-Path: <netdev+bounces-129588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B020984A83
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B708B20F69
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338921ABEC6;
	Tue, 24 Sep 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/JBRZer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E12941B;
	Tue, 24 Sep 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200692; cv=none; b=guVUw/zQ3XT/dcdMQA+6ZC4CQkd9LqvzOo1ee8/XEX5rSBjy7mWDE05zrwxokC26fCmub11YqVt+VczbI7vd63q8fx1P5MH9tOmaO4wwz+l2a5AGlXcbp6SJwWYC5pynRtUPRQleJwSIQAryVyBQ31wtRnIVknUAv9kmv7t8eno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200692; c=relaxed/simple;
	bh=5qoAn6EfJFUQhsx4AB+LfGTHNmgBhfUi3D7JY5kPiYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeeBb0qmiOEuIa68NE6Q25XUIYQStU/k/UnchMfDqyb0lCe/xIzGgmKbmMhjxNSAAOR/vjSOmB85afW+rVIF7Iz8qCuqWj4CzynvWN65yWwLwHPV6cIsN6twEYR7PQID0U2LaWI/Xum7Y3oBMLwiQniXexdP+IilOkRWSkxnKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/JBRZer; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-503f946d65fso1156369e0c.2;
        Tue, 24 Sep 2024 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727200689; x=1727805489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FtOisPFrz8MMfOlJEmHPyj/gSIdJaZPCZi0Wwdfvah0=;
        b=S/JBRZerLjFEW3H6Jx+aHCpd4CjmTqSJHrhnliPEqIVISS84zLLPJmQFsXOaM37oG/
         rGuMsGIhZSznuvao5onDFy3CyQSB6X5Vam3G4o4jNO0Lz5q8s2YkgySB60VIJ4VoWRvn
         Rb9dtuHSS/BtVvhDuEsJjhNnZX8MF9i5Irtlbg/hFl9ghPGGnEnJCF+rlg5+J5k4NYTG
         cxXUB9whzN23GVIrN2US5H0NjfH80Hx8gS7k2PqJKUATtnAWaXTMPDr1+GlSPBJSxAvq
         jSqK3mwBODijUHKePeg8oPS3ZLGhsOzDGCJDq/29swpihQQgppp17GiH/AvcC0qQs2Uu
         MMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727200689; x=1727805489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtOisPFrz8MMfOlJEmHPyj/gSIdJaZPCZi0Wwdfvah0=;
        b=C9m2WmtYfVMcQcoEm2amhmNrmFuhPWpLE5eQ1tSaNQ/Vz8EIyMJXWX8UnfULf19jZG
         cv3xEEEsQAYBHX78vP4OHGKxHf/TeRuWzxv51QTqCrrTGmz6jnchrt2YAQpzFdZW1pcX
         3t2CnELlMDxHYATtx2FaiOOEr21Ad47jctjPNNHd00FO85qLVzFuRgxAzb28ZjvduUly
         +t7e4ibkXMm1xn9hFOkw9LUKv8Kv4ZDaddfgz99TnuKaaTyKYpZ8gQrw7CcLvmh3JX1B
         l1cOCRlnpRNk0T5RYXMfPbJNvKUtUgOzmZmMDi4UyX/5G3W9wEH31t6uXLm8jt2/nI4L
         PdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOp0Tg7nP2eh6Uj+GFiE9m6+dsGJF/Ijyxxz5pQPG0fqLINp8e27vNtjZBvEmSNWPo0yzaDuBj@vger.kernel.org, AJvYcCXT7qoElIw9T5495FWjhcgXYdsh8wUIZZH+6D69W7Ooe9TCjRTO3XKQAEsOqiwmPopNZK0naZaNm7aZM6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjQTiheY8uzPFH0YQdFH4M/DaYI1Nv4ipCwl/naQN3+C0HfIRL
	lRJjYnzqTpb4EhGmk9BrvPcPVY4aoKv9KgQrxOXD7O2nbFJn+lVnNbwPIlhBYdqeKGOIS9HOKId
	1KjZcfke/cIBKv5wCC8CdTj9GM6k=
X-Google-Smtp-Source: AGHT+IHTkZU201Le5J6WJGmsaV/AnRUFdExdQ5YWxRBcW7uyOlLkprgUHHCmAs2qAuOVDPD8lY+75pyaYgLeE6pU3OU=
X-Received: by 2002:a05:6122:50b:b0:503:d875:6a26 with SMTP id
 71dfb90a1353d-505c1d82ce3mr385826e0c.5.1727200689247; Tue, 24 Sep 2024
 10:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923113135.4366-1-kdipendra88@gmail.com> <20240924071026.GB4029621@kernel.org>
 <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com> <20240924155812.GR4029621@kernel.org>
In-Reply-To: <20240924155812.GR4029621@kernel.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Tue, 24 Sep 2024 23:42:58 +0545
Message-ID: <CAEKBCKO45g4kLm-YPZHpbcS5AMUaqo6JHoDxo8QobaP_kxQn=w@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Tue, 24 Sept 2024 at 21:43, Simon Horman <horms@kernel.org> wrote:
>
> On Tue, Sep 24, 2024 at 08:39:47PM +0545, Dipendra Khadka wrote:
> > Hi Simon,
> >
> > On Tue, 24 Sept 2024 at 12:55, Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Mon, Sep 23, 2024 at 11:31:34AM +0000, Dipendra Khadka wrote:
> > > > Add error pointer check after calling otx2_mbox_get_rsp().
> > > >
> > >
> > > Hi Dipendra,
> > >
> > > Please add a fixes tag here (no blank line between it and your
> > > Signed-off-by line).
> > > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > >
> > > As you have posted more than one patch for this driver, with very similar,
> > > not overly complex or verbose changes, it might make sense to combine them
> > > into a single patch. Or, if not, to bundle them up into a patch-set with a
> > > cover letter.
> > >
> > > Regarding the patch subject, looking at git history, I think
> > > an appropriate prefix would be 'octeontx2-pf:'. I would go for
> > > something like this:
> > >
> > >   Subject: [PATCH net v2] octeontx2-pf: handle otx2_mbox_get_rsp errors
> > >
> >
> > If I bundle all the patches for the
> > drivers/net/ethernet/marvell/octeontx2/ , will this subject without v2
> > work? Or do I need to change anything? I don't know how to send the
> > patch-set with the cover letter.
>
> Given that one of the patches is already at v2, probably v3 is best.
>
> If you use b4, it should send a cover letter if the series has more than 1
> patch.  You can use various options to b4 prep to set the prefix
> (net-next), version, and edit the cover (letter).  And you can use various
> options to b4 send, such as -d, to test your submission before sending it
> to the netdev ML.
>

I did not get this -d and testing? testing in net-next and sending to net?

> Alternatively the following command will output 3 files: a cover letter and
> a file for each of two patches, with v3 and net-next in the subject of each
> file. You can edit these files and send them using git send-email.
>
> git format-patch --cover-letter -2 -v3 --subject-prefix="PATCH net-next"
>

Should I send it to net-next or net?

Thank you so much for teaching me all these.

> >
> > > As for the code changes themselves, module the nits below, I agree the
> > > error handling is consistent with that elsewhere in the same functions, and
> > > is correct.
> > >
> > > > ---
> > > >  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > > > index 0db62eb0dab3..36a08303752f 100644
> > > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > > > @@ -343,6 +343,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
> > > >       if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
> > > >               rsp = (struct cgx_pause_frm_cfg *)
> > > >                      otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
> > > > +
> > >
> > > nit: No blank line here.
> > >
> > > > +             if (IS_ERR(rsp)) {
> > > > +                     mutex_unlock(&pfvf->mbox.lock);
> > > > +                     return;
> > > > +             }
> > > > +
> >
> > If the above blank line after the check is ok or do I have to remove
> > this as well?
>
> Please leave the blank line after the check (here).
>
> >
> > > >               pause->rx_pause = rsp->rx_pause;
> > > >               pause->tx_pause = rsp->tx_pause;
> > > >       }

Best regards,
Dipendra Khadka

