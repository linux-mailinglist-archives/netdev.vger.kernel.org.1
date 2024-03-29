Return-Path: <netdev+bounces-83205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD6C891589
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D42B211D0
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9237711;
	Fri, 29 Mar 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkPja7bJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F73D3B6
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703596; cv=none; b=G4uqjscLoyEUcLUaKNz6c1CZidQd1lS1QrRhXfZ+3TJGbYrJ6aVV81LJcfQ5D7kVznMBhV9qlgYVBqT06NmP5zDJ8njBSA0WPGHXLbB15FcrsFp9pw2jIZAsCJ6ZK/mjB/UKrxOe2oNHnMxKvc3DEVQHtwgcx2eh7yCw4GoUp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703596; c=relaxed/simple;
	bh=1zERkjtrtlC581CcROudIVVXpAA03k89ji5eS+5BuYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDSJ+x9e6BWc9R3zhU7xnxBaDf+Tw5/Y2DSaEtPa/A96e2QCZfzTo45B31V+5TxfMQP6KiYol0+GHbUmdZcuC0ZqMLccb2z5XlbY5W79nIrKRxxrA5lVVhj+/sPAAznG7GFRQGgjdSZFFqXBN8eJ3W4GTfQTsw4qerqZp5oWxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkPja7bJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so6175a12.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711703593; x=1712308393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC/2DNYfpXPCFDeLwAU/UqglY0mCl+CZh+iTkFzj+Zw=;
        b=KkPja7bJsAG8stMGYJvce/yJ2ERbGd7/tikfhxIgHm2DkHD7w3lNMKhS+KBNfPqukk
         IAr7f0mSuCmeB96K2xfE9YJpbLpV14CeE8MKHzwtEN8onG+5mc0TZWMIRdDhfeLSzbMF
         ulmXak9u54Q9HHZElU9B/9OW0M+7vbmbsTQ3kxlDPaie9lRyFI3iTwtOxqb/dtDowf0V
         7vS9CwAb/+aCT2hQH5w7YVEqUIrvweJMAcSTq+Y9MRQN6jIz2DDmo/VRr0UIzPFnkqly
         4A1RFM9WR3nnvJQUQ55VRGeu6IbSCqGviwK29XacY4VVQ+3Ab3t1RJ1d+gMGndYDs2aD
         E6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703593; x=1712308393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VC/2DNYfpXPCFDeLwAU/UqglY0mCl+CZh+iTkFzj+Zw=;
        b=W3Fsx+7qx1Jn8nmlEqV1pbIR0vBV27O8Rw5VGi1206lVIVOYbvyEBHrUQPHKNfsxDs
         QqxufkuYcd2PuxoajdtFZJzSJHGzvp/SJ9RMCDMJINhV5XJOoXsFysxG7a8lbU/fH1lG
         CCz7OwoqdRLjAqRUlhF6k1BnPjHtTSC2xklIc1GlLetLRwBSkb3GihZSYv5+8gkRLABI
         GPWKKmIo2WLA530eBV2jMk8T5kizgWGu/7/SgAskRmE5KY2vPMDi5X44wm+/vZPQGxz9
         r2w/+qPauRjMoZdPa00vfISOo7Z5eoiAEE4izZtR4Ww102s5ZXsnYp1EWiLx3W6403kB
         iw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7GqqHjQiBcFvJkzBq0CYjGAi+nxtcXIMRJqvoQ8WFf6PJrgWh31q93fltMwpoRbPOCXCU08R5KVcIgMRA17M05H/wpVfF
X-Gm-Message-State: AOJu0YwYjF3uNqGmnyMh33sx/r5hOVZzoisrlAypyANxjQTpfclz4or9
	zCyH/E7viuyI2MrVSwkwhzIYaBewxNw/z87WRqcUZ5KmzckN+hWi/aQem9QueMYg8dcAnhdUTZg
	4csq/3cLrH9vJhGxhU4P2ivNREUpnQB/ybCQ2
X-Google-Smtp-Source: AGHT+IFlPhyvUlzfE7rTjsKrKisU2QouFz5YiSOmxPdDEKV0jtaMbzUzboFdcxhgTOLzWZAGDEUUIxfEqGpgqQOhzJQ=
X-Received: by 2002:aa7:d784:0:b0:56c:cd5:6e42 with SMTP id
 s4-20020aa7d784000000b0056c0cd56e42mr136121edq.6.1711703593362; Fri, 29 Mar
 2024 02:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com> <20240329034243.7929-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240329034243.7929-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 10:13:02 +0100
Message-ID: <CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] tcp: add location into reset trace process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In addition to knowing the 4-tuple of the flow which generates RST,
> the reason why it does so is very important because we have some
> cases where the RST should be sent and have no clue which one
> exactly.
>
> Adding location of reset process can help us more, like what
> trace_kfree_skb does.

Well, I would prefer a drop_reason here, even if there is no 'dropped' pack=
et.

This would be more stable than something based on function names that
could be changed.

tracepoints do not have to get ugly, we can easily get stack traces if need=
ed.

perf record -a -g  -e tcp:tcp_send_reset ...

