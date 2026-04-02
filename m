Return-Path: <netdev+bounces-274774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA7INCcCz2mBsQYAu9opvQ
	(envelope-from <netdev+bounces-274774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:56:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084238F565
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 898FD3038D3A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F4B3B3C1C;
	Thu,  2 Apr 2026 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cEXFbEDQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2037881C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174178; cv=none; b=NDhSSpxx+W+Zzqum4AgyxE30xAWCKB24MGw2jZnk8bL3/FvjKV33WLXw9VFGw4sQrLz7SZpu+htpG7jHBeiO/Vhf4tXQPyUpVL20mfP5N55ma8w0wBarFcsjnHAMAsiG8P3gko/ZotV51uGxGVU+DpIoIOHCMVnvCmgPDJ7dlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174178; c=relaxed/simple;
	bh=XIHE9fcGnR2jBbx6wJl1YfNvcMVyT7UIfzFV9lmmzC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LlSlBmPovrQdT7l3dkT0vVzHvJ+EjLg9w/kVAzGDTFNHYas+zVR2No8fnNqgGc5asMk28m3YKhoVirWbdu4pQYTYGfeKxlbdGr7b/k+aAvyK45jqKF654G9XMG3tiJ8uQevbFC9H/V3GXfDTlUVRpZTDIReSmlK9/EqwdKV1/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cEXFbEDQ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-467166cb638so537350b6e.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775174176; x=1775778976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJTemlzmTjifZSMN5j0rZBl7Csa5FXQAmZCLZ6s/PSY=;
        b=cEXFbEDQijLSp3le0BZX1oyMvrcYRkJlWhdKttcv7u+dUGDdmLmx5+yGapHOM3IGNC
         UfbTK/zZ/x4n4ovLPhln3hj7CvkVm+Z4en/i+08aBsf5TmRrQj8QosCbZqMIVrhmqeVe
         5N1g61x/4jAd34VMdwI4f55lhNvNBVUAHaEwKmVx07QSVQzGr16q/eIz7WYqv27rg+XO
         855ALqDc3Nl6lx6mvkiC7JALl/pJOCZ+umuwzqaNiELxwkaehqOeGc+4ZeHIt+nwzh9r
         ocpDiTQQ3i2E1lnm8rIUVjSctAz2NPmJXL8R/SVs8z5Bq9zyXWqCKnDzX9tK37HwLbLC
         gqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775174176; x=1775778976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJTemlzmTjifZSMN5j0rZBl7Csa5FXQAmZCLZ6s/PSY=;
        b=XCgoPRn9hhfw8P7+tNawU7G6I0da1L1rrsdbriWND/KoxqbjbdDYeHwCa1Y8YFTyAz
         /GTVUWOZfM4uf+kf4YIjBcoo+Vg6LwGmDGy5aMZAwQq8RoYOZcO7cuwLzzxuCpqoWNIN
         oYP53TI1ptwFSDv3mJhg2+jf46phE9SBF+41eqJLLuCqQTvDMdxmEbXkgoC00ArfBvdM
         D4KEqi+dNjX4fJw0+J1rK4urwDrqaH9aoHQMtUAz1H2pY4urZZJp9NXZ05Ya3rGmnBkT
         M4Q8CTtRB6YPRejRKF2yyetl+SYJ1oHNXuY4RcefWcltkTPBceUf4FpXSkBDh11zGzdf
         NJ5w==
X-Gm-Message-State: AOJu0Yy0RF4fPyqXCG51ymdDY6EuxBqk0QnGCOwR85fyE4tlYvpnKZQy
	FserVLLKbedk9p1GQUzRdpAvin/9ziCh4VCJeNaxxsQSJjOCW9iBP9qyxXw7hz4i1AMUgkm/Frp
	Kx4dqFOH+IZT+Oy2YmhUkcFbO+vUpd2UKvIPc2kiqcjyEjAbyuZYJQ9n8VqZNUMHcMkbOny3Bx5
	6QhrTZUnQLjPZy9ZcckKWf+WfP1c7I4xLJlfIlSNFKpzfnv0E=
X-Gm-Gg: ATEYQzwpN/gtBi/5T16yb0crvyyZeyUw0WG+uH1Y0thgdfix/19FcStGO0mL16hfi5v
	x1naK1k1ywBtX5cTqFAzR2xbICNJ2WlPxBgpRETKnKTOdT3BUxBP/5fn8lJOVqPpeaNI9iaffKs
	DbmOZil4pUIrWaT1H0Tu/Wa76HZsx5zfXT8Ltm/VoZHvZv/69SUCl90KWbqQtiYnw9CuXQNCN+f
	KyFIJZEeE18TTrlbp9iDn+61O9ZUndjnEEgVmeKKdwmT5db8ebpTF9s+0PvBtaz5+1vfHRxOArS
	NKfK/CehyBvQsPzUNs5rpYFc+dyvbGOz93rWRcbqn6FngR2T4aS6/2fnU9Z3lKJ3TRYEu4HANMi
	OI6VmjZYsf0GVoK7iFFD4vjgUhExCL6J2Rhc7pxy1nu0CL2EVDI0bUcnc0Lgm7mBGT0QGs9qDOa
	Ud3KvU6r6e1d4PojqPjz3vRYdJp3at1zt4t+U+k7z7ueX90viFfzoIwT6hjMKPgjVbza8YuOjBS
	ZM=
X-Received: by 2002:a05:6808:124b:b0:45c:925b:5848 with SMTP id 5614622812f47-46ef821cad1mr680676b6e.45.1775174175794;
        Thu, 02 Apr 2026 16:56:15 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-46d8f9609bfsm2394775b6e.3.2026.04.02.16.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:56:15 -0700 (PDT)
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
Subject: [PATCH net-next v12 0/6] tls: Add TLS 1.3 hardware offload support
Date: Thu,  2 Apr 2026 17:55:05 -0600
Message-Id: <20260402235511.664801-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274774-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: 2084238F565
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

Rishikesh

Changes in v12:
- Rebased onto current net-next/main
- Addressed selftest review comments (patch 6/6)

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
 net/tls/tls_device.c                          | 570 +++++++++++--
 net/tls/tls_device_fallback.c                 |  82 +-
 net/tls/tls_main.c                            |  33 +-
 net/tls/tls_proc.c                            |   2 +
 net/tls/tls_sw.c                              | 109 ++-
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 767 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 171 ++++
 16 files changed, 1683 insertions(+), 180 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

-- 
2.25.1


