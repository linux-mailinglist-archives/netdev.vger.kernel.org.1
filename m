Return-Path: <netdev+bounces-170600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7208A4937B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F3A168403
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D8248890;
	Fri, 28 Feb 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgXkdnSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D813214A8C
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731386; cv=none; b=DL5ueF1fM6F/30aWy1QaI3V/CNtNOjo8Toh9k+pvCOpv2sO4rjyhJh03nd3p9K5TK18eywhxpKG7s3QuUQUfshr/WpARx5kdR4IeFiAmhkLFkHCznri92/kC+6L+RiQGpFYevcm6fr/4d2a6qf3I5t+o1PqqHMduGjpwrY/183Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731386; c=relaxed/simple;
	bh=ACe195wtoRx197/riQf1QMIwQDGYabbOYGhXEvpnEBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VChoYTPbA0tN8U6O9o+cn4OQUDHeVpigJ8dp2zDGejKo95QVvBy/+JHYGT2kwnWwOPbF59FC2qqRA2HhnrTKZcU8oN6OU7NyIICwi1R6JH4keVmCv7O58D1u3bT3YLQnegBsvBW9cH33l1QokGQ0zk/vUit/Wtw93f2fL+dwS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PgXkdnSx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471f257f763so17483841cf.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 00:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740731384; x=1741336184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvjGL6WGQQQmr6eQdBwTa2SVh5uvK/8NFNU8AVIQAYg=;
        b=PgXkdnSxvYFpjrrnQO9noTKD2+3sd6vszI4KLW32FA1NbO8keQbBBaOEpYyvMQHqm6
         2Y9TEsPvr0hluJ2edIwhgLKr+q4DVSgm/3mvfHFkwJ3+X37Y+4LQ/X1ahE7tRlzQJs83
         B/fX50sHZcunn08cNpya+jPj2EJ5Lb0qncvA5qvBDLBNO0hWwQX9XnzjaOhwzgK2Nsa+
         lJ2XkGz+aBAlQRJrqQ58JqQt8EiFJ4fB3g2yRlW449TnTYy9sc2xASl+OVFRFafwxGG2
         cSsF0NIQo2XKnvQLYGEQL0ULPItN6yPdT9pJaMIoZgWqlDRJBypfNwKY1syk8jmPsiKm
         cXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731384; x=1741336184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvjGL6WGQQQmr6eQdBwTa2SVh5uvK/8NFNU8AVIQAYg=;
        b=Yq8FpGddN0TZfl2ZzUhjgSvavM/rM+qmGu72PFLC1MtrVWhRC7tIQpplo9komAsyeP
         rDyOmxFTHwM8fxuUMfHfQp4FuKJDDEBH4VXIwpgj/1vZ0tHzF1ycZBms4x/UKS9HNrHM
         /XJydRiEoz8ZN9iqZpcNEV5rMJ/1MR2z78WT25EBVnMTCK8V1j3NxbNVfll4mnAcdh1A
         i6dikDKdpnlphtZLUiVh29rJg1LJp+Td09rSTfAU+XIJXHEQLaFgPvHjhiBigOx/0G8M
         c6GS9zuN+5mTHH5lySzNPQhWXPQVfPBmwUbAzyI4bQG3a6xhA0Yanfy+HxKQYTyY7mBI
         +Rog==
X-Gm-Message-State: AOJu0YxOYrfY9PWAI7S7DIVMCGu9dvVfeWB1wXQ82y17rT3BlHt3JykR
	yt1C+kKD8ldCnUSNPKMpDojEX2pPxJneVvgjnsBAD6iCx/sHAA8vyCYqDNqqQ6J0p0R6oLPR39E
	aC7oPz6SesBJNChiRXkdgHx+xO6iE4KZwzEvg
X-Gm-Gg: ASbGncvIun6hxqwrCe3igj5MvVUqCkwdGWALuHLXyjNeUyLu0fy+TVRubYlQH9KwY+U
	9ASsKk/nrHg8do3JW6jxOV2Hz0ZJXwWIGi63yTtWt2F0rdUxXd+IMtfVFpVeeheILtcdqTpYYXm
	EKXdZYo+oeOxlBIORETNdWQME1XdPTOAkmp1Y0iOS2
X-Google-Smtp-Source: AGHT+IEAY9xJ9O1JI/QmjkRb1OfF8IXzGgEH9KQFTqoDw+pqa5YpSG1WYWYNMY0dAy4yOaGGgz5EaK69N30PYilb0SM=
X-Received: by 2002:ac8:5fcc:0:b0:472:4ed:40ec with SMTP id
 d75a77b69052e-474bc04dc8dmr31648411cf.8.1740731383739; Fri, 28 Feb 2025
 00:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228045353.1155942-1-sdf@fomichev.me> <20250228045353.1155942-2-sdf@fomichev.me>
In-Reply-To: <20250228045353.1155942-2-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Feb 2025 09:29:32 +0100
X-Gm-Features: AQ5f1Jp6fwUGY-q-bfvAEpKZGsHDRGDIfdn1DLfNk5L7tbYJI-1n0zAqFpVmSGA
Message-ID: <CANn89i+EX_M-RPasCXct4FEA-VsRaw28_aB0M2cMvsv3XfLpoA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 01/12] net: hold netdev instance lock during ndo_open/ndo_stop
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:53=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> For the drivers that use shaper API, switch to the mode where
> core stack holds the netdev lock. This affects two drivers:
>
> * iavf - already grabs netdev lock in ndo_open/ndo_stop, so mostly
>          remove these
> * netdevsim - switch to _locked APIs to avoid deadlock
>
> iavf_close diff is a bit confusing, the existing call looks like this:
>   iavf_close() {
>     netdev_lock()
>     ..
>     netdev_unlock()
>     wait_event_timeout(down_waitqueue)
>   }
>
> I change it to the following:
>   netdev_lock()
>   iavf_close() {
>     ..
>     netdev_unlock()
>     wait_event_timeout(down_waitqueue)
>     netdev_lock() // reusing this lock call
>   }
>   netdev_unlock()
>
> Since I'm reusing existing netdev_lock call, so it looks like I only
> add netdev_unlock.
>
> Cc: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Eric Dumazet <edumazet@google.com>

