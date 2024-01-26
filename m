Return-Path: <netdev+bounces-66196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DDD83DE11
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 16:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7112B213D1
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A351CFBC;
	Fri, 26 Jan 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="JydDJpU/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9B1D52D
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284514; cv=none; b=HDdgqX0M0/rDAfDWt+APogvAoIqRxeXsAZ6JthceKHwMSit8SJdIDS0SQ9OXlc34hE8AIpnfiuPJwrseeWxllOArBOOy2p/w5DMGnSTH5ftQVPOYnmFrFyaBjVOkBBTQYFbNiQe2gQShfcTO2/vpuiEwqmm5i9dt9Uurhx4EqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284514; c=relaxed/simple;
	bh=3lYgZp347K4vTTTOiB2qjtOQzvKBmqK24fKo8PVGArY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=u2uk44sYa9hZGfV0dLYkIhx5Z1u5KBFuTKqeiUJXA17o+dkd+s59ZQF6wt0VMtboFtCJnm4/0nN4D3BjJ0UbXDJr5D6jVHiOPqIIEogoZb8p3Z1m3zT7A716hFlWbXyK9/TsFk/VfkqtM+OFc0ZoIng6yXgnKMSqU/vlO4D1MEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=JydDJpU/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso9422355e9.3
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1706284510; x=1706889310; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3lYgZp347K4vTTTOiB2qjtOQzvKBmqK24fKo8PVGArY=;
        b=JydDJpU/ZKQ5smFhLzxlmRbAnz8hv412Y96oVnxe4lbm0yzeU8/1UPIgRKqgoUywBT
         i9KYfR+EJ9uXT+TWhAntkcyTCYZJRfSRLo3cgBimTbS7DG5n4sYDPe3Csr4suVQMw3hN
         IMvTiyEZleDR5cEOPpK3NGFR2pKuxXAYRwaiVsygVtX1qEcD04NJ1TB+ZrLxlT74IgWX
         lf2CTPO7MOHZ1RshGX+sDCFXt19QU+DGoNGRg3BKLdcBE8kUaZV/9pwCa5o+vu6faSyd
         OzUnMY2JdZpT9qfuEMR/p0FuBuZFTkbpfM1NQ5bxowyj5xnh7TsoLT9jkyglUbKb4YW3
         VesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706284510; x=1706889310;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lYgZp347K4vTTTOiB2qjtOQzvKBmqK24fKo8PVGArY=;
        b=NjgKCIZK2xLWCHnaI3ghdFTNm9pl6sR9RfykTo+iphGZ2DSDmyGplfQ+uTjPo1T9kQ
         6KLyhJ2Dx1uxT0ytxLxBzU4vrN9sO1EMX7dXpJ9w4ilasYpvtu2MRY1Nyl3v358gxokP
         bR+VJRX6WPRIev15mGbKlt5NiFEzoXZx48nBjhc0PHkemo5xjjfrmz8RdBqNn4dAtSro
         jirc9fVOTGfVHFJkF1NuxBfPZMH4gBPo26omRYEyg1KNlCPJxxJHdeH4g4qpBghFkYni
         Z4KzhceL4lMB/iYBga1j4VYQV6UXv7c0UZb05MeQ3APQNqF/t/yoqADMb2L5Xh/zaeqm
         7fzw==
X-Gm-Message-State: AOJu0YzLdnFjfApvbhoFmuLVN7lc85zELkEKqRppP060hhYw4aYliRjN
	ZhLjDYTzmUZPW4NRaGV92WayHrNwnPUcKnPSEMQPqe1OpoxUiSg+gK07FAEFNF/HkM/mjapLrCl
	77Io5ExDw+8n7LiIPT2Y2x2ihDQt2/aR3wdMuAFR897OEMmVGnK4=
X-Google-Smtp-Source: AGHT+IFkQt5nIqW+dbgjyXjH5Xw4PEm1cQcBJxc08p2lx3fOD9Cpo3POMOBgKNe/rC7fcoRRD7AsfCUqRB8gmpoBE+c=
X-Received: by 2002:a05:600c:b97:b0:40e:da5f:7152 with SMTP id
 fl23-20020a05600c0b9700b0040eda5f7152mr734056wmb.239.1706284509890; Fri, 26
 Jan 2024 07:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pavel Vazharov <pavel@x3me.net>
Date: Fri, 26 Jan 2024 17:54:59 +0200
Message-ID: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
Subject: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

We've a DPDK application which runs on top of XDP sockets, using the
DPDK AF_XDP driver. It was a pure DPDK application but lately it was
migrated to run on top of XDP sockets because we need to split the
traffic entering the machine between the DPDK application and other
"standard-Linux" applications running on the same machine.
The application seems to work OK when working on a single port.
However, running on the interfaces behind a bonding device causes the
remote device (switch) to start reporting: "The member of the LACP
mode Eth-Trunk interface received an abnormal LACPDU, which may be
caused by optical fiber misconnection" and the bonding stops working.
Note that the application needs to work with multiple queues and thus
the XDP sockets are not bound to the bonding device but to the
physical interfaces behind the bonding device. As far as I checked the
bonding device supports binding only a single XDP socket and makes it
unusable for our purposes.
In the concrete example, there are 3 physical ports in bonding and
each port is set up to have 16 Rx/Tx (combined) queues. The
application (the DPDK layer) opens an XDP socket for each queue of the
physical ports (Basically the DPDK layer creates 3 virtual af_xdp
devices and each one of them has Rx/Tx 16 queues where each queue is
actually an XDP socket). I've run the application in different
threading scenarios but each one of them exhibit the above problem:
- single thread - where all of the Rx/Tx on the queues is handled by a
single thread
- two threads - where the first thread handles Rx/Tx on (dev:0
queues:0-15) and (dev:1 queues:0-7) and the second thread handles
Rx/Tx on (dev:1 queues:8-15) and (dev:2 queues:0-15).
- three threads - where the first thread handles Rx/Tx on (dev:0
queues:0-15), the second thread handles Rx/Tx on (dev:1 queues:0-15),
the third thread handles Rx/Tx on (dev:2 queues:0-15).
I've tried with and without busy polling in the above threading
schemes and the problem was still there.

Related to the above, I've the following questions:
1. Is it possible to use multiple XDP sockets with a bonding device? I
mean, if we use the above example, will it be possible to open 16 XDP
sockets on top of the bonding device which has 3 ports and each have
16 Rx/Tx queues.
2. If point 1 is not possible then is the above scheme supposed to
work in general or is it not right to bind the XDP sockets to the
queues of the underlying physical ports?
3. If the above scheme is supposed to work then is the bonding logic
(LACP management traffic) affected by the access pattern of the XDP
sockets? I mean, the order of Rx/Tx operations on the XDP sockets or
something like that.

Any other advice on what I should check again or change or research is
greatly appreciated.

Regards,
Pavel.

