Return-Path: <netdev+bounces-139911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D119B4977
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40871C20ADB
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86320515F;
	Tue, 29 Oct 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Br2nHR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469661DF960
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204257; cv=none; b=bm9uz2GsZlsawS3HdfRycFNlIUBc+c3oKJoZm1wDcycsfXqVTM8Gnv1WH8f4iZfCFm46sp0KhekpJ5UjVEMm/CGUhUbRjwzEBzIPxPLzwgsWEzI1Gn3i5jiyuVd7yPUzpwZ7/OyuA4ChavVrWemZErqnUsY+PZ7wsNyRRMyfu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204257; c=relaxed/simple;
	bh=gPyUYPLZV8oxiK3WNdmSQuKs3a3P/OP4ElS0lx67Vl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BI4QfMM829d4ij5JzclK7iRGnPNP+C+T/r5PIoYmqSFinRQXBNxmkuMynslCwNMwna0ZqBLbH/eCQ0xcicK7pDabsYEF3+yJlKdqtOaiu0olXhwDHnDE8c4Xw/pNW7VAxdTsarr9vf6XO7he2OJeHWNPDf/+6PcL49ZQpO3YUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Br2nHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78515C4CECD;
	Tue, 29 Oct 2024 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730204256;
	bh=gPyUYPLZV8oxiK3WNdmSQuKs3a3P/OP4ElS0lx67Vl8=;
	h=From:Subject:Date:To:Cc:From;
	b=M7Br2nHRJWxxN5jpH5LxN5nGhvQ8VGYvIamrv9Qjss54fS1hKyeF4LLLGuJVggWpA
	 0SOxFEb0gdpfbBFmTKs6rUc1uMG8dtN+ENyrpTFjW3ifIhdUYpm1vapFoHsI1jA2gv
	 //nWPXGrPwS+mab27s2VojUcKNBP31NEPDWyFcMllyxsfkK1rDvxnhdrKxIS9Ectpt
	 sQWFYl3VvEe4JyrZTvnleBU4qR/uLv3R07VF5W8BFYKIW4SvUAAWcgFDkO5O60ZvFi
	 F73Hns2/ziggf8gd/SNPk690GE5ZB0ON3tEAWM56/A54fY4tjdSpu/WRx3CFsgIhRX
	 y+puIB6fenNBg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] Simplify Tx napi logic in airoha_eth driver
Date: Tue, 29 Oct 2024 13:17:08 +0100
Message-Id: <20241029-airoha-en7581-tx-napi-work-v1-0-96ad1686b946@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETSIGcC/x3MwQqDMAwA0F+RnA3YrnXqr4wdQo0aBq2k4gTx3
 y0e3+WdkFmFMwzVCcq7ZEmxwNQVhIXizChjMdjGOtPYHkk0LYQc374zuB0YaRX8J/3hy9jWtYE
 Cjx5KsCpPcjz553tdN1GjI79sAAAA
X-Change-ID: 20241029-airoha-en7581-tx-napi-work-312646caced5
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Simplify Tx napi logic relying on the packet index provided by
completion queue indicating the completed packet that can be removed
from the Tx DMA ring.
Read completion queue head and pending entry in airoha_qdma_tx_napi_poll().

---
Lorenzo Bianconi (2):
      net: airoha: Read completion queue data in airoha_qdma_tx_napi_poll()
      net: airoha: Simplify Tx napi logic

 drivers/net/ethernet/mediatek/airoha_eth.c | 102 +++++++++++++++--------------
 1 file changed, 53 insertions(+), 49 deletions(-)
---
base-commit: dd1b082f015317091034bee815b97d911d7a2195
change-id: 20241029-airoha-en7581-tx-napi-work-312646caced5

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


