Return-Path: <netdev+bounces-91570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0918B3149
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562661F22891
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DADE13BC31;
	Fri, 26 Apr 2024 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caNgvyEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50E13BC18
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116477; cv=none; b=krqOXixydj2QEGs7bEdYhyhJZHsrA/B1+0pieSi14+zwESfC08Fx1s81BH7/V9DpRVUSLAl+ahFY4zUkIAvUTS1jv87VdIrZxsmieEZttCj9EKyqzK8NCjHTdGsxMfMYDfdYaP8CVoup5ib9yn8nfCjktzWTq6UZAvD9M9VlrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116477; c=relaxed/simple;
	bh=48Ba5A32Cjl2L/cHDAoV0QpV5Af4tdSMnVjMTBjS/94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlmFKc1AFAnptazwLRD4wGC9H0+OoJECoxhruT1bNWo+/Cx1xV7f/F7LePzepuw2nAB0ysvBsTAxMiGM82TKx/wZkxBYMomuBkBiBZyzO/6tfBvBXzN6GU6kpU4E5Dlw/lXJHXSPIKnnygztCYttbOjQffqDQrv5eiky9HwFUzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caNgvyEZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so6022a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714116474; x=1714721274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Ba5A32Cjl2L/cHDAoV0QpV5Af4tdSMnVjMTBjS/94=;
        b=caNgvyEZNso/SyeZ3gZn0PF0kTL1bIMSTmYaDdt/8HDl9KxZYWixg+Ml0RWGd590xc
         q0v8POQCz8BXCuvzt/TuiLIaXsZFuf85zUHCxyaoA1c3zll4Y+Va1ho0nnZ9XPFWonXQ
         WjNX4GcqzF3FuIMXquYDtkpfcy1iNCdDzcXwK9x6HRGBwSlrP7JhUJe1B4uUuuLxhVgp
         YWACfrZMZ++lq7i+in4cmBm2gw5kcj/zI+sK4tgijYCIihKpjb/bKs0xkSICdbHh4wPw
         XF8KAkHwm5fCyVETFnZO4WN1DuS3T5CGb/BxuWu8YpPefzhqgzNMcBwNLDGaaNGGYpO0
         ipPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116474; x=1714721274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48Ba5A32Cjl2L/cHDAoV0QpV5Af4tdSMnVjMTBjS/94=;
        b=wt7nwbGsOzo1ZZaM4QjIgYVISMP4t1WCiLDSa1jrlUz2y+jCFan9vig+zG8YCzeScz
         cHWRbucWLXEm98b33tlr5eH20B5cKKPY5bOq5rth1YP/6BhzxfvPWpSwaqQUhml3R6m4
         hBYqxxxHgtayinAo/C+mM8vYlXjuNStUI8d7I/T8FK8zLd5ygjQSDERFxPl8NXESrhKb
         /xUTFTJPN2Pj2m/P0rapMixo2bZFqjcr673iQgsZ4noCNwbBCo6Ml7RPJM4KkzG0iNM/
         B01lj7UyonWtRiyuSusuy4WxRHL9QLEm1/9zrHz1vT/z3pjn6AYr0jS9uodAMlI9Kdmv
         6eOw==
X-Gm-Message-State: AOJu0YzNlCIfPotmWf6+MWJM5C4kAR2rkOlBWua+cxKc85sEVdDktqk1
	dErmPrzN2OgRsajS7gcNEgEWp3lQErVcZZKkcnQo9djqcxtq7ME5ZfgXSqv9NATPZ1IOBmdRb9x
	a80wVbBkl7d0k46ZYhFo6ZqDCEWd1gGyXd4dm
X-Google-Smtp-Source: AGHT+IHEn5uOD9GlXoPdHm3uPp4edfxe4KynTFwvW8GmIsgl9y2/YROhvW72ZIDxBxLHIb6M0J27TSxSFjNOrAmpu00=
X-Received: by 2002:a05:6402:b2a:b0:572:583f:cc4c with SMTP id
 bo10-20020a0564020b2a00b00572583fcc4cmr30849edb.5.1714116474078; Fri, 26 Apr
 2024 00:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-6-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-6-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:27:43 +0200
Message-ID: <CANn89iKOdbyuaCsU9FhLeWJS1QYMXr7NffAwPbYWApxpQrMTAQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 5/6] net: create tcp_gro_header_pull helper function
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> Pull the code out of tcp_gro_receive in order to access the tcp header
> from tcp4/6_gro_receive.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Eric Dumazet <edumazet@google.com>

