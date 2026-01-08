Return-Path: <netdev+bounces-248121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC43D03D42
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4004336093D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84974333445;
	Thu,  8 Jan 2026 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU0hxsE9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B530B536;
	Thu,  8 Jan 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884736; cv=none; b=CeCftNI9+YH4SllruqtzrGlQmMiRoTW8ymRqMM1zfpbBxUo6X0AZFo5qBmH1GoSt5ypxPr7D2RVmWGfpic4ERi5RlxcItTZ1y9B6airFI2DvuldsFdncNh63KzArxsJBA2HrpKsYFtDfhtA9mOGNQVXZJFuOfHLg8HcAqByHrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884736; c=relaxed/simple;
	bh=OhlOQ7KmGY1tCliVjuLQ3JOxdM6RT+MpKjYTQNq49QU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oCHlluJY6OCM8Dju0+9ihMVWV5I/E9MUMZA48QMny7ULz8YVaiLpdihc51D9qPyTGUEiRz1spV60cEch+aGoDfv5FEJtF7rNHJ6YDX3dso50ytq9nsw5lJE24UVrGK09HbVs3GCSZybBsWn1pq0/uKS6dtYu5w72/ImUNCwACXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU0hxsE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826B3C116D0;
	Thu,  8 Jan 2026 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767884735;
	bh=OhlOQ7KmGY1tCliVjuLQ3JOxdM6RT+MpKjYTQNq49QU=;
	h=From:Subject:Date:To:Cc:From;
	b=aU0hxsE9w6KFlaqb5qfNSIS0DUG+I8lveyFHswoGwf3mTYDYF4JGhjA8Xo4I0ekOE
	 8kTopEsog54rnEv1qIrHiBt0vuUvHR2dG+8Gk83Bh18EKcUMykBLaQz1osIyfDLngi
	 p38i/YgRtfg+jLmOf7ND6ngyruPdVyx5pD2/wcek2KRZpVZGsd5DG4V740o32nXJAN
	 HdInwQJlDhBAkx8NfvXocMYrbSPowlJMVmG5WWIWYyuJ2xvawU4W5EOYSj4SdBEvm2
	 GjM+zSv5WGoIGARX9mctvsvCThR0cBtOovBQpzk4GB2YZ0ijRv/uTdtgmnjp5t+s4i
	 d2hTYJy7un6wA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v3 0/2] net: airoha: Init Block Ack memory region
 for MT7996 NPU offloading
Date: Thu, 08 Jan 2026 16:05:06 +0100
Message-Id: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNzw6CMAwG8FchO1uzP46BJ9/DeBhQYFGYKWbRE
 N7dQmKiBy9Nvqbfr7OYkAJO4pjNgjCFKcSRg9llou792CGEhrPQUudSSQ0+UOw9VB4GHCK9gLD
 jDtiiKfXBOGUKLbh9J2zDc5PPF859mB58vj1Kat1+TPvXTAok2Eo674yreZ6uSCPe9pE6saJJf
 0PuP6QZagpV2rbOc2fUD7Qsyxv+n74tCAEAAA==
X-Change-ID: 20260102-airoha-ba-memory-region-58d924371382
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This is a preliminary series in order to enable NPU offloading for
MT7996 (Eagle) chipset.

---
Changes in v3:
- Add missing minItems for memory-region-names in airoha,en7581-npu.yaml
- Link to v2: https://lore.kernel.org/r/20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org

Changes in v2:
- Remork memory-region entry in airoha,en7581-npu.yaml
- Link to v1: https://lore.kernel.org/r/20260105-airoha-ba-memory-region-v1-0-5b07a737c7a7@kernel.org

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: npu: Add BA memory region
      net: airoha: npu: Init BA memory region if provided via DTS

 .../devicetree/bindings/net/airoha,en7581-npu.yaml  | 21 +++++++++++----------
 drivers/net/ethernet/airoha/airoha_npu.c            |  8 ++++++++
 2 files changed, 19 insertions(+), 10 deletions(-)
---
base-commit: fd1de45ad24f24cf0aedee0f64e668674a9bd6c9
change-id: 20260102-airoha-ba-memory-region-58d924371382

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


