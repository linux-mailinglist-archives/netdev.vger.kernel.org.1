Return-Path: <netdev+bounces-251190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44CD3B310
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D354E30D36AE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D10313523;
	Mon, 19 Jan 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJm0UxlL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8B3101A8
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841478; cv=pass; b=m5VQTIrx7iugq8UcYYdrcXsDgTgy4BjkdfEQq5a2v4M2N1VbzMg/Tzl1ALU252spin0za5keiqopzNL7W/4/BjZwUnnLsJ7NCclRIR4VS4U7Gfwwz5gw1nN8z2xxiv3prPtxUOCIQz15gaqVSNzdHuSpgLQTqtk6HUS10aVxzK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841478; c=relaxed/simple;
	bh=L7cMIOhFkW0HstMAX/Uqub9fZPfIBDZs5CklIVC9Bmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhqRhZjI7s9ahF9+83tdnkKIrnnz4LMhKL4aahRRjd9dhSPsPhlAT/Sc8Dfjaxs/2E46K11nRTM9mFC9ZzRuKkB7ZwJOcCSqliY3s44f5CZt9piVbS+h2pF3ekqoH7lS+evggXNWP1OVe27cMMS8EQd9galWHKHBKRpzF63ZtFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJm0UxlL; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5014b5d8551so972981cf.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768841475; cv=none;
        d=google.com; s=arc-20240605;
        b=DWHKN/FvU+bh47bAvRfAv4K4d8xbvBz1zFshmlupdoUo73vCB4EPLSxabPRLJn4Erb
         43AONwhr/LDOzRWb72uVm7He4eus/Ij8d6TSEuTOy7W7ky3f9qc6WJg48k/19SRofv7j
         lW1uKbKnOuhPe5BKxVvakr66qe9avH2NZRWzBFgF1nhkihkvBfYkFXDReP+iBnWEm2dS
         JNIcPjWFa/FC1iWM8c/Z+j/m/X6pVSdwjvoVVVKW8ypWIXmjAvxUNa90v9m+M6rwHmyK
         /VPD50D9fVjE0aD7FnI2buNHMH8+jbgiN21Jbsop+EszC1PQHhpwBwADtRQr11elwP5m
         ocsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rmSbSN0pqClvudWpTg7XP6qXNhoYmJaIJIOFHJ/Fcag=;
        fh=VIHReSnJaQa3f6l6HVW3ExcFNLG2c49n+LUc5OQh1pA=;
        b=L4leDEPWqGb+TYSVprlUpS9iMANAIKzqv33qkF8UF18qrLSibxdTqywWDs16q+xldv
         6iiD9fY+/GAOj1RXYuB6HRJGUPOZU4lHfQ1hLObtjZkEppmJqHlkTWWSV6XOpLU/UA7u
         Szg/w2UfDsdG+tYwup3QU01lohz2CHQvchD1ZKb0cVykI2H+MYl1yJ+SUJabY953BhND
         JnyTK/IJsQeatkxhRuyKyb6Hb6xdRUoEsjjYdQ1VQMqL83KzuQWcV3W0jD7zvV4uX0cJ
         uOQhL/qgNSJoZvK9GVKzz6R4WW7drehqCl3+wQf3bf2EbBV+1ZRgwSXjDC3e6aJcwzEs
         +PHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768841475; x=1769446275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmSbSN0pqClvudWpTg7XP6qXNhoYmJaIJIOFHJ/Fcag=;
        b=AJm0UxlLozO7Vtop5yR5TIND/f6a4oqgyuSbhMhqKLbZ5jkNq4OxgOLBZpu89S7sXC
         eFqKDFL9VEHCoXIpxcfyjXngFhxKJ+qPHzPIY3YTU1ePFchCa287eO83eIzpDF3Wv09q
         oARThH9f4554L3BbNYucwOSjsVDcZf3ZwpJCjR1RPcrwe+zJRSZIOmrPqjHIWPiicp98
         Zt6b+UiSVtfoEFd+ZSuHZtoTDo4NiGpr0tthP16SjO9T2fN+nF+LGZ3yXxcW0aEHgzKD
         bj30aDkcR3FliXTBPOiJ+H6O90asWzmb1nHurCyb9v6Zfccpmzt7ctVHMA+z470jIA1k
         Elsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841475; x=1769446275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmSbSN0pqClvudWpTg7XP6qXNhoYmJaIJIOFHJ/Fcag=;
        b=ny3LUQQ0+Qpm5C35jYUtSpqZGwkSX0y+/YcWqY4LkWHiZgdQbB5oKacZ0Q+168NiwU
         XaBmtbRrNnaGynK3sp3Ql1ImTwdBH0M3hm81kC6eiTzvBhk8XkiaBcWLMfy7dtFwzFnU
         mBO2GamlfU6zPcM8TYw9GLgY622sNN/a8MzbsmSmBIjjQ9igTdqqr0K2wa3oOuYWgNPt
         pbnp0Lo7VkzVSXl4G5mfu8nYhTdvmQi7c+jGrQpDgbVKaoxnypNFXLcWWuj5/LLH1kXj
         qgLkiiw8bVOKh0UeG+WbRfkicbIiZjl0jRDyTNu0Ccpccdmhk+/SLQpGEia4O6xSe6ZZ
         oYSA==
