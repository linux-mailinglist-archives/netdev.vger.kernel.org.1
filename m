Return-Path: <netdev+bounces-227742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7501BB66DD
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 12:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F84C19C0F35
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DEB2989B4;
	Fri,  3 Oct 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK4jxQvb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6721267729
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759486154; cv=none; b=BsBvyj1eBPwaPRlHsK2pcJo9eFRMgL2njZpbcmVbeuK56peaBp7hpc7uJ2q5y/tZj7Wvx5oDihxKNSZyQ2cIFgUxx1vxI1bsNdvNmDxCd8GIu8WlKO3E4VYrpXZHAYKohpxPHXwiSb6M0PjaikIiCG2A7zRDvczNVhdRMOPRrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759486154; c=relaxed/simple;
	bh=zyN5kJjGWts9pnV3esQfqyOjly0NsOO5iE9InxBUDQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmNsfXAiB2UPneCR7pJqWK4MjThqIT/rUaNAfeWVNsqUXijQTasQNUH0Zkpb3+aMsqsD4pzNTzh97raVojVNjXFoiDVB3sgV7mw8/iK4Wvs1ZxlbcQiusOqZ3U1PXXVaz9injUO1HtKaiE7TYWwzcA3Uy36cNU5wY6dEIJyi+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK4jxQvb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b55197907d1so1371416a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759486152; x=1760090952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H789t2HmzhmbljtGAHdhtwsEfghCwEDwSOBBlGMKrck=;
        b=hK4jxQvbLl5ZtjCVDzrCgyV+QbIJd0YfD5f5ATeCnhLhyStoFB+szSshtFthHAMZ7z
         gfPOm7Kei4I8uzU53HIV5CFOzO+pTPqOB/YCBZ7vC9w+Dndh3BRWWK9b6hVeH0slwl2m
         7+ZV3Yh2lVE3vstxKstJ595GlpTbQesOewMoPGTE2tkOzgV0oLyDorVX8LBupIJmU90e
         +9SLM5BE9HbKH+A6DgOdsDJiDSuT4RtKj/DM8eXC8UGjAJIFfbzDmxxPn0QpAI3rdnKV
         HGb8nWr5Pkx8o3rwrDiZA/YbIOwT3GM2zRZi/jbmm81R90dGNPcMh9Xu5Z9K+Yk0Id20
         71lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759486152; x=1760090952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H789t2HmzhmbljtGAHdhtwsEfghCwEDwSOBBlGMKrck=;
        b=VDn8OpC2zRcxoqaUa22WlhqcZhRI2Pt578CCOOPFJKIWVHZ5pnurv5sjgQr0As5eaG
         Pmq7EfMUxq6zLqg3p4IYUqw7HYZbr0UuwsQIM6EIa1W6efi8/2NLhD9kqJaceSLiPq6J
         nPlLJvu/hdGGjfQL0RlL6ZAjd2zWESzGIPq3UN8FjK+U/GMwsmrG8Fw8vwSPlYtFNf9J
         98eKWRAgkAjIOg14rlqdRikOi5P5ttRnKk7j9iEwRy6SRdIkS5iEA/twNOrKeNNmSUrR
         3FB8LS4rxWElTNZrrep7qRWdDNwBzJ2gWvPFWl5bBITMDpo3USKubBfqJ5v2JRc9gYIL
         Rc0g==
X-Forwarded-Encrypted: i=1; AJvYcCVascg3W8H3LH99v3BYzFPFF6aM1xcT8sjJGnc0Hst4CRR5LMSyMcHqaXPN5eCBwMYtDN5v2vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWXQj0EXDDRhKwND+OiUZyv/bWQFWUMHpn41CM3j6PaaclK4E
	rBH4xLJ16anAHLjIEU0dpqX34QtNWmERw+YHA+CGX2NN0paMZ0Mc7hAwgHWoVGSHloMzuvI1v8G
	hUTgFhCNX3hDGv9GfKYxR1t6dQYxbPZU=
