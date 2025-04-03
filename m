Return-Path: <netdev+bounces-179022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E5A7A0FC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 12:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37091898658
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A82248893;
	Thu,  3 Apr 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEXx9rX9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0521F4619
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676080; cv=none; b=O3Qv5q/wo4dBd0jqGXnhZbDCwtPuC3SQKTbncdwX5y8GsDmozaa9ExuqJMzO7hPofNmhk/jJRyhiPQFiFZcUaALFUUNM+Zsn632rtAcKoykgI0/xGZEMiJ1niJjg1t1azYDd/Y4gBPWRQBTZoUlYcSef67wLF997STBMMclbf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676080; c=relaxed/simple;
	bh=g+zyu1W+Ka+cnsbwWN1Ae1NBt9c69K1+qfkRTzHmZ6E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=tcGfuXCtJCKcn7aELKqbAnGN9bjgG724OvaqFuzOCd2VevasdzCFp/7ilY6P6XSfqCwZ6C+qbjWLTzEVmtNPvlnPAqD6/5Y5/bWr4z3/M3YTlt4CK8rHezPaRBCIg2BxptfuRRmRGttYdaUfxXInn5Y8TIlTlPZb0Qf/uDKk2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEXx9rX9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39149bccb69so637974f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743676077; x=1744280877; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+zyu1W+Ka+cnsbwWN1Ae1NBt9c69K1+qfkRTzHmZ6E=;
        b=QEXx9rX9AfR0XYYw4PBYCgVwRmQ3vTASBVtekAvbnuGlgWm2w3D5RFdemtH/kbER3l
         NJtu8dFUHhnOi3OmusH2UAyiHU0sGFIp/758QsUjkpVHtTAWuMTxpMjrKEtAMtoTqOfw
         DMFfD6XCHbw4hj0i9ofqVl6bgnrUbl3/yPAY/wc68EmVnBz/sDE+pmZZH2/LcPT1YHhk
         A+MzzaX2ZkFEOoDxDdjNwBfeg74WeEo2Zz3LPArfUX39V9IWNb/KfTqprBskerw3gAZY
         a66MNMPJyAznoWp+liwdnQcn8f8bVoqXCwI3xSqi1l/mpAwjyfj8h6QsfPhDUPdThQDK
         cakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743676077; x=1744280877;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+zyu1W+Ka+cnsbwWN1Ae1NBt9c69K1+qfkRTzHmZ6E=;
        b=h1fDDNzF+WdiAu6I0e98eiL0AP1YjyL9c+aS/X4jwq9s0BXYLTzC/xpI244rc6qIDY
         XOh8kiD1HYdOgWmngdT/7aKIKS95qmrbh/lXLWOlbaGFFE/CXiv3277MBVW5e0dqqKPP
         LZkr36KbPlugKfsAvhTzedhPfHH4IClq/gi0a+Gm/JakQ+OPYHSYVF8fSjfnyo7IppPc
         LoPI0UmGuT2DrbMvZTSw67PCfqaXOTjswieiuPT295rI9VrLYwEu65xQeBICRfbmgJHF
         UsIpfacEuWuliDPGw0bs/AxwKyWlS5gE7TYrYEcp9FzNjJe1d6MaNPeQr3+hvy+u123G
         4uXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH/YnzBUNkeovEhP+HhgficcCTnE3cWy006EqxQCYPFjtghBbtowXG9I2sDJ4KKwLi0GLCm/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSI60EdSZfkyAnXLu1YVHA8xBhX5o+/QZhCzhRAJHNwuQ/b6L
	dKPh65CY+Mu8UM/0wQKpT2cSlugbgEtqJLiPdnddZvnd8T+hGkHQ
X-Gm-Gg: ASbGncuSxs2kqjWe2fSvVo04ba2Jk598ZhG7ip0jVhzcTjCsNCC766wLf0OwBHntkth
	kSCEWxuC6AzNiI14N16w7FvPjouK1DXroNT/GJTMW74gjpWbuc/qYUJNYoppwqcbNKO7d1U9VBd
	3slyiA0/Ey+SwqlZDNwRZI2x6ml+LS0zaLaZerwLWnV+Q5nMf7iCR9nNg7neQ1QiQWP4paBRaRI
	C//OEGr7ITSB9evU1K0sVDM8BHZQtFkaSL1+Uh8Bn5BIn7ETVV660Kj+L66XKV9XGvePv+kSc4G
	jUlZ6fIXjhAmdcbLhHMzZzigaDMbHAK6TFa5uWDoIzirUpw36U3vUxGLSQ==
X-Google-Smtp-Source: AGHT+IFbesmNzeXH0wyZ8tJopppcVzAsc4j0RvCwd+Lm50r65zP7Rv9IWXtW6TdWCU7w4s5NCfFznQ==
X-Received: by 2002:a05:6000:1acf:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-39c29752f9cmr5181667f8f.15.1743676077357;
        Thu, 03 Apr 2025 03:27:57 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:45fa:4ac2:175f:2ea9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342827fsm14554065e9.6.2025.04.03.03.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:27:56 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  yuyanghuang@google.com,  jacob.e.keller@intel.com
Subject: Re: [PATCH net v3 4/4] netlink: specs: rt_route: pull the ifa-
 prefix out of the names
In-Reply-To: <20250403013706.2828322-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 2 Apr 2025 18:37:06 -0700")
Date: Thu, 03 Apr 2025 09:37:47 +0100
Message-ID: <m24iz5hc84.fsf@gmail.com>
References: <20250403013706.2828322-1-kuba@kernel.org>
	<20250403013706.2828322-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> YAML specs don't normally include the C prefix name in the name
> of the YAML attr. Remove the ifa- prefix from all attributes
> in route-attrs and metrics and specify name-prefix instead.
>
> This is a bit risky, hopefully there aren't many users out there.
>
> Fixes: 023289b4f582 ("doc/netlink: Add spec for rt route messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

