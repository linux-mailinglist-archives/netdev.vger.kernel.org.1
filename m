Return-Path: <netdev+bounces-153368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C819F7C5D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1211891C10
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3298F226199;
	Thu, 19 Dec 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7rBtpwj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6795E2248AA
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614907; cv=none; b=IIERRobzMTRCfS8gUZrbuaq2X9DyS5ECXKuEILEOwKD22a65JbOGA/VAXK4YXPRV/u+FAUgwkVLDGSmcuuVf9VfAXdEZfnqpkYX2mUXdEcQf70O18zttZMYQJkB/8ruI3InBDa6gAA2hPKP/Hn9BpK5gHQ/LTGDFqDhsvvVYq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614907; c=relaxed/simple;
	bh=4/t5GN9ps3XzOcrnn6EMeDrYNqFyBuuwb/x1+W0bhhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbku4tQUkOPXJBdMQPwkGHmmt5aZsEsgLRXFgNg2UM8zwzih9ObVnhqZp9m1xeahRKfJND9oo3VxvSHhBrpVspZsGpQRLO7hgrfJCJHIrTUvJ8+2w7Bv24FcUdki0ZtnxcQw9BY2k6GZVC4nRu9ZvT8aXTnLBYheyxoE4qk5mgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7rBtpwj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso1352418a12.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 05:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734614904; x=1735219704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/t5GN9ps3XzOcrnn6EMeDrYNqFyBuuwb/x1+W0bhhI=;
        b=e7rBtpwjhksvQhcdRaXYEX8sHYj860dtBd5POpmnqXMhlBGpMhUxFn/R1iqnkBUBcB
         Yr+zfjMMw6MH2abeTuNRJxXxSytDC4okwl7Q6ItLMUTR4YhG3T5Gi3CQl8kF8fgrvYc5
         njlXuUQVXcrwiuHS/0wx5uCLKOyOim6FM+aL+o5l0Bf9lKf2Ym7qvawNA3wpja9c1Ppj
         HS7ARfGiaNm7VK4Lji0BgPpuXvDD1Lp5xBhiSSSpuHTKXQdTNwkn72cHmg4lrSpCP5DU
         pEuxI8RUvMTUEwTi+y5bRNaFGM/YVuaCNu0FtX/ix9wYQZBQvdMi6rTkzaHFlh0Lcy0g
         LLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734614904; x=1735219704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/t5GN9ps3XzOcrnn6EMeDrYNqFyBuuwb/x1+W0bhhI=;
        b=YurLjwVGY+wu9otbaXq0ETQ7ZIqp89iGTPiau26f5qee6CEWHG3vhQQf8OPDn5/PHm
         BGFabyaNsrs0VRLGbNq7AGEcVeNouHncTpYTwNKIANSyx+xNYh0nbR0Yc/2iC9XIEwzk
         79u+WsKhhDgG2/oLQKZgymwgOLIMXglxQWQs4z6N+1fYrudMVlwsj8IqUi+Dgoyed/Fr
         xER1NZDDPpu0oJ9D8V7I5kAL1mN8R56UkOIng1oy4bo+cEZmCSVTQySLuaLErtz4F2gk
         0Bm54qDq57vAGCnIZBobqT6k/aUtUlIBntPP2DHqgSaZqtbO8qTKkyAku4kDfyl5PZk3
         ksOw==
X-Forwarded-Encrypted: i=1; AJvYcCWEjyISps9xlRxVlzQxy7loAS1c6SfkAqmNrxKxJu/3ATwaEu+StZ8g6nPYasX3JPe6RrD3CyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEmgxTWX60BTNaDmJ2rtgd/TIvPPV9VUt8YXodaG/qCin17tI
	t+b6ViRS+38goEMCEXIM+u2T5Y1is4qlnmJhHNcdx1HUwzLXYFn24zNB1UMOrj2aB3776ZJT5HQ
	4Ao9SjuXop9CBdbDCi51+/Q7i8K/gwwfh2u4K
X-Gm-Gg: ASbGncs4iiKTLZFKmZ5nP+XGLw6OKlxDOGyYYSQYG3l1Z8HofysWrFvXabb5prBb5Xm
	xGu3pg3fT7bmK2fdpgLvp8EeF8/f1JeJwI57MTlapzItK+yKLOqVRpZ/HNtUk6OgnAsVNw4tJ
X-Google-Smtp-Source: AGHT+IHgxMxE4x23GUSj3xrOA13xmvWqS3+DnbSB8GfshOw9pFkne65D7U7b2x5uOfuT+soLzuXQG4Fx2qchhubU93c=
X-Received: by 2002:a05:6402:34d4:b0:5d3:d8bb:3c5c with SMTP id
 4fb4d7f45d1cf-5d7ee3ba964mr6630282a12.12.1734614903619; Thu, 19 Dec 2024
 05:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219032833.1165433-1-kuba@kernel.org>
In-Reply-To: <20241219032833.1165433-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Dec 2024 14:28:12 +0100
Message-ID: <CANn89iL6uwSyb077XE5HNwqm62et-7D58yEZOSxi0hDKMk-FjA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] netdev-genl: avoid empty messages in napi get
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	jdamato@fastly.com, almasrymina@google.com, sridhar.samudrala@intel.com, 
	amritha.nambiar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Empty netlink responses from do() are not correct (as opposed to
> dump() where not dumping anything is perfectly fine).
> We should return an error if the target object does not exist,
> in this case if the netdev is down we "hide" the NAPI instances.
>
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for na=
pi")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

