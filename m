Return-Path: <netdev+bounces-63755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8E82F363
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 18:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F01C23758
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90681CD01;
	Tue, 16 Jan 2024 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g//5JxH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC81CAA0
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427018; cv=none; b=e/mW/Q2EoG7Tlce2I1CqLn+RleypjhXhMc0HCOGRZ/n5MNHBetvhz/mfMdI42mjgExB9fAgVRqE9ZuJpM6t+GWTefZmSx0cUJ4QDDt5zdCLEFai+P3JFPBT8WYrXvVmfudFBigZ21BWcvvnhPPdSteUQcgvyj5VZDgRkDi5kZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427018; c=relaxed/simple;
	bh=LcH8SpaKXSuzmvpIr5OOQ94gPXvSL776wVHpa/ElBjs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=BAkmgFVWbZzX8Hu52nOfhEqNoVQvyw3bom78nuAjUawxLZyN4hRMti7vH0/IbaX2ff/sN3PQ5gfCZv4qhSGkcoJNaVHdMTmgg5/u8tFgYKvej+sBvE0fWKcsYdKsEZ/sQW3umac6f5Xw3+ZeVuh05WMZXx7RWbhqV2m1PboOh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g//5JxH4; arc=none smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so28261a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705427015; x=1706031815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcH8SpaKXSuzmvpIr5OOQ94gPXvSL776wVHpa/ElBjs=;
        b=g//5JxH4IFZazcBkg39EY5/Z2Xj0+thGkl6N5L/goBBdR5ic5JHY2REITK/W1Yfv6G
         FeyDKqHtz198sHPcM5xVGl3NR2fyuSZ8eHe6EEVUkIW+qFGDW3mlxTW8/WIp9MabbyAW
         zFbD8OPsNt+PPd4lJ/4rGhwSmNeBrCYbvK6TgdYRQZWt8MpurLQrkIzmVTD6SHH1UBU6
         LP+8HWGtRazeWPRq4c2Rs2RFU6QbvuiUU3AMFuHQMZYBoN+Hqx7XgLz+vLS3S9ytma6t
         zSyOx+G0Fk9EUF2zBegSuaV5MuQdXgIAznW2Ezyc2mKTOHnlIViVbjPsyKRKWQ4ajc+0
         5xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427015; x=1706031815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcH8SpaKXSuzmvpIr5OOQ94gPXvSL776wVHpa/ElBjs=;
        b=FUiqJ8OhISxCF9LR8E86yjYijrWuaWlfNEHx6vfTnvQa3Dbx2Bn0+K19lx08KIM3OU
         yD2bXzBOKWHFWhka2N79M3X00R1SzKSM/bZaZIe6gBCJALdsuUwYodufycAMmcq3NbDd
         GH5mkjtfS94k5+Urh0n8m+CIkRU7vEIyYzmBgz5a+8fhqCh7sr+aTi9Wk4YPJ3oZkvow
         2eWNOGREQesD0TNNBb/BalI1YPMfTyGknvjxEFVkQuHVc27qEC7SZpEEDM72jVllzFF0
         IJvYlm1WL4+yKC3BKW+aTvfOJ+/AlZyXufiuH2Tn4I9Z7sLkRCLtEKQ9gxi/Trwc0225
         O9/A==
X-Gm-Message-State: AOJu0Yzje4pOhgwYMQuZU4BKzY12KgCVrmY2I4a1VDfLvfK/FLOWH59A
	SAFly4A1rH6zQ4onwss6rqu+ADDwxvGUQuG1US6Q+8bbyT0v
X-Google-Smtp-Source: AGHT+IEqCH2+QVFUNxmp6JfimiNRnUG5eO7uirPh1kn9mq5KJ9/hSimv+N938mCVYV4dQ0aiYfzp+UCiroQPnzNfxFs=
X-Received: by 2002:a05:6402:3098:b0:559:b56a:cc6f with SMTP id
 de24-20020a056402309800b00559b56acc6fmr26446edb.4.1705427015377; Tue, 16 Jan
 2024 09:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddfc9eec6981880271d0293d05369b3385fb9e86.1705425136.git.pabeni@redhat.com>
In-Reply-To: <ddfc9eec6981880271d0293d05369b3385fb9e86.1705425136.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jan 2024 18:43:21 +0100
Message-ID: <CANn89i+nbXMuLpB11s9rr3L0PV26UwkSPdNXDijoX89NOJ=V-w@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: relax check on MPC passive fallback
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:19=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> While testing the blamed commit below, I was able to miss (!)
> packetdrill failures in the fastopen test-cases.
>
> On passive fastopen the child socket is created by incoming TCP MPC syn,
> allow for both MPC_SYN and MPC_ACK header.
>
> Fixes: 724b00c12957 ("mptcp: refine opt_mp_capable determination")
> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

