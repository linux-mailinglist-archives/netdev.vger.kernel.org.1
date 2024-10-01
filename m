Return-Path: <netdev+bounces-130697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECD598B315
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 06:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1391F2420D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 04:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B31B86D3;
	Tue,  1 Oct 2024 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW+ebHyM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D281B81D1;
	Tue,  1 Oct 2024 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727757452; cv=none; b=X3fhlokNXp6BNI90WE62xKO2LLmoAPa34Ue0ijoWHaqVgT0Bi16LfxATFjyJk24n9c2mL8ljgpkTrzUgX10w7qSOi+cMrK28Ldne6cm8/AV9dj7dyzBoFTYN0GoxzKJfeCWKD9DFWJd/zZ7QczQwN2i4pqAC1+vFBCMU81fRcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727757452; c=relaxed/simple;
	bh=LZ5PMqQLlj+hCXJWg51KyuSJnp4YjqkIXXC/3j+wyAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOGpwNqGJJXtz8B/SiYmHsgnWjvsk1RMX7rFyisr4Q18nHSvKBZL3C3YYBm8h3rH3ZJpzS/3iqihO8yFQp6U3L6iw4JDAZ0Hs41lYmMyRg3egm1JM2L7opMBNvOSRITolkDaZBjJfYzxGfbBw4mjNd/WXJHQdBPr6fn2IpeyP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW+ebHyM; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84eb1deaf03so1081360241.3;
        Mon, 30 Sep 2024 21:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727757449; x=1728362249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ5PMqQLlj+hCXJWg51KyuSJnp4YjqkIXXC/3j+wyAI=;
        b=UW+ebHyMmianBqOl6Mm0JHDNDI10ClUg5f5P4xoxeb8cyw0gjP/SO2WZoistww236C
         Rlzfr4/1NM0L9UKJKzJRGgajxOPOrGRTIU9solyaZ5rj2nw4QMOKIMPKobEMVfG0xH5j
         PxOedCBUj74H06vKoytvcSC+CF8m4XTx3jC6Y7BbU3SnNMcvXcUV+KqqcXPIv7zfimHW
         8/jwi+35zmuXPxpGNKcV0witWI8NBeWMvP0HnaLb7GC3O4kGDOoJI/fa5u4iodRnMFvn
         Su7CFLoJsCspA+RagxeiVFjuf5lv7QP9vxY+2eHFajwFFHmadjj5tJBqGyk/nhWjTdTT
         +D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727757449; x=1728362249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZ5PMqQLlj+hCXJWg51KyuSJnp4YjqkIXXC/3j+wyAI=;
        b=WNY3GbXs9gEs0eajd91YvfrvAblpv567CQJFc6Ua3zYHgbweMN6O3mewYWzkieK415
         ij5ETJRCd547n3o1I3iyWpmf8pogczBX/KZ7cstrSexwRGsO9x9jGdndQAGAOZ8ITvJA
         Camt34fp8zdsF/ZPO8Ck7Mw1Q37LENIszt6GzWU4XCOdeAhP3hxpjsJk/T3Mf1ztXg7t
         LnCLaXG1/dXB+fAXmlVvBxauhTZqG3mrfJqZrbKgQrNEddkmEIxjBTMqUWnRcoC71/28
         7WtsVgE31A5NV/ByARVO2OJ13DkdTi+1DIN9HVQmawMWFxt8NkyaD4iv7TpixrsLcFA5
         la3w==
X-Forwarded-Encrypted: i=1; AJvYcCVpac+F8CurcyMLi+vWu1laBJuWaors7OOI6ysP99bdlUh7y94JmtD9cf3GeAFuNWqvlgXA1HC7bfrn70c=@vger.kernel.org, AJvYcCXRccDyuUy0+q+SvqWbLTKs3KKujI/31tBIMD37vXwV4sLcxVabp2MtnVrVoJ6X6BUbMCcO2PkD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VGgGXzRw2UIJoXZ1xqRBtPnniB24bKXFSw13/D4HbtfKxoLt
	WfeJy9Syx+CT/MIxrlTLp+2YF/RdzPUAh6S3iB+M3+oBMYM/aZusmqOBI1fqmNCccsk7qIuWTe5
	XzaMXWDKuErpDvLcxPsH+zeE1i6M=
X-Google-Smtp-Source: AGHT+IFNtWBr18OXyho9rBy13vllspx0N2cLNm0fW635niXQrBQe6lJbJVEeDFy1D6jM1e32W26/QFaKxUJl9fUltLU=
X-Received: by 2002:a05:6122:1313:b0:50a:76c9:1b0 with SMTP id
 71dfb90a1353d-50a76d84983mr4237622e0c.11.1727757449623; Mon, 30 Sep 2024
 21:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926160513.7252-1-kdipendra88@gmail.com> <20240927110236.GK4029621@kernel.org>
 <20240927112958.46unqo3adnxin2in@skbuf> <20240927120037.ji2wlqeagwohlb5d@skbuf>
 <CAEKBCKP2pGoy=CWpzn+NGq8r4biu=XVnszXQ=7Ruuan8rfxM1Q@mail.gmail.com> <20240930203224.v7h6d353umttbqu5@skbuf>
In-Reply-To: <20240930203224.v7h6d353umttbqu5@skbuf>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Tue, 1 Oct 2024 10:22:18 +0545
Message-ID: <CAEKBCKNgG1VK9=q8XhNkhpUA+nKvFfO4AOAqQX=NubqsDu75nA@mail.gmail.com>
Subject: Re: [PATCH net v5] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Simon Horman <horms@kernel.org>, florian.fainelli@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
On Tue, 1 Oct 2024 at 02:17, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> On Mon, Sep 30, 2024 at 11:52:45PM +0545, Dipendra Khadka wrote:
> > > And why is the author of the blamed patch even CCed only at v5?!
> >
> > Sorry to know this, I ran the script and there I did not find your name.
> >
> > ./scripts/get_maintainer.pl drivers/net/ethernet/broadcom/bcmsysport.c
> > Florian Fainelli <florian.fainelli@broadcom.com> (supporter:BROADCOM SYSTEMPORT ETHERNET DRIVER)
> > Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com> (reviewer:BROADCOM SYSTEMPORT ETHERNET DRIVER)
> > "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> > Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> > Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> > Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> > netdev@vger.kernel.org (open list:BROADCOM SYSTEMPORT ETHERNET DRIVER)
> > linux-kernel@vger.kernel.org (open list)
>
> It's in the question you ask. Am I a maintainer of bcmsysport? No, and
> I haven't made significant contributions on it either. But if you run
> get_maintainer.pl on the _patch_ file that you will run through git
> send-email, my name will be listed (the "--fixes" option defaults to 1).
>

Oh, thank you for this. I only used to run get_maintainers.pl on the
file which got changed. I will run on the patch file as well from now.

> The netdev CI also runs get_maintainers.pl on the actual patch, and that
> triggers one of its red flags: "1 blamed authors not CCed: vladimir.oltean@nxp.com"
> https://patchwork.kernel.org/project/netdevbpf/patch/20240926160513.7252-1-kdipendra88@gmail.com/

Best regards,
Dipendra Khadka

