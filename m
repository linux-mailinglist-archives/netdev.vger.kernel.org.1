Return-Path: <netdev+bounces-136851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BF9A3416
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EDC1F231E1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 05:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D517279E;
	Fri, 18 Oct 2024 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzkzyCL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6473BB24
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228577; cv=none; b=ZDQWfI6C7MfoicKKRXnCnljU1XDfq4JJDGyeM8D5UG/dvgUZNMdxKSQEmEvxcnVYeutMxM4PmLzaQ2smm+AWVL2RSJsfYiZiER3MXPfwM/nCbNUcIvc+qhFTj9/euN4vJjjtzTu8l7qzh0X/vfBPRe5qbisPCdEzTTf22Hijt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228577; c=relaxed/simple;
	bh=uvBiPoJq7BvgeG3uom4U08EtiWnKRfURpd2XtcIzqio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7KRVLCws9BaI89WoerNfMohbnh5XZtr+5wH68xhul8fi7DAkonjEKcWldrNJW6DJIrFvB8bhvJxISBRQVRJCHDQEtjJzjpAbayagcIrv0BHlYypL9b3CZRjr/LtJvO+3J8B3KnzzxTqqZvRftfIn1hN0JJnhnoBQMmCL6B3HA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzkzyCL8; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb518014b9so15452161fa.3
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 22:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729228573; x=1729833373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvBiPoJq7BvgeG3uom4U08EtiWnKRfURpd2XtcIzqio=;
        b=qzkzyCL8/0WGcSPApneMUzPJVnAbjCT64s85gFeeDi77UYwGQm5I3Jl1jCYnGIflH0
         H4FXACXOEE2yvsC6dkxePA9t9poG0LraPBxnZlST4y91KwZSOBkYOA8alAZk07lKiEMO
         eD4wKRr4nk18oK1XYWE1wHEounlsF+yK3d7vyE9ePZPm3GYfFY2TAlgWNAxYe/rtuRuS
         18UwyQ9D280saOCs9ZjPXnL5AF9toXQXOxqMc8Gquv0FXHPRLs0jLmePsiKWJKVQj0P0
         bBQ58tnGkxLecB61ggEA39EhOxQc/jhb3gMSxDN3pak9cWXmo/1LkjlwXJMDUHlnmjoU
         Igpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729228573; x=1729833373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvBiPoJq7BvgeG3uom4U08EtiWnKRfURpd2XtcIzqio=;
        b=OTp5pRtO3/imLrvFUEuw0ap2eRY1SUTBbxFtzleLgCIcNFpP1dbgA2ppU8c7z3gSdx
         H2Eu1a6XfymVw/cKrZhFIZGroqZ6QOR0h/wwH3EXXSgZNJXYfcrQ0nc/S8ullNOZITq6
         v13o/lGgblLcLNe3g5evoP46spBE/Oz9fEq+6dVuaUwKJ5nozJ5JtfuPkuozVPpJirJO
         ZhAp5yF0xaCbfKuaab29QmU2CGB54LggqOc5NdbhQLqeo/leIIK0dzC3EvSsKkqL4aJS
         6gnUuy0F3FFMO0FqszDgaFYUul0ucFtstvg/PDgHPf8wRNd0/lD7Q0vfC0DHrEMZ+4UU
         0cyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLq5zZpYqEQ3AQct2yuG2qfrYEO9YrWRDQ2HbA9tgCvmW+OOXgsJd+dUy21jZUTAcDF/N/ox0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPk0vXBOfu2mHDskCcGSDLg4g0qGZo9xSSpl+AsjjGoTJSZvTT
	k7aFdpFeu3czHdXeyw6+XgXadzBec76W1qW9Z0ft7mqGxDOkwM8WiTZSkwnnawFfxA2CncRMNjG
	xm/TnlpCA4yGYL8yNSoDJbKnTEVl+EotnwmMG
X-Google-Smtp-Source: AGHT+IGQDhrr/FXur7TzLuoDdEtO28G88iLoQNz7K1NSKTgpdAOmvMWYccuxW59jiG+rInC+RTrea81hwsS6F2i+nsE=
X-Received: by 2002:a2e:4601:0:b0:2fb:382e:410f with SMTP id
 38308e7fff4ca-2fb831f02d1mr3990351fa.26.1729228573272; Thu, 17 Oct 2024
 22:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018014100.93776-1-kuniyu@amazon.com>
In-Reply-To: <20241018014100.93776-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 07:15:59 +0200
Message-ID: <CANn89iJSop5Nhi7nKeuwdiuN+PSwgWh4Ge=84bgYJmbHLmcrPA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] ipv4: Switch inet_addr_hash() to less
 predictable hash.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:41=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Recently, commit 4a0ec2aa0704 ("ipv6: switch inet6_addr_hash()
> to less predictable hash") and commit 4daf4dc275f1 ("ipv6: switch
> inet6_acaddr_hash() to less predictable hash") hardened IPv6
> address hash functions.
>
> inet_addr_hash() is also highly predictable, and a malicious use
> could abuse a specific bucket.
>
> Let's follow the change on IPv4 by using jhash_1word().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

