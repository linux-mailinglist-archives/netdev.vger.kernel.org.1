Return-Path: <netdev+bounces-112327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2092938543
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 17:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C8E1C20842
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006BD1662E2;
	Sun, 21 Jul 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Las4SBa+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55952BE4A
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575380; cv=none; b=RzN4DFp9wNFr2yGBfJ93NQWxCnWzYgz9dEKdBQwpdXl1CbPKvhdlmwoG34K2+HAJAJfNmOA7slH4j7h8JB4LMujfnSvey/cl7K5bkQ3C9p0MB/0ST10cM26XsWAPviVVoFYohvTwkUMLk3Tx/f8FNRnleAcWeti/FLlrxNgVuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575380; c=relaxed/simple;
	bh=Oh0bMNGd+SYQ0S4Nct3T7Nuc3+AfPX3/WlegU6RhweI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSQolcujdGknDvvR6vkQ2G6GqbOa/p9z1n+4KifS7nZQl/eKR9sI1lOb0uM33coic8jHcZjsd+NI2KBYUXFXVfujix3XBZ91h/oVXMwgpqt8M9ujVrya3SbA2vpSL3eDr1meHLXkzQv7PDj27QQlazP+SmqYrR8gHSJgqLBpj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Las4SBa+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso30387a12.0
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721575378; x=1722180178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh0bMNGd+SYQ0S4Nct3T7Nuc3+AfPX3/WlegU6RhweI=;
        b=Las4SBa+qx55tIjiNsJ+ayP0mANT2yF/lJIQ8sF57s/5izvJRLFpGaCa7Fgrl06ma9
         0WbAmxzCukL7evhON58sHFO45iPfYzOXQfsAYbiJroBn2/7OmngvoePn2vimF/iogE3g
         vnlF34vZpl1AxhpdFHy39H/kVVNExWO6i/83vlsifsQlVNZusHznIBUFYT8KJrDdEGFc
         PFU9B9VwLb4OTGJ0ltKbtgtfvREYie7+SM/AkSvvK7N5tJkqopZr+5seXqX12nLIzd1z
         wvVDcP3NGwTzxQ+2WQ53zcsif3kIr79CkP83Tkxjpu7wm1BF+vkHqf719JGH7cMY57sz
         RZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575378; x=1722180178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh0bMNGd+SYQ0S4Nct3T7Nuc3+AfPX3/WlegU6RhweI=;
        b=DAB0q34GBT4+Vs7JFttRsG88d8vP7A90gHmOnkPKvg1bAYJDxW7/Y//MzbK02rkMLq
         hO1HeAuviRqA/7ojx7oMjDcyl1kWGdPhGBuI5vspdO7yps+qLMU2CD0TxUvdOBusgWhD
         1gaO1MOM2uHz9jC4XfzGQ2y8G99oN/EJE4L9V7aN/I07sc701DzErhobhxq9JrmoiTJg
         fqE1GLVrBV+BfPz3bR5K5JEHFIPQTyI+9lekKSK5HcQWRlC9UZtKG4s/iCFQg8scEj6Y
         U/Nw4Yaos7oiVVs5TysdP+xwn4kOzHljVwvNauDVG3kW8YkoX30TkDqdHwT0KnpnRr8z
         Fzjg==
X-Gm-Message-State: AOJu0YzrwEtk7QlJQjuJTcO1ZqhJGjfSO6jRDepcx4167A86UP//B0ih
	fpkMDQYIDpvfUx+tlV67UBNlFUhN4oO6EyM3QfedACCIh71LymSgVJVRM1k6XAeQ3+19Jgy10G/
	fS2w6FgCJ/T6vdpPUYA9hNVTBUQVItT/cgCBiCHSTTlcJF5nMpVlO
X-Google-Smtp-Source: AGHT+IE+lJe/AejQFBMo3dUg77L+OWLtKdthnwhoL8Ltie7WhfzS/hb+VGu2PIcimMjM1Hax/O0X+c6m8ZyjFUkCyyI=
X-Received: by 2002:a05:6402:35d6:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5a4a8428366mr101775a12.1.1721575377228; Sun, 21 Jul 2024
 08:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720140914.2772902-1-jmaloy@redhat.com>
In-Reply-To: <20240720140914.2772902-1-jmaloy@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 21 Jul 2024 08:22:43 -0700
Message-ID: <CANn89iJmdGdAN1OZEfoM2LNVOewkYDuPXObRoNWhGyn93P=8OQ@mail.gmail.com>
Subject: Re: [net] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 7:09=E2=80=AFAM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> When we added the SO_PEEK_OFF socket option to TCP we forgot
> to add it even for TCP on IPv6.
>
> We do that here.
>
> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

It would be nice to add a selftest for SO_PEEK_OFF for TCP and UDP,
any volunteers ?

Thanks.

