Return-Path: <netdev+bounces-158100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E9A10765
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1B27A02CE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444EC234CFF;
	Tue, 14 Jan 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6NIwvfS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF82135AF
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860109; cv=none; b=T+LqeUfCCCpwe1IIRiVXwtn9txluOaGAf9MwFcrjlqtDAuS78SJQ2mV+aLVUZc1KCLLYvGAsHD6GCsi4PLFQRWwCZ1O73s4nXCZZPLO8Y33bEb4YPwoxbRA0mOW2kKM2F4FoTgwVQcLs0CKb2Rv15l9zNNxnl+Z02L2xMDGOLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860109; c=relaxed/simple;
	bh=uiCC/1Mbf2s7+vn1p3NnnSItnyOGPWYgQ1y6gQY/z+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYpjm8V/zPJpo9PW9RYzWMiF+bGdmuB5rXq0BxJQERiivA5x9ZmjrJ2sHcdUBKO8z7cGasIUyJPxxyNUO8CCCrJIRrvJ+k60MgoZIukL4naqHCkdTEvT7qwmzdjGBjejPhMSl4+hicuzHQObZcVO1EKGdHbC1BqmwfmxXZCXxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6NIwvfS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso9230562a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736860106; x=1737464906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiCC/1Mbf2s7+vn1p3NnnSItnyOGPWYgQ1y6gQY/z+s=;
        b=r6NIwvfSCFe/DrfaOWbs3FiLp7aSEXLUmyRzZ28caBHPBojyCOot4hLNkxCBsr7dnm
         WlS1JVA1TSNgZESblXeXPTh4jrOPhfjlY+mXbbAGeCQgcxqtxwHaXMugDlhlydtteGrz
         icL5UBv8vnIUzF6p24HMdN+9jzMNBzjRVoOlyz/8ab3uSjqedYGwrUnylLYvIKJumI1b
         H7wB0DyvEVygiViJ5BDZbLNAuVZ8VEcama9ZKzn/1idgGxUYXazR2tFAU7MqEYix7+JQ
         VRQ6Lo7+Ag75BXNltIQhhBw3KlSeCbPRhqLgFzWftBUBasdlPiF+L+9XDcFt3ulgiH8Y
         kWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860106; x=1737464906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiCC/1Mbf2s7+vn1p3NnnSItnyOGPWYgQ1y6gQY/z+s=;
        b=ZIn/fg4jAQnMYGaP5BwL5NgoVRcdl2o78iYCy/3sNNn+bz0rp8dShCg1Nt3esCAbWF
         04MiYnEAsvJ5wZBDFbEf6W6151uKzrj9/4GHSfrDOqMhZec1cGbuUWSiSixdoZp98CUz
         eoHkLQ3rLTTXc2nV3hhLh18t5aRHszG2PimduP3fzFgHqpUfxYO6w5pkRPBwzLCt3ssb
         4Lr6BUNzkpoYC4PCCEGJCU1ngcG1JvI/E+hTf/VauLMoSy0PhWfbdx0y67KcmDw3/uQw
         dEo4bZkguEeJezYTODMnlTmc7pBtjskbESBavQucot0jFlqWN3Y108Pbx7GECKFSPOw/
         dUBw==
X-Forwarded-Encrypted: i=1; AJvYcCVrVKc4Tc6kcLN6cAgKztY/KLH0k023DHe/lHkUxuV6u8vflo9SbTVmzpd/p/Y07+f82lKrfKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFw4FLf2SMgFSAjSQCuxKXJtDe2GPNIZCvh2qv9zXLCjp+dd9j
	l924F0Gkl+HQkk36krggM6AQcUIDTKo/Zy1UhiZKq4CQnNxFrJIHzq3eXndEZhgu5p6+uqQnLAd
	442zXU1A0p51DgbsMqTbrFOHIpDawJc28dpoz
X-Gm-Gg: ASbGnctYMJwnqjehHW2zj0GrgA/LNxhSU0SW5+9V2b+T6Upr3+PnwwHLql9g/jo+g9F
	wXzP5Eb9DNqOl3pHFa2sjESoH1UmCquhhKs80VQ==
X-Google-Smtp-Source: AGHT+IFvY3Qv6OcIDb0c8RQoZ3hbh27Jt9No4xK26zAAxWjnaPWcTBLdIreGupnBNEPH2VswM4s1J+vEXV/AkpyPLMc=
X-Received: by 2002:a05:6402:348d:b0:5d9:6a8b:468f with SMTP id
 4fb4d7f45d1cf-5d972e6d1b4mr25901681a12.28.1736860105871; Tue, 14 Jan 2025
 05:08:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-5-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-5-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:08:15 +0100
X-Gm-Features: AbW1kvZuDJ5edetrUosCDv6nWvO9y9-0KnK8oofqh2T3e20fDDJkSM2PwYQvpvw
Message-ID: <CANn89iKMMhw94mi8sRWrXz3+zLVUUqe4EGum7t64AFmq=-Hszw@mail.gmail.com>
Subject: Re: [PATCH net-next 04/11] net: add netdev->up protected by netdev_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Some uAPI (netdev netlink) hide net_device's sub-objects while
> the interface is down to ensure uniform behavior across drivers.
> To remove the rtnl_lock dependency from those uAPIs we need a way
> to safely tell if the device is down or up.
>
> Add an indication of whether device is open or closed, protected
> by netdev->lock. The semantics are the same as IFF_UP, but taking
> netdev_lock around every write to ->flags would be a lot of code
> churn.
>
> We don't want to blanket the entire open / close path by netdev_lock,
> because it will prevent us from applying it to specific structures -
> core helpers won't be able to take that lock from any function
> called by the drivers on open/close paths.
>
> So the state of the flag is "pessimistic", as in it may report false
> negatives, but never false positives.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

