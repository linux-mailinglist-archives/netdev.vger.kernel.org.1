Return-Path: <netdev+bounces-207556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674CEB07C45
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6B558054E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA67927BF6F;
	Wed, 16 Jul 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPR4RSQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107D22F762
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687933; cv=none; b=S5QEIRFfLHkBdomjghrERxJdrq4k/3QHo+jwfwTnOpZF/wVFq2kHkQRhxNUMEtZqon1DTAAYc7g/bTixzMB2XT8x8ucW9Pb9NlLft/1yK6dzFrFrAmd2NR7/GD6zUTXW0ry8ZcluWsx1L+OefWKh24ciUtYMqKgv/7Le2xpcHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687933; c=relaxed/simple;
	bh=wE6h2TC5VcAhKtzJVY1PiPTCFhFLJazrob7Bt/Nmdyk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i9XPFDlKky3qzaGnc4ZPmY1ttf2NL800aXTb8FPYyGEl/mJz0jEZO1uRH07n+0Ng59OcZ4FlYqCPStFjY+nsXHyP3LCZitNqq7ilmOMlKyj9WAU7TkQCwCO1kw4L2ShzbHHeplkCR1YKBAOkMfsKqdq8ZZ69ej83wrvMj4dHOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPR4RSQm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7183fd8c4c7so405627b3.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752687931; x=1753292731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYt3/mqS1R3o8eXuNnWLoWrcaEurR8SXckmftpyuCVQ=;
        b=KPR4RSQmKHzxkNO/AtFA2lusxcn8IYv1DaEoBrsAcyuHY3Tw0p2uRxLcqLizngRAG7
         k9hgh8nV0WjheW24T3/7WxQCP/FduDO8oUy7tEKmYDum+CNrmYmaBanILjzHfygDgsh4
         yznQ4+ww3SQE1h2oRDuR4b7qUvfeDJaxp2Ol6i4WWRdM4uaaiLRkU3JQQ4dwt7mI04jw
         HqqwuSMYQQCgrPc0Ji8Q5s9+ntWmpIc/2BmW4HFOQGYVLZES7vBld7XGb4dQQabRmGKg
         XQ/vuRZ9Lzegxm8fHqbmiXdLqeg1zRHVxgaH0bZESTdwf7bavZ1W5VANxU3n2YZuJY4R
         iy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687931; x=1753292731;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uYt3/mqS1R3o8eXuNnWLoWrcaEurR8SXckmftpyuCVQ=;
        b=effnQuz+7CGeh+0qs39/y7inmWxZFyplGIobZM9GNhBkqORpwmMpXtWUDiTuFw32hM
         UWJBz0m7Os/TzpwJfPXP6Na7CpG3GCZadbth8+UXmJ9kyQ3L0FNCplWH9k7p2ankEHOt
         4dPfneq8DCYZfmJ0Wep8ZNywoa4SNvgimqH+gVNRBWBpGjh+qzSSTwCNqeN2i+Q51PAR
         XkKj/pFB4lxyU/j3t72WMvcorTeug9Cy47BUp/Mb+J7ewAG92EfzQ6v6EN52GxLU60f5
         M5GUcCShmPk95g5LwMZegnha1RBPpEunLymnyJgDwGy4QC6Ep7ztmH4pIP1UICrru7uI
         tbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZpNC8pSIb4CZfJutce3cieYNRDfbwC0p+RnqtXQjR3+N/AvT30hWBKWVSeGJ0u5kOylnCZ1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+xC3j/SmnwytGGpEAMKz9kHkr15G71APxnNHx+8NRRmfLwQI
	6cohDvdLgxzWfxgkYg7cZkhoXjDTjp74K+62SH2ZLynQudBg6Dwf78k3
X-Gm-Gg: ASbGncv1UJuTq9y6CYx00afhe/+7joYS7CB3h5b1+AqvliwUYFH0V8RqPIceuDlUkbA
	biRrXGzICNsy4etsmSQVsi9C+17sfRjPndrW07gLwfWWOlJKOMjrnODw1wqQ7kxv7Ezt4us0CUQ
	4XbVXK+P038/qBXFTTAPpuPH6+qyEKDa8rv7UuAA2uc2AXIKBZfzoySShfm1vicchkGKbADdYOu
	rMfc+JEwkT6QCel3HGrzNmrThXg7b8Lq3C8XKcR+YqLmJvTsC/1UWc6WiyPRJLcte5QsHei3l56
	ZhLz3evaRaLZwnDi/0IcG1G8Xh9qePuomRjfKYr1GiHcRDzEQpJKoHVsTc9P8qXpXWi9L21ZgwR
	s4MPG33WF866Ve5cYb8J2aqWaaTFmFjIVbHF0ZwrzQdRf4NZwzG4u2WUCQ83RESqPTjU9xg==
X-Google-Smtp-Source: AGHT+IH2Rb3wD1A7qeuvZpygsMC5w77lBA7oV/M41X9dK/P+c047pojnmCFIU1bMzJc01819lFWhNQ==
X-Received: by 2002:a05:690c:9989:b0:710:ed16:267a with SMTP id 00721157ae682-718374ace37mr41379357b3.30.1752687931258;
        Wed, 16 Jul 2025 10:45:31 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717d33e81ecsm27884177b3.112.2025.07.16.10.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:45:30 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:45:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <6877e53a6f32f_796ff294ea@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250716144551.3646755-18-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
 <20250716144551.3646755-18-daniel.zahka@gmail.com>
Subject: Re: [PATCH net-next v4 17/19] psp: provide decapsulation and receive
 helper for drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Raed Salem <raeds@nvidia.com>
> 
> Create psp_rcv(), which drivers can call to psp decapsulate and attach
> a psp_skb_ext to an skb.
> 
> psp_rcv() only supports what the PSP architecture specification refers
> to as "transport mode" packets, where the L3 header is IPv6. psp_rcv()
> also assumes that a psp trailer is present and should be pulled from
> the skb.
> 
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

