Return-Path: <netdev+bounces-99669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A58D5C68
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C38288EB3
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD04A7711E;
	Fri, 31 May 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRedeXsI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627015E89
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143158; cv=none; b=nTtr+AkxCmxvnqtNyZ3XAt8jzm2zzGan2U2jUm0usd/waI921Lw9VPikXFUaqpVMMgqMIQ34EZlLFeAvXk6nryHuH91aXUTQEj/EJl14iNSOcHWv8m5L96o+aLJE+jajZGh9Xovp1NzfhI5CfLI7t7SLsDfdiIRNwl3pXCxfIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143158; c=relaxed/simple;
	bh=+zcuFiMnBzt6Je3SocB3n14Z+8rap9B5dQT91Kolxik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzmYyGI+g9eQhjn4J25crGnpfqUXn/YZ007Ug0V22/nQxhTkapDWbVp39urDwzgR4AKuSMXppynsvSAGgsummuE0Xs3Be2vdgJvMMqM5uZ0Lsa6WRrqiSsCUxCjK5ERexqaMj3tl9qsdJROF/fgR3dF7eNpYBIGyNOCSMpQ42Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRedeXsI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso7144a12.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717143155; x=1717747955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zcuFiMnBzt6Je3SocB3n14Z+8rap9B5dQT91Kolxik=;
        b=CRedeXsI6+NwJtVel/UQgHObUcrZfJ17p9SALGX6CLxpKBdZp7LF7BjZvh7NyxI7Zu
         tWbUdPjWOe8i1ZMOasJp7HnwCvTRLgxCPGSoCkbixT9/HrKBYV2NT24a0X8p6pkLfA3Z
         ZeBFhE6ho2CdBurh6l8WaHL3zHQQJwwHNSz9c3AxXOZr1zdcOt2eNZPBsAnDaxlcC8p7
         eDVh9ev+zHL/5LHPnoICm4eeWXclf8vfQn11kK+vSFf+M/SafF7ayci9HpEdtq62iTkv
         XH7kIerh0zmgo5iGxsEUlQV7H8DAT1KhqJMBCCCRXIa1j+b36iwExEO6VqqlmqZurrmv
         0xOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717143155; x=1717747955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zcuFiMnBzt6Je3SocB3n14Z+8rap9B5dQT91Kolxik=;
        b=H5Dy/hlWIdtvZW5ZTP64cCiXIjQ7AvcqTTR1Wcsqn8S5xrjkBGkwTrBLESmwG1FqfM
         I3XYiVamqfsZRD3FFbnFNBb0avSDKHLWyFjYdEy9/7ZODP6i38Nzkzaqi1LrRsWgv9Qq
         J7Dous7XmPMHmIZdJQtY34teXIexo/7owGKp+g2MjFhr3sMoWw3SQ/VbHx7mDExitZVQ
         2MVdu2Z7mjcX/IOaTLda5577uGmpj/0IPJSKoADAiHHZrULgZFjE+vndpkZSwv6O1t1N
         WCN76ClfO8aiNrod+QC/A44SzTU20TzbuVPrLO5YkJjQcB6JzFYLG3m3ZOmhOMBDrQ82
         15eA==
X-Gm-Message-State: AOJu0Yy1XzAjhq+RQLwV3SqOddaYkmkB/d09yqmRQxVFuN8UOW02m0bn
	Dir4aqaGdpy/m25kWdTl59Jo05+pOP+kh6cVfjk5A83WE7IwZ0HmeFD+BQ0HpTbZbMJn24nvChd
	c/MS6PtbpQ/hT3mrRbLMsYixhA2IDIusioQBnR4ApH20UBFpg+g==
X-Google-Smtp-Source: AGHT+IEMtyGeXl/fX7gxxAL/632eX3+s+KyYKjTtKvCIZwvhhUfWl/OjeNy13luErF1LkScAcaTd4e4OSvlnM4p8mrY=
X-Received: by 2002:a05:6402:2029:b0:57a:2398:5ea2 with SMTP id
 4fb4d7f45d1cf-57a378648c9mr75743a12.3.1717143154749; Fri, 31 May 2024
 01:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232722.45255-1-technoboy85@gmail.com> <20240530232722.45255-2-technoboy85@gmail.com>
In-Reply-To: <20240530232722.45255-2-technoboy85@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:12:23 +0200
Message-ID: <CANn89i+GZ31Epxs6sfgg_skW4QOQHKFA4GHgM_4i95FcxX31gQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: make net.core.{r,w}mem_{default,max} namespaced
To: technoboy85@gmail.com
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:27=E2=80=AFAM <technoboy85@gmail.com> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> The following sysctl are global and can't be read from a netns:
>
> net.core.rmem_default
> net.core.rmem_max
> net.core.wmem_default
> net.core.wmem_max
>
> Make the following sysctl parameters available readonly from within a
> network namespace, allowing a container to read them.
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

