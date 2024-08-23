Return-Path: <netdev+bounces-121227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589095C3B5
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC84328435A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AE7358A7;
	Fri, 23 Aug 2024 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgHAmEqW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1F23AB;
	Fri, 23 Aug 2024 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724383678; cv=none; b=suvKKEiA1+7J/6s1IZU/ucIuhqK891bPpM8Bfk6qgYW6B8L8xrPZruGJG9leK7PQ0bx6SeJmUpb715vjHEUvwpnrmK+sM7Jr6BpXj4OuDfMv7U6ygcbnWmwzi3fi+fe8ShPpXEKX3NKqBfe7t4jtuQ1UzGQdSxaHx6OFAvV3fOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724383678; c=relaxed/simple;
	bh=suy4ZFyyeE4wmFdPJXoxMX5BPHUKw4sn6T7yWh7EiFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSaitqgJb86R9w2Z46o9DH0p1YG4i8Ab1eFYjPcCP5zJb5x6y3phI4pwKiU0D0hQd6HeLP7WiZ+7mNmWUrzu7Q3/+NpAw1BncwRR8eYwDJ1fozzFI5//AP3gTua+L5v/qwBImvVjP0KLzStLVJdp4/XmWdKDadf3Rsl1Klsc8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgHAmEqW; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d31d16d39so5498025ab.0;
        Thu, 22 Aug 2024 20:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724383676; x=1724988476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suy4ZFyyeE4wmFdPJXoxMX5BPHUKw4sn6T7yWh7EiFs=;
        b=cgHAmEqWVTcixU4AmMSulRWiaIdveSNC52vNvjFkerLLQ6UuObsk+h/65cUpJVO10S
         dY0Qi5gg4L20RYdIBnE++2Jk6xKUVDx6/N2BdOQ2PQGJQW6x+P1tjBL0jC7XEEx444tV
         o2wEGfC/BSCNW2XWDWNMANOrUMzPzAlxnjzM0yd7UfnsPVI3ZMoQlSP7FtnoZW7iZhLl
         rcgXKCujD5yeBBwFyE250bEBxW45y9P613sGYqTqE3OQpUAeoRrdnpBZQ0tRqNEZ19x5
         XXCmgN5FXi131hJWYyTgeL1qVad8E+4F/GzgjiG99+YnUv6aKq0BfFjEorYhZpnIlGu1
         i5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724383676; x=1724988476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suy4ZFyyeE4wmFdPJXoxMX5BPHUKw4sn6T7yWh7EiFs=;
        b=Cl4hmu3UjyQGgVTf4Ou0oSrPvx+bRCmMIkPRc8n5anGOjb4yc/JTlLY6mafxQWVet8
         /Uwdm8a7A/a5R20HI4cPUuCSKvJQfUZ6ell9cnNEXvHPkprSjAlutfIpy3VgaJpzLJNG
         hh2VZpf/8Cm2689cfzMsV/J7yzz17ue5Nq3uICETDaAQUi3uMhcxj3SLEcfPIaxDXKD9
         YrwuwYR+ovNPTdQCczzGC3FFXqyTE5iwrCI8iQQQyAnumSWjlnwpSofucHC/t9bDUSTv
         4+hxledx1HBtrbCWi68gqtcCiS9poZN1l0zAN50vOPsbPnVrMqDnAIJZM71sXX3r0nAX
         nX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrTXqN9NCm+sUuGaXYhGfLwuP1N5OqqGOjkDZu8lgKVv+dnZEn5ThG4MPAmBTY+/cEn/mCN/Ks@vger.kernel.org, AJvYcCXzo9xplyEj2UXnxnjMc7NQ5hGkfr6KfHuPaxv3g0GWzOW1NDPQNWEG5OC9BuMM+hOWg4GQtBfAjD27BWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+mo7RdJNsvwj/scUChHTwl3k068Ojxgy47ykfBT88hwt883o
	PK/Y/91XwQ901g5P+YJrsHha4C4e+tk9mlKsANQT/RCn/QRrdKYTPMKkLbioHCRXAK5A+c+vXJB
	E7OK33fW1uN6hWv35XRgzgYaX2vg=
X-Google-Smtp-Source: AGHT+IHutCtUhIMx3puuezGmXR8jjAONEJEzlQSAasVnZbuz/+E3iKy6Y9hAxds3PJ5c1T1sfODDzfjU1Dna+MZCqFY=
X-Received: by 2002:a05:6e02:1b08:b0:39b:2aec:6729 with SMTP id
 e9e14a558f8ab-39e3c9848d4mr9550425ab.12.1724383676129; Thu, 22 Aug 2024
 20:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823021333.1252272-1-johunt@akamai.com> <20240823021333.1252272-2-johunt@akamai.com>
In-Reply-To: <20240823021333.1252272-2-johunt@akamai.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Aug 2024 11:27:19 +0800
Message-ID: <CAL+tcoDh1GUL-m-UXM=WenN74wXLsgudEScJedfa=AEzt1Rs9g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Josh,

On Fri, Aug 23, 2024 at 11:02=E2=80=AFAM Josh Hunt <johunt@akamai.com> wrot=
e:
>
> There have been multiple occassions where we have crashed in this path
> because packets_out suggested there were packets on the write or retransm=
it
> queues, but in fact there weren't leading to a NULL skb being dereference=
d.

Could you show us the detailed splats and more information about it so
that we can know what exactly happened?

Thanks,
Jason

