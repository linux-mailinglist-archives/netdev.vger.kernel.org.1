Return-Path: <netdev+bounces-230912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976CBF1A15
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E98423EA8
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CCE31D399;
	Mon, 20 Oct 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXyAzkLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249FE3126DA
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968164; cv=none; b=RhbuoZmB6deyyFYf/u8sBeOwzj2T+7Ixj3NWfRyWOJlZmjzEE9ftqM0es6tSZtUginaRJVYbpJOQBjCuBjsJsrnLxH2h0J+dQxwb7Ed4lMY3SWVWs8ApIM8LS4ipEMJmzMplTQUr5kJa+QmMVdt9frZOPYY8vWY12HEG5q3MmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968164; c=relaxed/simple;
	bh=h3HoLkT4aFAk87mxUyKqKSEwXQ3salm8bUf/3v+FYOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNFKqpJux8L45u6KewTOj0Hb3hUHc5g/7cdxmT6Bd+Sw80mEvvOt8SyZgOeXHBstOLKWa9p7VY5IMH91UNCR/FcmgnFWX6gLJsNLlhCsFyW10eVTX3drsF6YjAh06seGiFJ5W78s6Ee3+b6YyL5FTkCJbzUyelB9kVnd4uDK76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXyAzkLs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33be037cf73so3069893a91.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760968161; x=1761572961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWKmwdA9I2ITUhToX2qR1cuSgLsOWMNN48NL48WMTnk=;
        b=RXyAzkLsG1wE1CXF+A/i/bMMNnpWQFaePQTpR7AaRTGnluDhvV/Sbn9qgZ31KB0Ir0
         p5SkyM1HWWrw267VPbpC7DlLu8A/WZgDKSaB0CG7BCZ/JIVRkQeKgWvnGX4EbFHpSBy+
         3ArsvbcZqQDjZb8B1UNjn3q4U7XpYwbiUtt1aW3JMancQCJU/K5w6PC4kLLcqOgu3tZ7
         OuzEra4u22j8XEhdBptFiGHbxMmMHELF6Q56FSW9T8A9Sc3RPzQn2CFRImOePZWtxmG0
         E3ULX2CoGyX2Yzb7TRFB5gaIWW08vnNwUqs5IVJy0QM76OX0syJh21cEVU2kCvIuj2HE
         OSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968161; x=1761572961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWKmwdA9I2ITUhToX2qR1cuSgLsOWMNN48NL48WMTnk=;
        b=LdbWRQRWTEu8W41dRd3/nIo9k59AwnIx0/AJaTUSj8bPShxydcOUAZmYnwgtXKUSZL
         FmtsKn5fgzZxYhL0fw1RCblZTe1O7sFVbEuOmnDVHvZ6QKaSEPbwdnTIDG1S/zU3wGRI
         ja69HF2hhWK3rSWhMXgSPPs8IS+z2egEU/j9UPbcfkcK015X5EL6zS8yh/KpaTimYtM2
         HyzC3/cSBkv2vFsHik4oyiCqYBHrcQubneDGSkgt95ByebXU+n/mg35zWQy5+FprRpMj
         ds7Hv2PJWUbfxZm8/O5ncj+ToXGUipZ99KEJwlQcPL8Xt9Fy47ak6ZSLxd8GObK35iv1
         VLvA==
X-Gm-Message-State: AOJu0YwgV3VnG1zdIGiSYwOV8b1eBN71c1dpzZpmV/g5HILNbRk3nk0/
	2tI5STY+Bt/C8XRqko8ijgPnh6hftqfxna5ZRFuWc4vLtkt8oHjAP7CI
