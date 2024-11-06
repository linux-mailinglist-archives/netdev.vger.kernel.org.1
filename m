Return-Path: <netdev+bounces-142337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C69BE547
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB42B24A35
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A571DE4D4;
	Wed,  6 Nov 2024 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drSOzEtd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669631DE3C3
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891461; cv=none; b=evR4JLWOdWcEGUBSW9O+3+cm0DLbAPULAQZV9skPGc6v0SxtUu9NB5GY1JVLsOaMN39yCm1BiVh/iiGalQ5JvhKGYGZAyKchy8EOeEYtXZdnMb7KevKILMzsuqg5y8RWEcv0hgSC8talhi2TyeJ628ZETSsbY4s/ydflU7YvX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891461; c=relaxed/simple;
	bh=rBtPz5gG0rZNJwXUgyLqZ4dCXI2IdSj8GTwcAnATtVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhW1t6zwGa36VMbfps2ytbkYGor7JNxM92wtBmiCH7+fz8hVap43W2gVeBUHBtCHyS8I0PtxSy1np9r4UfRGVgXTEQhciYC4bdGkggb0yhIwL2gabXqY3CEmVT3bJVRWKDjroou0J2zhv7DvqFrGtrmjzLZuM4uriQQHYHURAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drSOzEtd; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso5788609276.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 03:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730891459; x=1731496259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5+8CEF8PGrkpuoZv09AoSuECiDMudOpJZwqH9DLQBI=;
        b=drSOzEtdIxeTSrX7HDaTExWznXs5M+LjYMlLF81564X2AQGyRhr0AH3qTYY1FonWCD
         92gNh4YLL5G4YnPHB219qwJWUEDP4ikgFlSMnLKtcIgrYRdUNfwCKxYVbYQU7paXQq0D
         X1QJvpJPXbBUbPc6McU8gFcpt07zlJDc8J3yaIVkgTbuach5b739mSK2KEeFvIDSVn4K
         iMS4nkinX7if9AD+gZ4Aab2oKhOCTRm/aQgz2bx1RmLvmJuo80wLyHedcjYN8QNmzf9v
         e7o7sWOzvejuiisWTJ3V/8zWXUo6gboLHEz9zq9aoNrQ3/Xk6BZmd1E4IwWINsEA+mOf
         RS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730891459; x=1731496259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5+8CEF8PGrkpuoZv09AoSuECiDMudOpJZwqH9DLQBI=;
        b=JqQRl1ASlzmT+RQeOqX1EW5qNbXA8VVIeNhAJEZPcXgaOZEVqPme5U4JGmCc0q8hAI
         2xtS2tE1OWoi+iLyU0VBbqow4yH42H7KvSbKqBU0mO7hePAHGF7R4rg1G6TlRwB0lLcw
         rI/wvXLATbm0sB+Rzkca8vsOTqafcFDKho84beY1H6eYusMwWoimKGdh+KtafG9slUXK
         VyOmdtKY0d66NDGNqTkAiqdhRo//RWUMPPOxhRBIq+0LkKwwhFa5hygs6Najoz0vCw4j
         rASkYKmpo8AM5kh9xKRy0ahJzUy/hQYp9cL25BFR/mV3Pw9e+h4/CpcTTR4X5M7+HJYB
         WlVQ==
X-Gm-Message-State: AOJu0Ywrg0DbY0K0xIhdiYTDxHjNbcvUP4zcmRGgmjDQ3d4WGSec22yN
	YwIFk4JdqxnOgu5UKdcAfzgfr6CP34SHE/7h1iV3uTHEBnlOqs7JIcUxYqN9WlMfErbzd0eCEtx
	dOkjafKZjMqIGr+fqEyYrJBSTmwY=
X-Google-Smtp-Source: AGHT+IE1sZpZbBwhB3vfOzE1oN0wLqnxcz1wrnDPvGC+Rpg+zy6pts2342ur4zYg+bx25KKddKleEKnBLApVYSKJgu8=
X-Received: by 2002:a05:690c:dd2:b0:64b:5cc7:bcbc with SMTP id
 00721157ae682-6ea52520bb1mr244627657b3.32.1730891459226; Wed, 06 Nov 2024
 03:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028073015.692794-1-wojackbb@gmail.com> <20241031185150.6ef22ce0@kernel.org>
In-Reply-To: <20241031185150.6ef22ce0@kernel.org>
From: =?UTF-8?B?5ZCz6YC86YC8?= <wojackbb@gmail.com>
Date: Wed, 6 Nov 2024 19:10:48 +0800
Message-ID: <CAAQ7Y6an8ZkxYpJehd8cBRPHjqyQofc6A4QdPzM_dhh1Sn0nng@mail.gmail.com>
Subject: Re: [PATCH] [net] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com, 
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com, 
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com, 
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com, 
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If the PCIE connection remains in the D0 state, It will consume more power.

Receiving or sending data will cause PCIE to change D3 Cold to D0 state.

Jakub Kicinski <kuba@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 28 Oct 2024 15:30:15 +0800 wojackbb@gmail.com wrote:
> > Because optimizing the power consumption of t7XX,
> > change auto suspend time to 5000.
> >
> > The Tests uses a script to loop through the power_state
> > of t7XX.
> > (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
> >
> > * If Auto suspend is 20 seconds,
> >   test script show power_state have 0~5% of the time was in D3 state
> >   when host don't have data packet transmission.
> >
> > * Changed auto suspend time to 5 seconds,
> >   test script show power_state have 50%~80% of the time was in D3 state
> >   when host don't have data packet transmission.
>
> I'm going to drop this from PW while we wait for your reply to Sergey
> If the patch is still good after answering his questions please update
> the commit message and resend with a [net-next] tag (we use [net] to
> designate fixes for current release and stable)

