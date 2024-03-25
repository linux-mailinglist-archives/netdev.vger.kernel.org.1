Return-Path: <netdev+bounces-81631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734388A8C3
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EC01C622D7
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E514A60D;
	Mon, 25 Mar 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu/N5hR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3312C550
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376178; cv=none; b=m4sZQjdxWNp0lEK9tCJJ+nuUNONf0R3YOy3fIsN//hTiHlxEpOwA425YkZjTKlPaiN+rAMPdrNw99ytUuVoDf6FHtK3UJJ+xR+/4mzphVsNUsNBBsrS2YWhgqgcAJCsaAcHZZfDs3inwhOFGV8YXRa63UDTBkJ4/WGnt7ApOGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376178; c=relaxed/simple;
	bh=SpZ60Q0TfqOGJSLKmBZf/3y4n+NuErqApBO4Me4X4g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkWAam0q3fVZZiJKuXwUiOQQlt0jjgHZ+OmUpxFCu0Rn9VEaV7V0ZxNuk8IBq2G6smOLsNG//o7uZsCChpv2LeLh4nWOLv//effXBgk6d2YIGxMKcAwf8OeNw1cVf+QDV+CBGBrVRbAZQnW7usH4Kj1zVaLpKV4IvYYSas6E/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu/N5hR5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a02c4dffd2so3036736a91.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711376176; x=1711980976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhNfEr1t58MDqm3Xeexn7iubwQiKjuw/9gL75PjZE7Y=;
        b=gu/N5hR58aw/wrE8P5wVOSzmtieo1Fd3umktgnMfsQJsneBiGdqNLnxrQj6LqxYjVA
         Ipw4MmztazxnjCgPByGJT5KMughBRGz7EPpCNrDKbkSTqRAtT1a1A8nmsq4yvppTnoNH
         QL8OvLPQ1rt9rJzfHwRvxhT5R+8geM92MhRtD5+X4M3PDANmvqY21US7Hk/1s3G9Xnuu
         EfyZj3QgQGpN728zHANjUcQ9MSdMDMQPoWiNjh3b4UUsn9WPd2AAD8+VjTQiBxjtLIsZ
         N+1ub+ifpiquFrCO50vL1ncYDGpuBUiYjrYdCdMhwqPd1430bwCYDe7OnYmivMFLNW9B
         /iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376176; x=1711980976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhNfEr1t58MDqm3Xeexn7iubwQiKjuw/9gL75PjZE7Y=;
        b=UAOnAuw1FMgeykmxIEYSI2HL1rJceqAjKFGf8d4KzoAkWUNqOf/udzMs91VKgiyMYt
         FJD3C7KBI/YUVzJ8NYQNv7No+rzpwF1JQ7cs3IPfgAgGmPuKKTbKugHqRTU3vLrFcnYy
         Dq8tQ3xGdUBlLellptAVRG8mKxfmCLD0k11q+MwquE0/GNJ+N6nXK6aEKKcx/4yC5pNo
         wAEFc+3g1omWu8yumn+6m1S/UxQ53zEWErcDFBibrrhffcOxD9VXSFLfa/LtL6wMzKdJ
         RgA4nK6t+rb5ZaoZBVAE43judbXg4y6mw7trXxOSPXvNs/OIQs4ZE31gff/J5X4KuaGq
         BDkA==
X-Gm-Message-State: AOJu0YyIXi0z3Ae96f+BhzGyOI8GRYbKO3A4qAduAAGdB1a56CMmvC33
	bt6J2nHdAgoajE+rN0qW/DCGRGXBl+pxG1nQhs+8FahOk/BesFXPPvJNY6KsYHg/Xa1T1Dojyq+
	ztf6hsoquCBCnakmmZaKpzWPA/OFGSEcy
X-Google-Smtp-Source: AGHT+IHNEVjQnPIlPvJXozv9asVirCt2QJsHzybLrUG2pwWHg/gtuK4dwqXfmLkAQigWSQ1LFaZ2D6uY6h7Aps/1zBY=
X-Received: by 2002:a17:90a:1c16:b0:2a0:1f2:e3ca with SMTP id
 s22-20020a17090a1c1600b002a001f2e3camr6674168pjs.36.1711376175924; Mon, 25
 Mar 2024 07:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325064745.62cd38b3@kernel.org>
In-Reply-To: <20240325064745.62cd38b3@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Mon, 25 Mar 2024 14:16:04 +0000
Message-ID: <CAJwJo6ZQAEb6v4S_BgPqZv8W5W0hizvxyzv0K_M7domgOwTEJg@mail.gmail.com>
Subject: Re: [TEST] TCP-AO got a bit more flaky
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Mon, 25 Mar 2024 at 13:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hi Dmitry,
>
> the changes in the timer subsystem Linus pulled for 6.9 made some of
> the TCP AO tests significantly more flaky.
>
> We pulled them in on March 12th, the failures prior to that are legit:
> https://netdev.bots.linux.dev/flakes.html?br-cnt=184&min-flip=0&pw-n=n&tn-needle=tcp-ao
>
> PTAL whenever you have some spare cycles.

Certainly, will do this week, thanks for pinging!

-- 
             Dmitry

