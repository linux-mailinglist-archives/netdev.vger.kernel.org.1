Return-Path: <netdev+bounces-163434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE3A2A3B9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DB01884A3C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54C1225798;
	Thu,  6 Feb 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuKejry5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86F22578E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832343; cv=none; b=hyYeIW95dKq8hYwHRqb1J5G817dySjT2op72K4LFvV+cE+oBkBvcyJ/TlPlHaZgXVDbqwqxnqKblLmXYzoBu5nxSB48PTk77zaO/bLaDga4KjFcKjt4P/qhk3HNE7K4OpeG8R4AB5g2lEGiCHWkfCRCb+MLvpF6qmxIG9b6Fy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832343; c=relaxed/simple;
	bh=lFob+nyO85FMtuM/16sJSwE00zhLEz3M48kxSIhvbFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvWT7+uW5y0Jm7uKhMUUqK3qe3Itv7YkPL6dJIdKAzqR43iXBPhPgCF0Alp8MLfmooYcodbfRe1WCCPVJs/z8bWGtU7NNwpPRLRvtTrCqPHzH7Xew+tn2LVMQWi0rtMZ2U1tuA9qiORc9e2+6DbYd6vp+pYimbXMLXyubKxrOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuKejry5; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4aff31b77e8so216399137.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 00:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738832341; x=1739437141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFob+nyO85FMtuM/16sJSwE00zhLEz3M48kxSIhvbFE=;
        b=EuKejry5YPHYDY8kPU2I1FCU8ZE1gJRjKlFlR9Ry3RYAKmSqjVUcPCA0Wi/wBi9tRz
         NHlr0rvzMdUb661TsLQgaVeWXUJukiCpH+Q1keyDNwM88kWRJKJwDGdeeQh/J/urwG53
         D/15tXHX74dhUiIcvCvZqZwIszDrj2R05KI9NT0y5LY92SkI38pvnMa26H0jQKjfOvpg
         dKvDA/v9qSjD9zsMWlWVdBn3y6BFOHZr2jfF4E/wodzx+rsgqQA7iGFngwY39N/Ld16S
         a3vde0b54FCzbDSQLnlXt0F4j8l7F/xIiev4pFr5F4p2Lyl2ruDqsz6fSxm41aqmcUy/
         M1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738832341; x=1739437141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFob+nyO85FMtuM/16sJSwE00zhLEz3M48kxSIhvbFE=;
        b=bdpNVZNYHQ3TGMl12KTWFyJE9pONNT2Flb2qPiRgpV+AXvud12+ElbX5PxU4LWSPC6
         267PB3qdvrZ3l7AmDDKCh7EO4aB53/ZqENQLP19CfBUvdsmTRqU+L692H95vMNzDM4+s
         nCxXJoP0DDfhgZmJLuCLDIvBk6U8No8cZmMi8aKnandwythaXexXdFoAkg6TI8g0u6q7
         OyJKWKiKD//NWfraWkJQMNRIGX46ohoebHfumvDx6/BSoJ3Z42zKdRbUQsYDQHcswLvz
         DaKe9HqENimrgduS1oX/JBFxJHk4Qx6eraQ+NaMbExiAEylKfyO6GsMdOKAH9GaZm76N
         CuSg==
X-Gm-Message-State: AOJu0YweEMIvQqbgDM67INLrs9TtPG1+N/J/DiSWLG/MM6uP4k5oRHyi
	R8ofM4/whTQFhwB1ZreaNvAo2/ZWFgkP3N6UkULUU2832E7tlrRvsXGE6nXM7FlTfQwMQzXp2NQ
	yUZ5VmJh+XAr9vvacOcbraZ37nD8=
X-Gm-Gg: ASbGncs5E4y5u+DruR3D6M5FZLX8D5NeSSFbLOiFig1B+76Q5ctMqAaEkp/1tlIqxfe
	9awVBkB8CP8T55gyp/xbqjLFlUaeQ0IWPIhheKB+QKZirPS1fcWplK+3DRt9cp9XFN6l+tH0=
X-Google-Smtp-Source: AGHT+IEsvbtbIivN1zUAi/xGHgQ3cR2XKiVdaU3AJIww/CQk48pZ09/yoroZASkmSw3EA+mhfsE6nc7QojJ+LfFc7NU=
X-Received: by 2002:a05:6102:4a8e:b0:4ba:7f58:d526 with SMTP id
 ada2fe7eead31-4ba7f58e50amr34396137.17.1738832340989; Thu, 06 Feb 2025
 00:59:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZtE+qmv94hQgpiWtBFvG7tOdngao6Lxkrw-3Ry-fKvvSA@mail.gmail.com>
 <20250205172940.2a48e075@kernel.org>
In-Reply-To: <20250205172940.2a48e075@kernel.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 6 Feb 2025 09:58:50 +0100
X-Gm-Features: AWEUYZkEFwHe1g7Ld7JtQTFg5DXONPmXgHzflL6tBpiy4pT8c_mJqXX_AFv2Hyg
Message-ID: <CAA85sZuVjaqmZaQp3+vUOrz0Q0nQYzUJf8YWzJwk7vWBw3xung@mail.gmail.com>
Subject: Re: mlx5 - kernel oops on link down and up?
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, saeedm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
> On Wed, 5 Feb 2025 12:49:17 +0100 Ian Kumlien wrote:
> > I have two machines at home connected with two mlx5 cards - 100 gbit,
> > for testing things like rdma for nfs etc
> >
> > They are directly connected, so no switch is involved.
> >
> > So, the machine on the other end had a bad harddrive - so it was
> > powered down and up...
> > To my surprise, my desktop broke in the process (network traffic
> > stopped working)
>
> Should be fixed by 979284535aaf12a.

Great! Thanks!

