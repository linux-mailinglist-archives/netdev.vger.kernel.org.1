Return-Path: <netdev+bounces-173047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA2A5701B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CA53A27AC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49423E229;
	Fri,  7 Mar 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxLHrpdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C671607A4;
	Fri,  7 Mar 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370830; cv=none; b=DuNIzM/ANiWKnAv/Ho1iBQ4GAaTuC+cH+UxsEaFRZScOAkcazWVuUoG2v7zhmLmYRl+tVaalxfeqzWCYYGstYFY51GUbj27WV35smySuyQRVayFrnbR7rfXTvrUMmD3GJbaUahizpB5dsEdT7X/Q0N3aKnigvdLrBXPbOE3xsDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370830; c=relaxed/simple;
	bh=PCBLZbxeORQk+gg5YOjCD6ldtBvJ/+2v4ImdaMUnWgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmWHk8W+mLNPP3SV16TdTulkJ7GeIs51TmaYrAtz8ANVZ/xqKSjnjKotX61JJ8wUtoYAIbiAOsnFSNOlPEbFN8il0hIKZASWYh7qfIlTv9zeyuFrjAIZQyT3OTjlw1dl8X1iCVkofxRWNRXvn/ZQHGzncX+qdIvsFcPubmDyzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxLHrpdg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac25313ea37so220996466b.1;
        Fri, 07 Mar 2025 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741370827; x=1741975627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wkOomTGttoakawgqhoO+GpdOmml5a28PHZWdVY9aEg=;
        b=IxLHrpdg2f02pmksqXYVyJ3V8ag8KfHsraLw+xDi3YGe4pcfF9DkRcd9Hopa+WKNeM
         g6y1fVU/83zCZ8UUWNRGNjtQ96HzRVY/g7tKLmsYxoT7e1napRO9GueDtJMiDSjup0wH
         6gueklHmbY517i00DhG+2epTELlXBRXnN9m8DYcRzwMZ59YMFZp1mvlhS55EKfwJYRPm
         NtzqdOrKwaNmEI9SW+cMzzM/QzgBlUT0MM96252wX7D54sXwTWbbbKX2sirPmrRY3/Xc
         ZHzbufvS70ivJyPf94pxthc27r9xHWoFulXwnwuY5Oa1xFOhSegppwLloijG0iXqeAow
         SAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370827; x=1741975627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wkOomTGttoakawgqhoO+GpdOmml5a28PHZWdVY9aEg=;
        b=TnLkdQPCszAKkbDWMRkx31vbBnvouWKwKMi5aCl7MOVPQCaSUewfj1g2eW5RqhsCIl
         xfbDtXnqYuFbNmLbct7cVD6GhvpTrQLR6Q1MOw0oMgP6wScaujo8Yqd3o06395XAe7pH
         oDkgQ3owPA8ysvwIRB96pxlyeZux8kjWh+GUF56P8tNQQwuZD+rJQ9/EY/tRaOhxGqS3
         40HX1qkPNgPdF/9MHWojjXWDSwOZfFdfxDM7ObaTmDZHHHOqo5tKNN2AJC5tLRNOgYLQ
         ikVPORUFVFpiQ812CUyBv50pQUhgtitWV/XnSkhp7QlBR6sCsE6PpssnwmaD8BXdn03X
         JlcA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Lzpj7cGc3oDHzckPdH6D3oSbkIqSwdbZe2HniSm0Ih83WV2GR/8n4jy1nZlxziLk3k3l+YVw@vger.kernel.org, AJvYcCW9M9GbLabGUbfaZCuKChN0ulrbKozqbh3ya8FPEjL53X1rDaioUZYEyURVfQJ7w1o4bc/5MCh937+Pd5U=@vger.kernel.org, AJvYcCXRt6qPqi5DHVFyl69Hv6MhtUb0wKvF7HIFLWVs1/CNUuEQQPt9zx5yupiyqv4nRynydWscgCZ0pfVo9wHLkJWpHGetXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtAR0QMxPaNqGAIm5SYBzcz5eacSjKzqjnMX8dUcMoaCuetRrD
	af2qPdoP0gkgd1lOLA0cJ/hMYTAh3rZIsQSpXH3X4iNkjI1CLD5Ouq9MG4GQketDqh5Vs/E0FN6
	OoF2ERDomFxdQZYCKYk7TtYU23Io=
X-Gm-Gg: ASbGncuOge9ExTGCb+yuZcjy3vaxD2EcMsV/KjgAKLVJRpE1TudfNCEvfruPqNZDM4d
	ujEYRE6LJ1LtLvRy0+csSaGzIaNnktFppdb1SnYqpkVdR9//wWl1OUMWY1cJ4p4YvDbuwV5HPrv
	6LtlAvvoXu3ky92fg3CclqIiKCcBgO
