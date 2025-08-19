Return-Path: <netdev+bounces-214827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1568CB2B670
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95A23BAA4B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA328504B;
	Tue, 19 Aug 2025 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IokYRN4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F30285079
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568002; cv=none; b=X7YYMgV1wPGmR1XgAz4j0QVbnh4XR1T7WMlwLJOyDaXTYqYDm4FGaIJLgQqUOqPjywFaWLC0i0igqFB8/e8T6Luy3RcFsaCYlDJMjstBoYgeaQXa9JuRt7qHYXsfe11kZ4gKvsEtiV0cG/TmyrdH/clmYJatZZKeTZhDAOC4elo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568002; c=relaxed/simple;
	bh=tEGknVAKb+PN/lYStQKRG0VhNOO+rKcQSO2jl7NQgp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZeJce6/DWN8cmA1ODVHO2/xWELmYp5CWAHcyJcb05I3Fz+Ju//A1Mo2WPEhPAECf8bgDWL/qg6Hqqmc7BPil0B++tiaBVBnI44+dash3txJbiLVP0ygABvVG+O8LqG/KZHr/+8tYyg0fncOzfNvo7xoK5MP1/H331tSUO/dppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IokYRN4M; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55cef2f624fso2456e87.1
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567997; x=1756172797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEGknVAKb+PN/lYStQKRG0VhNOO+rKcQSO2jl7NQgp8=;
        b=IokYRN4M43p2bMRqsHErNjuCfRonPyDYs0/z/4/QCe2o/E73wCHKqUlM5yxowQJUnc
         ik5DDsyjaF1790X/dzdS1Ap4t0BgN009H2yg4YjW682QyQOskarPQ149oKa4YVHWdEzc
         FosV+35D4DOoEMINeXE1pWUaqXZxZjOabuLBRjJYU098lhpBQBHnmH8E1GPAoGcyPEAI
         CVSf5AI9V6kUlRWOcllnbS3uMt6+OyiSbrD8jIwQtiBsUzqmr2HB28ixuQc0OMSV/YBt
         FrSr8l5jDqVwAv1HJucWyy1esItrmXIAn9n9ILCtb911EJjBLoLoOOF4QNRA9tqa7MAL
         0gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567997; x=1756172797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEGknVAKb+PN/lYStQKRG0VhNOO+rKcQSO2jl7NQgp8=;
        b=r/eeDW7BqE4qWAxENKzk86hbtiodGKu2t1sd16apnG1pGmAcVb20kgpLciX8ZTFBab
         zCCrdLgPsCqkpdFujrhT1eqcBvREVRsh2aJ/K1j+HOZ1drFH4L9DZHY12GHKw/vlpQSj
         WFeylB4SCqNJgE/t7CkWsZaBHgi6CYnMEB+ZMLxcQYcoakrG6kBGmO8to/WFQACXviig
         hjU3ELnn3dlg6kDpfmyLJA9xEd7pmTnNP1bfGZhfpsH3qJxJ4xaxjXEWayfpCTvKQF9M
         AAYRzWfBwkJ14Yh5LAtv8IXZgYXjhmCEeqCpILeQdhIOCfBpQ/eG7RilJl6bbt9FepHW
         KxvA==
X-Forwarded-Encrypted: i=1; AJvYcCVSRWs00+atwBKntb50+C3McBWOSL3BD4tx9gameKR4QqMI0lMDcK+T7gpjqTSCMeRSjtu8Asw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5e0Lm6JqEPzrBpTe/ZOKK0xaHUMXkIcnhMXhWG6aIuXADy4x
	jjw/ta7vTrS/0tVUDafJwUfj6xLBBC6n4B3wiq1rsmzTwjm27CRsmCz6oct0jdmpqDEUWlp6ajR
	Hg53Pzq5UHa+QK5sFS9ykqhdmXmvPHEcKhffIETPM
X-Gm-Gg: ASbGnctNRgJoF4ruRvhDSnnZiWl279zDBl5SnsIB2YL/2iVah1T6Uuoo7Oo9F/zrH/p
	qzQf15CycF0j3Qc5ej50TIf1liUPwzWYMT7zV4vdgFdTGPsXnwHfmPzIYQR0tLPkre7fU6tzsU6
	vAvdaTTKEzcXYYPLSHm5kcEVlyMeIDi9mKbHsKh4pi1SHGt2uqXALT+ZdYXUFKXnS7ixYcPupvu
	F1RHXlb0AYeJS4=
X-Google-Smtp-Source: AGHT+IFMUp3WY4nxgsRLh9qsELNl/XFP9KJPv82ZlJwh8Of7VRvx5KMBcmdg5ew6Blf3tzjdDHHPFM335ASvYbURfxM=
X-Received: by 2002:a05:6512:e86:b0:55d:9f5:8846 with SMTP id
 2adb3069b0e04-55e008bca39mr113505e87.0.1755567997069; Mon, 18 Aug 2025
 18:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <8669b80579316a12d5b1eb652edb475db2f535e7.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <8669b80579316a12d5b1eb652edb475db2f535e7.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 18:46:24 -0700
X-Gm-Features: Ac12FXz-VQtX5NnWQl1oIQj3f2utu39W7Ga73n3qvm15FFIanSkTTYHkB_pEaFw
Message-ID: <CAHS8izMO=6oHN4w9XiL0yw7x86LF8iw-LhMA4qZe2rXOu0Cmbg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/23] net: clarify the meaning of
 netdev_config members
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> hds_thresh and hds_config are both inside struct netdev_config
> but have quite different semantics. hds_config is the user config
> with ternary semantics (on/off/unset). hds_thresh is a straight
> up value, populated by the driver at init and only modified by
> user space. We don't expect the drivers to have to pick a special
> hds_thresh value based on other configuration.
>
> The two approaches have different advantages and downsides.
> hds_thresh ("direct value") gives core easy access to current
> device settings, but there's no way to express whether the value
> comes from the user. It also requires the initialization by
> the driver.
>
> hds_config ("user config values") tells us what user wanted, but
> doesn't give us the current value in the core.
>
> Try to explain this a bit in the comments, so at we make a conscious
> choice for new values which semantics we expect.
>
> Move the init inside ethtool_ringparam_get_cfg() to reflect the semantics=
.
> Commit 216a61d33c07 ("net: ethtool: fix ethtool_ringparam_get_cfg()
> returns a hds_thresh value always as 0.") added the setting for the
> benefit of netdevsim which doesn't touch the value at all on get.
> Again, this is just to clarify the intention, shouldn't cause any
> functional change.
>

TBH I can't say that moving the init to before
dev->ethtool_ops->get_ringparam(dev, param, kparam, extack) made me
understand semantics better. If you do a respin, maybe a comment above
the kparam->hds_thresh to say what you mean would help the next reader
understand.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [pavel: applied clarification on relationship b/w HDS thresh and config]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

