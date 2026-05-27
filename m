Return-Path: <netdev+bounces-292045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLnsHDBMFmrZkQcAu9opvQ
	(envelope-from <netdev+bounces-292045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:43:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6365DE542
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8E84306715E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B5220698;
	Wed, 27 May 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH6GVB9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49109233134
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846080; cv=none; b=CUWdPZHmxPwD3F5uzhNq0piBXx4dj3cY1cvBVjPfIKm2/lFEHLSZ+FrrSSrAHpLOwIFdtUB8GvnqqXWmJR2UU91f0R+QXJZnQbHEzLcx9+AIFvrXw7XxySDWZ2vxaYjK9CuUgILGhSMU538x8aXZu+IP61VklwJ8OOTbr+1EI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846080; c=relaxed/simple;
	bh=GEGRh0W85SqrLlW6N0F2lcQajahHedW48kZQuxM3VFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JF+6JE1b+kL325mg+U64NRkRGvvrdHqXIhyTArbKb2dfkKn9FrpUlcJ71RcMY0pCroHlrml8uAkMcKA/AbQJWHL73HzwowMcgCezlPSIkjXEcwTkIb+8XPKY2rT6JGwweMkW2aNIQMuqlX0iCZ7MGVmXwWrZ7rfoPfG3kiBfjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH6GVB9v; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3664df32e91so12886339a91.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846079; x=1780450879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8GhRiSHUya2U5GAfqZix+KjHHdBW/Dseqiazsv/1nfo=;
        b=SH6GVB9vhL011SH3xffAroVTlGKyIMnOfHc6V8GMWDrpn5Yn4goP0n4GRvatI5H7BH
         P4RUlXP1EaeYHwTK9GZpaV7gl72QoDg6ztvNeluLAzWSLd9poWpjV8UaF/XcHDSFs1vD
         rqlq8sl8GVlAEPcFTstKGwNeAER49yIvSFxME5jSsnmbxfDkc74D+n6bK7Em83Qah9qQ
         WhuwW6JEZatf4EZAN+edaFliQ7/FoF1bDyZkQCNeAYTkkvCLCZL3KoVJdIothO2HqXht
         2dtsuLX0tpvzE6XgLh/bohePirJeQZVAJcrCay2w8JOKOxZBvP2k2mPRNnSPUIOOTvaa
         r4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846079; x=1780450879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GhRiSHUya2U5GAfqZix+KjHHdBW/Dseqiazsv/1nfo=;
        b=gU05YTpxwaE20fwR5ekgGgzKtQfa4llnY/fNHJQkWpIG8ee0QrYkIjhVdtFd2/WXKp
         UZfvuqqf66MWtI5KDL0+4FOpodp6qoDyV0ZMMdYohV1mWKc96mLJNxfzZyHDHCesJqGT
         RxxNBpBu7x+IymePG2LM/eqsQ2zZCVzalnZSIcNkdhyhq9DJZCn7T6kZXuUPjDNC8M7H
         tuJjPiIu3J/rczjpRJghN50aY/7YMyyxu96DoDApQsuJTy3G7yzGsVFD3JeJlRaMxLH6
         CVlqJF5ZmBO6eKZKGPi1dtLwB/5FXk2zSoOKqs5zaNWK/IRqc/jr0fXV1tBWprjHt/dV
         SDbw==
X-Gm-Message-State: AOJu0Yysn3Wvig++SQ/DXQcB6ELeUedgt3Dh0cfE7ek+IfCvsTELHwGL
	9fviShZiLYCebCwm8cQzeUUqdspv3zOiPbw7GypIpnS9XHKHWP/LpI7OxRV0b5vx
X-Gm-Gg: Acq92OGxgd6xhekYHWvPiqmzdltcb+ocJRIjpUE6EgnE/cIl2u9gR3hQcn9xr+4/XhF
	1cDCbmQxRCOlXc9NrvuN3IdwPWHqSzRg+1pqzJ85PkHZAkpAbbsUjEk37CwRG9D7NsClwZ61KF7
	ky/dVK6LxSIbbUj/VdYwpeC18AmvtVPlGBu9USfgnl/8xuljUq9lOitKjCfg3zRA2hXA/DCTtcD
	GpTcpvZya+UJ6TkDtheSIuEf+KUQx7MRb/Lhl9LMjSPf387gCRJ2SGGbvtYgkHaI30Y5dgWrZ8t
	Npv2XxYXq7YnBd7YOZGIaM4kIkj7eUGly/H+UwsmTsvEz+QbjyBBuQEdePTFgfQYJ/pQ82FLogp
	Nz385kGFwOwBACqzE8+jccmVY1iI9NMJaBNSUGQCLMuGKqcIuk1cNDaIeFMhuQT4YZUWhc2DxZN
	HE/fwbpz7ejl8hgS96FT4ZM8uCy0k=
X-Received: by 2002:a17:90b:3a10:b0:369:a359:b192 with SMTP id 98e67ed59e1d1-36a67475b45mr20004194a91.10.1779846078561;
        Tue, 26 May 2026 18:41:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36ac1fe6df3sm8134971a91.2.2026.05.26.18.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:41:18 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Zijing Yin <yzjaurora@gmail.com>
Subject: [PATCH net-next 0/3] net: add retry mechanism to ndo_set_rx_mode_async
Date: Tue, 26 May 2026 18:41:14 -0700
Message-ID: <20260527014117.1401809-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292045-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE6365DE542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Original async ndo_set_rx_mode work left one place where we do netdev_WARN
in response to a ENOMEM. The intent was to see whether actual real
users can hit that (adding uc/mc under memory pressure seems like a
very unlikely thing to do). However, it was quickly triggered by
syzbot's failslab. Add a retry mechanism and downgrade netdev_WARN
to netdev_err. The retry logic is a typical exponential backoff:
1, 2, 4, 8 seconds, 15 in total, hopefully enough for a system to resolve
memory pressure.

Link: https://lore.kernel.org/netdev/20260416185712.2155425-1-sdf@fomichev.me/
Link: https://lore.kernel.org/netdev/20260519095557.3749407-1-yzjaurora@gmail.com/
Cc: Zijing Yin <yzjaurora@gmail.com>

Stanislav Fomichev (3):
  net: change ndo_set_rx_mode_async return type to int
  net: add retry mechanism to ndo_set_rx_mode_async
  bnxt: convert to core rx_mode retry mechanism

 drivers/infiniband/ulp/ipoib/ipoib_main.c     |  9 +--
 drivers/net/dummy.c                           |  7 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 46 ++++++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 -
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 10 +++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 ++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  8 ++-
 drivers/net/netdevsim/netdev.c                |  7 ++-
 drivers/net/netkit.c                          |  7 ++-
 include/linux/netdevice.h                     | 16 ++++--
 net/core/dev.c                                |  7 ++-
 net/core/dev.h                                |  2 +
 net/core/dev_addr_lists.c                     | 56 ++++++++++++++++++-
 13 files changed, 124 insertions(+), 61 deletions(-)

-- 
2.53.0-Meta


