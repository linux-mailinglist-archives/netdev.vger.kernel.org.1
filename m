Return-Path: <netdev+bounces-140110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E379B5435
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0F51F24614
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40277209695;
	Tue, 29 Oct 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TftYdxWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4FC208230
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234332; cv=none; b=i5rlC3/+L2CZW2og6wQE97Ib8fOOEAkGcVq4/TbtQYGjilWsjdfp5/WTfXDRlBWlO6r63kOTltihY8rN05OFXtr9cSfpGF51HMfEwdMlccztc/zi6v+SHpSxnDC+PXvzwDXYXL3PZ6c1DnySbqkJDTPC/CpnKStStP1iVuCtsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234332; c=relaxed/simple;
	bh=rxX4tl6h4/IVnKLPvQdszEOE7LTI8m5gBDI4nKRji6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpYYkztWxcz25dEh7fZikjh5HVvW2M25Zz7V/9w22Y0onPyzUfdzrNOGrlA+roE3Oio266sPvEJCQSFqn/vT7PFx8U/CmKw/tcfQSZGcvIhrAZD+vrhKWhYSgm6r0xUMR3z+XFaWReeWRmFhDA+eBbnY07j6gJKzzdO/fvMVcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TftYdxWE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7202e1a0209so473125b3a.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730234329; x=1730839129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxX4tl6h4/IVnKLPvQdszEOE7LTI8m5gBDI4nKRji6M=;
        b=TftYdxWEXrBh1Y+WDvRjT/BzGMGEQPImSYvHbctXruuVA6E8JFE1DyBWRlVcRWZtUL
         kXeqs4q9Sd3IWx4ueJqgEJgPAfncZa8HnJTRwNYE1RH6hjCzZGUNm4H/dhP4bPsFdfRI
         4FhlrUAgFW4kzzcXdGqOQGNXcRnVxq7cc0QTk7BBneqoCeN5zC7WPx/AuIW88rMDxvq7
         vKjlcfYcAJrpMa1UsV58DdOG0IdAh9rB7L7oZCyFJN1yxL8+ODQB18c/z0ClNazdkJRF
         nVIgPpK54bLK7jBAfNce11BpP5up6iaKCs9e88O8pSIyd2Yd9XlO8ja3K63ei9YaTtTP
         WUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234329; x=1730839129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxX4tl6h4/IVnKLPvQdszEOE7LTI8m5gBDI4nKRji6M=;
        b=LnwSJai+02hPb70yM4z7HWehvr6DPfxMh7KBg5Kq/lbSsFAraPQ8S4lLCl/xqsbgbK
         GVqin0zzJCk2dIfvljOj+ob0Ux9AnOJzoALRjLJYPJS73evN8pLj0K+IP1mjGkgHCNTw
         HG9FQcrYvK3lHItJ5eyxkXZVhUtafNrfvW5vFC9fW4GFQTN+21LEAfbSvLtQ+cEkocOC
         hdLWo++hcRKNMr8jqGn5bnyis2UuMOFTRuQnfTkENwrUVyALwmJCi5CK85Nti4MfFYZj
         oKm4FUkA/Dv9s8XXt0RSgaoBSocRWBSfmDJSAYOUGskaSOD5oDw6KWqahjQSq9hrMQNQ
         HtKg==
X-Forwarded-Encrypted: i=1; AJvYcCWVQNWe32ZTzh+QO6odUeS3Sgp306q+WulJhPvtpCoEmkfZA5cqUdTWdRPkxG9mrYex3BC99RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08s0rW2kvlAJmWdFZmf5tM9QPV8oMStsc29rX5XDJe/6PZ9Zl
	S3kl5zhOQHysG/BLJv7CQxysOeUwRPgPkn+RBr66Q2Ji5U0o5Or6r3cu2Z+yeo8Ht663bmfu8zS
	t8X0OvSZ5fO5IcxzhDTkleJ8W8IVLGA3X/MQGU9qtkJJrG243DNmKuA==
X-Google-Smtp-Source: AGHT+IET98qsSjNOjsfBxs4fNBfxl9mkBrcuSKEy0ssdSSQ0hphNvrIm7EngLn9PbwFPzWUn3YzOuODt/EHr1kPOdGQ=
X-Received: by 2002:a05:6a20:2444:b0:1d9:ddf:b087 with SMTP id
 adf61e73a8af0-1d9a84d970amr8215310637.8.1730234329089; Tue, 29 Oct 2024
 13:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com> <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
In-Reply-To: <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 29 Oct 2024 13:38:37 -0700
Message-ID: <CADUfDZrSUNu7nym9dC1_yFUqhC8tUPYjv-ZKHofU9Q8Uv4Jvhw@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > If RPS is enabled, all packets with a CPU flow hint are enqueued to the
> > target CPU's input_pkt_queue and process_backlog() is scheduled on that
> > CPU to dequeue and process the packets. If ARFS has already steered the
> > packets to the correct CPU, this additional queuing is unnecessary and
> > the spinlocks involved incur significant CPU overhead.
> >
> > In netif_receive_skb_internal() and netif_receive_skb_list_internal(),
> > check if the CPU flow hint get_rps_cpu() returns is the current CPU. If
> > so, bypass input_pkt_queue and immediately process the packet(s) on the
> > current CPU.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>
> Current implementation was a conscious choice. This has been discussed
> several times.
>
> By processing packets inline, you are actually increasing latencies of
> packets queued to other cpus.

Sorry, I wasn't aware of these prior discussions. I take it you are
referring to threads like
https://lore.kernel.org/netdev/20230322072142.32751-1-xu.xin16@zte.com.cn/T=
/
? I see what you mean about the latency penalty for packets that do
require cross-CPU steering.

Do you have an alternate suggestion for how to avoid the overhead of
acquiring a spinlock for every packet? The atomic instruction in
rps_lock_irq_disable() called from process_backlog() is consuming 5%
of our CPU time. For our use case, we don't really want software RPS;
we are expecting ARFS to steer all high-bandwidth traffic to the
desired CPUs. We would happily turn off software RPS entirely if we
could, which seems like it would avoid the concerns about higher
latency for packets that need to be steering to a different CPU. But
my understanding is that using ARFS requires RPS to be enabled
(rps_sock_flow_entries set globally and rps_flow_cnt set on each
queue), which enables these rps_needed static branches. Is that
correct? If so, would you be open to adding a sysctl that disables
software RPS and relies upon ARFS to do the packet steering?

Thanks,
Caleb

