Return-Path: <netdev+bounces-138783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFB9AEDF6
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 19:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B41C2330F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D851FEFC2;
	Thu, 24 Oct 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dInqIB3R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A61FE107;
	Thu, 24 Oct 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790790; cv=none; b=UAJcwZdwK+JmmXWc3gE1wXiIXAUdODw4uJSTAdhnIANbLQ2ifndJhKqtlm6QDKWgpFbBYmFacd5lnaUzcPiDnqRjLa8DfpiAZk2o74FCP9jGawUlT6SLJsadrQkk++QbsBNAQP5nlf/Cv5EcIyVZ3UtiyRf7NHjX0gU9FaOPFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790790; c=relaxed/simple;
	bh=uyA62426iCGfJjQuEXLHddgjcLqfe7HQ197e+A2pODc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMELQUQ+DO6ouZ53QuXkAddhDaUI+fiqQkjR/4h71i8+UK4e0RI0JYKNuBpvipbKAX8EzJifK2bToLmFxEJ7rbqaEmaV6Vyt4U9K7RYuTriwlu9GAxfjKwAZUf7luHzcqgskwa7AbXinW6WiDY2OM2VAkHCl0nevrElOUDbUSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dInqIB3R; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2b4110341so180195a91.1;
        Thu, 24 Oct 2024 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790786; x=1730395586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Cmyp2pbCrnL8r6TKnpyqShEFdJNBNPbRm5jXu0QNwc=;
        b=dInqIB3RwGG8wd/qG/pSbwOs3aiQPSU/YWBTxaUc5GxVXmFDNdRMRm0scTdZ65pdnH
         mcXajvPHWcBCvK0CBoRL68J/rpgMeb4qn39eq3QH5XLGJZh0TWXAMvwiQdHlYtUMSWek
         y4ft99D+sjkZXkUAtHDBlHvJPh/rvh7R3tDuLCTSe7922uSbXJrcYd81JtcDzmIDnayP
         wa90xEtjxsV6hrtEoRvpWOaf5N7cw3/+cpdS9sNQfVrHiM/HXt7VAvn68KQB/9srsNCM
         JfILZOETbJYRKJChjnIFPsgrhYr5+XQtMirMwXoP+HQMHoa/ZkKTYIFg4kkbqMdS1Tzb
         G9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790786; x=1730395586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Cmyp2pbCrnL8r6TKnpyqShEFdJNBNPbRm5jXu0QNwc=;
        b=noJbsoemFPRJFkE8gJNEQxCx+ZiIw4fWLzYyaEYobqOJYX90p9qSpG05x6NQ5ZV/HQ
         De3yodcihWlUfvhbiHYNSSsBBWgK2OdzCKghNcBVeEhoAMLwt6A3lOwUVrX03EQ2mABc
         1wygf3MwGOR5YagEy8IZqXy3+2tYgYV/xpvraW1VaVShhaWbIKf8ZhcZWbstD7bHjoCr
         xT0aich0a4h/m/DVB/HObP/EgyuTn4nVpY/4XfFuCFvy7N5wexh58FF9d9i0jJj6Xlax
         3Uik9evVU80odZEOqE4kcRxRSObpfKol+fhWQru4tfkCqeLMdgYUPGvP7mVhJ/MqRG0T
         27FA==
X-Forwarded-Encrypted: i=1; AJvYcCV5HxvWaULVxoKmwbBbd0fqTiiFJFNz2kmxJUOZyVCFDE3Wmtj5mU6rXDQAy22EW9PVnbPTdQAwUcV9bTw=@vger.kernel.org, AJvYcCX31i0koWliwu+yNt0zCOvjSR4tm1q7GWB+CThdw+dUBVGwIeImqNmU/EJe5fIXJl1Nw7yOz34zZ79G4vEXKQc=@vger.kernel.org, AJvYcCXYgtwW/mAHz6qvJg/a4IJC+KpvRHWnpcnEqsdnfEfzfBzgBcpNolkvoS9IU827pxg160Nu/m8L@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2BLkeymr9ZyHPYdxTREreYfcw2zUq6YjYnhaW+WyWUaW+RoD
	pQB4RL4abmSEMWiEe3hyF84Cu4Pv//y2/KMmfiZhm4WTBpRy5FNB9vTPuexIpRTkU8B1aBXAi+t
	s72IIl85e3R26IB2iJchixcqCW14=
X-Google-Smtp-Source: AGHT+IEyqfq0vzt+4pDxQx+AINTPUEv/2877gmMNBg1AkvLwqhkXvpxeUMsCwfZwBdhgZX+AqgjV12C+PS/R33L5U2Q=
X-Received: by 2002:a17:90a:eb15:b0:2e2:c414:80a4 with SMTP id
 98e67ed59e1d1-2e76b84cd66mr3163049a91.9.1729790785889; Thu, 24 Oct 2024
 10:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-6-fujita.tomonori@gmail.com>
 <CAH5fLgjTGmD0=9wJRP+aNtHC2ab7e9tuRwnPZZt8RN3wpmZHBg@mail.gmail.com>
 <CANiq72mKJuCdB2kCwBj5M04bw2O+7L9=yPiGJQeyMjWEsCxAMA@mail.gmail.com> <20241024.092248.1743299714523375638.fujita.tomonori@gmail.com>
In-Reply-To: <20241024.092248.1743299714523375638.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 24 Oct 2024 19:26:12 +0200
Message-ID: <CANiq72kWqSCSkUk1efZyAi+0ScNTtfALn+wiJY_aoQefu2TNvg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/8] rust: time: Add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:22=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Do you mean msecs_to_jiffies() returns MAX_JIFFY_OFFSET ((LONG_MAX >>
> 1)-1) with a value exceeding i32::MAX milliseconds?

Yeah -- well, I was referring to its docs:

 * - negative values mean 'infinite timeout' (MAX_JIFFY_OFFSET)
 *
 * - 'too large' values [that would result in larger than
 *   MAX_JIFFY_OFFSET values] mean 'infinite timeout' too.

So I assume `fsleep` is meant to inherit that.

Cheers,
Miguel

