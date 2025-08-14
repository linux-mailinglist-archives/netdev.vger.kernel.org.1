Return-Path: <netdev+bounces-213704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED08B266B8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F7B2A5529
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81682FE06B;
	Thu, 14 Aug 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEBDtltt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154822FD1D9
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177100; cv=none; b=F9SkJylp/M4iyk1I9bEXwdRzkJIMJZTEgabstiPv4iQmNnhJIvtuNvg+nl6rkal/aKQhzM/m8X9CTQJFuDVKAGRlzGkSExUf4GzdgeKZCyNLs6ZeRrz+EJ7Sk2063P4GKjP0Jt7qyJd+WQhL56aed6GYmioRZjZaHTHHNv0sqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177100; c=relaxed/simple;
	bh=LQgw6+fTEu/l6eNRiJCEeQkIcbRo5WZOl/xTxrsl+NE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XewfPf7sTttXmBz6PZqrA+C+pFVX22LAUzQmESo3ugOoEsamrF4fD2HhLMHdEbwVOD51cxXpr5SDq/dW5alxuFYwbrhVvwelSNYPL/Db8ii/K6Oe0V6a2YwBYFHn13AovAsqsAWtCRJU5FkrwSw4TTgb9R4HOwLqiLsegNhiiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEBDtltt; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70a9280c7c9so10124126d6.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177098; x=1755781898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlonSHep0jnTIEJ1ig0/81c0WkeWKeymfa/jH5pHbaU=;
        b=EEBDtltt5TQLAIVmNUe978WaX/xECwDTTz0q2e+nUaC3L0xpWMY75NRxiiCXUayNZt
         rG9aKcLYVg6H/71TIk5A1VkkES5CVarxTAXuCpayvLs1k6DJvZvV0IqLcLMfyAMgc8X5
         PFD8PRdPjVh85No6dAiGl7PQEBLxG38zBka405t+/spBAlRfm16wn4zqG6VuFP9aaCFD
         DMDR+giLK3xa1F13K1hCs41+YX1M5ziSGujLsJic/tWgXRNf/Kz2s6ESJZU6S4Ut/Y4a
         aHPapeJU4tNtF5mulk3bIKQFoVBjq+Gw976wBGOrE5HPgDx+oyw8FCOGmfOKKHtQGu3E
         W/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177098; x=1755781898;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlonSHep0jnTIEJ1ig0/81c0WkeWKeymfa/jH5pHbaU=;
        b=K3Gr4oxxpORWIJELXlfYIWu2m1+2zdNZ2IzmCfV3q0wRS6wmJxKvoE2gkHxsGoczhJ
         /5K5AaA5nw/2sN732nEodRXhCnKLFnYT5yJrQ0qOMhHy6PrjQkCJ35JlbYiyVp84K0cw
         SmGt/8EyMHKTKHlHvU/X7fkT9TDN0Fn5reuVtwjpU97t2dwjKat1ipESQkHYCt4GuMvK
         raiqKG0Z8wfd/Bl5Qgm9ljJvpzNt3rxK2ycWElCo5e4WxHd4n9yS4va87HQGHSgW4TTM
         XrUYH2cgZE/DF5IeUABBmZki8TpXeHoSZfkw8nGlXuFit+ZUU0IPfAAWOGhfKsvsDGXe
         t9uw==
X-Forwarded-Encrypted: i=1; AJvYcCVtWuRgSIyIemi4U4d4PayAX8IarCk/Tthh5M6xNSa3hrNMERuiv0zIPHgpt1yke9dZFIiOlHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8QQWNw1bdgW744R2+k3r42sjAf07W/HL9Ipdh+mTfBcraW9E
	MvVi0i8I5CelHytiwfrd7CnsfzsUhTcLxAf1leMYAbx0iokx4yGa0dps
X-Gm-Gg: ASbGncv0trKAbyHFjg0tCJn+/xqExS6lYxgHNChgWstrXb/mO0IaNxF+yR+TKdZY61N
	Z8cQg3q2uFZLDsE3QeXcuz2IOUJT8F5MyopwVxa+2SqeDhBhBtk2mKcWZLo9Uzfv8EcniJLn+D0
	Yz8fpL6gCYfyJhsQrAn1j7jgWpkmbA4HcVBolGy7BOTh+gmgpOg5isXE0yuZOLtsrq7E4qMvPwY
	cvbpdIRJc3MBLruDKO/7R0T55eqyUtwwDUo1+U0FCOHEIG2OXPL9NPrVtM2NzOZMc7V1W0fpc5P
	gN1bewdrVOuU3x24gM7kRXjC/8tajK9UiW5m1X8+viQxnlDtaSlWnWyrI9ibF31Gh5XAV6kpKN1
	eMZtOhCVjfwRnwCh3g99wo9jS2+3IPZt/TjteNY/HhJQ/BfnXgW5AI2MTlwTbIurxK89AEw==