X-Gm-Gg: ASbGnct/RZlnGMjzR/J53HZr7VohtDtTqL6MNrj1ovLMOjEohiiKf/ZT0PqOTODRm6E
	6ogg6R7ZR8GyQlrXFMjB1W3N6Deh2MsvyS9vCfpmEwuCBsBajGCzzroCGyVk5M4hH/cbDcvit4t
	H63SA7HEyUZOayUm4xbAWDfaG+ITIcTNKdkhqI+CxtoQxcga/9HPypV71VcGrWZDAGa6sAwdUy9
	z16Iqae94zdDIjZ5IfHaPQlYy9McIsvHnlRc1f86KbI9ZnetMeOkdSC6r0hoRDHNO03AUxapi+D
	uZYXnNW/SZwt/qCF
X-Google-Smtp-Source: AGHT+IF0+4q/k+zcJ3YTSndyNDr287UygKKDh0bpp2Ii6zW2yIPj7g8FEXDvGEP+fNpAXN2VPsFiO3yvV4ckDIx6k2A=
X-Received: by 2002:a17:902:f642:b0:277:9193:f2da with SMTP id
 d9443c01a7336-28e9a51332emr30166305ad.5.1759486152149; Fri, 03 Oct 2025
 03:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003092918.1428164-1-kriish.sharma2006@gmail.com> <20251003100309.GH2878334@horms.kernel.org>
In-Reply-To: <20251003100309.GH2878334@horms.kernel.org>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 15:39:01 +0530
X-Gm-Features: AS18NWC_eW-Dv_FT_W7Xy2UkifYVy8aGoVOn2CYcFPK0N5SlyvAcZV_zO15r_4s
Message-ID: <CAL4kbRPQrXxktcWH4Dm3JhcFTsJf8ZYiyQwq+=bt7pzzn7wqBQ@mail.gmail.com>
Subject: Re: [PATCH net v2] hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: Simon Horman <horms@kernel.org>
Cc: khalasa@piap.pl, khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thanks again for the clarification. I understand this is more of a
clean-up rather than a bug fix.
I=E2=80=99ll prepare a v3 targeting net-next once the merge window reopens,
removing the Fixes tag.

Best regards,
Kriish

On Fri, Oct 3, 2025 at 3:33=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Fri, Oct 03, 2025 at 09:29:18AM +0000, Kriish Sharma wrote:
> > Fixes warnings observed during compilation with -Wformat-overflow:
> >
> > drivers/net/wan/hdlc_ppp.c: In function =E2=80=98ppp_cp_event=E2=80=99:
> > drivers/net/wan/hdlc_ppp.c:353:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/wan/hdlc_ppp.c:342:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Update proto_name() to return "LCP" by default instead of NULL.
> > This change silences the compiler without changing existing behavior
> > and removes the need for the local 'pname' variable in ppp_cp_event.
> >
> > Suggested-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
> > Fixes: 262858079afd ("Add linux-next specific files for 20250926")
>
> Perhaps this should be:
>
> Fixes: e022c2f07ae5 ("WAN: new synchronous PPP implementation for generic=
 HDLC.")
> But more importantly, and sorry for not noticing this in my review of v1,
> I'm not sure this is a bug fix. In his review of v1 Chris explains that
> this case cannot be hit. And that the patch is about silencing the
> compiler.
>
> If so, I'd suggest this is a clean-up and thus you should consider:
> 1) Removing the fixes tag
> 2) Retargeting the patch at net-next
>
> Please also note that net-next is currently closed for the merge window.
> So any patches for it should be sent after it reopens, which will
> be after v6.18-rc1 is released, most likely on or after 13th October.
>
> See: https://docs.kernel.org/process/maintainer-netdev.html
>
> The code change itself looks good to me.
>
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> > ---
> > v2:
> >   - Target the net tree with proper subject prefix "[PATCH net]"
> >   - Update proto_name() to return "LCP" by default instead of NULL
> >   - Remove local 'pname' variable in ppp_cp_event
> >   - Add Suggested-by tag for Krzysztof Ha=C5=82asa
> >
> > v1: https://lore.kernel.org/all/20251002180541.1375151-1-kriish.sharma2=
006@gmail.com/
> >

