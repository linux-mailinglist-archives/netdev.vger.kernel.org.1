Return-Path: <netdev+bounces-241773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D4C880C3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1F33A53C4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872F3301027;
	Wed, 26 Nov 2025 04:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XekQ2wZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AE2248B3
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130964; cv=none; b=H0yC7KacnLIYCF5G6wJ0FGjNC+6BMh0+0Xh6jQjQ3RhmHEDfG1OeGkKxUHsQDshXG+MDsAapVkSaVzonqj02SMIY3hXky6Bd5Wci7Pr1prSiKsLVazozvfiHugeBv9By+e0m0sHLiYDIdDi8ZLLMq+bPt1S3FcwocxguqWv+9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130964; c=relaxed/simple;
	bh=RhGkATIBjHuKXg8BuLK/jvXD5X8qLYcsuE5rRk4MnA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JX5Eq4mejPLgw86g2rZkIz/XV4reGZVKxp+AbVUB4wS5pKD3/PWipL4r58GijxjX2m9PGEGhjdL0a6PSMoLnEn0FyumaWP/w4vjPioGGBwKOV6f/Fu0LmsR3Y1MecZZOq877RACMeMg32kCd1eXbOoSaW87KVwWIc4ZaiRo0/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XekQ2wZo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso80733011cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764130962; x=1764735762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhGkATIBjHuKXg8BuLK/jvXD5X8qLYcsuE5rRk4MnA4=;
        b=XekQ2wZoAXxTWAMEVTM2MqGqrgyWRZvXpS89qTevFEs+P0h3NLIRey/JoAzi/U8vqq
         YGi4SHpbLQV2KFaC5nxj/31TJHxaCxVuxRrOvN5iKcKuavCFJ4AnJ3ZbI5MHHVGrg8cd
         Bdc2+8Wok+Cb+0NZOg6mKNyH/mKTyKOeM1lkBJPGJjvfNdCvnU2IobfQd0QrE0lN9VsS
         wpIqD2cpjIqQBtx2ImpyPXYBijh3VLWlciaQu1s4q1xcauVDhohFvyKKrqLMiwJJw3Ah
         KfadpD9oULYgBJhsjVA6MgABP3sW/HQ9nSAw3gl0h7EEpLhise5PT/vOA3q0PDEQvG96
         ZeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764130962; x=1764735762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RhGkATIBjHuKXg8BuLK/jvXD5X8qLYcsuE5rRk4MnA4=;
        b=REDMH3oXtf9cHnHmpyEdHnuqcT8O9vYEh/Hn8V3gpjir1lxIdQLCPtZsx6SRFrCXKU
         8MbaLb5BkfN37/jpJ66gNYMbMq+SRK5Zblim5qD5aQNw2pVJypSNtnRuzE36F7ghj2bd
         F0Cv8KkYwMQaAsOZQyO/tBJ00vMxndoYiiBMMEv8OrpejKvX4/F1Z6ylKrLkfJgVgEav
         f2wKLpNYdyDhdfX4LLiOIda0zqBttr21fnEaQ++gv8t9D2iVBaYxGq1ydOj8Pciiw5Sq
         sJx/sJu8jqLVqMH6QdjT3lnESR7SKvMS+bRF6ru20Nxaw76Gae7xFmIvWXMGgXSS8Ore
         HHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7CnlGs1BUfHOckGksaG6BjWmp/ThbBYDLUooRtInz6DUo274F+KjW1fTuOUlq4STGj3J5GLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYghQFtUAYey7RLOt7mnvZ58+K6vWIObHV5nBv47mNJ0Ku7DQ
	Xc+KCuDi8ch7wCWE5uysvXZpdAXxULpbAZXHoolHHkfmdoR/dfRsWrJKy+n1xdhqvK/IUrs0BMQ
	ML9Zqw5rxV+zkuo+DqaLHWFC++YSeby03kiCRecO+
X-Gm-Gg: ASbGncux4pnJC5s0H4Z+d68OiCyGqp0ULUSVjAPxo8dN7n27kfYrYFc6iMhtVmNamH9
	90uRLbGJInGB19Hbql2UdXWNBGUVtFOVxiqkEKTM2axUdeJ6zgNwkaSUFZiuCn84ZP7EMR1+0zG
	E+TNlMehm/tUHKibqALD8vEvCH3UpWrc5W9eU4x4tf9q6X+tkuCyJdPH2tmiVAvWdp+NTcQnpsc
	EIIaR2UFMd+m1rA0rN7CTwt1rworSJZmc1GFKG3Iw3FnEY+csXZrP90gaJ9h6h1wNyyfyeexNLe
	CT8I
X-Google-Smtp-Source: AGHT+IGx9x/LBQUM0Tp2PGXo+ghnOqdp6tqUzhHx64nkalaAvyUzsAffNnBonLDKqjFuu3FqvrH8e8W8i48Gc4KsgNY=
X-Received: by 2002:a05:622a:50c:b0:4ee:49b8:fb83 with SMTP id
 d75a77b69052e-4efbdaf1cdemr67320161cf.59.1764130961629; Tue, 25 Nov 2025
 20:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126034819.1705444-1-kuba@kernel.org> <CACKFLikXhRKfq33VaK4Y8Hjo5NEsg6drfjqpQ0YSA7GGd2f_5w@mail.gmail.com>
In-Reply-To: <CACKFLikXhRKfq33VaK4Y8Hjo5NEsg6drfjqpQ0YSA7GGd2f_5w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Nov 2025 20:22:30 -0800
X-Gm-Features: AWmQ_blcyWKaBzwNjLW4ThgVNf6LzA4ZdHC9ysQOIvWlz71DTA-AbVvXqqInZKI
Message-ID: <CANn89iL0JbKufHrMMLcrcF+BbF3WSUtkz-mytpvaw9UEwMmVGA@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: make use of napi_consume_skb()
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 8:17=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Tue, Nov 25, 2025 at 7:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > As those following recent changes from Eric know very well
> > using NAPI skb cache is crucial to achieve good perf, at
> > least on recent AMD platforms. Make sure bnxt feeds the skb
> > cache with Tx skbs.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

