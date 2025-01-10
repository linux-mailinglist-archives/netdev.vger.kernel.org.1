Return-Path: <netdev+bounces-157217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520AA09744
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE251884635
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0458212D97;
	Fri, 10 Jan 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyLhoPca"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E596211A19
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526301; cv=none; b=foMtKwsXkAzEqd4ZgEV8EQi6YotwH6+Kv478UqQADgnrJ9PcrYhDQW5MAwL35KIiuZyIVBmMiKXgmcsd4wgn3xAwOYskJk/EoYiWaHa4yD+1IoccZgZlA7Gy4Kujibq79vpF3BZ4iS0QJtTKR8kE80RDJR1qkJSrnI6+nl1/CcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526301; c=relaxed/simple;
	bh=dZLD2/RK3nMxdB1/yufmW1ve6pFcEAmvlg4u0n6ZAC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRPOYasfwo87AiNr8eRPWIyg40wwsac2ZPvg7doiV8o7mEHVLGujjtdIu27tmhWjxwcH7mS/jCs8qQ155hczvamSIsKhbUWU/uo2zH08D6zWJLYhqeMR8eYSNe+oQ4f/YZ9KM98nnK6XfmTbI/nuturd2/h/NwAPdclwoAcoVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DyLhoPca; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467abce2ef9so270591cf.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736526299; x=1737131099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZLD2/RK3nMxdB1/yufmW1ve6pFcEAmvlg4u0n6ZAC0=;
        b=DyLhoPcawd8G99363K0uCiHvysbiCgemo8e/D50inn048VkYH1ak+Uh132PrXGhMYW
         c1V7k9m12gyd0F4p2xVMHctC2gkxka8G5JrIFR2yv50hor6VNiQafuWIhGc6HFGjxQJW
         EjZRQWMIO9LR22eoo0ZBPdzBllFwa8lCzzlW3gIsonLFT9Y/KShUr0H/mYRJFgnDeKTv
         hS7hcFV6C3HyOlMEUJ91i79Iu6dLVPeL1m/HntbHBor1+YlKL999cDm55YpiceOMMxoo
         pOppYDgAhM4MftvmKezQm7BebKZOxtCwj9olNfyr32QhXcq5vv0RObCKCVWp7Wvb0K9e
         uKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736526299; x=1737131099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZLD2/RK3nMxdB1/yufmW1ve6pFcEAmvlg4u0n6ZAC0=;
        b=pHqMlTNmXMNopaneWxZqnnJkqkRoENBgbtbcFIBiMTvdTOlzuogDu6K94K/fv+iWWz
         erOkb7Ay8PJkxKiYxLl1jhX+4QDsPqg5K8Dyo6MdkTlzrpAVaxCYieZ1r804Jzv6lGH7
         8AwJZMuiU2v0ndOJ5uuIRXJUGTSfFLcgZ8ykaW4YsZn/uk3tlo8sTugUEocSYoSnkQmJ
         erUdW2+Gzo/0mIkegcQJBYqTWaVs6NPa0QUuWbR3lV25W0EVjAlwK5qX15r0PcOnao0Y
         SheGCpw8nCl6ycOTEtzBfAVGSKkb3aPLeWXVfeN7X1oDX62Wt6OMsmtgdH+qHimhKLHU
         mTCA==
X-Forwarded-Encrypted: i=1; AJvYcCUxBF1ILLWRGMA89rb9JoNDPuGBe4q3Mc9lk5dZRvljDs0tRqU4KbNXxGbScSOEwXR7mHLaY3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLTGNh3QNXhCksOj+M02p4t6bXAvv754d0iQgh4ZKxrIRtn9a
	cMHG/4809/A2CKZ1EaL2m1L2lBUpU9fVLU7+GkSj5n62uI1oohdSXAhrKkdBnZZr/jdltfijEDq
	5c2HX0YdSgV5CnICNCfiIvvwxKIPkZCwZILMW
X-Gm-Gg: ASbGncviDu1UHFOaP/ukaJpgey6kCW10jfBM5zMBajBDe01JVuYZ2ZC11ZzY1+/zOaR
	CD7UkfRwAO5pCQu1J1CQOsj9ypHG4/6grXtUQXo5l2ZPvitgYiHk+WRHmH+hgeWnktiL/bA==
X-Google-Smtp-Source: AGHT+IHygeqEmy6Ne2CAiAAsOJHi64fj3I9CDqnhJ65axCyiB9rIY/L3TULm33msORs7MRZ2pIYedHE+kmJbQcvlLHk=
X-Received: by 2002:a05:622a:8e:b0:466:8c23:823a with SMTP id
 d75a77b69052e-46c89dad596mr2701791cf.17.1736526298867; Fri, 10 Jan 2025
 08:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109161802.3599-1-sensor1010@163.com> <CADVnQy=Uy+UxYivkUY1JZ4+c2rDD74VY8=vxmxf=NJxWcXa69Q@mail.gmail.com>
 <5d5290fb.a567.19450f031bf.Coremail.sensor1010@163.com>
In-Reply-To: <5d5290fb.a567.19450f031bf.Coremail.sensor1010@163.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 10 Jan 2025 11:24:42 -0500
X-Gm-Features: AbW1kvZv2K2A0rVn5uezz8CYqXaFdZ7PYXtEDBI1FQK5rSGaemnyOiGXlVLr4VQ
Message-ID: <CADVnQymirM10M95Hspk2KYrFDE7uBqQSM4PBYRqJJVbqmKCMsg@mail.gmail.com>
Subject: Re: Re: [PATCH] tcp: Add an extra check for consecutive failed
 keepalive probes
To: lizhe <sensor1010@163.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 10:58=E2=80=AFAM lizhe <sensor1010@163.com> wrote:
>
> Hi, Neal
>
>
> If the TCP_USER_TIMEOUT option is not enabled, and attempts to send TCP k=
eepalive probes continuously fail,
>
> then who limits the number of increments to icsk->icsk_probes_out?

The code that I pasted in my previous message limits the number of
increments to icsk->icsk_probes_out. :-)

The code is right here in the lines surrounding line 809 of tcp_timer
in Linux v6.12, which can also be viewed here more conveniently:

https://elixir.bootlin.com/linux/v6.12/source/net/ipv4/tcp_timer.c#L809

> Adding this code is feasible. If not added, the system would continuously=
 send keepalive probes without any limit.
>
> If these probes continually fail, the process would persist indefinitely =
because there would be no measure in place to restrict the increments of ic=
sk->icsk_probes_out++.

It's not true that the system would continuously send keepalive probes
without any limit. The packetdrill test I pasted in my previous
message verifies that Linux TCP stops sending keepalives after the
number of probes configured by net.ipv4.tcp_keepalive_probes or
TCP_KEEPCNT. If you think I'm still missing something, please provide
a tcpdump trace or packetdrill test showing the behavior you are
claiming. :-)

thanks,
neal