X-Forwarded-Encrypted: i=1; AJvYcCWGnoh50Oq6yNqabaWW+91QV50VhjFGi0neHI52wwOKrXe2KRA8HvTVZBUkA+2m77YWhfasU9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVSbSe/5mScfR+vsyxhOh7RIGle0HZ0kM190HryWJdPG/Am2Y
	OHUEjE3dY721fGeIlhcmUOoiiIp1MBt5MbOj473jOrL30B4hXgpPOQ21/tJRhTJp5R1dnYq4MaN
	QIeiLPKlpA90R7C/LzVJlWf5qXxZEY9G5GZggwuaz
X-Gm-Gg: AY/fxX4QDf/xY4T9+86DEUlbHuoyf61db+GSiptRyDx1LTJmbOl8yLWX7h93t331Ti/
	Ipu4B3tn0wS4uvyizYnsL3sqYY3JRI7INULQ+t/zpgy9MYWPh4FXvc9yJu+xoEibGRBHAK5WBNy
	1i7juEuHfY2Q7nmaAsi/UwxtX6LLyQ0pVmtR54zuxrxhSnZvT2f1h8vjm1P43Ydfzz3MOJyRyZA
	DOzLKxnm8IB2HvFWrwTWNVKUEgXW3x06kdnuozitKWeYP4YNmHfwNw9ySonF6buKlCNPt0oBB+F
	e88ZK/Eqn3qBT4fd5/kd5ZMyYI0RiDyje51EEJkHPTqMjN084ChAkFbnqspc
X-Received: by 2002:a05:622a:348:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-502b06eb15dmr20778741cf.5.1768841475200; Mon, 19 Jan 2026
 08:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118123204.2315993-1-edumazet@google.com>
In-Reply-To: <20260118123204.2315993-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 19 Jan 2026 11:50:58 -0500
X-Gm-Features: AZwV_QhigMTOw0md0DDCAjulJ4h4WbU4ESGG45zB8Npz6SbgEcqU9mrIaPNYLVk
Message-ID: <CADVnQy=hRTstSpOVY5UxxBTdOmdDsqBQcYnFWCc8ikaqDSuvSg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move tcp_rate_skb_delivered() to tcp_input.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 7:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_rate_skb_delivered() is only called from tcp_input.c.
> Move it there and make it static.
>
> Both gcc and clang are (auto)inlining it, TCP performance
> is increased at a small space cost.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 3/0 up/down: 509/-187 (322)
> Function                                     old     new   delta
> tcp_sacktag_walk                            1682    1867    +185
> tcp_ack                                     5230    5405    +175
> tcp_shifted_skb                              437     586    +149
> __pfx_tcp_rate_skb_delivered                  16       -     -16
> tcp_rate_skb_delivered                       171       -    -171
> Total: Before=3D22566192, After=3D22566514, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

