Return-Path: <netdev+bounces-137802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E2B9A9E42
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A581F21179
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A54193417;
	Tue, 22 Oct 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7d04Cr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA25193427
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588641; cv=none; b=RDokgMqZNsiIG5NBvPY9FSaXZsMUDhz9NZ6VVKlb1At7FiB7VrPw0K+jrg5S3SKF2HfoHuJSQQVj0TI+kky7n545VYexozCg+P9Eu1tXKFff9eKEen1U/P+A5xwUqXT7C53zWm58fL9ePEaHahts24hJhDgcnYIG05gsDMFIMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588641; c=relaxed/simple;
	bh=iSYYRwFuX/hXOaJQUynx3QdWkJAQaKnubutbCjnu1Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxrYDSbse7SCKH7oanPgNw7SnJWUCgyquuh/jx6DOxLQ51PwcPiYbVceHpJUsvpRj/JEpY5TN88IQva88swzcxegG+Mt5cxX9KP7znU+BAATNYXZkPmDQ4fV7LS6l64o/TxxJbc3cqno3V6Fjd5Nzay5YYQrbaQabbmU2018jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7d04Cr2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cb6704ff6bso3017158a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729588637; x=1730193437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSYYRwFuX/hXOaJQUynx3QdWkJAQaKnubutbCjnu1Ps=;
        b=D7d04Cr2vwDeqiWfpocglMNKO86XQ3i0dbckDeLm04AYmV0Zc/c99lVPisdocyQtc1
         VDloQgfCEgz5rSl9MDQTyYtLbCzlBMzP5ySeYS5sjWvU5K9cMF4w8qrrDDbsXQIADdWH
         gQ95vSrXLF9UwlH2bNewss+3ZPB2t+qyUe1HHoVvusZv4AUCqdB9TDOTwuavMw7xsGYy
         9HqCd29A5A+7C6iTGZP/MDGz/XQRxMtXZa9bBV/Ln0Eh/uOzRnb7oLqBkHRBh02KYj6K
         5ALDjRWodgy3vVgx2OxS/NsyKokr1luag0Vklqjye/PLes5gshKvgZkuqErJI7+qxnpc
         xxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588637; x=1730193437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSYYRwFuX/hXOaJQUynx3QdWkJAQaKnubutbCjnu1Ps=;
        b=rP2M+zP+hhYITJSJ96O/iWSIfA03xbyOsJshjgZ3G0m+r9MKjgV+iDu2aXe8e5J0Tm
         gJp1dLLbXwWaLCK/BH9af4FijDveJ1hvXhXJb3zdQB+szpFZjWfLG6jJFwaaVm+ZwznH
         hwL8jk/Mmx3T41X8btQEfS+FnJ8ys0fYAxvXr5CuRxJLX202CD/LiSQFfe2rnOwYhiOW
         F/oyUvZZpEfKiph+RlsY7KTjUt/yMS3cuw8o9DUyLe0mCNph2b1/ctF7Q82aamRrI7++
         X+6E2IZbJGahWhS6njCAEJV7uHanNGV56XLmpE9XSc9XLovJY35nbQfYlEiNG3nXmqA3
         K9IA==
X-Gm-Message-State: AOJu0Yy5MpxlriLdhUv6hLlJc3i3Y8JqTwPZmSiI92eiVwbpFcuZkVmb
	8iiD3jNVn9+l9XU04udBvvR6Xy+tLY8UCfJ+Fi5N9XbO6u/G24IeoagSuHOt6Si4hJG9yNfgLgJ
	uE7mRezhxmkco5VUp4QW3JOasakmr31z8ZsiL
X-Google-Smtp-Source: AGHT+IE7qF/VThEozX2l3bRMvwUpUvpl9THxCsaO4qJ9HwBs4FMVmtzS58KuzUHTlg3JLO3qWTw7W/zU3W0K9l+WZCI=
X-Received: by 2002:a05:6402:2681:b0:5c8:8626:e41 with SMTP id
 4fb4d7f45d1cf-5ca0ac445e7mr11805094a12.4.1729588636451; Tue, 22 Oct 2024
 02:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022070921.468895-1-idosch@nvidia.com> <CANn89iLHV5NqHPjRp6W77c1DFtOBDmBs1sWR5+W_405NvOBs7g@mail.gmail.com>
 <ZxdoY8Uehc3qs89P@shredder.mtl.com>
In-Reply-To: <ZxdoY8Uehc3qs89P@shredder.mtl.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Oct 2024 11:17:02 +0200
Message-ID: <CANn89iJr6dte1Eu40C9Z8KQ_gT2b2ETQdaTTrFtT0B8LjvP6vw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, pshelar@nicira.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:55=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Tue, Oct 22, 2024 at 09:26:11AM +0200, Eric Dumazet wrote:
> > I was looking at this recently, and my thinking is the following :
> >
> > 1) ASSERT_RTNL() is adding code even on non debug kernels.
> >
> > 2) It does not check if the current thread is owning the RTNL mutex,
> > only that _some_ thread is owning it.
> >
> > I would think that using lockdep_rtnl_is_held() would be better ?
>
> Yes, agree. I see I did the same thing in 7f6f32bb7d335. Will post v2
> tomorrow unless you prefer to submit it yourself (I don't mind).

Please send your v2, thanks Ido !

