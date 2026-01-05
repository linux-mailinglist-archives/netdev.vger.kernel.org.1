Return-Path: <netdev+bounces-246995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22ECF3466
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 12:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CF283032AD0
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 11:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6453314D1;
	Mon,  5 Jan 2026 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGPTqadR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E4330D47
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612456; cv=none; b=MyPJN2VVFK15DrH6XMnX9U2BdZCH84m0ZVmNvc4XXhLcMRfHWW2Rr+lsC1lIvIYIZlp/l4DVBdwUmPScdlODEJ/2dGWQovMzZPSCoA/fK0r/4tqMr3cIqXOoKTdqjr6LdJBPlyQCtI734da4r/gl0HtGcDuD6Cn3bq2xomKsF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612456; c=relaxed/simple;
	bh=w3LxHMD4kkR5wHW0DV+nRsYtmZeTdTO9Z0RD8SuWoHA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PMu6xEItLOV8Ex6OVcMs+lMH/A9XoQiI1zkqmrnmhgscrOeYS4//SUDLZUkDfxF9cI+A9OQMYUlMwzKsP9VvREAJKShYfkYr3r6GWYOUp7tK4IsSpWdmil9WIeRxxgl0HNIegXDhFcQbko5lD+OiBSZsz0R6C9KdhyMKWuO7Xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGPTqadR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477770019e4so117245845e9.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 03:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612448; x=1768217248; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GtGsEIDk5yYBdSjpqv4emoTr198N8agoa4ygu+ppaC0=;
        b=QGPTqadRx7X+kZK3LdlTIiUc43AuQK4354hYR2OcSsTaqVPR8vrc7M7Ef2DQ+1697s
         NKkrlEHxum15dbLpWwbTsfR2wLO+3zgoZPm0QLM12rddHPN79ZgbSw2ucr/XeAs101bJ
         EeEMzZFw1biLnW6ZGGZhyePbKYGFiDCugiTVZoXy3lWG7qDBxpfzUr5fsGZSL7ScZtB+
         X8NZUd3nlRVuY1Pjirm8fs111XACaogoddZHwGnmG8og5EZwtMzURqREApXh7kckK4tj
         6zRkX40cHUoNslmpkkV6aD5kvgP46QcItOg4wLYiS4HhkPMN8HwXuMzI6Ib1XuUkrZXh
         tYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612448; x=1768217248;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GtGsEIDk5yYBdSjpqv4emoTr198N8agoa4ygu+ppaC0=;
        b=i9X9hXcuP43iQIolg3a5b8WM/J9/XJwiVnKdf1yT3E42rFcvaLsAPr0RbCOw6ioPh+
         W9ymY+HRaU/hvGeIEWuKc3Ub8nuYTwUjnrh8HiGHHgxgcbgPTl61lzW8EbyrkmuyoQbb
         /onDw+kSPeEJRAi8MdGmAo5s5oe6eUgXBxssXeo98npWpNA70PB7AechW/5EVaUnSTpH
         wsyBG6FvZZRdJhUR3lhBINdGlVN71LziQlr87xE/c1D8BQNNn2G1Zm8LBMs01iTgW7XJ
         rbW1dU7uf0laCgjhdi3fIxcF38TgVqA2iUClvOKVOu+qYBLw7C7VMtcATLaVaCLXEd40
         kM+A==
X-Forwarded-Encrypted: i=1; AJvYcCV6DFhUJVtF9RzZkwodiZ4l1V1wrn+wp+tzmP00UMgiqiJEfSpVDjgJiEWMghIrv7YZpowYuXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVIq+vDt/Wivp/mFSPC8E+BtwdUoINJVxQl3964PI3iHM5sFfb
	OukOMGIxNjq1FvsnCJOWJmk7CtXnVfNxgFAUKh2zOpjFadHzLetjbp6N
X-Gm-Gg: AY/fxX6DLiRW19U0JAQpChxACRaLMm10eYQtyt6eARecmdUuWqAy955xY6r3wmxAqGd
	w3fTL4HH5qF0+OTClEfYXKOZ8beVJF8Jr/vrkJZdmegY4MjDNdsJXVEXN/rZ+tIQEPnv3a5bZvy
	YoLDK0pBsLqXIA/fWD15ZulwnQhTtfgHCJr7ndcqJN4/0VvfMIV+Ly3y0+RKuXk1ArCJaBu8S9B
	cMWqQrReIdMekXf7y+5ioDErIE0JdTiBP4mzT67cCuyJFJKjXNOn9WZeHvWcD2t12KMlfaJ1Ike
	FPv8BcWcuuky90bRMCc/8yOxXjyMDd6GsNTTlUeD50ZBwVCOpi9spFORfdUcYTEnIomuMxzrSkL
	b+Dqw+ppQYXWYcukKtqgGlhS1gDPT7i0DsRfqXuTTkjfFVy6fl3e7qHOfZOa58Gc2ZvCaXXqsJL
	O0jPHHde2mMLbQkK2n0GVAQys=
X-Google-Smtp-Source: AGHT+IFWhDyHbAPuYySIWsrxVQyQ2qEdwvB4qT70AHLiqMEgM6c0m1XGx2ijUI+szqgh35agh76d9g==
X-Received: by 2002:a05:600c:c05b:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-47d1c03867amr520692785e9.12.1767612448161;
        Mon, 05 Jan 2026 03:27:28 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6b9efb7dsm61399255e9.0.2026.01.05.03.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:27 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  hawk@kernel.org
Subject: Re: [PATCH net] netlink: specs: netdev: clarify the page pool API a
 little
In-Reply-To: <20260104165232.710460-1-kuba@kernel.org>
Date: Mon, 05 Jan 2026 11:27:17 +0000
Message-ID: <m2y0mcguzu.fsf@gmail.com>
References: <20260104165232.710460-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The phrasing of the page-pool-get doc is very confusing.
> It's supposed to highlight that support depends on the driver
> doing its part but it sounds like orphaned page pools won't
> be visible.
>
> The description of the ifindex is completely wrong.
> We move the page pool to loopback and skip the attribute if
> ifindex is loopback.
>
> Link: https://lore.kernel.org/20260104084347.5de3a537@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: hawk@kernel.org
> ---
>  Documentation/netlink/specs/netdev.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

