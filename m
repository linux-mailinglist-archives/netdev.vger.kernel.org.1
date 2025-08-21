Return-Path: <netdev+bounces-215513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEBEB2EEC0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366983A655E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2E2E62B1;
	Thu, 21 Aug 2025 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhKGTfZC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DE194124
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759070; cv=none; b=asOLpEDlJccQeTBUAa3Wuc8wdWJ8Bkc3p6NwioMHcyup60cKvUTsVZEYIqq4pXUe60uYr6NY6BzmtqSVyqmU2x5QzKpHTDtyCg6EpC+C51WKo+Xja4NGP5N9MS1TS0rdl5dcDkfXmKlTg8STSuFWaWZ05c8mOIdbahkg9yzWa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759070; c=relaxed/simple;
	bh=+N9c2nmhrEAtSojw6V2yYCyrvOisRYaFakQuHyDJd5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDqMmaKFKmMEbeCdn6uvq/EUc0CswhzvnW+hSN3p26eBIHxAHkHLpHJZ1s8kBxHK7VS9bdehPSvaEyk0jUSlq9xAzV2FyWDmh6WMjAjOqheUM1cPQXguyVem32eVApS/90e5LrlSvY8esj9LTJG975DZjTM0/y0wdPbYJOfhOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhKGTfZC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b297962b9cso6360311cf.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755759068; x=1756363868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeERQiDkcLHsHzjkvcpYZTJ+xwVE1J6UoZnY1+hyELE=;
        b=LhKGTfZCqIsY2CI1z6iHuscillBNLG3YI/O0StQVS0ex6AlHBo3Ozudx8vZ9gk7mf6
         RI+h3rfEWL3GrJJF9DvbJ9VYMSVBMLgwR+bY52ixPjfyqCi75Kus9TAopd9THdWYIoeH
         vwigpoQUSOmne9KAFtNCGzjYd/6YVTApPtT7gVBY8f4uJE4K2NEY+erqVCSKRmrPrOeH
         vmcMGmc/xhgijfnC6ow0hPa4omVUUh+iZSTG5qJr0msZKn7Y3Vu98oiCD72yDpQOzYWA
         GmeTSHOz0CH0HX5d+QKt7Dt/VboAEzReKFlgcjAF0IbwPKxK02/hWluODQrW1L98zFPk
         inBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759068; x=1756363868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeERQiDkcLHsHzjkvcpYZTJ+xwVE1J6UoZnY1+hyELE=;
        b=BfBeHHogZRRtA59EMHvAc20qm9e4HGXvqSfjzp8Bt2Q65+mUiSaNwyAYIvVQqmqDnN
         OhjGxYCDvRh4BKtXbhJtmlUzZY2hP3AnwhVyyIQjrxih77iMbPkZFkAoZ6qPsTsAdAto
         Wd2ZsIMi60mI86KFpy0fe1x9DmGP8eWkNa8MOohzTz1c8abksHMXRP/FXU6RK+9Jsf3U
         uyUJkduSPyASEhdd8JB1vO8u1MZaWjZ4zBdqZW1sYupZWNCIKUkeEqxSJ1vpXVJtj0Q5
         Csq7n0rlmavb0hA9chHqSZPLQiMTyco8qGT55R/xyXZl8Hv6T5URUyiacjQfysqs6Adf
         AeQg==
X-Forwarded-Encrypted: i=1; AJvYcCV+NEsi2UBFiO/+AISYyzIq0DU9op9oWXWfy7mpmVS/T3AaxSXUZkvfwjJ8N5NZqEdy9P38bdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Owc0wc+RvxLJnqpeo2TzmBpVdLhD8Nzvtq8YGTYeIqtxNXPZ
	aqxONjXZgQNkl4eEhQPydsMnyTrnP5LjHX3rBazYnCrtd5lPLwM/vwAJ3ZE/pvloAEWk9HcC4Qi
	Y9TJJ3yPY1VpwEX+6DbOPRk5rjsvlSwaOCihqXFVv
X-Gm-Gg: ASbGncv7FeSXo+2zN4525O6vsofG6wNeguAkfXR72GBknix3zgZMTyWkNGtLIMZmDen
	iZPqs/oVggZZbl6T+5cSsqbjwl1XGU7SPXosijh7s/0Bk4yZpucABAYNGF9nyKlplDYFjYLe4i8
	qAshmxAxA9Yd8fw3siYL/jTVedZ8uaU98GectP+066rOjlN00aKgyeprr7RJGUQbgz52McgpNc0
	tzcFt9ZRLe0i3U=
X-Google-Smtp-Source: AGHT+IFB82nnsQYUBUP8M4vS7fWKAylORNtKfwy3k+z6DPJXwo/FZ67cp+MtY71pEO99NgOJmf5ivbqKkUqPPmf13OE=
X-Received: by 2002:a05:622a:2b46:b0:4ae:f8bb:7c6a with SMTP id
 d75a77b69052e-4b29ff97ad0mr14727891cf.54.1755759067875; Wed, 20 Aug 2025
 23:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com> <20250821061540.2876953-2-kuniyu@google.com>
In-Reply-To: <20250821061540.2876953-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 23:50:56 -0700
X-Gm-Features: Ac12FXwgMWAkc7KFbCtNAapst5wS3YpLc83D9WXzhIaCopffmuEoixYdPdsDLKc
Message-ID: <CANn89iLmj7vFhONUPGqCDZinBXy=q6kdG2bXVvsc5KmtTveGBg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/7] tcp: Remove sk_protocol test for tcp_twsk_unique().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> From: "Kuniyuki Iwashima <kuniyu@amazon.com>

Oh well.

>
> Commit 383eed2de529 ("tcp: get rid of twsk_unique()") added
> sk->sk_protocol test in  __inet_check_established() and
> __inet6_check_established() to remove twsk_unique() and call
> tcp_twsk_unique() directly.
>
> DCCP has gone, and the condition is always true.
>
> Let's remove the sk_protocol test.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Please fix the From:  because Kuniyuki Iwashima <kuniyu@amazon.com> is
no longer a valid email address.

