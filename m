Return-Path: <netdev+bounces-101654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F24B8FFB73
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1641C2439C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 05:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27214EC78;
	Fri,  7 Jun 2024 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WH5fFpZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91A200A0
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739481; cv=none; b=DqbC9BkozH6QIk5baMoYX3VKTdFhImzrCKiie5qcb2l7611ViirzMTmr8/cnWg7f3tzU6k5aKdWE2zTx6+imLrVKvx93f04shud3qvL2ST87Di6hYnsdGgT+1HVf8y8PAhK8/MDjr/PqqmkrNVTlKu08DH93J3+UDbjQ9nX36wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739481; c=relaxed/simple;
	bh=map90Hwl/wwt37B2rRDVaQJh9zrq+fwXiHG+LToCauc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbaMyVUKTUBax4JayEO7/7cc3jf1QMZ9Ra7hCLGaxtUpDZ/T62wQ2KVP9n+0rwMced+XAOS0OZ6lfMLdectk4p6M13rKiltLZv04wAmXNFxN80FvcRHsTJIxQRGji1MjMzRFE/mENlNRqlS7/OdVBNcHby+MlYjkMQdS/C7mJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WH5fFpZS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so9295a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 22:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717739478; x=1718344278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=map90Hwl/wwt37B2rRDVaQJh9zrq+fwXiHG+LToCauc=;
        b=WH5fFpZSSr36yTeFCA2eNAOQaSYMmbGgLPeIZKgeem9dU0OKLUpZJpcFhu3zRH6Ebd
         YzgyaK+gi70jrDhdrzzLfMHpY83MrB/WOGS1sZbY3eKy2ojRjkf6oS6g2lJpup0gt73w
         JMaHiucFZ40wuKl6OaBLvzcU3JJJrnbWS8J9Jf5g2KqeOQv/bLQYHTI4E7oE9fIvnX9H
         WNQw3QWCS+zwK2qLRWHjKQ/mMW70ZlTEwssqwhCmmdYxxgJQD7siovBUTPqf5ex8xt+A
         bUNaxAuABH09vIp/0AKL9Ohe62plNoWbT4xDKvuyod0HLTNZCmojo06xuUxFxzgGn1cb
         2AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717739478; x=1718344278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=map90Hwl/wwt37B2rRDVaQJh9zrq+fwXiHG+LToCauc=;
        b=pTasDGVpmivxMWD7kEmeEqW3XZr7DiTSQKjeNYpBxInUpeCQo7h453Siu00I3e6irs
         UirhGJkbpwZ0P4VOhrILtirOpXB+MEQA7miZf7yoH8lwL/+jBrdGRxWgwsJ8WT6YaXWG
         dP2pHedyJ0FcOLs2MUnuEn1N8h2b22dS71dQgJ3OnpQUTHgi3Ix+K4yFs/nBIXIPbnPb
         yeJqf1NFeRgcx0HojBE5yJcAKRmfHJUbUz553m1KUOpyjgnD47RIgZzGtaT06w9e6pWL
         QVuAkK8Cd3lDUAhd5qJrzgDQOvSXq859lf+QTxqnIN8aMJ/5IzpQaACKB4dXH0AB3qGe
         6sog==
X-Gm-Message-State: AOJu0Yy5m2lJmAhycplkBw8Mg/lRiBdcSBVtYPdjemfszja3xHDugnUI
	i8xVzeJ57DHnhiE2SbpmwhuFETB1LG0ECpfqJLxpawbwx3zytj/XDofCZo868ONZOQsNCyALYJs
	/gDj0SVAEY+wlsodivM32p1b2TJABpREwYA8yZlxrTyqSc0h5tA==
X-Google-Smtp-Source: AGHT+IGqWLOcez9nBFGpPo2weqioWP+XmCins7dZR9xd+TzSoSSY1ij3veGrCK03xY4kkQ1/Pm7SE3ZL63/aqNfMk7g=
X-Received: by 2002:a05:6402:8c2:b0:57a:1a30:f5da with SMTP id
 4fb4d7f45d1cf-57aa6bd3be2mr456301a12.2.1717739477446; Thu, 06 Jun 2024
 22:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606151332.21384-1-fw@strlen.de> <20240606151332.21384-3-fw@strlen.de>
In-Reply-To: <20240606151332.21384-3-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jun 2024 07:51:03 +0200
Message-ID: <CANn89iJ16zo1S7HByyUJKQhA_uQ9zr1PL4GvGCR0-tHdfQ2PnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/3] net: tcp: un-pin the tw_timer
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bigeasy@linutronix.de, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:18=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> After previous patch, even if timer fires immediately on another CPU,
> context that schedules the timer now holds the ehash spinlock, so timer
> cannot reap tw socket until ehash lock is released.
>
> BH disable is moved into hashdance_schedule.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

