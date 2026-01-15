Return-Path: <netdev+bounces-250198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C056FD24F77
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F6F3023552
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5073A1A5B;
	Thu, 15 Jan 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hB+Tg+9f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795503A0B28
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487634; cv=none; b=HanLG9vnvfh7O0MDLvIFSp4jBe4kZaKoyU4HGf08TsQ39VbNcSamAc9sCPMpCjA5CTzHAQbTtQfm346S/fI0MorEes0Kd23ypXutXbOFqI0knnlWw63H9loYQDDyCmpHmurI7434joEchdS3zEtoQ/SnSM0V1XKm8k5H1ZfOWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487634; c=relaxed/simple;
	bh=8rR//kRgRM+Qh/l7k8ZvuRcqg72t/rP4Ihy/06zJAuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGzZKA7BbesesKk0+6qFvpw0pAbPRMUTbgENMQkolfnBKfBbCECoGx2qrXWY4qVpPfPnLuKQcjvR3gqPScEPE/XeI/c/2NPnDVxGy4xOwicxt/dbU5XxIzahXDPhM1mA3jPP8MsK4TbB5FunC6aXGcOtuCicpJi3o6M+I46NxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hB+Tg+9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6517C16AAE
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hB+Tg+9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1768487630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puVYZ6ntPN6hFvEqttknJOK7T6Kh44cVv1NhFCJjVaw=;
	b=hB+Tg+9f6rUXMn2ykTVGX21ss7Qr2zMZ1+WP2YhUFNWwhxEWShlgPgBLvIZwYLKt1wTaaA
	NZCcbcBPipIHJkpIyyYfCmX2rMaAWnDxn0qRNRmhvgcNwji6fA7rQs4CeqnHk19T+riTG1
	0eLkV+gW6/BrIrMNQ5Sq/i8e/j/JUqo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 96a1c10f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Thu, 15 Jan 2026 14:33:50 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfd1086588so601321a34.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:33:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1M4wjQt7PL5FusN1nqRn+LneC+eWPByYvmeyeL6HW0ije/ES/Yn6A2sZ8Xz1OLJ8nC1hpyb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhAWkcHXU0Vb6euAhHrQ64rU10YhXN/2JM7bAg7QR5fxgNwDqW
	d+klvxeYkpy6pl0+5Cwl3ge2/Q2TsvxuKgaesxUJdGeca5HTggSjz/DcVz5N3V0MMuA2ZPKarwY
	tTdtTYBIxShTZcqM9VBUCIAtIRo0dJKI=
X-Received: by 2002:a05:6830:4408:b0:7bc:6cc3:a624 with SMTP id
 46e09a7af769-7cfc8b69bd1mr4946386a34.32.1768487628292; Thu, 15 Jan 2026
 06:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115033237.1545400-1-kuba@kernel.org> <20260115051221.68054-1-fushuai.wang@linux.dev>
 <CANn89iKfuXjqKsn+xB6bpGOaqM7pN4ZcRJ=2KJg4WY76ArYXhQ@mail.gmail.com>
In-Reply-To: <CANn89iKfuXjqKsn+xB6bpGOaqM7pN4ZcRJ=2KJg4WY76ArYXhQ@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 15 Jan 2026 15:33:42 +0100
X-Gmail-Original-Message-ID: <CAHmME9quqMVzD5zSEKvOFOYj3QLANAo2iYeqWQ1toV0C7gJXTg@mail.gmail.com>
X-Gm-Features: AZwV_Qgs49WZRh6E-yqe5lqzG8HY34Jy6O9o1SJKl4M8EfIBEY_spLptdahY4Ps
Message-ID: <CAHmME9quqMVzD5zSEKvOFOYj3QLANAo2iYeqWQ1toV0C7gJXTg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] wireguard: allowedips: Use kfree_rcu()
 instead of call_rcu()
To: Eric Dumazet <edumazet@google.com>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, kuba@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, vadim.fedorenko@linux.dev, wangfushuai@baidu.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Thu, Jan 15, 2026 at 10:15=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> > > The existing cleanup path is:
> > >   wg_allowedips_slab_uninit() -> rcu_barrier() -> kmem_cache_destroy(=
)
> > >
> > > With kfree_rcu(), this sequence could destroy the slab cache while
> > > kfree_rcu_work() still has pending frees queued. The proper barrier f=
or
> > > kfree_rcu() is kvfree_rcu_barrier() which also calls flush_rcu_work()
> > > on all pending batches.
> >
> > We do not need to add an explict kvfree_rcu_barrier(), becasue the comm=
it
> > 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_dest=
roy()")
> > already does it.
>
> It was doing it, but got replaced recently with a plain rcu_barrier()
>
> commit 0f35040de59371ad542b915d7b91176c9910dadc
> Author: Harry Yoo <harry.yoo@oracle.com>
> Date:   Mon Dec 8 00:41:47 2025 +0900
>
>     mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destructio=
n
>
> We would like explicit +2 from mm _and_ rcu experts on this wireguard pat=
ch.

I'll take this through the wireguard tree.

But just a question on your comment, "It was doing it, but got
replaced recently with a plain rcu_barrier()". Are you suggesting I
need a kvfree_rcu_barrier() instead? The latest net-next has a
kvfree_rcu_barrier_on_cache() called from kmem_cache_destroy()
still... But are you suggesting I add this anyway?

diff --git a/drivers/net/wireguard/allowedips.c
b/drivers/net/wireguard/allowedips.c
index 5ece9acad64d..aee39a0303b0 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -417,7 +417,7 @@ int __init wg_allowedips_slab_init(void)

 void wg_allowedips_slab_uninit(void)
 {
- rcu_barrier();
+ kvfree_rcu_barrier();
  kmem_cache_destroy(node_cache);
 }

Let me know.

Thanks,
Jason

