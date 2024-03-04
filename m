Return-Path: <netdev+bounces-76976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630486FBCA
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522692825C5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76E171CE;
	Mon,  4 Mar 2024 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnufAxEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D715134B7
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540666; cv=none; b=uvQzepuea6Ta0IKlvbjTaqX0iWTjGmp+K7xzngoHsvtsLQe8JjYOQZU7QRrhuOaqG1TLZdAHJEwkQw924BJ1OqZDZLnf0Fb4vtvEw4Tg08+HDS9rqatMmFhVE1+RMwcibLJzj5fj3lJFHaFi2yEmArwK6DnByoyTDCft0y+TiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540666; c=relaxed/simple;
	bh=xuxYP6DP8Cdr/UAZq7ZNL5tg247ofyZcPoyR+xDjmfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lO2XRlQtNZE8uxQh5SbNTRIxEoTTuRYAOw4JyElmTC798jEWSabXpOpXmEUJXkzyJgrpAv6gYjNqjscEBErj520eROSKWv+UDCJSVi2TIY0zqp9v27X1uQ1NewA5HS/rM7BlMb95KbMP3CEJyYd4MBUqdyZLT0u3UXbAhqAFbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnufAxEZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso21856a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 00:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709540663; x=1710145463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuxYP6DP8Cdr/UAZq7ZNL5tg247ofyZcPoyR+xDjmfs=;
        b=OnufAxEZqbM7M6QuuWBZYPj626AEXak7ODTyQDRFI9npS+NdxQH72pza8qK/fw32bb
         3Ymj+yHJkJfLnRlfKKm2N5YHgLf+Aj2VpYqhNZKfT0kJk8sKLLwVWGgZRYwCzOVFl+jw
         mDACCUgekNTyw2RrxWpr6J3czcEt3ZdMEZ6n/MmU57lPldKoHmnkql4DYgxMll/8ncl0
         uFdXj5ZWsC5fCm9F4CSd7TKlJeF4tJg4zuiylzOk2JdcO8NoggtP6vMVlohv7/7DbaMw
         Zn95Hd4e+Zg3La09EyAP4II/9K3apQexqF7C/bvFUkwL9YengIf+J/CDMjsnOZCVVLCG
         7iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540663; x=1710145463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuxYP6DP8Cdr/UAZq7ZNL5tg247ofyZcPoyR+xDjmfs=;
        b=JrcA0fPtvqYJedwFnum7xnnAfYlVj43Jh3lj5etrvozeoMPIpeG39L08zyzn9N9AEu
         d/WpArpnrIdGT6Ur6xIxZ5aJ2KzSW/nm/ykevvEScm4zZCbLDGwrKGQsEbhFk+SnJhFJ
         g6VaVJjWrBxb1YzgRWyzGMjDGKdHk1JDYKedcAWPOffLL1G/LLjYg8AMdBpz5/neN3KR
         6kg1t75MlBUD20aWoReKXTUpewyR3GVQfJjHMguvovrz5z/uJiumN+rYy837QLPhAip4
         7aQeUm2D+aW6M2l5geK7nmjaQqqB6vjTIbNKzkVz4EJLB8dXXXfAU2wY/Y31kthIfjcr
         48kA==
X-Forwarded-Encrypted: i=1; AJvYcCVCRm+ehZrCaAXJEhadt4bvUskewhua5D0j1+LlVrJv1yKxVeOyL4A6IKMp2mn3+/eEBej0g+vqAeNTfJp8rwtc3ge97N/2
X-Gm-Message-State: AOJu0YwrUIwDhLfii18HcQGxpqOXNUHen+NaN8MeOm6WXhfwE4h9KjRY
	ffEP8PJwBNBFBf+zabDqPjWbZNmc+7VZMSzYgY+pq4h2eacCHKAHhdibPQn0AQWkdAZ//64NShP
	SFA2PeoFmOZCDO9OcTGEhqoAssc3n11HS3zCS
X-Google-Smtp-Source: AGHT+IGsrm+exERQpnzcTrgZMnftf2s2OAnI9eMhtFaLJa+VkZE16xQePWCjjedaR9AnUu1ThJ2DT7qdZrjK+Zcvkx0=
X-Received: by 2002:a50:cb8c:0:b0:566:306:22b7 with SMTP id
 k12-20020a50cb8c000000b00566030622b7mr289225edi.1.1709540662841; Mon, 04 Mar
 2024 00:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229170956.87290-1-kerneljasonxing@gmail.com> <20240229170956.87290-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240229170956.87290-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 09:24:11 +0100
Message-ID: <CANn89iJcScraKAUk1GzZFoOO20RtC9iXpiJ4LSOWT5RUAC_QQA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: add tracing of skb/skaddr in
 tcp_event_sk_skb class
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Prio to this patch, the trace function doesn't print addresses
> which might be forgotten. As we can see, it already fetches
> those, use it directly and it will print like below:
>
> ...tcp_retransmit_skb: skbaddr=3DXXX skaddr=3DXXX family=3DAF_INET...

It was not forgotten, but a recommendation from Alexei

https://yhbt.net/lore/all/20171010173821.6djxyvrggvaivqec@ast-mbp.dhcp.thef=
acebook.com/

