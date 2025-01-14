Return-Path: <netdev+bounces-158204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E34A1100A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FF83A3958
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61241F9F52;
	Tue, 14 Jan 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="LhB8R78c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8AB1F9ABE
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879244; cv=none; b=nw7ZXSmLVdFw/l8l1i/KiP+zEiTdDANcSCAVSMtqndj8vc9GyYFT9M623XtbSZInHbNF5Z3W8+YaVtZnuFbehqTYupm/KVPp15D3oy58XIUEjkSdClPs6LOHhk3lZ8SlQEZFes+Z8GNicio3yNV93VSX/DGm/zdV51b5qxgd9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879244; c=relaxed/simple;
	bh=gFX/hSgD6xlERsUSwDU88YNN4OdYQrBc3tkSLHFV19w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh6AsrkiHWrHess8TU3qdK2Tf0C9ZlWAHqGBF6edF+o+zW3mwQEDBdIFMVhYaeyNHn3Hoj7ADQ+RDGcAT1L2gTZ4HTz6I4pKN3XuI5a7+tGeO/uZ6SFMyOipEmQftkkOOZ97pRwmK4S8tkGtO9gI29udoKuoIe8yFbbt880cYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=LhB8R78c; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e46ac799015so8054300276.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1736879242; x=1737484042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37oFeembf54G6UbQrt4LG/htk4F1TzMYX0t0x14AnPY=;
        b=LhB8R78cJPB065D9UZBSycBoTn5nDWpHjhhOrcPdiTo8O0vMBDpLNm2XS7gWiTHq0m
         xEiK3ojRqbBjHO4p3FBuU8PN11I+tzuOM30uwyQrvtPN9mLAELlBg7PIoDwFlJESGsqW
         rasJGvZKtGqNkKm4ZPpPDv29nQq+uGa309c+iLFO0xPY4iTz6dQc7kEf0QM4jit7kMfc
         Hcvtq3OZ5EnzycrGiokzaY4dQBxvuyuovaQYttY7Kw83dUg1yUm4NYpcYD4wZHH8JPSv
         3ArhTKtF2zPXOmwyMZUdV/mi6mlRVG8Tph+lFLaHCFc95ga94kQda9HHyAS5Ng3DtQhi
         +hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879242; x=1737484042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37oFeembf54G6UbQrt4LG/htk4F1TzMYX0t0x14AnPY=;
        b=cHMwzj+ISAVreQkAa1D2z7oJ1Z+5AoZ1x8YJ+9kVwP1nNapEIB15V9o/2ZD8wqYFhc
         jd/2sWCi00KEYFaXENzlrfb1wIsJZVFeqomt9E3lPTf6yhG4hDb0G+noIt0YhXaRv3WU
         DAYZ6klmFlr/OnqRZAI947Gf1l9O26i9Sz5zRmIB+8Ii3HLFHK3jV7Er0mpnB83VCI0A
         2RFVjo2OWtSJUKStnx74x3fHCOiwgk43jHo5byIVC+os0fUP8D2SPGaF5RP+JbiKL4ec
         uho4p8LcuFsodxHVZADq0W5pEu1FYlk/8fSo3hCo3FdSjQAtQEbgPNrWGOkmB/JmyGlG
         Yqbg==
X-Forwarded-Encrypted: i=1; AJvYcCWm/ZwHvvTBgEYTAIJtHIxDio7b4ubkxtEjppSygLY8wkCkEFRRGdLpUlbsQq4HqtNvzStlfug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kgG+TNzgnu5NKAL9O71G6Ub5jwlYzcGgR87AXlaRX6CNoCaS
	r5n3fy534uR8SKzFKIVNY328uHyWvpQDO7N6o72bYzVBXmkWkVpotOt1ydXsY4U84+v2yA4BQ24
	uvQcqTxFmt3LgPEAesaxyZkQ8ovnixrZ3kjF8bA==
X-Gm-Gg: ASbGnct+NWav6+9+FFCfQbTy+RGRbl2nKlCrJPCwZpomC2KWCyucLa0vQ5xllRul+pG
	vEvWQXNWCDgezlN9QaElwQDLigf4Y9d3IZg/QEg==
X-Google-Smtp-Source: AGHT+IFT++ovz/7G9q/aOes+nb7635aB7y6TffMWRHaKG5kG/Ev2u8YWJwfikR3zEg1HT5ppEaaWJQ7okK1qC6LjxKY=
X-Received: by 2002:a05:6902:e10:b0:e57:4b14:6fdb with SMTP id
 3f1490d57ef6-e574b14720fmr8624218276.34.1736879242256; Tue, 14 Jan 2025
 10:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241213000023.jkrxbogcws4azh4w@skbuf> <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
 <20241213011405.ogogu5rvbjimuqji@skbuf> <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 14 Jan 2025 10:27:10 -0800
X-Gm-Features: AbW1kvabiu65H413mJgHD7Rs_jEwnqBhK6Ve2bPRQzP4LAjZAjgbQwa8FGA1-4A
Message-ID: <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
To: Arun.Ramadoss@microchip.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, olteanv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 7:29=E2=80=AFPM <Arun.Ramadoss@microchip.com> wrote:
>
> Hi Tim,
>
> >
> > Arun,
> >
> > Can you confirm that prior to commit 331d64f752bb ("net: dsa:
> > microchip: add the enable_stp_addr pointer in ksz_dev_ops") that packet=
s in the bridge group were being forwarded to all ports and
> > that the intention of the patch was to limit them to only go to 'only' =
the cpu port?
>
> By Default, In the reserved multicast table, the forwarding port for the =
mac address 01:80:C2:00:00:00 (BPDU Mac address) is 10h. It means, the STP =
BPDU packet will be forwarded to Port 5. However, the CPU port varies depen=
ding on the board schematics. Hence to fix this, forwarding port needs to c=
hanged in reserved multicast table.
>
> Procedure for updating Override bit:
> -  0x0424 =3D 0x8000_0000 | dev->cpu_port. (0x10 for lan9370 and 0x20 for=
 lan9374)
> -  0x41c   =3D 0x0000_0085 (write, reserved multicast table and start. Ta=
ble Index is 0 which is the index for BPDU packet 01:80:c2:00:00:00)
> - 0x41c =3D wait till start bit is cleared.
>
> Let me know, if you need any more information.
>

Hi Arun,

Ok, that makes sense to me and falls in line with what my patch here
was trying to do. When you enable the reserved multicast table it
makes sense to update the entire table right? You are only updating
one address/group. Can you please review and comment on my patch here?

Best Regards,

Tim

