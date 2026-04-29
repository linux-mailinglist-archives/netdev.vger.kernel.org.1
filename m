Return-Path: <netdev+bounces-282460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PgJHpFK8mnNpQEAu9opvQ
	(envelope-from <netdev+bounces-282460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:14:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF41498DDE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B2B13007ACE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB137E2FD;
	Wed, 29 Apr 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="by5BOO7E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C32580CF
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486279; cv=none; b=eTI1NVf4nZA3v9Vw2CgaB6paxlVRYtIhvOOD1pOysqpH1AEePq0uUxgcFQ1uG7n+PjQg4CJvhb379b00EA3WBt1mjs7rboEncsFIlNgaNsqmsux5OfwU1N7uCRXNo3Mh+MniWQDHrXh3JrsZNnGP8jQBe8brnoJjuzdyQpiSOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486279; c=relaxed/simple;
	bh=Z0bIVU6SS+S6MdJBsTyOe/UplqWn50S40CXuK52m2hE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XaLjr3cvN1XnRZD89hGqfgqvj+7MeVGRIJNiVpzzLJs8w8BOMCPOML5Dj4w0J/o9X5OTtpybfKWNOqf1cEsmO5hpwxZvzT6vdOHDOiGAuNDiFFlLbNp/xggvB8grx4OFZrqyOR6bUnhTH/8XI6BSKBThOwZ+YfeCQDVrJQoJXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=by5BOO7E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891cd41959so346745e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777486276; x=1778091076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezL0pR0AX9nqfNlvpg+fDKk8//SgRDedoro1/h3Zecs=;
        b=by5BOO7E2XTkfh9DpFaqu2FgidwNIgxF9ywkQ1x78bG1aNwiWIIha76zEehvqj/zw8
         djW6DnR6sUBtlh5KxesZHV4WVP+q6q8ppBHkCbpnZhgFv8WZtRuXH/CCjKg0btcjz8qk
         wNrvOwRDO8dUV09UxzT1U2lENydw7tOdrpD9j2SNDZVbtu2omp6qndGE+om6ysYmpTUF
         XFj6wqd4K2M27L7Itb6l/ndAddd+5nIcELnTAw/9UoCZ/s80ucI0eO9YhzV33ENJDSiS
         xiitJw+KfUyfy1vg5k1W3UeVyZieFuAy2gVtFyRfZJwUPgThgT1QfvB2DeH1H0DlBq/J
         aNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486276; x=1778091076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezL0pR0AX9nqfNlvpg+fDKk8//SgRDedoro1/h3Zecs=;
        b=dzBjJF/xCM9UC+VlnWOpY4a+VeuTWaSnFOl73SYW1TQv5Jua7xZDP/yaVhYTvmobSR
         AMvRq6n1VSEmm6+JujQXKKB0gnc2q4YLOjNqNqeXZSJdwk/mAmVnSaB9Lh8I1JPSz7c/
         gKjVLEJ9xfsjZdmDUJZ07/K3QonrGgqRlywxiQug97GPF9YtoxrGBRXwJqvkI3+P78Ur
         eScrvAsRzwVdfo7oI3waizo9a68kwYrBis1H1w06V5Li/ziDnY/XE5SOGGEFih3p7IKM
         cB0PAMtHweexI++60TUW8wmUdEOG/F6tXNcYsIxdY4D8pA+SPkCuR51Mq94ajTBsrAQV
         lOLg==
X-Gm-Message-State: AOJu0YyXTOIWgmDZg3TikFE2dRkJ+zlvjHnDXxUveRKEnbHUKjjbVmdr
	pqIjUfwihG69QjnSRHz5IxuCM4a7JUZuLT677NHtVd489maFLCgqfugqDavHtURSHikJD4HRUc5
	aUJlrhOZCgPonL6BfCeehRDSdc6vuABdETO76Y+Wi23qJ9uLutbwbuK6Y/jqtzjUN0elK/JDepa
	EpBdQlokt6FmNcVhR+caUoVhbPrSWYkrw+AxtM4hlUSB3WBwA=
X-Gm-Gg: AeBDietmDaT7FKx+COH+2lwDEREuGEJjCO+XgvxSgfIFo/wlB9b7gdMok/mSHJbZDBo
	4QWt0gKGaZ6YyK80pXYAxQkmYlVNqZJjRys4TsNW8L32wlfgn4rhRDu0GpUZqUdRlU82y+4QaHE
	DvMviffkSNz+qyeahcZNaGNlbHBrINraY0oKBbdYIJE0XDU+9fKl+PjCO2UEjVtBLOW2MOob9yw
	r8AhckhsOlcxFbyc7k4+tmFEBYLaBPg/DNHvKTGg6LsOXh410/CnR/g7Gxqos0Q66li2EClvEPL
	wrsYK3Q0V1eeZ4QlhxeizBPbuInflQxAZt33hVO5BQqjMH17CRVSq/QyWcPInnImlW2WGz/DQL3
	0FOHWCdoxbSlqHjVKlrHJU1Z2WX3g83XnYlkxIO5Sblmo+VwgwzQof3EI71fOcNN2btB0n4X8R2
	JbMyxfVX8ikWCo34T0HzGr+sl7CJhS6dqg/b1NxXwZwB0DI9aPLpr8IktcoJKX8z87/YI=
X-Received: by 2002:a05:600c:a315:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-48a77adc73dmr99301725e9.8.1777486276010;
        Wed, 29 Apr 2026 11:11:16 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm7525285e9.14.2026.04.29.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:11:15 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v13 0/6] tls: Add TLS 1.3 hardware offload support
