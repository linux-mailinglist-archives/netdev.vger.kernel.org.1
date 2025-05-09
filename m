Return-Path: <netdev+bounces-189369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904EAAB1EAB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A2A1C080A0
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5625EFA3;
	Fri,  9 May 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt+A6bfA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098325F7B3
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824681; cv=none; b=hKO8ppYW6h/sT7FaQlhMTWntT8jEWUWAqBaGQ63J0VbcZ6ypvBiVeikv79T0c9nAiZ0iIJXoBJpZB9sD8HfboB0bX32aqlZnyK9ouLC1BPoR+95+GCMLD/9jnhAWKR6mDh85sj7QhroBjqaP+5/9gh+c+G++Xdt9Z3myrNoKzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824681; c=relaxed/simple;
	bh=NDdZ9uhxEDaV2+24InU5fbPJHgTbu+VLUYmkY0cTw5w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Z9RRxxk7P+cJuk9GlzaYwGCwHusoZe9bHWt8NTSLq3oyGGpxAEz2cJteTwluO7Bz8YkmBhXIH8fz3Q+ib0jmE0KR2MrkQTrBF2hDs2JNFwYeaCF9idHZQVeX2XacqaKGXbezOjgpxmWFCdDjZW26lT0jHoOqrGZSn1WLlKZ6aeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt+A6bfA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ede096d73so17775085e9.2
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746824678; x=1747429478; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDdZ9uhxEDaV2+24InU5fbPJHgTbu+VLUYmkY0cTw5w=;
        b=kt+A6bfAekBRSjnwGaNZ0D1gPLrZJgufIHz/nUJOTKmZOBrHKv93XTtAv3UbClQbdK
         +2/uDv8hZ88JhIdaUMk8uY7FARmZOpDUI3xMNykzpXJX2yp4344FG4Kv7Pg3aZ3uuNkE
         M25vMJySIXC+nPSLYyr5x5zP9nUP/N+0lrk7iOZycvAkuKBLva02VMB6JmcrkJ2IRHK4
         xUNN2w5ko6unV62gNoEKgGoTI658TF4VyaEOmkDaJbHKCymgQkoONMfMjr7C6WDBEtC3
         baqYp3tfOzfBUOrc5jDSkbmyiDy8+bL/d9H6ZaSIrKDiTrPU8JgcAmNMFnZ8lxAAcfg/
         7sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746824678; x=1747429478;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDdZ9uhxEDaV2+24InU5fbPJHgTbu+VLUYmkY0cTw5w=;
        b=u0LyXVyvdHeajcTpSFRHLHfz/5NK6R/LBlUA0eUqDudFdnbdXP8H1NRsM3anCARRpZ
         zZSqyND8qLYxDWMZqMXEeiV3ykKvOzjZwLW/q0HVoPioPrfIAWqeRy9yBlHeRuxD1ZD3
         SsdAb6pDV86RAM9MlRZwS1PUv9wKaYmNMC5INnxKnLABcn/LTg8jyBzyG2MZ8j4qk8A5
         wu5ndszUqS5TpSGT1MR9r1K+wpa5h/rsHyvso6Hpqrs9JUtbl0V1LZ6ewthySLT9P0bU
         mA3Q0UFrp1Akm+vyQPsq0VWZXLjNqs5YvRgA/1dsXxXYMIYJLTljNkzd/eq+ATG4jDHu
         BjHA==
X-Forwarded-Encrypted: i=1; AJvYcCV/NzAPD1Rp7EDB9SLi9WhwHD8DC8N7qoTtjfnko6y4amYdHluLvK6sMB8fmoA3MKU23MOoadA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLxXOqCosArIi67lGSXU5RuBp3PO3b/OWz1yuOMCKIMW5qegr
	2ujniQItYBynRZwZMfBXpKwh+eRCtpgk3nQ1sCB8Y6RRaS++7rfb
X-Gm-Gg: ASbGnctIukCsdEW5XaW0NffgM4fEGQ4H1mr0MPkU1HkUvRm5CFLOs/NXGiy4JXVbdfl
	OyTzxJHGhVEVKLB/dm5j5GGuIjgvJeE521UsUAVq9MZJBXnEUi3jjEXh48Rdj2NYnUiWP9H0GpC
	55AoYQpr3uvy/SGFkNsKghwMriNdOB1MVz9PHFH0LXKo6MTCUeX43txZNRHkn5s0Smv5/TKu9Xm
	70Ir7S+GvAY9U4QuaTVALKNrFW0bFaZECfJJUK76LFgtyRcF2zYD6V+UydRONqwp8hahQwmb79D
	w4pVVMbzLGQgvDVVnE/2aq0N9aKKztqjy2oKq9IjKJxEZIMfiCZ2hNeh6NuOrrvO
X-Google-Smtp-Source: AGHT+IHmwMq1947OfD/yprfBrJn/XvX9tcyTkEHtjitJY4kMMgMP8SCm69WSNFP9mfuaw+06MnnOwA==
X-Received: by 2002:a05:600c:4443:b0:43c:fd72:f028 with SMTP id 5b1f17b1804b1-442d6ddd612mr43967245e9.29.1746824677411;
        Fri, 09 May 2025 14:04:37 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:34b8:45ec:8e8c:7fc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f0easm81848365e9.12.2025.05.09.14.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 14:04:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 3/3] tools: ynl-gen: support struct for
 binary attributes
In-Reply-To: <20250509154213.1747885-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 9 May 2025 08:42:13 -0700")
Date: Fri, 09 May 2025 22:03:57 +0100
Message-ID: <m2ldr5h4xu.fsf@gmail.com>
References: <20250509154213.1747885-1-kuba@kernel.org>
	<20250509154213.1747885-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Support using a struct pointer for binary attrs. Len field is maintained
> because the structs may grow with newer kernel versions. Or, which matters
> more, be shorter if the binary is built against newer uAPI than kernel
> against which it's executed. Since we are storing a pointer to a struct
> type - always allocate at least the amount of memory needed by the struct
> per current uAPI headers (unused mem is zeroed). Technically users should
> check the length field but per modern ASAN checks storing a short object
> under a pointer seems like a bad idea.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

