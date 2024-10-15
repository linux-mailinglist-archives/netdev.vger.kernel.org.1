Return-Path: <netdev+bounces-135470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3886799E09B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97141F22A8C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101918A6A9;
	Tue, 15 Oct 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="09Krmcuf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB52AD00
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980185; cv=none; b=E1/8xF1MymX8NZB5qDo8pP29av65zSSxGDDPIDI8RnVTvU00+LGn2XH9MG4JDEsghw4OtaTljFL5zCMkfLpZlryPb9h52pqIjT9N5TjG8uHzI8ef98bDe8PErsK07cGnVuwL40xzHSQHVTAmtTdVSjTyuWBPuCbkKftqZ7Xx6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980185; c=relaxed/simple;
	bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwzKx0qrqeGtUpusNMqyA43w2AChMJ44Po/WiK6OxiHULCcPwlizIXVJxO7+xsY6q1i67Ii24Off2D98UOm7mhVwRV3lq4H4u4fLR8n288VIf2QpNFMaBAqCRVfHjgGirtgdb2DTeQgvvQMg7aqnTNbnPBd4aPidZkUwtY3/Xvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=09Krmcuf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so2589562a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980183; x=1729584983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
        b=09KrmcufF7rEVXlGbNEOZj163OfAxp+uP9RGOx/4y84pVT1yaW8DOjcxh/WeKeHaiC
         kdpDFPrzK8OqRxCh2dhHvQAaGld+6b+d9ou07xqK/UZ+EvL33UWds9uuME/rX8Oz7O8a
         Q+21BG/urNVQz7DMo/IAUgHZYmkCNZk5NHfwiaVXjbG+hJFbGUxd7Dg4Y6TUgA+RBsBc
         M3P2l00cor/EoMmICbjqajsDBqPq+SKOx/7ND/7tKrE9Duhvu1W/Azl+FmVjIpFsnsFO
         ezC4KXu6Wp1yTFF+tEhgA3cfm+BmPyxjndn9+AtbxGz4VB+lY4sqlJIcLdS1unplSgcG
         iNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980183; x=1729584983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
        b=E1NLXAWHThw1CkAu1K2LTp98sDQ6sO9ZEd1h8qHAzioCQEsvkStZxOtB4+CKOU5NDB
         4jzXA58xRXx9/v4pH5YJGsJCrvZtIR25yrAnQQw+4B+HTyXAFQSjZvKqmTmMr4DDIIuE
         LjByGZNiJEXuRGOfvxIl28hEhDzVmFDk3fxTprdALhQjxwc3kPwQhCk5sNhiL49HvQk0
         tOgGHFpF0WiQo5SonutpMs4wCPRKdcWmaqEVhKDCTJtYr1qeLbfikl1BMQU5Fo9RncFz
         G84W4THCOidFyhXKO3XSGShjmjEDkN9oDo8F/NyHNXC/vdKHDoFQ/gprj5A1xctL9WX2
         enVA==
X-Forwarded-Encrypted: i=1; AJvYcCVG1YChOq8v6nk8J/2S8nlEMdQ4Kdwop056/9McUfvg9YgJSQi0I638+9qDYH2CSpUtJMcgIxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/4AkSxpptfEe5bb6763SW29IMqOdwZsUGT6mpkHTFlwEct3H
	GJujmrXWPfEUN8ilNwgQkO/hdgmXVpDNNfDSwepDcPzlWNQwYWIqF77eIIijxe06I3x45CmoqXm
	e3JWre5aMcEsb7cQE391Xy7ZcHvRxmVTGpNSA
X-Google-Smtp-Source: AGHT+IHFnVyo+nd7P3K+X7va3TZdYEr+sTXi8dLernve59WvBKwViCcIX8pxH+sBlo+MA02kMuzXkCk0/N4DiisUNUI=
X-Received: by 2002:a05:6402:34cf:b0:5c9:3f2:ea54 with SMTP id
 4fb4d7f45d1cf-5c95ac09854mr13375258a12.4.1728980182448; Tue, 15 Oct 2024
 01:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-5-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:16:11 +0200
Message-ID: <CANn89i+dNUOXwsJ3HeUuft+Wwa-rGEi3jhN-m_mTTXks6c=AdA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 04/11] net: sched: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register() in favour of rtnl_register_many().
>
> When it succeeds, rtnl_register_many() guarantees all rtnetlink types
> in the passed array are supported, and there is no chance that a part
> of message types is not supported.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

