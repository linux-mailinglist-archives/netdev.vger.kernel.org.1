Return-Path: <netdev+bounces-131659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C50798F2A9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FACC1C21F28
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A4B1A08A9;
	Thu,  3 Oct 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpoCKqp3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7919F470;
	Thu,  3 Oct 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969600; cv=none; b=ePWGcY6/4q6NbkATYFAOg0aST6iJDgY1uXNBpWIkVKeS/LVFLN2eGl9U41IKA9BgbCNaPMcCVjltFMS9oNLzm6DBJw22G9nS3tzA+uWmMv1v18tcqKCLdHXhWmMchwK17H8+5vwLCMS23FbflrPZFc0uQeOi65YM+xzGeoIo4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969600; c=relaxed/simple;
	bh=nr/vMyYhABDZXydF+sK9w9L0mldz0sraia6/uWj27po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AG+qIZI8G1FPaYo0MrJKJm5rWwsIYJK1mLJcaJROTFB+onri/3LTld6nsGp5pVlc5efG5zTdpVq6AGBTcZXAStqWKbKPUBoMSdOm2RulZTvE/YE3OyHquTPNRV1P4a0guFWrmWBFjb0euKRpfZ2YgqdnQPWzFiE50Nz6HBV7QyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpoCKqp3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a99e8d5df1so111565585a.2;
        Thu, 03 Oct 2024 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727969598; x=1728574398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cx4tTYL69dBbw3tjxjv8PKeAlv1+C3dog4q/0F9XPQA=;
        b=PpoCKqp3i5fpWUDCLEjGpONHbVFEDKRUV7y5pgoJ+M/JhT7HFPZkxIl2/6fvtqU6Dw
         lgsESX344kRvjZ0fu5ICVvxQsWMcAAgkXinJF3tE5b4RL+6YZHG5ZqDzLKg0kAmEwzvs
         V/DsunqMSCCr9niN0CQL5GkTV2Ny+oO1a1PUeof5ZJBV8LLJKVnUqdT/MY/uVXAvSyvn
         fs6rFilktHp6Ik0w0JVJxa7pZAfUtIGqzpSSfRq1YadBi5LzYdMyPPGIe0R6jTFFSXFq
         QejhHlP9+be6vLbW0lYvDlRqlqCIMPScwtkmkwiKs4avzo7SXIrTl8BT7yUli0AhT+Mi
         QPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727969598; x=1728574398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cx4tTYL69dBbw3tjxjv8PKeAlv1+C3dog4q/0F9XPQA=;
        b=YNwteRec25ygcQa6T/NRVwiiYldHNgiPtw0M6FkTsL/HmIM9oWWNZBlU0vl1YwVsPV
         yCowxIdwBAQE6rzTF5Ug1WgGNcTEYADBwcLEAtSN2e/4J8wcBZxhfd4Yh2wv7bMrw3Vc
         oDk8rCNrvBOkK5VM8IUEg9NJzXzhjJhxoAHlw/y8AqDzXMrlHMzXSoBVSCM7ryH8/b1F
         PLZCWxGcXEiuvsDQWf8NyHrmpP6qKZnbS8WGjnfqPGs/xlMf2StcgI7g28XucvzOHTer
         0e+AdQ1AD75JUVxorkfDwihezblL89SqYI7gMQgsAtEtRfCdsCW8rbPcytVOnR3tFIQd
         sGRA==
X-Forwarded-Encrypted: i=1; AJvYcCU55VV5CuYyCKIHMBqOkEcLcnO9nULl6B27pd0tZ+UJCwUfuUN+PrVjuSQ6TsY7yIc2Bqb8yR88@vger.kernel.org, AJvYcCV6YKWGyrTcEn+9AwFcjr/jsnB1x6BqZiNLV9OpB+orQz0yRSlq1ifRTlkI4kgB7gj3ERnZ5ohoagnis1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dBIlDhp5HZX1KQD5V3hxIwwxSU3rZjcyFNKeG00LLGA91Mjg
	JpbMguoOvOIboPfbCLI6Fb64un7TcdOrjPpzNRnczLQmW361euotuB1qfW0vKd0BZdU4TdmhXxV
	zJuE+lphbiIaUxSV5FfL2eAHIxoU=
X-Google-Smtp-Source: AGHT+IEJz5GSuZDrpFCH4UjvKy0flQYBRBcUimtmO0PXS2bvpuFxSlAN1WkaHUuNG1tMXLbEjq/QrVrBOnn9evyDXrE=
X-Received: by 2002:a05:6214:418d:b0:6cb:5592:9559 with SMTP id
 6a1803df08f44-6cb81a0c1f7mr108173306d6.16.1727969598212; Thu, 03 Oct 2024
 08:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001193352.151102-1-yyyynoom@gmail.com> <CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
 <CANn89i+aHZWGqWjCQXacRV4SBGXJvyEVeNcZb7LA0rCwifQH2w@mail.gmail.com>
 <CAAjsZQxEKLZd-fQdRiu68uX6Kg4opW4wsQRaLcKyfnQ+UyO+vw@mail.gmail.com> <CANn89i+hNfRjhvpRR+WXqD72ko4_-N+Tj3CqmJTBGyi3SpQ+Og@mail.gmail.com>
In-Reply-To: <CANn89i+hNfRjhvpRR+WXqD72ko4_-N+Tj3CqmJTBGyi3SpQ+Og@mail.gmail.com>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Fri, 4 Oct 2024 00:33:06 +0900
Message-ID: <CAAjsZQxkH8nmHchtFFPm5VouLEaViR5HTRCCnrP0d9jSF2pGAQ@mail.gmail.com>
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux@weissschuh.net, j.granados@samsung.com, judyhsiao@chromium.org, 
	James.Z.Li@dell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> sparse is not in the kernel. Feel free to remove it from your hosts.
Oh... I see. Yes, you are right. Sparse is just a program like other
tools like gcc.

>
> $ diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 09e31757e96c7472af2a9dfff7a731d4d076aa11..50fc48c6d0c99d91f5a8eb15c4e3dd0304a83e0b
> 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -2888,7 +2888,7 @@ static struct key_vector
> *fib_route_get_idx(struct fib_route_iter *iter,
>  }
>
>  static void *fib_route_seq_start(struct seq_file *seq, loff_t *pos)
> -       __acquires(RCU)
> +       __acquires(some_random_stuff)
>  {
>         struct fib_route_iter *iter = seq->private;
>         struct fib_table *tb;
>
>
> $ make C=1 net/ipv4/fib_trie.o
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   DESCEND bpf/resolve_btfids
>   INSTALL libsubcmd_headers
>   CC      net/ipv4/fib_trie.o
>   CHECK   net/ipv4/fib_trie.c
>
> No error at all.
> It also does not know about conditional locking, it is quite useless.
Yes, exactly. And It makes me crazy.
`net/ipv6/icmp.c` was written to use the conditional lock as you mentioned.
This is not a problem and can easily be verified intuitively, but
Sparse can't sense it.
To refactor the code to silent `Sparse` is putting the cart before the
horse. NON-SENSE.

So... What do you think about who wants to send the patch to silence
the Sparse's warning message, nevertheless?
I know him who was just about to write the next patch by correcting
mistakes (Seems like he wrote the subject prefix to `net`, not a
`net-next`, what a foolish one).
Is he wasting his life and taking other people's invaluable time? What
do you think about it?

