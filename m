Return-Path: <netdev+bounces-96244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3D88C4B2B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA09286641
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C1749C;
	Tue, 14 May 2024 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7UEjUWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342891C36;
	Tue, 14 May 2024 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715653559; cv=none; b=f6sFgWvZWvJnPEBycYL1Y3bIlJGrBMJ8DuSaq7TJb8dlt3k5IsG2Xgu915hAVaDzNEtW0GsLOJzm0a9Be/Bp+NII0D6f7bHgs7hLNzpGTE6YH9ZwaTCwHKo8aY3fuwb9gH/QvlyWQAn2og2kcU3kfBzi/ozIEyKu0c5E+SwWv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715653559; c=relaxed/simple;
	bh=+a2RxBxWnxcA46Thf9ANLvCZNlU+Od+JII0GFSrtrTM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wyh8XsfmkvN5t4XFoYehlITS0lXacRRPopDbq0Dz1fo13spEepXzUD5zQgY6swjnOZ/J+yO1uYsKda/+BEhgoxLEJ12sYkGDCd1AT0Pv1o+lf6thU+IRw9jQiXSeigmKqC8GmTkdH2C9DOpSmrCyet3RmvQxUSTsdTEhNG7Bv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7UEjUWM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61af74a010aso47780587b3.0;
        Mon, 13 May 2024 19:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715653557; x=1716258357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx4RFDf6WgXAWKWwP6oMkLQ8rk0CdMUrz/uyMHvaUJY=;
        b=W7UEjUWMHKZPwBAv+42MNRfR2YVu5H5tpE1S/EYADt7mIn13DS5JPStzU6KdynwLaO
         t/TgvhXdK1AfZbRo5xMUEIhwWEN2uYkhs8xLDgFaRa4L7GwiofY8s81017fgNJ5L0Ohw
         Mj1R5UmBnEHuVSEDQJIfkPc0zMl8V8aiLU//hEv1fitHLq/AAFc9jACLyZ2fij9cV47w
         3bD9A2+vHMImnkQKfJJxbI8gqmZ5dZdyAqjfROwlxBx05VlaNBxRkSQCYfU2aj+DOXQe
         afTzrEIRlPpHa57mob6tgbgCNfp3COFKdMNCdVSZqid3EWpFjn4E7djR382el4RzV2Ct
         qizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715653557; x=1716258357;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mx4RFDf6WgXAWKWwP6oMkLQ8rk0CdMUrz/uyMHvaUJY=;
        b=o12lOTLbafnalwpqtelre7+7GG025BuHkp815oVOo1Kz0xCiIwsfEUwhVJHziicBjU
         tI92RWUDAdKr6P4UGo9+77odr3K3E8ada7oObq1PWfbmerm0PAWpTEbEKrtInk4mZMCd
         e3c4LYhAwN4UrjDLIqJa7dpClQ2Szb9yRnwzm7NTWW5U50aCthYrtptb4K9xFL3IyRbw
         vGtht8aEYWTVgYf/+jmmzj1kCodp9/EBzsjbL9auR9tmUk9LfRbLgRDZPJWyq0/dZ9k5
         ZNlYVuwoxlYey4IWRwV7YKBcP1k4TUoJae6wSev4doQXDPZMk3MtWzsZKdbPO8XB77e7
         nmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW07OBGwo0UE8s8G8670aOspbBpOnsJRtCfUal+QyZprjCHqUqnIj8Iz7W8pHj8pSu0tYDiJa7Q0wzIFWRWq/UwENmVBQVpUMWTu6+gO2kQpTQqBR0DINfnE6pMz7UgFMBAfr8v0YOR
X-Gm-Message-State: AOJu0YxaFhueWWCfe+2PRrC7cNIg6K40ovbz/NUuGbB0P4j+YoP1RQRK
	JzTd/4G6T9eMVM+IOM5so4lMDYz6U6GLfTBxDEQbujOSHrzOT1MLoY1qxA==
X-Google-Smtp-Source: AGHT+IHniwQQiYpd+TSCEkO0ItdZFVEhjPhlluaGCZGQkZZy2E2jyDTudjBeqgvzDdoqqXThA+rIjg==
X-Received: by 2002:a0d:d6c9:0:b0:61e:a36:8d85 with SMTP id 00721157ae682-622b01384d2mr102100187b3.50.1715653557034;
        Mon, 13 May 2024 19:25:57 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e19256258sm20030401cf.49.2024.05.13.19.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 19:25:56 -0700 (PDT)
Date: Mon, 13 May 2024 22:25:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net, 
 linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Pauli Virtanen <pav@iki.fi>
Message-ID: <6642cbb4309a1_205cc6294a4@willemb.c.googlers.com.notmuch>
In-Reply-To: <CABBYNZKdbvyev+BV=CMGrzWPECJraP4OVJeysQYV=EFLKf_WVw@mail.gmail.com>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org>
 <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org>
 <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
 <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
 <CABBYNZKdbvyev+BV=CMGrzWPECJraP4OVJeysQYV=EFLKf_WVw@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > > As for the "experimental" BT_POLL_ERRQUEUE. This is an addition to the
> > > > ABI, right? So immutable. Is it fair to call that experimental?
> > >
> > > I guess you are referring to the fact that sockopt ID reserved to
> > > BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usage in
> > > the future, yes that is correct, but we can actually return
> > > ENOPROTOOPT as it current does:
> > >
> > >         if (!bt_poll_errqueue_enabled())
> > >             return -ENOPROTOOPT
> >
> > I see. Once applications rely on a feature, it can be hard to actually
> > deprecate. But in this case it may be possible.
> >
> > > Anyway I would be really happy to drop it so we don't have to worry
> > > about it later.
> > >
> > > > It might be safer to only suppress the sk_error_report in
> > > > sock_queue_err_skb. Or at least in bt_sock_poll to check the type of
> > > > all outstanding errors and only suppress if all are timestamps.
> > >
> > > Or perhaps we could actually do that via poll/epoll directly? Not that
> > > it would make it much simpler since the library tends to wrap the
> > > usage of poll/epoll but POLLERR meaning both errors or errqueue events
> > > is sort of the problem we are trying to figure out how to process them
> > > separately.
> >
> > The process would still be awoken, of course. If bluetoothd can just
> > be modified to ignore the reports, that would indeed be easiest from
> > a kernel PoV.
> 
> @Pauli Virtanen tried that but apparently it would keep waking up the
> process until the errqueue is fully read, maybe we are missing
> something, or glib is not really doing a good job wrt to poll/epoll
> handling.

Perhaps this is because poll is level triggered. Maybe epoll in edge
triggered mode would avoid re-waking for the same outstanding events.

