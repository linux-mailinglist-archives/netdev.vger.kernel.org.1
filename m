Return-Path: <netdev+bounces-121995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED595F821
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E6D1F23726
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB891990AB;
	Mon, 26 Aug 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e+pjeuj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB710E9
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693465; cv=none; b=CRAU+iGifezpYHPAAK0pvC1f/SnhMIp8YI5lJ36u6iK8mhcZDPHhRFr51Q/5QBtHYfPjJS2qdKuVrdwPOQAlPT1B8loOZex2BHmoDyf9sCdypSpcrw9o77BUW12Zwwxn6Joog2A0hEDskl9pgIumrTT7CvGcOSMyqqwXCFB3Luo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693465; c=relaxed/simple;
	bh=ai93OtOQrbR4S3AT314DLeiH8KJPW3YI556gX8jIasE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGqM45ZzKg1/aqkcZKmjJAua7JpUhNC6gJYBhQ2bevlMIcMyuNlp+gKaDK3bTqvasxK2BN6VR8VNJFHEZKY2ZzWaiPO3XxUr9B28p5SHuc6lpSnMTAN5fIzCXjuvdB3VIVvmsfEsWQimbHS3+6HXaCtbQle0g3/J4b9JyddOXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e+pjeuj4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3e46ba5bcso3265798a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724693461; x=1725298261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iClgDrknyT0dEay6TLsYqV+rELzO0m3jwG6/VjVsKOY=;
        b=e+pjeuj4mPrtiacsgQal52McaGxDOWl6JKcDmgYDtfpRpu5x5rZ94dZ9bQmeQS6INY
         md7PNXfBKZ55/+GpJo+gI0ARPrS134axbAVbJGBGTYZph5L9E14QYmD4/Ov/S+MjtVaw
         Swy5SiFwqLgFpqTAwpaAEwue4ZdbRAg7kKbjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693461; x=1725298261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iClgDrknyT0dEay6TLsYqV+rELzO0m3jwG6/VjVsKOY=;
        b=JgocUqwL9CMHFCM2BhPJRVcoB6sXGrXc1LEnTULcrvfbf+4tjBGj2LdzzDAbLS39jn
         UVkjMwytYdCNEyn7KlyROrvQWYqr7oiaHLe5NwglQV/A365oT8uHgeA6oSGUmGrjlXa4
         RgI4EGxRjU9uc/QT5Yc8/PsPUV0vZ4t2KW5Hb1qbsKnraIaJhYtrqpvcD3z0kkg2yI1C
         uGmxFvPlG38hA1eV+nEAxEY80bPH4+f1ajCYqVSgCs4rPXjuLujUJHL/WQ7gxuZqjmUT
         JzxY+IRZU4Nzmsrs+oOeRLNABymC559v57wURLs+1B30LjTilUlB/UHqfpAf2BylFq6/
         IJYQ==
X-Gm-Message-State: AOJu0YxHyqM8mv2GTnX27R7WZwwSNayEL7CpSh/RyMKNTBClmGrAjlHA
	iYhs/IrscxjKc5dpO/o4cle0BXQwFsmVkldHC/VPDXNSTJEIuAI18A/NP7yqygsrJ5+AhiU0Ztv
	aUIzO0BTYQWuKaG5rgxo9dSEmfFUjxOkcxJ2A
X-Google-Smtp-Source: AGHT+IGOiC9l+tylzHyvTlxh5R323gDD1FRUx3Z+bfPXVWn9FyrfJSQssxkfETmOUkVELarY+SrTHbJFJ2oK/08oDGc=
X-Received: by 2002:a17:90b:4a43:b0:2d4:924:8891 with SMTP id
 98e67ed59e1d1-2d8259f79a4mr319895a91.38.1724693460840; Mon, 26 Aug 2024
 10:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-5-jitendra.vegiraju@broadcom.com> <5f7a617e-a8a2-40ca-a54a-19e58d69ab33@marvell.com>
In-Reply-To: <5f7a617e-a8a2-40ca-a54a-19e58d69ab33@marvell.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 26 Aug 2024 10:30:49 -0700
Message-ID: <CAMdnO-+ZKyoPY=ZDO8cir5T8hcF-nLRhkasfykF8EFbbedqXFg@mail.gmail.com>
Subject: Re: [net-next v4 4/5] net: stmmac: Add PCI driver support for BCM8958x
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com, 
	rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, xiaolei.wang@windriver.com, 
	rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amit,
Thanks for the review comments.

On Thu, Aug 22, 2024 at 9:35=E2=80=AFAM Amit Singh Tomar <amitsinght@marvel=
l.com> wrote:
>
> Hi,
>
>
> > +{
> > +     int ret;
> > +     int i;
> nit: This can be merged into single line.

Thanks, I will fix it.

> > +err_disable_msi:
> > +     pci_free_irq_vectors(pdev);
> > +err_disable_device:
> > +     pci_disable_device(pdev);
> Shouldn't pcim_iounmap_region be called here to unmap and release PCI BAR=
s?

My understanding is that for managed API calls pcim_iomap_regions(),
we don't need to do explicit clean up.
Please let me know if that's not the case.
Just realized that pci_disable_device() in cleanup is not required
since the driver is using pcim_enable_device().

