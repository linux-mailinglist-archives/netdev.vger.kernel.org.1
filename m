Return-Path: <netdev+bounces-225700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B59B972E8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E6718A8115
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D320427A135;
	Tue, 23 Sep 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8obXiPo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE220C00E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651749; cv=none; b=O4LzQH9sNhrvpbsEexmY8kDe9iJt+yAtGm0WqnbBKRXSuShe+5YoycaycaDsINSUPR1iC4RLcGqwVD+N+jKdpLyIt6PlCzqFcFCWzMSp6oYCatkwpE3nCaX788wn6kVjHT2HHxSBF9d6GBbexohZry9uWDGtuy7LLoQOPiOc9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651749; c=relaxed/simple;
	bh=lG8HqIkETFbjop5LvJlM5o07LzAENX6B+fkwBs+UuUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIUOmxAiG9dGu5QrQsM1l/mb7HTuXF5/6H2geJICC1jjpb9F7+S9fjdLUaXXaM25+ae6Nf93Km5LkXlXmsJxmOOlNyWUXnhHmRl8FFKPCA6GGTm67KUMz6WgX5+VSupQ8znlBYMg0AIHa3QfDwa71r9rMOeQAR2Ay36vKRx2yic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8obXiPo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so5666146a91.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758651747; x=1759256547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLipmlobx9xFBejkL9LIG2h6j4kUcZbmXvXP/ouCDtM=;
        b=g8obXiPoW6aw+wzJuwmKZPmDM/zDcWzebF76f/k7bxLZWOAGEqCf7IwJUbH1FPbUZx
         nxPjkfbVymJ1HyLwpGUsGQ65IONIjunL/C5Uo88JOnYsnoDLX9bM0lpke80erHHVaVpA
         MsNyp3+Ltj1/jku3CdtSNprHr/fqfef1svU44ILS9hW5AZP9vy0qDidG/7A+AirrGmQ+
         eEYAkuT+mUNMhqzR3C41/+qAgxg+rZsUXQ54ZkTIb+i0ubXT8Ub7zYG45DOGC7KZwiP4
         yLEf0usnN8MnaCofmwHdnUqD3gnBnRaeLXQ1wZUwmMVrojkZFbXAyOfPcOTgZD1fbvbC
         p5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758651747; x=1759256547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLipmlobx9xFBejkL9LIG2h6j4kUcZbmXvXP/ouCDtM=;
        b=m2s/wdnWe1UUPGuJWAxXrxiTUV/KEp7yhjjLMSA5vq5bZg7Z85drJts6MhjEOD+NCS
         jyykSC8iIVEmQeUFT5F5Z0tynHyDdi7J0kl9rmtlCtiVuxq5Gk/gDTiOxvNmDVAGh6N9
         t9UwJmzaoTykb7CGMThoIqWJk6RY1r8rPlyndu73uDZgmqufHwsOr04D9nRagaLXiT/A
         wVYjQNEFbC89FjWJQrk5wKCFhJ7LPBAtvjr6B0ywTQUmEgHX6t/I2dwnlYzKb9YZAhhi
         F8H2Lapw7boyHO816UcfEI9YluBCyFxOpzcmKO2UNP5TQAa2SfRqdR5apMj4XIQpgX/p
         GgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC1S+6ClD3ohgzHCD95TyHSrvkOPEmN/Hx4Zh9USTiwPl5D777etZKg09W0VH36VejkIunzvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOskIhOLXe/HwJVPBoXIGbzwB3CE+1XrdpwGED6YbDnLAeu/Y
	IHsLJ2GCY/J5AS1dxXQ0cnEdj5slhDfKnbyRVjpPK0Gaq1oPqkcPhi3GmcT1S4LxmKwei+6W9SP
	1Anxb7PSzlbn9D5cHeQWZ2CjyvhQFBu7JVfqGh1Fe
X-Gm-Gg: ASbGncvwjBcolTacjRueDatDKanNvlkFNnWTxQKDolSjFQoVtHzAuRXU1V+AasF7+Oq
	jbI5PRlLxBl97y43U8ocmPxAp1R0My9jJBjvx2FZCUMirwJE7yDzTDmUISrU9baFcG8j3KO6xrR
	V0h6dYsxglrWVB2oDVp9ee44HQ52VVB6ME+7b9bYlS79nah2xaP4j2XG3+XGD0d5gbXJ7mdTdsX
	KijjDRsrephhX04scqfEBf59yBPvmphTI18P+cqxz16
X-Google-Smtp-Source: AGHT+IFP9ou0WtzoSuqIgAB+dHVkXI0CupDnlmjUKW/qWJO0NRIEIHox7of0tkwRIXCZ5Y6/JDl6kKoVbCYK2Hpx+kg=
X-Received: by 2002:a17:90b:2cc6:b0:32b:d089:5c12 with SMTP id
 98e67ed59e1d1-332a96faf21mr4040803a91.33.1758651747305; Tue, 23 Sep 2025
 11:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922104240.2182559-1-edumazet@google.com>
In-Reply-To: <20250922104240.2182559-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 23 Sep 2025 11:22:16 -0700
X-Gm-Features: AS18NWBcXR_X7OErMAxzzVcnTZGCEKY-DoLqAC2gMmtQYlVrtqm0B6dSYZiK3CY
Message-ID: <CAAVpQUBD3VoDzV+4T4w58QGeu+ij3Lf+LGptwcXHkjv=bm3QVw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] udp: remove busylock and add per NUMA queues
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:42=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
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
> [0]                24901 |@@@                                            =
     |
> [1]                63512 |@@@@@@@@@                                      =
     |
> [2, 4)            344827 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [4, 8)            244673 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           =
     |
> [8, 16)            54022 |@@@@@@@@                                       =
     |
> [16, 32)          222134 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@              =
     |
> [32, 64)          232042 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             =
     |
> [64, 128)           4219 |                                               =
     |
> [128, 256)           188 |                                               =
     |
>
> After:
>
> @udp_enqueue_us[398]:
> [0]              5608855 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [1]              1111277 |@@@@@@@@@@                                     =
     |
> [2, 4)            501439 |@@@@                                           =
     |
> [4, 8)            102921 |                                               =
     |
> [8, 16)            29895 |                                               =
     |
> [16, 32)           43500 |                                               =
     |
> [32, 64)           31552 |                                               =
     |
> [64, 128)            979 |                                               =
     |
> [128, 256)            13 |                                               =
     |
>
> Note that the remaining bottleneck for this platform is in
> udp_drops_inc() because we limited struct numa_drop_counters
> to only two nodes so far.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

