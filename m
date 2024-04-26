Return-Path: <netdev+bounces-91563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 900248B3119
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B3FB218CD
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A699513B5B3;
	Fri, 26 Apr 2024 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0D9YydhW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A513AD33
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115501; cv=none; b=HTlsOwX4IXmT8q3MOH75DCfao7jb96rN5bzsdz5+h0aA2gwGHnLoLCnnz9engypmUUK/2S/MWSgJsOLDkUjm4fIPiT2bnAmeJQ9GorWyCLBcQgjWZFerYJTSQi1c2ScSHIjzoHHMHpN/bq1IK9fvYGAN+qMAuowQFnPtkv/yxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115501; c=relaxed/simple;
	bh=Nd4jaR/42dIYUGyfQPfs58FKm+xvVcQuYdvOUDI7cZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqEJ1WAwep2uP3SptuSvO7LPhbigBaCsisil+13jmWJ3K6V4nk1mQ18ewndBx9OAbooL0gh7i+N0iEzmhw59KwQba5nuYi9lIBh1ue0UvN67BDDhsyeVeeZPyBoocKWC4vGpQhU9zfRNEpyyXcGHMv1bnXeT54FH94TnyO62GzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0D9YydhW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9053a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115498; x=1714720298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd4jaR/42dIYUGyfQPfs58FKm+xvVcQuYdvOUDI7cZQ=;
        b=0D9YydhWENJKWGA4o9ID1jgksz19WvYswjLNXVQeMV1TZ0hL7VXLS9YD/WXxr2wo2S
         8UnvYdiB7jXCJ17jAV1O74AgapZLr0ejWxT8+N7SFwFxLa/nMOXQzhDMrn+vr7IvM8S1
         X4fofy7rKXl2jCSe+PZWw+4Do0+xneJexG9PwnJzvW+B7DSEC0n4cA9B6vueam3ih05V
         8NgHpMNoSP0cCZ5onBgtrjFOqWzUy43pOCIRiZ6fwsCxAyDgMK2tKOrmhbV2TAqSaDCs
         iunuUp/t4Q+ITi1fo/G+3uVHBNw4a4z4e4EUGo01WD+aQ/dicuVea325Aliowl6uUdkK
         X/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115498; x=1714720298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nd4jaR/42dIYUGyfQPfs58FKm+xvVcQuYdvOUDI7cZQ=;
        b=p/h6Dxc8BoEjNzAundqOtCiRJ+xmpatO6hEW18py46ubYaJKT8xZ+gQ1hZnXopn5BQ
         fVqEQuIckJJx7RmDTeHLZQP3Cdw1rUgGyyMnmRSHcU5kOe+6ZyPUfigwUvs63hOfSWYd
         S309+nvKp+b3gf9Fny9SwnmICeEtgfRRC+95C+NhsjY89QHtBv3ddoyI6tJcxvL1k2Cs
         GNK0KbL4Wp4IwtH0bOZBm5revwPl/HQ/LtYntIK+vouahVESFpHLHnrLtnpfP1E2GLL7
         0XxEIhhoP95l9dNMCalE4JNpldEtmy6fUL8qnjr+tGJVZ2UTOini0Py2s1d0FnQz9AfS
         3btA==
X-Forwarded-Encrypted: i=1; AJvYcCUJe2xq5Jw1zMltN9utACcsDHapFmEM3T3okm0+faZfKxhXNv/EHra6Ddhoo7qHinRoI0+2qDY4Syv5jFC3IM3JDOdxASkH
X-Gm-Message-State: AOJu0YyPuJyTy9ebg8MMu65SJbdb03+wbjnaH/dlaJj9Q5nsRHqi3LpS
	QBafbm+EXQleFDYqyuCrkKycTGCPyD1+O8yIwx4xDyvD63A2DB1tfz/19WhNKqSZihX3nAz7a+L
	ht+aUH4kf8KbNZ9SofvlWLbNwXpva5pf5ji9n
X-Google-Smtp-Source: AGHT+IFGFOVqN9rWuwqHOOO+oH76cLWmGLatqVO6OwSVaACVskc25LUiElBUrODWl++2MM5fkppQkcjTxQG26Gykqd4=
X-Received: by 2002:a05:6402:c6:b0:571:fee3:594c with SMTP id
 i6-20020a05640200c600b00571fee3594cmr83544edu.4.1714115498355; Fri, 26 Apr
 2024 00:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-6-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-6-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:11:27 +0200
Message-ID: <CANn89iLEAyZVBYd+Sy=y4sxvqBEdev-VhJvW9k4eRRSBKff1Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/7] mptcp: support rstreason for passive reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> It relies on what reset options in the skb are as rfc8684 says. Reusing
> this logic can save us much energy. This patch replaces most of the prior
> NOT_SPECIFIED reasons.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

