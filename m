Return-Path: <netdev+bounces-171661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AFA4E0C2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CF51888822
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28E205E24;
	Tue,  4 Mar 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvGAyMma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDF1FF1C1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098102; cv=none; b=NVyePuI2MDk48GCZ3YzVxnLuJLUa2uHI8X2nJibT9c17oNZRo34FcwWy3j0Nyz+k6QDq9lfcPEbEUixkk7Mkf4PXxHDKWTI7Iiy4B1+OXk6oBzR78PkvJQVRvlPkMKeoeHMO1i7WSCvfPIl0NkuuvXxwRrJqq69KSjyI8saS4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098102; c=relaxed/simple;
	bh=2/A8bLCSYDyUh0Y4AMyPzn+24HBj7KeFNCpDpiY4LY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaR0qzUbQWcLfYi3DvDL+Z+swwPMdgg0XW1uQ0IaLZaxoYj5J/F8ArWKoIJe/D6/LAn48BDAcWB/O235Ub95I45wGJSIt6efD3hlEr3mcr5mzVfDhnLZ+fSLtLdvk03A7b740Tty1YYi3QnsMzBg7fLO11Kd3hhEvSimP+ELueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvGAyMma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E4AC4CEE5;
	Tue,  4 Mar 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098101;
	bh=2/A8bLCSYDyUh0Y4AMyPzn+24HBj7KeFNCpDpiY4LY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SvGAyMmaFemOAQp68fZt+MCMgrEJ6zQHJ6LyDSwbW62eXThD/6/mOFttaFAzBlYXa
	 1wNK2Akz/dBeTwp6JC2oXl8WFBQXDTgk8LjCtL3MBeUf6U9dj+IkKDUzJC4bS6Y3dr
	 UBNUL1HHOZ//3hhOX40CQCbdIS/sQTRU76gaFRJ/MgWNMWvIKqfaMWCDg9BmdNh+oo
	 mM2Jkl5dxO5lpfv0iStZZAdpakN+3vLYB59m4CvnshCu8TUlV79YrlQkUvAmBoXD9J
	 TheYNfNEiIvAGc2xq73q1jjCmmtrvUlI7MdSdA4EnFN1+ixDpqheN9Bv4Ovrr1yop0
	 p4aTUCMiGPCfg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 04 Mar 2025 15:21:11 +0100
Subject: [PATCH net-next 4/4] net: airoha: Increase max mtu to 9k
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-airoha-eth-rx-sg-v1-4-283ebc61120e@kernel.org>
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

EN7581 SoC supports 9k maximum MTU.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index dca96f1df67ee971e5442b0acfac211554accc89..f66b9b736b9447b31afc036eb906d0a1c617e132 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -20,7 +20,7 @@
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		5
-#define AIROHA_MAX_MTU			2000
+#define AIROHA_MAX_MTU			9216
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_QOS_CHANNELS		4
 #define AIROHA_NUM_QOS_QUEUES		8

-- 
2.48.1


