Return-Path: <netdev+bounces-114830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7594458C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69435284187
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61F158529;
	Thu,  1 Aug 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7ikYXov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8813C8F6;
	Thu,  1 Aug 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497751; cv=none; b=I7J2ShzXaCcdzp0Az5a9OPXrVNmN0t7wJGqNU79Mlx8eINkfJgbblulGBPWxVCfgfXK5fkCjkgchy+K4PJOzl7+mvo9ayI2g7U1GZqpDjun1aD755bbAEbcFROVux54BQJGNLK5D8q0OlTD6O1eopru0ajKjN619oonJ4maLyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497751; c=relaxed/simple;
	bh=hmwI99xOs957wahotfiYm89IpJoEa6sHrmucbJj3bao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tw6SuuWEqdPIxHRuApWZIOKh2y9ECblU0ZtckX7pG7fR5RgKFnnL0rWGPHjGgWUI6ycaa7H2tce0mc8l+OvSRV/1kOyVDJHHuuShce1YZ/dTge8GkjXSny+zqEP+cGtW/BXvvG3vQ9XXYVRLvq6XQ7vzZX/zhDzWthj343MVTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7ikYXov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E86C4AF0C;
	Thu,  1 Aug 2024 07:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722497750;
	bh=hmwI99xOs957wahotfiYm89IpJoEa6sHrmucbJj3bao=;
	h=From:To:Cc:Subject:Date:From;
	b=P7ikYXovUv0Gabizyy89I2S4Zy74Ob0bxM+1z26KGLh2UyoSHHfWdTC/eNzxZeyJf
	 d2L7r6/V2wRmuGy19NUWm/O80O5vAGB+ig7aWJK0jAZYuF1noLUfHpqs4zQ7B0zmDu
	 Sfv2X+FRgiODaqO9cIRIUra3jNGM+UtwkcMhgK+GpPVTcEVljp7q+ajrqUe2an//Jv
	 9InFimQK4nig32lNRW494dAAbjNOGC/mFxT08j875BeqoDYxLXeuWElhoJ+Ws8xLDW
	 W/RtroltWeYJpQ7bRIsZf26kJw2a9WXc2eKw/b/MTWkl4VxlAQqXjxfpnUceXpQHKQ
	 PFAXkCbgOeHqg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: arinc.unal@arinc9.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 net-next 0/2] Add support for EN7581 to mt7530 driver
Date: Thu,  1 Aug 2024 09:35:10 +0200
Message-ID: <cover.1722496682.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EN7581 support to MT7530 DSA driver.

Changes since v1:
- get rid of mac_port_config callback for EN7581
- introduce en7581_mac_port_get_caps callback
- introduce MT753X_FORCE_MODE(id) macro
- fix compatible property in mt7530.yaml

Lorenzo Bianconi (2):
  dt-bindings: net: dsa: mediatek,mt7530: Add airoha,en7581-switch
  net: dsa: mt7530: Add EN7581 support

 .../bindings/net/dsa/mediatek,mt7530.yaml     |  8 ++-
 drivers/net/dsa/mt7530-mmio.c                 |  1 +
 drivers/net/dsa/mt7530.c                      | 49 ++++++++++++++++---
 drivers/net/dsa/mt7530.h                      | 20 ++++++--
 4 files changed, 66 insertions(+), 12 deletions(-)

-- 
2.45.2


