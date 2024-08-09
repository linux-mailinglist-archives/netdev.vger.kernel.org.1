Return-Path: <netdev+bounces-117049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F46794C843
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00FCB23A58
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8EC8C7;
	Fri,  9 Aug 2024 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g2lT5Zr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C02D512
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168210; cv=none; b=F2ELt+lr8vQ+iqe27kV1CEKOKV7ebhiZYTE5e970U1rEBksOcRP+D1Uh/tl8amGkwYZzaPT6qQxsZafuP8OdaiEf52qCGzg1gCmxDOk7ebDGphMlqloxer8lHokBXTOJAHymgExbQTlltQPAqfxMKi+zdu3Cuql7xIZEMhpXkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168210; c=relaxed/simple;
	bh=kfVyGK7FU9ZegOabivxSZPP/i0pBwjuwJ4mulpISATI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/ssSg+r5fGM6InXnk6orE1OIuFhFAu/P8eb1bXbf6XTQaA6SJbsm0Wn7cA06jeKJ80A9RDdxgsF86p7NRMnqHOdsq40ut2SzMLHY7wF9RW+7Hze4eSvZsxlwX38Q90iNN0y1MeQGn63NC8aIve8yFHbYU14BU+vaLmQ3KQ4l6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g2lT5Zr4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso1309978a12.2
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 18:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723168208; x=1723773008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJYAKUyPbciCc4vCrXAcPv95+Qs4aCXInm0STL0fohI=;
        b=g2lT5Zr4Tb1YPBwzBkVVsvj4cMQ2vPwBEki571dFtxp2VeTNana0Hi/IIWYupILF2A
         Z1GySRORTKkS9BsLUJuy7kZprnQU+7NEjlADhtcN9mA8eNrSit+IGuyzK5spaaI6VAmQ
         eqeKKTOFCtcm9y3vug8Tz+MfONU7U7qTKJGxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723168208; x=1723773008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJYAKUyPbciCc4vCrXAcPv95+Qs4aCXInm0STL0fohI=;
        b=EHpUx8P4aKGcw9Y4mNi1X8rc0t5ARj5np1Jeu4DK74nMa7z7uYOe7GoofxT4++SQLL
         gLBZsXg85lb0YC8lgs5iwcT3k5nN+4OA36MRifYIHql0HWDLy6iLqVFJ4L44kBGFi1TS
         u6V05kXcrqb1jCoOozi3GVE9kpCi0rh1/7LuB8fE2CIGANjRmO1TaLbQ7wmYM0EsTsGP
         h9ZcuVm1NM8KCW5c7iRmxRpGbCMhOXUduMIQj83Qd6hfSgzJXn1kBDf3zlJQmt9VGrsh
         H6SGWhlS4ShJ4Mn8aEYj4qR0un5+GOWmidPHxbfKMPf68I3S+TzCE/LI0eM+7aNW0pgP
         KzCA==
X-Gm-Message-State: AOJu0YzUEYWty+H0zFuupO0d2vnQc2nJvxyDtfHSW3TKAYfjUNUx+BCz
	5D7g5yGcIrhJk6X2KlCV4uZOnolViqDfyjWaoqxpGsRTBVdK9zKib4anujILWjRRxZRGJPye465
	+uKjFp2Wy5YNoOcsZ/NWBuaH6SKNmLpfaBWik
X-Google-Smtp-Source: AGHT+IHzhTtrIODiPawo9uaYrezjTm9YBfmLrsFRZAR1fnpznOkZgFG+1eZH6YuMmWDJKca259PLWfZIyYoQ25pXmNU=
X-Received: by 2002:a17:90b:4b8e:b0:2d1:ca16:5555 with SMTP id
 98e67ed59e1d1-2d1ca16580emr3666377a91.37.1723168208179; Thu, 08 Aug 2024
 18:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com> <1e6e6eaa-3fd3-4820-bc1d-b1c722610e2f@lunn.ch>
 <CAMdnO-J-G2mUw=RySEMSUj8QmY7CyFe=Si1-Ez9PAuF+knygWQ@mail.gmail.com> <e6b4fc20-a861-4f24-9881-f8151fe66351@lunn.ch>
In-Reply-To: <e6b4fc20-a861-4f24-9881-f8151fe66351@lunn.ch>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 8 Aug 2024 18:49:57 -0700
Message-ID: <CAMdnO-Lte7SfYXBhjBXoKP_LsXRvdexvUKKYBQEC2Y0jjEQYng@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew

On Tue, Aug 6, 2024 at 4:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 05, 2024 at 05:36:30PM -0700, Jitendra Vegiraju wrote:
> > Hi Andrew,
> > On Fri, Aug 2, 2024 at 3:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > +     user_ver =3D stmmac_get_user_version(priv, GMAC4_VERSION);
> > > > +     if (priv->synopsys_id =3D=3D DWXGMAC_CORE_4_00 &&
> > > > +         user_ver =3D=3D DWXGMAC_USER_VER_X22)
> > > > +             mac->dma =3D &dwxgmac400_dma_ops;
> > >
> > > I know nothing about this hardware....
> > >
> > > Does priv->synopsys_id =3D=3D DWXGMAC_CORE_4_0 not imply
> > > dwxgmac400_dma_ops?
> > >
> > > Could a user synthesise DWXGMAC_CORE_4_00 without using
> > > dwxgmac400_dma_ops? Could dwxgmac500_dma_ops or dwxgmac100_dma_ops be
> > > used?
> > Yes, the user can choose between Enhanced DMA , Hyper DMA , Normal DMA.
> > This SoC support has chosen Hyper DMA for future expandability.
>
> Is there a register which describes the synthesis configuration? It is
> much better that the hardware tells us what it is, rather than having
> to expand this condition for every new devices which gets added.
>
Sorry, for the delayed response.
We got confirmation that HDMA capability can be identified by the
presence of DWXGMAC_CORE_4_xx and device_id 0x55.

> Also, what is the definition of user_ver. Can we guarantee this is
> unique and can actually be used to determine what DMA variant has been
> synthesised?
The initial information I got on this is that user versions are
allocated and reserved by Synopsis.
We probably don't need to key off this information now.
>
>         Andrew

