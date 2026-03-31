Return-Path: <netdev+bounces-273697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJLGIjn7y2mcNAYAu9opvQ
	(envelope-from <netdev+bounces-273697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:50:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9836D382
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AA8430A4928
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D7426EBE;
	Tue, 31 Mar 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TEq4cayd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373D426EB7
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975123; cv=none; b=imIlvyUU0tPJz7Yf/7okEl8JOipSkuC8HmjlKfjMyL0YS2gMSNDGlHETGzoSBCAZxwv81f54vfMiNMjmJKjcUDJeJz1vp7/6aEJEHVPD7Fg3PClmHVqlbtD9E4hloFLoLfQGlNwWArFaHoiKz2WSBxSAMdzoM6QoJODBtVagN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975123; c=relaxed/simple;
	bh=JM0rk+RR5oCwxpv152rUJ8FoLbeD2MDQomwJBZWykWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B/v7uSUxqeRTgMnHeYIOhoTEvP53cPL6Apo39p+j6ZJF3rfedTmuM5sWBbSbOL6Gpq9WODz26UFlUV4SKQPmLrKvwk/tOqfuWmpPsImW14Ct7d7vSRlfhUyMjEZPtLUoKcZWggo969zqiU2uRSgPo457SiPoBm/mCBM8J0HAiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TEq4cayd; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-41c5a81d4b1so27125fac.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774975121; x=1775579921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGjSgW6PdgwOqrCqoUkdRojOzdzxr7Rj7UbrW1KSawM=;
        b=TEq4caydGOyacInmchzVCnreNEaLiPLkSl0RHEcdQSAAyW7KxPD9Vhf8PYzvQa1i1W
         MdywpEA4RA7q+7wiA2kt1pVA2vIgAdQ5lH5B+PmfEQ0bfqtohaaJXjSrr6EFfCD4BxfO
         iUmf/0sPBUQKsl+43xH4W3AsQTtj1+lvculjCfprancegN9+Mzzs2ETytwZeI8tXjB4r
         a0wxz6BIEdP90sdDG/A5F7/TNBeVN31tcmag3bMuZ+Y5nnuc85yV/+ZVSWj954E0GyZu
         E4aZqkPI/kvOwbQyVFe0TdjWOuwy5Bz+FOvoVCT37/c7qW/UILXlPa8qQakTwlhRJy0c
         4nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975121; x=1775579921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGjSgW6PdgwOqrCqoUkdRojOzdzxr7Rj7UbrW1KSawM=;
        b=ZEQuAKHHG3ryqjPA4LhiiJ2MFypbkMIy6fzui7p3QQtIxpm0XD5TFimva8Nb0xvZ/p
         50QDLmujILMF7QW7qJfKFOiQo4soy7DWyAJtdyq7Z5xKKqtXQaUHCEE6eTui77DodWc9
         pbyXu7PBizL+1pkaZRoVT7pvZ4zBsO+TaKmzHAkGMLszuD/LRHxE5zQRiqa/fNHSZURY
         dZmF2VR6BLi0s4HRzYe08o+ZRwQPNsWQ8a9Ud7rtiUVo2niSE/TwwdwWpZJOVeg6uhsI
         c/IJqcPsWfjV9DVbkRfAyjaUmrn51DzN3EgjoYpR0oizLGHFaPHSh+I1d7YR9eBnELTR
         HoQQ==
X-Gm-Message-State: AOJu0YxcVXSDrFIyCoBzbpK2Bo/Aqnx1g+kksYtHQz5uioUxTF6SzKjT
	AszKKtCRq9c93bDjr53wUK7sRtfhA8mkq6RjL7MneMBW2+NiS7QAsEkZaRTbQEZlRhwIhCUIDj5
	Bzl/ihvQh8XTGIDXBfmTiRwTjv4llJnvrg32XI6eH/B2OmMKHzEYDGcVWjvWJ53avz0rlVFBsOu
	1PWPUN2T5x5sr3r3pHJuNaUa+/0XnEgA/zlSikunGk9yodPac=
X-Gm-Gg: ATEYQzxIBY4YA4dUhEaoqFdnwh7pJjMDROCYs8Y0uPq4iFdSNY/sEDnSRBQNwJ2YUGV
	GfHY2TMQ6QU/Vij60ImPNEGY7aYfyBICLx0BiRwTcFERBOaian1C/YVLphERVtfvGTTcJGsqqS2
	ZIneiZOwSyjJObG8/BFN9Li7fd3HoL7BwsQ1ypHD0uGlM0P8NguvAoSUWBOAhswrG7xsaXIVIzc
	hZcFFZPLN0j1YFg2bEwSOJJ0D4K0x21r4mZm06SB0YMxJx1QgLLU+mlAO93MA2u2m457jzl8vbO
	HnFMwU0gb+80709Q7X7vOkxUqv4ktrpxvwKhH1+NAso9U1QbJZovW5gGoR1noNyrwU1HYV3+XpT
	nUKarvUQj7boMqFoZNJkQIvAwJ1gCL7hEjPKeYZIw0sDuaLJ/1sAZv/viDLSeLLy+mEIrITV2VL
	2jvI9AjihljdLLFVVdVawuHM9R18i05N6cMxYMNC+zUr6DQOp3fwNcuNNZ1Z+bKctAPMXG1j9Eq
	Yw=
X-Received: by 2002:a05:6870:240e:b0:417:14d3:399f with SMTP id 586e51a60fabf-422a3b60bc6mr2337422fac.2.1774975120511;
        Tue, 31 Mar 2026 09:38:40 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-41d04d79c35sm7599651fac.18.2026.03.31.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:38:40 -0700 (PDT)
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
Subject: [PATCH net-next v11 0/6] tls: Add TLS 1.3 hardware offload support
Date: Tue, 31 Mar 2026 10:37:51 -0600
Message-Id: <20260331163757.149343-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273697-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: 3CD9836D382
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
  Delete old HW context and add new one with updated key.
  Track ACKs to ensure old-key data is flushed before HW switch.

Patch 6: Selftest for hardware offload
  Python wrapper + C binary using NetDrvEpEnv framework.
  Tests TLS 1.2/1.3, AES-GCM-128/256, rekey, various buffer sizes.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128/256
and multiple rekey cycles.

Changes in v11:
- tls_device_complete_rekey(): flush pending open_rec (from MSG_MORE)
  via tls_sw_push_pending_record() before switching back to HW offload.
  Without this, data in an open SW record would be silently lost when
  the AEAD cipher is freed.
- Selftest: enforce MIN_BUF_SIZE (16 bytes) on both client and server
  receive buffers to prevent KeyUpdate handshake message truncation
  with small -b values.

Changes in v10:
- Drop rekey_complete_seq; simplify clean_acked to set REKEY_READY
  once acked_seq >= boundary_seq.
- Flush pending SW records (tls_encrypt_async_wait + tls_tx_records)
  at start of complete_rekey; return -EAGAIN if send buffer full.
- Add start_marker_record + tcp_write_collapse_fence() in
  complete_rekey so the NIC passes through SW-encrypted data
  (including retransmits) before the HW boundary.
- Fix flag clearing order: PENDING before READY with
  smp_mb__after_atomic() to prevent clean_acked race.
- Use crypto_free_aead() instead of tls_sw_release_resources_tx().
- mlx5: fix reverse Christmas tree variable ordering.

Rishikesh

Rishikesh Jethwani (6):
  net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
  net/mlx5e: add TLS 1.3 hardware offload support
  tls: add TLS 1.3 hardware offload support
  tls: split tls_set_sw_offload into init and finalize stages
  tls: add hardware offload key update support
  selftests: net: add TLS hardware offload test

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   3 +
 .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
 .../net/ethernet/netronome/nfp/crypto/tls.c   |   3 +
 include/net/tls.h                             |  76 +-
 include/uapi/linux/snmp.h                     |   2 +
 net/tls/tls.h                                 |  20 +-
 net/tls/tls_device.c                          | 570 +++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  33 +-
 net/tls/tls_proc.c                            |   2 +
 net/tls/tls_sw.c                              | 109 ++-
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 907 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 281 ++++++
 16 files changed, 1933 insertions(+), 180 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


