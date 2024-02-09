Return-Path: <netdev+bounces-70501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD85E84F4C4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 12:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C74CB24C1B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8E26AC2;
	Fri,  9 Feb 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgaqG9pZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9AB2E847
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478805; cv=none; b=QfNu2Ok8eCXeDdl3fV9Hw+cCawK3hYIX7X3D1yvXfwPbNxxMQoDrPsCxNlhgFDN6jvmjeIXedtBhIHeDFDPU4Zjbt35M0DdKRnxqNrlG9VS54i93vn9JqQQJEPJlLdbVcR2waovEIySFnXZZZxpfeZ2C/ChDbKnKsiI3TBQ3x18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478805; c=relaxed/simple;
	bh=qHuHtPxjNoTh1S6Vhf6QSDBJYn/AgJM9XGp3BFrDv80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfgYC+/raolPDvdhmfRKB1HZ4FdAkXKw1LprYmVqSleHiSWgP742C4EsTlsiQqO8tTgeke7I4ytdvTw6Vgne9yu4z55iFQdmjeuJqJ5FP3wwDhnwok4z0aOOniIiitzLDuen3wKkve5EoTQFC4vy+wamp9Ca0lueWR4/Y76ayHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgaqG9pZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5610c233b95so992728a12.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 03:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707478802; x=1708083602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qHuHtPxjNoTh1S6Vhf6QSDBJYn/AgJM9XGp3BFrDv80=;
        b=GgaqG9pZW4Jjkm0ODu9ZtZ9p6+aeJZnqRWopUruEthn15qttg4a/v2059WZY6pY6OG
         ImBkblqGp4BuowE2R+NDDQAfYmQHLikpGVxy3LcgsnxiPFMMMtRqm5+H+fLj/kS0hQeP
         VA6nl3wzwkcFC6be4qoBfdDmolWvxODTchZCBGSzbDD7a1w8rynGqELsJurJ7qiHoHK+
         sFtbZJ1s7iMM2BDazrcBmPGNUvYHm5vPbRrm5n8U2/rsnPJYI7tYVKoW1Ve0h0xq/qlF
         Hbe+6gLnRQUePKkT1crhC3At2/+OycSrQOUAkpAeOzcJE3xTUjFoHQ9QD7BybXLhZf9Y
         Ol7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707478802; x=1708083602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHuHtPxjNoTh1S6Vhf6QSDBJYn/AgJM9XGp3BFrDv80=;
        b=DuhhZAFpBEDMLsnuXfCdlMfAspFySvY2ClVIo7sz932/DiCVIyhiY7F6zO0BQcQepm
         zx4ZsQ3lvrHmvwKS/mWajJXhaXVkwArFWyTtsdJ6QyMgp0gIYeCqMOWDvEzNELxP+JnR
         hy22fyykIx5vRXv26e91H/e8BZroQzB1nl7YykGUurSxyslJElsKvhLMVaZB7waOjNX/
         BLtJCmLP0jrADQBmG6ctmjVdbJWxUP4bHvxJLhxIWeENd77DjTwHZThtJs+SNmZaX6CX
         Rdnsd0QGgp3dHWXbGPymj3DO1UcpxsJlGFfp0e4sXuWSZfwqFFmNW01lybr/a7ucrlhZ
         b+Vg==
X-Gm-Message-State: AOJu0YzSwVi9b1fB2tTYVwYN6gPRNZeZp3m2MyaWfQVMByO4sG3OKI7A
	uGep+TLe7cBgNYpqPiMfnjyYrV1SAWnKGOQ9ieCtvdg4Mo8AzqqI5OIbYo9Q7WCWIwbKHDp7bcp
	yKsBNW0pyFTjJqhNGPaT7inYZLKSiFmHpGa2Irw==
X-Google-Smtp-Source: AGHT+IHriHZ3j1Y2zGObaYmEMS5HaoAKLt+1R9lMY3jWZiA58OuWssx8xSOTSYnGD3td4q6CHSb1R/c1QWIVQ39oL80=
X-Received: by 2002:a05:6402:4309:b0:561:40d6:c95a with SMTP id
 m9-20020a056402430900b0056140d6c95amr1035312edc.9.1707478801597; Fri, 09 Feb
 2024 03:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209061213.72152-1-kerneljasonxing@gmail.com>
 <20240209061213.72152-3-kerneljasonxing@gmail.com> <CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com>
In-Reply-To: <CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 9 Feb 2024 19:39:24 +0800
Message-ID: <CAL+tcoDUtUp+qJ1zxDyLUi_Y19+-68V4pTJhf0S0g51Y-bt=bg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] tcp: add more DROP REASONs in receive process
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"

[...]
>
> Your patch is too large/risky, not that I am trying to be gentle here...
>
> You should know better that we are not going to accept it as is.
> Please split your patches into smaller ones.
>
> Eg, a single patch to change tcp_rcv_synsent_state_process() return value.
> It used to return -1, 0, or 1.
> Take the time to document for tcp_rcv_synsent_state_process() what are
> the new possible return values.
>
> Then other changes, one at a time, in a logical way.
>
> Smaller patches are easier to review, even if it forces the author to
> think a bit more about how to
> make his series a work of art. Everyone wins, because we spend less
> time and we learn faster.

Now I understand. I'll separate the current patch.

One more question about whether I should split the 1/2 patch into some
smaller patches, say:
1) first, add some definitions into include/net/dropreason-core.h
2) then use those definitions in cookie_v4_check()
or
1) first, add some definitions.
2) second, add kfree_skb_reason() into cookie_v4_check() but only
NOT_SPECIFIED fake reason; get rid of 'goto discard;' in
tcp_v4_do_rcv() if @nsk is NULL.
3) third, use those definitions.
something like that...this way could make each patch more precise and clean.

What would you recommend about 1/2 patch?

Thanks,
Jason

>
> Thank you.

