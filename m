Return-Path: <netdev+bounces-98856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D958D2B56
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 05:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36345288102
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35359433B1;
	Wed, 29 May 2024 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="t+Dv74Qj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49291391
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952690; cv=none; b=J3f8GIaRa0myHDjoSRzN3crkB5BGupxZIxfdRnhMvvBqErnIoEuJ9frCoMlRVsBULSkRDT83nk15BnDvqeVF6WevWGWqPe1OpYbvExSJcbFsaPO7Pp4UKqoCH/ycd9DRp7TfBhg4fE7xdSjPyBSq0roUTzFnH+vC3jJCnECUcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952690; c=relaxed/simple;
	bh=jbfmJS2BdmG5oxbEaUOnRzLbKYW8OnaBkBN1o+oKM5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TC2iG3O3TuCtiMogqWwNyZ0CGLZrUVOIpLb3CWjVXML6IjFit/Tj0TM9F2+87UKKe5yDNySSPjFHkTUVyJR4L5980Cq4Sacgnu0FwOsW/ge5EUppw40ZoQXGJb3GfVp7nDzPUDpbDkE+feXz2QuiK5UCNKuLJ/v2x7J0QEOZESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=t+Dv74Qj; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B7C733FE64
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 03:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716952681;
	bh=wzuecrJ0JFchccEBCmxLIDXRwMQkEzpCJKJ1c3kKpP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=t+Dv74QjPBGB3y6rduoyaeebj2bggcd/YFdZKtrr0hf84X9Ch0PPOOr2BqRtOiDF2
	 cmClN8xl4kB0eG9SYieYppNrcMvi0scG0zGBt2dJFPyeurgtYRlgbYjXuk1xI97U9O
	 sjWdqaXYlJgkKFLaeuZSbeFinYCx3nxdmDSyIO/Bi9ljK5EcYE6yhJL/SOTugrPX/x
	 we0iB4h/b6sY+nGpZV3sVvseCz4P5HKZBkPkMh0lCV6Wt7eKWV+XL9OffDKOX+3LPk
	 L2SI94OmH/0SRbl/WVH/a7np68r7p1uajOmg84oWySpwnnfnwbXpmuD+CMzhAwFg+z
	 FLTaniWLfq1jw==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35507f6304eso648544f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716952681; x=1717557481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzuecrJ0JFchccEBCmxLIDXRwMQkEzpCJKJ1c3kKpP4=;
        b=YgwY0+RuUTw5hRMGMy0ad9SoZmIz5VcJXKO1cUAyuioLnHKWxpxyRTKG5evr8EstaP
         04hd+PjGHpxBdZvgIMgd3nlQWQp+3wnQbzGMx0n2pfR0TQ9EQw/9Uy9Qtew/uuBO5Ben
         vCYUJ2x/BTkvoeuSfYPx1r9ScneXeuLAJEXN08jBAR3F8S8Ck8m+SqFofdRnmXMOlqcs
         0OloefYao3NHRQwDzpd4lWqNfJyMoi9OhdatlOVd5loKAvCY5pXuCnoy+kXlchEoVVGn
         FcoTZbYJKOBUd6hzgX1ggksOtodk0QDLUXzu7kKKhqZtpkTnJWSDL1xtrSrbs0NdNx6C
         hewg==
X-Forwarded-Encrypted: i=1; AJvYcCWgakA5IHwTBq0ANWVju6M1PEz6zPNSr+7pQGyEns7HmR3HkzwBg4Kl0xl+QkwLYoEJr/aGfNbJaBuYlz4CmbnC/sn6GCfY
X-Gm-Message-State: AOJu0YwIC8bP6xOEH4tQJRydc4+TesAe4jFtxLevyvB8O1fzDhNsQg2F
	TJYhlK0oAJbzs460CjnNzvyVP8IIHkloYRt0lK5+CtspfcaVLbgmbp3BIX7WKWR2JnH3Ibg8ZQl
	tqBdvukfyeO2FYKB1/JRSGR493824dWTDYHMGArfJMhlyTuM+u34yALpqSpz83dW3oad385UP1j
	nD0D4/C6oJ5cR5/s8v5kQxUx+9V2/7MmuqU5fRWoThlzV/
