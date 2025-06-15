Return-Path: <netdev+bounces-197861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EBDADA14E
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A8C3AD902
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B21922FB;
	Sun, 15 Jun 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNVoBnr0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A71802B
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749976641; cv=none; b=KMdCMAlv3LVo8JSFpTzztGBtGJKBbTzvBfXAlEjgVwgen/sPVgfcnLTgeRQIgyuxAEZsPM7oEaR0B9nKKad/8TCwIZW70o9SJXB2C3hsjovBRP++s0rt6ihqAwwKAqZRzY5dN6GoIRHKhpJsVmAd/8a9HUI5t9n7Ik86p9fe/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749976641; c=relaxed/simple;
	bh=ya0FHPPaoMwryR5s/tkb+Pmcvo+q33+OAufiSPMpG00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AeSW8iqzj2/qb2nzGOwOVJrOIRwTxZYLAhbobso+FQlM+Ed7v66vz62Zw/+JLBi9p+m8CxBnex6pXdTJ5cp9TTfFkNDdgd7tP07jSjgYKALuHDntmBsy9k9K9qyNrbtxo+QuuEI3Mdt/kqmWO15+n14WbDTJ3ISofa++3cdmt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNVoBnr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ACEC4CEE3;
	Sun, 15 Jun 2025 08:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749976638;
	bh=ya0FHPPaoMwryR5s/tkb+Pmcvo+q33+OAufiSPMpG00=;
	h=From:Subject:Date:To:Cc:From;
	b=XNVoBnr0M2veZfT3I7ngWIgveBZLJzOQYaOujnjzIaos4jpnp5duh4xUibNY9PAyb
	 42+UcBAS31Ss0whhs7m8EQ0rxpS8ZRmvblDivX9FtKrEU0zhkEpqVMjvUq4C9IUAwH
	 gcDc0rnUO7EZbfjt24xEfgwgEM0BER2/ZeTHEXQsH5zkGZb5atoyaCiMGcexkA7MTj
	 ZYpjVARGTTUxknvO+YLsuggPKXaUQYRSo+fl4YNV5J9b7/eJg3AM1TvkLuE7FjpTN1
	 zK+OkaQA8Ed6M/N/WrWVwFYX3YPjQdhdSCU711pitN+ujP3QHEWKomY1fiBUD241Br
	 0ue5b9IX2ELYA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] net: airoha: Improve hwfd buffer/descriptor
 queues setup
Date: Sun, 15 Jun 2025 10:36:17 +0200
Message-Id: <20250615-airoha-hw-num-desc-v1-0-8f88daa4abd7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGGTmgC/x2MywqAIBAAf0X23IJKD+pXooPolntIQ+kB0r8nH
 YdhpkCmxJRhEgUSXZw5hgqqEWC9CRshu8qgpe5kr1o0nKI36G8M546OskWpRiuHam2roYZHopW
 ffzov7/sBzxMXlGQAAAA=
X-Change-ID: 20250614-airoha-hw-num-desc-019c07061c42
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


