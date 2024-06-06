Return-Path: <netdev+bounces-101293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE36E8FE0C7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FCA1F25EFF
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB2E13C3F6;
	Thu,  6 Jun 2024 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwQI8D1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF313A868
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662043; cv=none; b=EC1255laHxAE1ql3igwaECkpSzmL4Y5wkP/qDHCLfWuhM3PKJotM6LKu8pch/rtzy9WsdpyGVZZE982xTPItqf2yzs8r08nVtVwfA+vnK6FuwmjlrK23YKGWf3InEAOLESZUB0LpwyZxbXkIsfhbkZLGal/mqmIE9+UYjk+I6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662043; c=relaxed/simple;
	bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6OGZd6NZ9cusPEFintEwxk+IiQQHg8r8pTTrq8kfg0wzqIRz5tg4f7sNEFM+3JYV5Ya9r9n9aYH8qMxas21i62celRhe76qvoeFZzJHORyDt13S1BOp0xSshALt7r7gLjPG6SsVxu/qVtBwOefbHb+Nxdi91RAhXg+yPEsnD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwQI8D1/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so5657a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717662040; x=1718266840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
        b=JwQI8D1/KMlpOJERe4LjbP+zOoLcHnwkXu8KzhFSA7Icx+kBNRoH1ULM+mVb30DwKc
         TlOwzCo61lgbuMmS2bjzXgYSVw0hnO7IeujTaLx5Ik2swMy+L0/AmukFmc+cBq4tPiT1
         Vmg9FU8DovorPMwHwTpIjg4iDRPiTByFTwkebOvhMM+VPWuwjsiTVGP0pzWDIOZtultx
         lBWf5CZEu2ipIe1z9otbbic14RbiRsWMsLKtVB9JM6xiRCdC6Dq9StwS5YIEJxTJ1OIJ
         F5U95JRSvoTz/66oVIaeg3Qm/MWj/6d/sxUUsSW3N4Btf0l66z1V67upkN/p9hNoi8R+
         804Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662040; x=1718266840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kI2cdJDpABdMGmQl+txxxVa/ZELbED2IxOHszzsEmk=;
        b=Vx8m6lH6csiHr6EKm4y/n4hCAsh8fAQG3ZNdRjBxMYh2PzIqvYew8qlR1CH7ZL9QyY
         hpNGLzyY/QMznn/lp8zoi2t/GgNK1SQcPh2cteqr8bAX2PyWSVkKFTRtNciEoZMvu7Q0
         TO5F/TF0DaIOdxHNZ6t54iJQr9yLiVgrTmpQ8Y8SNgNHA+fK0TUejLmnyXctW4LYT+oT
         wAMLHrdC+6+8sp+PsAgURCIdSPQYN99M5X5vWpAbE7Yc2WK9qycyWr85UOYpBHhlHRK2
         ZqGXRCG4dTg8u3cqo3jsQcgSpvKoxisqrqWZ/+RPDAR15Cy1OU3wjEDrf1i/cnJ9a4d/
         TC/A==
X-Forwarded-Encrypted: i=1; AJvYcCWP2M9RivuHVoF0F61S8MxbgaBJHJ6xpoU0kpw1NkyHons8TxITtSgDZwjL961UZ56dW7xy6XwQiimKbhZ40T1TSs8I2pj7
X-Gm-Message-State: AOJu0YzFFGIiAHm/oTMe+bNaCSk2EDrySKd5qE7BIVSjhkq6WEvJWOWO
	R1tvl1CuCY8AxFUAUHd1VNCQPbqOeNB0U4IHLJyo0+B8xtnDSD1y9xoV4sFpYc97V5JP+okjaau
	FJF+tkVWAXd7m1oTJKYqnxzNMtIipH6ACm+bQ
X-Google-Smtp-Source: AGHT+IFE9WmSo5OTxuoBZojQvoBTfkJrcVh029teBW5Jl+55BD7o3it5tXbtjBD7DlrKr7HlCiB/oFVBH9UKsTRUNSs=
X-Received: by 2002:a05:6402:180e:b0:57a:9ea1:f92a with SMTP id
 4fb4d7f45d1cf-57aad34e850mr99420a12.7.1717662039210; Thu, 06 Jun 2024
 01:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com> <20240606-tcp_ao-tracepoints-v3-2-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-2-13621988c09f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 10:20:24 +0200
Message-ID: <CANn89i+D1mXLvTvQe+2ggdm_HZiMQcRP4+Tm0Cgo++oyd=zm3w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] net/tcp: Add a helper tcp_ao_hdr_maclen()
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:58=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> It's going to be used more in TCP-AO tracepoints.
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

