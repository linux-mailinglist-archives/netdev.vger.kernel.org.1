Return-Path: <netdev+bounces-269666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIF5HPVsvGkPygIAu9opvQ
	(envelope-from <netdev+bounces-269666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:39:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E55CF2D2C00
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09A730B9EBC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3873AB299;
	Thu, 19 Mar 2026 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IWN4N0eA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DE3F0764
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773956183; cv=none; b=ao6b2Bmao542vj26P7Kfpx6z27VPejiggRQUwNB0jXKpM4fPZlnhY+nGeZDviIhenXzp0Z1LbRDB9gf5wQtp8a44x3Gd0RTI3o+9er9aYQWuRDtWc6H9dZIgCzSxc7eT4IAI/wyS5YTQ/aTvIiRjf+63mwxolUmX0bgSieJici8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773956183; c=relaxed/simple;
	bh=Jl+d6d1dXv2psrBcTnxjpcS42ccYigHmNQp+BIqvLMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kO49zf4dkae+UYZnt5FGyifd6dALCLlyWj/tktQskj15qeq3mxHcxu3A/kIdL7Jg36R/bQJs1F3idlLXb7gNvaRLbewwd/RtngPKM2jSvMbygVUdy3AquX0xM/QNyv6uVLUtdfb2sd+MKrOWoVrOkNvVlF9rHWFFqZhqgV3Vh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IWN4N0eA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so12694465e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773956180; x=1774560980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbL1C4uFwb1NFR/CFLYetbDPdIVpKz3VXQyvBB+DIL8=;
        b=IWN4N0eAuRplPLmNMAL3ENzEIDwNdK/Q2t3/0R4LUdh2FUOEqNgseYE/mU4fyzZCWk
         QTe1t9MyvEYYMbF0NESdGe1El6SdBi2c5KUKZ7J5fiZ3hskZnzGCCFAGSat22lwvMDVh
         53IY1LIlVt8rIDzTRp/J8gfW0e6zB753t0Nk3OuUaB2dmYGRrYtRjj+IL3wa2T4RpSa3
         UtqB8fz2B+KENkTavJuAuhS+E4rIfeyekaD/jSQeYWtaehhkIkEWzrEWuaXr87WdO9KZ
         huzkvmMbHTUKF2YLGeT9z+JhC4r35Rskt/PqlI+220xWyS1CznXTqL+a/pD+pADDR6WC
         igag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773956180; x=1774560980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbL1C4uFwb1NFR/CFLYetbDPdIVpKz3VXQyvBB+DIL8=;
        b=j10GSBtD1b0EzqK8p7SFLuSSKqKt3DCUmuTVb8s0pSWtkAZRVhrg5t+kFWmd/qo2Cw
         R8Wt2akv/pMlpDpR+ZjPPi+unkIN3J9wzgiueV83tGKDDyjdO4Q2LkBmUCHFQ2cXSaBp
         vIz99ntw1mJIgrC5zj8IUsGvi4VtRf5TmWSh/CsR93IxGcsfDykoo5byc7PIlhUkSznP
         qzYEAWtKop7bnuGAJ93PyCCQnlmim0YRlfy/7Dis9xkpGCBTrv4arX2vXJ5D69626v+j
         15zuOoYuxsPB7RQ0Nlg314oXuOAa6/3f73K25Kp1GVU0C1wAwFm+LeoB1kF/3BZHOX3f
         P8pQ==
X-Gm-Message-State: AOJu0YymZHTq/He/OfWLLEalDftcvHUp7/+2nA9PXZAbmvpNoBBebKuW
	oX5gaB8G9KIaODWEwUCzcRCgC2uAGHwYMUtTFicOXTjUfVB7+egMHYFKUrs8dXArc6GFVcrLEIn
	boTYFF+rhHwAAdTCbjmqwJclpVzwntaIFVImmoWZ+bk7Qlez5Ch+ad9cNgxOwsqj93skJ1P2aom
	ziBJ+4rzHVm0O7uybSWZ6av5qfCkH49BivUdnZ7xXWAzzNPjY=
X-Gm-Gg: ATEYQzzDmaunNbImMtgP2++JpeP3GZnjce+rb0CxOALBVGLxpRgjrz8O9vum/VsXJzj
	TZU/sN0Kfv2cRhefpKB1KW7Jv/ysyrS2NRlPcbTVrIBuj69FtZSHXe8j4/kVcgPPk3KfYYz1m9F
	vSWMjOIJVU/JfN2SXU/yImTSyJ/CPwzzOMy3MzqO7QCrHTCCud5o92GJMPUfwcxqA77gAIJLJIf
	0udZgmDreZ9vq3nlVxepySBqVQDnHEHNAm/IyWxFcgFNWtS/IMx+OPqoDYy26JbcA0q+KVvxySk
	Rc3q0C3FyI1yVMTpi/C49prFSwwxNfM7LZsaDejgCyTbc6H0BaMDVvl60DDupAwCjT5bpMJEAlO
	MQPKm42C8qTrZz1bDdLl8RMo8GNpCcU2tJ7FVOk5dSAhDsVmGdMOBttab4p8bXssRvPPhnrwJTK
	221+XxstRM8vvCzGRsneMM6+7DDmWeOclR+x/6yU/y4yldyQxoyFY/70s4JQWJCVTxY//15TGyp
	Wg=
X-Received: by 2002:a05:6000:2912:b0:43b:45d1:f448 with SMTP id ffacd0b85a97d-43b64244c54mr1477796f8f.14.1773956179719;
        Thu, 19 Mar 2026 14:36:19 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm1190659f8f.4.2026.03.19.14.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:36:19 -0700 (PDT)
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
Subject: [PATCH net-next v8 0/6] tls: Add TLS 1.3 hardware offload support
Date: Thu, 19 Mar 2026 15:33:17 -0600
Message-Id: <20260319213323.235559-1-rjethwani@purestorage.com>
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
	TAGGED_FROM(0.00)[bounces-269666-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.933];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: E55CF2D2C00
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
  Graceful SW fallback if HW rekey fails.
  Track ACKs to ensure old-key data is flushed before HW switch.

Patch 6: Selftest for hardware offload
  Python wrapper + C binary using NetDrvEpEnv framework.
  Tests TLS 1.2/1.3, AES-GCM-128/256, rekey, various buffer sizes.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128/256
and multiple rekey cycles.

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
 include/net/tls.h                             |  79 +-
 include/uapi/linux/snmp.h                     |   2 +
 net/tls/tls.h                                 |  18 +-
 net/tls/tls_device.c                          | 540 +++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  33 +-
 net/tls/tls_proc.c                            |   2 +
 net/tls/tls_sw.c                              | 105 +-
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 902 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 281 ++++++
 15 files changed, 1909 insertions(+), 165 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


