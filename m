Return-Path: <netdev+bounces-230702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F239BEDCF0
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 01:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C12E189E2D9
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 23:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462F23EA85;
	Sat, 18 Oct 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIBdeIWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C122D4C8
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760830476; cv=none; b=HQsr3YcS9BDw4ZXN3suabq1ped8urFpA5vPQN9l7SSYNad0Lo3C542/OxyxouaySOpv61KCo+IoLROE4AEntnG9A3Mk6wa6DeMi2SYNdyz+T162B67Zy3JaMspFFMqvqrn64xhNjuGEx7r5VOPTkMKG5L/xVmAUmlmP0PmmIdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760830476; c=relaxed/simple;
	bh=lgCm9LRC/j4rGsb22pRV5+7xb4L9P433AOv0I6fSjHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FD94EkAeG0kQkg4vZTh/LRnRWYK2iY/0h/Ksx0W3tBrupqEd3MKJD0aKoYL7/d9thHhQrqSgp7Fkj+kFebzpL2biLGDooifMoMzwSOU3KkFb8PQMQrf9MQedgY1vxSuIqId390RWYpg+aWZYPpMKbunDrGRbtAQv2pttS8gyXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JIBdeIWN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2254018a12.3
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 16:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760830475; x=1761435275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPA1+wPqC8k/s2wwU1HqmDK2/+HkqbtbcxNCKEGHybc=;
        b=JIBdeIWNiU9U9EPIXRtuVMZtAhic0QIo+5PZYUg5UZN7rICxA0j0f2zpRQ5j3r2YsW
         ybDw6JvQVQXWuwS6GfPDquHbe7GkxvvGosrpZE44tvRTCTM0kajp4z3xBnVlMBMKQyIn
         /A2gkz0ovcdmXZsjifoESAKmEopPARkZc12lCx6cSdbuGbDjcjxHCj1x8ypUKKK79Tg3
         mPWexKP6HVO87vMujrg+4KvbX8G3Lo9aPdypiO1YQvCvgzjlvYGjccmrbRLK6Kklguxk
         9EqveMmXeaJ9c91iFBcDZRJzT9A5kNdqosWYQJio18OKVcM4nFiLn/kc3M3y04tKCkSS
         RKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760830475; x=1761435275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPA1+wPqC8k/s2wwU1HqmDK2/+HkqbtbcxNCKEGHybc=;
        b=WGc5/JBJQ18IuK03JjqHu2of7D8DwWuOyoJiEzgEbyftouoZAm8D1i7w3JXIJ145cj
         SYb/vE7tPvlZk+uMRgvvPX7pTCz001v/9v9ch/qeZ3ip0rvWsQkEVTHbZYK5ib3Ka9Bq
         ZdfXIePBd9NK62hdX/QW8KOpg/5sDWe9v3/vfTOqVjhXYSeVAixJH1lbXQ2RT5Gfx5Uo
         wQKjmrpUsiSMa7qdcZBcY+iDRUNzH60tMTtvOHk2orVWkOuCLLnXgWzyE6zy4ZNrUF7Q
         8vAL7rJIIOpbVfK+l4fSrWru8m6Vg09cRK4S78iUAk+btvf3Ba66FfBN9zRMtb2JiHpD
         RkLw==
X-Forwarded-Encrypted: i=1; AJvYcCUReGuy8oMVsIKHp8la9DFQsN9SIf+vFsPnHS4Hx9nI4YH2zhHodFL+WK9hS5iEEmLf0+uOItM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9O7YMChJ1jNdNS3cymzYG2A5j8EjUhs5wdC7p/VDC0s83EKOB
	CaAr88fx0T38zIZhLvZ5rSyjdgL0Xtr6sut6ULtyur5G+Kmpx+FURdg6cEubGbA/xoyVkqpsc0x
	gziiFMA==
X-Google-Smtp-Source: AGHT+IEnk1EpLilTC7PgZVTpzNkGB62noBdQPpKAStRSiGB/RTMfyjWOrT2qftOyoFLLD4smsWru3nRmtKc=
X-Received: from pfblj2.prod.google.com ([2002:a05:6a00:71c2:b0:793:b157:af42])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a0:b0:334:988d:a9a1
 with SMTP id adf61e73a8af0-334a85242edmr11452357637.16.1760830474631; Sat, 18
 Oct 2025 16:34:34 -0700 (PDT)
Date: Sat, 18 Oct 2025 23:34:17 +0000
In-Reply-To: <80bb29a8-290c-449e-a38d-7d4e47ce882e@wizmail.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <80bb29a8-290c-449e-a38d-7d4e47ce882e@wizmail.org>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018233433.891423-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour consistent.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jgh@wizmail.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, willemb@google.com, 
	ycheng@google.com
Content-Type: text/plain; charset="UTF-8"

From: Jeremy Harris <jgh@wizmail.org>
Date: Sat, 18 Oct 2025 22:17:12 +0100
> On 2025/10/18 9:56 PM, Kuniyuki Iwashima wrote:
> >> In addition, a client doing this (SYN with cookie but no data) is granting
> >> permission for the server to respond with data on the SYN,ACK (before
> >> 3rd-ACK).
> > 
> > As I quoted in patch 2, the server should not respond as such
> > for SYN without payload.
> > 
> > https://datatracker.ietf.org/doc/html/rfc7413#section-3
> > ---8<---
> >     Performing TCP Fast Open:
> > 
> >     1. The client sends a SYN with data and the cookie in the Fast Open
> >        option.
> > 
> >     2. The server validates the cookie:
> > ...
> >     3. If the server accepts the data in the SYN packet, it may send the
> >        response data before the handshake finishes.
> > ---8<---
> 
> In language lawyer terms, that (item 3 above) is a permission.  It does
> not restrict from doing other things.  In particular, there are no RFC 2119
> key words (MUST NOT, SHOULD etc).
> 
> 
> I argue that once the server has validated a TFO cookie from the client,
> it is safe to send data to the client; the connection is effectively open.
> 
> For traditional, non-TFO, connections the wait for the 3rd-ACK is required
> to be certain that the IP of the alleged client, given in the SYN packet,
> was not spoofed by a 3rd-party.  For TFO that certainty is given by the
> cookie; the server can conclude that it has previously conversed with
> the source IP of the SYN.
> 
> 
> Alternately, one could read "the data" in that item 3 as including "zero length data";
> the important part being accepting it.

Actually, even FreeBSD does not read like that, and it delays
SYN+ACK only when SYN has "non-zero length data" (tlen > 0) in
tcp_do_segment().

---8<---
	tfo_syn = ((tp->t_state == TCPS_SYN_RECEIVED) &&
	    (tp->t_flags & TF_FASTOPEN));
	if ((tlen || (thflags & TH_FIN) || (tfo_syn && tlen > 0)) &&
	    TCPS_HAVERCVDFIN(tp->t_state) == 0) {
...
			if (DELAY_ACK(tp, tlen) || tfo_syn)
				tp->t_flags |= TF_DELACK;
			else
				tp->t_flags |= TF_ACKNOW;
			tp->rcv_nxt += tlen;
---8<---

