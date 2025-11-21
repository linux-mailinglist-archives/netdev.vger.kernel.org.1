Return-Path: <netdev+bounces-240847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39AC7B20B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62BF934D5DF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC834FF73;
	Fri, 21 Nov 2025 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw7BZvT6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8134FF40
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747349; cv=none; b=nD/EG9dfz06cVkqjT0AegTvWDSL1i4NMXVo68otRZHObC3Xh9KaJuc6BG1mwL5lt6/7kzNpPL80dpSaJwYPyVAuwdP3gWmzCZLdlgMCs1MPIclxvF4rLEYWmeqS7PPDZ0MDdAp5ai2hJpSx3FSdj2tUnzZ17/cS5ur+OVE91JSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747349; c=relaxed/simple;
	bh=bbpHoxgmqkgEJqHNWPVdMBw27oGNmoNKaCdnnuCAO/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhhMY2Ou28g5BZmX7VliFF+H1UjhYZXz9myGmEMrO19ikyzZxZXWDhJZ10AmDe9c7xS+n4HhQci5mnOIY1vwdxTMCpNpi+h0utFu0DpiYLXsDLY4PopLkTEV9CV2EQTZ3yu0tAli2pTmKtg78b/f/fnN8gAFLitKoDfLIXp3QZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw7BZvT6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso3196816a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763747344; x=1764352144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8ErBzqTgP4cHYgJVQfDWaPxezOQKn0ALUTf491LHzg=;
        b=dw7BZvT6sjuKYNyxxv74lLzOpvQPySmRZbs1+/GgmVgbpIAxCeNFAxqF3XF3IHyFhf
         7hzxrfuDE2E+P9nvKzYyAPDayT5pzCcpVs1ibT+dKoJoWirAC42tmko6d2FTiE26kLn1
         RnYtp5Zcn7SkH5+QEfcnQeLhVG/Ksz03wO1j1HxisS+VByZm7pdjlLwnXrXVPpyP1DAy
         W/ep2NxcKjH7plxE/oQ7o/7FjhOsihAZUJXtjL66q8vj6/EIDJEfUxt611+NLJFqThcd
         RPUpTYqzaEVsWSEVO7FHT2bGrNBFlA1jE3CIsXtaHXNR6as3tYaqa3jqEiv7J46Y05FL
         PJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747344; x=1764352144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8ErBzqTgP4cHYgJVQfDWaPxezOQKn0ALUTf491LHzg=;
        b=MQG9lzMKrcFpHGwcexGlvrMNaml2NLDTasME2DsinphgkFjjnC1qLxelv9dUQdpylh
         EV+FsMpgPPWsCVr+6BUA9qqmvZL5NJlyhaYpBnLXH/qMLJhwD315lFUQuNy5Eq94zx0B
         SyYH5IdiNyJhyBh6x9arT2DTXKyQn0Z2qzqp0UBuHJrL5qeNOqCBNw6mZc3Vaecz3G2Q
         6S9bf38RUwB6N3ZfQ2d/CGtUPwPEX6I4dIdOdk+1BGqVEEQ74z2lHuUexU4Gx/ZMXuu+
         l7KsKK4sOYOjU3hS1sw+u+ArwpForTpT0NESpeLjJN8o9vwkPTHUX/EdkuHkICSov2WA
         3bVA==
X-Forwarded-Encrypted: i=1; AJvYcCVqscdN7ouMsF1SrvJVKe3FxMT/iCPh0VDeG5+3fjzfbM+4zHPJz4idgUXNYFOIexYVC7Ftnos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1Rv0J4b15To/M5xc/mLgDNSsI+lyasa0+gefoAqPI+I8pvEy
	jcFo3fkNhLke+APBkzEKmLfhO049RxKHjVrCw2ple/p7F3y5/0R6XcoZjVerlf8TESLXQAJYP4X
	CUBNN42JwuSDycgyS/k+ATJNp+jB6iDA=
X-Gm-Gg: ASbGnctMhnr1wJ3iXlzR4IgQYhBztn1rus8UOnr9ua4KqsMvHVuUWEC6PHH/59PJ9pv
	ca5ybnyBfC3pvEHYSwlH/EkM5GCnVffYcswJotdaVuucrdlijCghFXVBeml9ZgbUOd+g1A9DXE3
	WxRHlYrJ11O4FXtaZQTw5Yd2eOLp+mO3j/gxTpzxDmrH4ICkD3TdMrq/SegzT+el/RMv7yuYFd0
	LReOU2z+/7lHhweoQIneHw969lB/aF0cyoJLbinFOzfuC5mvF1DLa9WazyKG2FWaaZK8W/v62rU
	PcCsTuIcJmj1H/p61ZW6LFh3sCji
X-Google-Smtp-Source: AGHT+IE4GS79sSxW/Rd4Ohj496vpRoSTu+pKqkj/hZLDMt5SoW5D+KLGWEEIKTW5/CgPvJlUkWdvl5lidG3EzaU5/BE=
X-Received: by 2002:a05:6402:35cc:b0:640:c918:e3b with SMTP id
 4fb4d7f45d1cf-64554676c63mr2972912a12.26.1763747344224; Fri, 21 Nov 2025
 09:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120141354.355059-1-viswanathiyyappan@gmail.com> <20251120071715.28a47b21@kernel.org>
In-Reply-To: <20251120071715.28a47b21@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Fri, 21 Nov 2025 23:18:51 +0530
X-Gm-Features: AWmQ_bnsZ7DyviHAe10zuie-93KQZaGmhmfWVwmmKuclxNtRbUQFHAMN1h6UQus
Message-ID: <CAPrAcgN=RwA5j_hCwHAdSTwyfj5jignvaZ0nNidFqYaY_VeRxA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/2] net: Split ndo_set_rx_mode into snapshot
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, 
	skhawaja@google.com, aleksander.lobakin@intel.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 20:47, Jakub Kicinski <kuba@kernel.org> wrote:

> Running
>
> make -C tools/testing/selftests TARGETS="drivers/net/virtio_net" run_tests

This bug seems to be caused by a call to probe() followed by remove()
without ever calling
dev_open() as dev->rx_mode_ctx is allocated there. Modifying
netif_rx_mode_flush_work()
to call flush_work only when netif_running() is true, seems to fix
this specific bug.

However, I found the following deadlock while trying to reproduce that:

dev_close():
    rtnl_lock();
    cancel_work_sync(); // wait for netif_rx_mode_write_active to complete

netif_rx_mode_write_active(): // From work item

    rtnl_lock(); // Wait for the rtnl lock to be released

I can't find a good way to solve this without changing alloc logic to
be partly in
alloc_netdev_mqs since we need the work struct to be alive after
closing. Does this
look good if that's really the most reasonable solution:

struct netif_rx_mode_ctx *rx_mode_ctx;

struct netif_rx_mode_ctx {
    struct work_struct rx_mode_work;
    struct netif_rx_mode_active_ctx *active_ctx;
    int state;
}

struct netif_rx_mode_active_ctx {
        struct net_device               *dev;
        struct netif_rx_mode_config     *ready;
        struct netif_rx_mode_config     *pending;
}

rx_mode_ctx will be handled in alloc_netdev_mqs()/free_netdev() while active_ctx
will be handled in dev_open()/dev_close()

Never call flush_work/cancel_work_sync for this work in core
as that is a guaranteed deadlock because of how everything is serialized

