Return-Path: <netdev+bounces-248748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00348D0DDD0
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B5463016F9F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F6A2C08D0;
	Sat, 10 Jan 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fJueRw8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915824729A
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079230; cv=none; b=iTQwXMg/QjKFdiBZwEt41s06HXTR+RncX7Hg1l3Fhc8ue7zjdhtVsBFnLmzCyLW3UrRcnku5CPUEEBwOCNq+TXHbwgD4XmBNrUGAxMMzdnjrC7YuZdd8h9iz0ZC2yZLWgk9P8h72ljUcuDsQyDxwPNLHglgENKF+pnNhxgqA9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079230; c=relaxed/simple;
	bh=IXfvwuOK5pWc53OJI2lcx6KVCLcJK9alGMkZ7Y+PoPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0uNmjpV114YzSLhs6BHlIzp8FcDcFN9IVEAl2RdtP/C7tYpvNdpUQU6MKXlnPsrMwf3eBbAsHk0voZ6We+/mXmXEdPZJkxiV6ynKdGwcab4e25EsZBnexW44Xo4UtjTCFz9KBCV+HHJWBJUlWe1xUUdJddYiLNlOZHRu6L5mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fJueRw8b; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so8640307a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 13:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079227; x=1768684027; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXfvwuOK5pWc53OJI2lcx6KVCLcJK9alGMkZ7Y+PoPE=;
        b=fJueRw8b7THgvh7RWhoLt4p+QlR6Z1aXuNfnS8wX2ea0PJnk/lQLiIn3BA5PjEey0J
         VOEfDZSefDiAiknS+PLDzXJ5Y0gtGZ+J58GdFMScFTOcLodxBrP4WV8h2E7fz78k73lc
         8f5jzRuTaSd6w1fOICPFY5prtKqiZ/U7/bmcjXPPYM29czEPG0sk9PMi6l+NPWzMjT+1
         lzggTSVBEAN8SXoaFdEUyIlDxo0jZrs7Eg2gxzzSKT2grHfB3mtE61w61hJ93e0HjKcm
         ADltWAaqOvpkwE4sczsDffbpFpOj0StfMhqwoKrX8UiuaaW7cqvbMJbXcBP63WgDlfmp
         RPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079227; x=1768684027;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXfvwuOK5pWc53OJI2lcx6KVCLcJK9alGMkZ7Y+PoPE=;
        b=JagtOI/k0zUl5lz3mN1+UgI7Ve7CY/dK2ZcHwal+0mgJ7jxW5M3e5mlQ+YVQJ0900i
         +75qEIQNpfvR47loYdcIGYWh0+0dSkXheCWW326PkZfF2XjfnM9354/JxhMSOYcMJmW5
         t09rzvz+uHrKqFPYTRIsFQQBM24tUEXcNHcro2D/77rSt7zTQEuwki4ie/26DDa7TJM8
         x9JUYPBC2Yzvpu1PX61qQorlGMTpYTQiSRgMFQzToaV0Nu2aYn1QeVbtsBkV/4GZMOYX
         d3eJTER/kPiwwgd0l8omS6VNB3rpay9UuZWuVtdf+MKyjTe4Ys832vjNg2umhcZ5/1xH
         STXg==
X-Gm-Message-State: AOJu0Yxo7kp/hyyMxlHA+C24Ksx/ya/mPHzrxS+S+QR4fF2JyrumnKDu
	2PJ86j859CjfSCbnJdb+4OtvNIXTK1AfX9KDEe/JZaSXb4BpeQD1cUtzvzSkTDRPL5U=
X-Gm-Gg: AY/fxX5+lObryzYBhyLn7mYO/mLBksolvWzcs8rMTGNzZs7TARtfwFNQIxO+F1eZbqp
	97i1EVgQ4Qcfn118HSjgdWdgZov7jOYzZ5T25mrr1zwsvM+l0g6tIG8ODwYvY6Y9GQqiHLVNTb4
	/2+UdNnApOh12tU+5016dE2WJXBzMF2Slj5DN8S3MtUfoVAhb+Wl2Al1qOreqmg3WsK567gXwsj
	EU1KC4CtJOv7/UpDp1aLi0znRxluhXvzsS4DwOiIaMrG03KbcOf3PA3SFCV0lf3MoYSJ3U2R2D0
	QFkbToBwFtoKSpKUeps6b73pr6fvkSOAi36GBXP9AvUT2vpxDa/Tlo5MJ2+w66GG51P2v3TZLAT
	pxoloVHPRe2REzJQtKjlZoBXWF4w8qe75zJBO4e5x3xHbJZyv+PEJdTU9wEogg3heTt13HZYDWG
	dH
X-Google-Smtp-Source: AGHT+IG8W3YOUpUXKIynx0DSfOesFASMjUPxRhrkXK7LL+GlWPJKWTfQ6zS57nlw8gfEkHEN794pLw==
X-Received: by 2002:a05:6402:2683:b0:64b:62f7:c897 with SMTP id 4fb4d7f45d1cf-65097de7c13mr11938356a12.5.1768079227158;
        Sat, 10 Jan 2026 13:07:07 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:cd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6648fsm13361525a12.28.2026.01.10.13.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:07:06 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2 00/16] Decouple skb metadata tracking from
 MAC header offset
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	(Jakub Sitnicki's message of "Mon, 05 Jan 2026 13:14:25 +0100")
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
Date: Sat, 10 Jan 2026 22:07:05 +0100
Message-ID: <875x99uqh2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I've split out the driver changes:

https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com

