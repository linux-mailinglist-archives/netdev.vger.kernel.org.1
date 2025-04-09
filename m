Return-Path: <netdev+bounces-180864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0BA82BD2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2615463BB0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095652673BE;
	Wed,  9 Apr 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZSN/I9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914826657E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214343; cv=none; b=BKscS/PsY+DpyTDLLRdTubRF2oX7eEN7lYbEiCL/EqJM03RCzPmnyrqIc9XEJX8wYjH5hNFnZFiT+swfx+8Rcbkw2pn8IoKKOpXOIPft6qngq2l4NI0vAsNzFQ2H4/wkuDKzRS2fujKQFqWjDduJzDWm6XFp5KwTDrJFZ939kGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214343; c=relaxed/simple;
	bh=XcH7EcKvFmwxA3XYUg7s8/QJB4ZCktKtGLmASsozrng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ+bNY2TGivRCJM6uNu1OzTLqobAupBT4lgqXx8URsAVNqFsIojuM/qzUFvD1X2eszpVy9aZpXi2bTQiuFSWIxPehfo1EAFIhIVohcwAGp65x4qw5zrgvwaKwBRw07ddL6xJjn1nQFqWivtO88YAcS4cgRyDspHvZNXLS9AJs9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZSN/I9Z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47691d82bfbso135020801cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744214341; x=1744819141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcH7EcKvFmwxA3XYUg7s8/QJB4ZCktKtGLmASsozrng=;
        b=MZSN/I9ZTBXnXbXn7NAaIKNt4H8XjYjVkO7mYEm5AOFzBwfUi/JDKRXIS73H/jNdrv
         ynKpFqe+xTMm9fRisFud4PyJqId+yKwYi6q/FzZMGzQlvomAehwqpX8pGJY7JEeLTJHh
         Wo3xfVw5qe7nnLk9hdgzglpc/Q5A4KRaKr7swf/RwyI59ticvz5v4SsQAJ/x4jy4tZfd
         7mv6Q7+1CaXPla6RRuo6GfxvrUP/2FaSai8ICB8zpglfBFOFOeN/l6CqxA5Dc5G6+Iqg
         OqGe8/9dbUB/HMQetf8jGPda/10v4LRRBlgnv8R7UsJG3po997isPFL3aZMNIucVXyd0
         qB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744214341; x=1744819141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcH7EcKvFmwxA3XYUg7s8/QJB4ZCktKtGLmASsozrng=;
        b=ZL4UaRLrAFFmovGsIKXmus5NgEvAMlobUwTdoInKv8GlE0GC75GefltULc6JyZBLc5
         kVGIBs3TaGKAzIB+xxkSVXTWpZ2lvt7MGGHVbfY+oZrnNEzMVp8o+3Gve+5gUlP+j7ed
         f+BgFqCQqdJK3KFRf/jLl194+YUYWsFNuHguBGZnnImn0tElL/qjGRTqanm8GOEa4CZh
         fA0lyiCzgxnOMtqLznunm9sUYmp0x1SsSMMEkKRE8fwVTVGk4h2TSbF7VaAvG9Huzj7o
         RysJ6izDSJ3sjd6zsVNms9oj7IxwOs7sfAB01rSPipmB9er39xWr4pgBfl48YTEAqz5V
         7sPw==
X-Forwarded-Encrypted: i=1; AJvYcCU0iJvQIAImw6AjbFjbEnrj9zp0qZCjXLY9fJOfbjf4fIKl6rD5Y03YFDmzFnQNa3nN0ZGR2Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8ZSlha0TpsDlh/8TeQDsjcPPYAWcGr18A5VWd8OFyfsVvLl1
	FJwsnjl9qXPOlyVGuzjDJCtBcdBAGWryssuURL0glTQhJEwxOjFSeA/IGGrs2jfogMOXv/KzB/L
	T2nEMR3IZ3z4mNDpZOrgQ8ogXtTAaV5/tXNoN
X-Gm-Gg: ASbGnctlkUgoWsWUKwFLsNfOsl40kpiUjSad0lHAnrEZ0Uhktm7dV9iBLKBJ1h+T3TR
	WTMtyZ8AbHhIg5YXBE7IYx3GOKJGraYyaAq/Jv5XSlu+AST6bNMyDldSP4GQqHiSxg6KUWGjkto
	bxB0nzUBmQhjniqkkoKeeoIg==
X-Google-Smtp-Source: AGHT+IH0RTESPK/NJ5Ou35TXpdrPGyuaN8DXVZD56fO3j6B3neA5pmFlXcOA2CYr67ILMi7s35IIrwWamYsSXF5CmhI=
X-Received: by 2002:a05:622a:1a0c:b0:476:6f90:395e with SMTP id
 d75a77b69052e-479600a8a0emr47831501cf.21.1744214341023; Wed, 09 Apr 2025
 08:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409112614.16153-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250409112614.16153-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Apr 2025 17:58:50 +0200
X-Gm-Features: ATxdqUGuWPO65Q8Izl_HTv6LGfTHz9AyxHrvgZCqKWrBazkw_CnhWTjlj0b-fTk
Message-ID: <CANn89iJi9+qn-QyrghvT5xZOvqi_FQX5iGeW3X0Ty=xRe9i2MA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] tcp: add a new TW_PAWS drop reason
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: kuba@kernel.org, mrpre@163.com, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Ahern <dsahern@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Antony Antony <antony.antony@secunet.com>, 
	Christian Hopps <chopps@labn.net>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 1:27=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> Devices in the networking path, such as firewalls, NATs, or routers, whic=
h
> can perform SNAT or DNAT, use addresses from their own limited address
> pools to masquerade the source address during forwarding, causing PAWS
> verification to fail more easily under TW status.
>
> Currently, packet loss statistics for PAWS can only be viewed through MIB=
,
> which is a global metric and cannot be precisely obtained through tracing
> to get the specific 4-tuple of the dropped packet. In the past, we had to
> use kprobe ret to retrieve relevant skb information from
> tcp_timewait_state_process().
>
> We add a drop_reason pointer and a new counter.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

