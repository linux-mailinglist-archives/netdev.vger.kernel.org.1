Return-Path: <netdev+bounces-224068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA21B80709
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496621C26ADE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF91333A95;
	Wed, 17 Sep 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQk7Lg4c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773FE330D36
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121308; cv=none; b=LC+8I8ho7PI8/Jhvn17DAXbDdXJ8sU/aQN12nksFZeS+yfSUGPOnsuAUOC6P9lUPVreNim5S4VXOjXP2KPguG78C56v2g0OT3Bnfai/7naU9yaHqva8lo4BN5Cot40iVXuJt6PcptLJiRzl10IEg6lEXmfCoDVBXrxru6RMPGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121308; c=relaxed/simple;
	bh=Y+BsLrd1iKzoubJQM3u5yHO8IjgvV59hojXWBnbW0zk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o5ZTe1GHIuYayqY4IVI3KyeQsqXivbm1YX0203WSwGYS0A47Vl4SX3hUf7pRNpaT+zzcT7PtlhTZywZJxyDkKmMqPhXfuwL6Rb9q4hzJKw8HgGAtyf3O9YZbGxnseKbQ3tsV434GSzW4kUxUp0cE/g1RdUhseczL0+6tlWD1v2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQk7Lg4c; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78f15d58576so5054386d6.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121306; x=1758726106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsHXyi0A+MHSWsRskOX0flgPTU1OVERvZwHTTn6sBVk=;
        b=SQk7Lg4cKiLbo7vAEl43H0YHLEqGZMBvPiEQN387P4Zy7bTEVUa4pWBGduKXAzkyDU
         RRVks4Ey2Nw4qtSrRCfOV3mCM+N/VRuP5o99qcvceD/zcxShCaP5ZwXEkpoyNeRpbS59
         MUE7oEavb/FPymmTbmRRKVgCI42prCWnOwYFwfMoOKrrXeet8eBdtInVGVy8wKwc0Tm4
         C1loBFpSM+h/Qrtrby09hXbfSB3x9klMSpkXx22CX9TxbzfLS8lae5KaAwI17lxBC1p8
         MVmxdII9JPoxMm+cwC3Lq8hSYk2mIsAwj0gEp38z+0JupWJsPJ5FQ+1VaD2dYPqBQTms
         5pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121306; x=1758726106;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bsHXyi0A+MHSWsRskOX0flgPTU1OVERvZwHTTn6sBVk=;
        b=Ivctxl5eSbMfIYbM7O0quelP43r7q6ue54lBVuJPQplx9S7GZgHJJW0SZdW2iIhDn+
         EFtdwxfRsk7sV/aiU4S1VRGnJEb62l2Qr2RZelpkONoscUwsrpJ3x1vcvnQ9xuMO+C09
         pXVKfxtYQIfjDzZMno8t76jkLNhBg+NeWbmbKnXIuKwcP8B9m1U6jbN6RGMmPrWiTKnb
         MtY/rohTyry7JS7+J4OUymalbwJztCGqDotxK6XLd8m418xpTUnJhQmVIu5gnctmGt9N
         b6mMmPdlqpEwdT8OWGwLo3rnlIKlkpTtc9Glt/x+xnWWgZhPCHgcXRNjnnVSdSYQtIoM
         07BA==
X-Forwarded-Encrypted: i=1; AJvYcCXO43BG3wT8sZ8LzObUs8/rJ6Y03NqtggMxqSsP6hhFVNxWGlbyOs9033UNslGeL/Yo8XnkkN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKdCO3yiPWzhJH/X9WvWwMW5tnx3ydX4WNU1KnRZ/10PnvKss
	iLFcaBNs27+1wvhz8HiFd+K1afuHepR/QOKgX1odDBjmFIUPQ+uw7uF+CODaWQ==
X-Gm-Gg: ASbGncup0bkJKstnIlL+Pd+ZRV/+mEyq8soJoplCXAmu6OkoI8bQM3scGSApp1r/mrZ
	v98bxFDPTS7Xhy0VbYO9y8QSPvIot6DMf1gZzceUtqRD8ViQxsfM790JTYwcjUy/Y/F17xw0EWr
	ZBv02O+G4Ee5UABxgdzLUNJpYAHHV/OWofd3+pI4N1CyWlOjdIk51tcRTeFhw370Rnkq3QWcDVb
	dQGggKLjXqClxD/mB+gcSRM+t0HOv84YWh22gPhCr+DUWOzng2+4DlxDO4mlMXfLxOIFTcpxwha
	U7qbvbObYoqUvWTEjujoSjhTmt0uwDbXwLiMo0Chk5ar1fi0YyErQDZPEjcizOPALCnDtUU9dtr
	zkAuy8hTWngsjKXmsDFsjntb8SGq2pjJxGUoJxsEOySrOI6MughcLb0lDXtTz4mhlX8D8weNeqT
	nAdYvaoYRPR30M
X-Google-Smtp-Source: AGHT+IHlOs6AAO7T9N4dZMj6Tw5FBYmJpKwa/dUwqiFSpzHJ8cgjE9tHsgU53My3jQGcU/pAkQtj0Q==
X-Received: by 2002:ad4:5ae8:0:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-78ec684d600mr24172086d6.24.1758121305576;
        Wed, 17 Sep 2025 08:01:45 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7868144a49csm47958516d6.39.2025.09.17.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:01:44 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:01:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.a51d1cd6f43c@gmail.com>
In-Reply-To: <20250916160951.541279-8-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-8-edumazet@google.com>
Subject: Re: [PATCH net-next 07/10] net: group sk_backlog and sk_receive_queue
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
> UDP receivers suffer from sk_rmem_alloc updates,
> currently sharing a cache line with fields that
> need to be read-mostly (sock_read_rx group):
> 
> 1) RFS enabled hosts read sk_napi_id
> from __udpv6_queue_rcv_skb().
> 
> 2) sk->sk_rcvbuf is read from __udp_enqueue_schedule_skb()
> 
> /* --- cacheline 3 boundary (192 bytes) --- */
> struct {
>     atomic_t           rmem_alloc;           /*  0xc0   0x4 */   // Oops
>     int                len;                  /*  0xc4   0x4 */
>     struct sk_buff *   head;                 /*  0xc8   0x8 */
>     struct sk_buff *   tail;                 /*  0xd0   0x8 */
> } sk_backlog;                                /*  0xc0  0x18 */
> __u8                       __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
> __u8                       __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
> struct dst_entry *         sk_rx_dst;        /*  0xd8   0x8 */
> int                        sk_rx_dst_ifindex;/*  0xe0   0x4 */
> u32                        sk_rx_dst_cookie; /*  0xe4   0x4 */
> unsigned int               sk_ll_usec;       /*  0xe8   0x4 */
> unsigned int               sk_napi_id;       /*  0xec   0x4 */
> u16                        sk_busy_poll_budget;/*  0xf0   0x2 */
> u8                         sk_prefer_busy_poll;/*  0xf2   0x1 */
> u8                         sk_userlocks;     /*  0xf3   0x1 */
> int                        sk_rcvbuf;        /*  0xf4   0x4 */
> struct sk_filter *         sk_filter;        /*  0xf8   0x8 */
> 
> Move sk_error (which is less often dirtied) there.
> 
> Alternative would be to cache align sock_read_rx but
> this has more implications/risks.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

