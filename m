Return-Path: <netdev+bounces-103587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960A1908BB3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF51C20DBB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A21991A0;
	Fri, 14 Jun 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bS4ogf8N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F914197A97
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368285; cv=none; b=ssj6VDmtVq9L/8HnaSRaCavSqAtmLTN+BH/zp1A8zxVQgRReALfnA8a1rPStCFIz/T25iLRvHxYLv95vHMasCQxMQjesad5ySsGALOgiUZpoLOsxj1M1l2VTg0IRO6mn85Ut4zbNmvqPCD9AdK0X9xHqQn+ccb5mi/z5XC8uN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368285; c=relaxed/simple;
	bh=SSHygXE7aH2rGxTfBAkWe0KmN92hir30Po3ODMo3KCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7DSyG65BUDy1j1qvf0kn93XF71E1TTrduv56YlbUmo6hG0HVh2CQq5fWWiPulScAiHuQi+6L3lMFyPrI9q5NZ2Qtho9+Cuzwkz2kciQ2Nc0b6pcaoxJMyXPbnbEruift7QoEPJn3QGMNixKEEyCHaeRbetrsrRAGRxiXhXJnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bS4ogf8N; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c8bd6b655so14212a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718368282; x=1718973082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSHygXE7aH2rGxTfBAkWe0KmN92hir30Po3ODMo3KCM=;
        b=bS4ogf8NNy42zLJO83UDOzRzqn5vEzNgmg9oqAhlrb7JtlTHx/bAFZBZ89ByLjHOqp
         JvIzsbRBGWLeFHUMQNweRrsMM44AyMp2rnAvvngmqeg+jlDXR2H7ykfxTYeVXGgLii+1
         fMlcehJKqWl5WrAkbhuZk8vDetF96UFuRRp8/+qRUxiD1d2xxNQBajNhceeM7rO9ad32
         DhcQPstdqPwsAQrhMgJK9UwbXezLAQWgcFoJoUVRi8KAxwvL0ck2WwnJbBZCxjVNJKUD
         AGzmHsAbfIV1ZkH3UNc3sNySbBpwhTOjMFQk9aurtrOfa8lLeXeOkQGz9Oy4eO/7bM4n
         kbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368282; x=1718973082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSHygXE7aH2rGxTfBAkWe0KmN92hir30Po3ODMo3KCM=;
        b=TM51esZx1spbFGIispVKBIAyPHEF9p06+wG5Gxc+3crLel4PrQ/gIPZi+Omlf84zge
         Gy8UbGhRQc3Q/7Y542/sw6dAD8Zw2uk7AS46FTMoRK/zQTasloBjEHle5CchseWb9qiF
         jRwzFD27v8vTsiAFZuT8gNwqE0yIBH5aRHhZObE/wNfx6T4a+cZKmYLm8w8431vNr1vp
         y2VE/YdRmczH9WtOjOiBpJ5PbHr9D8dpk9VRNml5mR/7XAAUXBZsWVI1OwSwVeLh5HOQ
         dg3SGho2RN+V9jb2osP9jfQchKDC/joaFcGYxBpT/RxcZ5lKx6kZbVuFWWjYLtygXTUm
         CAig==
X-Gm-Message-State: AOJu0Yx2qEs0i0qnB4JzkmkuoFLsFAzszSppsHuHducBDdeX3hUPix0Z
	VMUNAlBqHiSxBEiOrTu8WhMjHw5UrvOhvnwYpYkn3acYbzYtPDlhwL+5eBglSnWtDzGFDiqjz3B
	zZwgCdeKl8dT/zltVpDYklCqb687wVR6YZqtd
X-Google-Smtp-Source: AGHT+IEIW0suiKfVCFIci+gqYbxrXx0KK1h73UnpknB+zvmql56GG7AQAMAoxQK/V8yOn1N/tgRm5+AygERoWmZjHGM=
X-Received: by 2002:a05:6402:2788:b0:57c:bd8f:cf3a with SMTP id
 4fb4d7f45d1cf-57cc0a85c9dmr136167a12.5.1718368281964; Fri, 14 Jun 2024
 05:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614122552.1649044-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240614122552.1649044-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 14:31:08 +0200
Message-ID: <CANn89iKwuRMWc8nosgHm3OuykayBMEZUCd1FJi+K+xn7xS2+rA@mail.gmail.com>
Subject: Re: [PATCH net-next] fou: remove warn in gue_gro_receive on
 unsupported protocol
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, tom@herbertland.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 2:25=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
> not known or does not have a GRO handler.
>
> Such a packet is easily constructed. Syzbot generates them and sets
> off this warning.
>
> Remove the warning as it is expected and not actionable.
>
> The warning was previously reduced from WARN_ON to WARN_ON_ONCE in
> commit 270136613bf7 ("fou: Do WARN_ON_ONCE in gue_gro_receive for bad
> proto callbacks").
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

