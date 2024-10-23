Return-Path: <netdev+bounces-138307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DD9ACECC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BC51F244CA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833511ACDE8;
	Wed, 23 Oct 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rauB0Sqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC702914
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697424; cv=none; b=S0IEIXb3g+Nd5NieSZA9mM6LWTePFrVhX5Q1fn8GByhdhREsos62oEyzE+PODMiwyyOMQKlWaCAjakYFlm1miQz48vZjKaKXR3dtc+tAZs+ot7P1tCVmSeTylGtfQsOkPIFQoviXWnu4qBtTTAyrywqbFut/YRMiSUYsjT4qSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697424; c=relaxed/simple;
	bh=4BOZC7Zc0QYmVmVuZEJfkwViPrDWvOiqSf08wEN+G24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWZYErZQzPJLboql0oeNSDstkmag/gHWHnzbbP+NBisugj+S15dZHHE+26yTCzUdsXl4d9v3zAmxaAIVwpjs2K46Frk2Y00JfGu/Ia1rXVWllkU4tpxGTL8dx0XOU7Be3xEL6KxGgKs9EGuXzorJBNOjxbc04BE9fqRzYMg+3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rauB0Sqt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso7415924a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697421; x=1730302221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BOZC7Zc0QYmVmVuZEJfkwViPrDWvOiqSf08wEN+G24=;
        b=rauB0Sqti8fORWc2uQ/ZuUn2j90kz9FccPRhIMs6zknZoOIUFM5jKlpveLd6yexIOh
         ZhIDL1yoPAgkxpcbvnuFeA7OQiE6wEs7RMM22sZ8jVbGsj9fYIonZ8q+OF4lLMDA6F23
         syTDoZsQGawDNCiIoHz+fcde0gURCXsANS2HuFedzkDvBS7C5XR7ntobZXqU2VUC8DfC
         MmN5s01Ini/aowvrhMNIkXRPhd/VNaYFs3aHZZrs4xAx4V1SHtj9bD/J5k7Ir1CnYHhX
         9qSlEbUIWTpLTwLBWU8ih73i8kGKRtN+BFjUjH9xoTS1bkXCDDIItbA3uu4/xjsOASTo
         HQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697421; x=1730302221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BOZC7Zc0QYmVmVuZEJfkwViPrDWvOiqSf08wEN+G24=;
        b=Q+vuosFrIfSs8Y1YwVwAY8yV0nwDf6oKk0y2jIWM2RKBs94eMdLup6saGYxAoM0dSp
         wRqu4niBxgY2tJ+XffyHE794qtooYhjxjB7jfBLGasqIIDxvQp8+g0ui/Oh/Jmu5al7t
         3+uRgyS/NyxHRo4EzOamgHHg+gXtdg+XmCvzXHq9NChYTWAvjf7yM8mZWKygMHAGzo8m
         /05jNJiklPHlFwoU1B4piDODrPKc/esn091Png7lmQ7HCWgXQ2NE0CVPFvcP6atRj9wg
         6Uw15fVIojT4WsJIexEn2dBucTGHI5BahE8z9RrScKwf/9gdgrWM//8TJ8noGYw44p+6
         DMYw==
X-Forwarded-Encrypted: i=1; AJvYcCU6f5eix+R3O+ZJDK5wOpekkKwEZBjwhU6CnEEMprhbMnSq7+G26SGwbdDpIcXjkfjzNfbwsIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+yDSzGnBfwKONekpATeNRCY494MBq1Wuxi4AxixUWJ3xXhzT
	Vrj1voKndMeFRYKKvbdcOkDTMzKB4VvcdoohdzzIyZo6D/Ex/7PRbSskQvcJLScS1YoyKGhLyo3
	4nFKQKto68HYFcuiwHlg7/hAAjuqV93ZfpENL
X-Google-Smtp-Source: AGHT+IES0RQ6QwdMO/ESJU3KxMgEj2Y/pJX4mUTyLTBKqz/X8sFWQy063IEIrZCvPNylhgphZbAxSzHUQJpV2IImz7s=
X-Received: by 2002:a05:6402:13cc:b0:5cb:6701:d1d0 with SMTP id
 4fb4d7f45d1cf-5cb8aa2d49emr2557536a12.0.1729697420588; Wed, 23 Oct 2024
 08:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-6-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:30:09 +0200
Message-ID: <CANn89iLss88g6dvZVYPDZ7OSyPSfJV97SLoq-R1BKm6eTKG8kw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/9] phonet: Don't hold RTNL for getaddr_dumpit().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> getaddr_dumpit() already relies on RCU and does not need RTNL.
>
> Let's use READ_ONCE() for ifindex and register getaddr_dumpit()
> with RTNL_FLAG_DUMP_UNLOCKED.
>
> While at it, the retval of getaddr_dumpit() is changed to combine
> NLMSG_DONE and save recvmsg() as done in 58a4ff5d77b1 ("phonet: no
> longer hold RTNL in route_dumpit()").
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

