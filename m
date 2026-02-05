Return-Path: <netdev+bounces-257360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO2FCSclhWlV9AMAu9opvQ
	(envelope-from <netdev+bounces-257360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:17:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD3F84C9
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED0F3300CC06
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 23:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1133ADAD;
	Thu,  5 Feb 2026 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eOztKvTW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CB2FF677
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333476; cv=none; b=PpB5REsWI8Lv+uOGkiFssO2xODHmS2np4YIgqfU0c7MdHsGjd6z1aCo0wdFJNJbrxeeAkjJvuSvt6diblcDpvyX1knhIsGm+gqiRnvTBDkGS4nuKFeIuP/WDJJrjh3LI0zf5GlhaKvznKMLyR2Ox4lS4oMV6pZ5hMN2VfEL9Nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333476; c=relaxed/simple;
	bh=6+KL0elHa2XWMTppF0HtJQTqx2JQOa7To3eVG6myV9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lWQGwm6hIxcgb0ABx8pw5o4B0KhuRf875zSOp2jBK0M/6pYyM5I2RiqfpsQ1XZnwR4uNVWJHJetdqjD3w8zJ6NBRaNS4C5w6cU8cgUW2MW5NAPs9NVjMb0hf0xAs/XSNHz6PR9y64jXuj1omcBZs0vbQM5BkxnuAaQWsn0fUySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eOztKvTW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8845cb580bso12364966b.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770333473; x=1770938273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bLs0Xvz1liao2LlAZDiG2CAyWHpI8YH5ICuDPc7Dhw=;
        b=eOztKvTWuCoyyTO4X6sCkbzZzhrmVJ5Y27dKrlWpqrEaoo/v5OPbg0WfJdYsgqTwWT
         Lq+pZTXEY6AeVodIKnmn1r+GIFCYeM9I7BlHSbUz2zbwaS7TKMjF1bZM60h9R+mLrDW6
         jpeLygdsQgJU8AMu/vASkvsJ3I6kXgho8bEc5DYFlmvMmz7q6HoNn0aYz/DnJSfQs5f7
         os8qAYqhsnYPvLQi7YiCuxGAMQ0vK36QjjLY+AomESWWpxqeapy8RDzzrYYLoNmX8Qk4
         zULu5otvHTfY0qSqU8etGFo/lwKqthFqasKnuSP0KOzrxfAFR4UMv0xNpYsm5UvCqQJg
         6iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333473; x=1770938273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bLs0Xvz1liao2LlAZDiG2CAyWHpI8YH5ICuDPc7Dhw=;
        b=uh3D4X/CfKlBEGSWlNeVbWHUtgI4Y0xn8AcWMXngXLhcX837+dJJiCb4W/ICBsD7h8
         /AlFTCM89B1Jpn7OnoRNirFjiRLE8zYTNPpi18gwvED6bTTtA1qpQ75STOFUDW3I7QjW
         fb0YhOkH8XKtODJv38fxltx7Egq4+StCpauOmIFqOUPI46A4WZmZDGPEA8Ku8AaVLnpf
         clNUOq/YP5Vas0LpB7g+Z2JMP/IEwlJRhdByGavfH497INRbyaWnSXyCWVZ2gjiv6VY8
         hQfS0zQzdpqoXtHn+Ot0A+ed3EQSwaOz3g8mJifoO56xT0rjWnqp705D4zTNMUOcNmLi
         DMoQ==
X-Gm-Message-State: AOJu0YwwDZWUoNku1VjomhoIU/CaI7LmGhyn9qhhFXmFxK3hcQ3AgTjA
	CDsDLvt1Aly+WcHoT32Gnin2uXgL7JiMebEaXgjr9q9fR6C76JBigPr08fVZCUfog2v/kAP4F2l
	z0fKhMIYPh7sTYhupOUJ/sSc+oynQDsuTYtiCdbEHOc6PVvV6GFyJOFaSshDNb1FUrdjZw3oXZH
	lEwVIpGR6Ev4GahpxcKQaCg9kYTeQBTT8WJ+kI3OYAFb/FyS5HxQ==
X-Gm-Gg: AZuq6aKrgyZVudxuZDcftV2LuqMkdek4yCTjfZr3JGEbHxJrF2Ebw20dH5iC3j2/J9y
	4TwhiFfAPk2FmudAhGiciSGl8ZCw4I3oMAh7AYWu7Mah3ZeKosgY4OXU1hIgL9SnhDYRYQyifa6
	mn1/u5YDOGMrrO9qeoc1ZFIgevdEf/7gXDCfuprWi0x9XfKGwOAOYPj/gIVUXRWJH8bz3Ti0nwI
	2WBmsvzCK2siaALqQ+TB2MyZbQ3BXed8BZ5i0dgKApWrJ8X+83xug32r54/Vr/yA9T44vrQjnSE
	kqaenQBL/k0eJL4itU4w6XHSgidwHEnk/vdm/vIOxxv2vz7OJbatTczxQmsHlNH374oJA2b5POt
	GtGXQiFQ5sGsHduhOjzKeKJvLSByR3M/aEqDZyLqOve8LX6WY9llR9keib8fh9cKlHi82aSEhfT
	PvgTWbrlNWjco3EUbygFarmXIe1INdtF5tYox+G6ZcBILxRVg3a8V+3AK/t6JarcM=
X-Received: by 2002:a17:906:c14d:b0:b8e:a179:3330 with SMTP id a640c23a62f3a-b8edf174385mr36477066b.6.1770333473333;
        Thu, 05 Feb 2026 15:17:53 -0800 (PST)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8eda74c415sm26649166b.7.2026.02.05.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 15:17:52 -0800 (PST)
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
Subject: [RFC PATCH v7 0/4] tls: Add TLS 1.3 hardware offload support
Date: Thu,  5 Feb 2026 16:15:54 -0700
Message-Id: <20260205231558.139818-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257360-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 66BD3F84C9
X-Rspamd-Action: no action

Hi all,

This patch series adds TLS 1.3 support to the kernel TLS hardware offload
infrastructure, enabling hardware acceleration for TLS 1.3 connections
including KeyUpdate (rekey) support. It also adds a selftest for
validating hardware offload functionality.

Background
==========
Currently, the kernel TLS device offload only supports TLS 1.2. With
TLS 1.3 being the current standard and widely deployed, there is a
growing need to extend hardware offload support to TLS 1.3 connections.

TLS 1.3 differs from TLS 1.2 in its record format:

  TLS 1.2: [Header (5)] + [Explicit IV (8)] + [Ciphertext] + [Tag (16)]
  TLS 1.3: [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]

The key difference is that TLS 1.3 eliminates the explicit IV and
instead appends the content type byte to the plaintext before
encryption. This content type byte must be encrypted along with the
payload for proper authentication tag computation per RFC 8446.

Patch 1: TLS 1.3 hardware offload support
=========================================
Changes to tls_device.c, tls_device_fallback.c, and tls_main.c:

- Extended version validation to accept TLS_1_3_VERSION in both
  tls_set_device_offload() and tls_set_device_offload_rx()
- Modified tls_device_record_close() to append the content type
  byte before the authentication tag for TLS 1.3 records
- Modified tls_device_reencrypt() to use prot->prepend_size and
  prot->tag_size instead of hardcoded TLS 1.2 values
- Pre-populated dummy_page with all 256 byte values for memory
  allocation failure fallback path
- Updated tls_device_fallback.c to handle TLS 1.3 IV construction
  (XOR with sequence number) and version-specific AAD sizes
- Rekey handling: HW offload key update (rekey) is not yet supported.

Patch 2: Hardware offload key update support
============================================
Changes to include/net/tls.h, net/tls/tls.h, tls_device.c, tls_main.c,
and tls_sw.c:

- Extended tls_set_device_offload() and tls_set_device_offload_rx()
  with new_crypto_info parameter for key updates
- During rekey, the old HW context is deleted (tls_dev_del) and a new
  one is added (tls_dev_add) with the updated key material
- Graceful degradation: if HW key update fails, the connection
  gracefully degrades to software:
  * TX: TLS_TX_DEV_CLOSED is set and sk_validate_xmit_skb switches to
    tls_validate_xmit_skb_sw for software encryption
  * RX: TLS_RX_DEV_DEGRADED and TLS_RX_DEV_CLOSED are set for software
    decryption
  * In both cases, tx_conf/rx_conf remains TLS_HW
- Record sequence management: during TX rekey, old pending records are
  deleted and unacked_record_sn is reset to the new rec_seq
- Split tls_set_sw_offload() into tls_sw_ctx_init() and
  tls_sw_ctx_finalize() to allow the HW offload RX path to
  initialize SW context first, attempt HW setup, then
  finalize (memzero new_crypto_info, call tls_finish_key_update)
- Added TLS_TX_DEV_CLOSED flag to track TX hardware context state,
  to avoid double tls_dev_del call, symmetric with existing
  TLS_RX_DEV_CLOSED.

Patch 3: mlx5 driver enablement
===============================
- TLS 1.3 version detection and validation with proper capability checking
- TLS 1.3 crypto context configuration using MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3
- Correct IV handling for TLS 1.3 (12-byte IV vs TLS 1.2's 4-byte salt)
- Hardware offload for both TLS 1.3 AES-GCM-128 and AES-GCM-256

Patch 4: Selftest for hardware offload validation
=================================================
Adds TLS hardware offload test using the NetDrvEpEnv driver test
framework. Requires two physical endpoints to trigger actual NIC
hardware offload.

Components:
- Python wrapper (tls_hw_offload.py): orchestrates tests, verifies
  /proc/net/tls_stat counters on both endpoints
- C binary (tls_hw_offload.c): performs TLS operations using kTLS
  with hardcoded keys

Test coverage (9 tests):
- TLS 1.2/1.3 with AES-GCM-128/256
- TLS 1.3 rekey (1x and 3x)
- Buffer sizes: 512B, 16KB, 32KB, random (1-8KB)

Validates hardware offload via TlsTxDevice/TlsRxDevice counters and
rekey operations via TlsTxRekeyOk/TlsRxRekeyOk counters.

Testing
=======
Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).

Both TX and RX hardware offload verified working with:
- TLS 1.3 AES-GCM-128
- TLS 1.3 AES-GCM-256
- Multiple KeyUpdate cycles (rekey)

Please review and provide feedback.

Thanks,
Rishikesh

Rishikesh Jethwani (4):
  tls: add TLS 1.3 hardware offload support
  tls: add hardware offload key update support
  mlx5: TLS 1.3 hardware offload support
  selftests: drivers: net: hw: add TLS hardware offload test

 .../mellanox/mlx5/core/en_accel/ktls.h        |    8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |   14 +-
 include/net/tls.h                             |    4 +
 net/tls/tls.h                                 |   15 +-
 net/tls/tls_device.c                          |  323 ++++--
 net/tls/tls_device_fallback.c                 |   36 +-
 net/tls/tls_main.c                            |   31 +-
 net/tls/tls_sw.c                              |   77 +-
 .../testing/selftests/drivers/net/hw/Makefile |    2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 1009 +++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          |  353 ++++++
 11 files changed, 1750 insertions(+), 122 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


