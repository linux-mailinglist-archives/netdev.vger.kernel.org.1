Return-Path: <netdev+bounces-288456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NRyC6GRB2pU9AIAu9opvQ
	(envelope-from <netdev+bounces-288456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:35:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC0558330
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38546301F9A2
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8196405C3D;
	Fri, 15 May 2026 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EehKi4OZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D9405C2F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880516; cv=none; b=SMutiPneHpAClOdnxhzUBH1Wn4bB53zG0lPPmCW98sSVC2Bxsnj6vt8mstGLKWo6MhHhBazRLd5J+037v4FpboHn4+F53jzK9laitb9YZ6l3vvQuFuG5ydDSQZS9fMljv4uKQoMiMegAYujnFblik6FiBFLQg0iG+rqe5VTgqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880516; c=relaxed/simple;
	bh=Ae5KPHohGX+RAVFhUsu/mLfVIuU876rD94yoypJybsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OApWlNX+w6gd55kzQ2ccB46z00Mln0jTJf5jfKIRkiRf9ZCMXX289Fcnc+dbBGOnJHcmKMGqZf4Y9vtn0y2QnVRrY3SivOJ0G+o+HHYjfXe1pnvgdSOVIAikQWyxm61BdzPbNBcH9ZBdbnD6lO64VbrK4J8Lgbs0kDm9bCrSvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EehKi4OZ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40ede943bf0so224732fac.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778880514; x=1779485314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gms6x1z+pH29qwtO/3nzJIt3bAtbvNPKa0hGACzVxWs=;
        b=EehKi4OZywHSkaBbynD3RCIFhRG69gbauTT3DF+UK3ohh1wmR6d/81Qvemdhrbcfxk
         BLvl7CUWtXSEskaZycE9jSOc603TDxP+2RT/sUoLVN0EelxWJbZFsznEUDrLSp2NREaH
         sQ0Qhfo1k+PyVq2sWbSpmoZvQQT6AQ4ql9EqlJ6FeLGVXK+BjNj0XAVGBey/jvLXfeci
         b816oU/a6wKDgOmFPD5JxQDuCjWcTAT9ymwvw8UeOoy1hjHsKfpN8NfsmJOO+Gatj5/S
         FcndlNp8VcShcJJrOUgDyOF9CQ6r+Pf7uZS9s6YBaY7BH5JCZmSa2Nx5jWZgUlNIbzHH
         tB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880514; x=1779485314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gms6x1z+pH29qwtO/3nzJIt3bAtbvNPKa0hGACzVxWs=;
        b=JeeJdc8fObHA4kW2rhfkYxehJcpZIGfOxhz+sTVjKQG7fZqQdtzwVarMzOiBBi5gVe
         NnNCOYXX6qRLP9/SyAzxhkCOeT23rqOl4Jf+fe7waZtBIz2DxNY5vm1sjEvxlte/yIsM
         rBcmV7xs27ioDbgxjuKp/KkkYA4BkZ2VjtJTC6mvvQRvKuCc+BrWonylDQkhxgjPOP2k
         o9PG3hlAo6xAapttaQjsqih7y4kU6CjCIRx6r2MKYR0irV+/DEiPzhLiX910dWK6vWav
         /BeiZLsYBNB6xXrZnvAPJiYz1mOQ6N1gxHkD0CcD+uxQgs1CtZltww37ZbA72+TxaZr7
         rMfg==
X-Gm-Message-State: AOJu0YxYrd6D/6yz0vCNOBg4Cp/iJyA4azlOSsRaWeoNkaDMWLMFzFds
	rRgKV7He7fdAj69Xn3bvpe352ZVP0Ul8pooH4lNiLFWkOxI/pBCUzvhL4qPAzmJM0LG1o+VOuZm
	+pOm8WwWSVtfx8KbGR/Iobn7WlqWyddkpny/fjuHvipdud4sRVCzCtnLExvnGq3VrU8DN1/tD1H
	mJxykhOLchP/FNDaEYS1H5WWhGQCKS9yHFP3yRRli2By9M9uI=
X-Gm-Gg: Acq92OHHPsJPCMIoU6navALYAOzGuCubda4uz7OmeLZ2MjjQR7qAduhrEtFEkNfzldh
	xEy1S7/9BcKeCkJ3gXBgzurA2aEQmYeZqEXdq0OUOAO7ERZ5aOnpXT4QLJYvMNIlLpdoCsVk27e
	IYaR8Nvm00POPXn4aElmZLA01ioKGKbLBdNij417XbMdGwOf6fxZVDQJgGwG5m2YY4UTD0sBocl
	z0qGXZcAhr5NyEJBJtB+ttCKc1U8x3peCkdyYLeX5XUoCVXRXiGzlgUjcvGqG370vRj+1JiNIhZ
	S9eJXBQsO5W5enyDinG0J8PGQbvfBI4tjdCH+E60Yy8Fg0Y9RfrXhVSO+EdASHGfdYu3QT+GRZe
	KWGrJAiVgpMEXSY/a59UWNKgd0xH8fguJ2/+3Lh314YKMDzbmpADBVP2wDIZIhAgdTabCZMsqKv
	9RMgTCWbUismchIOjbo/SXcfNjQ8nZ+7jGhwi7g2jA2bHUhxWlxdF6XcEiEg==
X-Received: by 2002:a05:6820:6ae3:b0:69b:b52c:c9b8 with SMTP id 006d021491bc7-69c9bfaf1bdmr3356668eaf.47.1778880513520;
        Fri, 15 May 2026 14:28:33 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm1608987eaf.4.2026.05.15.14.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:28:33 -0700 (PDT)
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
Subject: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
Date: Fri, 15 May 2026 15:27:06 -0600
Message-Id: <20260515212715.3151307-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B6EC0558330
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288456-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Action: no action

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

Patch 5: Prep helpers and refactors for HW offload KeyUpdate
No functional change. Hoist cipher_context/tls_crypto_context for
embedding in offload contexts. Factor tls_device_dev_add_tx() and
tls_device_commit_start_marker() for reuse by the rekey completion
path. Split tls_set_device_offload() into a dispatcher and
_initial() sibling. Move crypto_aead_setauthsize() into the !*aead
block so a fresh AEAD is correctly configured on RX HW rekey.

Patch 6: TX KeyUpdate support
tls_device_start_rekey() installs a temporary SW context with the
new key and redirects sendmsg. If no records are pending,
complete_rekey() runs inline; otherwise tls_tcp_clean_acked() sets
REKEY_READY once all old-key records are ACKed and the next sendmsg
completes the switch, flushing SW records and reinstalling HW at
the current write_seq. A KeyUpdate arriving during a pending rekey
re-keys the SW AEAD in place; if HW reinstall fails the socket
stays in SW mode (REKEY_FAILED). Adds TlsTxRekeyFallback and
TlsTxRekeyInProgress counters.

Patch 7: RX KeyUpdate support
tls_device_del_key_rx() is called from tls_check_pending_rekey()
when a KeyUpdate record is decoded. Old AEAD, IV and rec_seq are
retained on tls_offload_context_rx. tls_device_decrypted()
classifies records by old_nic_boundary: post-boundary records use
the new key; pre-boundary fully-encrypted records are decrypted by
SW AEAD; pre-boundary partially-decrypted records are reencrypted
with the old key for SW AEAD to decrypt with the new key. Mixed
records retry once with toggled decrypted flags (old_key_reencrypted
gate). The new key's tls_dev_add is deferred until copied_seq
crosses old_nic_boundary. Adds TlsRxRekeyFallback and
TlsRxRekeyInProgress counters.

Patch 8: Tracepoints for RX KeyUpdate path
Three trace events for the RX rekey state machine:
tls_device_rekey_start (inflight flag), tls_device_rekey_reencrypt
(old-key undo, retry flag), tls_device_rekey_done (old_aead_recv
freed, deferred dev_add issued).

Patch 9: Selftest for hardware offload
Python wrapper + C binary using NetDrvEpEnv framework.
Tests TLS 1.2/1.3, AES-GCM-128/256, rekey with various buffer
sizes, and burst variants stressing TX rekey (temporary SW phase,
HW reinstall) and RX rekey (boundary tracking, old-key
reencryption, deferred dev_add). Verifies RekeyOk, RekeyReceived,
RekeyFallback, RekeyInProgress, and DecryptError stat counters.

Rishikesh

Changes in v14:
  - Split the monolithic rekey patch into four patches (5-8) for
    easier review: prep/refactors, TX KeyUpdate, RX KeyUpdate,
    tracepoints.
  - Renamed TlsTxRekeyHwFail/TlsRxRekeyHwFail to
    TlsTxRekeyFallback/TlsRxRekeyFallback to better reflect that
    the counter tracks SW fallback, not just HW failure.
  - Added TlsTxRekeyInProgress/TlsRxRekeyInProgress counters to
    expose in-flight rekey state.
  - Selftest: updated stat counter names to match above renames.

Rishikesh Jethwani (9):
  net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
  net/mlx5e: add TLS 1.3 hardware offload support
  tls: add TLS 1.3 hardware offload support
  tls: split tls_set_sw_offload into init and finalize stages
  tls: prep helpers and refactors for HW offload KeyUpdate
  tls: device: add TX KeyUpdate support
  tls: device: add RX KeyUpdate support
  tls: device: add tracepoints for RX KeyUpdate path
  selftests: net: add TLS hardware offload test

 MAINTAINERS                                   |   2 +
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |   3 +
 .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
 .../net/ethernet/netronome/nfp/crypto/tls.c   |   3 +
 include/net/tls.h                             |  90 +-
 include/uapi/linux/snmp.h                     |   4 +
 net/tls/tls.h                                 |  31 +-
 net/tls/tls_device.c                          | 838 +++++++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  29 +-
 net/tls/tls_proc.c                            |   4 +
 net/tls/tls_sw.c                              | 165 ++-
 net/tls/trace.h                               |  79 ++
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 971 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 257 +++++
 18 files changed, 2395 insertions(+), 188 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


