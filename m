Return-Path: <netdev+bounces-180748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77AA8254A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1C9189AD4B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2042620D3;
	Wed,  9 Apr 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0F+GI26"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DFA2627EC
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203072; cv=none; b=QgMKXR3Rs1VutRyWD9kG/GUbOdAWKXkljBv9SfZ1RKoER/PNGWcy73AjLBJr69p0/aeDBoKmhhCvts5lvNdds7XkULitY704vDMk0pNiPTRGB5UY3oYGH8nlXjuHaNo7xW0vrrGzaYi1gU91qRokhdWEcYUf8AgYPKOYbIieEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203072; c=relaxed/simple;
	bh=B6SYW/vYNY9rSodEAFtL8/7Wt3OtYZlPW7nBqOZUA/M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CYdwz3Xjz0QZzPphWFEcRQC2Q91KDQgeqVcsjaPaiA91xGIVBaLBSz2LOW8AsC28Qr0Ek+eyszZLhoJaoVeHp3bYmz42wd884oaGW/SQSVxSDw62iLrSfuhTySxq6skv5QxQqpZSMO7gtnBBgWGcqVPU14fIrGoPfa6nCUZH4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0F+GI26; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a823036so61024115e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203068; x=1744807868; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0STw0L1V4iQw1xjSHBHjAeebYV7L+If9mrQubwhJOQ=;
        b=e0F+GI26FCQLsPOgLI5ZxNkoTg2pYDCfvRZcp611BSlKFv9fQsk/Ob4Kt51c7X6Ncx
         b+lK/7Vs8rQNQwTld7xRXcUJufC8VxNgLnXnD2PUP25JVvc7u1WT4vd0q2aI5lzvLFOs
         ahSA++gQ5KMJhnkJoMA4gzuoOl35DpamhBl1L2L+cDKL7wCt/+1jnFr07EkkjuKj+Ubd
         2j615XfKeYnQdopib7Y+wyJAWYkHG9OYb571RVhsFx9C+j97W88xXpC/UTAvpBJxq8YW
         gIR67m7Rvkqjk5uAXZww2sPj+MGlqBfSGGmOnbcJUdbO8Bmdp5vJcZ0CV+TTUx+ZcCfh
         wQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203068; x=1744807868;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0STw0L1V4iQw1xjSHBHjAeebYV7L+If9mrQubwhJOQ=;
        b=Pc8s62a1tG4TUF1c0n2h6yngbUwSqTQVL515VlpGP66sMb9KbELPRrOliBkL7aXy+F
         4BdN28YFNDJ+WG5AZLMjvkvSirc4eSbneEmsQtMl4zDq+/vuPt+SPms05pIHzSgueMAc
         HN91/gdNBbq1iBbOQulfGHnMjIjkEv/jlEQij0zGeyc7ifvQ1xFZ7WVDOa9324Kpipz8
         dfC5c1LU3M0wgfZqgLa78GeoyMOecdzAaNVFC4qJq3pstwTwNeqVdidmRPiXXgJ+VpgE
         NmAUZ2F9icnNaHNCFonyPwYooBT949f5E4KBd2OWSaQfm2BcVkL2xodCIVCnpGjBp59k
         kDKg==
X-Forwarded-Encrypted: i=1; AJvYcCXJEYvXEtPxhi+EdULlD2nWoAtltDC5X8g95W4tDTxOeP/u/vWx4WCq2umQl5aluSd+AiHeJJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrbONYnVnikbanxkfJaU9P9UYxvRUZRFyWoDZrRlxJsWdsJ5X
	WsIaYPgUikvJfR3rn3LHErV1MSuI4V7Gw79GbldgrAs5X/WtDAwc
X-Gm-Gg: ASbGncu0odIzgf01mxkEDJLKfBUg7BpBwO2Wbuf4r5g6GkXsfXug2xchZ0jbG/LCwSQ
	jEsz6uszk8DfjzjTX2E46hLyvxKPQH3sWvaGgtskt94JqZ8usOw1GxpAkOsRLnIjp4T1vYD9P5z
	OW6dzPsANw5rwNgxqU+Bjm4WaUhGT36Maj5Hr7kux1B1FbAvOBNEgTVAmnS/U/xVivZsn45isVC
	at6Zmy6hLaCYpzTucIKd1oyb2pZNR/7lVzKkaqCEuse0TVAOuYA9+2oiKli8VU4jgB3caGgIIDx
	NO+1f7ergFr7n5TMPTN+CtYNjfTm3nCBPVR/ETVxajXsXVSmPo/UfQ==
X-Google-Smtp-Source: AGHT+IF/iiD/md1TS2k9O9uyeytP5ZNOGJZbWhMGXteouZg+U7YIePxeRHN8HW0FAZycZr9iti5XSw==
X-Received: by 2002:a05:600c:3ace:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43f1ed4b996mr24535705e9.21.1744203067921;
        Wed, 09 Apr 2025 05:51:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89361165sm1603613f8f.19.2025.04.09.05.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 03/13] netlink: specs: rt-addr: remove the
 fixed members from attrs
In-Reply-To: <20250409000400.492371-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:50 -0700")
Date: Wed, 09 Apr 2025 13:19:50 +0100
Message-ID: <m2wmbt34t5.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The purpose of the attribute list is to list the attributes
> which will be included in a given message to shrink the objects
> for families with huge attr spaces. Fixed structs are always
> present in their entirety so there's no point in listing
> their members. Current C codegen doesn't expect them and
> tries to look up the names in the attribute space.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/rt-addr.yaml | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
> index df6b23f06a22..0488ce87506c 100644
> --- a/Documentation/netlink/specs/rt-addr.yaml
> +++ b/Documentation/netlink/specs/rt-addr.yaml
> @@ -133,11 +133,6 @@ protonum: 0
>          request:
>            value: 20
>            attributes: &ifaddr-all
> -            - ifa-family
> -            - ifa-flags
> -            - ifa-prefixlen
> -            - ifa-scope
> -            - ifa-index
>              - address
>              - label
>              - local

Yeah, that's a consequence of me not really grokking the intended
purpose of listing message attrs when I wrote the spec.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

