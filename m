Return-Path: <netdev+bounces-169697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A35A45491
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 05:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B8216D3F1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A224F1DED6D;
	Wed, 26 Feb 2025 04:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qg+vSRWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09D139B
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740544553; cv=none; b=Pa7zoM/GGD63YG2O/N9UCytbu0bhMQj1P6lHe5/lNHj1H0Uy4AR+Up4rkkKQmQiYOCbE+vCf1L/FB+jIpi9e5ziRR/E/RWblYFJNaNxlLpN+qqc5F8Q8o2pKLDRq3FMlpQNLqG3FryIZQH1UNgg9mbkIa4jeNi/pWvoTrLW6Ha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740544553; c=relaxed/simple;
	bh=UBPza1SUPTLHERUvj3y34zri08q4yI0GcdInv/iXNeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgFwblyuwzU3eHmae/ZHn4g3tAH51ISKfhJCbshp+OMFLAaJ1vxf37pytkN5QNhf1Lmk75xuYTZOgtHmNroJwy/vRjy84ty9fnUgrws9ZQxz4S7Dt8iT7wwAJyz+bbudNb1DuqqjCmioLlcsGq4YeQ/BbzoiDTUscLGp5bh9Sv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qg+vSRWs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso11583931a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740544550; x=1741149350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFKdFVLTJhLMWmV1mhzjdD68kjTcQcQQrs4WZ16iG64=;
        b=Qg+vSRWs2d7C4UG9Q/Jpq7PCpjJ+MwE5JAutML5RA9oQnXIjesQcSmSVK7Jz63AaAu
         6D5C4rDn3cTiNoye8Yh8o6GaNkgxTdJIx5d2W8sb8Qjl2q8Z6vfO9j1hWOeNW1CF5v/X
         5ZNJcU/MaYLBgGeJ91TRS+dWW73dOJ81zZ58nkPX+6s8R53rYTtCbZ9sh/wiuteqbXah
         p00mxIwS1MbWwWGzYoSdmoLf77RtH2d4/2wLwzSUZe2IfI6MlkCTv6c1tXGzePFj5lfz
         79jbR85jhrkmoop5y/T3fC2DZKwvsCtmNoYN6CTkHlNGwtrsZpWHguLY4bP14XlAz+uQ
         IH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740544550; x=1741149350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFKdFVLTJhLMWmV1mhzjdD68kjTcQcQQrs4WZ16iG64=;
        b=mz+mWbZ+PzMtzqhPQIJfe6ndcd3CHRyPHknMA/2G4qQqMEDXJ0LYMlCXrtsY+6nl1s
         Hu4kJwnxVp29BHnw2gIf8lClQCg3PcZ6Bo8+79LDgNjD7YcnzLGjNQvfKzQK3KAL+rda
         HzwkSzWDZ2bWlIwx4VW75FICD0sbpq5gqPJhhjqH9HrYDuKmOreNNLkhcrVrFtYp0cyr
         BmMkeQ/KdJyw0l3zZO9jE9Lp7Vv2FZuaHiBWIMNElTxdpfO+3JaSTQh4VXDi9VGgMbP7
         Nzt0FKyw0rE/36ZFZb+Ht24z2BYb5pIrKuxrx5M2l74VtIpvucdintkq30nuJ60URDZV
         7t/w==
X-Gm-Message-State: AOJu0YzuzuJ3C70zeJicvHSeBJWDKhuqfDqYFScQenEHj0+j2ZZtZL4b
	cI7qDBpAusNtOsXj2sI7ZbXKvHPt9ZsEaV/mouCPrUKQDVgVD8rxmgjGfIO9ClKKvplK23kVNtD
	lMcZprSHxxmxx0FjF0xYWmT284I6dmOBVC7Yx
X-Gm-Gg: ASbGncuZi1lRQFn0iNc/vSd+TkLx1vlZj/q5kKGVjZ/0hXCV1tm6vIzLQfPVdjNLryL
	JBTfaiYwTDfMNi50nqcVR8HWxeXOHBXMXpTDWpX3RRytbgxH0wWFGmCpMpHrhD2LuzEZLNSelPW
	1j8fWDY7Fd
X-Google-Smtp-Source: AGHT+IFMmEmVg5OF+dwEaYXVyEuPOguHVz00xJRpWI72B59/z53YuFcYQ5l93uLJ41/G1pjHmG+FZo7siMTpNfpVAgU=
X-Received: by 2002:a05:6402:4609:b0:5e4:a1e8:3f04 with SMTP id
 4fb4d7f45d1cf-5e4a1e8a365mr1427201a12.8.1740544550088; Tue, 25 Feb 2025
 20:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225112852.2507709-1-mheib@redhat.com>
In-Reply-To: <20250225112852.2507709-1-mheib@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 05:35:39 +0100
X-Gm-Features: AQ5f1JqmDFtSVkpk41WdBb5Wkx1sBOVXF7QB54uwwA5TwLGo3UmwPrRLIpuUAxM
Message-ID: <CANn89iJLZ+3-HTQJSsk9iNnXy89uE9oLQn=ZLNayY16hauBYew@mail.gmail.com>
Subject: Re: [PATCH net v3] net: Clear old fragment checksum value in napi_reuse_skb
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:29=E2=80=AFPM Mohammad Heib <mheib@redhat.com> w=
rote:
>
> In certain cases, napi_get_frags() returns an skb that points to an old
> received fragment, This skb may have its skb->ip_summed, csum, and other
> fields set from previous fragment handling.
>
> Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
> CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
> others only set skb->ip_summed when RX checksum offload is enabled on
> the device, and do not set any value for skb->ip_summed when hardware
> checksum offload is disabled, assuming that the skb->ip_summed
> initiated to zero by napi_reuse_skb, ionic driver for example will
> ignore/unset any value for the ip_summed filed if HW checksum offload is
> disabled, and if we have a situation where the user disables the
> checksum offload during a traffic that could lead to the following
> errors shown in the kernel logs:

It would be nice if you could get symbols with this trace
( scripts/decode_stacktrace.sh )

> <IRQ>
> dump_stack_lvl+0x34/0x48
>  __skb_gro_checksum_complete+0x7e/0x90
> tcp6_gro_receive+0xc6/0x190
> ipv6_gro_receive+0x1ec/0x430
> dev_gro_receive+0x188/0x360
> ? ionic_rx_clean+0x25a/0x460 [ionic]
> napi_gro_frags+0x13c/0x300
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic]
> ionic_rx_service+0x67/0x80 [ionic]
> ionic_cq_service+0x58/0x90 [ionic]
> ionic_txrx_napi+0x64/0x1b0 [ionic]
>  __napi_poll+0x27/0x170
> net_rx_action+0x29c/0x370
> handle_softirqs+0xce/0x270
> __irq_exit_rcu+0xa3/0xc0
> common_interrupt+0x80/0xa0
> </IRQ>
>

Note : This suggests ionic driver could add one
skb_checksum_none_assert() as other drivers did

Reviewed-by: Eric Dumazet <edumazet@google.com>