X-Received: by 2002:adf:fa44:0:b0:354:fa0d:1427 with SMTP id ffacd0b85a97d-35526c25695mr13910659f8f.15.1716952681274;
        Tue, 28 May 2024 20:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpCJ+0J4feg5DWmCamoCmdHKV9NdQcsZdg5GrTQwmVV6HKgfUo06EW5RnIGllF7jaxWmj3OWvP61y/5+LdyDY=
X-Received: by 2002:adf:fa44:0:b0:354:fa0d:1427 with SMTP id
 ffacd0b85a97d-35526c25695mr13910642f8f.15.1716952680890; Tue, 28 May 2024
 20:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528100315.24290-1-en-wei.wu@canonical.com> <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de>
In-Reply-To: <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Wed, 29 May 2024 11:17:50 +0800
Message-ID: <CAMqyJG0uUgjN90BqjXSfgq7HD3ACdLwOM8P2B+wjiP1Zn1gjAQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ice: irdma hardware init failed after suspend/resume
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org, 
	rickywu0421@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com, 
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your kind and quick reply.

> I think this should be called later in the reset path IMO.
> You should call ice_deinit_rdma in ice_prepare_for_reset (replace ice_unp=
lug_aux_dev),
I'm afraid this would break the existing code because in
ice_deinit_rdma(), it will remove some entries in
pf->irq_tracker.entries. And in ice_reinit_interrupt_scheme() (which
is called before ice_prepare_for_reset), some entries have been
allocated for other irq usage.

> What effect does this have on resume time?
When we call ice_init_rdma() at resume time, it will allocate entries
at pf->irq_tracker.entries and update pf->msix_entries for later use
(request_irq) by irdma.

On Tue, 28 May 2024 at 19:12, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Ricky,
>
>
> Thank you for your patch. Some minor nits. It=E2=80=99d be great if you m=
ade the
> summary about the action and not an issue description. Maybe:
>
> Avoid IRQ collision to fix init failure on ACPI S3 resume
>
> Am 28.05.24 um 12:03 schrieb Ricky Wu:
> > A bug in https://bugzilla.kernel.org/show_bug.cgi?id=3D218906 describes
> > that irdma would break and report hardware initialization failed after
> > suspend/resume with Intel E810 NIC (tested on 6.9.0-rc5).
> >
> > The problem is caused due to the collision between the irq numbers
> > requested in irdma and the irq numbers requested in other drivers
> > after suspend/resume.
> >
> > The irq numbers used by irdma are derived from ice's ice_pf->msix_entri=
es
> > which stores mappings between MSI-X index and Linux interrupt number.
> > It's supposed to be cleaned up when suspend and rebuilt in resume but
> > it's not, causing irdma using the old irq numbers stored in the old
> > ice_pf->msix_entries to request_irq() when resume. And eventually
> > collide with other drivers.
> >
> > This patch fixes this problem. On suspend, we call ice_deinit_rdma() to
> > clean up the ice_pf->msix_entries (and free the MSI-X vectors used by
> > irdma if we've dynamically allocated them). On Resume, we call
>
> resume
>
> > ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
> > MSI-X vectors if we would like to dynamically allocate them).
> >
> > Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
>
> Please add a Link: tag.
>
> If this was tested by somebody else, please also add a Tested-by: line.
>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/et=
hernet/intel/ice/ice_main.c
> > index f60c022f7960..ec3cbadaa162 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5544,7 +5544,7 @@ static int ice_suspend(struct device *dev)
> >        */
> >       disabled =3D ice_service_task_stop(pf);
> >
> > -     ice_unplug_aux_dev(pf);
> > +     ice_deinit_rdma(pf);
> >
> >       /* Already suspended?, then there is nothing to do */
> >       if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
> > @@ -5624,6 +5624,10 @@ static int ice_resume(struct device *dev)
> >       if (ret)
> >               dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret=
);
> >
> > +     ret =3D ice_init_rdma(pf);
> > +     if (ret)
> > +             dev_err(dev, "Reinitialize RDMA during resume failed: %d\=
n", ret);
> > +
> >       clear_bit(ICE_DOWN, pf->state);
> >       /* Now perform PF reset and rebuild */
> >       reset_type =3D ICE_RESET_PFR;
>
> What effect does this have on resume time?
>
>
> Kind regards,
>
> Paul

