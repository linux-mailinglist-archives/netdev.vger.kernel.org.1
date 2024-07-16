Return-Path: <netdev+bounces-111667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97653932086
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6571F2257F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6716208CB;
	Tue, 16 Jul 2024 06:43:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623B1CD31;
	Tue, 16 Jul 2024 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112239; cv=none; b=q4B6yw5lniPNOK3fPxMmiCUvscSC7OfQ/98eTXvN2Oaxtz0EtkHtxjgT4+ReWHRQapK70R/nZYbZRV6Unkez3KeuwVN2DqbJtIeNBfY/TtW4UzbW8hUbBAPSQcsq22NeuO7k8Hc3Y6PVlLh8utw+igAeCGssklEbQuoW9tnlJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112239; c=relaxed/simple;
	bh=G50rzP3LUFZmy7R3InuDex67Bo9NGsVbQFy3/r5Hprw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vE/KhLctou6Xb72gyGJDzY7HTwbqdtAXhusgiE1HEi0/zp/FiAMKa7+c60C6bd0JytRfbuFOXKzFoOIn87KBL8b/k9tYW0piYaQzFk39aa/UeUBk9MU5Q6yzh+EEyLnRwNVRcJ4dYvmr5SoEynVm5Ju89i11S7YL1J2tK4rtLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid02-cd.amlogic.com (10.98.11.201) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.39; Tue, 16 Jul 2024
 14:43:47 +0800
From: Yang Li <yang.li@amlogic.com>
To: Kelvin Zhang <kelvin.zhang@amlogic.com>, <xianwei.zhao@amlogic.com>,
	<ye.he@amlogic.com>
CC: Yang Li <yang.li@amlogic.com>, <linux-bluetooth@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] Add support for Amlogic HCI UART
Date: Tue, 16 Jul 2024 14:43:42 +0800
Message-ID: <20240716064346.3538994-1-yang.li@amlogic.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for Amlogic HCI UART, including dt-binding,
and Amlogic Bluetooth driver.

To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Yang Li <yang.li@amlogic.com>

---
Changes in v2:
- Employ a regulator for powering up the Bluetooth chip, bypassing the need for power sequencing.
- Utilize the GPIO Consumer API to manipulate the GPIO pins.
- Link to v1: https://lore.kernel.org/r/20240705-btaml-v1-0-7f1538f98cef@amlogic.com

--- b4-submit-tracking ---
{
  "series": {
    "revision": 2,
    "change-id": "20240418-btaml-f9d7b19724ab",
    "prefixes": [],
    "history": {
      "v1": [
        "20240705-btaml-v1-0-7f1538f98cef@amlogic.com"
      ]
    }
  }
}
-- 
2.42.0


