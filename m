Return-Path: <netdev+bounces-208989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F18B0DF2E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED92F585ADF
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA7239E91;
	Tue, 22 Jul 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jghAnaIg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8828C5D8
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195097; cv=none; b=rrbUpVsM6fUQwaAYBnqHY2xjHGVcYnUpoGdteg6wdHW4AoD0Ko4x7kmGPg8gaed1kW+6hKSvyj7kRjXtKniwf0anxX2GwmallFnZYW769vJ/DCwhyAt6JagmeLbf1598xUcwJxBfmso3v1XAt0x7qAWya4KXBOBpYZOv1ysFqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195097; c=relaxed/simple;
	bh=os2DYnIMBSE/kMJQ/4ssNfzgbbajAEFKtkzZf35uM/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgDoyYyixPosxkNwqr4fPdcufc/ijRtVZKH0BjRNGDFdLurRqX6G2B/11Ii65hckx+pc/jxyYH3QjR1wLhjQf6HyHqBuACX1ulTvg3KxDHVVVqJkTMz3DmK0umrMFhDzcd8E0qycdhj/eroJJAQwbauVSEHvCKC/PKX5kBNuQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jghAnaIg; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so52585956d6.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195094; x=1753799894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn4gJyDMnXhPbLwCQpWenpbaZRFD72gmw0empnN1AaA=;
        b=jghAnaIgRXv26KB6kY87bQyminisZTw+CJDHgZPgoPlaNbTipJZdw2vgEBewm2vrGn
         edlcehx/DnVfKLfg9yrUPfxgWGjjljz+85YhD0/ACY6VtqAHmMWrXAFxyVJ5GlwHODEr
         hsiwcSjj7HlW/NYeXZZbi3O3cyDEPuYc74riLXFtxUwdtrk5JxdTh2SZ0xCoUWiohxL2
         tPXhMOtA+fxmoY86Bd/ItH4OByGbD9PVzvieVfPv9cenQRchTqUNC9XruBsmg8Fzvteu
         o/c0o99PCybIlgNwl/6CzGwEYlJm85VI2uHtmdMzhPUzOUk6mFDfPH+ZaxVW2dVn8MYs
         jdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195094; x=1753799894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn4gJyDMnXhPbLwCQpWenpbaZRFD72gmw0empnN1AaA=;
        b=haUrMXqhti+8iaIEhZsUuumVNVZthhqeXQk/Fnd+ElI+cdzeSvBToGrL7WQI9/FIV2
         Rknx5ilMkcq2cdoy8V+C5060BtaWtbSpxQHI5cU0edOQfoaEg1UAR7RkqmffjPOJYzVq
         Pr3YZ1fDKx46UtUWTMKZqEVS0RcnrpIZ/5laEiMAQv8NaSjp8qiVZ+2IlVdePaMUJXDM
         nNwp4q17hDCgxjB/Rc889dB7KREwF61I2BD74bjQE8VMBhNae9msUEwMSH6FrkT7DX91
         xK4aTFDhXTLnuN+sgjB+21+zt1xd+BeU/dGG+Osl8n0/213/3W75dq7gioI3De8ivTLf
         bh/w==
X-Forwarded-Encrypted: i=1; AJvYcCUVb/BWNsdhoQnzYn4yUTGMc+aOhQc+zS9LodFVP0mCWr4ka4RZ8UoSDANOqSChfQZdrfqTy+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXMPKEQmTIwKfenaa7+sqGRQxNu3kc3u/PeYWt5l6sWEPkx7A
	duO04jtlM3qy2MY5ha58U/9Uxzd6qs0moj7XuVlkBP+wKHwJdTa9t0xBSOnLB/sEjmWFvTqn1p0
	1XcoR/7iE3rJlYUZLDkIR8XjtuBdqq6SZGVvwxUZV
X-Gm-Gg: ASbGncvkpMYoJ19fsWb0pB35DnW98pZElPTIo77rVrrwbRWEbkhmTf233wdReNouQsg
	kNNROK5HL4TcBwFWUAfCYT4gwSXAD7fmz26m0XRcVngZOhwDzq7HCWhG9kHdG7EifDj/wGL+18/
	LuBS0qr+G5f0P6D2U6TnvSAuog9VhLNq8cfd1AW0o9qdl7iiu71nO4+zF4ugn7av7fJA4/9P6M6
	FcBqQ==
X-Google-Smtp-Source: AGHT+IH7wiXrlu0TBmC9UV2qMcDz1px3wXYN9maWZ0wBhcAItzqiY44+P1BWoDs4fyTq/fL+do1VMmfi2vruAWutpv4=
X-Received: by 2002:a05:6214:6207:b0:704:f736:7353 with SMTP id
 6a1803df08f44-704f736739emr250100436d6.25.1753195093977; Tue, 22 Jul 2025
 07:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-6-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:38:03 -0700
X-Gm-Features: Ac12FXxlsXsI3zGI0AVZPAQnuIlcT_-ASbHpDgM34ehNdBuFJw1M1IUr8BHKjK0
Message-ID: <CANn89iLBoSc+x2n0w44HQp8CKumWBkqgYQEOi-enLahFTY02wQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 05/13] net: Clean up __sk_mem_raise_allocated().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> In __sk_mem_raise_allocated(), charged is initialised as true due
> to the weird condition removed in the previous patch.
>
> It makes the variable unreliable by itself, so we have to check
> another variable, memcg, in advance.
>
> Also, we will factorise the common check below for memcg later.
>
>     if (mem_cgroup_sockets_enabled && sk->sk_memcg)
>
> As a prep, let's initialise charged as false and memcg as NULL.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

