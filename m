Return-Path: <netdev+bounces-234999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E5C2B0D7
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675573B7CF8
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDE2F28FB;
	Mon,  3 Nov 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHNLpDNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4822E6CD7
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165698; cv=none; b=bc3XkmIUoKGvgd5a3I/nKEDfu/c187K3PNQ8RmFQgFsY7J6nX+07ihYaFIkhvWA1XaG+v7kMUtpzmqkHwxzbebXI5I8xn08/8DY08bxYPepl6WGl0Xnsi/LTnPapVis6iGYTi/iAl8nqiNzVr5a5sFGf8eRw9lGGG4KEPmxQffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165698; c=relaxed/simple;
	bh=NmlZXXYg+7teCHm0X3usXxWwSJfTnQa0ZnnwvQ/twLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UtcE9QTuGNT+XE+JzR7aBNHOuZh0tlVMqqv1WIdgwT3BcnXNirv9h7quEjdnKPJWDY3mBlr4FBlyn0vEW8Oez2o9pVN9dx6MBchPFT7GLiPCzA1anO1Y574a7hVwWXK8EKk3b6r0p8I7OZs2k+U+0hHx6aB+yma+HysUMJ6cO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHNLpDNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0336FC4CEE7;
	Mon,  3 Nov 2025 10:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762165697;
	bh=NmlZXXYg+7teCHm0X3usXxWwSJfTnQa0ZnnwvQ/twLs=;
	h=From:Subject:Date:To:Cc:From;
	b=VHNLpDNguNBJ95eK5T0Tcs8Ir+xnuehPRBSTcWs+irj1PKmVZJD8fJaHGEzHikeOu
	 InfRRxpGegUM1JEl3JwoTBp0FAqjc6BWJ9MLvqdmN5Bm11sTuxjHY9TSQrSHfKOYez
	 Ri4xxbOgAgGh6rdR46QFxyGMZ+NPu3Rw4PkZtk1hgNxMLfVlaOI1vE3KjH4kPRlMB1
	 AH6iCkNzI3Uxg1MUdNHSNYqF4kp3XAVkHjVIEK1Qu3hphyslu5GXFuLGxQCBK+5DkM
	 8CVIIwEW7UjU7jRAQ5/oYX+4EidU7qUsVInqbIo1Jjo27LoqJiZKqaxwih+uFyoERW
	 mOql41vAqasEA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] net: airoha: Allow mapping out-of-order DMA
 tx descriptors
Date: Mon, 03 Nov 2025 11:27:54 +0100
Message-Id: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqDCGkC/x2MywqAIBAAfyX23IIK0eNXosOaWy6FhUYE4b8nn
 YY5zLyQOAonGKoXIt+S5AhFdF3B7CmsjOKKg1Gm0Uq3SBIPT3g9uEvY2BWkCxU52xvbUW8clPa
 MvMjzf8cp5w9M5Y27ZwAAAA==
X-Change-ID: 20251017-airoha-tx-linked-list-0adb92b8a92d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.2

Add the capability to consume out-of-order DMA tx descriptors. This
feature is useful when multiple flows are queued on the same hw tx queue
since it allows to fully utilize the available tx DMA descriptors and to
avoid the starvation of high-priority flow we have in the current
codebase due to head-of-line blocking introduced by low-priority flows.
Reorganize airoha_queue struct.

---
Lorenzo Bianconi (2):
      net: airoha: Add the capability to consume out-of-order DMA tx descriptors
      net: airoha: Reorganize airoha_queue struct

 drivers/net/ethernet/airoha/airoha_eth.c | 87 +++++++++++++++-----------------
 drivers/net/ethernet/airoha/airoha_eth.h | 27 +++++++---
 2 files changed, 61 insertions(+), 53 deletions(-)
---
base-commit: 01cc760632b875c4ad0d8fec0b0c01896b8a36d4
change-id: 20251017-airoha-tx-linked-list-0adb92b8a92d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


