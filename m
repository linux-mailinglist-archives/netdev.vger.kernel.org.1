Return-Path: <netdev+bounces-227547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D551BB29EB
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 08:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC95325AC4
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 06:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57E28724E;
	Thu,  2 Oct 2025 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTSrBKL+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9534BA47
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386508; cv=none; b=tRMSUbUgAe5dcpqqtkmiU5d+59ahaNagyDHph9CnqbZlAXzo2VvAMDFIVU2XDooy07BYqqoeLrdgKdgnDBTpstRNOTMFXMqpjJOlEj5kviJyvejTu30hnyX0CqDosIVySzLfrVy+fzRDATZcdseGRVTPyCkvgQNlu1X8xo6TA/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386508; c=relaxed/simple;
	bh=+lcrU3YTtDZYiZ4n5KrHCkr7P0KPSmyr43+lUAN+gVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8BrqGV8OEb+VFEflDUVtq2AV0PBt8+klwFiYvOAj1bRKjWHFXW62/yKpUN8tDAIhCVtxctf4c7L6CoY3Ez9DsMSwYStLLynLVXzKauA5z2w0dujx56w8uE6GzehW6vs5vypabPZXbGXwbCfyYQo0zMY7CNWQ3TTC8hyzcen0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTSrBKL+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so689183b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759386506; x=1759991306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MbGOmWIEqrWaUo/PXcyq5W6g4F6gnDkLTPdFW2OH18=;
        b=sTSrBKL+K3gGigxMJqPsrN6Ca8ygu2kI/2T6srPpwfKHp/P/YyAjds8354pwk3Fc/c
         pJwOODZcWuCaQDObX6tH3l4cNX+rjm4aUH4bD8MWxAr0wGUoGq96JCoDicq8V3Ql4t3I
         TfoI5dwslxOX9g++XI26tDfk/oaqEER3Rwas61lmDF0kq9ZLkYg5EsrEly4pXgM7hsdc
         qhd19PWiC9EXbI5ONyC9E0rTjl/m9s61JukvJVstlmz6rsDT8Rzhq5RqWkXy6XuK4PZQ
         jgWGhO2Il9n4nsGxF0PAXPiZUPrZFLycL025/ku7GsnMw1xZ3xVHALC7QLiH/lO3zUkp
         thAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759386506; x=1759991306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MbGOmWIEqrWaUo/PXcyq5W6g4F6gnDkLTPdFW2OH18=;
        b=b2s9MueTVQWFnEAYj4ro8j6Dm+xTm9n1fJ/rGupEAyQuqL4E5yJ+Oo43x5+WuF75/I
         iDbz+gtTmNKHRd3NX9g0nuvyxhn9Mk3p3pV4plPLa7Bkrrsy0KbTSxs9HSJYIH8NR9Dm
         oOh/xiccJy/P3+t4MXZuyKfQ635njZvCzbQMLKlFvP3+a4rx5jywNYSjK247PNb4KTzl
         AjFkckcXP+m0BIRLePx3mgj38L7MKNwTPQ9318ZN6WjHhaThvFa4uj1x60RoxFlU7pw9
         rnptd6ayfzT3H4cf9f9citH1sCUtUJOP7oxmc+ovJTDJ32FqBJK6eo7AqGB0R+vBKT3j
         /2RA==
X-Forwarded-Encrypted: i=1; AJvYcCVAmcKho8DAwsa4CP0BeZHz3hVRGQiTOD7n6lX7/gvcgAIf5rI+NZDJOsEVmUX2JSXCz7CTawQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqQKY8nNYTXVDjxjbWdSMuzBvUpjrjzb7QDqL9RNwt68C2e4U
	8deXOxDRUGkO2np6XVt1X2a4Ew92gIjJNkf4ZNSlCXzeTJAWWKW/BBq2Y6XZS07dxrl2oGTY169
	mJbfhCZPvf9OKinXZk5tGlAjrRHs8DZBd2appx/x7
X-Gm-Gg: ASbGncvGFEmdvWI8wfaSubg9stx4hAZ5R67dzQKn5mTZet1/k4U8R4pFp7aXen1NhKR
	bgRqMES21TrpOlWeRw7QM/nVI2qGTzezaSdvycs48Laq4r/n5m0ylQoECVWNJnesSq6iiJklcuj
	g/S705R1+/zcI6Xh5FW/nyjrYGMKlRrNKFCGvVx2VXy8m1hv+pi6RDSlMDpDlLWE7yoZJwOe5hq
	TciuY6rscA6mUwUDz3IF+mSR4NRm5CAm8JFW9FI8gu5j1ucFlU4niDKNYIsyK6m60henLCmhaHY
	Bkg7XTI0sg90/3TK
X-Google-Smtp-Source: AGHT+IFrRY+Or/vfsrZXsxndsULBSoyHEIHD9Q3SbkWPPuWFlGtC9bBggjEp/2ID6zIFaxn3ABOzVT2FMwsI6//YIS4=
X-Received: by 2002:a17:903:19e6:b0:24a:a6c8:d6c4 with SMTP id
 d9443c01a7336-28e7f2dcc13mr77352385ad.26.1759386506306; Wed, 01 Oct 2025
 23:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001022426.2592750-1-kuba@kernel.org>
In-Reply-To: <20251001022426.2592750-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Oct 2025 23:28:15 -0700
X-Gm-Features: AS18NWA5ulHIiUfeWL7R9QnpYU07CQcldhYL-qVQy6mWl74drF_buq0B_OoDUfY
Message-ID: <CAAVpQUCZNhW7zvFrL-kmfkks=u0RtOBW+a-R3BxtqHjt0aud7w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: psp: don't assume reply skbs will have a socket
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ncardwell@google.com, daniel.zahka@gmail.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 7:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Rx path may be passing around unreferenced sockets, which means
> that skb_set_owner_edemux() may not set skb->sk and PSP will crash:
>
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:psp_reply_set_decrypted (./include/net/psp/functions.h:132 ne=
t/psp/psp_sock.c:287)
>     tcp_v6_send_response.constprop.0 (net/ipv6/tcp_ipv6.c:979)
>     tcp_v6_send_reset (net/ipv6/tcp_ipv6.c:1140 (discriminator 1))
>     tcp_v6_do_rcv (net/ipv6/tcp_ipv6.c:1683)
>     tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1912)
>
> Fixes: 659a2899a57d ("tcp: add datapath logic for PSP with inline key exc=
hange")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

