Return-Path: <netdev+bounces-252512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM6MOI96cmmklQAAu9opvQ
	(envelope-from <netdev+bounces-252512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:29:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE756D036
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C839300A8EC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198F38757E;
	Thu, 22 Jan 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IRvo8sWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EBF333442
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110155; cv=none; b=ET2a2hFlRVKXB8/XH5Opifh32JJy+Oug8sLblTB+WeJ3ITkog4LaDM2xxkhgXq259U6WT2ht8SVkPT6UsD51TeTWBBKzxkBaBG09EhU14cZvu4XmSSZld4oBnNDNthlbhgWr1wSJOoztq4qq2x1gMaRtdmBBMXAkI+eb/JBW+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110155; c=relaxed/simple;
	bh=jUCUYHk/vIhT6Vfw1pwSSz1Dc2LLzMz4IyaKQcasnjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VJWVpBIhdKI1qlU1YhhFCNsF93bjUI8FBbDWfa9GANu8v2oUw4hENeIANxzLxA8zzufsDxu0dy5Qho4tLFIkKPGkxlNEE67SthSv7A7j5hMyjZfqkqW71soYEDWB4C8cxg3ASmfX6SpudsRivd/bP3awxkPHRMy6LCX2jSM2ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IRvo8sWu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso2865069a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769110148; x=1769714948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSEabhcfDlsXWJ1LXzQaN8xBnQ5waXUHWyGy6/gLO7w=;
        b=IRvo8sWuBzUdzsL/Xb0O/75jVV35KppEYlrV0DrPwJeJpEsxOtghYnOBNGmhaba74L
         xYvrCn8ajZPW/dlwSe28iI7nIkpYGGxxcMrAg1YTALBemsKzLm8xizqSGqbw5dIRlc+S
         91gpOpQK8HjQiEtAhuBkzf08MBuB6YmPYU0BFkEuje8qkmEzlQqrMtsUvFMW4QCLdH+e
         2yO6L5LZqrSjhxF5mX0H4NChhGI7SKpzihMAwQCxjJ8V0J2W5SgtC10+D7DlUe9W87dG
         c+/kgS4k9cu4RNgtyJPycfbvoTgfsTJlrC4jHVoeoEhy4odADMk+KVCYJAEYydQ8bxSL
         4+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110148; x=1769714948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSEabhcfDlsXWJ1LXzQaN8xBnQ5waXUHWyGy6/gLO7w=;
        b=HAsTUEA812TshhARDnQDUS2gfAz62dCqg4li8DQ/Zv8v8l8rJR0YCtr1+cR4ePbTQz
         QEr31ZqHAqefEn/rT4Jh0sIUJGGXCVj5pfWcAtPz4LdvY5TCL/pTlgh5l2PxcncEocOk
         VgNuldTzTrkShvYQrtsD5wJElFFZ3l7EKbt+cxebXMzHawrQlB6cl2jin57f8+gv9Tz2
         PstwtMY+YVdLNOJ8n//v29saW5NVQVUcBfJ5/IBTwAtzO1k85WpIvgCykFC/P/lXY9SW
         Ygh1oGyP/OPeV5eOvVaf2qK/sO/dk+el+kIOK9PwtLHo0rxtdkXM8SqrXj1uV8X7TKRj
         gALw==
X-Gm-Message-State: AOJu0Yxd7vYmX9956BKIA5rjGQEY2E7ehKTJo18yPFwoJX4KCyA/szcH
	MwfMybXbN25Eqr+IGuuvPtaw9t4IjQFIB78LrjgY5Lqboe4s8iqhLKsxaCSSOpVqGBciK0p0EgM
	vEDG3z4VLy4nvTpoXneqD4Up4ozKcC7djHITnC69doLYYXRZd/kYGl/bC9UtxlskLmGFmbga/Nk
	3PNlsVSoozacRVIwiIU1gRfYZdpcpTN3SOYp7oaHxAu2sJRtU=
X-Gm-Gg: AZuq6aLk6OgDo5TadgWhH3AD9myxZ3txUon3hBget0nFmcwuRKXKQcEnciFqFybXqNj
	enkLfwQArxeNDD6KEDoYzMBC0g80DOpAIUC+swk6YXI2ZI5QKFu9TB92tMZ115VSy7h3S/uiKL8
	nv+O96Z0wf2pvYT+UOp6k2VNmJmUrwWUFnXEXbrz6/a5encHMCo0pFcvd0pG0NMQI0j7G/t+FqC
	KtHGF2kSN5C4oVkXpgPgxlCoAFg/31nqkSs1D59w3DU3wBt0QCNpY288/kj29dGJbW+QeftJN7r
	UESxNn7VhzKbx33slkW2F8NdaXPVitUkqcGGbm0yIOXSPu7wllM5pDIXHpKLGUnJYXCzxxUvLbO
	JeNWEuFJJnJAzFaR1Cd/ePiPsQBoNuvpCNAq1qqt1gtr6RZtEM3aT+pN3QkcNg13OyIfDwep2xS
	2J+F7mgb0S506ZKhx4+C7eJOeRzwXTAXEAEpL0
X-Received: by 2002:a17:907:3daa:b0:b88:464f:3db8 with SMTP id a640c23a62f3a-b885ae9e6e6mr21131266b.49.1769110147763;
        Thu, 22 Jan 2026 11:29:07 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b885b8011dfsm7925266b.70.2026.01.22.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:29:07 -0800 (PST)
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
Subject: [PATCH v5 0/3] tls: Add TLS 1.3 hardware offload support
Date: Thu, 22 Jan 2026 12:28:48 -0700
Message-Id: <20260122192851.86670-1-rjethwani@purestorage.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252512-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Queue-Id: 3AE756D036
X-Rspamd-Action: no action

Hi all,

This patch series adds TLS 1.3 support to the kernel TLS hardware offload
infrastructure, enabling hardware acceleration for TLS 1.3 connections
including KeyUpdate (rekey) support.

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

Testing
=======
Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).

