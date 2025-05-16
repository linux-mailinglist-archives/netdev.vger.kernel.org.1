Return-Path: <netdev+bounces-190951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA207AB9707
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857BC4E249B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D1E1FFC67;
	Fri, 16 May 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeghaOav"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478115530C
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382432; cv=none; b=LZu9ZYt23gI1kI1G/Ze0zNDKAYv9Actkhl+4JVJ/ZPfXZD91HyrswdVcnK1RngkugdQKmlK0JBYZlAXw9PKMSHJlHOQ651rD29woZ56EAzN2Fkq3qhj6oS1tOTupcHSVHCIfdiukum06TzYjouYcleGiLNqfuOBxzdlur35eODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382432; c=relaxed/simple;
	bh=kgZ2vse2jLZoLmPeQGmJgqcIfaqnsw+PumeT+CIMfwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CIqPM6804hzkonVv4jqZv85p/mIE+RZ+wluBCEcpkhp9Z3YHQ8hORTNTiEJIwELCAOf17ho5F0tjc8s4jwrUybPG/laoxPbB+fwOewPhSplgtxNmMG/AUI/3M3j/cCU2soZYX16JxwndP7Zz1jJo0vvTRFMzaOyR1en2hx1u/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeghaOav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84B4C4CEE4;
	Fri, 16 May 2025 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747382432;
	bh=kgZ2vse2jLZoLmPeQGmJgqcIfaqnsw+PumeT+CIMfwM=;
	h=From:Subject:Date:To:Cc:From;
	b=AeghaOav/4TjBm0dvFkkrv1O/PfKQcxQg5V8JMlD/3048Xw7fiw6fRNHjLtFox9fc
	 iEuekt/kmCDd7D8Cx/gwIeKfRlGGZWjeaQU49rJxiPXkk9Lsu4Gw3yABeY7uvoPQbD
	 OrcAtzikvLBUqCGLqAoLwOwoD6raYWOCHoDoWQSsBn8L9KnM1fmWVfzOqKb4uEbhdQ
	 OZ/sl/PTQ6iei8rn4CdlKBJGY58/WgGSSUvLlYd5rkXn/eedtQnzuwOymdyyRF+XM6
	 /8w7LdPObvfSNBCI/2QA8bDhoAZUoGrpcnC1fQ0ajRG/k85JDR7pGFxJ0SOA780/rt
	 /uwS8xXbDfNFg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/3] net: airoha: Add per-flow stats support to
 hw flowtable offloading
Date: Fri, 16 May 2025 09:59:58 +0200
Message-Id: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH7wJmgC/3WNQQ6CMBBFr0Jm7Zi2UhFX3sOwaNopNJKWTAlqC
 He34trle8l/f4VMHCjDtVqBaQk5pFhAHSqwg4k9YXCFQQmlRS01msBpMEix0ReJfkzPPJs5Y0P
 n1vqTd23toKwnJh9ee/neFR5CnhO/96NFfu2vqWX9t7lIFGiFIEdSGWXN7UEcaTwm7qHbtu0Ds
 I8iEb8AAAA=
X-Change-ID: 20250415-airoha-en7581-flowstats-7e69cf3fd94d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce per-flow stats accounting to the flowtable hw offload in the
airoha_eth driver. Flow stats are split in the PPE and NPU modules:
- PPE: accounts for high 32bit of per-flow stats
- NPU: accounts for low 32bit of per-flow stats

---
Changes in v2:
- fix memory leaks in airoha_npu_stats_setup() and in
  airoha_npu_foe_commit_entry()
- disable hw keepalive
- fix sparse warnings
- Link to v1: https://lore.kernel.org/r/20250514-airoha-en7581-flowstats-v1-0-c00ede12a2ca@kernel.org

---
Lorenzo Bianconi (3):
      net: airoha: npu: Move memory allocation in airoha_npu_send_msg() caller
      net: airoha: Add FLOW_CLS_STATS callback support
      net: airoha: ppe: Disable packet keepalive

 drivers/net/ethernet/airoha/Kconfig              |   7 +
 drivers/net/ethernet/airoha/airoha_eth.h         |  33 +++
 drivers/net/ethernet/airoha/airoha_npu.c         | 178 ++++++++++-----
 drivers/net/ethernet/airoha/airoha_npu.h         |   4 +-
 drivers/net/ethernet/airoha/airoha_ppe.c         | 270 +++++++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c |   9 +-
 6 files changed, 427 insertions(+), 74 deletions(-)
---
base-commit: 894fbb55e60cab4ea740f6c65a08b5f8155221f4
change-id: 20250415-airoha-en7581-flowstats-7e69cf3fd94d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


