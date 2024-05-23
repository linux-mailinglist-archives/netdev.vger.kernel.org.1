Return-Path: <netdev+bounces-97840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298668CD745
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CFC281A29
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB710A22;
	Thu, 23 May 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HE7xFRLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5E1171D
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478674; cv=none; b=VSjm62vwEYWhDpmp7COS0wIPnfCL/4/WeE5DbeNKaGqswESesinmBArHfI4aN7voKem2Qpds8dQe4KggJ2oVNB2JUWgGqamOuPQSbka2YrzIyqJf/nQNxTgCHfgzvY6b4CBOi9PpsSgr8M/EuJA23qRHa5dLNsqDMOH3JalaOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478674; c=relaxed/simple;
	bh=ewb8fAokVh1uQ0gRHgNv2zxSiN0gJC+JwoHXf21T4v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVDkuoxNT8FiGq+mIcPvg4jaF3qCRCWNI46HbYeUdPNIlesoRyiGLonnTsSoYKheYXFEowZZvDqGRc8UDuHZEz/ZxhX7czNMAIRmeLGQ2h+Qkme2QCrOftb9VxRbprDWg7I8u7bRYzmcuXJy0iWqmSbUNos6OGjqI7YDMKUQJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HE7xFRLp; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df4e1f0f315so2069764276.0
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716478672; x=1717083472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewb8fAokVh1uQ0gRHgNv2zxSiN0gJC+JwoHXf21T4v0=;
        b=HE7xFRLps8EJfsNYg5RZ253mvkfMwu7+96p8f2KBR7mkdAOACHEpxztrkvSWvtXlzk
         8TQ/CYdaUy66XspxV0kikdkGeDFU4p1DOuElZUMEAqo240ruJ/U+Q99sZBMjMGtdUHGT
         lHWhmSy+nfDjigAW9aQik2pScZim+qkdrwO5bkLREWTK0yk7mJGAGdA2DhlX/jDfbjI3
         JcVBBvdejid6Zc176G22qNsFgfNFq2K+rD1XRtun5kOa82NatIEr1/h0RWnN9/b6uZYw
         BhsS0CBwWQTy5jGIDVjf2l/nAzzdNScqo0twRW8F5W2g3y5jZiCeq57Fv78lricvHpFs
         CKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478672; x=1717083472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewb8fAokVh1uQ0gRHgNv2zxSiN0gJC+JwoHXf21T4v0=;
        b=xSLWxf9eUJpGWMIBjgS2c6YC1crqK9o3nvlqYMTpywrOyw5iLB6IoeKqCmUIwkOKWj
         2HyGlZzSSD9fncmvGd2/i2VLDiN/pSuJgVJaRjmwZiUFunQxAHcpvZ8yp6/r1FKsM1Hx
         LRkEUo/aYSXYsFTCU6wOApbDOvUvisqQuPoHmuZmDgl/H5I7Gu/tcV2A+Jz1XrlVQ6E0
         UdgyNyGkvYcL/1KA6UkLulEhGnxA0XlEtq7fbCLQ1VAoO10IR7oAeb1IWCvQprGVtQoH
         3MnrC3BQpuuCUhM9HuNnawYJ+ODlP74h+BuTqkO1C2WLAwkl+Y6fvk+X45QhfWM9crfh
         qBmg==
X-Forwarded-Encrypted: i=1; AJvYcCW3hvqcRa96y0d/faHbgse7bDkp5l8WNxGqK9EDrGYT0q02yfKilC78DAFiMlARY+jPg/dKxkC6jdJin/wpyfinbE8mQ1rM
X-Gm-Message-State: AOJu0YwEZLkw/KLUvmVASTy2Fpm+VpEWn48wqDwbW3vON/l+DXA3Ovdy
	r8P3Ehe/XG3PsqWKL9PiKv7GXfjHt+h9AgpJadUKW1wRr4yGutLogCzigXM3n4CZGAqLpgxlRf0
	hsbD5pG43V0ViOfA20qzzYQlOndCQwux8seRj
X-Google-Smtp-Source: AGHT+IGgFNC2tZCwC/lfU2Q4vYmbDOVL7a7JJKq/dj1q1jdeW2odf65j2e5ZxP0ptH++FK9NrmpVnVUtkXg2XvZLEqk=
X-Received: by 2002:a25:aa91:0:b0:dee:7fc3:ad6a with SMTP id
 3f1490d57ef6-df4e0dd1f39mr5569839276.56.1716478671700; Thu, 23 May 2024
 08:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130528.60376-1-edumazet@google.com>
In-Reply-To: <20240523130528.60376-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 23 May 2024 11:37:35 -0400
Message-ID: <CADVnQy=MGsnuKet_FjXh8a32+bDAE5e3kF716MXb7aNjT0ihFw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reduce accepted window in NEW_SYN_RECV state
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:05=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Jason commit made checks against ACK sequence less strict
> and can be exploited by attackers to establish spoofed flows
> with less probes.
>
> Innocent users might use tcp_rmem[1] =3D=3D 1,000,000,000,
> or something more reasonable.
>
> An attacker can use a regular TCP connection to learn the server
> initial tp->rcv_wnd, and use it to optimize the attack.
>
> If we make sure that only the announced window (smaller than 65535)
> is used for ACK validation, we force an attacker to use
> 65537 packets to complete the 3WHS (assuming server ISN is unknown)
>
> Fixes: 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_wnd =
value")
> Link: https://datatracker.ietf.org/meeting/119/materials/slides-119-tcpm-=
ghost-acks-00
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason Xing <kernelxing@tencent.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

