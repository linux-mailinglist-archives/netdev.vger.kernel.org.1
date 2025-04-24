Return-Path: <netdev+bounces-185669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6BBA9B4B2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607431BA6D91
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26D528D85F;
	Thu, 24 Apr 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjIrTM8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683E28DEE1
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513489; cv=none; b=bfqa4VdpywDkwJn6r4h1RTVHqdFCiziqsNX4BRBsECpvUBa5u/ONPtQicEH/RdbXDP9aBG9nRTDYKE/FEw72v+CxJPw2aJsrsip8O1EEmIx7JOZ+oGJ4e6KFyVxW5zQUjY8lDvqKMwTL3GhoJ+yUQbdKcmEul2aqc08OdtJQEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513489; c=relaxed/simple;
	bh=mI+7gRwVIUctLO/aLVIx9D4jjs1loesDXw5i8kmk2dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgB7gasT/og7VxC6oQ8KP6Hb9McHu116IwY/8R3AsyS8rjUkhBUOX3JFOKgRSsoQaEDb7kZVkXE11IPKYMbUlBaGCMXfBLqQDQSQHM2WauIrHf572LVOB7+tnw9iEzcbDlYqUSZXQ18AVd00/IycqG/DoyBFPSPyNczl6qVpWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YjIrTM8G; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4772f48f516so26296941cf.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745513487; x=1746118287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI+7gRwVIUctLO/aLVIx9D4jjs1loesDXw5i8kmk2dI=;
        b=YjIrTM8G3U4qneCLTu2cVavwLDkMufuVXrI0Xk9YVZaxv56zYMGn4sIhaQf0iO2DhB
         puHp+so69EaUWLogLHakFl+REG11ySb2ROSFBsSM7kI9PFMT53LrLpFW/nzmj4MsMhCB
         dHFKGj/fgvI+z9L4W8p5wd0vNauCaCNouggL+lIR2+beDzDgcN64zTpIA1zCAseFqkpc
         tVH7QxWJK9ZtccJkybSrE4VnPEf/Ak1MEJS/ufwG6WsJPbScdOBYiIsb15FXpfkqCr+W
         nqfT9gfwYf9p9iOhyeF7nENB1vVlg+Z09IpcAKzCnT7cZaUP1y8gzNRpVDGq/MrbToN+
         EIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513487; x=1746118287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI+7gRwVIUctLO/aLVIx9D4jjs1loesDXw5i8kmk2dI=;
        b=MaJCuusUsoZJnWdGfanb1a7rHVBXfMEmsQ5OpvHHkjZDnqVfBmUja+Rdsm0EmRymna
         Ekh0t3K7XMmQyVkQURDszaItpl/YO/KQjbap+PrAHcjog/Hc8M+oGEpWSpKq+3twi5BH
         mlROzEJVlNSx0KqIIHsLM34RAFHWxbEs+1oRXzsz/s3F6UiLfclk/wdbe0W9vsk+vysx
         IZhIEm6yqjWIhOj1K5mRrbRVlJfF3gxqTkJFwYP1689fS6bpdgVYMW6+dWLRXSDoD5R6
         OTD1V46Kgx8kEjz3aljQknoyHX1i/s1pxqkx4lvnA+GioPJLctkzVLo599ft2bhfgRBY
         r6YA==
X-Gm-Message-State: AOJu0YwTALLOAZwItCX/Cm/0WiCyBTHB+3kKViS+rz0gaJlRwuLcUXLm
	6+LgyaKD/FzUSlGjIFfrDRb9PKCTBNrMTe7BuwESrfsrmiIcKlp49Lv8x+D6m3WEuPCdYdcEU+f
	TIOvwgPMe1MCQZ9RU8oaHD4Aujf5SZlxzXIGfp9BkWOQU8AqDcg==
X-Gm-Gg: ASbGncu6N2D7IMh/8plWBAl3TLh+3BrXCKEVUrCE1aqMN+CUmZdYzFBivqOmcPtA1b+
	dmzRt/kN8mg7OaKJLTHv3TR3pPG4NafphcKCDcLBNhWcY6AqGjbkvd/i3umVfrL3tSyPopvc/Iz
	RZpMBQ1Xm5B4c4WnG1aeAUPPrUgCYC8ln83GE5Zrt3i6LXRYuDiGILRoKzKARSkQ==
X-Google-Smtp-Source: AGHT+IGLh/RPe5h2B0ePd8DECq1+5uvOC6qlxo9fJEdcEqcCTWNVzxg+nI97qV6gboRDHKxOI+RNR8LRhgk9ZoW0+0o=
X-Received: by 2002:ac8:5a13:0:b0:47a:fb28:8ee4 with SMTP id
 d75a77b69052e-47ec3365b1amr53242741cf.22.1745513486672; Thu, 24 Apr 2025
 09:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com> <20250424143549.669426-3-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250424143549.669426-3-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Apr 2025 09:51:15 -0700
X-Gm-Features: ATxdqUFgndvq5W6lahVq4dVoSiHA2OWQLzzHCECxww-riRN_30TIP-ZCuaZHCSM
Message-ID: <CANn89iLD0bGKdFzSJDiiFhT=Np3LKHM86WE8daFO1zdEzWA+fg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] ip: load balance tcp connections to
 single dst addr and port
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, idosch@nvidia.com, 
	kuniyu@amazon.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 7:35=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Load balance new TCP connections across nexthops also when they
> connect to the same service at a single remote address and port.
>
> This affects only port-based multipath hashing:
> fib_multipath_hash_policy 1 or 3.
>
> Local connections must choose both a source address and port when
> connecting to a remote service, in ip_route_connect. This
> "chicken-and-egg problem" (commit 2d7192d6cbab ("ipv4: Sanitize and
> simplify ip_route_{connect,newports}()")) is resolved by first
> selecting a source address, by looking up a route using the zero
> wildcard source port and address.
>
> As a result multiple connections to the same destination address and
> port have no entropy in fib_multipath_hash.
>
> This is not a problem when forwarding, as skb-based hashing has a
> 4-tuple. Nor when establishing UDP connections, as autobind there
> selects a port before reaching ip_route_connect.
>
> Load balance also TCP, by using a random port in fib_multipath_hash.
> Port assignment in inet_hash_connect is not atomic with
> ip_route_connect. Thus ports are unpredictable, effectively random.
>
> Implementation details:
>
> Do not actually pass a random fl4_sport, as that affects not only
> hashing, but routing more broadly, and can match a source port based
> policy route, which existing wildcard port 0 will not. Instead,
> define a new wildcard flowi flag that is used only for hashing.
>
> Selecting a random source is equivalent to just selecting a random
> hash entirely. But for code clarity, follow the normal 4-tuple hash
> process and only update this field.
>
> fib_multipath_hash can be reached with zero sport from other code
> paths, so explicitly pass this flowi flag, rather than trying to infer
> this case in the function itself.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

