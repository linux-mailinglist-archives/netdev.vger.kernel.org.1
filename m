Return-Path: <netdev+bounces-65326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDE839FAC
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 03:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5821C211AC
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 02:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB615AF6;
	Wed, 24 Jan 2024 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aq7FXuMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B06101D0
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064867; cv=none; b=CBKRzGa9si21uaqKNsgA/NmUatAR/tM4pGGB+b6ZXJAKLPNIJpo9zs27KZty8q8KyYJdUDMY9luVqrH2sV0IBH/R0qLXZxXPok26cclMRounHKBkZQairfx1EKKuiQNGMks32h37BiysgpKnW6TfN4TBPW4y1HnV4vAdMSxeQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064867; c=relaxed/simple;
	bh=ZQ4vtsOIO+sx6pl2NLSWqLhdVeTyINduR6Wn0CldNr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0NP0e3IVBpg6qH/nBBybYvMEt8Bi6IU8y1zAX5NdJ+Igya1E8lUs13TNWK2KlTL80/FN6uOgEZcldIESBPp6txA/SGfH4ZaQn34FzomJ/dnpwJtjee7oMazmdOaWjJTFQ7zpqXS4GgYjOFtQhv6JMEWZQS8rmZQjpWVVyQnIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aq7FXuMq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4221125a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 18:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706064865; x=1706669665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWukwyy9wiRh1x6kV1LvOUsMPKDtwpdkTrjGMS5A3Oo=;
        b=aq7FXuMq5zc3MfM01RAbYwl1ioXTbXDq+YFczEKPiR7f8VTRBTeAUU6/2w6E47tmZd
         tnI4vrpVcDpdP5tmR+kgqHT2UIaEtd1VhklnJ9yEorxn6j2uip/lhNX/lIKYLfAguue0
         cRlEpdAnXAVNtRFCWxNSd/n2z6mlJnI4F1rmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064865; x=1706669665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWukwyy9wiRh1x6kV1LvOUsMPKDtwpdkTrjGMS5A3Oo=;
        b=tWHsJmlGENXhgPhaGsmjxlEoNmEo2LBQLmPCCprtmtIhjLke89ljPGkE1T4lRAhB3T
         TRnTRq6C/IacyC9ibhYiF5xZdmh1CPywiv9fwKcHOecXqX+GGMEREzNlnuUAy6bsJZb5
         f9jtVHdGG9YGNMXUSK8attBfA0u8355gsLkyfC0huIU8nkYD1uluu15YZmWmIk1+vYs6
         4C34NdEgqJFgjGzq0zbLRWCZT9QvX6Xly5VESfz7PwZJpAH893/V0CsNzqm4QSNSs4jK
         dy4Y5aRNX33Z2+4RwZBUahHcz0knyuLJyRGr1/JLsjhY+KKw2jys60pelHFXTWn6KLpR
         NUTQ==
X-Gm-Message-State: AOJu0Yx66fHcGAahUQrP077LHwwRWRMjm/oQI3xNZZtdPo+64nsvbqKX
	NNHHs9aQwU+Kgg4dwYv7XVuqhjOgBVx107DyG6a90zRswsWrucg9WCkwmPNF66uUbI7uuCCeQUd
	9SqVN81cySw94z41e7gFn2K+oOFV85gVeMBOCJ+Uk4X0ymWainv3Co+nrRoEBobGuYUD+kAMXmv
	0nATVoCgNdQgYKsTPoxFVrSUqY2unjd2q5gPw=
X-Google-Smtp-Source: AGHT+IHMoaRwDr49eBfpainoclB+KoIk9MjYaRHB8b3w7efiNB/8gEpuMNNGT1DWzOdBHaOkiXdl+Q==
X-Received: by 2002:a05:6a20:748c:b0:19a:542e:e56e with SMTP id p12-20020a056a20748c00b0019a542ee56emr243005pzd.23.1706064864661;
        Tue, 23 Jan 2024 18:54:24 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm12974229pfg.32.2024.01.23.18.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:54:24 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next 0/3] Per epoll context busy poll support
Date: Wed, 24 Jan 2024 02:53:56 +0000
Message-Id: <20240124025359.11419-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
epoll with socket fds.") by allowing user applications to enable
epoll-based busy polling and set a busy poll packet budget on a per epoll
context basis.

To allow for this, two ioctls have been added for epoll contexts for
getting and setting a new struct, struct epoll_params.

This makes epoll-based busy polling much more usable for user
applications than the current system-wide sysctl and hardcoded budget.

Longer explanation:

Presently epoll has support for a very useful form of busy poll based on
the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).

This form of busy poll allows epoll_wait to drive NAPI packet processing
which allows for a few interesting user application designs which can
reduce latency and also potentially improve L2/L3 cache hit rates by
deferring NAPI until userland has finished its work.

The documentation available on this is, IMHO, a bit confusing so please
allow me to explain how one might use this:

1. Ensure each application thread has its own epoll instance mapping
1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
direct connections with specific dest ports to these queues.

2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
polling will occur. This can help avoid the userland app from being
pre-empted by a hard IRQ while userland is running. Note this means that
userland must take care to call epoll_wait and not take too long in
userland since it now drives NAPI via epoll_wait.

3. Ensure that all incoming connections added to an epoll instance
have the same NAPI ID. This can be done with a BPF filter when
SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
accept thread is used which dispatches incoming connections to threads.

4. Lastly, busy poll must be enabled via a sysctl
(/proc/sys/net/core/busy_poll).

The unfortunate part about step 4 above is that this enables busy poll
system-wide which affects all user applications on the system,
including epoll-based network applications which were not intended to
be used this way or applications where increased CPU usage for lower
latency network processing is unnecessary or not desirable.

If the user wants to run one low latency epoll-based server application
with epoll-based busy poll, but would like to run the rest of the
applications on the system (which may also use epoll) without busy poll,
this system-wide sysctl presents a significant problem.

This change preserves the system-wide sysctl, but adds a mechanism (via
ioctl) to enable or disable busy poll for epoll contexts as needed by
individual applications, making epoll-based busy poll more usable.

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20170324170836.15226.87178.stgit@localhost.localdomain/

Joe Damato (3):
  eventpoll: support busy poll per epoll instance
  eventpoll: Add per-epoll busy poll packet budget
  eventpoll: Add epoll ioctl for epoll_params

 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventpoll.c                                | 99 ++++++++++++++++++-
 include/uapi/linux/eventpoll.h                | 12 +++
 3 files changed, 107 insertions(+), 5 deletions(-)

-- 
2.25.1


