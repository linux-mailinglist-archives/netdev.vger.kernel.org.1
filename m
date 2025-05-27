Return-Path: <netdev+bounces-193672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ED2AC50A0
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 16:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889973B94D3
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2669615A858;
	Tue, 27 May 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC07RlYt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD34C7F
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355362; cv=none; b=abr8Xb3GdDRnwVjkHuqu/jCT7muWj0Ygo5JtAFaOL5uGBRuWRTBFezyyMTpCmPaPHIP3Zr7+VnNXdIY4xI72AxLxydX7uVk+eqgWWUk8q102UP/t8QQzfCv5m6nwfxREKPTwJ+ysxJC1uFQihs0xov2QJyo3dTSkjOM6uULkx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355362; c=relaxed/simple;
	bh=RyXzkfH82uIofZcjPH9xbahHgmhNvJRlVehT4lcCMKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAr1+IcnAQ6yyd/cc7tFIgjfjeFnprIy8kifO+ckbalbun/mnqr/pt62Jh85kkmuUsSdmvaGmB8bMkNmCQuQ75MA+ye9Z8IJ42r/4Y3P03OZ+Do46Q0R0iFwydRI7/1GfatET2qUlFE/UK7QBqARN7bD48rv21KbRu6shp3cMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC07RlYt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf680d351so27181785e9.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748355358; x=1748960158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyXzkfH82uIofZcjPH9xbahHgmhNvJRlVehT4lcCMKE=;
        b=cC07RlYtt7iLyP1dJ7z84IToI9mmO2bf5ZFnK330LsCYipTaZTauKFiJram04DmZCd
         qSC/znr12yxud2CkA5JTPsxXvZCi7thkWJwU75i38p23/qcPFSpEC70+gN7y+UXEPpU0
         Cj2+DSUg0883AzQKRKDVMZR1/cpktN3D5Mxqgsj86jL8rX7rs/nbSoMHiXZAZ/sDp+vZ
         luTlUbhuqSOEppWqbo/IsZWK0kb42B6BcmDuDrw2Y889m88xw806itaDNP7EFW+i1gwJ
         +VnhHk3A+1cKqEzNuZyCDQJRfPLX89mPqSX+w0JJWgIJPtQwu/IM5eDREx7r3lIb7+NM
         2w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355358; x=1748960158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyXzkfH82uIofZcjPH9xbahHgmhNvJRlVehT4lcCMKE=;
        b=hSWhBs2l0xhyo+odYkPZBAVjegbKHpMFeApBPztuYhn30EAN0luojDcliabx0/NYT6
         xZskBXEvX0YqK0mEes1Q6NTR4hcvkgc6fsa5DdYfSxCqymwJowv/K0+Vfm4YFHcib+nY
         DBeIU4xsSbSTA4r5DD82jyZhT4RG8Xsn7q9+ik88uRT9avbjZbrGm6iZ2q2oTfeUT4YG
         vpwnZQy0/DWaMahOi3ONh5UgUu+jepR5lhUeOMKG32UaZ/Av+yq6z6JjGov6Jh5TyjZF
         2fslB2fxCLw1ng4cMwHIK7lWdPljTfQaLngQSErNr/aipIg94juXfs2ORtmIncj0EAWI
         johQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHNWKPeCLZ5X6AYj9w1AfFtU4fO5SOv020mlK7ofsO4Smb5Xfh5z+RU2WQWvCbqn/u1yQULlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPypl82+j+HL+duWUo7P0NHvago7u+zdNv2aNaXpKxQ7ndtwk8
	lDVSPXOK9TYlSrtYySjbbuuR34CriGnucB5rJ7DQjQflEKMfQ1WNat+Xbi6A6vM7rveUVlE+8ba
	DqI9/2HnE2zIWUEseldIU4/sT0HBrgNU=
