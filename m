Return-Path: <netdev+bounces-112432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9656E9390FB
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BBF1C21315
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1016D4EA;
	Mon, 22 Jul 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fziGVBDy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED416D4F5
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659856; cv=none; b=YAwFp8IChw/9WoVgEHTu1VKcj6risukZWMK1ZHThqOKWH6IHaWG8oVLFQmbRjRp2GVmJQnRqSjuiMUabNvh89EJ6pWVun62IEItgU2EWTgym5Zn6CBv9wHEF1v/3izNlcbOspo1VQ3z01Q3j9GasCploQNXNupaQMYKRQAz9IG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659856; c=relaxed/simple;
	bh=MjQnqr4i3FcFhs08Z+5zEAel4nQdhM7DD3Go2hry/gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RH7xDQQnXWsm5llVj6u1m2dV2T8RKryAOW4jeDizfW2kCtppc26UyeqQksjTWw/t8qyzBtuvPDEnCTEQeznjmLGtwajcFjBuLKzJAEG0FNJ/ZIezjeuzernmtzPUcps+Swo0Dy6S7Wn71qsKHBpCJ5sr2yD2mpU3fLDt4XZTU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fziGVBDy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso39920a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721659853; x=1722264653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjQnqr4i3FcFhs08Z+5zEAel4nQdhM7DD3Go2hry/gE=;
        b=fziGVBDyb7zGzgGi+M+5/sfevReP+CjmgiOtO9t4fPUklAagNDlhwUEeeP0P64Ylej
         N1zTKyuaCMQseI8N+YaOYnK8ZdDWE2nxhNL9cv9yU3WvXiq1Dl6MmQj0wbLYTXKRtRPm
         waIlki0LVGIrxaj1Km5UHZeSvm71a4pfRCc7lUsykLJk/1aJXGtd72X8oZ/GEj6MoUBn
         mnxJHd4xu27Getvv9lv7CDjMAGBcMB00meWW9B+oN86Y2/OKEQGFTZFDQ/Ab0SHEz4EG
         JuqgpwisE34lgFltXd/LgKvtS+PMa52RSQqCw8IsumLDbJ5W+6KRCGBAGyxEVGy3+2Be
         u32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659853; x=1722264653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjQnqr4i3FcFhs08Z+5zEAel4nQdhM7DD3Go2hry/gE=;
        b=ezVCn8kIU0mv8X1qirCacK1TY474ir9OMMYnafcMFqP9yeCnecSZmweqXYWnVxn9vl
         /m1pz0LXiOrVXcbXbAO4nRkFBvw6MktFaa8i9NyIPUzOgA1zMT8nlFqoRPDgc5tBsAwv
         P+AohmNyVYYNa1e/RCnjbCSmHPHM/0ixUIWFmzXFx0z+wX3dtGQPvvMDf2ZqZ0xLBdwl
         8RnlK59vjdNbMUUAxDNqPlSMFNG7qYxQudU5DeiFKu9ETJNslveNsoAixoSX5v0TtxvQ
         YXjrRYndnJ9u0O0d4xXGRp7GyyiqBdHU4d8t8WWlIbixST3xspSE8zMO1JLb5boItYD5
         lEQg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Jsn2qCBQcKKVZF2aAeBJX/xXNrMgWrY2p1+CEYpa7w286P5noNuwoX5hLdfbTj0tNWzXIVbkMxEXJy4cd6YxAjrCH4Qu
X-Gm-Message-State: AOJu0YwPm7GJ30SB7ZpS3paNGulGeidxv1Xd9+2GzCOXyVU1WucPs6WQ
	GGK+E+RE/3dm98v+i8X8BXw0hZXQCnGa8KEROMP7ZWStMJVqv4RNUnkvWOr0USuXDjaL+s66zNn
	UxeOQ1sfvjP8oewkjbiIqEYc/Fw2MIbKz5oV5
X-Google-Smtp-Source: AGHT+IFY/Rki7XV9E4K2wPZzSL88IJmsIuffZ8D2F51UDDgCs/8puSI+3cEH+Aq4UhqxlrEhVOy1j8mZXrQTynFesrM=
X-Received: by 2002:a05:6402:2686:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5a45695902emr276488a12.4.1721659852603; Mon, 22 Jul 2024
 07:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722094119.31128-1-xiaolinkui@126.com>
In-Reply-To: <20240722094119.31128-1-xiaolinkui@126.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jul 2024 07:50:39 -0700
Message-ID: <CANn89iKrebOtKsZptq_NMhwCGOVbrp=QgAYnJE3OPsC1__N+HQ@mail.gmail.com>
Subject: Re: [PATCH] tcp/dccp: replace using only even ports with all ports
To: xiaolinkui@126.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 2:41=E2=80=AFAM <xiaolinkui@126.com> wrote:
>
> From: Linkui Xiao <xiaolinkui@kylinos.com>
>
> In commit 207184853dbd ("tcp/dccp: change source port selection at connec=
t()
> time"), the purpose is to address the issue of increased costs when all e=
ven
> ports are in use.
>
> But in my testing environment, this more cost issue has not been resolved=
.

You missed the whole point of 1580ab63fc9a ("tcp/dccp: better use of
ephemeral ports in connect()")

Have you read 207184853dbd ("tcp/dccp: change source port selection at
connect() ..." changelog and are you using IP_LOCAL_PORT_RANGE ?

