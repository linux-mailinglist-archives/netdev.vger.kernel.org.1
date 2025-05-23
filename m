Return-Path: <netdev+bounces-193142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E59AC2A66
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD755415CA
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46981B4241;
	Fri, 23 May 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu8+ACfT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088319D8B7
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028232; cv=none; b=p2iBlydaj2kgXNFR+5POIxu1ePD1DY/mP7VM8UXSrz9Srn222mJslxCpaKrdZKnoENybFL6JkFAuLSLfTcOj5+v8YPAQPpZrdL1QxnSZz8XXNnfMliI1318NpqAYkq5Jpl2neHvT24DIxVKStCzoPRQnoaDEtvUjzAgxlbDNVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028232; c=relaxed/simple;
	bh=bdiHYolmlYqocA9ieRjL4GeZn3an8qacr7vPZxo9G7g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ffAm7CO4J/bPWjko2uFDbB0w8LHugYIibzhLsSVakjo2OqpWLOj0OxalFtYhzzON87Q/S1093saUbzU+juphAyRvB+toYq5tNTzmKLt4M2PuhuCifR82xeKTnsLEhZykSOXFO7jTvXERFpZhIUW3M1BprrhvVu+PTa/lgbvtwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu8+ACfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1788C4CEE9;
	Fri, 23 May 2025 19:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748028232;
	bh=bdiHYolmlYqocA9ieRjL4GeZn3an8qacr7vPZxo9G7g=;
	h=From:Subject:Date:To:Cc:From;
	b=hu8+ACfTLtm8AVoFaZBwSIcFzZN89A43iMqJM/hk4x9WJ++btChu+YgZtBX7ie5KE
	 8NUyKhOgSEBREQ2CkyS8KLa3U0NrtkhWQ1Ur2TYh2IXrQY8WO0W51Cyg1/EVMC4BDY
	 fnUePUTEwNjyWQbaIcFtqSHZiaEprCcKuo2M0qx3FOcWpeJbIA0zSv2dv+0kysiyYY
	 9fT/cORhmQvMwCEoHEbjJEkWrnKfujrChSmJJNRvBfMQ2YVXkrLOUyr9zO5xn7Xlne
	 X0QOy5tCzDKEZ7AsZ18fywaTGeO+KAene0JE1SzHwO1nBkL9X8QAn+2F5/+xwzBu9P
	 L6UMk6pGC5Evw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] net: airoha: Enable hw acceleration for PPPoE
 traffic
Date: Fri, 23 May 2025 21:23:29 +0200
Message-Id: <20250523-b4-airoha-flowtable-pppoe-v1-0-8584401568e0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHLMGgC/x3MQQqAIBBA0avErBtQy4VdJVpMNdZApGhUEN09a
 fkW/z+QOQln6KoHEp+SJewFuq5gWmlfGGUuBqOMVa1ucGyRJIWV0G/hOmjcGGOMgdFM2jlvlXV
 MUPqY2Mv9v/vhfT+sc81ZawAAAA==
X-Change-ID: 20250413-b4-airoha-flowtable-pppoe-2c199f5059ea
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Initialize PPE UPDMEM source-mac table used during IPv6 traffic hw
acceleration.
Introduce flowtable hw acceleration for PPPoE traffic.

---
Lorenzo Bianconi (2):
      net: airoha: Initialize PPE UPDMEM source-mac table
      net: airoha: Add PPPoE offload support

 drivers/net/ethernet/airoha/airoha_eth.c  |  2 ++
 drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
 drivers/net/ethernet/airoha/airoha_ppe.c  | 60 ++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_regs.h | 10 ++++++
 4 files changed, 60 insertions(+), 13 deletions(-)
---
base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
change-id: 20250413-b4-airoha-flowtable-pppoe-2c199f5059ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


