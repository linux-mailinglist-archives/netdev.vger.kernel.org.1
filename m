Return-Path: <netdev+bounces-122980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27471963546
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE12E1F2489E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9DD1667E1;
	Wed, 28 Aug 2024 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="VDEZrShU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA6156230
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887006; cv=none; b=LDnBdmHk6dLyviTZXp2jQXUoNo4XoVxptsWuYTcJ2nTIt9TZCMhBy278g3BXN0840hdoa18SNfLVbSrXVcjUGbqjXGOA5aETdsxuQQC1UCHunpebqdjcVf6KTk+MD8bcL/4CPbcj2QCAxr26QHxgJCo8XNFccFd1mG0R+O5cNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887006; c=relaxed/simple;
	bh=6WxycaVxQT38O78SqFvhfYRoa5EqgpzzCOzyVVksNL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJzm5/uVKycggHTF3J51MsA36aMDlfMxvAa/K4n/pu04d8i486GMvmPg1rkevoZxanOOXSRou3d1QTJx6XWUjUDw6SUUNxlFrTf22E/8CuwJ+am0tyxHGIINkSzUhaJU+ugJcksbOr3Dg2I6aLtSnVnS5eJwW3DWvQKTbk2b+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=VDEZrShU; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db157d3bb9so19932b6e.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724887004; x=1725491804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WxycaVxQT38O78SqFvhfYRoa5EqgpzzCOzyVVksNL4=;
        b=VDEZrShUDe/CmWkpoaIcQeuYCLcQKX5287UJW+4Z5/5hL6GApkrQtxM6Ge8MqM2Dxr
         SAR9pRMqo1D9e/JNRFLeW81EfKOBHEMPPbNcHSunYzVaAVn/7uzJKKuBkeoP54r48Elw
         blFabEy1xonHkQm/wMGcAXOCMLEoy3M33GWC5ugcGIrHUqvH3eV1d9IkltuiM/AJKuRm
         Ynxu1QNFekRy0t/Ut/aI1KWcG+gk0bboiuXEhI9g0a681wc0jhVlAas9ROL3UgjwRQLC
         egQNXW1Nqf9zMtsNEWTJWUyqY4HN8jE+AOUboFfPRhKfLKQhs0hHc/OBCSjhh3bsni7d
         D+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887004; x=1725491804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WxycaVxQT38O78SqFvhfYRoa5EqgpzzCOzyVVksNL4=;
        b=AaPWLmmc30qjlBF5s8WiwUBIax56YTtt2bkxtGh07CEpJ1fbGv83vn/qAH5w/lNu16
         flxxzbIFzrv5glH4l4x5Od9DVtkpUsodSMfVJGD9wh/lHqJ+J+HIx893MqEY7mbRjWlE
         Vsg8uAb7tGNE/ZtuV19o/hPDySWMvOiGQ7jJc93KiweCE2yyvT7QWk5s3gBgtglvb/Ww
         4+5oSZj0V0uZKZddNuk8SCGCfwR8FQncbmkKFvcvH0U45KQfS4bHTbxHrrbYDjulfpu3
         dqVm9SiP1di0MXxYeNRMFqc/k1hsT8owVOCINJNDsxrIkN0GwwvF6BDVvswbjNb5Bvzl
         X3nA==
X-Forwarded-Encrypted: i=1; AJvYcCWcvDXGziZByFe8sjMUFoWfv3rfrxzBShOJp6iTTI6r3GFC/8ku44nhGuF4bCVVUKHCtHrKZ+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDj8OZdb/9xsBTOE7xh7Ym6OggB+Tef/4fGAHWlyDy2wsneVq
	/IZL87MheAmXqRRnQXAsTWSb0DJqedne1ksCSkdblSplrvJqvVoLbCjXBsBhe4A6CGrAPYKxhFJ
	zzTwDDx96Vg/HNyDbW/vN3BL7Ucap0K8fTf66UA==
X-Google-Smtp-Source: AGHT+IFulYLTr/q0MYpGuiK8dbocOeHO0TRrOPOfH6etK3coAQIF7gKYWtaOzA1GlbWnLpY0TqDn7PU0n7Wei9j1CaQ=
X-Received: by 2002:a05:6808:384a:b0:3d6:3050:7caa with SMTP id
 5614622812f47-3df05afed36mr1403510b6e.0.1724887003694; Wed, 28 Aug 2024
 16:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240828214524.1867954-1-max@kutsevol.com>
 <20240828155758.61e3a214@kernel.org>
In-Reply-To: <20240828155758.61e3a214@kernel.org>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Wed, 28 Aug 2024 19:16:33 -0400
Message-ID: <CAO6EAnX7i0zi840zMidR89UyWF0dZHP032C5o6Ur=6hWQPp2CQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] netpoll: Make netpoll_send_udp return status
 instead of void
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Jakub,

On Wed, Aug 28, 2024 at 6:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Aug 2024 14:33:48 -0700 Maksym Kutsevol wrote:
> > netpoll_send_udp can return if send was successful.
> > It will allow client code to be aware of the send status.
> >
> > Possible return values are the result of __netpoll_send_skb (cast to in=
t)
> > and -ENOMEM. This doesn't cover the case when TX was not successful
> > instantaneously and was scheduled for later, __netpoll__send_skb return=
s
> > success in that case.
>
> no need to repost but, quoting documentation:
I definitely didn't find this doc, thanks for the link, looked at it,
and I see at least another error in
this submission - there's no designation which tree it's for, it
should be net-next. Will follow
the doc for in the future.

