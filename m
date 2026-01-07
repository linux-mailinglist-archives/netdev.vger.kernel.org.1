Return-Path: <netdev+bounces-247631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB0CFCA0C
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C1A30C7146
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7E285C9F;
	Wed,  7 Jan 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYLmz/D1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB588F9C0;
	Wed,  7 Jan 2026 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774591; cv=none; b=eCSI3yE+cqe6jBElmhsq5Q7x+jjzNMxisaRIEwh8NlIKyNoJp0Sr0Sa0qLaMN1XGoftqnVlm29Jk6sZox55tztftTNuseMu6M37VWnRENiV7qUQALrnBs/Ci+tjx9egkLCmos+aSUQpevnmLpEoVho0uJgQEGCrAdBOLCxKEOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774591; c=relaxed/simple;
	bh=HQW9+MChU3xfZrpOjQ72SkTW5oqkPjogg3Ob9cZ2vWI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eRky1a1Dwc11W28l2bistDAGOIlhqq+vxGXpNXKg6bjutS3xS8HzwzLqwJHgxOJDBYc6/zTJNf/6OKc2CRqofMJXmrkOJekvebh6uZZ7aniA0kA13lM6ULWX0GfjbV5U+op2q46RXI2oFKe2jCIkGa4cbT0ZRCDrRT/eAx8uZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYLmz/D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6738CC19421;
	Wed,  7 Jan 2026 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767774591;
	bh=HQW9+MChU3xfZrpOjQ72SkTW5oqkPjogg3Ob9cZ2vWI=;
	h=From:Subject:Date:To:Cc:From;
	b=cYLmz/D1gWWf2RKRY7d6SbaCBwqzDjux/AhaEnMh1ddjl8LaCwDafgYEHTx6gGD1W
	 Zxc2YnJKHyec3L7oCalZ9YPkD7L8fxiJQQ8Ef7lXCAwCU+cJcL5reYPXkyjTkGgOzb
	 H6TLdKHXXgfo9YYcLWlFxy7gZvxN/SA51DuQkI5lwTiaUJNxj5Q4Re8pezqxu/FLix
	 8cuSTY4DMtXMcxbSIx/jCEWjgRSrnQVec/Ekp06pcBLrJAuWoQ4LDdhr5LeuBSTsnJ
	 a+AupEf3JMtUkRK5y5eUDJ+Hr3XSGja/WeycI8hhz6tnkqWk1d/iQSZ3/xMkdJZ3fv
	 SpllhAs8LCG1g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/2] net: airoha: Init Block Ack memory region
 for MT7996 NPU offloading
Date: Wed, 07 Jan 2026 09:29:33 +0100
Message-Id: <20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CQAxFr0K6tmZmEAdZeQ/DYoAKjcKYjiEaw
 t2tJC7dNHk//78ukEiYElTZAkIzJ46Tgttl0A5h6gm5UwZn3NFY4zCwxCFgE3CkMcobhXrdYFF
 2J3fIvc1LB7p+CF35tZkvtfLA6an17dFsv+nPWfx1zhYNFo3xwee+1Xu+kUx030fpoV7X9QNgc
 nPWvwAAAA==
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
Changes in v2:
- Remork memory-region entry in airoha,en7581-npu.yaml
- Link to v1: https://lore.kernel.org/r/20260105-airoha-ba-memory-region-v1-0-5b07a737c7a7@kernel.org

---
Lorenzo Bianconi (2):
      dt-bindings: net: airoha: npu: Add BA memory region
      net: airoha: npu: Init BA memory region if provided via DTS

 .../devicetree/bindings/net/airoha,en7581-npu.yaml   | 20 ++++++++++----------
 drivers/net/ethernet/airoha/airoha_npu.c             |  8 ++++++++
 2 files changed, 18 insertions(+), 10 deletions(-)
---
base-commit: 8e7148b5602321be48614bcde048cbe1c738ce3e
change-id: 20260102-airoha-ba-memory-region-58d924371382

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


