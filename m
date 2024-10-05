Return-Path: <netdev+bounces-132323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C86799136C
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 02:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C4828410A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE5F196;
	Sat,  5 Oct 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqAOnz5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C585380;
	Sat,  5 Oct 2024 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087241; cv=none; b=jAfLPCZKSiuiWrealsL/PgBYBK+gz7Q0WCvLXJCEHeG3+r/wzamCylvkPbm4w3Gw0RGr0SeLW3PS3o2bS33PyvVHTP1u4KQ0AzMNEuzvVg6am+geo14i5Q416AH/FhGrVZ4Bd0XySIAb7e9GDhvRmy2wWcRFCC8URgTNYDg0JoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087241; c=relaxed/simple;
	bh=j3PuYQMjZeJHIKznjn3ld8bBflbtCxWoP0xDEqWE7sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ax0nt3ApYlvl83eJLOHMle9wPqmc6DoAI8s+6eTrtMghGceDCLADGAqSkpWE2GqUi4RkrpSfqxbsbMAf1KqFjeU3c5kTofovcDWQAXTWOk9KisDEdt6+xLp4F19GaEpz7C2NMxuQTt5em13eiz42kFQU8dy2U5ENoXtlPmKipkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqAOnz5j; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e25d11cc9f0so2237423276.3;
        Fri, 04 Oct 2024 17:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728087239; x=1728692039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJSDzEKcDDJXpDk+O6gVhu3mMigXo2HqlSDo65WIbgE=;
        b=bqAOnz5jtwN85Uohkwh4/20qe9rEfOQZsNiTVqrO+ayS88lT0/8PQtNmm4RyYAuMl6
         scA4TLuhNGqKRxvmlDZ8vzgM/Z6tSlKqDvDlhPydEMg4iZQ4Eo6XYyKWixXJMaqwliBp
         yOnTCo/4Zlwr3XzPIiPYf9foMDdH8sTnsQVwCHWn+xYRili2Mb1k277wQWUD7R5XfM/K
         gbhyriVg03L1igiTKWeEEn7gfOKvchg/hHpkqCsqlBowuCKat0r+9Ruw/MwJT7EkBi7L
         inPRLgVQo7PPtIAFODbOHFzkBQ8XscE207CvkpYcc0VLmDgIIoA37B03OirQH+C42UJO
         1i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728087239; x=1728692039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJSDzEKcDDJXpDk+O6gVhu3mMigXo2HqlSDo65WIbgE=;
        b=Eeim+/qo7Nf+h0YjgOajLNj5nppHINyfKoUYRSSwUc9Pqa237/d31pvZvapE77Bv6U
         GCdYciKLihimgK+ubEbeSKK5DttCXqQ5TemDu9APeljvQqE2RAJ4maV7ZXO2KR//rOAi
         NtcQ4N+jM/0ClYOI5PYaHb1TWi2LSj5UDQaJr45aUbVvjFxh9nSazrlg9QPS1wKPGU3q
         jxzaUP3364XUAvdy/nqtF/4U/2PXb8EGAOVYuA7li50Cm4XFN4xlQby7HQKxYHrvIEge
         238Y6sReAEQP9sDnRARwISxui5fZGMPYWMzIR/OLEWoR0vzag5yD53sQtsZKvDSUoXky
         Mr/g==
X-Forwarded-Encrypted: i=1; AJvYcCW3mBlLbnFgh4LD75Aa5IZmem53GP75+jjjJUH+P0OJOehmm3topSr0dNlgvDFiPXLhOy8CLZzp1mRop+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUnjr/6B0H9qhdvcdOBlOyYamSKQ6GeVV+bALO4CROn//rrJD
	QKJFNzPSUDxzAG9fc3OxbuEm1y0iOhW08CfnNMVMA5JGfE1MHm3MfbuDHXRKHCSbJBwFT+4lKIr
	bjI4teRziZOaChvVeO52X9i+MYz8=
X-Google-Smtp-Source: AGHT+IEtEX5BXyLXU3Tg4jopbzm+fgYfLSPMUTHgJDb8NIz2yHRaXoaMBtfhpVA2IBAU9Kyarea1ztCPSgHRrDiR/FA=
X-Received: by 2002:a05:6902:154e:b0:e25:abb9:ad5a with SMTP id
 3f1490d57ef6-e28937dfc0dmr4327532276.34.1728087239011; Fri, 04 Oct 2024
 17:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003021135.1952928-1-rosenp@gmail.com> <20241003021135.1952928-7-rosenp@gmail.com>
 <20241004163433.79ca882c@kernel.org>
In-Reply-To: <20241004163433.79ca882c@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 4 Oct 2024 17:13:48 -0700
Message-ID: <CAKxU2N_JZB4SWSZnnUHgHrfyEHWVDg25bFvvojqBxQ-U2nrZhw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/17] net: ibm: emac: remove bootlist support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  2 Oct 2024 19:11:24 -0700 Rosen Penev wrote:
> > This seems to be mainly used for deterministic interfaces. systemd
> > already does this in userspace.
>
> I guess.. but what gives you the confidence this is not going to cause
> a regression for people? There's certainly plenty of machines with
> "stable naming" disabled. Whether that's wise or not is a separate
> question..
The ultimate goal was to remove custom init/exit functions. Although I
could just move all of this logic to probe...

