Return-Path: <netdev+bounces-169162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD0DA42C47
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE90B3B14D7
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA11C84AF;
	Mon, 24 Feb 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yyjpECE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F99282F0
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423852; cv=none; b=MagU2XWMUndR3e4QP6sEf+k+1VOjwmJBmPWxi0C7swg64BBW9LTXIwcFortJCmpWWqXAiGMKDjm2al2t2nXjwxuW1y1SbT3vNU+q6e+fUynCqRisKNOYkgmVJQZmxNptkasqGmDd/wzLwbTShV05/nRbfRHwXcECBsJ+g/lPZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423852; c=relaxed/simple;
	bh=a7KIxKD7aoeoZOqCkxW8MiXflXZAnlr6LQmmaXMfXYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOLyxWIZzY73FViTdd2n3I0e5NGdhdFJkADH8dn44ika/4lHUSYAlCGAtQvuZP6S3dFh9ru7KgnJHXPucOCATScPvPHfuSaa4oLNGQLh07XK4AKZLdD7CA6W7j1z+eGIsRxuexT4/QPFG7H2EYo+SZZ79GSU7+TDXm8O1ePTIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yyjpECE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so8367444a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740423849; x=1741028649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nSSnIUgykCsOJjoRoPgBIV/Do11WjZXMG8oFwcXmD8=;
        b=1yyjpECEC4FwpamKSMT98G/jqqz0XOq+OwoJdHIsFjHqkj4Lo+y22qQdFqgBX+0T46
         CUL89o4mvo8J28S+iULL5fNo8DgpecmGspw7puUVQ4Z5rmtzZk4rtuQ9F4rCxqZyscTc
         jgSg2n8WzivwS/HTvHS9bdhpW0WU7oZzlLMEU8+qWsPM3OHGMcct6Yk1japA5v3cT5Wx
         s70mLRm047ZAW2urgoRQ/XZJVw0y9LeBSvmz2J5P3DQDMOh71LFMwI+NvPrxzGFWvhye
         GsL4eX6LSTe+vfXwtMaJXXiRLYFPDtw8qnFxpD10o2e7qP6y75BCflNhfSzYLJroZdfS
         T+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423849; x=1741028649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nSSnIUgykCsOJjoRoPgBIV/Do11WjZXMG8oFwcXmD8=;
        b=sp3YiPOT+aZ1+ekJ4dbBuqRe6n22opsQ0qSpzbPsnI8WV0kmg1VTjQPfpxzlaI9tfn
         JMTcfJkYMa93fs2AVBdrSn8uEva9+RCLH9mCpYKtJTF4tEHkIe6DelrIKEdRHAZJHltm
         88tCwEBE9oaI/qtRrNfaOfyrAQ8aBAnNu4BRQgAa6YuQ8S0/hfDQP4ovLY8EvBNgt0Dx
         Zw+vQM7cbMDfIjCB1TFWPr3LU4TZ93rnSCkViNyOcJYWnd2on/UGAbBHFNf4LYRSq514
         QUW93omgbCrcjl6ZZVfrmeeq4q7/Mz1mZj7uG4BARVtq515LUrE09xBfueNLVqrL7FOh
         C1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUafM7z1bXpNprInLmv2+kZ+2Z+4y4lTZDCJWD6AIvGgo1fDG9zXvoUzI19W6lRXV2QWoWimWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/3SamqKAMpqZsf11kDc5peN0aNyv29ev25jyL6zU4XW0FVpk
	9evvtFKtv3v2rlawF5Oh+21P6xkO2J3ehhrx3y8k+saz/LyYWVy5CErvKM+gJdsbEBlJfHDDbJQ
	B0n5Tk7zmRK6Hli5mY7uNBs2ucGdbTuu73gsk
X-Gm-Gg: ASbGnct6n/6dFldRA69W43eVBArtfEhtvXE6ZxjJMh14Z9xrjcBXgLRzdtoh4hlEslT
	mp5Z+fdkAJvtUmXo23z1hFnmTmBk3gqR8QnK5hC4JF/EhfBLuOgFKfcz9e5yU57X7x2mvvPLNsG
	Muk1cvAA==
X-Google-Smtp-Source: AGHT+IGgQflHbqJ4UhoDf/fk2E5dvSe6cFNlfrPYK7uSbM45dr7J0xkIHLkRgPNbQ8e5rSTMONtTWGu2Ja+QKsZlfN8=
X-Received: by 2002:a05:6402:26d1:b0:5de:572c:72cf with SMTP id
 4fb4d7f45d1cf-5e0a12b7c27mr19854821a12.10.1740423848811; Mon, 24 Feb 2025
 11:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
In-Reply-To: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 20:03:57 +0100
X-Gm-Features: AWEUYZnNdis7E0SVF0S-h6-AU7K1RTAWbc2V10Km6GwZSmwi5zbMocT2Sf-WWMY
Message-ID: <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: Breno Leitao <leitao@debian.org>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:24=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Add a lightweight tracepoint to monitor TCP sendmsg operations, enabling
> the tracing of TCP messages being sent.
>
> Meta has been using BPF programs to monitor this function for years,
> indicating significant interest in observing this important
> functionality. Adding a proper tracepoint provides a stable API for all
> users who need visibility into TCP message transmission.
>
> The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> creating unnecessary trace event infrastructure and tracefs exports,
> keeping the implementation minimal while stabilizing the API.
>
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
>
>         rawtracepoint:tcp_sendmsg_tp {
>                 ....
>         }

I would expect tcp_sendmsg() being stable enough ?

kprobe:tcp_sendmsg {
}

