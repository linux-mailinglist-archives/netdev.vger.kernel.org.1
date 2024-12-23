Return-Path: <netdev+bounces-154070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA69FB349
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 17:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14877163D50
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6881B415E;
	Mon, 23 Dec 2024 16:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zenith.plouf.fr.eu.org (plouf.fr.eu.org [213.41.155.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBD1B4152;
	Mon, 23 Dec 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.41.155.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972260; cv=none; b=BvLivFw1tcXZVLl+1hi7pG9MJr5P3zwGnYkAf6APYPVXUDwU0OYZqdZVoCgzglGGl2aRBSgWHd3CRz6JYSsn20tU0FJ3uc4yS0AEqS3N8mnDQYB9cu29ezRxqcCyLKrElLq9EVpnZsxg/HUzKAIp+Ti6WH1QFqkIghCHqyq4yb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972260; c=relaxed/simple;
	bh=wlMEeRIXYvr6fv4DgMY6C73FcM2dTkJcnfCa6aV7z4s=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=sSCHWp3biXijOWSbHtWewotebctXPfZLaZh4i2bxCzvnYe9RzeYafXP1kElMEqMcsHALpJg8SCjEs4g3bWk/1OUGOv6gqkr09XdQkYLTn60yVVzVDTn1cnFgAOc5RUINHx8Z/VHCjV4++K4hAct8oBJriO+zDRj8iXC4G/ntkBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plouf.fr.eu.org; spf=pass smtp.mailfrom=plouf.fr.eu.org; arc=none smtp.client-ip=213.41.155.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plouf.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plouf.fr.eu.org
Received: from [192.168.0.252]
	by zenith.plouf.fr.eu.org with esmtp (Exim 4.89)
	(envelope-from <pascal@plouf.fr.eu.org>)
	id 1tPlXL-0002zy-6J; Mon, 23 Dec 2024 17:44:07 +0100
Message-ID: <10165a62-99fb-4be6-8c64-84afd6234085@plouf.fr.eu.org>
Date: Mon, 23 Dec 2024 17:44:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pascal Hambourg <pascal@plouf.fr.eu.org>
Subject: [PATCH] sky2: Add device ID 11ab:4373 for Marvell 88E8075
References: <4ba0418d-0e64-4685-a345-cc5b6bac3b61@plouf.fr.eu.org>
Content-Language: en-US
Organization: Plouf !
To: netdev@vger.kernel.org
Cc: Mirko Lindner <mlindner@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4ba0418d-0e64-4685-a345-cc5b6bac3b61@plouf.fr.eu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A Marvell 88E8075 ethernet controller has this device ID instead of
11ab:4370 and works fine with the sky2 driver.

Signed-off-by: Pascal Hambourg <pascal@plouf.fr.eu.org>
Cc: stable@vger.kernel.org
---
On a laptop with such ethernet controller, the ethernet interface works
fine after running the following commands:

# modprobe sky2
# echo 11ab 4373 > /sys/bus/pci/drivers/sky2/new_id
# lspci -kd ::200
02:00.0 Ethernet controller: Marvell Technology Group Ltd. Device 4373 
(rev 10)
    Subsystem: Samsung Electronics Co Ltd Device c102
    Kernel driver in use: sky2
    Kernel modules:

 drivers/net/ethernet/marvell/sky2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 3914cd9210d4..988fa28cfb5f 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -130,6 +130,7 @@ static const struct pci_device_id sky2_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x436C) }, /* 88E8072 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x436D) }, /* 88E8055 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4370) }, /* 88E8075 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4373) }, /* 88E8075 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4380) }, /* 88E8057 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4381) }, /* 88E8059 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4382) }, /* 88E8079 */
-- 
2.39.5



