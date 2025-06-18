Return-Path: <netdev+bounces-198913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC8ADE4CD
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D91179673
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3F01D5CEA;
	Wed, 18 Jun 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PquaoUNy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FD944F
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232920; cv=none; b=EhBMuf65noYLbFbc0DsnxF+6aVmlxQ+kJ7vMipd+acZL+6Z9LiZSdWvy45tceIQHU0T4IdUjJQDTaEkknDvlLdhG6KENX1TM+U3HLw99QF+JVTTOZ8tQTkJF1rGUuZED42krK75+4tRQAbyt3rm5bpxC0RYwh2TbA+vRwFlsaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232920; c=relaxed/simple;
	bh=+/zmf0Zit1fRNlUV5u/lb+nGJi/dBvp3kAUks71W9P0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L30NNqJjBKWx2TD5+fIIhhwhnblZSV1U+lsNdfH8Eh31SKPOe0xpRLmXVvtS78lsrG2dcxrG7XTx3g/T06sXQSxQA05me55pTdwQTwqjVKPYGu64rIHO5Zgk/uIoV6UehrHscXdcwkQ4ZArxXvqnxfV+lC6yggkfOVxpjSTFiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PquaoUNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA4CC4CEE7;
	Wed, 18 Jun 2025 07:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750232920;
	bh=+/zmf0Zit1fRNlUV5u/lb+nGJi/dBvp3kAUks71W9P0=;
	h=From:Subject:Date:To:Cc:From;
	b=PquaoUNyLF0WxQ6Sx6Up9q7eFUUOgbvrZCWwkUXyfJw1MqfsvLprQF1mFmeu8jvAB
	 atmT0aOFdO/6dUYvl443aWq0i/eTS5HC6oGQLvJd+KPF+RIn1InVRFONm2IKEcvxFM
	 i5oCSTwzd8IWqNzxnXyUP1Ay643J+RVzJEgtysUR4fiEYze6AZ7gnnJZX0afYPsORF
	 gaINh7JGOtbCyf3dOBiUgEKH6ezjAjV19jmyYOhx8yYCN2hFHcsMH81TmxzykLFdRs
	 /myrgGgy/2VyjTt/a5GchaBHgckNiayogkYSkNOsTA3BkL+kuIbFXR/juh9vntN7Ca
	 CqNUsQlhDIJuA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net v3 0/2] net: airoha: Improve hwfd buffer/descriptor
 queues setup
Date: Wed, 18 Jun 2025 09:48:03 +0200
Message-Id: <20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNvUmgC/x3MTQqAIBBA4avErBsoQ6muEi1Mx5xFFko/EN49a
 fkt3nshUWRKMFYvRLo48R4KuroC43VYCdkWg2iEbFTbo+a4e43+xnBuaCkZVE4uyg2ul5qghEc
 kx88/neacP8CIWb1kAAAA
X-Change-ID: 20250618-airoha-hw-num-desc-6f5b6f9f85ae
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Compute the number of hwfd buffers/descriptors according to the reserved
memory size if provided via DTS.
Reduce the required hwfd buffers queue size for QDMA1.

---
Changes in v3:
- Target net tree instead of net-next one

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
base-commit: 0aff00432cc755ad7713f8a2f305395d443cdd4c
change-id: 20250618-airoha-hw-num-desc-6f5b6f9f85ae

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


