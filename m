Return-Path: <netdev+bounces-58786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57137818369
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 09:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E691F2473C
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4A848E;
	Tue, 19 Dec 2023 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwGvcCvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EAC11C89
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e1f1086fcso1532e87.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702974900; x=1703579700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W69IBq6O2QBTt8VdyjjqFVXDBiHKvQB6keYY1IZdXNw=;
        b=PwGvcCvmlG4tzCanyAQ/sUijndNyJSd5jLp6z/EuRAAzROjHioqVc0G4Cd9xAwVSRP
         jelngXups/s77PiNBRBc+XGMKB9PFa3LpwB2uFsbKAFj09HNXp8d1tGD6pWpnbaQu5QT
         zf/xk+zHKktolT5Bo6OLl1N9mOBsB53eDarhWVD7ebs+N0XDdC5/oqiPqEmN/cfzfFis
         MQ2lCT9aNl3yG3wUS2pC+kKJMJgnY1TFwYFNSSVyhsyr88jUHP/CcsaEZZySpG5dDz7I
         OW5TIX75Ev6rfPGGdJiLDTcB4+aTdiaPPTJwlKuZN2xPiibhbiSIz7ZPk4cWB+7t7Awh
         A8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974900; x=1703579700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W69IBq6O2QBTt8VdyjjqFVXDBiHKvQB6keYY1IZdXNw=;
        b=R+UHs9yAbGHEuBD9viWN+c1QUO1fVChWUUQMxHH9yN7RApi3gbkVHZLiDY4mL9Hapb
         hmuxbWrtOUDAKxAtBvnO80nHLX89RStfERN45+seKzWDic/5LHRRQLJ3NJYKn7FvsdIF
         ubZ282571V/NYX32PdAy27XuDoU7cTeQW+34uZgC6rPWWCqhZImWlYQ4eXLWloKJ3/xU
         BO5QDiUS58QLSZxsFc9xyGz6IqyZJLNDkpx8+1rImUkVwwXUWNFmkIzSddjGwH4UVa91
         SggAEvtElkmRj5xHnCpn0U2x/0WFzJIUlOs8ueejzElKr0o1St++mo02HK74efxpm64d
         HF9w==
X-Gm-Message-State: AOJu0YxxIz2Ur78EY9GM8tm38zjR143khSdznIeDLilQe69vvLd29Qmm
	qW6aof2QJrRaWyYVWdbIbq5oP+u7NLi6KVCji790nAqWkwtE84H9En7lfVOupA==
X-Google-Smtp-Source: AGHT+IF7fOjFd54KnFby9CSY4g2A4UT449rMDSFraOKuaPRO9a2ms0I6WTRFhuzkZm9pnU/0NO60tzjR8xvapeLXzUQ=
X-Received: by 2002:a05:6512:3582:b0:50b:fe63:f06 with SMTP id
 m2-20020a056512358200b0050bfe630f06mr89709lfr.4.1702974900049; Tue, 19 Dec
 2023 00:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219030742.25715-1-dsahern@kernel.org>
In-Reply-To: <20231219030742.25715-1-dsahern@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 09:34:46 +0100
Message-ID: <CANn89iLczu8fXUGxJt8LGEhoUbkNrKyh=5zjZXR4U-HfKPwPsg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/ipv6: Remove gc_link warn on in fib6_info_release
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:07=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> A revert of
>    3dec89b14d37 ("net/ipv6: Remove expired routes with a separated list o=
f routes")
> was sent for net-next. Revert the remainder of 5a08d0065a915
> which added a warn on if a fib entry is still on the gc_link list
> to avoid compile failures when net is merged to net-next
>
> Signed-off-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

