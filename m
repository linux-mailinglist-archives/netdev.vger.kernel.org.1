Return-Path: <netdev+bounces-273393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACu5GxwQy2lCDgYAu9opvQ
	(envelope-from <netdev+bounces-273393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:06:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C929A3628D5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219E530378BC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D311CBA;
	Tue, 31 Mar 2026 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LoZU6trn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8DBEACD
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915505; cv=none; b=hu7R4K+DcKBEIVp+ZXMbJCbrWDqpCLmcLraIKVo6rjGGs3ogmfgMWhO6MIFSWGr9LWw9v8qnxftcb3po3n4X6jX/JXkt2KG30MzWbzFFLiGf1lJItUoztP5VcEgcY74FQfC1sKinLTHBy1b+SuABXxvjy/Qquf/Udug0B692dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915505; c=relaxed/simple;
	bh=qfzmflUp49CvW+6S238rJkRsxzoduCgnAbdn408rKxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sr9ro9q+gA5a2sG+LO5Q/KP87bnfmiM8YrvWazhse3NVuZJ5gwf+YWFua2d1LEEQiOpI0YbyDZW+Scib4Wob4avHIvimomHN4uGDETuxWZcc0jWG6DSewwqnZJP9wcyvdHLnjxhYbWcnumrR4ZAMciNGGNxgh8sL/JXlSgrL78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LoZU6trn; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-67c250805ccso1931779eaf.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774915502; x=1775520302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18yatGeQ7YApJ2t5FxEsmf5yyYL6ML89guDbbsjZR2M=;
        b=LoZU6trnUEf1odxH96Kh/eZI3jDpXLFOmQdNhCsVj4S+iTgG/t61fDjZLSzRDOxI+6
         d0aMDvnED9gb0Cry256h5D+1NMh3RF7V3ZUQuiiQZ7+2l477DnfJt1FzrQ8SBk7N8j3X
         BMdol0dgfnFBp+GQSgprNrrE45bChXgab9HByonvj7PPuPr6LmEZ/quRZWfLQPOxnxLy
         x7Ask028H1JSvXCOXpe6KC2viDm6fnFlzu0GqhZtqkgBXFceJp3wt2iQ42/D15rXolP5
         p9Fdu4czfejlZzPKERO3/Z/kIesrq2xiFOnjY9F8TmpcZsxMYnYI9qaswjYTTGIJDM3G
         VlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774915502; x=1775520302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18yatGeQ7YApJ2t5FxEsmf5yyYL6ML89guDbbsjZR2M=;
        b=hAqSZpBti9vVfo+vxI7Lxl5NKV3KnDYCv6uLQ54/4bmm2WaTj6Bljw/NV6dNBLl1JJ
         ZSd8ZG9a7FhzvfA1k6nIBeKc+bRk70GecybspNO2Z1oFjYYnVZsQA80B/EUDqeMjsiOG
         w4O+7mU0Z5e25Q8yQafHPn31xV1QINhEPhiu5HoN3q8yvj5gaQUx19lh1P0RqTJ2NGkE
         sNaDNFgrC+rDFFTZe0VzBvxG57XfAp/viBb3fg9EtRzKJmq0NMJzCzHyUrB2QRXjX4Q+
         EA3YwttIJwxSXu8endegIpRNRZlFmohLBbRuwTz00ILIex1+NiSwtmrU6tDcdMALmdWO
         hgrw==
X-Gm-Message-State: AOJu0YwEWWoT6PCYRgCfo+UDwIXGaWVt3Wzk6GbpTnQh5kH/ps60izv6
	Am95lHk1EuU7Cs1uvSEZCPn18WLxsaCkelO18JpfpMjzA3LDh9ozCID6YVW2E3aczXEErnMvgLt
	l2FpEgmv6UTdrOz91eX1EzUQfCjcd08vLgGDnTfHpKBaCuYxmBFgD/QTRXPgwKQV0NRqf3i34sc
	MNgWAkWFqUz1VfSHyyN3nCQ5NuVOqi2fM/sedBQS8t9dYT+OU=
X-Gm-Gg: ATEYQzzv36GBlO3ykppHYIWzBHV81x4ZNrHR63UHhFIWk52WAxMzKQPuucOeKCf20FG
	udgk9HQ9J+SO5oI6UfDtlsnN3ZMkVxBZyCXzXqyHHPhFX4mcDrDa3RFEpRMuaWxsinue6Ihs/ni
	yJubjC5IC1a84wVVRSHxhqJ8zL8FRgUmujLx43NUK3uRljd4vFcOGC8S1I+Pu3d8vLjm/7vPtei
	66Rg7mO56bHwueRkQ9tYmPfAX36eqtB/4EJO10gnFbIKIOgOv5Ww9LIvqb4KTOprsiCw6VUXkyq
	TAC7F4qUB0K3FEmlqXA/lJ20ioEzSRhtEAPpa0ezD1AZ5Vb6CmwGCV4NHCDJpwrnZ1It7Hl1n5R
	syaedu8lHAlRLDdewEuX29MQPZ3/MG4zGX2C7LGDiQhnDJ+eY9UFEp8RVZ+odmkQfCak3NdtVmG
	V0gVueCoUw3mFB/2BDTrY94jnfavrDgsrwVrNshixS2nlHESVsnyzFjQk9qEdLvxjH8pRqW4y4D
	To=
X-Received: by 2002:a05:6820:1609:b0:67e:2acc:5c9 with SMTP id 006d021491bc7-67e2acc083emr4446414eaf.44.1774915502296;
        Mon, 30 Mar 2026 17:05:02 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-67e231cb2e2sm5627807eaf.12.2026.03.30.17.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:05:01 -0700 (PDT)
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
Subject: [PATCH net-next v10 0/6] tls: Add TLS 1.3 hardware offload support
Date: Mon, 30 Mar 2026 18:04:38 -0600
Message-Id: <20260331000444.4103528-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273393-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: C929A3628D5
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
 net/tls/tls.h                                 |  19 +-
 net/tls/tls_device.c                          | 565 +++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  33 +-
 net/tls/tls_proc.c                            |   2 +
 net/tls/tls_sw.c                              | 107 ++-
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 902 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 281 ++++++
 16 files changed, 1921 insertions(+), 179 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


