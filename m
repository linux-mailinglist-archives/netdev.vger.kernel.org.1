Return-Path: <netdev+bounces-177746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC51BA71828
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF815189AC96
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112F1EFF98;
	Wed, 26 Mar 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Affpz9ml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9BC1EFFBC
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998189; cv=none; b=mnoMt4+QN0LCY5BUeI+avXo59fmhioNKr0/p3rZL8KNt+4g0SBUXE2Vk5ODdR20feLTId8c+rNgQVtahSJkKMsIsEDsEUChgMAbXgzjcSBPo65a8RoF+RjTIeneExfune3z5Spp4eRPkm/3A59m4Y7e9Cm09jB0MazbDp/FWYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998189; c=relaxed/simple;
	bh=cx53uc+EMptxO0evR4aaIhvL7qYMx22P8mLy8g/Am9Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rzvWXEvKfw8MIQ7s6Ki/U7LqcqnxtHmrr9DTOG5hK2A2xz4DhlmvoLM1WJ5viskIJJKnrDi/KEF3/qwFpKwp4M6IvNMi5aMboxGXyteYzq8HqUGDvBSMfBv9A8OGh8Jez434UKrIYLA1ycDnm94W2fkh/C+qzggSFEGp/TGrI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Affpz9ml; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c56a3def84so668783785a.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742998187; x=1743602987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZamFrRPvs0FueULW+HW6eptg6051M93VWIu0p9xwSY=;
        b=Affpz9mlRuGoDVDYjx4a+bChlbs2o8PGcP6jGMOBObmKkwHfSXzsJaxQHG4u3obSme
         ER/HLQC8C/qfolBcxaANN4P4dNskWysGQpDG7bhlh9k+ro/CTbziv7XuIx9ka+XdfaRU
         6igWKvS7eWuvaBgZaJy21j7mB0Us/NBx3s2Wy+ghDv2P2ZMUz9L8jgGOTl79GO3wuOZw
         Zla/g2grmtp1cvmLPUKHITs94qf7iv45x/j4dMlFsLAvwbZPoZH72UF/ja87FrzQfgzU
         yKhJ2O/pqQwMqLiIaeZi5sIHY/ll7G/wgOJr7+ldU7Ax71GSgkeJqstsp0iTM+kmaD6m
         SLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998187; x=1743602987;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lZamFrRPvs0FueULW+HW6eptg6051M93VWIu0p9xwSY=;
        b=p3Vl+GR7erSrSnnKR7GJVUitEx20NCXD7oDUOhNPJS5u2Oz8qMAFG/XUHj7eLQR58W
         YoMNzIn+W30akigKsmDH8KNlNP2FrZcnPLoMuglGiLWmdMB4S24j0UG91w4G7ep8MZ7K
         1q+zrPgE8HeDiD2/HvAGRisqJptggExgiyjX5UYwc6dlDy/bg0jxJWHTRusL8urbbua2
         DCO5vcnKfFTWckm+f65TgDEJKAr5QgvuhSg/YiT/a97PnSumQi+g/pvIiSHAGUeMb+YM
         2Tc2ukvw8r7USrv3wVYeh8DWt4MCPBzmj2HT3ElYUr+YxecqbF+GLMHEsIE/+KyVaFlR
         s4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFfAqQBTVx3/vNKCkg7lSOtmgb3szPcVGAWiketty1D2kpBM4CSSAe5ZXUkEfAslu/X1SrEuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivY+2RCPsqnuHwM+kf/6RclojW9MzrSEl52nUg2J/hwokTo1V
	ah8zttgl6hEu+3LsSh3SXZUFZVsqSgjhyVMZRAmoJ5CguDvHULpr
X-Gm-Gg: ASbGncvRzn0W59TiaEd9zJVRVZmviIPbxN9ACiR8dC/fHapjOe5F8+bvBA/fqYR7k7t
	LLBw+p74fFO8fF7Ee+H/W0YzHgRJcM0FLkeTF4Jl5otgCccB3VZSX+HFrTAjwKJs071kAe0WD/A
	ltuz7A/nkppIGBio0u3Ej3m8M+568SVGDDezgBVdkp1H0HfUJPX3So4SrlKAao25dCxBo/jAchU
	+5paMjUveCXa3QPYvBhwUbUukWy14XW9+uKrvoO8iI2dyR772EtvCuxsyIKpbRMfP0kfTnN2M52
	rYoW1THATcKe7bTLaL3mDy7cXLx1Xt34YS6iW1cjaBacrNOlv1EgnxQjSBWE9SJfk74SZR3v7+w
	NYKUcq0/1uWTdpI1O2b39Eg==
