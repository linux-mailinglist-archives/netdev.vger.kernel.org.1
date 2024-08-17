Return-Path: <netdev+bounces-119444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDA29559D9
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 23:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA08B21097
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7714F115;
	Sat, 17 Aug 2024 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgNK9BYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BEA9473;
	Sat, 17 Aug 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723930479; cv=none; b=X/qXb3Yi0Su9It530Ka2DAzMM6Rb5GET3FoTtTIYkn2JlKQZWwyIxgj306u85c2zz+E81Y2iaYgElzdpPtmobPl7i5X13vRbSK3aqE0XRdgN6Bd6NwPstipzP8cgopSO7d2FKcvgpj/2zwgrnF4e05rsgkY19uoWsgqrzEiGJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723930479; c=relaxed/simple;
	bh=K6MQKJJEBULWdnk40T76inGua7I2zour5xmmEN9Mon0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De0clbb7m7QAG9u8yuBoUaXfAsE/z3JyKg+VVf5U/Al3hJFisAXpLAC7FMLcfT7ed/bKcinqUCukT2sn0D1xVlpjhf9EXZbNnzy9xp/S8S6CfDIf96xCsRgh96YhJqMwMfQIICW2l8wTkrzQqgqeVd/8XE3whDACoDvTTJ4/oVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgNK9BYq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b5b65b1b9fso3979127b3.2;
        Sat, 17 Aug 2024 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723930476; x=1724535276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2USBcqsbs1UN2FTzMZ2DFXq4TbQQtiR3NN57//g9qYw=;
        b=XgNK9BYqknt+9E199ggoEEFBD1j/N+jpDQuq1BLXFhLZpQuFJByzNPpIWiM2kUc2Wz
         U3Sh2V8aRLMqW6qsxzVYTc/5JB9aBdkdhRGaMDWg+H+KicCYseOkHpspDrNu1KOUr1QM
         pfA/O7NMcQLyCQ6kDsYxnz5Oo2RtwWPnzOOC7Igaku7rrbL64nHWR+GiTSih5ORc1xbi
         xI4ilax8hDL0zErRMaMBhEl2iIl5SMo34QqrPzESSWBuZKt8DQgh573o471Lp5Wui89H
         kcRJSt2eZKttJ3SUUzQiKoXTTKG5J2cfXrcBozDOmtLOGG+k8Jx3GrnFuR9LjTNgPISp
         kgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723930476; x=1724535276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2USBcqsbs1UN2FTzMZ2DFXq4TbQQtiR3NN57//g9qYw=;
        b=K5LRkewGFCSCUKOWT8nDsNpsh6Kg2u62/+2THRgSGS6v4LV7zOogc+OexOt5Z0bIDz
         13kfd7+XnlxX9/w8RorBR7KDDINq9pystDpYN3Q/67MHaHE8Fo7hodd/TyeEqt+BhlCN
         TGemDZVZTvJ047q5VlPmsNhx6kxffibM4pbpxPelBdSVRXMtvdYieEPAcDa4mQU219yo
         ku/4l9W4QxY5Bdndf1jysLV64mgcfM0T08XzWGGKkuDDG8DsMOp2bpTjaM3oeIfMUy4F
         bWvuLyZtFItfhVyvsSibdzpUyGutjbCY6qhFw9l9F3LzDm77CGCmkXqrVscL1cu1Tgg/
         FfQA==
X-Forwarded-Encrypted: i=1; AJvYcCVMK5nrbCSBapupkLfdgMPsqAAnWFvDp+KpU0KjvjzjR88KXXkX1PyMNzyO/0Crkxjg7BAdCRF8d2JeK2TsO4UoHuUGCrptJh8Gra0Y
X-Gm-Message-State: AOJu0YyETOS8OMfSFoSJjhAiO+B9hob+7a4qpHozeYuV+S1zvUUa1tYc
	5/szvA9OOlHES0ImC87z7XFeG5o+ANfLvaZs0bzRBBC1BK+0joxUajRQNpuzuhHi0mgFt/G5zlI
	zLqZDzttl+vw+cRA0veVvSjidXTM=
X-Google-Smtp-Source: AGHT+IGslAtKoklOvH66TdBlhY0fFoKv5dAl/fVTxhr/9tzpaoHaUKVToWcsOH4ORMKGW6YfVZBv3c1cZlOtsNGlLEc=
X-Received: by 2002:a05:690c:6488:b0:6b5:916d:5a8 with SMTP id
 00721157ae682-6b5916d08famr24659417b3.23.1723930476505; Sat, 17 Aug 2024
 14:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816224741.596989-1-rosenp@gmail.com> <981a8ff4-d4f3-4e1c-8201-d7331ae29f96@lunn.ch>
In-Reply-To: <981a8ff4-d4f3-4e1c-8201-d7331ae29f96@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 17 Aug 2024 14:34:26 -0700
Message-ID: <CAKxU2N8CPgfODgsRufcfTg6MjnXCTgqGXv5cTqZjrx7D9ACURw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] net: ag71xx: disable GRO by default
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	o.rempel@pengutronix.de, nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 11:39=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Fri, Aug 16, 2024 at 03:47:33PM -0700, Rosen Penev wrote:
> > ```
> > Currently this is handled in userspace with ethtool. Not sure if this
> > should be done in the kernel or if this is even the proper place for it=
.
> > ```
>
> Comments like this should be placed under the ---. If the patch is
> merged, anything in the commit message under the --- is then
> discarded.
Well, I don't mean for the patch to be merged. I'm mostly trying to
get feedback on it. From what I see in the tree, it's not common to
disable NETIF_F_SOFT_FEATURES.
>
> > ag71xx is usually paired with qca8k or ar9331, both DSA drivers.
>
> Can it be used without a switch? It looks like this option will
> disable offloads which are useful when there is no switch.
Most of the time it is used with a switch. Even in cases where only
one port is available it still goes through the switch (QCA9531 single
port device using AR9331 DSA).

Some older devices might not go through the switch. I'm not sure.
>
>         Andrew