X-Google-Smtp-Source: AGHT+IFBf7glgDcgWmZiKnDmmcF21bxMSuMDhbcpDZPMMBRIr6Vb+pd9XoZN62iofvl9sTrgCJwFci7pDGa5B6mFURE=
X-Received: by 2002:a17:907:a193:b0:abf:51b7:6071 with SMTP id
 a640c23a62f3a-ac2525f212emr392804766b.13.1741370826759; Fri, 07 Mar 2025
 10:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
 <20250227121522.1802832-6-yong.liang.choong@linux.intel.com>
 <Z8lLm9Ze9VAx3cE_@surfacebook.localdomain> <601c88fb-8ec8-4866-a45d-f28dea6d9625@linux.intel.com>
 <CAHp75VeOKbAsvSuf5+VQnGFmUcN92TNnR2eF1+70h3PjaMdMqA@mail.gmail.com>
 <d7c0094e-7fd3-4113-8d00-91b7a83ffd1f@linux.intel.com> <257769403908de3ac6271059e1febee88654fbdc.camel@linux.intel.com>
 <19b78790-d4d3-45db-9b1f-fbe40f8ed795@linux.intel.com>
In-Reply-To: <19b78790-d4d3-45db-9b1f-fbe40f8ed795@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Mar 2025 20:06:30 +0200
X-Gm-Features: AQ5f1JoeMb52MrYyvd86gAym0UFqsglYSq0MjE2RDPOAAk4Ejr9eExmge1UjnS8
Message-ID: <CAHp75VcXtwe3zutnZUDNXBPe1qgwP+GbBF9KSFHOPioEvSk3Pw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/6] net: stmmac: configure SerDes according
 to the interface mode
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: david.e.box@linux.intel.com, Simon Horman <horms@kernel.org>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:28=E2=80=AFAM Choong Yong Liang
<yong.liang.choong@linux.intel.com> wrote:
> On 7/3/2025 4:52 am, David E. Box wrote:
> > On Thu, 2025-03-06 at 20:56 +0800, Choong Yong Liang wrote:
> >> On 6/3/2025 5:05 pm, Andy Shevchenko wrote:
> >>> On Thu, Mar 6, 2025 at 10:39=E2=80=AFAM Choong Yong Liang
> >>> <yong.liang.choong@linux.intel.com> wrote:
> >>>> On 6/3/2025 3:15 pm, Andy Shevchenko wrote:
> >>>>> Thu, Feb 27, 2025 at 08:15:21PM +0800, Choong Yong Liang kirjoitti:

...

> >>>>>> config DWMAC_INTEL
> >>>>>>        default X86
> >>>>>>        depends on X86 && STMMAC_ETH && PCI
> >>>>>>        depends on COMMON_CLK
> >>>>>> +    depends on ACPI
> >>>>> Stray and unexplained change. Please, fix it. We don't need the
> >>>>> dependencies
> >>>>> which are not realised in the compile time.
> >>>> The dependency on ACPI is necessary because the intel_pmc_ipc.h head=
er
> >>>> relies on ACPI functionality to interact with the Intel PMC.
> >>> So, that header has to be fixed as ACPI here is really unneeded
> >>> dependency for the cases when somebody (for whatever reasons) want to
> >>> build a kernel without ACPI support but with the driver enabled for
> >>> let's say PCI device.

> >> Thank you for your feedback, Andy.
> >> I appreciate your insights regarding the ACPI dependency.
> >> The intel_pmc_ipc.h header is under the ownership of David E Box, who
> >> focuses on the platform code, while my focus is on the netdev.
> >>
> >> if you could kindly look into making the ACPI dependency optional in t=
he
> >> intel_pmc_ipc.h header, it would be greatly appreciated.
> >> I am more than willing to provide any support necessary to ensure a sm=
ooth
> >> resolution.
> >
> > Choong you only need put the function under a #if CONFIG_ACPI block and=
 provide
> > an alternative that returns an error when the code is not build. Like t=
his,
> >
> > #if CONFIG_ACPI
> > static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc=
_ipc_rbuf
> > *rbuf)
> > {
> >     ...
> > }
> > #else
> > static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc=
_ipc_rbuf
> > *rbuf) { return -ENODEV; }
> > #endif
> >
> >> This patch series has already been accepted, but we recognize the
> >> importance of addressing this issue in the next patch series for upstr=
eam.
> >> Our goal is to ensure that the driver can be compiled and function
> >> correctly in both ACPI and non-ACPI environments.
> >>
> >> Thank you both for your understanding and collaboration.

> The current ACPI dependency for the config DWMAC_INTEL is necessary,

I can argue on this. The driver worked without problems on the cases I
explained, so the dependency introduced very recently and only for a
subset of the cases. What you probably wanted to say is that "the
dependency is needed to avoid compilation errors in CONFIG_ACPI=3Dn
cases since the used API doesn't (yet) provide the necessary stubs".
With that being assumed I agree.

> but I
> agree on making it optional.
>
> Implementing the suggestion from David using the "#if CONFIG_ACPI" approa=
ch
> would address your concern about users who need to build a kernel without
> ACPI support.
>
> If you are okay with this approach, then I will submit the solution for
> upstream.

Yes, please do it as the ACPI dependency brings a few hundreds of
kilobytes into the kernel with a lot of possible unneeded stuff.

--=20
With Best Regards,
Andy Shevchenko

