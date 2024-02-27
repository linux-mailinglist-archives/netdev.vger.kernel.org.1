Return-Path: <netdev+bounces-75303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E68690E9
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC911F273FC
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0A1386CF;
	Tue, 27 Feb 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBNa6Ma1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97282F2D
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038392; cv=none; b=BCJVyjNaeGa3ukvy6WfpNWuLIjYwO+jyt8DOkobP3vs9FPMmnmjXCfmTz8cGG5vQk1daI0gSsu76Vc+JYDpnPHUG4lfGZ+aaV7/zSLNFNtKJC2ljgucZeNGUNaTxx6SDRnBRF+3O4pqjyYV8huASTP7ia+BcyDvsZ6CxsZf3C24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038392; c=relaxed/simple;
	bh=W6nSihqQazc2RxS0b6ff44+mNScmEMm0nx8W2Ma5un8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZMUgklaiwRoqw7CPXfkwlJHrCllwMtqnDd9k9iXmXRIi+E5NOv7/xHGeHzjZc5Ps8C/+YURthvK+8G0FjBY6oqQJE2Uxxx8AZM6vZ/pUc6UQEwffWNrpAC9FwLowRQA2EMTzkrfTnQpDppJTqMWR2reYTFkXcJoe8BOUA6l3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBNa6Ma1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709038389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W6nSihqQazc2RxS0b6ff44+mNScmEMm0nx8W2Ma5un8=;
	b=RBNa6Ma1za1lEiVmaMTN+X/krsVbF5gsucMJ7T2CaqX5DgLGVGPQtXZhFGfC2AW6+xeZNu
	94zMlA1qI4pkJzcBTyERNPftT92kT1X9t6ZuEH/jC2++omcsmsOaHLZa066NH2uhFlNFNY
	BHjhCPI9onkuHSt6x3xRTaJ+/y0MPDY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-q8VEVUe0NqqUB1V22LFMoQ-1; Tue, 27 Feb 2024 07:53:07 -0500
X-MC-Unique: q8VEVUe0NqqUB1V22LFMoQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3377bf95b77so1079892f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038385; x=1709643185;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6nSihqQazc2RxS0b6ff44+mNScmEMm0nx8W2Ma5un8=;
        b=CdOsPM5UGnlNpSzcp9mjsLu60khxaheqD2nuGJyMZZXPCPskwk9z1wGmzCnGpfme8R
         sUAzI260xYKuWq2yTkobGDqlOtUbjXr0ZDgq3ezz+VnPuf093q0KXvRL+HeQ4eSgk9T/
         DzOacadFn6AfN95yK5LjU585ENo8MLr+YufTlwOQZrROQW665XOSOapObCu9KNNmP33N
         R9mb8YDHRr4ojach0xhyAv94Y+D53T5qE3naekwfag1RRCvOMuwHHyOK8dxy/YEPEx+4
         Q+FzuDHpszgRdD8UNSahAComHQ0FhvWqjqxR3hCEXRjUoKTuX49lyjYDtgXt6SXZM554
         3WFA==
X-Gm-Message-State: AOJu0YzIJChsKBddYdSH1KsxAeWNI4+2GS3LSubOjFVvkL5p8CwXWehO
	Qj6rR07v7f3kT9oZco+2ZLnYvyVTaJ09U4wLmsxbthlVL7BJlTMHeXlf2TLRxfKY+/AeDX505AL
	jdbZ4Xh3FvEEjv3TqCViYeL+B9Tgyiqu/DMYS4xaPsopK1RXPJYkCO7FYrcCQVw==
X-Received: by 2002:a5d:5b0f:0:b0:33b:48ed:be63 with SMTP id bx15-20020a5d5b0f000000b0033b48edbe63mr7280954wrb.7.1709038385710;
        Tue, 27 Feb 2024 04:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPVAXADRsXx4hZP+xM+4ftdTjj57Q5d0niPidsBM39PADkME7WIw1Zozv2hg+iEm5gBfBQxQ==
X-Received: by 2002:a5d:5b0f:0:b0:33b:48ed:be63 with SMTP id bx15-20020a5d5b0f000000b0033b48edbe63mr7280940wrb.7.1709038385335;
        Tue, 27 Feb 2024 04:53:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id bq8-20020a5d5a08000000b0033b684d6d5csm11484088wrb.20.2024.02.27.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:53:04 -0800 (PST)
