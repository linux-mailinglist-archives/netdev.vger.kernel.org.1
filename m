Return-Path: <netdev+bounces-218389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DCBB3C467
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689FA7B0B6E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F6261B8F;
	Fri, 29 Aug 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gyw4Yz0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035A1D7E31
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504583; cv=none; b=MRwiLGlPpmRaM7h1mEEgFtFyP8cZNGItgJrdpmsFlcLlByWnMSFdLIL7crHaO6EwzOI+4yMSrK6zzEiNbrD9nYpecljp0O/gOVesozNKts56PzSJdjLMC5ns9n9VdX+wqAUbTpysg7VsdtKAJPIUpzILSRK8ytPmnQ2WfOrmK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504583; c=relaxed/simple;
	bh=jWktGVfKqKlDHrXHd01DgVEcElSD26vHoVFRttfq8fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wb3TyXkk0QkICi+hUmi1xZ6HVB3OIWYDXBYMQwLosCe2vUqTlCCpmw5sQTgQCfzEDqUPyQrPR+e+wSPPieGDckqGzyyGF9HASr9N4KgXHV/wNm1U9qV+dko+YEU7Q0n4RURO+8dlhqfJbu1hnfuz4ot0SOWgBseNxv7AKv8yql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gyw4Yz0V; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f62f93fdfso1777e87.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756504579; x=1757109379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWktGVfKqKlDHrXHd01DgVEcElSD26vHoVFRttfq8fQ=;
        b=Gyw4Yz0VIruJRzuYjaEKDbIqwgkEeu4YX7hUYsrn8pDzdrQCCddtSXGUgJdy83defg
         /OMAh/Uwrdrk1tLinq9QQ6GmP0R/ggwHp7gygfmIoSypauYl+UGYda66FGiuX/YORTun
         Qd6CyGqLT3kTV1Dbui9prrT34hn6E787UmlFrom252UDTfvGge8as6nEAqhXTTaOPYz2
         z2ZK5zI5ky8Aa+cxc0u7S6oB/MD3Z/tVI8f1iu5Lqh+6JWCvp6FU5QoJuHTte2OyHCDu
         E4FR0lD4XYfHe67tssckQuFzYD9KAIwxIufbe7Pu3AVAbHtAi0DH2wdLGCtaZQK/pagV
         I42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504579; x=1757109379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWktGVfKqKlDHrXHd01DgVEcElSD26vHoVFRttfq8fQ=;
        b=GNB5vF1z/lPtRas4qJ6IDOMBXei0hsdAfUr8X4jiyWdD9rgrkf7MWr5AGAAIXDtPpk
         BbGo2R4/p9cehqe9Mvp+zkAtutM/ggZHvPUPmr2pueI9KSTH7a/VLZrIY14FgcDTqRVg
         I6e826M0ecA3QIp2BMxY3pW+svn7OYL1/n8R6yPmcDnAdWbEcY6BvtitbcK9FlDaHtDm
         4im6eTlZL3GIvJXcwELqEpmQAACB7KYEcxgrQerm9D9yisYYsW01ebGKP+8mHhKMNU0a
         vEM7ETfVuH/f9IT8wdEbJmXjw5We62kllXqF1Xc4S2hJ8U1yMj6d+TqUltoL2JfQOENT
         lIbw==
X-Forwarded-Encrypted: i=1; AJvYcCXdDqZon9fzHats19UTJ0Yv+k4tmyaYM/zJrUIX/nrtwZBrwBAGckx08TTvyS9tlJI8P8mJnJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIDeQCbQdt0UNicCxbpY7aAWpFrwoM7hs+mT+fyglur9TlRs/
	ePFYadWFUBHHINdt2zBNWyCYuQstb+ogng35ypSGTEdjFIPkMB7Xm+e0OQlYsEZQ98IcFBvV0Qe
	ubXPzMCAxnNK3J6wQn7UAUYK7vmKxFPSzT/MMAmiA
X-Gm-Gg: ASbGncvUe16QQOjmE5A+0rKzEli0N37bxNmG/GzmI2cMQswHkv37J0gCbBvHx4xByZS
	tjN5yYFsZhlamkC2KWlscNX3eWpgXOGQ1ihvtl+mwnyJqbbmAmx8BRSzNReg4jwP6cvanewyCW+
	zalWral/q2eOUxlTuCkd2wadYd7q8+084UjUOgKnVLyMIRP+fPoO0936qFW9kNTVJ8+cxY/XuPz
	ZHgQOz+i11RpQaF4kcfyfmc7xQJu/KQ2cmSWtHEjdfI
X-Google-Smtp-Source: AGHT+IEU58FiMdGKNLCAk8jntYKu+cqqYbs1QNzq8MMC/KJQ0AYO8nZRjLjMNWQew4d+ngsnVqwMZGVDjVH1xaN3KdM=
X-Received: by 2002:a19:6448:0:b0:55f:6a4b:b156 with SMTP id
 2adb3069b0e04-55f6f47f95fmr72889e87.1.1756504579132; Fri, 29 Aug 2025
 14:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829012304.4146195-1-kuba@kernel.org> <20250829012304.4146195-11-kuba@kernel.org>
In-Reply-To: <20250829012304.4146195-11-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 29 Aug 2025 14:56:06 -0700
X-Gm-Features: Ac12FXyB6kzWpl99qnQv5LsMZiS_NhG8RtVmZeb-vOQDm6jgMN4S2Myl8cCDOQQ
Message-ID: <CAHS8izMh4O+U1p84TnxS2cLhyyG=gMy_yo0U09x=NYYzEHYe-A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 10/14] net: add helper to pre-check if PP for
 an Rx queue will be unreadable
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, tariqt@nvidia.com, 
	dtatulea@nvidia.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	alexanderduyck@fb.com, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> mlx5 pokes into the rxq state to check if the queue has a memory
> provider, and therefore whether it may produce unreadable mem.
> Add a helper for doing this in the page pool API. fbnic will want
> a similar thing (tho, for a slightly different reason).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

Only thing is I wonder if we need to ASSERT_RTNL (or the netdev
instance lock equivalent) in the helper to catch data races around
setting/querying mp_ops in future code, but we already don't do that
in existing code and it's not worth the hassle.

--=20
Thanks,
Mina

