Return-Path: <netdev+bounces-129994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B31987782
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE78283D24
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C841157E87;
	Thu, 26 Sep 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcR4aU4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BC15ADA6
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368015; cv=none; b=jhYsfAgD/pAKQWkISjk0j8j/BDxdy+BP0X8BfFz3zYZ0bdQMTPxfSjFJdVcbyn1qQGl8w0xuc5NoqMN0lN/EdpFD2tyk6Sr0ub7bWgfFwoa5N+Frc9KCLpKVm+XDc3ZXFoUgWl6hZRGy/ZhI66f1E116sjLqpaJkn2Cz71vsIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368015; c=relaxed/simple;
	bh=1XFyrrh9E9GehnVeu6bNJhyVcAiq2NlQtLZmJMGeL3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPvy05hFMKtAhbVKjakHSZPCDrzWpWEVBKDnXcMT8xcSgTxvimMtZofCMU/HViMnitg/o8xF9/U2207UFAsgXYYY6miMWpH1m+7RKbTTBhvGX8zA0nSw+ghB7AlpDHRAMR0CMN2b3ijI8K84dZFZBM6nNOotFkwKzsKr6oxw9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcR4aU4l; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582fa01090so316041cf.0
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727368009; x=1727972809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk+i2DqTsiNixuvqjJAv1SWA9BJLnA+CuCyLsRr71jA=;
        b=bcR4aU4lQWxzd2reX6ftxkSZLVBame+sBO9liBTwbG6Ym6OJzoYkDCDxrCmdI8QlrC
         Xoh6F9DD870ELoM9jSThSxbG/y3Py6fMzxmhz6YH6j2XE5aCFrbmYtKNUUeFKCESQhTu
         9M+O0LFhZzweHzmN5ewU5wMTBHFzTDdtusosjlrFqt3WNIV7BkCVU7cbOtJBjDpJZRiG
         LynAkDymnCyk3CZPEgRUFWbiRovdvMP8jDGyNf26fxkJdbmnZNoKevoMpOebrV+n+sOA
         qMgWc+PQUJNiKzMFuW6tD6zeMsa2BdAQEHw8NArlsWyLwVqeaCPcYyp1lbfd82z6tfhv
         C13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727368009; x=1727972809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk+i2DqTsiNixuvqjJAv1SWA9BJLnA+CuCyLsRr71jA=;
        b=SGgM6y564jxIekwLA8/giMHf9FnQjW/P5C/YAx5Se0rMp1ldPnjzJPB++QO0nOsins
         4WSHdKWV4f0PH3Qj5Vz3GLoignrzlGPMWMMYU86xLPnUlOYNClPGPj02K1E6knEkC4Do
         ltKe3pOrWNKwrFay6eqKUbPonmvGEfAAIZqqPLnTpSs9ZCN5TC8y4/SHZevS7kvPzGDk
         hkni9ycu8ET62vwwE5jSk7fyud65FaAZkvXJypnqrID1RUMeZMUMT1W+1WuMlgpw7DFF
         4Poq6/ApsHi3sstf+atC5e3UkJPCFuDthK1wkKaWZVvm230EeRUFgf/lDnOtMn7slU9j
         tRYg==
X-Forwarded-Encrypted: i=1; AJvYcCXdlvv+j+yx/05QuZZ3DHl4qTxTDqm4gbjMLXBtBjsFHt1tZ7H6ZP7WoMkZ9wbmzyu0qSFAnLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmzfpW9LkHLN/9FG4tEQmNCXeUjWrLv2aGK2jSny2IKI+R/yx
	84k8t4t6MU859DE2RJPdoX4cXNQeY83DoQ21Sqk1Uvfvu3A9cwoxYABbpgWw6mbC/af0PhtSDXq
	/Wnrw0IW9aJL3AwZgIMqPpqhVQT59yYjYJN4E
X-Google-Smtp-Source: AGHT+IFyRfsI0tPyH/qmVhxJDCqGfM7Eu7px6OvqOHZISj7h0zvaYKiA/na78IF60EQ+qdK8hSux1sTZlXUJFJiwins=
X-Received: by 2002:ac8:7f94:0:b0:453:5b5a:e77c with SMTP id
 d75a77b69052e-45c951d6ba4mr3809941cf.10.1727368008709; Thu, 26 Sep 2024
 09:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-12-sdf@fomichev.me>
 <CAHS8izNKzuNX-nttnucfVioOt4PuMOfq0h=5W5=30jouP_2qvA@mail.gmail.com> <ZuNhYn7wlXddLWiO@mini-arch>
In-Reply-To: <ZuNhYn7wlXddLWiO@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 26 Sep 2024 09:26:35 -0700
Message-ID: <CAHS8izPL4-PgSQit6Nhhf=4YXzKX5SkK7T+K-Q07yQ7xBVRxzw@mail.gmail.com>
Subject: Re: [PATCH net-next 11/13] selftests: ncdevmem: Remove hard-coded
 queue numbers
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:47=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 09/12, Mina Almasry wrote:
> > On Thu, Sep 12, 2024 at 10:13=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > Use single last queue of the device and probe it dynamically.
> > >
> >
> > Can we use the last N queues, instead of 1? Or the last half of the que=
ues?
> >
> > Test coverage that we can bind multiple queues at once is important, I =
think.
>
> Anything against doing this in the selftest/probe part?
>
> if (probe) {
>         if (start_queue > 1) {
>                 /* make sure can bind to multiple queues */
>                 start_queue -=3D 1;
>                 num_queues +=3D1;

Sorry for the late reply, this particular thread slipped my inbox.

Overriding user-provided configs here doesn't seem great. It's nice to
be able to launch ncdevmem requesting 1 queue to be bound or multiple,
and I had the idea that in the future the tests can be improved to
verify that multiple concurrent connections on multiple queues can be
handled correctly, in case we run into any bugs that can only be
reproduced in this setup.

--=20
Thanks,
Mina

