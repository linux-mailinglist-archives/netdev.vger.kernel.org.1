Return-Path: <netdev+bounces-241573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B6C85F09
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 069494E262D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FF222B584;
	Tue, 25 Nov 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OrrWBpEn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB8221F24
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087672; cv=none; b=uCl0znM5/9+EIyxGbYkNXnpaQdmK0DNxEv3wWRkgiivLPPS9vQq8gyCbsRdsl/Hv1Y3L9HdvkLCBeQiYVqxOhKMs01gPuotw0PDcCG45S1hTyOzrmsyg6O8/UYrhcYCJ5SPMR8GnBbOFzlxY+wsdZsul/jNty4TM+0L9SiFY13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087672; c=relaxed/simple;
	bh=1bIw1A2QtCjzztIE3Q6so7JPCvttUNWYX23SVcGvk2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv4cDjGOFpkkhIlstgmxbLasEKFLl1bx5xAlrOJqKsx3S3xS+8aQhYqfNLaDSAckdSKHAhQnJK0ZYJM1BIMspMVa0fTxFLr67zmeC1NSS6CN4C8bdBsw1qlXkc8WfA4uzBcX9w8ykgYrHwNv0Z7Yu/GoUKU1fqKWCWtcGh6TI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OrrWBpEn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e264528aso61187325ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764087665; x=1764692465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoNUCPpkEhFwVICHMikfiUoeVdx3sH7SM8PEs/6W0wI=;
        b=OrrWBpEnmuxe5PN5fK7YrIOUDu6ZAdyCpnoyeFfsD/chzYQhBHIhYxDM1Yg8zmOK7l
         RtQmor2chHgYl8bIE5VH72FHbFKsw8tfFWjvUZELFRlW9TAWm2FoYaUoCOXVf82W3RQ6
         1N/CqKNEBLlkWUEPF+5grcdWVnjUjf8zEWA0NsX8+DwejYfvtZQeEBMjtnpMqCS1wy23
         UW9emEriILIa/0auB6DUfOcKpqT+OOABRZK66bKNJ5yDpzn/AqMQBVR6/ihRJsdaKoo9
         0x5FTwrllMd0tdZ5nNOqsrVDQ3KeUkevspV6yCo8nBua/n7bVsHhO708h0jvf+th/duY
         BXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087665; x=1764692465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IoNUCPpkEhFwVICHMikfiUoeVdx3sH7SM8PEs/6W0wI=;
        b=L8tFt1aWXhZsKf1L75ZT9uhAiu9hipgmNBagj9mNYJq9fj6BY6+FqpA0dKGPiHuTkA
         gSyqj9YfaXcr1LUQI+BdAlD3aMyxNa7rBkVAosJJOGhDzViH1uXg1k03DoXy7kc1nXjg
         APVq7/uq0FOFDhGPHaVIZ/dRAlRxD+QZWYh9PMLCs0mS6EoY44Nmo2NsybwFx0cCxYd1
         CF3sBj7vZIVLtO7ZbOYDUA065gIJMgcSFJjtUyJOguF1gZkibAdY6VaJhovwxbpNQyXq
         UBpvOFHGIe8yKa6J/eUdN7mmKshZsSPaw7zE8oqf11/Lw+LaNxmhBgEOegZRuQwxc+5F
         ammQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVVve4I7/2XEoKBc4uQQmHgEZdMj7TpK5CV+XGS7OPF5cZPuoN8Vr0J1/3Zt8XFXV0Kc3hS+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMCHlE7wC35Jz59z6l0B+XEVMldIQo0TK1Q9bF3NRzxBcaA3c
	511MTOEQqiW/py9ICHSg0byquo9b723kN6bLTnGnusUAhbQs5xfHxHHcHvdEP3sUK94YkC4iJsV
	GK3omS1aDGGw9RIufE5nFwPp2TO7bdbZdI73uyokL
X-Gm-Gg: ASbGncvxApz/bi2zfJh60HU73o+Xt8JTlee3R3V36AfXqQyonzrl1j2ouyFnsSLnZZE
	RLTnYQheGRXA1caiQ4KCfLMT55OZZCFaoaTEgJ/CwTcT9Sxtz6Cye7xD1qrUJ2hWMNAe2P0w0sb
	n9hsr/GCAitEGTPBAZXxHIokFeDaJyiVFSwCEHt5VMAsI1xD+lT8fWQpP/emKGcyktXJLxX+v0y
	ehBRVxB6JRhJvIW0qKAGvjTE7jr7FkK303YT9lTTVAngPY0XPG18/e5M6mFAXwAajfDPSw/mYBv
	834=
X-Google-Smtp-Source: AGHT+IEqYHw3y+hE6sCCuItIMhSMd5GEV/Qlf0Xba0ruWhe57oBl6Z8BuS7Qy4FL/Hno/bVF4d+QwQ07Zb0O/h0YnB0=
X-Received: by 2002:a17:90b:3bcc:b0:340:d578:f298 with SMTP id
 98e67ed59e1d1-3475ebe6779mr3232207a91.8.1764087664749; Tue, 25 Nov 2025
 08:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200825.241037-1-jhs@mojatatu.com> <20251124145115.30c01882@kernel.org>
In-Reply-To: <20251124145115.30c01882@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Nov 2025 11:20:52 -0500
X-Gm-Features: AWmQ_bmceMgMhep1ASgFnT0l5nobal20EYCqDASNP9vJm51thzGo-NonZTmDJjE
Message-ID: <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 24 Nov 2025 15:08:24 -0500 Jamal Hadi Salim wrote:
> > When doing multiport mirroring we dont detect infinite loops.
> >
> > Example (see the first accompanying tdc test):
> > packet showing up on port0 ingress mirred redirect --> port1 egress
> > packet showing up on port1 egress mirred redirect --> port0 ingress
> >
> > Example 2 (see the second accompanying tdc test)
> > port0 egress --> port1 ingress --> port0 egress
> >
> > Fix this by remembering the source dev where mirred ran as opposed to
> > destination/target dev
> >
> > Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Hm, this breaks net/fib_tests.sh:
>
> # 23.80 [+0.00] IPv4 rp_filter tests
> # 25.63 [+1.84]     TEST: rp_filter passes local packets                 =
               [FAIL]
> # 26.65 [+1.02]     TEST: rp_filter passes loopback packets              =
               [FAIL]
>
> https://netdev-3.bots.linux.dev/vmksft-net/results/400301/10-fib-tests-sh=
/stdout
>
> Not making a statement on whether the fix itself is acceptable
> but if it is we gotta fix that test too..

Sigh. I will look into it later.
Note: Fixing this (and the netem loop issue) would have been trivial
if we had those two skb ttl fields that were taken away.
The human hours spent trying to detect and prevent infinite loops!

cheers,
jamal

> --
> pw-bot: cr

