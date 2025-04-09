Return-Path: <netdev+bounces-180616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374DA81E0A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2395E3B21F3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3F25524A;
	Wed,  9 Apr 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekCQmfKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9848253B42
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182847; cv=none; b=QjH6uVUAWNT4FVgzCXOmdUOEN9k5xc5T+dXZB2RXsvAqeIzDSwZPZjWgoBnrTAdaaWVvMsR8Dj7SARfL1Xt3wx6G8kHdTf5TZ6BZeCmyp8Hm3VPn0GtNzyycmQVQ1alCb2k+z5pfX3wNd3P+ZVEC17yjk+6BZdFutdo4a1glByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182847; c=relaxed/simple;
	bh=o4u22On0K74aCLxCe4KHlANGFU1KZOeJn9PZNDHqBII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVc43Jg1dA0uCgcLvXYYhnZMb1YgWsZgVNdhWan3CEi0FBN1pog8gA8qoXGDHg7spfN5PT7ABoUyYqfqBu1rjyo9VUxWioo7XBbBc7YA89l3sGEWAmm8AgEQFHadEbIuyLfdAe7kV+xIZq03oBgTWt+9JYcBKXKWS+wVB/HnejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekCQmfKE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47691d82bfbso126133971cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744182845; x=1744787645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4u22On0K74aCLxCe4KHlANGFU1KZOeJn9PZNDHqBII=;
        b=ekCQmfKEB0bLWZzXtd7R2oH2sSK14iQ2pma12G0EcIvhTlGB5SzYD+FgtuHYRw2Ziv
         omL2HXb+4fJjfL/p/Xo6SNAkjcTaoFkU1s6RAPZ+TM0i75czBtd9YFBdwfmbDCGnS9R6
         N/uMZVezf3JMPZb38v+Zbn5iTlPumqS+2SSWkdwnYavt6JFgEUiv+wc9xB+eJEZypHh9
         gMjWJpEyz556pzyVvs43uDl82DSSbFZ7XDTR3exeKDf0t5BFnsw1LMoZo/e1RdvRzZ9r
         OXkD0+UHehK8C0/iex+frri3vn2aEBBt3adjC5LInhzD4JrYmcCKSJU4HS2lwnw66Ows
         jbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182845; x=1744787645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4u22On0K74aCLxCe4KHlANGFU1KZOeJn9PZNDHqBII=;
        b=E7TKNQQ5lFJHkR6wsirWXcSlD91kqSvxfKdMkPfObDyit7oVgDWhh+wtJfyEi3RQJZ
         1TCToFidwlWoor04eaOozUJID9zmIK0+7j1Z9VjRWWHJZLdvZ0aFA8QbDipj2xSQy1kx
         ytKjzJtozu67PYFSqvGULquozY+OpEkwrfhixzzxpqZPlVCef/5monyu6xkGcg+r2xrB
         Qr81Gkzd2U9BFac+6Lt+CdaAMN0rUe08S6mSmCTHiifHD8az1S0I7lkyzHCISq2QX7Ex
         HMVX391vcKkcY67ohGZR+fVhIGvXbsKqGHvRp+nBe8fMkG+URkutPZEJrQIzieXCZlGJ
         bheg==
X-Forwarded-Encrypted: i=1; AJvYcCUhZQnIrIAq9sCGf9OVlhQYnIekGGL9Tv1O1zYcV+oIgXeuc/VNOaSLP0BtAFWdHGBmdo+l3ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDEyVGl4ji9XwU4M3xspm/GDEWPWC3yiCRwOIl3ITi8l6Iub5
	hEbOETBI4XRCRC/XARstNThIqcdW/V9uoo5VNXXFOQSs4vYb4v5K7k22qDbubAnACuMWO1anxS6
	DEYTvYDuqsQ7ZQiYEljNvKkhMtJ0mZhT2wqKb
X-Gm-Gg: ASbGncs2mhU85/Jf3WdQgzx4XovgfQw7hdp2eGIEJRzOYO1v9uSjWOeduXC9xWY7Bp8
	X9oc4FuLhncO0ndvZ3OUX0Dld25yUashfVQ8kosV4Py64XN1avsgMzFGiMzMoCK/UjND8jpkHsu
	dvf2rc/mhMddpKjzPGzGztCg==
X-Google-Smtp-Source: AGHT+IEPf+bMOSyPAyRRT5FnYt/dQDrDJkP7fgIqSBGifSkvX0GxrGH6i7XdUzqfrW17ujqWAY4wjqbjwcnaYpM00XA=
X-Received: by 2002:a05:622a:1209:b0:475:ce:3c59 with SMTP id
 d75a77b69052e-479600c94ffmr21204371cf.30.1744182844448; Wed, 09 Apr 2025
 00:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org> <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
In-Reply-To: <20250408-tcpsendmsg-v3-2-208b87064c28@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Apr 2025 09:13:53 +0200
X-Gm-Features: ATxdqUExgIlhI5h9g1kuJu6S49AR43PpGh5RclwAbpAXHtSKJ9IcrrdS9kYyTqQ
Message-ID: <CANn89iKr2kfCakou8id62C5ic95HF5RCps9a2cUv5FL3yjAGdg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] trace: tcp: Add tracepoint for tcp_sendmsg_locked()
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:32=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Add a tracepoint to monitor TCP send operations, enabling detailed
> visibility into TCP message transmission.
>
> Create a new tracepoint within the tcp_sendmsg_locked function,
> capturing traditional fields along with size_goal, which indicates the
> optimal data size for a single TCP segment. Additionally, a reference to
> the struct sock sk is passed, allowing direct access for BPF programs.
> The implementation is largely based on David's patch[1] and suggestions.
>
> Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@ke=
rnel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

