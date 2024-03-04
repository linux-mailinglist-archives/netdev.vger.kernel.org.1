Return-Path: <netdev+bounces-76979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C486FBED
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6586B21C80
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526218E14;
	Mon,  4 Mar 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT14GLak"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EE182C7;
	Mon,  4 Mar 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541116; cv=none; b=ANbHEuBw12Bjbin3ajpW82dUAeTQu79DBalNnOF2s0di+z9CviJIxuAboKToNURrTljG1QAD6mgyFBkfJVbMBdJUXGXTHlRrYFoFUyutWU1wQdd+/TNXOfH8Qneg6iwX5AFUf5zM/3sJgjYvVKHPeWcCWkZkmaHqg5Pb5NKCoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541116; c=relaxed/simple;
	bh=ZOwa8Z7GGncP2Db0DiRMjZf/egFZkRQsVqMtf43WGvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELhXNtI4LMzhQ3bmSF7Mk0ydejISLie0Oi4+o0qzyLFDN1rNdtyMZPEYkzBh6lyJ+mxl//QEAKrPW0STLxEGiA3stUFJDdXF37GA5hBUhppELy16fGoXFY2i4bzPZCevbSFIaHT+SngPJqvk+ysIeouYNrdDh5ES8o8czzrdcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT14GLak; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44e3176120so161622066b.1;
        Mon, 04 Mar 2024 00:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709541113; x=1710145913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOwa8Z7GGncP2Db0DiRMjZf/egFZkRQsVqMtf43WGvE=;
        b=cT14GLakVbo4gvPnB61623dYKC99vF5HqfFjUyA5nNaCM3/uKDaXfNmKSIvwzAEiZc
         hx/4oSQ5RL/AWgQK9ijuJxEyE2yTIgQrPoZ+6nEdzWeItcZAdPDobVzjORucPCcpcCTk
         69PNPw7JXuwirx9XSXT0qNoklmG1fzLgEHzWJxvkXrWONW65Wz2S3hfXIt7b8IfXmOeV
         J9UYiKDhkx4qG545/kwY3Y0nZvnlVkfUEJMV4vCezbIk3myXhbmYQ8/RWHpQbGgX+5qG
         FWdyQHfc2auieQHqrfyjvVbBUtuQ3CtMmWnZq2mmTwUo6rweJwsqOfpmGx9FkwHxjM1w
         UE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709541113; x=1710145913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOwa8Z7GGncP2Db0DiRMjZf/egFZkRQsVqMtf43WGvE=;
        b=RDUxX0gmCsg2ByvbrgG4yHRzXhamsXLoSSAoyg4KhQDuVJd8ZOc46PJh92ecU5QXF2
         3rXPginZhEnML2L81kYgQZoFLDMWjyoKVmNlkNjEnlkKqWicfMOuiuoCgcds+T2wQ6hT
         3TeDs4BUEYqSrmPlq7WX3PRAgEdk+6gfdh3t+JLSAkJtupO4YxvOKKP2AKqrLpUe34Kd
         nB0hSScOSY1yR9bcF06NwtQgNSwZIBG9a/xUruEkFy+n7soHRwojXbtDI/c8DUNLaBfn
         0Ay6tbFeweiiEthKpw/75k1G3tcX8H8NkqZMbppwoAqv7WfsOLxTZ4Pp5rlroMXpIn6j
         FkIw==
X-Forwarded-Encrypted: i=1; AJvYcCW1zlqRx0BmLrfE1ZvO1gQVcgKIrjPQpn+80iARoBnvFRmxmJ76Swrd1/i78K7DZGj3QTw8bsyXwsnwEfexf6BWQGxWdOahfKYkD/RausEMS4AEHsSwBmCeaOob6qHjYM0sSpgWMwk4WFm6
X-Gm-Message-State: AOJu0Ywt7O7KmbzgQX7QzKLSur8yO9Yy7MUQ0u3M9VyikgydSUMnzGFT
	StMleaGsh9ifJ5whpQohSlIpFuedL72Fhoc3QppB08oyR9zyH5UvO2Grl85l9ILVOwUhTb6DTUh
	wePRg0q1niT3ZPjg5CkVV+T1uoUQ=
X-Google-Smtp-Source: AGHT+IGarN2zv2XSX/B+JgY/zICtoDmmXH4CWrWNILQD1p+GfoRNpqa5lQjZCpLQ42QpBZK0HrIIScGEJFh1CcLq0eU=
X-Received: by 2002:a17:906:c446:b0:a3d:7532:15ad with SMTP id
 ck6-20020a170906c44600b00a3d753215admr5626408ejb.39.1709541113064; Mon, 04
 Mar 2024 00:31:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229170956.87290-1-kerneljasonxing@gmail.com>
 <20240229170956.87290-2-kerneljasonxing@gmail.com> <CANn89iJcScraKAUk1GzZFoOO20RtC9iXpiJ4LSOWT5RUAC_QQA@mail.gmail.com>
In-Reply-To: <CANn89iJcScraKAUk1GzZFoOO20RtC9iXpiJ4LSOWT5RUAC_QQA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 4 Mar 2024 16:31:16 +0800
Message-ID: <CAL+tcoCuyW+f2C_U0sgN=RmtjcbbaUVqpO--WZTzs_rsVWdGKw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: add tracing of skb/skaddr in
 tcp_event_sk_skb class
To: Eric Dumazet <edumazet@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:24=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Feb 29, 2024 at 6:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Prio to this patch, the trace function doesn't print addresses
> > which might be forgotten. As we can see, it already fetches
> > those, use it directly and it will print like below:
> >
> > ...tcp_retransmit_skb: skbaddr=3DXXX skaddr=3DXXX family=3DAF_INET...
>
> It was not forgotten, but a recommendation from Alexei
>
> https://yhbt.net/lore/all/20171010173821.6djxyvrggvaivqec@ast-mbp.dhcp.th=
efacebook.com/

Thanks, Eric.

Oh, good to see the old threads. I have to change the description. The
other reason why I chose to add address messages is we do have some
useful information when using trace ss another thread[1] does: it also
ships the trace with address printing.

[1]: https://lore.kernel.org/netdev/20240304034632.GA21357@didi-ThinkCentre=
-M920t-N000/

Thanks,
Jason

