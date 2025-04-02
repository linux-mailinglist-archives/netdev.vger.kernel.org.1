Return-Path: <netdev+bounces-178908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E9A79850
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384161893BCA
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B71F4181;
	Wed,  2 Apr 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4EeA4sR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F365BAF0
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633481; cv=none; b=ouHtN1HWRE4IHqSHMjxxUa/Pc4UaIx93S8sPIGoJKBEkLy1Gbfe3nV7Ih+0aQ2XOhtrCaTiBEVbumiGv7HD4WcbM4FRYJ96EKHIMbWJeKP6BehW6vRd7Fkza85MhCs0q7AhrstDCrJdUqjDI5mZZS4nL4H9v5ijkaeAKBRJ4Jjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633481; c=relaxed/simple;
	bh=2Bq9mHP3ysW70I4V8FEdSzM21+gQCmDxoom6z8xEvrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kqz4VckNrk5pnqhoDfSE9tjarlNx1rN/9IY9Mv8qp4iNknm4ykB2CKo93OnNDvX2Z2SwgIr8//1387NfW5chJZWOsSqZ+kuDtqPQzVH3CzRiPHn+dGlgqQb+rJAczeCmQSiQEaAezbW0yJFeh6vDTYbZvq9C6e2lOLDxIK34XBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4EeA4sR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so2193305e9.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743633478; x=1744238278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bq9mHP3ysW70I4V8FEdSzM21+gQCmDxoom6z8xEvrY=;
        b=d4EeA4sR959C6XwyIaSFAL7YR++qtVmIjFPOzxvEkaOICBd16/m8R1y4ptg0lsCrUC
         CR3obyXjVTN7eH/o4No7BFaM/43HJ/gyOKvwT4yTQ2Jx203xZACZY4IB8P4n2N/qzbz4
         oL76ntYQfwcUinRLB4B71Gwh85ohMT9iPxB1gR738hvUGbnI+NQUUnrVuXwKwy0yTQcU
         gLXEnqCAivA3wg8oX3bTMGAWfpXGAJc63UIvL6/HnAf5BfIMymEQ3pAz7aKvbRwtn2mq
         Ed1WsUE4en8MOn0i6masBXLB+tGKgJwfC2c/lD9yJ2MMN0ghUBx0mNQnb3Jslkjy4WQY
         i23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743633478; x=1744238278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Bq9mHP3ysW70I4V8FEdSzM21+gQCmDxoom6z8xEvrY=;
        b=tksXrPOYquIbAKHAJ0Ccm+EhTwtKNsBz1hYAdwi8b0QTixmN55vUlI8BFF8Ygqzhk+
         5HgcV+ATAtTZokoWvhybuSNrI4dAOvngYABNjS+mj19SvU2+8AnlghhHTJWdFiCmqiy6
         I1ZT+NjyYU7WS8wJdZnU7CH/o5zItrEEu9kfldrM5BVcDW3P4nnfkOvbEYHbmgK8qr+H
         y1qhpv2BpLyHzQkmKK8XlZmzJhqKTXvMikS39Qfur7yGUgM9b126TO9ZV8I/kKZD2euj
         erIbmL16gA0oO5lDNIQy/dt0aqj5AVmoVzNr0Qfd+KWssBHBKPw5cL87DLcWVDyHOA+S
         jaSg==
X-Forwarded-Encrypted: i=1; AJvYcCWRWbeeWSUbJ/NeSMgTCZzbtyPtY3qLZXHWrXfywnVHKFYx+9z9tsu5VrkbCUkaVo1hED6txoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXr1rQs1ERlxnJCXyd0U2sWyZM9g52Wumvo1tn6XUho30VhiQ
	8ZGKVGSu1csqSiOit2H4JgXodnHxBDXg7tqzf64ZPltASpG+6uCutidxEypO9CHgKgfMYr/JU/K
	XKCPd4WU7a6WPbIVGUR5Ty/ikGvk=
X-Gm-Gg: ASbGnctvtha9F7x9VChT6gqcPJTIU6GP4a8LbQMduVmnodyJ9WSBCV3ifGafIyJ1Xcx
	IL6wWp7DVHDtVsky5X4PGBCNDmF8adBNwcPll0x9aeu5JJdpE9T5Gq1Z1xICAaLkceMJiobB6Ik
	VB9dQLtql/bqb9YqFtViLBwWruy4Uu0dKqdbm8WXNUqK3qknc0F2BEsNUCf87buBWPe1XtwA==
X-Google-Smtp-Source: AGHT+IE62SuYxF+loTHV8DPRlEbDool+AaVmk4ig7sfQ+haIU3pZf/kz/26tdm+C0Aq2dp0hC8NyeAKB+tqzP4cvH0s=
X-Received: by 2002:a05:600c:698c:b0:43c:e481:3353 with SMTP id
 5b1f17b1804b1-43ec13fd610mr5269685e9.17.1743633478158; Wed, 02 Apr 2025
 15:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
 <20250402090040.3a8b0ad4@fedora.home> <de9d0233962ebd37c413997b47f3c715731cfffd.camel@gmail.com>
 <20250402101720.23017b02@kernel.org> <Z-10ToqF15roQ2u4@shell.armlinux.org.uk>
In-Reply-To: <Z-10ToqF15roQ2u4@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 2 Apr 2025 15:37:22 -0700
X-Gm-Features: AQ5f1JoysbJdETgpC-jyO8Maq3T9Y4xdowhVATVYN1g9PnpL893WbqE9x4jI6is
Message-ID: <CAKgT0UfBb4DEXGvvEpyJ+AxRXmRn7zUjVUsy9wDRiU5j=i3GHw@mail.gmail.com>
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to phy_lookup_setting
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 10:30=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Apr 02, 2025 at 10:17:20AM -0700, Jakub Kicinski wrote:
> > On Wed, 02 Apr 2025 07:21:05 -0700 Alexander H Duyck wrote:
> > > If needed I can resubmit.
> >
> > Let's get a repost, the pw-bots are sensitive to subject changes
> > so I shouldn't edit..
>
> Note that I've yet to review this.

I will wait for your review and then resubmit with the second patch dropped=
.

Thanks,

- Alex

