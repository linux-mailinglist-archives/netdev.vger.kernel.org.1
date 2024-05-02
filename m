Return-Path: <netdev+bounces-92918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439748B956C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78911F2222B
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B8224F2;
	Thu,  2 May 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOPykL09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D3221A0B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635699; cv=none; b=APEu8VudaKZvTaXTTnEJgkSHKckrzsb4ClLsIXMRJi25xlk2VbCfsET7kkre/VVOHJ4NRaCkhwb6UxBy0UH3GExelC231UsPUd3SeKCaXSvQ/37rPcOWHbKUpeu35cULh5GrNk/vVkQ3xHynEFdMT+6fXShFjmVwus1ynMjthEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635699; c=relaxed/simple;
	bh=CV4cfa2c8EMFmCYMTH/lmrbEzknrxdfD0O54OpokceM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNDTvbFezjmY0S83y9WBzarQaY6fYU+0pSfAlzHtc21q506AkbjknyyrMBaOqCe285qZGJt0TAJy7tdnz98TBh4Rs3cxvieYiIiIRPzItLj4BePLjfB1PSxancZUALdoIwTfld/xh3R/ZmvmOHrIf4cAQWARa+IE3+OXNGArAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOPykL09; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso5289a12.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714635696; x=1715240496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV4cfa2c8EMFmCYMTH/lmrbEzknrxdfD0O54OpokceM=;
        b=QOPykL09iAVLCKvgp6na88Qk6n9y4CbdtNNv4ufbzIl8etYuNvISrWQ5jKUNnyudT6
         8BHMSWIiL3OSmdpp4TRnMzXDbcSA9olyeATMn8U1hC0s5fZDBADypQCYF96brEc1lCs3
         o1Yt9X+TkiKBsSzE49rtrQLd9m7vlpI/17qDZw1TGtiQp9xTSuOEoLMZsMPdO6oD9OtZ
         k5rxp6hDrvz6qe4xgNsT5hE2PsYUhg6xQplTw6Ul9PBLh1fXdTAap6NgDXcBQOLV1wqF
         pXbidPdXfxrzx/rHbQ2TkVuJHOFcnPDIEEoZXo03OUzbLHyW0WNCzU9EDnOlCmSr4FFj
         axZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714635696; x=1715240496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CV4cfa2c8EMFmCYMTH/lmrbEzknrxdfD0O54OpokceM=;
        b=FHD7MxZDZXA9fkgjQX29zjw+6J/b1zMGaTFX6GkTNQDU2ybtUnpwJGXPiSjzDo2ETi
         V2m79nmuFWP5OwR+4+5KeeqwGKWnwpYnKmLEI93KzONEHKGDqC4wYMGhf2MStszLpLky
         Jjz9PsJUy2saafmPWCOS+sXGiyKzmbBpxIW50UbzQfhLmL56RlAWPt5aeugWPSqOyBWj
         Q6AvoeLCfqkwUv4FRBCPqjlMktq15TWUVdwLscrgYv9bnFyxcpjX5YWzaCGJKk3lHeNP
         fZoV1ZZqtKVyxMNdTAfVaqitRWGu/hec+L0FIh3a4X3/yQ8d/wh3JujFGft63GjHf7+H
         D+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXM0GxMf6E6RYX58hY06QyelC/PDzqsVPicH3//Hu8LroQmIoiOy1+JBAWazioDQjbzM1D3vTp8j+mHzgoIhd6qYLECCrWX
X-Gm-Message-State: AOJu0YxesOSCyJ+HdsAuFrEIjAuWhVVFp49Lp4dpcjKkTxQuBfLZsziB
	2LOSwyM9GaBMQ9dtGx0JKBjkrWXSfl7x4mNSFC9ZQYh/T5HfImd3Tey/oRGTZmK45/Lm5djau/t
	jcZfyVFWdsKYb7rUYUtmOIGvcMp+MlANJpTu4
X-Google-Smtp-Source: AGHT+IHEAdG1LfYqwb2l5V62E1dx46Al+tJT3V7Fgf9XyViitIVcqArPzUPly5iuK/iUUNN6Mq93tjK06T053q6Zz+I=
X-Received: by 2002:aa7:df0d:0:b0:572:7d63:d7ee with SMTP id
 4fb4d7f45d1cf-572bba0be07mr153019a12.4.1714635695622; Thu, 02 May 2024
 00:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501213145.62261-1-kuniyu@amazon.com>
In-Reply-To: <20240501213145.62261-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 May 2024 09:41:22 +0200
Message-ID: <CANn89iJhhUqg-jgvwNz6QFHWjC7GbC87q3HcudmMPYx_gxHc2w@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Anderson Nascimento <anderson@allelesecurity.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 11:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Anderson Nascimento reported a use-after-free splat in tcp_twsk_unique()
> with nice analysis.
>
> Since commit ec94c2696f0b ("tcp/dccp: avoid one atomic operation for
> timewait hashdance"), inet_twsk_hashdance() sets TIME-WAIT socket's
> sk_refcnt after putting it into ehash and releasing the bucket lock.
>
> Thus, there is a small race window where other threads could try to
> reuse the port during connect() and call sock_hold() in tcp_twsk_unique()
> for the TIME-WAIT socket with zero refcnt.
>
> If that happens, the refcnt taken by tcp_twsk_unique() is overwritten
> and sock_put() will cause underflow, triggering a real use-after-free
> somewhere else.
>
> To avoid the use-after-free, we need to use refcount_inc_not_zero() in
> tcp_twsk_unique() and give up on reusing the port if it returns false.
>
...
> Fixes: ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait h=
ashdance")
> Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
> Closes: https://lore.kernel.org/netdev/37a477a6-d39e-486b-9577-3463f655a6=
b7@allelesecurity.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks

