Return-Path: <netdev+bounces-233983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F9C1B086
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98F225A1909
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F792D63FF;
	Wed, 29 Oct 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YK0rm6No"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402C30E0FB
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745327; cv=none; b=Cxm7zbSsxHpwOgPnT+72gxDH8NfNmyA4t0XtPU+bHUipz/yjbhsDk5Sw/kkSrPYk9szH1tRnb2VAluXXGoJUSHTVhZxnLc9J8x8ziYRL54Zm5lI9XfDT249d/1gL1I52dFMBbWeXxN4kKF/8XWn07YM6EpaRKjcm0FYTWV978HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745327; c=relaxed/simple;
	bh=zbMOoAZx7RYNx6TmQte8UME/DXY5NFfuty2hcf87lug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKai3q3vpAnLGNGmiOS4jH2NhOgTM1axqa52EBFTmooOSol9Wlg/Co4zTYXpfzp7fRYKbAtWKJ7jMJUHhQSdcjFiGEi4+KP1wqgIWylaKwIWG/wpnmLvGXBA8i4OokfgHbsFjjiOnPGyqcVfzTLncJSdLbXFQ0HNx0CZ6bEwa9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YK0rm6No; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ecfafb92bcso314711cf.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761745324; x=1762350124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR9rxo2u79GKDjnzL8I5WnLfCVj8XfqRuf1RDu5qxZQ=;
        b=YK0rm6No9KRbzuf/URWqKnByLSVQRYT2bE9JhVyRFfQsg3/c1kQwOfw16OsR5C5Rzt
         0FUM9oz5FYLvNjs/0z9hbh/wzNlx3pgVhQyDD305Nr83w0uAneWHAG5eBfNy4PlL4TYo
         M88hIKNbQ7htu1BrRLF0hbyLkQM/upYNZXsRnC8UuI/ZgoIlHZb7JZbcod98HW1x6i6i
         GyV3k1bGV1jyPUOcE5V3o6jdNsT3lqRYur3nZj9j5VSIN9E4baG5bAg4XQ10qsjXsZv4
         mK9OFme9K7P/8eB5+qvn5u6UzzZ2X3jO0icWBNLd/DhCcgBxAyDGyb9PinWDf5fLYNZJ
         36vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745324; x=1762350124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR9rxo2u79GKDjnzL8I5WnLfCVj8XfqRuf1RDu5qxZQ=;
        b=o50oUZ1qw2UQqZDJmU4AFRNu70ybkzsFpILY0w8lZDvouLMH0SpPQV+ZuasMS2z/mt
         4sSaZhZHQ80Bm+lgk7V0iQ6fBo43pzZrPsgFNXIhCfHol2xZXgcuO3nosqEk9eOVofol
         NS22VSyjyr8lN2o5uWfZw1GMjz1UuRpluL1twwcTbw4z/ewzYdK6zBy+gd4WI9zQlUv2
         JSQDGaSM21NJckT1Qnr0bZ0Elh3HYRvnNOemEJYQg15P6PxmfOtdW73r7dKx7wn3LkRF
         DzzfoUdZAGFrGFOwu6NAcZXaI4M9qmqGO09BwfvgF6r6hv6jxiPbdCsWutu/LNa+IAqD
         5Z1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmIJrdEp8PW8ei3+dAQrsI0ZC1l2fGixpFqTT0QXNmKTlJ8OYzp2dy3RM4dm/L1vOVPDpuIBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTpqnErFfY9ejoLyB2/let1IJK2F9PfX6D3QfyL5xTiB5dspqp
	LIj6nhAj3sYdqL2948aUaJoNWuB9p89zbN4FlibuS5GoNoS/gFBDt2Ss4tpyI5I0O2rIwv6aQBy
	TRLs5QwxpYYarf8IkInClTVx5IfzqURXvAam0vDX8
X-Gm-Gg: ASbGncvTnfMLqNPRpzGrXpkYB0YB/MZyiO9ByaWbWuHPZhVDAluTJnC51aKwqHFhL2N
	cB3hGtQh2AX3WzRuGpetYzbmgVmlmm+jeibVBMguc14GlWFqgpr9tgtnZzm00Y55s7cfaHFh03d
	OtMEoyaxy03jlEDtzSPDkL5tUYtwsHz2GM6bE+gEKEKeaY0Qwe/+MkSJsu/iA7MEVGdcEPLz7mZ
	tRxxgk5lM6F2ymXK+pVI8mtpZ1fugltVo83PRD0NNdsn0Kih9VSqVZAchSB/68XPtsIY2N+vX+a
	j6VBDpc3FbJfUO8T6bpVl8XizvktBEjSCMeBBMdsDGsmjOKJQA==
X-Google-Smtp-Source: AGHT+IGOZDQAj/TycBpf1oLko6kxdZqBO2Sk3hT4y5SfEx6uw5mwTcmg8Z7NahmZfp18PPYf1PTqZO5h2SskSugGe9E=
X-Received: by 2002:a05:622a:5a97:b0:4b7:8de4:52d6 with SMTP id
 d75a77b69052e-4ed157cfd4cmr6757411cf.2.1761745324169; Wed, 29 Oct 2025
 06:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org> <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Oct 2025 09:41:47 -0400
X-Gm-Features: AWmQ_bkzo-mReBBs6WU6490vxEeqlXsoSqmYJljmFEdRABTFs0x5o3xtvuTei8g
Message-ID: <CADVnQy=NBw3RL+yS4=4AusooKkiMx9Wr+20dj-14fK+jPNw8pw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:58=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> While chasing yet another receive autotuning bug,
> I found useful to add rcv_ssthresh, window_clamp and rcv_wnd.
>
> tcp_stream 40597 [068]  2172.978198: tcp:tcp_rcvbuf_grow: time=3D50307 rt=
t_us=3D50179 copied=3D77824 inq=3D0 space=3D40960 ooo=3D0 scaling_ratio=3D2=
19 rcvbuf=3D131072 rcv_ssthresh=3D107474 window_clamp=3D112128 rcv_wnd=3D11=
0592
> tcp_stream 40597 [068]  2173.028528: tcp:tcp_rcvbuf_grow: time=3D50336 rt=
t_us=3D50206 copied=3D110592 inq=3D0 space=3D77824 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D509444 rcv_ssthresh=3D328658 window_clamp=3D435813 rcv_wnd=3D3=
31776
> tcp_stream 40597 [068]  2173.078830: tcp:tcp_rcvbuf_grow: time=3D50305 rt=
t_us=3D50070 copied=3D270336 inq=3D0 space=3D110592 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D509444 rcv_ssthresh=3D431159 window_clamp=3D435813 rcv_wnd=
=3D434176
> tcp_stream 40597 [068]  2173.129137: tcp:tcp_rcvbuf_grow: time=3D50313 rt=
t_us=3D50118 copied=3D434176 inq=3D0 space=3D270336 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2457847 rcv_ssthresh=3D1299511 window_clamp=3D2102611 rcv_w=
nd=3D1302528
> tcp_stream 40597 [068]  2173.179451: tcp:tcp_rcvbuf_grow: time=3D50318 rt=
t_us=3D50041 copied=3D1019904 inq=3D0 space=3D434176 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2457847 rcv_ssthresh=3D2087445 window_clamp=3D2102611 rcv_w=
nd=3D2088960
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Matthieu!

neal