X-Gm-Gg: ASbGncuS9EsOsKMn/xguBQGAdG1gs7CGFP51C7PewAKP4KhfNcUcALETckBw93c2zNE
	kBmsTSXi5HOmLW2t2i8vskDkkrU/1/X54K9E8WygZwEHVQ9mfYCOiGJm6+QhScnyJEGgpimHeGz
	lbtrd4ct+BXCQmuFG2o2sSger+QI552jYHdlxS0izgrzI3655OX0KKi2gpP5sDDNz/mVNiGP0VR
	Nz8bdjq+9ptrZ8ExDQQHfrOPjQ7SsJ0CqdvehcSFqU+HZ2HAuUkW/aULjlABJ2VwYzUdyMpTH69
	uEBVyBq9RBxGFwFa02zBNh5QsG+7R6i0grADH1a32lrVhf1x60v4ZQFm7fqcjAFjAcq6B4jw0DH
	bAqDVzYZGFGbZdo7s8MKsIPuK6LRC8oBMCsGw/f86kiak08guVg5TjgGtwtt+FzInvUcNsqmRkK
	Tcn7c12XcnZXGa0hpg9dNFGv/YRRGmCD9GLVuYECGbxfkHwgqmpq5PKprxu79PdSqsGqDUgNcPt
	72KDJsYoMZV
X-Google-Smtp-Source: AGHT+IESKh8p2QsR+Rk1v/wlAyJsWQauYznHQNj/lfmr1UJMevw6KGFtM4HMsy0OkeBrWdiwqrKe8w==
X-Received: by 2002:a17:90a:c2c3:b0:327:f216:4360 with SMTP id 98e67ed59e1d1-33bcf853706mr18348648a91.8.1760968161239;
        Mon, 20 Oct 2025 06:49:21 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cc9:d444:c07a:121f:22da:3f7b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bdd02793dsm4507349a91.3.2025.10.20.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:49:20 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC net-next PATCH 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Mon, 20 Oct 2025 19:18:55 +0530
Message-ID: <20251020134857.5820-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

ndo_set_rx_mode is problematic because it cannot sleep.

To address this, this series proposes dividing existing set_rx_mode 
implementations into set_rx_mode and write_rx_config

The new set_rx_mode will be responsible for updating the rx_config
snapshot which will be used by ndo_write_rx_config to update the hardware

In brief, The callback implementations should look something like:

set_rx_mode():
    prepare_rx_config();
    update_snapshot();

write_rx_mode():
    read_snapshot();
    do_io();

write_rx_mode() is called from a work item making it sleepable 
during the do_io() section.

This model should work correctly if the following conditions hold:

1. write_rx_config should use the rx_config set by the most recent 
    call to set_rx_mode before its execution.

2. If a set_rx_mode call happens during execution of write_rx_config, 
    write_rx_config should be rescheduled.

3. All calls to modify rx_mode should pass through the set_rx_mode +
    schedule write_rx_config execution flow.

1 and 2 are guaranteed because of the properties of work queues

Drivers need to ensure 3

ndo_write_rx_config has been implemented for 8139cp driver as proof of 
concept

To use this model, a driver needs to implement the 
ndo_write_rx_config callback, have a member rx_config in 
the priv struct and replace all calls to set rx mode with 
schedule_and_set_rx_mode();

I Viswanath (2):
  net: Add ndo_write_rx_config and helper structs and functions:
  net: ethernet: Implement ndo_write_rx_config callback for the 8139cp
    driver

 drivers/net/ethernet/realtek/8139cp.c | 67 ++++++++++++++++++---------
 include/linux/netdevice.h             | 38 ++++++++++++++-
 net/core/dev.c                        | 48 +++++++++++++++++--
 3 files changed, 127 insertions(+), 26 deletions(-)
---
I tested the correctness of this by comparing rx_config request in set_rx_config and
written values in write_rx_config.

The prints I used:

After new_config is set in set_rx_mode:

printk("Requested Values: rx_config: %8x, mc_filter[0]: %8x, mc_filter[1]: %8x", new_config.rx_mode, new_config.mc_filter[0], new_config.mc_filter[1]);

After the writes in write_rx_config:

printk("RxConfig: %8x", cpr32(RxConfig));
printk("MC Filter[0]: %8x, MC Filter[1]: %8x", cpr32(MAR0 + 0), cpr32(MAR0 + 4));

Is this sufficient testing for a proof of concept?

I picked 8139cp because I could emulate it on QEMU and it was somewhat easy to refactor.

-- 
2.47.3


