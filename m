Return-Path: <netdev+bounces-208785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBBB0D200
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182991C213FD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CE2BE634;
	Tue, 22 Jul 2025 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmvgTlJr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1071C5D6A
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166562; cv=none; b=SQEGYbOQ8s44SX0sr9o5LsWQic3SB316jHk7V2Iyx7xqWHedXQhjn7ZdB1iHuBrXZ9s4br41fsO9XbBwyzRYsdLwVqqwhpLxw4Wz+V67IUPr2Rz/AKm2LGdu/AOzQrGx0wv1Gi3DwOWJpBe4tldmud5vJ5Qa69HiLqxw8xR+260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166562; c=relaxed/simple;
	bh=NA36uYIdstJH2uG8YyMNqBz92Za5P96z2ySsI/waiio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Asr90yu7bkvp+C86BhMK/YcbH8n332YNMh4wpvtp8ApMXJ4g+m7kwqdYgQvjz8rNHknZs/NtGGoya25KURV/dI24/4glGAE9n5nABuyL7e188EY/ATEg0vo5HkpvWwDbLyRQDZJKanA2NUUBIz/xLGDPsldXg/9CT+mPVRyASGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmvgTlJr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab9ba884c6so65412831cf.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753166560; x=1753771360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6h6Sd7T3RH+CtFzxBNwU/jmY2fsZCbhu4Ru+TS9LQU=;
        b=gmvgTlJrfSwoMG+fZ6QguOUaMrznQ9U5KIahdOlJ3wRGrGLCXHM0qyFYwPRD+rI/a+
         XS/gXR8ZaYh01KSI2tzV5jOV/g2cBxl00wOYsHDDKV/D2xcgWPQ/nrMe1NFtnneX+I+e
         HD/f1AVKr8ArPSjmjj9uValiyrkIpciejl7CqyGMNhxOjdlB/E/6lw2u5qKqR7Md7zNj
         5ewSt9R2YDEowO33Yiaz19Z+YSKyPDpTlOqwYfmqzFBTD1dPRSJzRixrC+29+2jabjve
         J8I7UCgCW9ba1K2Yphw80AtXXGhOh+AFIsHdHMbMf4+vR/0H0ZDRomPZUSWTHOqxqdp6
         fq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753166560; x=1753771360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6h6Sd7T3RH+CtFzxBNwU/jmY2fsZCbhu4Ru+TS9LQU=;
        b=H7D6nCHfECITFLSgW32LFJ3iJhvifDnjFATr87cgsYkT95K1d9y2ieHMXhqAgZGAqG
         6xjxOwHXXvl7/+0lvudc9Uz9hRESFEzzsoP1oXe4e1G2bIu02KOWVZT2KcEZGlJrpFy5
         BoIugzt3vPzw4YA3gjcCa/m2HjXwr5dsAF8OqTIufwFp0QhT6W4fJMnFewkrLYCe3sVk
         Dl9CZzkTuXS3VGvcea+7VbBtrPnhKWcFAKBsDk5ExyI7hBndvO7h9sOCxXh6lgmrdvuu
         jnewzi4D2GA+9eDZsbPb/18A1p3te7c5xc0N+IxVIREv2AzLyeTIDjDWaMAJzXQhubuj
         jA3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1r/doDzYvY+yYye249EvcdDvoU3bTV2rRG78coLQUGBGOYyNyaYHYz5gJIzO/+a9lYrPa5dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyTePzsVQCYUw6ZKTHrJ9rE2v13KmwUJVWjYZE4/ArxJdh4ZUg
	Z71gsRfbs6XHgpGddcObox0xAvV139SfXVnVHFLSMvBlVPbLHkijJ1vQy+40j6+ut7Tqu+qDMv5
	1TIjVXmmZbMSFQTmZpp0my0FhOfZGhOAZF44ycvF0
X-Gm-Gg: ASbGnctmfPhCaxBllAk87/Icai/fR+FofqxPL3CaYt54J/Y+RlBUGrgOqbS7RqYkQ9/
	YB6rfCA+IDczitAJ/P+Kx3qyGEEVJ9AfTWkTI0B71WIH+wP5stsfZG2KpQwefaj3eFjcS8qjSqj
	qzRDLfSfIr2+PxfTd7b1G7Pv/oA7b686KJNPQZNzp3giFd24skaB/iy6+8qlen1AuhGzVIv8+Rl
	ONf5Q==
X-Google-Smtp-Source: AGHT+IFE18i3ZNkbmsrw1BuD3fHiD6gRMvLpTbu/niAOFe34mLrrmfHvaIzaR08VQ8lZs6la4mlmVt+dTDNJFyAXP1Y=
X-Received: by 2002:a05:622a:4acb:b0:4ab:41a7:18da with SMTP id
 d75a77b69052e-4ae5b99f102mr36129921cf.26.1753166559335; Mon, 21 Jul 2025
 23:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
In-Reply-To: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 23:42:27 -0700
X-Gm-Features: Ac12FXywVAz49IpEFRm5TGn9QbbuypsOmwnVNfzN6cH9wGhw3rlyrS0T17qYW08
Message-ID: <CANn89iJiLC6ZRXqJU82vsH0Lu+-o-GP_1WAK=2bcfdGmu7nKrg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in tcp_retransmit_skb
To: fan.yu9@zte.com.cn
Cc: kuba@kernel.org, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn, 
	qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn, he.peilin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 8:16=E2=80=AFPM <fan.yu9@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, receiver zero windows, or routing issues).
>
> The original tcp_retransmit_skb tracepoint:
>
>   'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'
>
> lacks visibility into these failure causes, making production
> diagnostics difficult.
>
>

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Please do not add a Suggested-by tag when the original idea did not
come from someone else.

I only made suggestions to make your patch better.

Reviewed-by: Eric Dumazet <edumazet@google.com>

