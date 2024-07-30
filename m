Return-Path: <netdev+bounces-114001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BFD940A29
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76E91C21198
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D519046B;
	Tue, 30 Jul 2024 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1aqt+UN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBD150994;
	Tue, 30 Jul 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325601; cv=none; b=QdqjdKt8Ku/d7jROZ5qUvOoKbfBJofc+7PmKsmVAFTkJTZCSQb2Vnerhaq01TBMNBYy30PJZl7iDgkMjWr13UtcxrvpTNYnaAVA/0Ze5kwZCU4vgVN5IRRs/lgSsZKUBiCdX1c3CzU+e/XcNNFFjuQIt24s4MDaqPzPuAwSXuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325601; c=relaxed/simple;
	bh=nDicdgSbC0TQTXrWxg5z3pQYKzM9enTJkO+htwH+xSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kiZSpWVg0CQXB1ci7YxysNL8PkMUwC0lz5BfGM86NbWSYthKBKoQG79vryAgql48NJ8kedF3m5/7frFH30NlrzrxeOrFRudLDDfwsrzbeytEQdzuZE8TU+C7QDAd3+pIYLkp7ZJEqhrvyslI2jH2ZW0Zjiu8nL66eHJrw7v1b0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1aqt+UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB59C4AF09;
	Tue, 30 Jul 2024 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722325599;
	bh=nDicdgSbC0TQTXrWxg5z3pQYKzM9enTJkO+htwH+xSs=;
	h=From:To:Cc:Subject:Date:From;
	b=L1aqt+UN3W87SncD+wV6yppB8O62mdYsv7JoPokK1hdmOhgkKbu2+lykxCgGlctLj
	 wSKJ0pDCbnp5jC/2hdBsRKWbzJ0H5pXEN1LVuzbApLcxwfMb38fOclMZ93Xirh4coC
	 3FqdjVLXItkikL3A7MdpjAF7W5aIFBhgAI+vvAZI9oj0GOvhQbGRVhZgZ+FG/SvUgp
	 J9/wjRUBUndz2l05+5uSkQdTKhJnqKjpgm/Pft+GHvlOVLNSuaoBfmoh4yVd228sHv
	 flKt3le4C1Yj7UOdmkznbjfUTFMlPGgjwPWJiuk6zObVmlXNuE1jFLH9ZvP5H8yQ2V
	 dzKM1Vrk5EZ9w==
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
Subject: [PATCH net-next 0/2] Add support for EN7581 to mt7530 driver
Date: Tue, 30 Jul 2024 09:46:31 +0200
Message-ID: <cover.1722325265.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EN7581 support to MT7530 DSA driver.

Lorenzo Bianconi (2):
  dt-bindings: net: dsa: mediatek,mt7530: Add airoha,en7581-switch
  net: dsa: mt7530: Add EN7581 support

 .../bindings/net/dsa/mediatek,mt7530.yaml     |  9 ++++-
 drivers/net/dsa/mt7530-mmio.c                 |  1 +
 drivers/net/dsa/mt7530.c                      | 38 +++++++++++++++++--
 drivers/net/dsa/mt7530.h                      | 16 +++++---
 4 files changed, 54 insertions(+), 10 deletions(-)

-- 
2.45.2


