Return-Path: <netdev+bounces-190843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D99AB90F5
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8B57AFD11
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B4027A461;
	Thu, 15 May 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8zerxL+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67F20CCE4
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342382; cv=none; b=Q13jtmngKg4M/1DHxCl04CcbvDpi0JiFG9goJihnvYhz4Qc400gkPalNQxArTtnB30PjbE6UhHemGrRiOBHkE5HriVhwerftwTNTBciPcWcCRXCbgzzDYKAq2Gyp5i017L/hjsMdySXBrQ48PEKHrPO2uZWNopNPK18xuUgZVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342382; c=relaxed/simple;
	bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIuq9w6DTypLixASGpGWcGCnKepnP5Rhe7YU2glXM33SgzywArU+mifWeKax/5o/Pw6k+/gz7PUPnc0RoEoss58D4KgRUaeluqLu1Q7zDWb3lamB7xuJ1/Jt9MMi6XD8O1wZzUpxQ3rc0QFRwmyIUnWCHaKvLmasIOs8sUDQE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8zerxL+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1420a12.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342379; x=1747947179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
        b=e8zerxL+wnR+j4tazWO2tN19dxkVVHq0ygT4AY4rUUiU7kSO3wLtgzkg3q3cmv2YTa
         vZfFierl81popnMsW80aNLb7U2Afe2GxeX7M+fSQdXk47M0NSRNru8MuznHwxifNxZQX
         0XEbNYFlWryCsSd+Lv6PC8V6RmJnt51yU35olEby9SMXawcuutLVxdSL3DAC9Dert6/2
         uiXZ83Ifso2wolN93HuEMnIOSzfr9Trv+66flzNib18fyYn8POs6Ffv+67f3wprwvxMs
         gvOSiIQyNZ2li7jqt/fH8nG+n+gmupBubWTyGD6m+IcHWxvk2pnspjdvNQ2eu3Btf4qA
         U4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342379; x=1747947179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czi5+u2kEjArBpOgbOhFbSFaZ/a1SpCa/lwq2gvfT8c=;
        b=kxyigo6267wbulMJSSaGzWeqr1TXg5DCyNqDGOZBHyjODm4L5TzHk1J0BYtgaPi3e+
         pf5BaJI/Mf13w7m6cV5qMSBKshehrljY+fNCV7uSMKjiV2wNuRq7Ni7OTcILySEq3nhs
         RWG1GJsR0SjjNO68p/ke2dJe9D0kthfAp7oBwRNljz9/L3GoZ4PcpVjPjVpcUHcd9vES
         pw4y+nyb+fmOIgxY2YKr+h02ecveh39CMazxgmmimGIAoM+Dw8Gt6V9DpjBcqT/L+ZcW
         ZEYnkbzgioMnPHoh7v+gyJ9wBCWbCef50VDdS0+oibO+OMFhwWSgOd3YLxKu0npl2iMH
         BmyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWDQ6umKOvEyMECspftdt9sO9ChTLIFsxng/G/YSGOooTxAEqAXr48ww1g0OMF8XMEwX50nUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFgCWjfjgMLvQ6i6EdQVLs/wSU4Wcf0e/qYkCnKK4g2VpeHU+8
	ex1/fXMX6h4r3WSYoLhihS5dnjDyOHGWzqWZJfuEdQArHr350pmPSaCyDKvtRXhpYMfoOTiP/rW
	z7NRaRopRB/u5Q987a8VkwXQS8ulvremn2LZdG7Ti
X-Gm-Gg: ASbGncssFQQXdLhQaQyW5DoJTiK3KxPEZMlrznj9qVKFnddmKO6NCL3rlzpfY/1rBHr
	sbk4km9lYrjOARjXvlVtr4IDSRAN7Izh3brVYyUpgbRIA0K21EVWuITuUtdx+sxbtrx9TSt3FLI
	lra40RaZ8sfJV+PA2zD29UaW0CkbSS69N+6OSrcwb2N5UNH1EnXsFvrOQWiGBd
X-Google-Smtp-Source: AGHT+IF2M8wfat+ypXS8t4pkU9r+Ie60fdxet+x1ExwrsKQgeSVE6SwmGNdqBwNHbwOcKqnaWIIoX1c/2Jgm5HmN7XI=
X-Received: by 2002:a05:6402:22b0:b0:5ff:f051:60f0 with SMTP id
 4fb4d7f45d1cf-5fff0516857mr119534a12.3.1747342378383; Thu, 15 May 2025
 13:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org> <20250515170057.50816-1-kuniyu@amazon.com>
In-Reply-To: <20250515170057.50816-1-kuniyu@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:52:22 +0200
X-Gm-Features: AX0GCFukZXeV2YnpYpWYUXI1kiBBOFCdeQQogQc1TbzHuyl2utiuGujZlMvm38g
Message-ID: <CAG48ez3fC902JU244d=0zzr39f+iXxQH0GZgJp0rs8pbu8ka4w@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: brauner@kernel.org, alexander@mihalicyn.com, bluca@debian.org, 
	daan.j.demeyer@gmail.com, daniel@iogearbox.net, davem@davemloft.net, 
	david@readahead.eu, edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	kuba@kernel.org, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	me@yhndnzj.com, netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, 
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 7:01=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
> nit: please keep these in the reverse xmas tree order.
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ord=
ering-reverse-xmas-tree-rcs

Isn't that rule specific to things that go through the net tree?

