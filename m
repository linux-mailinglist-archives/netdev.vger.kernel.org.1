Return-Path: <netdev+bounces-226908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4384BA6101
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 17:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2AE4A3EE8
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607332E0B79;
	Sat, 27 Sep 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZnKgDOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAF4C9D
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987286; cv=none; b=rSHMonbfmT8h6mcJMHyFpEsa/fRGAumQnWD+CDIRYadLcs2n+jNaxUGWEOeqgOwI77aQrHn0MkND8Oy3J40cBW6Tk5PXayj/QQYDt5BomwAParFTOvduVnu9g2wSMWpnOoHwiHMlGJmgPq/b4ZSWfdyVSvKn71p6yL/dRKTogIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987286; c=relaxed/simple;
	bh=1NyzohdQmVFa2JZ1JpySWMhbjvJCfx19LHiQMzBXbeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsRRleSZnJYksn0VihHEE3WRodfwZBgy0gQ+q0hyPxYrx01/q0OS2yfwTr85RelhRuXy2A8mWjDN8M1oX6x1M7XbXMIGSeTApWH2s/y9E+Wi0Mf77GIYOwYrfD/rRc2bgHLq5XQ1q/UP/kBOjy3p8u59z3JP6WIgOfTngQr0BD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZnKgDOm; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso38048431fa.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758987283; x=1759592083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NyzohdQmVFa2JZ1JpySWMhbjvJCfx19LHiQMzBXbeE=;
        b=fZnKgDOmNO2+q7SF65F9Gc738TakS4nJA3T9Evx8SbZ4DhWVrMtKdhxRMqTn4ejzFf
         gXRI+n9NTRaKEG2WPjSyw4e3Q+fJcfj3ob4YGMgR6eZW+0IuI5CWqgqWhkOZmy/sqfuh
         o82ZaZ8146fFIvYWVUu58cntuMAMOdZ785G8NUMP6/kOOs+rGM7Wxz6iiVYBsLlVzea2
         CFdxnYmRPErVbT1dsn7xzMZs0pOZE6X5cQWyijmBjNsGWycEuvxPNMhIkd+59F7e0ZP3
         CEA79gCYvLr48wBG3TaOx2Zs3T4CM8gLJibVcA0UyZ8ijnNeGwM/FiRaE2md1yuGq0Q0
         4BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758987283; x=1759592083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NyzohdQmVFa2JZ1JpySWMhbjvJCfx19LHiQMzBXbeE=;
        b=e5AVrDbdjogLIwUpoWqqoUkJA+yroTi9GlcfstEuail6xTDcT39Cf16PIRu77+GvAU
         csglJJfI+0iXJ+zrstcRbLSUHebuXtv70M+85dFJ2hUXM7I/2zqBNmRg5m5VeBTz97Lw
         XiGYfZMPRyWcUZeSVYG4A8XYy62eaz8YRk4lX5ChiQPrm2AeJxvK9hL/aj+J6iBoSXd2
         48T44RrS0iCNPsGnggcSnVGu8y7FOHaVFWHowcE8a9X7TaE/tbzzE+XDpYdI8CrHrLbt
         Z+EhjpyO8xk+Iqp7IcBdGDXqJ2DdAH92rt0LAGilEfg00GUD907ZvlTTwZaFha5IuPE2
         sW8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgHyHJpFTHzfLEMRNqCECF7PpOkYpbaoHhR/0FZi8ONHbRpeXvEBYk41rJv9Y9aNeXUGOMEEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxams0dEwbZqc41cluPnk1OMJlfzwMnQgcGMuMztz8dN/YZdX4G
	jMDBibXBmkiGRCffAnEsBvyzwFh4EFDiOPJ+ynYDdx/W7tEfi5H2otDHDHi/rKMd6nQ7nDt9OOP
	R959pvfWq3v0uEr2FXw82mJqBTtikZX4=
X-Gm-Gg: ASbGncs1Na8yxlqoI8kJkub97TGDLutWGS7JsbOaw/xVEV5m5LKJ/1U9wKJgGxtC+uY
	1gaCmmoVIINKRK0zUyqK9rDhIe+RBNQcknRbx2UFBR2iaQWj8x0TDUv44OIt4vR+Mlvjlg4MT4/
	CC5+sZtlQ2pkg1bacWJzfUofmELLoZiJTWN6hgmEcGe8unwyO2tYwK0v049uqpk39M3FnvFQRXh
	xnhkrkzvowXKQCo
X-Google-Smtp-Source: AGHT+IFIV8oIu6Oj1Pp1lnbMHoF9GdCsUDzDv0uNr9W3DhIQe/zD2dAbhVOoRTo8GVxP6GDf0o+SLlO/CQEr38ubHyQ=
X-Received: by 2002:a2e:bcd0:0:b0:36b:9ecc:cb5a with SMTP id
 38308e7fff4ca-36fb24aa72fmr33790481fa.22.1758987282373; Sat, 27 Sep 2025
 08:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925145124.500357-1-luiz.dentz@gmail.com> <20250926144343.5b2624f6@kernel.org>
In-Reply-To: <20250926144343.5b2624f6@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 27 Sep 2025 11:34:30 -0400
X-Gm-Features: AS18NWB27mOMiB1EngWQFWE_xBLp4JBJePuK0Mn4tVah9yp5rIMATLFfal63ZDM
Message-ID: <CABBYNZJEJ2U_w8CN5h65nvRMvm2wWHHRng2J8x1Cpwd8YL4f-w@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2025-09-25
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, Sep 26, 2025 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Sep 2025 10:51:24 -0400 Luiz Augusto von Dentz wrote:
> > bluetooth-next pull request for net-next:
>
> I'm getting a conflict when pulling this. Looks like it's based on
> the v1 of the recent net PR rather than the reworked version?
>
> Sorry for the delay

Should I rebase it again?


--=20
Luiz Augusto von Dentz

