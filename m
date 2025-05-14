Return-Path: <netdev+bounces-190513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F08AB7267
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 19:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDBC4C3723
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736427C173;
	Wed, 14 May 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaljmCiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428531624EA
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242616; cv=none; b=eq78INNOY4MBvVIMk3RGaL5NGnhTtW1mVGFD7y8rkmXQxbyG9z1/CWFrEv/AEtwlW/foX337ErDTkyoDIWN+VBYQWgrfRBbszgQ1C/ZDm5piFpywY6ZyHHgu4ucXzJbEg9Ad9poK76hb6+9fHW8w3d0EHi3J5BuDYpZbhgW4f9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242616; c=relaxed/simple;
	bh=36/dH5xRVrtHH1eTmliW3XuJouu5VZHY85/K/slXbSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I62tQ8IYVbcIiW1ftbRlEyZLRI6Rc5YOOOxYnTRd4VSjcXx69lmMckYsPoT2pwqXZtzkvyOT7LyoZVEnPHOh1toMZhoU11pVXQ4WRRoPaDB9tzE9v2q40E0lM7pm1eQsxBWER2GRf/8kRDZq1SuxO6TVvHSWXjGHi082wPiwgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaljmCiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDAAC4CEE3;
	Wed, 14 May 2025 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747242615;
	bh=36/dH5xRVrtHH1eTmliW3XuJouu5VZHY85/K/slXbSM=;
	h=From:Subject:Date:To:Cc:From;
	b=CaljmCiOSsL2kgudEDasFhJkTW0yq7Y2fyDhvyCrzHu9MzmiDOiRtz8APrOHfNUwn
	 Se2+l02vsof/BtUoO0eaO+Gvf32lCABCj2qb9C49ftgEIDnuZKXVZECOA0DVVbeLNt
	 t8lFGvqPT/UrjGZg5TqImKoUsUt8HFQrMk3PGJ08vkU+gGoJ7r6eUuQoBt+7r4vpJ8
	 +eVIsNsYRyIq/OHdNEbyWgDZchgBShq+9H9ctxTDoZzDVhPB/2kahZS0etw+SywVWC
	 hCxOsHZN6sDqCmvXW/8sVRqVC3+O0weCTd/8bBHDCMdwsqprfdfhz1VshMdSDlBCEW
	 9SwLRW/zk12Bg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] net: airoha: Add per-flow stats support to hw
 flowtable offloading
Date: Wed, 14 May 2025 19:09:56 +0200
Message-Id: <20250514-airoha-en7581-flowstats-v1-0-c00ede12a2ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTOJGgC/x3MSwqAMAwA0atI1gasWn9XERfFphqQVhpRQby7x
 eVbzDwgFJkEhuyBSCcLB5+g8gzm1fiFkG0ylEWpi1ppNBzDapB8qzuFbguXHOYQbKnpZ1c529c
 WUr1Hcnz/53F63w/WUNxlaQAAAA==
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
Lorenzo Bianconi (2):
      net: airoha: npu: Move memory allocation in airoha_npu_send_msg() caller
      net: airoha: Add FLOW_CLS_STATS callback support

 drivers/net/ethernet/airoha/Kconfig              |   7 +
 drivers/net/ethernet/airoha/airoha_eth.h         |  33 +++
 drivers/net/ethernet/airoha/airoha_npu.c         | 175 ++++++++++-----
 drivers/net/ethernet/airoha/airoha_npu.h         |   4 +-
 drivers/net/ethernet/airoha/airoha_ppe.c         | 265 +++++++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c |   9 +-
 6 files changed, 420 insertions(+), 73 deletions(-)
---
base-commit: 664bf117a30804b442a88a8462591bb23f5a0f22
change-id: 20250415-airoha-en7581-flowstats-7e69cf3fd94d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


