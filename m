Return-Path: <netdev+bounces-201619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685EAEA137
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1041761B5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D412EAD0E;
	Thu, 26 Jun 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgukLk3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AD2EACE3
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949111; cv=none; b=t0yqapgSB3VzLDsRz/hYi8AvR+xQ5BdKDNuhN8YwRoF4kx2bOZ+RWTLINm/AqIaucCmnFTf3eE1GojlZ7L0Sdsirnv4HB6BekVD2EgpwJ1Fj8E+6acD7835xd5I8IgwhS/ir7fdJ/sN7ZvyXsxiN+M9fDjZr8p/p76nnnPDhfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949111; c=relaxed/simple;
	bh=e+gsRV9FF4hkpSUjFcDjLpDBVZY/qZIjVEe/Jqlzs9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gm4ZB1HwyAmVW0eicEB/yKhT+NS4qNY7KkD2OBlQZuUVXFh63I0/z+TRGgxz20L9VXu7QNMp8i4uOCEq2sK+3zHroRSnyTj8pD23Bkaam4rULrcuBCseKf4xUET9cCYIcVf/3YKontMzg/gKscCce6L48zjLtcX0CvkoasUbgPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgukLk3b; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a5903bceffso14950251cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750949109; x=1751553909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+gsRV9FF4hkpSUjFcDjLpDBVZY/qZIjVEe/Jqlzs9I=;
        b=cgukLk3bt7Mn2nDOZ0cBbtCh2CZxNjPfTWf/8Ez+IGvSmm8T3ZNc8+MzevLs2wLDgp
         LzosGW/RKpWJe3suHXj4ROMM/R5AbuSyjEKglnJPFF5DA3dhhIMuma72j9PaXLgMaUnT
         74pJ25CeKvmVaWyy1tmVf6n2KTG0RDB8aoZI3Jj81NXdzZZjWOpVBQRQTELm9ktkc2ZC
         XF2NWBt6Gy53lv6G+2/SsorPlmMd8W9ERxjazvIvHo6KO5YMX2GopbW6VeJmzUUw2yKl
         /1h3CYj1LzWk7K1ruI7BUY5yPAuDRlPxlVyRR2Tbv6DmQiLcriVUma3th5pWswePYuG+
         mIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949109; x=1751553909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+gsRV9FF4hkpSUjFcDjLpDBVZY/qZIjVEe/Jqlzs9I=;
        b=je/cEY5r3kOxl189MMFNlkzc+3BAbPGw8xaG87Lkef87tZc5yKXUwWPWk5CCCYcw+I
         ofeWjMa1QDiMHRI2QvVtEP87i0XzRcS59OPi81dGp8QckFf44fhHNW+vco6g0aG/fshC
         8zer3SJCQCgNCF3mWG8/KLshhf730nmx4K4Frbq/tvushU6pdJZEviopCQYDvWaujoFn
         bow71UIfUlWTGmKgB/Cau1TGnArvEbZy5LVVZMG/SWgydR0dW7kfbWr8Lx/GWZ2BITur
         TpNqUng+GTJaU6XYE8oDRktitKHVHNkQG34oDsWhsd85lL5KF1NeZKUEIx10JVCtVYXz
         XaGg==
X-Forwarded-Encrypted: i=1; AJvYcCWVEEZ+rl8aMvYD9v/FrZVEx9H+RXpkjPpiwrA8qgrHipLWP2ayOkwtF1ImQIRlOnZJfx8eBKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0Wsm5lRSXHl8AnEyBw+oji/RtXijjvPv7+wrEHbuQCeK+5lj
	355BVC7LFPMTi3rmAGVowc4o25eegNEV7o7zFWuZO/HTpMMaoenvdRStvm9IIVdNKn+/3UfCYq2
	OKPvmCSAmZ95KJrLTp66Tj5Vk+F8G3ZosLAEcHRh8
X-Gm-Gg: ASbGncu367hfLBBa8FQ80Egf8D9DsuKI8kAzE5ssA2iLZwTO15nJGhDXwh+v16lvGZn
	GtFsF5GzTMHYJ3PFyaTc/KUuRZJ64ZOD4npdwcItclyGkh30SOU9jIc5BN9lQL5blxwiD7/93Ek
	Adtir166EAaCYUUgpC9KuH7b5wTOLxFYdanbtrdYKBLEM=
X-Google-Smtp-Source: AGHT+IFlj5Bzt34SMqIzyXP6W2HJmsmWujPGga7rNgP74MwWKL59Wl1NdFxk1lAFHxpNQrJsSKTCkW1pMaBHFi3RAs4=
X-Received: by 2002:ac8:5f4a:0:b0:4a6:f5a8:3832 with SMTP id
 d75a77b69052e-4a7f2a1b4b4mr57849181cf.42.1750949108758; Thu, 26 Jun 2025
 07:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-11-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-11-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:44:57 -0700
X-Gm-Features: Ac12FXyuiMXY8IOg6qbC6BGrwGqMKB-3hf1lEwxBfgYPsvERrNTwQaRmBcpoYw0
Message-ID: <CANn89i+FwEpLOMFhH90_HMVsi0XLTU+wY+Eer+1w2jgPg9TWng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 10/15] ipv6: mcast: Remove unnecessary
 ASSERT_RTNL and comment.
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
> Now, RTNL is not needed for mcast code, and what's commented in
> ip6_mc_msfget() is apparent by for_each_pmc_socklock(), which has
> lockdep annotation for lock_sock().
>
> Let's remove the comment and ASSERT_RTNL() in ipv6_mc_rejoin_groups().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

