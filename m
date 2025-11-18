Return-Path: <netdev+bounces-239364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C1C6735A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8E7F4EBE9F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACAC25F97C;
	Tue, 18 Nov 2025 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5l2gFQa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE71217F31
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438623; cv=none; b=YKMVASDCoa1ygCNa2ip9ryQ4eQSpotB8voBnKSgA/NLapfc/eAuKpZUZsw4NldGVmKcDbS19J2rVhTiVkQ/2rH1pnK3vRxOsg1Tcwj0N3xhU1lQpzVrkCL3SDfxbm+mQQArhjLlQ1NHGp3SFKrz9jslJCq3O00kztX9dhN8i/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438623; c=relaxed/simple;
	bh=PthJgVduJV/fdLkCzRWPCbSk879aH0AsOsohjfZxtCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuiHWmOH5plOldYIvl1serPD8eYM7Vs8s0tAzoaNhqlIOO+H13BYvHByefMsCeS+TUlt3L5jp9skaiiQ2vVqZ1+/PRCSl9tP7jvx8mN6dneBeAC0nZGqgMqHCTr0/qcmt1I1jk9R1/zPrhiWUtVahTUARJbQT7h6WeA1Rkswx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5l2gFQa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436a97f092so6472872a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 20:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763438621; x=1764043421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PthJgVduJV/fdLkCzRWPCbSk879aH0AsOsohjfZxtCg=;
        b=O5l2gFQaPjbUVp6O8iXzOAXPI8sySFkBTEaXPRDrm/rBHLjDyAwnK5nAnC4MB2WHfh
         H6D7KTzMmvrStcpn1sw7x/y7RbGFVIOkZF2xIhXJndVV1HO3YBRm1FA83ntUjfce4JU9
         YpXvZNnReHyfKfEBCu6F0hcKw+5nE1dYDovTrqp3AF42meoQny5Oxc3YNYUMSmcUD0tK
         Lo3vxrfOlWqm+igPhD6Lcwh+RkBDs5njP2HrJM8NmCesb6jT6XCmmhHM/qYEh/H8+Pjm
         ahFPdmZsoch5Uwcz7+7k04s3SfsJ1UoL9ZUVMzRtstOQ0MoupGiny+B5WfajNwv7XvBW
         BZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763438621; x=1764043421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PthJgVduJV/fdLkCzRWPCbSk879aH0AsOsohjfZxtCg=;
        b=PEiRkh7l7O6wz6tf1Edrd2I6tp0rnAS4haqBClu0DApamueIrxhEpxXV9/X015/7Sz
         p1g7YeUmnt8uqb1ZRud/VDVVoIoj4JlqvWc4qIE4xB9GQLBsrZ1VkAkK9fQ7WTjgO+Na
         7T+oRbOi5ucf++Re1LrWNQKCd5jMNWXGPm2k7IUsOSoB3+/0fahsAiWMhs1t8P1VWF3w
         wYdtL+dCDEICvnjpAUi4EJ7OMbsUsuQsO/I0ZGW6EDaYuFeihfpMUv5P0TA4g0jQCmHi
         xFMJgIr0mAzs3lKDEzZnL6Pdutfa2kswc+KbbAqE6WFrUyJUhtQmuQMJXrApbmcdbYBr
         NrfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo5BF8uzlNt6YXGZYs/7TfxbenMiB9t98/QEmmaamw6jve1W7FzGH3voyl3IPkSIwOj6rH2KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwJ7xSPl9DXGndBz5p4D69efHQ9BQNcqBtQj0firguS0wzLtw
	3Rx9MDwXvxQLuQBZYamQO0GVWGD658CngwVLgUq78NdbgYXJwTojJjDMJbkfGO8RCZDywd18Bz9
	CcE4ZFH9hSqg29dVZP9I3iYyfK5bCKjVNyED6T/69
X-Gm-Gg: ASbGnct6LN7nGR0DRtJ+cLjj7Oed20JTmXUzhLdFC+pROXPdInNevqEW2ZiBZ0UHMDd
	RfFd8RUUi+V3nNfUJ2PgjocONWbGtmFUuUqJ0lkbeDIZHz9j8EFGeDCAqO1j6SBcGOY3mnAZrE7
	3sj8mJdcmCaWFGBnE4v7ahX8Zb0CldYMUk/wjdXRoAROwz/6iJcZfHvQWuLI4HO9NiZH5BDFSEv
	jflBOv/8nuA+ZyDIVT6ZvGWQdNH9f9mARYKVTT0UYR5fGKckE1xss8FQVoVptHd4RUrqlVSDgMz
	7IqnRSvbA3YqFInHeJy2xGKLPSA=
X-Google-Smtp-Source: AGHT+IHM+u4PCG4CLcxYfI3vf2grB/Tjp2DWae6UXbHX9VD2zgDcz2zY5Wkfp2ghV5JmLoL0is8w0/8AikAgphN11pw=
X-Received: by 2002:a05:7022:ff41:b0:119:e56b:c73e with SMTP id
 a92af1059eb24-11b40e85467mr6612185c88.3.1763438620568; Mon, 17 Nov 2025
 20:03:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
In-Reply-To: <20251116202717.1542829-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 17 Nov 2025 20:03:29 -0800
X-Gm-Features: AWmQ_blwhWBZx4Qprc52D3KZ0R6euoHuBhXAXl0zeKnNG0FRqhDvi-2Ej5tZbW0
Message-ID: <CAAVpQUAH0P4Ma+55DUJZCoJuaUiYBoP4bSkHUjKwKoVBo5p5Wg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 12:27=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
> with alien skbs").
>
> Now the per-cpu napi_skb_cache is populated from TX completion path,
> we can make use of this cache, especially for cpus not used
> from a driver NAPI poll (primary user of napi_cache).
>
> We can use the napi_skb_cache only if current context is not from hard ir=
q.
>
> With this patch, I consistently reach 130 Mpps on my UDP tx stress test
> and reduce SLUB spinlock contention to smaller values.
>
> Note there is still some SLUB contention for skb->head allocations.
>
> I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> and /sys/kernel/slab/skbuff_small_head/min_partial depending
> on the platform taxonomy.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

