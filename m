Return-Path: <netdev+bounces-198069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF67ADB282
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC153A2397
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F42777E9;
	Mon, 16 Jun 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmWNsdkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E22BF019
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081550; cv=none; b=BQka5RyM5U0hxX3q7GrnbWX7J+BZ47X92omzQJq3n2wUWdF6YOLKT3nAnAR0IBxmZ2N4mvN1v2aHzb6EtlvlDxUrJ5B/I6btE1VbFAG6ceqpB9NP1WxVC9B74QmGvYllIXtgVgR9bWxEBibjeZWfORwnQRKPXA4DSE2v1L8CBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081550; c=relaxed/simple;
	bh=RTUvtWJIHeJfRXaRZvoP7GhruXdkJkNjDL2jCXJOtRE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jItNk1RfjKLh7IeW0VW6xq2h+BwdaTV3CW0Ym4IoT43wtfuAPzXW3m8J9+fXsJt1wBEazyG3p3et85fZc2eR2qky9vshfmSy1/MoZf9vSbthHc27dF3pgjqZoeMc4d41ncGm2gcala++QbqymFm3h5LF/BMRej/rHEyRYu8BLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmWNsdkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB234C4CEEA;
	Mon, 16 Jun 2025 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750081550;
	bh=RTUvtWJIHeJfRXaRZvoP7GhruXdkJkNjDL2jCXJOtRE=;
	h=From:Subject:Date:To:Cc:From;
	b=EmWNsdkctCoADDzcTZHXywQyCBFhSrqhSKZJpPBH5SxlROx3RB2/NViPa/2ENnRKI
	 utQKiSm5ix1t8G4Azb+NNH7SmhHq0oae2q/kA7O/OqEUtqHKQcd/hmvwa10ZHIuw4F
	 09njSbYfB+rAm3/1VXZZhkfdcoU5iwdTkw+FhNzLlDvYIqy6gwl1/zU50Mn5KhWQOW
	 ZUTWtskPkTzJLG3ghhw6u25wm2jnqu1lP0cAFO9oqxSPg5MekIi3+Wx4pJ8QSK59Rm
	 cRLIVNOl6DZaVH2C1HFToKgtkLeO/lbmuOcFVX7qa6CQ1T9tX69Wf1lzjCkl/Fq/Og
	 OWpKq0cqnp1WA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v2 0/2] net: airoha: Improve hwfd
 buffer/descriptor queues setup
Date: Mon, 16 Jun 2025 15:45:39 +0200
Message-Id: <20250616-airoha-hw-num-desc-v2-0-bb328c0b8603@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAMgUGgC/22NwQrCMBBEf0X27EoSWls9+R/SQ0y2zaImstGql
 P67seDN45th3kyQSZgy7FcTCI2cOcUCZr0CF2wcCNkXBqNMrba6QsuSgsXwxPi4oqfsUOmdU01
 pXWWgDG9CPb8W6bErHDjfk7yXj1F/05+u/qcbNSps+7b11lb25JvDmSTSZZNkgG6e5w+OKBOIt
 QAAAA==
X-Change-ID: 20250614-airoha-hw-num-desc-019c07061c42
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Compute the number of hwfd buffers/descriptors according to the reserved
memory size if provided via DTS.
Reduce the required hwfd buffers queue size for QDMA1.

---
Changes in v2:
- Rely on div_u64 to compute number of hw descriptors
- Link to v1: https://lore.kernel.org/r/20250615-airoha-hw-num-desc-v1-0-8f88daa4abd7@kernel.org

---
Lorenzo Bianconi (2):
      net: airoha: Compute number of descriptors according to reserved memory size
      net: airoha: Differentiate hwfd buffer size for QDMA0 and QDMA1

 drivers/net/ethernet/airoha/airoha_eth.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)
---
base-commit: 8909f5f4ecd551c2299b28e05254b77424c8c7dc
change-id: 20250614-airoha-hw-num-desc-019c07061c42

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


