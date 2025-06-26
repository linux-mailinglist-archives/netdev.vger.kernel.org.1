Return-Path: <netdev+bounces-201618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470BFAEA12F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83071888BB6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586EA2E88A6;
	Thu, 26 Jun 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o57ObGyp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33052EAB89
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949061; cv=none; b=PL/YV1uc+9EY0zgvwhIbgX2Z/9gjlTWNwMIAf9LP3WIdzTBMd7ti0fB5RVel7J2sax0vcuyZYj41dBrgrBLrPsDpccX6CvHSYfbIK3Dtf9XRiO8TekakEIUw3NKM8RjztaYcWjTRTmoufzulfSmSuUJvL5KfaCpkw9yr8fAsd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949061; c=relaxed/simple;
	bh=j/tlqB7t8FccoKTlIlcxl6/kCUssD3yulSJeF18e+aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmevOOTunB+NeUU+rTIG/wZsB1SgFzYXVJSVblJ9nCE2ozQ8JFWDdwyZn+ditbJt6L1zMZAlaC1o201JaC6IbeQQsk56YwWMblSYf+IavP+E6p36GiFCf3Ei3QNcIvnI5sEvj4Xa2VnFimdg+DqLtHg9S6DrbyiQw5eufaBOEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o57ObGyp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a4323fe8caso6600521cf.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750949058; x=1751553858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg1zhxrxISiFzpgAwqSg+t9cG/YF3XpoR/m5CB9ruyQ=;
        b=o57ObGypo7DWarmra1A/2KFTdUR2bs7bitDY8VEBGzmXZKW1j3Vrn4LJqWFAYAwjjP
         exqY4W69tCj2u+w4+oqOPK1d7G7qowabWbeRT0HVn5rXfpTgMX2/OoyX+49MEbDwNIah
         KYEnW1NvVhf+pJsq3EWJnrJdjHiad9lPF+zRBiDU5cuoLfsvv8jA2B61Hs7ygxAt+wcD
         eCYEeg7YXc2LjYbDvK9XsQniSo3E8joBK3SoWIS8oaDThFD4lWFNNOibkmoGSeXCjTYa
         DxPxVwWkpoWRPJbEImUdSm1g3MoMprK2gyOX6eF+ssfVS9SrvQBTBJIu16blfx8zZP+A
         A/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949058; x=1751553858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg1zhxrxISiFzpgAwqSg+t9cG/YF3XpoR/m5CB9ruyQ=;
        b=RIPMOJvHAK+aJ5keG+TAPQKRo5GCDQA6JxrTP+X2v23jrh1GiN9pOMHQ+NQMm2ywzK
         0cYrHUlfM6S6TBPItWgbefW6cjHnJ5KTXlW0dLtmoV/coX/5p0GkFN6SvYsp7HD+bc35
         ct2OqvWFfPS8sks8i95QtfHmT2rfxL6W2gP/7/rJbzu7Dlz3ufza3U730p1LnckFtLaZ
         8wJdCBQLNkTrPTGIEGFbTxLKopQBRcEY1qhAvjR8Q4AEnqQFO7fXJv9XiB49jIY6XsWZ
         npX26DXRUP1MKP7KUNezruLHBX79QPUCKU0UrzTeDpw+2sLsWc2srJIpvZ7IR3qbAx5W
         b5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWRCQLZRtcPUk5kFibSzlM3XUuSgb+ATQ9lfTY/wjxaFFTIecNMdXGUGLOe6Qq3LQxzTeNQHpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fe5hHAqFvjcct8U14BQkW9DOTOg6jnzBNwdmFA57NRjgd2Nf
	0h1IG3dNl4xntLqqNoZZYe5ITOPgsus2fGqag/RbOWg+NuBsNgoiVsT9LY6h0H38aeoH1PmiNse
	7PHeg2v5NTltrFcoDzMZGIumvGIY5BWW3dSyiAqfg
X-Gm-Gg: ASbGncs5wNi0h5WLjWEoeNu+uVJGlcu4XWfCVcG2r4w/H34pFIpceR/5VmolcwEOBLu
	PeOskGILFY5Z/SG9ibKOK3O11j4K0kuHUwGpJEuweGu/uW3Fo+lw+V0jteS7cEwUUw2z8lfgIvM
	9fpjsoyvYf3j34ZEkjjzhjhXTuFH/z2eNHBGJ0vheqEEk=
X-Google-Smtp-Source: AGHT+IHWJRmHSXdYCKHz4xS6JUJg8PHgYlWBjoR+4WRVx/mvcOjwI9XduqhQ/zByC4RVCZNQ8idymuQ3qGwT1P0l+CQ=
X-Received: by 2002:ac8:650b:0:b0:4a4:3766:3180 with SMTP id
 d75a77b69052e-4a7f30c3d5dmr57533651cf.47.1750949058160; Thu, 26 Jun 2025
 07:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-10-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-10-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:44:06 -0700
X-Gm-Features: Ac12FXypeM_xWLeu0GzgPk_Ak3AEeQ2J-2tkdpoXaO4lCbiCtQ8zGbPcaKlr4f0
Message-ID: <CANn89i+zxB0cq55RLC5MdJLkcbDiWAjZfO5YDDQ8gLrgeERbng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 09/15] ipv6: mcast: Don't hold RTNL for MCAST_
 socket options.
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> In ip6_mc_source() and ip6_mc_msfilter(), per-socket mld data is
> protected by lock_sock() and inet6_dev->mc_lock is also held for
> some per-interface functions.
>
> ip6_mc_find_dev_rtnl() only depends on RTNL.  If we want to remove
> it, we need to check inet6_dev->dead under mc_lock to close the race
> with addrconf_ifdown(), as mentioned earlier.
>
> Let's do that and drop RTNL for the rest of MCAST_ socket options.
>
> Note that ip6_mc_msfilter() has unnecessary lock dances and they
> are integrated into one to avoid the last-minute error and simplify
> the error handling.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Same remark about lack of one READ_ONCE( rt->dst.dev)

Other than that :

Reviewed-by: Eric Dumazet <edumazet@google.com>

