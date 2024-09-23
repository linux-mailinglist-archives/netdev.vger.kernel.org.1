Return-Path: <netdev+bounces-129332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C9C97EE59
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EF01C216A5
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CE5433D6;
	Mon, 23 Sep 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpI9/tRA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788C1E52C
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105996; cv=none; b=HB6oCmmqwQmjC9KMxNvbQPeYkoG++LaJfEPW1V6OoqpmKQr2aDDYan8XOskjCmEJ8HyHuVBDpP8fuUZbcVPWpnXUF1714fgbUzVBQ8IKqYpeSZ3gRt6znaPUyu4ITjZrbnL6yJnWb41yW/gkUmqGozWSZHbV+d5NrDhDnH+uKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105996; c=relaxed/simple;
	bh=wKpbZkRft7AVu54gAugqxTOiGHxcsdbcfmXT2AbcUI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbFhYECgi00lILP3yxe6ik4X1enLEX8/JYUwNnaR2cWnf6H+Y5JeS5kuwdyxnG5SV8qCumqsCsKRspBL0MYi5Z+IGJri6AdN09Jr74JSdpPm3hmvilFRxNuCi38BCCIm5qtHKFewLciFU4UdKAQWnjQMhUBGV/WU3tDTZS9q4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpI9/tRA; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-502b405abb1so1161112e0c.1;
        Mon, 23 Sep 2024 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727105993; x=1727710793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0cHn2kxvtLMH0UDv0GGE+4WDLjMJMQj2YXfFS/thRgM=;
        b=XpI9/tRAIEPC3JuXZv02by8ufO3tE20B7KvurTRD/x/gGGnygl0fIvFroiNpC3mTbU
         wWYC7sXp9jXxuswDKLYjYMALZtzKpm0o/6C08QXwzCDYczR50ADck8IWo7BGMa7Kcm+F
         KYgYtp6LZYUa2LubFU+zQ/Rxa+4ogPcIWYRmyvmBwAsXi4SegK/g4pDWhCdfN+9DMiIR
         41ago1ftF/NPbtrXpJiitokRrsx7f6d6NFw9fNEcl3TGvqdR9Bkn/xIfcrnBjo7pHPid
         aUIWbnMncuLfDp0vO9/S+nWEJGM8T43NqbqMUlNPWkzwzr0nZ6U8VpONSHY2F9xulKvl
         z8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105993; x=1727710793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cHn2kxvtLMH0UDv0GGE+4WDLjMJMQj2YXfFS/thRgM=;
        b=veWe3a7B5uYvblabyzObgVuP5kizaAPRSldKnzJGZJQ1LedoojRNKE/o5KIPS2EH4Q
         InD4fOdaAHYIQU9E3yHybrYjMIEISSFVfdnhhMwbH4LchmAkdby+G+MzWsY4e15Utyel
         dy8XLOPFi1oOmI9Sswh6dhqCA3ue0EMvxzVZnzXU5wH8lE3WGtf/xsuEysuj147S4X6O
         0Srwk/rx7N8K5dbcbJPBmGRHDbavKR4atn/MpJGVHMUjvQ7Inv+oMhFNZecpWqqQv5nn
         J+HiagbhOcE+Saqtvlt+ZGjCPxZZjLU39UNu1NK7lRwNORRMH1imOR1TlY0EgC4LvNNw
         Kr5g==
X-Forwarded-Encrypted: i=1; AJvYcCWeTmEJEzZhycF5kYymFS3yfTJGtE8ptQFh7zVPUNPekiRjBUgYSCxKvHTve8y+aEyKMo0Bbd80CzmJa8SY+g4=@vger.kernel.org, AJvYcCXGP3DJLHu69u2hUuAhdwR7MNvrsfJ2vRq6fMGYZDFblXP0h69LDQfMxms/bb38ZQpF5RqIOMbH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5z2fsFeUvKRB7ohLK68yG5eEVXrruc8aJMEBbtyLuxHAMSKXh
	3d3e7fPKGfYOUClMV1r0MPvROcCte9bY9Hqyj0jzXohEtkP+aPnul5izdq5c5ulhCqcQFIo26fA
	CU+5LzTI6Hsx+GxOxPMBn06RIut0=
X-Google-Smtp-Source: AGHT+IG3kGD0hbXSSAj8Vc4+1ZrIhGPJEe2YJmMs/J6kJ4GbpvTAa0SZeHCCpB5ODKOWupdGftIbY4vMSUobDIQ2mZo=
X-Received: by 2002:a05:6122:180a:b0:503:9cbc:1c9e with SMTP id
 71dfb90a1353d-503e023639cmr7386774e0c.0.1727105993362; Mon, 23 Sep 2024
 08:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110633.3782-1-kdipendra88@gmail.com> <20240923173158.54bb1f46@fedora.home>
In-Reply-To: <20240923173158.54bb1f46@fedora.home>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 21:24:42 +0545
Message-ID: <CAEKBCKMho+hh1GLD=XP1wOjDwy=DiD-SsAng8jCR6uAmPXgL-w@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_common.c
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, cc=linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 23 Sept 2024 at 21:17, Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On Mon, 23 Sep 2024 11:06:32 +0000
> Dipendra Khadka <kdipendra88@gmail.com> wrote:
>
> > Add error pointer check after calling otx2_mbox_get_rsp().
>
> As this is a fix, you need a Fixes: tag.
>
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > index 87d5776e3b88..6e5f1b2e8c52 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > @@ -1838,6 +1838,11 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
> >               rsp = (struct nix_hw_info *)
> >                      otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
> >
> > +             if (IS_ERR(rsp)) {
> > +                     mutex_unlock(&pfvf->mbox.lock);
> > +                     return PTR_ERR(rsp);
> > +             }
>
> You're returning an error code as the max MTU, which will be propagated
> to netdev->max_mtu, that's not correct. There's already an error path in
> this function that you can use.
>

Sure, thanks for the response. I will send a v2 .

> Thanks,
>
> Maxime

Best regards,
Dipendra

