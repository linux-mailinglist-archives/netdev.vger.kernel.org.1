Return-Path: <netdev+bounces-225257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8D3B913F6
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BBB7B01C2
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493CA267AF2;
	Mon, 22 Sep 2025 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkTsFMn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4518024
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545556; cv=none; b=uJb87mwjeDvwcOfHTCCBqO3eMbQq9pPa6eEik0q6KOaF9fbReOvTVBGGUoEDLWlfKvBpLRSLEikuZkcZLtKRv07gKr4xuyIYOIMFIjoyT26Kr6rFP2f27G7rGL3rLFHZmR/ONxe6eTVQjc13mgq6id9QU6GIDJfDU1ZGEYDXu5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545556; c=relaxed/simple;
	bh=qBSzcKSuf4xAyWW34UCvNRoxEkfTayXuCCAxt1N+/G4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=e4LYL2KTJdSUEoU7p23sRjei4MPbfl6EM19sRqpXzUZZg+6r7D1Hw6c79m2WiqxlS7W68menc3uPJyz6wX67nZVKXiGxEIXQrasz6u8UZncrsz8D76szlM0JVefAtCzJR97F9hpnEolNJMYqYoSGMqPsfHGbwzx71k1zut2+I/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkTsFMn9; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54aa0792200so1087364e0c.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758545553; x=1759150353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9PNOBbvYQj8vLx1kUxDpT+tNA9I5A6dkvqQJci66vA=;
        b=dkTsFMn98iCyAUgyAyrGXbmeUlU2N5yM0NdJ0sq3KWJMUHtraIB739s+KCId1uvtDx
         wFTR6wcVjx2no3pfEFvoniZjUVcjM52P1HP5OpUfqU04/Ai8y5L25RRwGfzvUzlAYQQv
         uzXBI0br4cYK6I6PeXFlrXlOikfMqgHDFj1IyplLthDm/froZGj3Y9Lb8VdDI9IKhtLL
         Ys9xcsfpe8nQLykGXjUjT+RbfYxA0BYd08dpHS7WCnxdvnigC7tlo1FslhlBHVOvcpIZ
         zmmB7mL8Wj94uEi9xY5PLLyjFbuOLMMX4fVB/1/UJBbYx9Hehk5BWfJfE2jbt4dLUoBL
         BWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758545553; x=1759150353;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q9PNOBbvYQj8vLx1kUxDpT+tNA9I5A6dkvqQJci66vA=;
        b=LVvhxaHQFNYLGSekb5aIvqfeES6UkBdAligkPGu7jsNrFN6Oe6o4g/DLzMW+BIS1co
         tc+BsNHxbo2OgXnoDwEhumz2syj5CVAXoLvS6+6eiMgHi4k61Xxz0S4gM0Pkn6nRdcKs
         3PD55yJ/sfeSOs1VTa4i5qj3+yp6Ap62Kxe+aBA9XGL9rPXZTWzKVLJzonESSMAHTIKe
         YAfO2pIXNPRJi1ZJRY+a8xymF/ZpZl7ODeV40xO30iC1kHOhu7j9A0rOcPw9sO+p1jAw
         F0V8lujtyXbpVeOqF9PdFslwX1iSEi7gzYoE50ZmA5OIts2VGCxkUwFL+xlLGoegnJjG
         ExRA==
X-Forwarded-Encrypted: i=1; AJvYcCX5gict8Ape23xnGUbOIOkHdxzHpk/QHxyaXnFBsWfdnJVMdG9y3jBXvAu5Rgypiapqo+yJ50g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjR+Azl4+nF15csIgrDdMyAvijaSBB2dhmXaFd364yXqLa37W
	oY5F7uUJ6u3k1y+f4jRzW0n07tYSBEjC91hd8qrEhevFzH405I5jOJuT