Date: Wed, 29 Apr 2026 12:10:10 -0600
Message-Id: <20260429181016.3164935-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DF41498DDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282460-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi all,

This series adds TLS 1.3 hardware offload support including KeyUpdate
(rekey) and a selftest for validation.

Patch 1: Reject TLS 1.3 offload in chcr_ktls and nfp drivers
  These drivers only support TLS 1.2; add explicit version check.

Patch 2: mlx5e TLS 1.3 hardware offload
  Add TLS 1.3 TX/RX offload on ConnectX-6 Dx and newer.
  Handle 12-byte IV format and TLS_1_3 context type.

Patch 3: Core TLS 1.3 hardware offload support
  Extend tls_device.c for TLS 1.3 record format (content type
  appended before tag). Handle TLS 1.3 IV construction in fallback.

Patch 4: Split tls_set_sw_offload into init/finalize
  Allows HW RX path to init SW context, attempt HW setup, then
  finalize. Required for proper rekey error handling.

Patch 5: Hardware offload key update (rekey) support
  TX: delete old HW context and add new one with updated key. Track
  TCP ACKs to flush old-key records before the HW switch; SW path
  carries records crossing the rekey boundary.
  RX: on peer KeyUpdate, retire the NIC key; queued records that the
  NIC already processed under the old key are XOR-undone in software
  before AEAD with the new key. NIC re-arming is deferred until the
  old-key region has fully drained from the user's recv queue.

Patch 6: Selftest for hardware offload
  Python wrapper + C binary using NetDrvEpEnv framework.
  Tests TLS 1.2/1.3, AES-GCM-128/256, rekey, various buffer sizes.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128/256
and multiple rekey cycles.

Rishikesh

Changes in v13:
- RX: on peer KeyUpdate, retire the NIC key; queued records that the
  NIC already processed under the old key are XOR-undone in software
  before AEAD with the new key. NIC re-arming is deferred until the
  old-key region has fully drained from the user's recv queue.
- TX: cancel rekey_sw delayed work in complete_rekey,
  EOR-fence the last old-key skb.
- Selftest: new test_tls_offload_burst (TX/RX, RX-ZC) under sustained
  rekey.

Rishikesh Jethwani (6):
  net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
  net/mlx5e: add TLS 1.3 hardware offload support
  tls: add TLS 1.3 hardware offload support
  tls: split tls_set_sw_offload into init and finalize stages
  tls: add hardware offload key update support
  selftests: net: add TLS hardware offload test

 MAINTAINERS                                   |   2 +
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   3 +
 .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
 .../net/ethernet/netronome/nfp/crypto/tls.c   |   3 +
 include/net/tls.h                             |  84 +-
 include/uapi/linux/snmp.h                     |   2 +
 net/tls/tls.h                                 |  33 +-
 net/tls/tls_device.c                          | 815 ++++++++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  33 +-
 net/tls/tls_proc.c                            |   2 +
 net/tls/tls_sw.c                              | 153 ++-
 net/tls/trace.h                               |  79 ++
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 887 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 256 +++++
 18 files changed, 2271 insertions(+), 188 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


