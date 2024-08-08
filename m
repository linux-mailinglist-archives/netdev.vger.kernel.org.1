Return-Path: <netdev+bounces-116952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855A94C2D7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B71C209F9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0418E764;
	Thu,  8 Aug 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFg/JDv9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381112FB0A
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135115; cv=none; b=KpKtsTmqufWQ/GCMq+q+Q+MQlukZlmmSULFtGpLo+w68+fSM/b9jhpwOgWq2uI4x/nkmRq2cDqayzVwmyWY8+fxIDoIMhco/XsIocS9m1FTy/DU0n4vWsff2YUiUq0IF82pf97eJrzQ9b89B4cqLHGWofaeRLqLY2//+pL9zboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135115; c=relaxed/simple;
	bh=s7cS4JXnJNAgCf4cYK2QCGIHNmKpIo1u9uD5noSj9k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iop5RsXo1Q68vXmvpBn8xuZIPWsUqO8KlRZN5tjF0SGTlSR0MuTMAqnH8ehW1OpkyvIbn0V/NcGe5MH8Tmak7+8hYA3WzAL/ixuwFQqua5neFkLaekajbEjP4HPqpboleEnkQpEpSX0kaYQx/kAjBxq91rCo7BU4NIn8VYlMFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFg/JDv9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so1327693a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723135112; x=1723739912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7cS4JXnJNAgCf4cYK2QCGIHNmKpIo1u9uD5noSj9k4=;
        b=FFg/JDv9xhumeh3aoWTk5iygyrMQem85yXcd4RilkYrK4b6TxHNmsvPMJab9qzQy2x
         oEuD2RyrSi82PHjtsT+hHgxh16U2sJcHP2wf2Joa9+c5OUMKgfpZwrBotkvSZe9g+M77
         Q7vAmVUxUdH9b9Gslc7LtzQ/SQQuL9pjG5m/xVWTmg2alNH84saVF9dSYGcvoTvhXlwd
         5jxa6Hg3zIeFEhQz3SOb6So8BAodbfZXlDUuTxh5uegpc89A2OQ+vYXNJxO74Eb0LjBh
         1NLq83tJErK+DVBjvuvEB/eQWbw/SkrIyAGv+zfep9NiWw60UCO0DwBOxzCoWUBSLi4S
         yU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723135112; x=1723739912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7cS4JXnJNAgCf4cYK2QCGIHNmKpIo1u9uD5noSj9k4=;
        b=nm/Vw/z0lv+dkbNKSA3wjmTxeCrKa8b66x/PNYAkX2URh/JkVhzWJmsHfVyzPFcPq+
         lvZzmhunOxrVFJLafh/lOrYeDakNqUC2vUSh8bKm5Jvzi4ipjeVy3Hqtryc8ouDL+nrK
         Q7SZYVaWaLoyJ+GzNHs7bL16OU0QE/YphlNgK/VmsmMb6RzTBhh7OtsCcU5TXBm7MX82
         oTU8KrbPXWzrAi5sJPMo9S2EE2tY2ROW2s0NbaW6gAgaevuTaHKUX/argnR+S3/m1zah
         EnoUdVtT+CmI5vw415TlowRjkzBAuI/1Ny0Y6Fvg2Ll3f6HTwQXf8pjWJ4q7kN44vaHZ
         Oq/A==
X-Gm-Message-State: AOJu0Yz4a5NBvGLCnSF2pz/gd7h4SuIEPX8z5rpNQ18k5Amdk5o3FjdW
	pFjrQeKpsvMVkSfjx7oiZSKFEjhGbwbi7C8uLiJa8Kxec5T062KJXgN9hGVad3D/gmXMpASBznG
	805UjqyzFH/TbGvX29VuolmmQKu0=
X-Google-Smtp-Source: AGHT+IGF9kkbGa5+rGDChvsn5Cotz7sAf1d5EBk9I1ugajTqz+bYB0SkPdDCPV3c9kL+KPrldRGjHAHidehCzHP8EwY=
X-Received: by 2002:a05:6402:4409:b0:5a2:a0d9:c1a2 with SMTP id
 4fb4d7f45d1cf-5bbb233a7d5mr1972443a12.26.1723135111445; Thu, 08 Aug 2024
 09:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808051518.3580248-1-dw@davidwei.uk> <20240808051518.3580248-7-dw@davidwei.uk>
 <CAMArcTX_BDeFQv4OkOk6FLdaoEaS6VQyv6wijUPoQNPCy456zg@mail.gmail.com> <45a6ddd7-886e-4d48-a57c-21d948390d56@davidwei.uk>
