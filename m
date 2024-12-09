Return-Path: <netdev+bounces-150200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E259E96C0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E7B281C35
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E423596D;
	Mon,  9 Dec 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgV6OW/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382D1C5CB0
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750785; cv=none; b=cS0d7D9Eg8SIWqcg1pCxe//B0ED2iq6SoKfNyI4tmqfstkaMhJrG5cCyNM0D0rOjZgbqMb8C1gybFnWJRwP9k0N1aKeuGC1xurZZQf47fMJ0x9z1Rx6+CkG74snekSqqxbVbhMX9kVPSrbkCQR2XQCiH9Uh2IRKXwCiYdoIiOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750785; c=relaxed/simple;
	bh=hMCEZBd52IfBjLmuAGuA1TKt0UyWTxXpgKiVU/d56Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcHAaaQmD7U/TsfpEmWx4+rcjgL9Fbkuumds6wKdXNQ5iBR6q9pYBiAnIIn9UcxWRdfIuGndmi1qJiBCs7eeiK6viHXoriLejuEX9/rI7ANAh9OSNiHyCZSxbpJMbxKaIjMlVDeq76XuELwXv3HeQP9d++jqNu9VY6CVvSvRvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgV6OW/E; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso3489432a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 05:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733750782; x=1734355582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyOKraohbpCbJjgoD+Q4ojxiEjD3M3oqArgjS6aAPB0=;
        b=mgV6OW/E5t/s1HDkETOnkQE2REQ1rLLi70JZ2rPHd/7F1cptoJdxW5DCfKPHlcOHWD
         Iei52KKba+NvCyFNc5/Q9W0iWp2iAnqYBOvl3ySPFEABz/zwvIH8mq6GqLMGgTXKsN1F
         mDPvUXicPCQz8EHjv3nGY7StbiARy4KS3StrShZQVYcdwxFAxgVaE/nJWD1/vNqIriaV
         QAaOaDkUc4ejRDlUZzb6AsXmtaoma1F4UvOs2Arruf2JVt8qUHS+F+fWHFz3j25L8628
         kqJum2EG18SINLRDTUbb0RTmIjFo6cgAdXFdFdaklkHRYf+QbkPZCKupuf1JpHwimyDV
         X22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733750782; x=1734355582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyOKraohbpCbJjgoD+Q4ojxiEjD3M3oqArgjS6aAPB0=;
        b=Vb/qdHaQGXdFUKMrBc9iufjPUY+K/4+2D3W5UNSiL6s0db8gZwxfqXxrqvRZctSC8w
         fxqNQkIqM0tGttE1q7HclO9JPlZ5m7PxRJbxhvWINGwgJefrj72U8g9ZK4mbCwe5yswO
         1w30IkBvzpeEFC/2Acy2kxsSnZ4jIQ8vveXLhGvR2IER7bE1qP/BwKRwpjlLQJRLjOnY
         HcYq5DM8zQiqYvoS0YWnohf6U5FphK8f1PdDOOI9iLhNK1q8++HCbu6nbJZe3ZrVvJWP
         ogkWDHDvUnkgGqA8mQWBcPeULUsvmNjHLJUHFELXDEbda1oj63iGcUTTVaEindJTV7gP
         xWJg==
X-Forwarded-Encrypted: i=1; AJvYcCXfs+p7itU9BYtfGJlrJO5Ypx3VgbphlpOAi+9c5pdsvAoFA0r6nXcXq7EeLuQfJuLPvzqepFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJGT7CLhH0Fq7YBcXJlxxqQuOtJt+mPFvE8llRwM+nVMn03DW
	o2m9tqC9kJ+BZDiranhfbcp6Rq/33NNvsXCdzaYQ1TtTO7orNFKB9W7xmUgDbh/rhhLjfF7YgdU
	1SI2UvRIb62GWrjPnsZJYiXUKdTUBgOy8xjHx
X-Gm-Gg: ASbGnctx1njxqK7gs2PUncSg581BcEkrYm+L/mHEez22xZQqBXat6mdb5aua6zppUJS
	k1p4q480dDNqFOACCKrYYQfG/IOkfBw==
X-Google-Smtp-Source: AGHT+IGrteuKL+cXgGPqeJvWmTXfuM/VQrXx0WWPWPLPZQgNKio6EXWsneFfhIIwWD5lb1FbwWQAnWJJzUYPZ/q5KFo=
X-Received: by 2002:a05:6402:3216:b0:5d3:cd9a:d05e with SMTP id
 4fb4d7f45d1cf-5d3cd9adc64mr11993753a12.9.1733750781720; Mon, 09 Dec 2024
 05:26:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
In-Reply-To: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Dec 2024 14:26:10 +0100
Message-ID: <CANn89iJg=NBG4ubKA77iRZ0zxLk2isMRsC3tzJew4rBW3OO0kQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: sch_cake: Add drop reasons
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, cake@lists.bufferbloat.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:02=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Add three qdisc-specific drop reasons for sch_cake:
>
>  1) SKB_DROP_REASON_CAKE_CONGESTED
>     Whenever a packet is dropped by the CAKE AQM algorithm because
>     congestion is detected.
>
>  2) SKB_DROP_REASON_CAKE_FLOOD
>     Whenever a packet is dropped by the flood protection part of the
>     CAKE AQM algorithm (BLUE).
>
>  3) SKB_DROP_REASON_CAKE_OVERLIMIT
>     Whenever the total queue limit for a CAKE instance is exceeded and a
>     packet is dropped to make room.
>
> Also use the existing SKB_DROP_REASON_QUEUE_PURGE in cake_clear_tin().
>
> Reasons show up as:
>
> perf record -a -e skb:kfree_skb sleep 1; perf script
>
>           iperf3     665 [005]   848.656964: skb:kfree_skb: skbaddr=3D0xf=
fff98168a333500 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x10f0 reason: CAKE_OVERLIMIT
>          swapper       0 [001]   909.166055: skb:kfree_skb: skbaddr=3D0xf=
fff98168280cee0 rx_sk=3D(nil) protocol=3D34525 location=3Dcake_dequeue+0x5e=
f reason: CAKE_CONGESTED
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

