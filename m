Return-Path: <netdev+bounces-99286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0768D449A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 06:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6141C20ECC
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E51249ED;
	Thu, 30 May 2024 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEc8VTaF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09FD2CA8
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 04:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717044314; cv=none; b=CycE8SgMyRYykjCKboxIfQdlJ74zSAs5vaWquqPyBrf455BosJ49mPWQNtpZwBQ5AsV0KqFGOKmHH3niI4WZV9z4BxwtL+6KpI5ZKhVHOzO6d/NYde6AWPgUcYlMMC0j58EXGn4ROSqPkQKLb8tfbQm8Petx2zxaM0VzVLSneOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717044314; c=relaxed/simple;
	bh=CvGhp8LXGvn38FyVflkKFx32xm3EYQYIhAgCsHPJTyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prQJWnwqJEU56ew4t/pPA+pgUcpJfAGWOV9TCdUKXETApgDpjg1W9XuHCkynP2I9d9315IoUwHbEf4CEasVAUT4iOGb6N2GOWADthMJMIzwvTFVnSaiSpew7L+Q+mrEzKuaNxTZFHzAvhe1swwUt0yltpXPl/rTFD48++WKApnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEc8VTaF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-529a412a2cfso1273e87.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 21:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717044311; x=1717649111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvGhp8LXGvn38FyVflkKFx32xm3EYQYIhAgCsHPJTyo=;
        b=TEc8VTaFf1TX1Iz+aOEIvTAXAhrzZVJwpf/vrax9TLUIIqEPUSeB/kS+WpKo/HSRMZ
         7GXdQw8IZIHwYHlXwk2d0r+RhsXNKWoZMQ6EdDJL0oWXyi7JeJx5ork2W2ZBbrEK6U5W
         lTK16wABNs+KPki3ZxHj60NWVcILEqLecq5RAfxEh1fhZYxIQUgLdSS2iI9K9GojQ0tX
         IKOaZjzZWvoztIZGetRJ5+/ZnO8l+8PQ4u8qhMNZnLx5VY17IVmiyQfj49ycLcvGlUR8
         nnQ2XBI9aktFt/PX57boOgkEM3q3MT6zT4joBRny5U3yTWEAvJTvLG43tZr/9Pmzkr5G
         umpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717044311; x=1717649111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvGhp8LXGvn38FyVflkKFx32xm3EYQYIhAgCsHPJTyo=;
        b=RksW3DFRcmXdGJlV+WkyLthYHODQ5qPqKyLjJgt7AOJweoiS28a+QkRzlom/Ux9Nmj
         NHpUE+hiVtOgsPa04YUVIWPqzqOBFxgHUiypKDxKeEY9YGbu+caP2OEhPeTWUowAeWpI
         ootA5+3xgIugyFBzkgUjNlZmoaSE7e5bLXPeiQ946+bdWbKujAEBHaLKSumThgXM8wNi
         ptgnqZ04Shnejzbhn05hCGzXa9QW2/DJzi2n5jpGpO0o5djkTvIIvC3afRmSbzX/d6p7
         4pNxI1kun/lCDVm3LDwAMPFGwvocuHMmwkhxJJIMPYGBXpc4IcjzaC906o0770hEMbUT
         52QA==
X-Forwarded-Encrypted: i=1; AJvYcCXOu0sfs/oV9HnuLaQ5C4qfGlr8BWLDUqFIj+Dq3M5XPnrKcHJyo7YBLtAFbXc8f6F/OfvvBgIPzY7FuargJE5uC38NcyLq
X-Gm-Message-State: AOJu0YzDqwE+e22f6DTph5gxiGrdr6PKoLfQ2M5n+buNnL9i8x2izwJF
	YUFf3W0oqroc8IUkuK/gamMwMQu75oqGvpkkT4qIvpmoaDDzf+hfTFuj08/F5Y6MKWE3ga06wtX
	+Qwxi4K1GE2d5vZ10iQrDc8L+0Y3TwGnxOo8x
X-Google-Smtp-Source: AGHT+IHyw3TnT8NGiIyVQ3+szm7XUG9/vyoVEcJumH7+5VWCevgrk7+C/km3sX8hagT2u4Sif/BbBca1w/Ui0UwYfLE=
X-Received: by 2002:a05:6512:512:b0:51b:7ff1:49d9 with SMTP id
 2adb3069b0e04-52b7cfbccb4mr90415e87.6.1717044310468; Wed, 29 May 2024
 21:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530032717.57787-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240530032717.57787-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 May 2024 06:44:59 +0200
Message-ID: <CANn89i+MmOqo_=0sHzs8w3mT5uNXN_EAJO=teO-qYsxCPM6hqw@mail.gmail.com>
Subject: Re: [PATCH net] net: rps: fix error when CONFIG_RFS_ACCEL is off
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 5:28=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> John Sperbeck reported that if we turn off CONFIG_RFS_ACCEL, the 'head'
> is not defined, which will trigger compile error. So I move the 'head'
> out of the CONFIG_RFS_ACCEL scope.
>
> Fixes: 84b6823cd96b ("net: rps: protect last_qtail with rps_input_queue_t=
ail_save() helper")
> Reported-by: John Sperbeck <jsperbeck@google.com>
> Closes: https://lore.kernel.org/all/20240529203421.2432481-1-jsperbeck@go=
ogle.com/
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks John and Jason !

