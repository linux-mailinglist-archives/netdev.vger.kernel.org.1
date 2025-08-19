Return-Path: <netdev+bounces-214938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6DB2C389
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C825A6C4F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18924342CAB;
	Tue, 19 Aug 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV7UHce/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE6342CA4
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606083; cv=none; b=g4cHcrSJLuCEeNrYjQJkGrCfuaiEL8l39J5rA5ScBaJ0kXlhqZLlmQE3mNl3Zseu/ymEH3uA8c2j2Wilk9PpWZR02tQnxpzRSF1AlSKONXcKigh5c2lZVdTjK3ZIMZdqVzBt9myKOMzf6h5EDmlpXcPNgiqiwEBhcFlR5JtTU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606083; c=relaxed/simple;
	bh=kXp8GWA0rgI3EgE6rlfYCc10wvDZVs53PRBwMH6HPlU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CKZEZDSQT8SGiC3ME8kVyuM95RpkE5Rqy0DZ4CWsE5HUT2x+mEv8Q8YQBDFzSWde5AGEK/aQWNZhKFdc4yD0aRzNGltaK63KR5YNE2xZBPqzBUfF6clgd1EdyT0jF7ySKxXyuBHZp/Zr3U6l2ctKWMxq9ZvDeexCBtmgeLCCax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV7UHce/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7205BC4CEF1;
	Tue, 19 Aug 2025 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755606082;
	bh=kXp8GWA0rgI3EgE6rlfYCc10wvDZVs53PRBwMH6HPlU=;
	h=From:Subject:Date:To:Cc:From;
	b=ZV7UHce/2o7Aawu1yMkCXiy9gdcDEVS6mjdvLFJBxjQOCT3clfOyIIbpeoMQ0QVIO
	 Z176ti1kidYT5aVWIsu60Cik6ProTOpJlZEpxAAO1qa8qy88VHD+QrdQLU5MHFIs6/
	 fuUMLjNuYbDXYmfkSLe5Q/oFBj85i+TXbOj96y9yU76Es8GtFfosedV3GSA6q2xwMN
	 ri1MPS+latxWlqJow9jfvHXMYNyp7xgfFlTvqXNY1atXimMYYr6o4B+RN29+Ybqskw
	 xz8Uc5Vs4GfviE9Rdf9OIYUfE9FmzviNKtSYjLgl5tCiHNE8Kye2joy263BWWhISzg
	 UaFBY3FKJ2KMw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/3] net: airoha: Add PPE support for RX wlan
 offload
Date: Tue, 19 Aug 2025 14:21:05 +0200
Message-Id: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFspGgC/x3MSwqEMAwA0KtI1hOw9TtzFXERNNGAtEMKKoh3t
 7h8m3dBYlNO8CsuMN41aQwZ7lPAtFJYGHXOBl/6puzdF0ktroQcuqZ3eGwU0E6MIlukGZ1nkba
 dxFc15ONvLHq+/zDe9wMZrtlAbwAAAA==
X-Change-ID: 20250819-airoha-en7581-wlan-rx-offload-12eff66cf234
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce the missing bits to airoha ppe driver to offload traffic received
by the MT76 driver (wireless NIC) and forwarded by the Packet Processor
Engine (PPE) to the ethernet interface.

---
Lorenzo Bianconi (3):
      net: airoha: Rely on airoha_eth struct in airoha_ppe_flow_offload_cmd signature
      net: airoha: Add airoha_ppe_dev struct definition
      net: airoha: Introduce check_skb callback in ppe_dev ops

 drivers/net/ethernet/airoha/airoha_eth.c  |   7 +-
 drivers/net/ethernet/airoha/airoha_eth.h  |  12 ++--
 drivers/net/ethernet/airoha/airoha_npu.c  |   1 -
 drivers/net/ethernet/airoha/airoha_ppe.c  | 113 +++++++++++++++++++++++-------
 include/linux/soc/airoha/airoha_offload.h |  55 +++++++++++++++
 5 files changed, 151 insertions(+), 37 deletions(-)
---
base-commit: a8bdd935d1ddb7186358fb60ffe84253e85340c8
change-id: 20250819-airoha-en7581-wlan-rx-offload-12eff66cf234

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


