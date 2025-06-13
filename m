Return-Path: <netdev+bounces-197254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D0AD7F5A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1645A167437
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780E1805A;
	Fri, 13 Jun 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3ohBsyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5DA926
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 00:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773025; cv=none; b=kIlHlN9ZYuM0g6n0JXx7jag+hbu5owknY2rAI73zmU/TwjJonoP6qYN85yqLsbiIk7RE20TNGjxo6l5l3mLJfQc53crOqfWQ6sTVEzXoijhhK+didMzeA9xHkMp/HI/6MV1yqMwxMoGZboa4VL1WOp3lNn1+pv9VlU6KkDblz50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773025; c=relaxed/simple;
	bh=pzH8pMXUcalp6pDfuzsK2/D2VK/1SBdaD4K20Qy+vNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPgMo1pL8dlN1dSocvfVH7rQdDxvXOMkdWmkwDFy09BnNLiKd+o5+TKmledGAG9R7QcVIeX01yDq2MN09k5w6RTr3ysR3R0aTcLz8+qcGRSLpixrEBVlm73gKNxhC6W0MijRtnx1f0HkRQZJuqQv0nF6qlRG24PYFA9y9AUSvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3ohBsyk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55350d0eedeso1433194e87.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749773022; x=1750377822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzH8pMXUcalp6pDfuzsK2/D2VK/1SBdaD4K20Qy+vNk=;
        b=R3ohBsykmXpeEX//EHoia/Cbn50mv2FL2fOoz4wLFsdblAa9Eqvp5ziDxdL9DYvjMd
         xQWB3GTSQnua7MxxuE/jjj00t3vSmJfXuCVCVIWWP3ogWm2tTC76XdrUURU2jJlNEHpf
         qMPz4zb2BI93nMi3QJFvv/kQ47HXeyiyVyZ8htiztBbge62bLni/GqNwUqvrjjooa7HS
         5LZDQXZbARhvYOUPL1nV+cVVL5GjV6jYPXnDfuzZVoLmfTDEWUiIdTWsBJMzx+cPejH3
         o6X0ium5r7HAuVatROrOLRTgt+hs5tBguGP2mGSolteWzApQrVHBYFX504C4l3g8HfYv
         tFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749773022; x=1750377822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzH8pMXUcalp6pDfuzsK2/D2VK/1SBdaD4K20Qy+vNk=;
        b=gulBW/fYnRJKFua8X5kQRQ46PqhVdjC6pXMWZ3i57s3RH0swqnSfVtvNPjNYJhU2Yx
         13tKA/x6zc2HZYQ6uqVPFFgCVMdCdAAxZAKbV294TEVoZmqR3rCADN8iL44FrDr73STg
         WoCw2XU3sbBo12gx+FrpmZlslpl6etfp373hkQyukW7RDWg1abGhXJMVJ/ymiioG7p47
         4mP6PTXCay6vCz5Cw+vluurKWC4VCDRSY8BspimpeI8dFwexFOuJlDyT9fagsSsrZNLc
         RhBA7oI2lzt8urJQYa8giIQ2UCDkE3pbW89D4ciPdcIwraFFHnoVAnkFGoRk1aA38Scw
         fGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2sNdJToIR/BbOU0nNMqh16vpzrIF0dx3kDregR+yphm9Y9/ckWg/SztIuigZqyJDUtPQff14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtFZWCAnpT8V/XPGhK+Uqdi2+njKgsaKhtZTv+8CiBRTZxByu
	DXAX3Oi/AmnXoR2caomB0Q70FQv/6WnpkgMsaFhNPcT3roiGZjru7vf0uibb/ci5pi09V85v3y9
	Te6XYEW3a563YmiI5R9Xr493nO4qjD/ci7MV2tD5vRPukaZAwhM3ZWtE=
X-Gm-Gg: ASbGnctDg+zfrNefUHyX0k7w4BLb0Nvgpk8MO0uaEz49EgzbyILEB/+qhWkCFIMpA+6
	rCYVlokp5PX5Pavoq9Lg/PSSpisM8JaSZ1R4kOYocyxVrUuVYvI+zIP7P95m/FhOPMnZLw60zz2
	RNjKx2rqxzWe3pBgWKeREesJEm7BkEK//bJzBKrPx26GqcVBcdUQ0P9AxXZ26rmWQaz8iXTZU1b
	kpLkZVY2wY=
X-Google-Smtp-Source: AGHT+IHCryRchnM7kCKhNYJZSBNu7zRh8pUHzqHQ0apcweZpI5BCqRoJWSeLJsU3qoa5bR5qdbcwHv+BrtrUbRsXMC4=
X-Received: by 2002:a05:6512:1381:b0:553:35f5:7aac with SMTP id
 2adb3069b0e04-553af9bbf01mr179570e87.48.1749773021612; Thu, 12 Jun 2025
 17:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083025.842476378@linutronix.de>
In-Reply-To: <20250519083025.842476378@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 17:03:30 -0700
X-Gm-Features: AX0GCFvdBUhjhbTIICZQJsoZZ6tQWm4NpoXbd06TKsPSSSZ0mvn1EVyJNHREOXY
Message-ID: <CANDhNCoqYhFNfuyArrt0Sj7sWoLNsVJUn7YCUuxEL8nFrZPHog@mail.gmail.com>
Subject: Re: [patch V2 04/26] timekeeping: Introduce timekeeper ID
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> As long as there is only a single timekeeper, there is no need to clarify
> which timekeeper is used. But with the upcoming reusage of the timekeeper
> infrastructure for auxiliary clock timekeepers, an ID is required to
> differentiate.
>
> Introduce an enum for timekeeper IDs, introduce a field in struct tk_data
> to store this timekeeper id and add also initialization. The id struct
> field is added at the end of the second cachline, as there is a 4 byte ho=
le
> anyway.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