In-Reply-To: <45a6ddd7-886e-4d48-a57c-21d948390d56@davidwei.uk>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 9 Aug 2024 01:38:19 +0900
Message-ID: <CAMArcTUTZ=YAtn_v+xB+2nkP2n2oT2nEZ4O4WLVgrMUaAu7XfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] bnxt_en: only set dev->queue_mgmt_ops if
 supported by FW
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:42=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-08-08 08:13, Taehee Yoo wrote:
> > On Thu, Aug 8, 2024 at 2:16=E2=80=AFPM David Wei <dw@davidwei.uk> wrote=
:
> >>
> > Hi David,
> > Thank you so much for this work!
> >
> >> The queue API calls bnxt_hwrm_vnic_update() to stop/start the flow of
> >> packets, which can only properly flush the pipeline if FW indicates
> >> support.
> >>
> >> Add a macro BNXT_SUPPORTS_QUEUE_API that checks for the required flags
> >> and only set queue_mgmt_ops if true.
> >>
> >> Signed-off-by: David Wei <dw@davidwei.uk>
> >> ---
> >> drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
> >> drivers/net/ethernet/broadcom/bnxt/bnxt.h | 3 +++
> >> 2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/e=
thernet/broadcom/bnxt/bnxt.c
> >> index 7762fa3b646a..85d4fa8c73ae 100644
> >> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> @@ -15717,7 +15717,6 @@ static int bnxt_init_one(struct pci_dev *pdev,=
 const struct pci_device_id *ent)
> >> dev->stat_ops =3D &bnxt_stat_ops;
> >> dev->watchdog_timeo =3D BNXT_TX_TIMEOUT;
> >> dev->ethtool_ops =3D &bnxt_ethtool_ops;
> >> - dev->queue_mgmt_ops =3D &bnxt_queue_mgmt_ops;
> >> pci_set_drvdata(pdev, dev);
> >>
> >> rc =3D bnxt_alloc_hwrm_resources(bp);
> >> @@ -15898,6 +15897,8 @@ static int bnxt_init_one(struct pci_dev *pdev,=
 const struct pci_device_id *ent)
> >>
> >> if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
> >> bp->rss_cap |=3D BNXT_RSS_CAP_MULTI_RSS_CTX;
> >> + if (BNXT_SUPPORTS_QUEUE_API(bp))
> >> + dev->queue_mgmt_ops =3D &bnxt_queue_mgmt_ops;
> >>
> >> rc =3D register_netdev(dev);
> >> if (rc)
> >> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/e=
thernet/broadcom/bnxt/bnxt.h
> >> index a2233b2d9329..62e637c5be31 100644
> >> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> >> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> >> @@ -2451,6 +2451,9 @@ struct bnxt {
> >> #define BNXT_SUPPORTS_MULTI_RSS_CTX(bp) \
> >> (BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) && \
> >> ((bp)->rss_cap & BNXT_RSS_CAP_MULTI_RSS_CTX))
> >> +#define BNXT_SUPPORTS_QUEUE_API(bp) \
> >> + (BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) && \
> >> + ((bp)->fw_cap & BNXT_FW_CAP_VNIC_RE_FLUSH))
> >>
> >> u32 hwrm_spec_code;
> >> u16 hwrm_cmd_seq;
> >> --
> >> 2.43.5
> >>
> >>
> >
> > What Broadcom NICs support BNXT_SUPPORTS_QUEUE_API?
> >
> > I have been testing the device memory TCP feature with bnxt_en driver
> > and I'm using BCM57508, BCM57608, and BCM57412 NICs.
> > (BCM57508's firmware is too old, but BCM57608's firmware is the
> > latest, BCM57412 too).
> > Currently, I can't test the device memory TCP feature because my NICs
> > don't support BNXT_SUPPORTS_QUEUE_API.
> > The BCM57608 only supports the BNXT_SUPPORTS_NTUPLE_VNIC, but does not
> > support the BNXT_SUPPORTS_QUEUE_API.
> > The BCM57412 doesn't support both of them.
> > I think at least BCM57508 and BCM57608 should support this because
> > it's the same or newer product line as BCM57504 as far as I know.
> > Am I missing something?
>
> The hardware is correct (Thor+) but there needs to be a new FW update
> from Broadcom that returns VNIC_QCAPS_RESP_FLAGS_RE_FLUSH_CAP when
> queried.

Thanks a lot for the reply :)

I will try to check the new firmware.

Thanks a lot,
Taehee Yoo

>
> CC: Michael Chan <michael.chan@broadcom.com>
>
> >
> > Thanks a lot!
> > Taehee Yoo

