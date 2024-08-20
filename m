Return-Path: <netdev+bounces-120375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B729590F7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0717A1F23256
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45630189BB6;
	Tue, 20 Aug 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CLUzd94D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AE14AD2B
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195797; cv=none; b=a8eNUqYRum5QERLx1tRz4t1XBmC4Ms9rvWMt17TBEcZt09LCEbye+Oyx/LOxpSvtCDuKm5eLc0IPELLe451+zS4Y2sJdmiYho45t3tC9M5vWHaRbFOdKbSF9U8AOg7OPFE9nSfSIID2Ia7Ka8R7EnwK21Sk7Q4gVay7kPO2bw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195797; c=relaxed/simple;
	bh=WZfzdv19Ccv9KUaSF46EvtvrvJ5XeavHq/pzmaJLqWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJDas+6MroN/CS/rlrbSKHmN/hwzDyQTlMX+s16aruaikJtUBTUmCc4B2hjrXEjAFUvJXYTfanOrWpyeMDk+XAus36b7wxMLhWy1e/gAyjsNaKsxocKawzkEzzyGoDFKhr2j7CQgLPAYrXaHXbKoXkeTaDQakOOTgyciddKdbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CLUzd94D; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso147499a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724195795; x=1724800595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrZS09AovuuFmgGLEUEH4wrKa3bvYx4Fu0tek9TXx4s=;
        b=CLUzd94DSk91+TackRw6sGuHQ0w3EC7Dl9qbyBhnroD06JX+2lDUy4TLqOS3G3KISV
         TdRqYEg1priiD74dZ83XlFmpsqE8PhbjVSX50NE6cIGnTdnr9jEPa99JvLmT9ARW6lk3
         gOAoMTKS6dG9BoWoSHk0FSu3/mAIqA2CmW/qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724195795; x=1724800595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrZS09AovuuFmgGLEUEH4wrKa3bvYx4Fu0tek9TXx4s=;
        b=rTI5EEhqceze7Ozhhhoo925mFO6Rtuc5p2Yhxwfbn784yrgV23cpA4/XsxOoEeci4t
         DTctANsVsgMeDnuK5dR8uc29KOIejLCryvSkCMdcVzYkhaaTBz/8gZ2DEc5Q3HN0T7Jq
         +dcPwhicgroBCMTgax2SlugqcQNUhI5mm5dcBmJDDu11TwkudkY4ACW6gxPKlxFXg6x8
         k06pCVn6NCXCEOHutEscz2JS9hF5lwPrd7DQ9jHiLg87zcIPWB306JVoXwMgiUkl/IoV
         tDonwInImaS1OwgyV5yqd/z63HPMpMgDt0kuajixnSaAYr847mDsudvFg6p74kQ0r/fz
         CxHg==
X-Gm-Message-State: AOJu0YyHdkk3QkbLQeErFX06GCe7/pxtbKQ3w6+g37VC+X418lWL/mik
	eBuSB+0I/ZggXf1nRYp9gAhfuJJ2YLodOvt2V+PQVssU/l/Y/r36qt5tvk0zbJAsKGf8j/pWEQA
	mE06MIGLukg80Z3nartow5j+4OeUNW3BQrXMP
X-Google-Smtp-Source: AGHT+IEI+l6X7IR9T6pwKkJ8QZSEtEMczJRLjGREA1pdtgbdvp3Hq8ZiAk6iRl1Auq3JsoyP4nTpyh2MJh7WV6WdkT4=
X-Received: by 2002:a17:90b:1953:b0:2d4:91c:8882 with SMTP id
 98e67ed59e1d1-2d5e99a5c36mr770336a91.11.1724195794885; Tue, 20 Aug 2024
 16:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-5-jitendra.vegiraju@broadcom.com> <20240816112741.33a3405f@kernel.org>
In-Reply-To: <20240816112741.33a3405f@kernel.org>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Tue, 20 Aug 2024 16:16:22 -0700
Message-ID: <CAMdnO-LT8gChytPpw0HWqkJvL-=OWqHOY9UUj1gEXawyC=2TWA@mail.gmail.com>
Subject: Re: [net-next v4 4/5] net: stmmac: Add PCI driver support for BCM8958x
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com, 
	rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, xiaolei.wang@windriver.com, 
	rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	leong.ching.swee@intel.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 14 Aug 2024 15:18:17 -0700 jitendra.vegiraju@broadcom.com wrote:
> > +     pci_restore_state(pdev);
> > +     pci_set_power_state(pdev, PCI_D0);
> > +
> > +     ret =3D pci_enable_device(pdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pci_set_master(pdev);
>
> pci_restore_state() doesn't restore master and enable?
Hi Jakub,
Thanks for the feedback. You are correct, The pci_enable_device() and
pci_set_master() calls are not necessary.
We did more testing without these calls.
We will remove the calls.
Thanks

