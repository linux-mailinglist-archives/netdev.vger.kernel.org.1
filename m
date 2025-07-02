Return-Path: <netdev+bounces-203323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3DAF1560
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257A817DC06
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1826E707;
	Wed,  2 Jul 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="P4epZKvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C726E17A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458639; cv=none; b=AGTJzmtf1oPRU2TAKpabz4ysqMgcS81+PJZzvExBiJzYvtPgzW6YZsQ7pRuq8D4gBKid+DQJm1vK73oscYmQe99LGFMd2+TJQEBWB0YBjTt9Y4Oy/hDcNRZh9XKT3xdveq0cLHUOx83my/UGhKV4EBOMkVFFf4JBixqQ8ddf7RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458639; c=relaxed/simple;
	bh=uzbmKudiCVqbCWHjsvWpIONLcOqXoBM4sksfA7jU3N4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jknOJVqRPg/PiZ1Hzy/3zh0CbEN4xXp2ZuB61/pt26MsQGBsPxhMEkqseoRt6H79BdClaNiyPvRGJ3NJna9Ph50cZr01ko7hrgfmDSAFq+fGcl2ib48j2B5npnpFjiF7y0Tpx11M5ESOYjWwq4ToycGWpdqrb6am8/TwYGboX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=P4epZKvA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae360b6249fso877806866b.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751458636; x=1752063436; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzbmKudiCVqbCWHjsvWpIONLcOqXoBM4sksfA7jU3N4=;
        b=P4epZKvA0luTXkjDRr1G4JmggNRPZfOa+42wwyhAgrTIxm2CBjn+vQPOxjT2uFTn7e
         1HoSwvatZQaWHvH2NrAg9GbeX1fjPqQdTTqrAYDDJlx/p3hAjT3VBsRBxb0rST0yet5t
         /XOBZGoGtwgOT3Ox6ikhNvVzHGh4y6n7Z77Bu5AO1JgHX5yqWji4qOi6DXv8YQJHZDPm
         4M/OgvAIzaXX2LwMydQSu9qeZbDWiXg9vaH8yLh4ty1fy/opeTm/+lIyghNi4qU/w+LZ
         lBhjFQRwVtKhFZa9jqIUEGf9dLMPzBgUGU9Erffhculxj/I04RROb61NSd7I6hNRHsge
         +kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751458636; x=1752063436;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzbmKudiCVqbCWHjsvWpIONLcOqXoBM4sksfA7jU3N4=;
        b=vq2tttHw6u2pNhCYDbv09m2CKpUG1K3R0FxwliFSp+J/fJ7wvPjvlmi7DdUNeYcJTY
         3VeRbH21GS4lXOsW7immbUPHR4Dwn92KLI3QNIcywv7ifwQYlfH3KLialjs4GhZIreOQ
         3TlxVQOEhKJRra2izkIjLbPCbUcsvUngkWXs1gsXKJfIFizK67fPAwm8MVmUQ67m/Kov
         6Binup26yetxGIyDRsDXMpw6kcfQyjPkCu6wM3SpRUAdDWaQCBsp2ASHdInq6XsJZJbC
         zkd/43PxlAHaXMzpdFNKMp0l56+Ir+nFQPxELStH07vJ3t8e2O57xPjNHnrh3Xhefnoc
         nL5Q==
X-Gm-Message-State: AOJu0Yym56KcLKsTDHqunV5yRsymxcAgVJAECREi1BdTwCqLGNiIn7hI
	SsNbIaMEGMGZTqAnvqWJ2G9rRFpLmSUoKrCEI7G9aDg33qwdp1qFcFfo9PFnIy9pGkN82QSW3VZ
	3RQcE
X-Gm-Gg: ASbGnctcHol/P/Nx5m42h8Eqj8liFsRFXRbogWcCcUxvvN4xMIQ7ImoOHge2dnCHEm/
	WDwBTK2SnkHdtLuLRqEiqi5VSdB1nBVp4frT9sEgETD3SkzthC1jYj7w3j2Osir/RLs25nnYoI7
	pVywn45ctcoduXqKpMEFHxpO6WYGBaQONe0H9VVzlDgvZykyH6WS7RMU6ncgkbgcBV7hYz6ri12
	bUdrbb/1JYmIdlpzyu0o6sl0zL1G+GIftifCf/ExhKqjpVE4KoxcERpefaaqr2Qgn1yeRAcpnvh
	nDUiaPhpMB2cRll28Y9YvvMLsvafrX7moCXp9xxLS2lWaTwEGYWHzBg=
X-Google-Smtp-Source: AGHT+IE1QJ3AjK7fa64xTgB3aheM3DjGwzgHhV3/DYIftQwwZX3WczE3Ty9UlDMRgc+foEdD2NDunw==
X-Received: by 2002:a17:907:7fa8:b0:ae3:5e27:8e66 with SMTP id a640c23a62f3a-ae3c2bdcc36mr284553666b.27.1751458635631;
        Wed, 02 Jul 2025 05:17:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a090sm1075241466b.56.2025.07.02.05.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:17:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zhoufeng.zf@bytedance.com,  Amery Hung <amery.hung@bytedance.com>,  Cong
 Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
In-Reply-To: <20250701011201.235392-5-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:12:01 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-5-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 14:17:13 +0200
Message-ID: <87ecuyn5x2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 06:12 PM -07, Cong Wang wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
>
> The TCP_BPF ingress redirection path currently lacks the message corking
> mechanism found in standard TCP. This causes the sender to wake up the
> receiver for every message, even when messages are small, resulting in
> reduced throughput compared to regular TCP in certain scenarios.

I'm curious what scenarios are you referring to? Is it send-to-local or
ingress-to-local? [1]

If the sender is emitting small messages, that's probably intended -
that is they likely want to get the message across as soon as possible,
because They must have disabled the Nagle algo (set TCP_NODELAY) to do
that.

Otherwise, you get small segment merging on the sender side by default.
And if MTU is a limiting factor, you should also be getting batching
from GRO.

What I'm getting at is that I don't quite follow why you don't see
sufficient batching before the sockmap redirect today?

> This change introduces a kernel worker-based intermediate layer to provide
> automatic message corking for TCP_BPF. While this adds a slight latency
> overhead, it significantly improves overall throughput by reducing
> unnecessary wake-ups and reducing the sock lock contention.

"Slight" for a +5% increase in latency is an understatement :-)

IDK about this being always on for every socket. For send-to-local
[1], sk_msg redirs can be viewed as a form of IPC, where latency
matters.

I do understand that you're trying to optimize for bulk-transfer
workloads, but please consider also request-response workloads.

[1] https://github.com/jsitnicki/kubecon-2024-sockmap/blob/main/cheatsheet-sockmap-redirect.png

> Reviewed-by: Amery Hung <amery.hung@bytedance.com>
> Co-developed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> ---

