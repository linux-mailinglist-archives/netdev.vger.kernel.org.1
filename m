Return-Path: <netdev+bounces-80660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F09880344
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349DA1C2248E
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C21804A;
	Tue, 19 Mar 2024 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X4eOxCSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184517BA4
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868698; cv=none; b=oUH2rYxWch80UhRLWec2IIx2w85RWgMf/PRxIOOD5yz3YR323PHqE7Ka+qC4UEMi2udumCuxMaL3wukgsUPvM1X3ANwyVv44gN6XJzcvFeHd8oI2woSFnLxql4C4T89KSPUdatqo+mRjuYwSEL5ed54dRzlDvJROE9JaUrqqtL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868698; c=relaxed/simple;
	bh=jL9kHyMM7c3nVEZ31ALav/nIxEz+OLnT9X61bJOp+Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAvcKWBNXYNGMNl9vuZNOMhs5M3d7gJrkpm9tn8AllnebemRJM5UwvO6i96fxbTn3hVVTm2wM0S/B7JEBnNv2gydKsftlIANwFpLRp+BeBcP11aHGPcvlQek9riGxiiMN9fK3CeDyQ1KK1zexEuKHrzKum/a8cC0cAFkFjVQh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X4eOxCSP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430dcd64e58so10533631cf.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710868695; x=1711473495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy7T3S3KJOVX4N1q15sidzyEWWPC1Gkc2ooZN7wpRNo=;
        b=X4eOxCSPOLmSwqOG2tA52G6tt0+kOc5lYg+puJ3itS2gCDKRbMlSoDRPnNf7GzZCoi
         b5vwCIXm3Xgf8fcGe8O6BlAGXVSs3XFq5KL5CbS+Y/0MWj5XKXjQzpuxwbgPZUJRwqnP
         Nq7hezlm/Y/xBtpx03JhXtRq6jlumL8H7S8W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868695; x=1711473495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy7T3S3KJOVX4N1q15sidzyEWWPC1Gkc2ooZN7wpRNo=;
        b=joBBmZDW9GZdGSkhlWDCbj2tUMf0k04nZwFmIwEp7Qu5atBRNSDBsI/8XSJv2PInRk
         KNmKPzhQ55/BjsyRIMk3/jOZCCBOGF/SnT03hOZ/Kvoxfs73Jx+8f/hSnyf2CCtDSoGS
         l3t5fEM2BtjWoWd/Jz+sH/vhn6hrto3+05SnMyGJRE7ELYBp1uLkla75ixtnvE3JIKY4
         Jcoj/U2IjDhlmAvujcvU+Mj+5XdhP5yvIKzZ5vbW+AWsxfz/Aqti9z6TgZ4IwU3GN+QN
         1/4NPquNCymt3Vy9DYO0EthKzhmU25dycKntgxbkf3CXgRleVLFaj4o7I886FQfpYcIT
         oVKw==
X-Forwarded-Encrypted: i=1; AJvYcCVloVg5MmTxUrFNF/gcVaawUAT6rpU7DMKGrchvYG9KL5/SqB2lO0VJ4t2LxOpr50nJLXRnlP1Mji/wHkOGyICDsdidzNs2
X-Gm-Message-State: AOJu0YwGRvzBWW5hy851I2dkldTpvcOTiv5W004tk1zI8xRkCtTAw4Wo
	26uUwpDLhbYv7WiOnih9NJQ9wdlngotUGC/MXPyy0JYOIq+xmsm8EjGnfYnB8D3VtVbgCsJcC2Y
	=
X-Google-Smtp-Source: AGHT+IEyaboq9jPZOpo7Wrl1m9UwbbH0Q6q3Oi8HHbvlR4XGJut0I/VITC1UHt1q70z7DKiELSLwlA==
X-Received: by 2002:ad4:5309:0:b0:691:6650:5e21 with SMTP id y9-20020ad45309000000b0069166505e21mr14297278qvr.33.1710868695115;
        Tue, 19 Mar 2024 10:18:15 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id gc13-20020a056214230d00b00690c99e7ad5sm6604070qvb.110.2024.03.19.10.18.14
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:18:14 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so17561cf.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:18:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXenyZTB1LTsZU8zglEeKYoNt+cVF2R5s7otZ2nuoFJW4kBiwSkjbdXp1yEy+fgMn0kE1oUBr51Pck7y/su7RTU2O9uT6uH
X-Received: by 2002:ac8:590c:0:b0:430:b7d0:59d4 with SMTP id
 12-20020ac8590c000000b00430b7d059d4mr1682qty.19.1710868359392; Tue, 19 Mar
 2024 10:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org> <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
 <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
In-Reply-To: <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 10:12:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
Message-ID: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 9:38=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Mar 19, 2024 at 09:10:38AM -0700, Doug Anderson wrote:
> > On Tue, Mar 19, 2024 at 8:30=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
> > >
> > > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetoot=
h
> > > device address in big-endian order when setting it using the
> > > EDL_WRITE_BD_ADDR_OPCODE command.
> > >
> > > Presumably, this is the case for all non-ROME devices which all use t=
he
> > > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices wh=
ich
> > > use a different command and expect the address in little-endian order=
).
> > >
> > > Reverse the little-endian address before setting it to make sure that
> > > the address can be configured using tools like btmgmt or using the
> > > 'local-bd-address' devicetree property.
> > >
> > > Note that this can potentially break systems with boot firmware which
> > > has started relying on the broken behaviour and is incorrectly passin=
g
> > > the address via devicetree in big-endian order.
> > >
> > > Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device ad=
dress")
> > > Cc: stable@vger.kernel.org      # 5.1
> > > Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > > Cc: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/bluetooth/btqca.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > Personally, I'd prefer it if you didn't break bisectability with your
> > series. As it is, if someone applies just the first 3 patches they'll
> > end up with broken Bluetooth.
>
> It doesn't break the build, but yes, the device address would be
> reversed for Trogdor machines for two commits and possible break any
> previous pairings. That's hardly something to worry about.
>
> So I consider this to be acceptable for sake of clarity, and especially
> since these patches will be coming in from separate trees anyway.

I guess I have a different opinion on the matter. I often end up
cherry-picking stuff to older branches and I generally assume that
it's relatively safe to pick the beginning of a series without picking
later patches because I assume everyone has a goal of bisectability.
This breaks that assumption. IMO splitting up the Qualcomm Bluetooth
patch into two patches doesn't help enough with clarity to justify.


> > IMO the order should be:
> > 1. Binding (currently patch #1)
> > 2. Trogdor dt patch, which won't hurt on its own (currently patch #5)
> > 3. Bluetooth subsystem patch handling the quirk (currently patch #2)
> > 4. Qualcomm change to fix the endianness and handle the quirk squashed
> > into 1 patch (currently patch #3 + #4)
> >
> > ..and the patch that changes the Qualcomm driver should make it
> > obvious that it depends on the trogdor DT patch in the change
> > description.
> >
> > With patches #3 and #4 combined, feel free to add my Reviewed-by tag
> > as both patches look fine to me.
>
> I don't think it's worth spending more time and effort on this issue
> (which should have been caught and fixed years ago) for this.

Sure, that's your opinion and if the BT folks agree with you then they
are free to land the patches without my Reviewed-by on them. ;-) Mine
is not a strong Nak but I feel strongly enough that I'd prefer not to
have my Reviewed-by added without the re-organization.

-Doug

