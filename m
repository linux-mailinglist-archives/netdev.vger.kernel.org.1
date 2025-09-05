Return-Path: <netdev+bounces-220300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE422B4555F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B881E1BC71EE
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED56131A565;
	Fri,  5 Sep 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxGYZlve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2A318143;
	Fri,  5 Sep 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069646; cv=none; b=Tx5EFdb8ayYGXRhwqZelBifBfu1wNsfdiAjLFl7bkfRYIfhOWZcGxt0mBQMfrpsCw7fWQWA+Vf2fISJ2w5Q1vFjxxkMlPEie7sqqtC15vjzrtpYpZTa4c7sGWvfjDfHQengqDAyDXXWhEPpff/Etqp9n2rCoC0w/WHQDFxFiaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069646; c=relaxed/simple;
	bh=nWqeEYLMHIq8h3v6YSLMC28H8qUubeFkyVGEl+EW9eI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=rIT2Kfu3ImmAnMRonCwjo3iBA6o2L4Z7e9gVX6aTci3tXS9xdjUGMFSkyiAUMvCt3YujnBsZbrUm8oQs/SJHKwHi5kmOX81wt0vTQ7f3aqSIf5oD6TDlsBECMU1tyjtG+5NXzNQW2LIpgBIILFeLoqBTi3RP0J7hs7Ze95G7VlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxGYZlve; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so7655025e9.3;
        Fri, 05 Sep 2025 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757069643; x=1757674443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWqeEYLMHIq8h3v6YSLMC28H8qUubeFkyVGEl+EW9eI=;
        b=fxGYZlveIBKTC9z81uAJlVk+zkbkWLf1IF7TmzpGe0eV7Dp/r/pCTtV30adrnTC/y3
         JU0I+iR+N3mJ40gr36CMtt4uwwjqRUmcnHo/rxpfikvGlNAneIDc8iD8hHIp8YvUfILg
         6qOLmaiplHksU7RcHbl1ICjTeHqVsCbza2of2UUcqMlnY5G2583JmfDcq6CoCc44x8XP
         SDk5AXLIj8vXwLF668XkC/0e+i+9kEuvebEKtawlwKn+X9h+s0W8ZiJoRgu7aFjn8Zsl
         AdVNpWacTuU2wkTeaGl0d4tqkDjRQxHj0liK7ea0sW7+qZ/RC6F4qI2N6MkJ7kbU/Nlu
         DYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069643; x=1757674443;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWqeEYLMHIq8h3v6YSLMC28H8qUubeFkyVGEl+EW9eI=;
        b=rO3rlkoZdikhzUoqIwhH+xGRCd/DQbbFN1syu+xIT2cepBDH4F7nYWRy874J75DhP8
         Vqi6APmA3+1nSxFNr5r/aRkd3UD7bnpt0NQUgdpDRhZrb2pMTPp+GOiSqf3Z6Kos1JLg
         e0mcetbHmhgXt8ShEcL2gnQ6qzXHHNzobvBZxji/JMY3fKf3xIuUmjta+6r1XNwvKixi
         MAfrLVfkAD24r8EuJf1bY4dAb7OCTHqf+AJk8dVkZDlWSWzyIrZIesgl8IVA4lwNqND4
         nsuyZpvDZpr5+3PDl5tBKlftV3Y5BRHYK/JSHwjLmhdy4mrpYBtRPezhDqR0SIbS1UT0
         h65Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEQv6qq4JxltAgWxwXmgQxol7F1+SAJE2c9Lr1MU5M7a/dHZy6sXoPoruCtR/ugcaNk2mgNasV@vger.kernel.org, AJvYcCVrixz+v2siyT8v9WTQMaIzm3FKZJGuTx9C6tTdfqIpgArVBpVhzpl1K509DbRkJ5w8Q14BSXYUwDRG5Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6s3TtRgKR3yAI3K0bhEw8NBK4I4XACREXy8VC6LOkSBmi1ur
	X1SeiwM3fO8nhC1iwKpvgoSUu5UyDB4puS39MN6pmr+EZTsIMIzzziDviTm9cgNf
X-Gm-Gg: ASbGncvzxM66PaaLHRN1AssGVL9FkwsKBdLJWzeBYw52dw0c3QhVGwWHC4UzvRs9VLS
	bYvlu5kRitoWooLcj5ceo4SRTw6rqkBP/nZbZM3RdkIee+Fe6Q3u5DeZ3cXXNTlbII3KCcZgczL
	casjLV8BCA44Xxgqm7w+8zhdKLmTiMto/bNIue869wJJXnSkoqS8O3ZlExYH75XDPxQcHbjVgzV
	hGK9nFXwf3LanRm5w5fl+8lgBYZg/0m+2T02ujWFmt6kFybBBohh4xYkROQFgfVgEnvyyfy05Pk
	L2oi/VAmhV86s2Wo2Rv9WEHMQw9nUUUN4XJWf2y+zGoP3Qb9YlaBSjbGIh1MouEq7un6/vyI8WO
	HhrWbTZfVmiJmhIuqmRQOjTtJr8btXtboX+RteRiIWo3cMg==
X-Google-Smtp-Source: AGHT+IFre4je9aX0hE0DtE7GN22/+c6dGLc5GGdRk67qwV6Xk/fcd1S/XONZz/Y4orXr60TEmO3k1w==
X-Received: by 2002:a05:600c:4692:b0:45b:5f3d:aa3d with SMTP id 5b1f17b1804b1-45b85570b4cmr169521185e9.21.1757069643241;
        Fri, 05 Sep 2025 03:54:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8157:959d:adbf:6d52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f2d3c88sm192332845e9.19.2025.09.05.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:54:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/11] tools: ynl-gen: rename TypeArrayNest to
 TypeIndexedArray
In-Reply-To: <20250904220156.1006541-7-ast@fiberby.net>
Date: Fri, 05 Sep 2025 11:44:48 +0100
Message-ID: <m2tt1hxjof.fsf@gmail.com>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-7-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> As TypeArrayNest can now be used with many other sub-types
> than nest, then rename it to TypeIndexedArray, to reduce
> confusion.
>
> This is a trivial patch with no behavioural changes intended.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