X-Gm-Gg: ASbGncvLmmSkZsdkOzcaptBmZQjIg0YNS58mfMJvbH/2O9KAZHuHzakCVRf4Q5jjAnS
	/aidNH6L5iWxFLB4Fl1mTnUy8AkNqSiXPMhBwE4cBcpbcATgQpi3XmCex1vfkwuAyvprZfEcfHf
	+0noIcLPL9GWzsqHS0LXU4PRaq2V+4UrO0geTyI/k8srSyNSRLiNgqcydsvgp64s5vYfYTtTbnF
	Zo9LExeBI3tspdCAB/t5NkOhGs8xPqS1dkO4gLjQ5AmAf4CbEcZYsB9lgehlIJ5GHk7bGx1fmNE
	TcqfvwFTJCN/mGgqa/IIWeHzi0MuVsIW1KihhmVnlxh0TVM7NVLsFYXJLsshnss15jYkuHsKU+K
	ICjZUDT56ZurNaZY5TmOVz+zJBqemW2olrn7WELRHQwQHqo/VgABvKCRHfhkNE3soLro1BQ==
X-Google-Smtp-Source: AGHT+IFw+3gWwgrgzz3NQ9AfPCg9RVncWypkjyVm3Z7H5lZuekceNnoCK3+veQMIN+mQ7345mlOzLQ==
X-Received: by 2002:a05:6122:30ab:b0:539:44bc:7904 with SMTP id 71dfb90a1353d-54a837847b3mr3763944e0c.5.1758545553365;
        Mon, 22 Sep 2025 05:52:33 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54a88d5efbbsm1754249e0c.27.2025.09.22.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:52:32 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:52:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.af97f0e88745@gmail.com>
In-Reply-To: <20250922104240.2182559-1-edumazet@google.com>
References: <20250922104240.2182559-1-edumazet@google.com>
Subject: Re: [PATCH v4 net-next] udp: remove busylock and add per NUMA queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> busylock was protecting UDP sockets against packet floods,
> but unfortunately was not protecting the host itself.
> 
> Under stress, many cpus could spin while acquiring the busylock,
> and NIC had to drop packets. Or packets would be dropped
> in cpu backlog if RPS/RFS were in place.
> 
> This patch replaces the busylock by intermediate
> lockless queues. (One queue per NUMA node).
> 
> This means that fewer number of cpus have to acquire
> the UDP receive queue lock.
> 
> Most of the cpus can either:
> - immediately drop the packet.
> - or queue it in their NUMA aware lockless queue.
> 
> Then one of the cpu is chosen to process this lockless queue
> in a batch.
> 
> The batch only contains packets that were cooked on the same
> NUMA node, thus with very limited latency impact.
> 
> Tested:
> 
> DDOS targeting a victim UDP socket, on a platform with 6 NUMA nodes
> (Intel(R) Xeon(R) 6985P-C)
> 
> Before:
> 
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 1004179            0.0
> Udp6InErrors                    3117               0.0
> Udp6RcvbufErrors                3117               0.0
> 
> After:
> nstat -n ; sleep 1 ; nstat | grep Udp
> Udp6InDatagrams                 1116633            0.0
> Udp6InErrors                    14197275           0.0
> Udp6RcvbufErrors                14197275           0.0
> 
> We can see this host can now proces 14.2 M more packets per second
> while under attack, and the victim socket can receive 11 % more
> packets.
> 
> I used a small bpftrace program measuring time (in us) spent in
> __udp_enqueue_schedule_skb().
> 
> Before:
> 
> @udp_enqueue_us[398]:
> [0]                24901 |@@@                                                 |
> [1]                63512 |@@@@@@@@@                                           |
> [2, 4)            344827 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4, 8)            244673 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                |
> [8, 16)            54022 |@@@@@@@@                                            |
> [16, 32)          222134 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                   |
> [32, 64)          232042 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  |
> [64, 128)           4219 |                                                    |
> [128, 256)           188 |                                                    |
> 
> After:
> 
> @udp_enqueue_us[398]:
> [0]              5608855 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1]              1111277 |@@@@@@@@@@                                          |
> [2, 4)            501439 |@@@@                                                |
> [4, 8)            102921 |                                                    |
> [8, 16)            29895 |                                                    |
> [16, 32)           43500 |                                                    |
> [32, 64)           31552 |                                                    |
> [64, 128)            979 |                                                    |
> [128, 256)            13 |                                                    |
> 
> Note that the remaining bottleneck for this platform is in
> udp_drops_inc() because we limited struct numa_drop_counters
> to only two nodes so far.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