X-Google-Smtp-Source: AGHT+IF9xVgOGMmaCFEA6svzEpfW2rRQzc5ANdreOAkEX+w/EW+8rfgTnmlR4oAKWL9h6a98bw+atA==
X-Received: by 2002:a05:620a:24cf:b0:7c5:54c9:3b94 with SMTP id af79cd13be357-7c5ba1954bdmr2888239685a.28.1742998186623;
        Wed, 26 Mar 2025 07:09:46 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93484e3sm766712885a.87.2025.03.26.07.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:09:46 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:09:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org, 
 Matt Dowling <madowlin@amazon.com>
Message-ID: <67e40aa9c8de1_4bb5c2945@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250325195826.52385-3-kuniyu@amazon.com>
References: <20250325195826.52385-1-kuniyu@amazon.com>
 <20250325195826.52385-3-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net 2/3] udp: Fix memory accounting leak.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> Matt Dowling reported a weird UDP memory usage issue.
> 
> Under normal operation, the UDP memory usage reported in /proc/net/sockstat
> remains close to zero.  However, it occasionally spiked to 524,288 pages
> and never dropped.  Moreover, the value doubled when the application was
> terminated.  Finally, it caused intermittent packet drops.
> 
> We can reproduce the issue with the script below [0]:
> 
>   1. /proc/net/sockstat reports 0 pages
> 
>     # cat /proc/net/sockstat | grep UDP:
>     UDP: inuse 1 mem 0
> 
>   2. Run the script till the report reaches 524,288
> 
>     # python3 test.py & sleep 5
>     # cat /proc/net/sockstat | grep UDP:
>     UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> PAGE_SHIFT
> 
>   3. Kill the socket and confirm the number never drops
> 
>     # pkill python3 && sleep 5
>     # cat /proc/net/sockstat | grep UDP:
>     UDP: inuse 1 mem 524288
> 
>   4. (necessary since v6.0) Trigger proto_memory_pcpu_drain()
> 
>     # python3 test.py & sleep 1 && pkill python3
> 
>   5. The number doubles
> 
>     # cat /proc/net/sockstat | grep UDP:
>     UDP: inuse 1 mem 1048577
> 
> The application set INT_MAX to SO_RCVBUF, which triggered an integer
> overflow in udp_rmem_release().
> 
> When a socket is close()d, udp_destruct_common() purges its receive
> queue and sums up skb->truesize in the queue.  This total is calculated
> and stored in a local unsigned integer variable.
> 
> The total size is then passed to udp_rmem_release() to adjust memory
> accounting.  However, because the function takes a signed integer
> argument, the total size can wrap around, causing an overflow.
> 
> Then, the released amount is calculated as follows:
> 
>   1) Add size to sk->sk_forward_alloc.
>   2) Round down sk->sk_forward_alloc to the nearest lower multiple of
>       PAGE_SIZE and assign it to amount.
>   3) Subtract amount from sk->sk_forward_alloc.
>   4) Pass amount >> PAGE_SHIFT to __sk_mem_reduce_allocated().
> 
> When the issue occurred, the total in udp_destruct_common() was 2147484480
> (INT_MAX + 833), which was cast to -2147482816 in udp_rmem_release().
> 
> At 1) sk->sk_forward_alloc is changed from 3264 to -2147479552, and
> 2) sets -2147479552 to amount.  3) reverts the wraparound, so we don't
> see a warning in inet_sock_destruct().  However, udp_memory_allocated
> ends up doubling at 4).
> 
> Since commit 3cd3399dd7a8 ("net: implement per-cpu reserves for
> memory_allocated"), memory usage no longer doubles immediately after
> a socket is close()d because __sk_mem_reduce_allocated() caches the
> amount in udp_memory_per_cpu_fw_alloc.  However, the next time a UDP
> socket receives a packet, the subtraction takes effect, causing UDP
> memory usage to double.
> 
> This issue makes further memory allocation fail once the socket's
> sk->sk_rmem_alloc exceeds net.ipv4.udp_rmem_min, resulting in packet
> drops.
> 
> To prevent this issue, let's use unsigned int for the calculation and
> call sk_forward_alloc_add() only once for the small delta.
> 
> Note that first_packet_length() also potentially has the same problem.
> 
> [0]:
> from socket import *
> 
> SO_RCVBUFFORCE = 33
> INT_MAX = (2 ** 31) - 1
> 
> s = socket(AF_INET, SOCK_DGRAM)
> s.bind(('', 0))
> s.setsockopt(SOL_SOCKET, SO_RCVBUFFORCE, INT_MAX)
> 
> c = socket(AF_INET, SOCK_DGRAM)
> c.connect(s.getsockname())
> 
> data = b'a' * 100
> 
> while True:
>     c.send(data)
> 
> Fixes: f970bd9e3a06 ("udp: implement memory accounting helpers")
> Reported-by: Matt Dowling <madowlin@amazon.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

