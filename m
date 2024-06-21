Return-Path: <netdev+bounces-105748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F891299E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FC91C2115E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625256EB73;
	Fri, 21 Jun 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdA6/ShN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F42C859
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983691; cv=none; b=cSuLIKu38QaiFLVXsU/v6Hqfckla9TiL5azK0yNnET0GlLsAnDzDQqHououSRXyMYKv3FD13z/0K17D8ntvvBEC7MZnU+WTWOFhzbMk/RmYEYbcDBjN8Xl9qucw2x4adO2NtGHyhLPG44PWXDsqGBRvofA2Jo9euk/uvKRAk1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983691; c=relaxed/simple;
	bh=XWhccMxdPEnx/xygHba44CLYkJQu3Zhjqy566Ua6vHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+WTSqkhWySchd6kI0cjubxiaEjKpWHT/Q0vgUmE7003a16f41cqnOn+M0spE4DU6lhEENWfG1r5gxIUhhwSz/ceT0FY8EKZXdtUtsjX3mQlbbubLFPpAWJfN8he5nu0nxRHpekAMgzhuOBenMrYYw/rkPtHbUPcv5np5oROJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdA6/ShN; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d516d3f0b2so1281736b6e.1
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718983689; x=1719588489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8gXzhTEGQ8ivMNc5dOHdR9y1ckP/amgAWWHRCHQ9n0Q=;
        b=OdA6/ShNM92gweo3an+RQZCV02J0n5/P70LCOIcZd+rIs1nK6Gv69yyAvpwflytGhq
         hOKDJyv0cF/ouz2cdJoTBUkxdwpBV7LyZSnUtO1o2gXeoZn7a3nZMpfu2gb8ovmySrhq
         bPCuo1JD6hKA33EaF6n0mzquxm+DukkDN5/2v0BRJTkKP/xx0HhQKJvDlgiczUzH7Hif
         7zBwI5mMzEv3qcNO4V6K/QMWXbR2Azq9QfpgBKd526ikJrg5zkXSunL6ccCXxp0ketH6
         zqRocK4QtIME2/N4mmjHbnmFZmdHHVlkru8FpHsh6ZLXTsnc7ISzSB8aFpDNWEgNeQri
         2XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718983689; x=1719588489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gXzhTEGQ8ivMNc5dOHdR9y1ckP/amgAWWHRCHQ9n0Q=;
        b=UFQIWUzt2wblbD+eFifgup7v6A0ZoYL0tY9lTHOIROhPnYi2jvJfI8hbdA01v+YI4/
         eVVPF/b1p97b+JRA4JuOC5Gs2AmGx/EF/S2MF6k4HBZ5wPLDUwCkX5D484YIhhuO24bH
         o5yHhjfb/c4I23OywYprocK9ZT/6GePgNBC0qU+DdvsrSv6Esup0d73Q1v2jUPiLDOeG
         8pcK+z5+AOf19tQgmDydq9T9jJx0CCP0HCgWRFsCrWFtZDaTET1s4P01XI19QiKOPLji
         /YY38ExTAXoxIKExc94JmCGVPg39w0xSDLkRIMpfoUsY0kevdbUdOmJW7ta0mKDS+Cq6
         DQWg==
X-Forwarded-Encrypted: i=1; AJvYcCXNfSJ9J3qICsH2OuaOzXrVK0ZGrsf80DtUGoZUJHi7Pp4e6A8RMcWoc+tIKr3Xc+E5MvGcsqZSt6pJtTCpv9AFgOaI93iA
X-Gm-Message-State: AOJu0YygodnSFRpeIpHWFuSzWLsMh7/nhDSJD3fVFke3z3dY/8s3CWSO
	bDB3W1ZaQ0MBE/49j/EjH2ZS21v+7Fw0r5/C/1WfZT3r5DvTSoKnI7YQRF2fzZr0cEMIN4pAiXr
	guowGki90sfX0ZqY+11HtpdF7KqO2Jg==
X-Google-Smtp-Source: AGHT+IGnnUKC3MLNMMrleAKtiYbDiEpVu9zRKiSlQj1CtF2KHXakdyjYbpK8MsWO/oGKXTYYrv+ZovmIrHt2NIcSNOs=
X-Received: by 2002:a05:6871:3a0c:b0:250:7a43:af05 with SMTP id
 586e51a60fabf-25c949ce9d2mr9774376fac.12.1718983688860; Fri, 21 Jun 2024
 08:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621161543.42617bef@kmaincent-XPS-13-7390> <20240621081906.0466c431@kernel.org>
In-Reply-To: <20240621081906.0466c431@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 21 Jun 2024 16:27:57 +0100
Message-ID: <CAD4GDZworgYs12TArypDvTCqU7_FB7V-+vxhe3VbpQVEHSdutQ@mail.gmail.com>
Subject: Re: Netlink specs, help dealing with nested array
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 16:19, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 21 Jun 2024 16:15:43 +0200 Kory Maincent wrote:
> > Hello Jakub, Donald or other ynl experts,
> >
> > I have an issue dealing with a nested array.
> >
> > Here is my current netlink spec and ethtool patches:
> > https://termbin.com/gbyx
> > https://termbin.com/b325
> >
> > Here is the error I got:
> > https://termbin.com/c7b1
> >
> > I am trying to investigate what goes wrong with ynl but I still don't know.
> > If someone have an idea of what is going wrong with ynl or my specs it would be
> > lovely!
>
> You're (correctly) formatting your data as a basic multi-attr.
> Instead of:
>
> +        name: c33-pse-pw-limit-ranges
> +        name-prefix: ethtool-a-
> +        type: indexed-array
> +        sub-type: nest
> +        nested-attributes: c33-pse-pw-limit
>
> use:
>
> +        name: c33-pse-pw-limit-ranges
> +        name-prefix: ethtool-a-
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: c33-pse-pw-limit

Ah yes, I was "fixing" things in the wrong direction. Sorry for the confusion.

