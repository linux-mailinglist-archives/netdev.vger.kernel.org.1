Return-Path: <netdev+bounces-227358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E37BAD145
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703111923504
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2B303A0D;
	Tue, 30 Sep 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKHl+h23"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE023303C93
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239226; cv=none; b=BFyvXiaulLCdGiq0MJ8DulHZApqs3P1T4MQLpVGAaJQbRQ8A1u9VKUnNGdMXwMJPxBgsNRzU2H3nMSC5h7Ak0ra2+WM9ocA1H1icgBTCBvDkzcphaUpIo6ydukVE0q25sO8z+CmRtAKUH1ijXjwFIWvFrwLrKsAe1r+IOiC5guw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239226; c=relaxed/simple;
	bh=CUHSymEOsx6QYL2fbPXy3esCdme3Q/bVDiY03oECVro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQFSfGGHf+bIzjsb3EDbt/vmZV+jmgOlbG3aeNfLWtILZT6UCIOGUv+icplqOP5PrHFJ9Bz3s4TxX4wlPRDoikTeBy8mjdD6P6u8CCBDHHhxp9hAXr8nPPJvHC5TqRAXePMRVgNcagerTmYm+UkcVGD88VTbgM/f+WZkoMkajzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKHl+h23; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57f1b88354eso6269421e87.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759239223; x=1759844023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUHSymEOsx6QYL2fbPXy3esCdme3Q/bVDiY03oECVro=;
        b=lKHl+h23rdLUl5FWmqRV+eieKEkckSZLzE/7/EoWYuo58gANB3+TIIowY6Pwj7E45x
         O3sQON5/H+fytgonGL8w5xtYqw5C0vmW/fuaFcX2DpgQgHz/rVfgAoI5B7rSFIveHSKU
         8bugT8iPyFpFdNIWs0WW6SCDWlDP30Vi11H27OY3iRHNxxFAdcPAJ26Sw4nieMSB2bug
         ntS6CjpP83JsXt9DIoW8qR6Ohz9PdZ4dfWq2iRkhRe7jxb2M2HVukrVp5oM5455SQPId
         ZEuPLikVnJgc6yQe9nA2aLdjF6qnF717yir3E2V2CwzXlhLwGp00tIAC82l2g6pahyHx
         STmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759239223; x=1759844023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUHSymEOsx6QYL2fbPXy3esCdme3Q/bVDiY03oECVro=;
        b=Lb9dyxsGZI6e/cjr9kEyIaxmg2v6D8NFF3BNyTS5G2ibi8XEjc8c+s/Pc/orAXBOBt
         ey8l0ngKj8ik4hnXcuQ3cA6/Q3yyfgsR2r63GfWlr4cbN0ZOS+MSgR1IXmR2g/Zi/+yA
         US1h9JQmHZGFRbCP6c8/Tbv2Cj+8hpE0U99ZESvHyVz5MRdNui++/gOjlPQ33QPo7I9x
         Qpsj2PYhi8CPdawUKZAJRmBsylQmOiWu3Gijbo9BnCPlofH590DumCLsS0VQBcIJykQV
         XuKLloiS0YXD7UXWs4wyaMPkfddbbSugdkpiHhAcRh08fyXieY8llKGDc2kqDB9YWlAt
         DsDA==
X-Forwarded-Encrypted: i=1; AJvYcCUTe5hkHsaYevLQ3E0kmd40rbSW8LTBO9iGVvy15qc/bP1NWPZ8GoPG9EyJPvRz4CDBUNFFzZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzesJL1vx8NUkdn1jteuZveKv74aFtVWvO6GM4e9XIj3kqg6Kq
	l1mX+WvVhgbT8YQewxpgDdWTbj6KZe5boXnKcDLyRSPHTbU/SGxRlXUU6UgqgYvvOg9AW3QvdIB
	tN/6FuvWETkhKxOE9w4QE1rAzkjviFnU=
X-Gm-Gg: ASbGncvwDT//Iw0wk4ryGLr0/VPaFnN4JUwn53WFt/pOhcXqnsCaOUIbC0jBKUvRHGS
	pjZ0namWXH8sjMCWDM9NafK/fVViHSpRCK5kP0X0Gap0uRKn1YE2VNtOzAUUboleb7RcgdcgTto
	zyc8pTT35TDeJC5aM8nT0LoUrXyRaO2AIt79UZVAG89yTXJJuAivnGC378FUZfChof87flH+Mne
	9Vfo5sdO2qxCz3/hPbZqiQJE5x7JIK00E80G2Z4+325nWgTa/RwhRONSXheP7+WOv/dSOptJQFt
X-Google-Smtp-Source: AGHT+IHklcHPlmAmlLHJfII82jQFE7nA1C/gtspMIjp1MvgO1gKErD/Bs5XD5EbGRk/fHn+Fmc9Tezs5wGtRpvXmEgo=
X-Received: by 2002:a05:6512:114a:b0:57e:6aef:3ffc with SMTP id
 2adb3069b0e04-582d073fab8mr7062564e87.4.1759239222574; Tue, 30 Sep 2025
 06:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925204251.232473-1-deepak.sharma.472935@gmail.com> <54234daf-ace1-4369-baea-eab94fcea74b@redhat.com>
In-Reply-To: <54234daf-ace1-4369-baea-eab94fcea74b@redhat.com>
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
Date: Tue, 30 Sep 2025 19:03:31 +0530
X-Gm-Features: AS18NWABMwr4GHfH6IVP_7STi5E4UNpJ7XZKnoK6x2LnyMMJxfQrcgjTzeg1wv8
Message-ID: <CABbzaOUQC_nshtuZaNJk48JiuYOY0pPxK9i3fW=SsTsFM1Sk9w@mail.gmail.com>
Subject: Re: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, pwn9uin@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org, 
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com, 
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> AFAICS the mpc_timer can rearm itself, so this the above is not enough
> and you should use timer_shutdown_sync() instead.

Hi,

As I understand it, `timer_shutdown_sync` will prevent any further
re-arming of the timer. I think this is not what we want here; since even i=
f
we somehow fail to allocate our first MPOA client object on our first
ioctl call,
and hence end up wanting to disarm the timer, maybe on next call we can
allocate it successfully, and we would want that caches are processed
(which are processed for every time out). So we still want it to be
possible that
we can re-arm it.

And as I understand, `timer_delete_sync` will wait for the callback to
finish, so
deleting the timer after that should do the job

Thanks,

Deepak