X-Gm-Gg: ASbGncuNI5/OjQ1RZH4c0Vu4N5Jy+PGn91nXRJ3+i9vndepHEp/22u0ekcOPcoUKh2I
	fdAb8bCbPOtjjw+EgTU8HsdBbny0Aq9XaqXAjZHbiv33KOppYOOXScWOCpMwmWc0bE/kTpsC9g/
	m3MrbifeUD9btu9wEH0hJ27QCwi+nuAQ==
X-Google-Smtp-Source: AGHT+IHR8nhDcR83cYg9wFlCkdA4biWNxveUq5ABiuYYwj//nEYLhbh5UTRgXpB5h0COzQa36DPMuTBtBJbed9is/iU=
X-Received: by 2002:a05:6000:4008:b0:3a3:6478:e08 with SMTP id
 ffacd0b85a97d-3a4e5ebbae8mr895338f8f.23.1748355358296; Tue, 27 May 2025
 07:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526130519.1604225-1-dnlplm@gmail.com> <CAFEp6-06ATV_rh_KWvjgNoiw67WPvAE-gF_gU-DJdcycDiYVqA@mail.gmail.com>
 <CAGRyCJGESxV2M9e34dJw89=0NFt0+hrXCOCW=MaYdVfn42DZTw@mail.gmail.com> <CAFEp6-1nB-hiJb+W3zmnCSy9XaNfgbW7AqMeJ3LKa4+St-AqJg@mail.gmail.com>
In-Reply-To: <CAFEp6-1nB-hiJb+W3zmnCSy9XaNfgbW7AqMeJ3LKa4+St-AqJg@mail.gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Tue, 27 May 2025 16:05:33 +0200
X-Gm-Features: AX0GCFt3N0ajXkqlT5FHwW0LcoW5EQofUNBSUp8gTn3Q3A_5ErqpiPCGClcRx2Q
Message-ID: <CAGRyCJE+SGqiC6PsNnguN7sM1s48bEkfBeMeQaeBBZr9Hs-b0w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Slark Xiao <slark_xiao@163.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Loic,

Il giorno lun 26 mag 2025 alle ore 22:38 Loic Poulain
<loic.poulain@oss.qualcomm.com> ha scritto:
>
> On Mon, May 26, 2025 at 4:19=E2=80=AFPM Daniele Palmas <dnlplm@gmail.com>=
 wrote:
> >
> > Hi Loic,
> >
> > Il giorno lun 26 mag 2025 alle ore 16:06 Loic Poulain
> > <loic.poulain@oss.qualcomm.com> ha scritto:
> > >
> > > Hi Daniele,
> > >
> > > On Mon, May 26, 2025 at 3:19=E2=80=AFPM Daniele Palmas <dnlplm@gmail.=
com> wrote:
> > > >
> > > > When creating a multiplexed netdevice for modems requiring the WDS
> > > > custom mux_id value, the mux_id improperly starts from 1, while it
> > > > should start from WDS_BIND_MUX_DATA_PORT_MUX_ID + 1.
> > > >
> > > > Fix this by moving the session_id assignment logic to mhi_mbim_newl=
ink.
> > >
> > > Currently, the MBIM session ID is identical to the WWAN ID. This
> > > change introduces a divergence by applying an offset to the WWAN ID
> > > for certain devices.
> > >
> > > Whether this is acceptable likely depends on how the MBIM control pat=
h
> > > handles session addressing. For example, if mbimcli refers to
> > > SessionID 1, does that actually control the data session with WWAN ID
> > > 113?
> > >
> >
> > yes, quoting from a QC case we had:
> >
> > "There was a change in QBI on SDX75/72 to map sessionid from MBIM to
> > muxids in the range (0x70-0x8F) for the PCIE tethered use.
> > So, if you are bringing up data call using MBIM sessionId=3D1, QBI will
> > bind that port to MuxId=3D113. So, the IP data packets are also expecte=
d
> > to come from host on MuxId=3D113."
>
> Ack, could you please include that information in the commit message?

Sure.

> Also, we should consider renaming the mux-id macro/function to make
> its purpose clearer.
>

Ok, let me see if I'm able to find a better name.

I'll wait a few days to see if more comments are coming, then resend.

Thanks,
Daniele

> Regards,
> Loic

