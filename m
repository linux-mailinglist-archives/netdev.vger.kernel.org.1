Return-Path: <netdev+bounces-116653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93594B512
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242EF2817F6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EFBC8D1;
	Thu,  8 Aug 2024 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em3wgmc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AE8BE5
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084200; cv=none; b=VZCHs6K3O/mYiDupVekKOTiZ6+w/csQDUZA3+Q6nMX1gjjfvMD9PyamToypQGjb3q82xHXkzX0/sZbNMOvUJ07dTVUDkv1V8GKftV7/NQuta6DYu+IyNqqLCGi8CVkIk2jqA0si2HWK5HKUQrEh6b5OTbDJGpmxuSOuOaP8wiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084200; c=relaxed/simple;
	bh=IVqNr+aMwLd8I/8SpYBJvA8V5hy+rtYoAojADDWg86Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ASns7On5Qn058upV42lPSyQmXAFSKnzC82shWy3yHqUZenS2Deij0CCd2tRaPuJi7/d2YjaIXxZNyh/Jcxk9F2FyfkQ3CAPNjn/cpRs7qpRXaKY4H5xr5pi+XxoQP3e3Dd3G1mv1GHNuSno3Q6pB+U4VaTmQNNUIuTYwddnRDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em3wgmc+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1e2ac1ee5so32250885a.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 19:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723084198; x=1723688998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TrG5oaVdSR3UOzdTlaqQCiGjNT8seImWkvwB9H/RbY=;
        b=em3wgmc+pO4Lhzw0+VnR5t6F/EfuNjPbPXrVlubtFD3HYQBfV88N03kN3gz/S2XCUA
         tpkkW3RIjnNL2GSEND/ivhI3H5pBxXn9ws6YtYJU5n27GN9ZCc2aqWO0k4d9whqUNGKY
         8N03YnqPTZvB+XWAvN1N2Kd70awr+MaSdPtGN073q38T/bu4vrV4JxO+ze4uAOs8JulE
         +xXZtlKsOv0ml7VF3Wqn2Vf9LgeG42M/7y8+zUVbAKHb21sakYC1W9tHieyjT9YAr6MM
         oQHa+1y+mElo4k1YzCZjNEOm6+Kp6zcShpA5Qez9C/C5A2jTcEOG1RztIo5goQqKcqOk
         PU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723084198; x=1723688998;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2TrG5oaVdSR3UOzdTlaqQCiGjNT8seImWkvwB9H/RbY=;
        b=bIYwCOfejEUsKKYdj4zy5VDH8J6XnOzSU9EsGWUcOMijfP/KgUz3ai6z95WrXlAoT8
         Y6+kWbGeo7RuzcQ0/biMKU7w+kVkKbli2zHkVTUIf+MWdDiHRnMNzTk8mLwAJNZw1ud0
         qykLlQW0bc/XNRkBTHo+6jJMVnrUQSVIZX0a0KLYAMhBUFb0FRpjbIxBOqlWbaSlM11z
         pE3WrOTMbYBfK90+ReAKD7pVOYmLEROlC4T5kWPu2Ud/ehGXdJvEmZOoaYC78hEDuQDc
         zgSf22+OyAD3wHk2L6BPq7YGfs1s35Zrs6pmyV6IMyM5tdVzqGIfu7OmmvBknB704J6w
         CdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR7FxfELtn/wY8j9L4ezLPw6HcDiXPmorEcQnJjgJvFAQxs2PuS+g0gWinrTYWt9blT06ep6gKtnvZUw8BWf850U9b2PCo
X-Gm-Message-State: AOJu0YwNWz/GaX/Dv82emNiinEI+0rgjVUUxQU3jsHNded+pBpc3r8zI
	HVNJgjytdTd8wrcZpy1CZl8cgFlNt/2w+rGQpfBK+NfhRM/orWfE
X-Google-Smtp-Source: AGHT+IGVlMGNrfJ60VeiiIxKX2NU93+ZKazDm3CfCjTLDvM16t7DHwRF+McwoiwHk0CIRzPibbaX8A==
X-Received: by 2002:a05:620a:2a13:b0:7a2:16d:8428 with SMTP id af79cd13be357-7a3817f395emr59570185a.27.1723084197685;
        Wed, 07 Aug 2024 19:29:57 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785cfc23sm113869485a.13.2024.08.07.19.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 19:29:57 -0700 (PDT)
Date: Wed, 07 Aug 2024 22:29:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Message-ID: <66b42da5dc64_379500294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240807-udp-gso-egress-from-tunnel-v3-2-8828d93c5b45@cloudflare.com>
References: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
 <20240807-udp-gso-egress-from-tunnel-v3-2-8828d93c5b45@cloudflare.com>
Subject: Re: [PATCH net v3 2/3] udp: Fall back to software USO if IPv6
 extension headers are present
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> In commit 10154dbded6d ("udp: Allow GSO transmit from devices with no
> checksum offload") we have intentionally allowed UDP GSO packets marked
> CHECKSUM_NONE to pass to the GSO stack, so that they can be segmented and
> checksummed by a software fallback when the egress device lacks these
> features.
> 
> What was not taken into consideration is that a CHECKSUM_NONE skb can be
> handed over to the GSO stack also when the egress device advertises the
> tx-udp-segmentation / NETIF_F_GSO_UDP_L4 feature.
> 
> This will happen when there are IPv6 extension headers present, which we
> check for in __ip6_append_data(). Syzbot has discovered this scenario,
> producing a warning as below:
> 
>   ip6tnl0: caps=(0x00000006401d7869, 0x00000006401d7869)
>   WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
>   Modules linked in:
>   CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkaller-01603-g80ab5445da62 #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
>   RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
>   [...]
>   Call Trace:
>    <TASK>
>    __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
>    skb_gso_segment include/net/gso.h:83 [inline]
>    validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
>    __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
>    neigh_output include/net/neighbour.h:542 [inline]
>    ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
>    ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>    ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
>    udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
>    udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
>    sock_sendmsg_nosec net/socket.c:730 [inline]
>    __sock_sendmsg+0xef/0x270 net/socket.c:745
>    ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>    ___sys_sendmsg net/socket.c:2639 [inline]
>    __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
>    __do_sys_sendmmsg net/socket.c:2754 [inline]
>    __se_sys_sendmmsg net/socket.c:2751 [inline]
>    __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    [...]
>    </TASK>
> 
> We are hitting the bad offload warning because when an egress device is
> capable of handling segmentation offload requested by
> skb_shinfo(skb)->gso_type, the chain of gso_segment callbacks won't produce
> any segment skbs and return NULL. See the skb_gso_ok() branch in
> {__udp,tcp,sctp}_gso_segment helpers.
> 
> To fix it, force a fallback to software USO when processing a packet with
> IPv6 extension headers, since we don't know if these can checksummed by
> all devices which offer USO.
> 
> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000e1609a061d5330ce@google.com/
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


