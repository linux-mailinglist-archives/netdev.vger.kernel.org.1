Return-Path: <netdev+bounces-115901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065509484D6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C8A1C22212
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760FB16F858;
	Mon,  5 Aug 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z3WL/weh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54FF16D4C1
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893324; cv=none; b=gS0pVkRwtIWAW0xghGYAoSjXi5NvfgsNLxbZC9dHFbCUv1EqQbcBp6Hxs9IAD8ludbr9p1zm459r3cC0xvUC+ZVVKwaRqFy6vAHqbgy0DNVsEwSqWIrWrkCsv1FYnj2qezuwrAUMrQBFLB39lLIjei18seA9biwYrRcu/d5j7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893324; c=relaxed/simple;
	bh=CTTjcSVZh00GG8bK8bn079xIUwIcu3ks1xC9HUn/WHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnX65Hnqii4fmT82UCO9erH1tMiKRsDk6FSI3nGZJ8vQwcmX9UutA/FXAQ1avKD1GkSBxcgCnYStzR4Tplt2o8Y6tTYONXQ/q+IClaHtb8UcZEuMK9MbuDeno7wWsGfBg8YjyV610agfeWceNUuJH6qgDARhY2/fQ7UD3i4fQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z3WL/weh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so10095259a12.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722893321; x=1723498121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=Z3WL/wehUA5oHx3YiNUr8peqdqJXXgq+u0kf/MCKZGVY29llW5P9dlZLF8LCL+bnGe
         OrxAmsczeLx2sKEdHBpzdD0FVhnhPnYYOFnTRAur5Sq6vFbyLYR1pspKrM36I7MnHaSq
         opiT21XaeDREo7lFKx+kdwZ6CQlW4dBqbihzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722893321; x=1723498121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JmhoGoeqp0EkHzxnqjsByi1+fgV+qGizB/Udaf1KjI=;
        b=Vkpb6+ZqGkx0ULOXZpv0om+5Jz8fGr0dIUmdqGLUKxwRdNWY4vZ8XTIpOXuSaWaVhd
         yTsPC8Vo8LJYlTXU2TSVJS29NznWOp4rG3lxyWjwrdJYnsSQUNHAM7GD86LnygYxrUlE
         sC7hkvQ/BqpxknySUGpJLSUvM3y67lriLEeLO1+OefyX995zfGuGh4fnvaJSuqiDb+lB
         6Rvk7bAi1P9qFLUTmHe+Rruwk6HT597bOweLTdx3jzOgB9ORwqlD68HpNzJ7TLAsHz2P
         5jMcc8OrbeeN8ugah9enwNVnGuhhBolqBl+/PW5bCjDQP9lu+beyXpcEBsbQN+j4B4W2
         HV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt/r2JAUgG/mkxuQ3Yi0mxcMWbqxRey4xoQ3jLiHys8z0pfGAxocRkOsMRfaF03CKKwGuscOxHm7rc6DXTVHPYtL/ag+dD
X-Gm-Message-State: AOJu0YyU5XsB/LzhecWG+ndCLHH1QgbvgNwcH0J1nX8xffJv3pZAO1Rr
	ZBrAH/jTTq5PAkcMXIoWXS+BocX5q1CDYgvFBzNy0XqktWHwiCgfLauk93PV7peEyxfb3dR3JxI
	mxfbC3Q==
X-Google-Smtp-Source: AGHT+IHMOlzmBWcFL0gjthAbn2bel3WWMN4j3K2AEf9cu7VenxPm2Cs/V/JFotb64USlTcrH4V8Ncw==
X-Received: by 2002:a50:fc0c:0:b0:57d:4f47:d9ee with SMTP id 4fb4d7f45d1cf-5b7f5dc0b27mr9340672a12.31.1722893320777;
        Mon, 05 Aug 2024 14:28:40 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a552984sm5323847a12.58.2024.08.05.14.28.39
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so13546721a12.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 14:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAf7Hm1Or+SJPr5Php+cGdxCdEmBxkTeMEioSZKFYwPD4aZQ91fISyPK1ex6hnORp0cd99CyawTTaj5TpftUwdg/dyY8AI
X-Received: by 2002:aa7:df97:0:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b7f0fc7f1amr8956337a12.0.1722893319128; Mon, 05 Aug 2024
 14:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com>
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 14:28:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Message-ID: <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 00:56, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
> get_task_comm(), it implies that the BUILD_BUG_ON() is necessary.

Let's just remove that silly BUILD_BUG_ON(). I don't think it adds any
value, and honestly, it really only makes this patch-series uglier
when reasonable uses suddenly pointlessly need that double-underscore
version..

So let's aim at

 (a) documenting that the last byte in 'tsk->comm{}' is always
guaranteed to be NUL, so that the thing can always just be treated as
a string. Yes, it may change under us, but as long as we know there is
always a stable NUL there *somewhere*, we really really don't care.

 (b) removing __get_task_comm() entirely, and replacing it with a
plain 'str*cpy*()' functions

The whole (a) thing is a requirement anyway, since the *bulk* of
tsk->comm really just seems to be various '%s' things in printk
strings etc.

And once we just admit that we can use the string functions, all the
get_task_comm() stuff is just unnecessary.

And yes, some people may want to use the strscpy_pad() function
because they want to fill the whole destination buffer. But that's
entirely about the *destination* use, not the tsk->comm[] source, so
it has nothing to do with any kind of "get_task_comm()" logic, and it
was always wrong to care about the buffer sizes magically matching.

Hmm?

                Linus