X-Google-Smtp-Source: AGHT+IGvcsf3toU+LaPwtucP5SVemzEWWH5fHuCxK2RmWSazjOKx/X5c8wAzs0QR7fzYdKxgEdidSA==
X-Received: by 2002:a05:6214:f25:b0:707:4aa0:2f1 with SMTP id 6a1803df08f44-70af5cadff4mr45949546d6.16.1755177097591;
        Thu, 14 Aug 2025 06:11:37 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70adc1da2a2sm12990396d6.4.2025.08.14.06.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:11:36 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:11:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Ramaseuski <jramaseu@redhat.com>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 horms@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 sdf@fomichev.me, 
 ahmed.zaki@intel.com, 
 aleksander.lobakin@intel.com, 
 benoit.monin@gmx.fr, 
 willemb@google.com, 
 Jakub Ramaseuski <jramaseu@redhat.com>, 
 Tianhao Zhao <tizhao@redhat.com>, 
 Michal Schmidt <mschmidt@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <689de08861510_18aa6c29471@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250814105119.1525687-1-jramaseu@redhat.com>
References: <20250814105119.1525687-1-jramaseu@redhat.com>
Subject: Re: [PATCH net v3] net: gso: Forbid IPv6 TSO with extensions on
 devices with only IPV6_CSUM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Ramaseuski wrote:
> When performing Generic Segmentation Offload (GSO) on an IPv6 packet that
> contains extension headers, the kernel incorrectly requests checksum offload
> if the egress device only advertises NETIF_F_IPV6_CSUM feature, which has 
> a strict contract: it supports checksum offload only for plain TCP or UDP 
> over IPv6 and explicitly does not support packets with extension headers.
> The current GSO logic violates this contract by failing to disable the feature
> for packets with extension headers, such as those used in GREoIPv6 tunnels.
> 
> This violation results in the device being asked to perform an operation
> it cannot support, leading to a `skb_warn_bad_offload` warning and a collapse
> of network throughput. While device TSO/USO is correctly bypassed in favor
> of software GSO for these packets, the GSO stack must be explicitly told not 
> to request checksum offload.
> 
> Mask NETIF_F_IPV6_CSUM, NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4
> in gso_features_check if the IPv6 header contains extension headers to compute
> checksum in software.
> 
> The exception is a BIG TCP extension, which, as stated in commit
> 68e068cabd2c6c53 ("net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets"):
> "The feature is only enabled on devices that support BIG TCP TSO.
> The header is only present for PF_PACKET taps like tcpdump,
> and not transmitted by physical devices."
> 
> kernel log output (truncated):
> WARNING: CPU: 1 PID: 5273 at net/core/dev.c:3535 skb_warn_bad_offload+0x81/0x140
> ...
> Call Trace:
>  <TASK>
>  skb_checksum_help+0x12a/0x1f0
>  validate_xmit_skb+0x1a3/0x2d0
>  validate_xmit_skb_list+0x4f/0x80
>  sch_direct_xmit+0x1a2/0x380
>  __dev_xmit_skb+0x242/0x670
>  __dev_queue_xmit+0x3fc/0x7f0
>  ip6_finish_output2+0x25e/0x5d0
>  ip6_finish_output+0x1fc/0x3f0
>  ip6_tnl_xmit+0x608/0xc00 [ip6_tunnel]
>  ip6gre_tunnel_xmit+0x1c0/0x390 [ip6_gre]
>  dev_hard_start_xmit+0x63/0x1c0
>  __dev_queue_xmit+0x6d0/0x7f0
>  ip6_finish_output2+0x214/0x5d0
>  ip6_finish_output+0x1fc/0x3f0
>  ip6_xmit+0x2ca/0x6f0
>  ip6_finish_output+0x1fc/0x3f0
>  ip6_xmit+0x2ca/0x6f0
>  inet6_csk_xmit+0xeb/0x150
>  __tcp_transmit_skb+0x555/0xa80
>  tcp_write_xmit+0x32a/0xe90
>  tcp_sendmsg_locked+0x437/0x1110
>  tcp_sendmsg+0x2f/0x50
> ...
> skb linear:   00000000: e4 3d 1a 7d ec 30 e4 3d 1a 7e 5d 90 86 dd 60 0e
> skb linear:   00000010: 00 0a 1b 34 3c 40 20 11 00 00 00 00 00 00 00 00
> skb linear:   00000020: 00 00 00 00 00 12 20 11 00 00 00 00 00 00 00 00
> skb linear:   00000030: 00 00 00 00 00 11 2f 00 04 01 04 01 01 00 00 00
> skb linear:   00000040: 86 dd 60 0e 00 0a 1b 00 06 40 20 23 00 00 00 00
> skb linear:   00000050: 00 00 00 00 00 00 00 00 00 12 20 23 00 00 00 00
> skb linear:   00000060: 00 00 00 00 00 00 00 00 00 11 bf 96 14 51 13 f9
> skb linear:   00000070: ae 27 a0 a8 2b e3 80 18 00 40 5b 6f 00 00 01 01
> skb linear:   00000080: 08 0a 42 d4 50 d5 4b 70 f8 1a
> 
> Fixes: 04c20a9356f283da ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
> Reported-by: Tianhao Zhao <tizhao@redhat.com>
> Suggested-by: Michal Schmidt <mschmidt@redhat.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


