Return-Path: <netdev+bounces-252069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLz8GrdNcWkahAAAu9opvQ
	(envelope-from <netdev+bounces-252069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:05:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD75E782
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AA80BF76
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92189396D17;
	Wed, 21 Jan 2026 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Wj2ShEwh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5D397AA2
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032699; cv=none; b=LynDN4NlAkhnxV6rmziLHqYouFbEzWbH8Ecss+bVQ11jrXa2OpcvH0HEM0id4QxIcfavQbT2owAaCZHB4a74NC290WhuF9EaN9Jl1JfqGgebd9AS8EHcltV/sGCts2+SRhT0lZa4Fk5QYxQGioxoZRDyVOxbRH0vuAmQ/9fAXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032699; c=relaxed/simple;
	bh=/yKCpsIj9hcydvycHeYv6HvK2aJw6M8A5KybgIgY6/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JpaeM15XaohVAJdr3bnAwGmMC3Y6nXXwYmQR6QeOs5skxNhnfLcbc3xWlU70Vmgj4x0rfPFNtb03ZeR2Y25CgCRGHIhkaurHhhRrg8ton56ccT+DbYkyrbnSzuUsfw5RpqPOFixG0N+gHJ5hTS0rG+yeMcX0xGCffm7lbQ8nMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Wj2ShEwh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65832eb9723so583405a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769032695; x=1769637495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOclwln4Yuhwd+u30hsvbxyUcpBMQTQrdgoQfNtzuD4=;
        b=Wj2ShEwhheyR3mENw+w7S8H2u3JwUf9tQkzW0cmTJwuludMQmABG8nh493GsYu4yFP
         pGNQ3VxTmkc34d3ty5HQzl6JgfcxDSGEpDuzx7AMZNroppAoz7QrS6OIPGYBrQD5QqBY
         PkADYOxQixIbIDi669XT3W6DQgEnzsnDj8PTGJLiIQ2HqW9kqxONtLVrKeTRbvgy1AMt
         qSW8kTwhVNkqgEZ8CEDaFLbXRw0dfj/cW/lqI3p52tC05yZo9yLdZCBb/5HpHM8Tf1gl
         tcnoeOO3NFLUm6MeldosNeK05cdFepdQtZb5w0zHnyQANiIWHr6iBnuxW/B8Vc/oSEie
         DipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032695; x=1769637495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOclwln4Yuhwd+u30hsvbxyUcpBMQTQrdgoQfNtzuD4=;
        b=mSow7PHGJ5zjwPWOuCBfvXFPdTJU+DN79JwoHfiGgnPuE58zoBur6Mj6cDAdqMFbew
         a/xYBBVu4hDVv1y9YnFHXJNRJX8cUKXeTE08LvyI/6JfgaBwiXLhraoLrhSHitHQ0Zk5
         Goo5LdDhtUGjSDjwGafpeA0ZvQGLk+KKK1ztHn5rLmSkmm0fJOd9+4eopH1eWpWEkbw7
         oLfFtOFEHfuVRJj4npW0zPnzfMzbh8lmIEugHJzuH/xNClAkLaoTA0ltkVbtj6hbcb/9
         CkOIAoMBbemiUl7eSSlRijmbbIJLK6XNV7IMSjYxHiG6xIa6AiSgugoHa3hWoGGmNyXZ
         7RwQ==
X-Gm-Message-State: AOJu0YyE+jfikE288JDSVnZk24GpwlaQMBgPLelPhNNXcCRvXpdUltL5
	2WpypCtwj3NrGnMd6cDymngPhA7D1iK4cCzixNxFs19PlI2MzoHl6irH+pwsgo40a4DIyEsVg+S
	9EeyCpuLItZVExgxljUzmwiX58UIAT8ApPkYus0DIwVshcdBQzXlCFdz+S2Ms9BQAwEJot8I/uS
	PPQ7WjWITqc0MYfrFBSCNCLaIBchISc9+5BYOjbpQlt5khGdc=
X-Gm-Gg: AZuq6aJw3Mc9EMAv7H+tjr/oIoEHILQR3SFc5ZTOZYX7vnzP4hVj4e75JfNeUbQ5CKE
	y02KSk6HjmncB6Zi9BWaZXmSQ0XmlTnHI+NVtY+/pzrgqauYvzww1yMmeLRRpfhXW4g2U88qDUj
	vc4mG440FUxnwV+TERQq+si9x+vjgck/e1XQVs1+Fc7gjwxzmm/512jll3MQQ9XqomQI95avnXt
	ut0dZjZRJjfuiQm6vQpvvk8t1TxYPID9ishxzhTpo3U5HXnGJBbZWpVYZfUbQk19KWHVDZWoTjz
	wHkd5DC15eYtTRePaBCTci0ik4wlVyJ9oIR5X4y9YU3yVffHt0rKoWmMb/EGUh+fpbjUzMOjEEL
	3cin+wMocmeIcgkZ8DxKPACjlO1TLUOUPb79RvTPcPuoQJT7DkI2oyeauFJ/l+bMkQuACjrYpt9
	mjCcd9OAMkvEMr0uaoLlj8jqB/mkW9Hs3brlQq
X-Received: by 2002:a17:907:94c3:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b87968d1791mr1760571566b.5.1769032695297;
        Wed, 21 Jan 2026 13:58:15 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b87959c9fbbsm1652184266b.38.2026.01.21.13.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:58:14 -0800 (PST)
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
Subject: [PATCH v4 0/3] tls: Add TLS 1.3 hardware offload support
Date: Wed, 21 Jan 2026 14:57:24 -0700
Message-Id: <20260121215727.3994324-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	TAGGED_FROM(0.00)[bounces-252069-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[purestorage.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:mid,purestorage.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 14AD75E782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


