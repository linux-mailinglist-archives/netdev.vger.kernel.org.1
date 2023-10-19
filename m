Return-Path: <netdev+bounces-42832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9322A7D04E8
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 00:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36301C20E65
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BF32C6F;
	Thu, 19 Oct 2023 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EhCfFpyE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3D450ED
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 22:35:16 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283F2126
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:35:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so172113a12.3
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697754912; x=1698359712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6L6sBoVhtv+gisMW9vrcDKOjCxepeY7VRUU0FAAL42c=;
        b=EhCfFpyEpKRg9lDWjoX55C9LCtMdInS280r1So6+Owc2vxXYpxOYNTT9egQA3sqz/C
         EIeA2nFS25MKMJfaG33Qk2W2NSurFXUrgr9cQCj37SBeNdGnUDB5pZbNICa0yka1FF/o
         V8sBJuZ7UBcNzs55L34D5T+7KP4314RJQoyhcfqmJib5d3gPjPOGNIMGDFEtlRRT9bSC
         4+Dd3IBVUC+5QQwCWju8A6IEkQJa9PWjM5PoWGxtkmna6uCUKiM7P35+ILf9A3COnzfN
         nGnBbMpaQ06ecEW0nZI1112tGCtGXRlWImr9zVNmcQ3ahrGwnOsCI5UOrBf5qubtuab+
         EkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697754912; x=1698359712;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L6sBoVhtv+gisMW9vrcDKOjCxepeY7VRUU0FAAL42c=;
        b=eJHPYrOcAolRz6+ZGQC1sWZ6jrwhYTZUOZ5zZ2SBdNIXMNknDRxhvf9jF+9wBRkK7T
         L7IqryIszJuM+YWaIu1hSdMZHRCZS8kd1CX7Vsl4D+iBIF6AzCpkUOy7S2NUixTex0Qb
         cmHsndF09h7d8PKTPXdALG9Zi6MBdEmB6vPf4ss+tPDpPyXdyUvpgQ2tRdIOiMf98gWr
         drV0HTcoNGOT557DEw3UsppljR+SmrCMz7lFtj3fe3bMQip6ljINzlK475heuAi7gtzm
         jyAwRtuGpGXOX3k72OFnQSC68I4GetBLLG+GzaaKVNjGKdX2FIxAFAAl8jlnK543c9vR
         9YVQ==
X-Gm-Message-State: AOJu0YwxDXMM6kpbdTMOu40WJk4I8laas1yLg+nAjod1kAhHtfJft8z7
	Rd3bIatNCb6u+TD4wo9gq9jhYYNMm51gmaDVlTQE8JMqGVs1opf7qKM=
X-Google-Smtp-Source: AGHT+IEdZWTAYH0vwqrtaMnk4W8FAL+z9O+h9gExED1hdEcOGaiC47Rzcdn3qAXdh6CsA0N91h0Rwho1lcLBdMf9jvs=
X-Received: by 2002:a50:cd1b:0:b0:530:a186:f8a8 with SMTP id
 z27-20020a50cd1b000000b00530a186f8a8mr190751edi.37.1697754912395; Thu, 19 Oct
 2023 15:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Babrou <ivan@cloudflare.com>
Date: Thu, 19 Oct 2023 15:35:01 -0700
Message-ID: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com>
Subject: wait_for_unix_gc can cause CPU overload for well behaved programs
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

We have observed this issue twice (2019 and 2023): a well behaved
service that doesn't pass any file descriptors around starts to spend
a ton of CPU time in wait_for_unix_gc.

The cause of this is that the unix send path unconditionally calls
wait_for_unix_gc, which is a global garbage collection. If any
misbehaved program exists on a system, it can force extra work for
well behaved programs.

This behavior is not new: 9915672d4127 ("af_unix: limit
unix_tot_inflight") is from 2010.

I managed to come up with a repro for this behavior:

* https://gist.github.com/bobrik/82e5722261920c9f23d9402b88a0bb27

It also includes a flamegraph illustrating the issue. It's all in one
program for convenience, but in reality the offender not picking up
SCM_RIGHTS messages and the suffering program just minding its own
business are separate.

It is also non-trivial to find the offender when this happens as it
can be completely idle while wrecking havoc for the rest of the
system.

I don't think it's fair to penalize every unix_stream_sendmsg like
this. The 16k threshold also doesn't feel very flexible, surely
computers are bigger these days and can handle more.

