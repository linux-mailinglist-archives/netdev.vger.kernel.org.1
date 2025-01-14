Return-Path: <netdev+bounces-158047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4ECA103D0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D75D3A6887
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38722DC4E;
	Tue, 14 Jan 2025 10:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E01CF2B7;
	Tue, 14 Jan 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849783; cv=none; b=kdEopM1kE8F1BwyIwMsFx4pLZ5YGGVBTMrsYNCypkgZBphfP6VGIQc9SajQFYbI5aSDgBZe4w3fI35IU+INDAEp4bw+Dae7Fb+SipBV8ELAP4UnZZyzZFkOEyyN5YkPGf/Bt+yrPKU16gztQK8e3RnfbbBmnWoeCQsjpHhiM9IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849783; c=relaxed/simple;
	bh=fNg5HidGBGqFliielqciKKgUH8tUnrPivQUJC60lWfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKmKblFoxjVQOSCATdF9K4ulo34BTZjThGkBOConz0uC3gnx2blVqEy5auwXFqdVNfR3eJ39vde1xS5Wx/gYnQxVYW8EInWrC500w7jVv5E41KS23v9DxWR5nDRwyqHaOSMSdU+nGj3Rk3pqpLmo4UVGZ9QhSHSOZYbdkl8SmcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so1554322a12.1;
        Tue, 14 Jan 2025 02:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736849780; x=1737454580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3M/EuPkWhuotENbUi5KYCJdNOIMqVY69BdheypEnLE=;
        b=EcajSNJN39WhT780Jw+ep5fGBKaidDiAsBjXfDs/tANYfS2ytK24HZIBQt13H1hNKn
         NhiSBtbD0rjP4chn1iHGFYUIoDsJQ2KfaFJarH1nm38HnJHWavQoqcvmo0Jcetl3suyD
         F7M0JJJwliJDd/cX4H2mkMv/HQBrJ2E7Hb65mBDFVkg5ZjdIH5st+KxMjUZ0qO5U69LE
         Wr8//5ftguu7EpIIsJypnLG0wj/uv7ST9Vb4btwq13CEECt7dOjz1gWnKqapoHsXsePO
         yaw3hkfIpqyjSpBkD7oPFGmS2gwkm04F3x/9Qb6a2wOtlcydD6R/cAH/Ik8OQpLjjC0i
         ZFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPa0dssAjaVxzF/6pZXzcwEveUQVB5u2Ws+NpHs83vmniKYSTChsL3FJpwkOTIRWxBYUYMw/OK@vger.kernel.org, AJvYcCXes2a4YznPFusyk7NnjUYinEspqEhfxji4eZkEYjeb1C6Wp/GGcLwf6M6BFYIllin//HYeaUIN+ILczx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz27xr1zkBLdwBv1X++CSJI3NaU9sdyvRDKldIBJCvq55Hn6pI
	EqHBiAP/QPNT2jI5pMZFKoSwNsA455UVxwtNll7y80XvilQ0YZfg
X-Gm-Gg: ASbGncuVUIj0w4xOy36alduObfQrwLl4Il4T9aIlGGADJ3WL9IAWKxWf+ixXmAFXMKR
	rjOCPHMbDp4jvnFPx8yxN+6urGOGvfCqs9R4SMKWnyKENnzZnpHCP2GcLznODiP8Yh2n8O4nUWs
	D2VFGKXcwBX4GSbe1TS9DSLNE9aFkIZd3h+9N4vlEniAKV0P1bfiM2AnQzqJoTMVDTRk2E1peJe
	orRoa56Brd9pPrcPlkN5bntfQ0jPWvnrJYcgHPvSl5WsZY=
X-Google-Smtp-Source: AGHT+IGx8jXT0N9hZjm65ONyDqdjyj7thTGtcsqEjcdVX/o14kSPOlOxR8q/tXF67ytjSVf8tC8Kzg==
X-Received: by 2002:a17:906:99c2:b0:aa6:938a:3c40 with SMTP id a640c23a62f3a-ab2c3d4d2c5mr1769852966b.24.1736849778240;
        Tue, 14 Jan 2025 02:16:18 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060533sm612217066b.23.2025.01.14.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:16:17 -0800 (PST)
Date: Tue, 14 Jan 2025 02:16:15 -0800
From: Breno Leitao <leitao@debian.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net v3] net: netpoll: ensure skb_pool list is always
 initialized
Message-ID: <20250114-bouncy-groundhog-of-aurora-18e5f1@leitao>
References: <20250113-spotted-independent-kittiwake-309cab@leitao>
 <20250114011354.2096812-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114011354.2096812-1-jsperbeck@google.com>

On Mon, Jan 13, 2025 at 05:13:54PM -0800, John Sperbeck wrote:
> When __netpoll_setup() is called directly, instead of through
> netpoll_setup(), the np->skb_pool list head isn't initialized.
> If skb_pool_flush() is later called, then we hit a NULL pointer
> in skb_queue_purge_reason().  This can be seen with this repro,
> when CONFIG_NETCONSOLE is enabled as a module:
> 
>     ip tuntap add mode tap tap0
>     ip link add name br0 type bridge
>     ip link set dev tap0 master br0
>     modprobe netconsole netconsole=4444@10.0.0.1/br0,9353@10.0.0.2/
>     rmmod netconsole
> 
> The backtrace is:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000008
>     #PF: supervisor write access in kernel mode
>     #PF: error_code(0x0002) - not-present page
>     ... ... ...
>     Call Trace:
>      <TASK>
>      __netpoll_free+0xa5/0xf0
>      br_netpoll_cleanup+0x43/0x50 [bridge]
>      do_netpoll_cleanup+0x43/0xc0
>      netconsole_netdev_event+0x1e3/0x300 [netconsole]
>      unregister_netdevice_notifier+0xd9/0x150
>      cleanup_module+0x45/0x920 [netconsole]
>      __se_sys_delete_module+0x205/0x290
>      do_syscall_64+0x70/0x150
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Move the skb_pool list setup and initial skb fill into __netpoll_setup().
> 
> Fixes: 221a9c1df790 ("net: netpoll: Individualize the skb pool")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

