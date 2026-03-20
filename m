Return-Path: <netdev+bounces-270115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDwCLHzfvWk1DAMAu9opvQ
	(envelope-from <netdev+bounces-270115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:59:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 347662E26B4
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98CC93054672
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E703AA4E9;
	Fri, 20 Mar 2026 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZFZ3nwd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F839FCB5
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051096; cv=none; b=e1JBex9youDLnRTY3/gIFZKITp4is4ViFjEBeLnXeReZV1TnyK3qgChNqJd6LqRt5HOOlVfCZm/FQeMDoZmetc2UpSK8Zq5Xasp1lsaWi4/WgmOjKmikyb+k5cZ4Ishszq5c9hR0RzhakGqHLuN0uwQVsVQ/8qQQdEEK6Gs4n/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051096; c=relaxed/simple;
	bh=dNeoOu1t3KNyUaDgwicIa2dDR/caR1KQxquIkpXPm24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=INhmrzRqaIBcDCojbmYrDe+RUSlEgoXcpU4w+XwdnBkJAj40Qtlf2Al4v/vsY7yUzBKrRVggSqsOjeULlrNfWneQ71mdpMcCZ0gWOhBYL03E+pVrCR31U79TeDuL2tA9CyDx/J7j75edPwMXr2Je2pzyF7C6givSmSFPBIebx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZFZ3nwd4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so9246145e9.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774051079; x=1774655879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NVm0nQYPk5NE/4GIj/YWi6A6ci/QMH+dSQjYUxxFvik=;
        b=ZFZ3nwd4QxOqMwZWecUUEgQ7yEWDxpS2BnFjr4M67efYhj68a6i6UVf6adHtsZh8X5
         GEn+NklZ4Ci9f7La9OG1yVx9owY8mD+BJ4X00d7RTk0nZbiZdSXNbI7mqD9u7XUsGf4m
         QtvSK7acuBd8Mlniq7mH8ibaZ0dTlG6EqxhaEiNIbw331oypnD+8LPWByj44wxnTfyLc
         wK6X++d5nbIuRMZYctRl+4iH3tdyXlQhynaDko6DzoodHNJxw5h9n3oxseQGZC1f7Dac
         mcvfH2125TLbyPbUTcH2yrBopdn6fShpJYyrfri1AeUEKRLk1p8mashj8pjGPu76pDAs
         DFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051079; x=1774655879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVm0nQYPk5NE/4GIj/YWi6A6ci/QMH+dSQjYUxxFvik=;
        b=k2AQbhqMpXvyymWzaXEZq04+iZb5f9k+YgVY2c8sew58Gak0tgrVsBcrpoP8uAnecv
         oKcnYL+aAL9vynyGt6BD32j1WQOoRq33a25optnV4vdJ0+NuqMrDmq4CYlM1Fj4Ny47p
         kiJTVFQww5tW2FFN9rwOUhi6yJ4kFwwrhmOeEgRgGQSQ3J1LJbRbAbuNvm/8bjARHoy5
         e14MNYeTHXB/CCfLZNsvD7Om+ShgYO8U4ucUT0dI+dmE9vV32Ug8ONog3rHdtETu+mTb
         j4axbOLWHhUCbicR3+ATSDXmnL5vabmmEOyTzVdaQozfabLny4B+TGYsCOTmqN+/VwKK
         /6uw==
X-Gm-Message-State: AOJu0YxVvHqixqcrHDpWZmGL1BHua4C20Gwd0KDUroFPc0UYZJigbYGc
	zltF38zxOOb/30pcQesYrfHg2BhQRCzgiwQhreZzQm71HfYDbXCvIimU5rTyGYlsoTZB4fsUGin
	ERzMG3ZTSRWInuxzO7ES0dWn0dx8wP84Cn+rLKIGJVelfSnK9KYW9wQphjkZ1Lbp4t9kvnB8re4
	52rNLf3XghTObpaW/ea+XdN4BOkdEev6+EEmmBAOuCD9Av9/A=
X-Gm-Gg: ATEYQzxty+gvamhDZ1wG7Op5DuHWvAwzul6MjoXKnvpVIGJsYegvY782GzOqGtk+iyZ
	DFHaAPv4rgPT2fZDX/ukJUxQmNKm5ZUVlGf/WIA/3OFxzTAF26NjCgnFBi+SfIhI1HT1at/Dxyq
	a8TtJibMUDAzk3mhaB5ML00oQucREs6Nt70+mcKqpBvsBLtWL3J950nQ7sImAzYWywddsSliBpN
	dAT2p01mwWrLmACVYraOMI5DVkeuoqk9kolA7uVrndV6F/6u2d5LvoKWTPufGNQbXxrTq3/Rh1V
	Gs13xBh60scdJKUfF/svYjusW+RrVvyOajJzxIUoX33GTjBqyS/kiY+Oxf99M1+uwjNed5w2hTq
	s9L1OZz6ldCD6gMhRL45Ys45NVDcyV630Nb3ZunLwAq3hqQRZ39z/UEglB0+E0Mafl9PGjJWiul
	Ye7ssMrhVyjxC3WHtsJ4bNET5jIaZ+KaoijyHDCVOFbyP6AcetabJRz2Dv7y6VZOZasT3jAMDgC
	So=
X-Received: by 2002:a05:600c:348c:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-486fee1af1cmr61177315e9.25.1774051078956;
        Fri, 20 Mar 2026 16:57:58 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486fe87c815sm28704635e9.7.2026.03.20.16.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:57:58 -0700 (PDT)
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
Subject: [PATCH net-next v9 0/6] tls: Add TLS 1.3 hardware offload support
Date: Fri, 20 Mar 2026 17:57:00 -0600
Message-Id: <20260320235706.636531-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270115-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 347662E26B4
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
 net/tls/tls_device.c                          | 554 +++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  33 +-
 net/tls/tls_proc.c                            |   2 +
 net/tls/tls_sw.c                              | 105 +-
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 902 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 281 ++++++
 16 files changed, 1911 insertions(+), 178 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