Both TX and RX hardware offload verified working with:
- TLS 1.3 AES-GCM-128
- TLS 1.3 AES-GCM-256
- Multiple KeyUpdate cycles (rekey)

Test methodology: ktls_test : https://github.com/insanum/ktls_test/tree/master

Please review and provide feedback.

Thanks,
Rishikesh

v5:
  - Fixed typo leading to compile errors
  - Link to v4: https://lore.kernel.org/netdev/20260121215727.3994324-1-rjethwani@purestorage.com/

v4:
  - Split single TLS patch into two separate patches:
    * Patch 1: TLS 1.3 basic HW offload support
    * Patch 2: HW offload key update (rekey) support with graceful degradation
  - Removed record_type check from tls_device_record_close()
  - Removed Broadcom bnxt_en out-of-tree driver mention
  - Link to v3: https://lore.kernel.org/netdev/20260102184708.24618-1-rjethwani@purestorage.com/

v3:
  - Added note about Broadcom bnxt_en out-of-tree driver used for testing
  - Link to v2: https://lore.kernel.org/netdev/20251231192322.3791912-1-rjethwani@purestorage.com/

v2:
  - Fixed reverse Christmas tree ordering in variable declarations
  - Combined 'err' and 'i' declarations (reviewer feedback)
  - Link to v1: https://lore.kernel.org/netdev/20251230224137.3600355-1-rjethwani@purestorage.com/

Rishikesh Jethwani (3):
  tls: add TLS 1.3 hardware offload support
  tls: add hardware offload key update support
  mlx5: TLS 1.3 hardware offload support

 .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
 include/net/tls.h                             |   4 +
 net/tls/tls.h                                 |  14 +-
 net/tls/tls_device.c                          | 319 +++++++++++++-----
 net/tls/tls_device_fallback.c                 |  34 +-
 net/tls/tls_main.c                            |  31 +-
 net/tls/tls_sw.c                              |  77 +++--
 8 files changed, 379 insertions(+), 122 deletions(-)

-- 
2.25.1


