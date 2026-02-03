Return-Path: <netdev+bounces-256442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLkDN4BEgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:54:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB10DDE6E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F7D30C19D0
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE37248F54;
	Tue,  3 Feb 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eJ0iETxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122923D7E0
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144572; cv=none; b=RgvdwoB3N9NMlX7DL+nqgI7XexLXv12cLRIZT2jU3hvKwU4O+XU7OZsFvc2flO2rQkz52CQVCk/Im+rWRsze6ne908I8kkS2k1tKrMwTnsDVA5jPG2QXnNf1NuELX6oFyA9j5w7wTl12xcG6KDoyf9wahZt5Gc0fWK1VQBoeiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144572; c=relaxed/simple;
	bh=Z04g1bdnvywSGpD+1W823hmtHO0/PEfqcGeRh4jclIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i+F+Q9ah4GLN/GNpOdwB6kw65WGZ3QWaFSaL5YGVhE7lyEkSrHitbs5wwUakf7myR1Y527ViMHMR07JNFGCOuLo4DXopnjq6oiPLl3yZZSrZMpawlzpLZ8NuuOV+cxmchJg9Mjp7XrzanIzNBPsY8zd+yNJaYg1OuEE1+7FhErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eJ0iETxs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b885e8c679bso927602566b.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770144569; x=1770749369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYplb8kNjkhWsFw1MdMMEQteBqXz4bLxH9vkxCK3Qrg=;
        b=eJ0iETxs9tNhR1l1gIM3qro36ETDtD8N6KgHeuBNYvDMnbs8PuEq8DyGUyEdbz6fxf
         eV3WSRTdh9X55QYax3I8cVfiSpCOtCR2havg8Dv2cmicwP2mT2T7Pmdor2pWgIvpJYLg
         JgZX/WV6fAbIUeoE8Ji1ACescjUXm1XmPgwJ5FnYooKcerC3dJ1gT8PL/CroUiDetqwC
         1dRDVhK0A12uxeuwQqajvdga6iSZ3S64QLGgqSWxoTmOqfME9q6BuTHrhyfSqO3mSNyR
         srnM3D8aHmPvKZtZ0XqMhmeUr7tYaFv+wAiBo7Qa7xXCcQ94ljbcNU5Hn/HoyL7SJP4w
         wc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144569; x=1770749369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYplb8kNjkhWsFw1MdMMEQteBqXz4bLxH9vkxCK3Qrg=;
        b=NRzbVjF/uHhGBSjA7Uczga4M31BtWqU6Mgj+GiiLXPOsp/de0hz77MkJEQAE7C2rYu
         fQhf68btuC9/zlpqrT7rmq3hXprcWazvVta9IntV1HyoDovstQY7BK4stfKJjMndUAXl
         Bkv3btytLNgVo+FJYEBDjJLcUyl2vrKwmXh+rfPrGtPc3OlQMJwxWNF+Ut+knkvasuvT
         MUcpfnIi1RDr4NNPxPLrICuFFbdFfz5Ek8+eWfptc5iwARGa+A1MQYQM3AuJ6XqYKNHD
         Di+cReL4eNZsgRf4tOaJ2vYFPo7zdcnrOGyZrMVjAKGWq7UvryGakhL+NvxuOyUkfjOR
         GkAw==
X-Gm-Message-State: AOJu0YwBO/ihFlNrdV57jCiwb02CpijXNTxH5g44D2vhhOj5bGNB+fPF
	lUx/+8at+8uUrAz+eI+lxrNqXGYu6WVGjLu0nMGYGX2ZHo7wIpCrxHO2nRGyeIfgbl33WHI3JcJ
	dWyLlLvdvG3xCDrH00UtDYsS2fbV9QnzmCDfc90C0JiNeZLGKf+Kd1YNdA2Ksf1VSTDyJUClc10
	26w3VMuVlmIH2Me4L+6bNM8cp0+AXIE1uObfwVb0HokV0FH5A=
X-Gm-Gg: AZuq6aIizohpANUtFBmNtqn0WPt5i0Zwgid8QG0VLmdusoprcq14XE0qKOdw6vq5u9M
	1e6R11FG/EDrrOV6QDJa52XgEoHQs9fRoLFOlDBGdADzsLeFRATxCCvznmYv2OyVHScygBVqzUo
	7MpIZgCR1CTOIUYlABBJvjPhd6EeaLEtRkzj/inzJWJnaAJ8vmc5PALUCSiFaEimvS7bnxAdv7O
	B9ewmNaDo/dCXrcGCeopZWGf9wKRs51GLUdN8gimKxQ4sqZuPqGxL0AUn7vhQUcjsqMh23FE1ox
	Nocz8ZBsHEb198D+pME6GYedQJOIg08j7QqrYGBX+QKiUMtmBNVo4K7AFYaTbncFmnHHx9L+1tp
	0J3a0AXZ3KM6Gm1rjokYOt0MwD51OSrCGBfOANfHtsScjN+7temOcFGwTQQ6mwWdboCu3B4aN2T
	IFRaRAJ1VwliVWX/e8smD2MStqKU5kid5M+Zl+
X-Received: by 2002:a17:907:26c2:b0:b87:2bd6:6bc3 with SMTP id a640c23a62f3a-b8e9f399d50mr35627066b.61.1770144568523;
        Tue, 03 Feb 2026 10:49:28 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8ea004ff2bsm12107766b.63.2026.02.03.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:49:28 -0800 (PST)
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
Subject: [PATCH v6 0/4] tls: Add TLS 1.3 hardware offload support
Date: Tue,  3 Feb 2026 11:48:31 -0700
Message-Id: <20260203184835.3619101-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256442-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Queue-Id: 3AB10DDE6E
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
Adds tls_hw_offload, a two-node test program for validating TLS hardware
offload. Unlike existing selftests that use loopback or veth pairs (which
don't trigger hardware offload), this test requires separate server and
client machines connected via offload-capable NICs.

Features:
- Server/client mode for two-node testing
- TLS 1.2 and TLS 1.3 support
- AES-GCM-128 and AES-GCM-256 cipher selection
- TLS 1.3 KeyUpdate (rekey) testing with configurable count
- Verification of /proc/net/tls_stat counters
- Echo protocol with data integrity verification

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
  selftests: tls: add two-node hardware offload test

 .../mellanox/mlx5/core/en_accel/ktls.h        |    8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |   14 +-
 include/net/tls.h                             |    4 +
 net/tls/tls.h                                 |   15 +-
 net/tls/tls_device.c                          |  323 +++-
 net/tls/tls_device_fallback.c                 |   36 +-
 net/tls/tls_main.c                            |   31 +-
 net/tls/tls_sw.c                              |   77 +-
 tools/testing/selftests/net/Makefile          |    1 +
 .../selftests/net/tls_hw_offload.README.txt   |  109 ++
 tools/testing/selftests/net/tls_hw_offload.c  | 1293 +++++++++++++++++
 11 files changed, 1789 insertions(+), 122 deletions(-)
 create mode 100644 tools/testing/selftests/net/tls_hw_offload.README.txt
 create mode 100644 tools/testing/selftests/net/tls_hw_offload.c

-- 
2.25.1