Message-ID: <33ba4e9cde1ccd1c9f561873782478a913eab670.camel@redhat.com>
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
From: Paolo Abeni <pabeni@redhat.com>
To: Doug Berger <opendmb@gmail.com>, Florian Fainelli
	 <florian.fainelli@broadcom.com>, Maarten Vanraes <maarten@rmail.be>
Cc: netdev@vger.kernel.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Phil Elwell <phil@raspberrypi.com>
Date: Tue, 27 Feb 2024 13:53:03 +0100
In-Reply-To: <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
References: <20240224000025.2078580-1-maarten@rmail.be>
	 <bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
	 <f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-26 at 15:13 -0800, Doug Berger wrote:
> On 2/26/2024 9:34 AM, Florian Fainelli wrote:
> > On 2/23/24 15:53, Maarten Vanraes wrote:
> > > From: Phil Elwell <phil@raspberrypi.com>
> > >=20
> > > If the RBUF logic is not reset when the kernel starts then there
> > > may be some data left over from any network boot loader. If the
> > > 64-byte packet headers are enabled then this can be fatal.
> > >=20
> > > Extend bcmgenet_dma_disable to do perform the reset, but not when
> > > called from bcmgenet_resume in order to preserve a wake packet.
> > >=20
> > > N.B. This different handling of resume is just based on a hunch -
> > > why else wouldn't one reset the RBUF as well as the TBUF? If this
> > > isn't the case then it's easy to change the patch to make the RBUF
> > > reset unconditional.
> >=20
> > The real question is why is not the boot loader putting the GENET core=
=20
> > into a quasi power-on-reset state, since this is what Linux expects, an=
d=20
> > also it seems the most conservative and prudent approach. Assuming the=
=20
> > RDMA and Unimac RX are disabled, otherwise we would happily continuing=
=20
> > to accept packets in DRAM, then the question is why is not the RBUF=20
> > flushed too, or is it flushed, but this is insufficient, if so, have we=
=20
> > determined why?
> >=20
> > >=20
> > > See: https://github.com/raspberrypi/linux/issues/3850
> > >=20
> > > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> > > Signed-off-by: Maarten Vanraes <maarten@rmail.be>
> > > ---
> > > =C2=A0 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 ++++++++++=
++----
> > > =C2=A0 1 file changed, 12 insertions(+), 4 deletions(-)
> > >=20
> > > This patch fixes a problem on RPI 4B where in ~2/3 cases (if you're u=
sing
> > > nfsroot), you fail to boot; or at least the boot takes longer than
> > > 30 minutes.
> >=20
> > This makes me wonder whether this also fixes the issues that Maxime=20
> > reported a long time ago, which I can reproduce too, but have not been=
=20
> > able to track down the source of:
> >=20
> > https://lore.kernel.org/linux-kernel/20210706081651.diwks5meyaighx3e@gi=
lmour/
> >=20
> > >=20
> > > Doing a simple ping revealed that when the ping starts working again
> > > (during the boot process), you have ping timings of ~1000ms, 2000ms o=
r
> > > even 3000ms; while in normal cases it would be around 0.2ms.
> >=20
> > I would prefer that we find a way to better qualify whether a RBUF rese=
t=20
> > is needed or not, but I suppose there is not any other way, since there=
=20
> > is an "RBUF enabled" bit that we can key off.
> >=20
> > Doug, what do you think?
> I agree that the Linux driver expects the GENET core to be in a "quasi=
=20
> power-on-reset state" and it seems likely that in both Maxime's case and=
=20
> the one identified here that is not the case. It would appear that the=
=20
> Raspberry Pi bootloader and/or "firmware" are likely not disabling the=
=20
> GENET receiver after loading the kernel image and before invoking the=20
> kernel. They may be disabling the DMA, but that is insufficient since=20
> any received data would likely overflow the RBUF leaving it in a "bad"=
=20
> state which this patch apparently improves.
>=20
> So it seems likely these issues are caused by improper=20
> bootloader/firmware behavior.
>=20
> That said, I suppose it would be nice if the driver were more robust.=20
> However, we both know how finicky the receive path of the GENET core can=
=20
> be about its initialization. Therefore, I am unwilling to "bless" this=
=20
> change for upstream without more due diligence on our side.

Could you please report back in a reasonable timeframe? The issue
addressed here looks like relevant, and the patch quite self-
encapsulated.

We can keep the path in PW meanwhile.

Thanks,

Paolo


