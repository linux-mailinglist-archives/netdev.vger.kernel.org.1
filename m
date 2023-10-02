Return-Path: <netdev+bounces-37370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215547B5092
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CEFA728222B
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A265EEADA;
	Mon,  2 Oct 2023 10:46:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C631C02
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ABAC433C8;
	Mon,  2 Oct 2023 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696243577;
	bh=2Tjv0Ffod7M/rpTQ3694goQOO2G2mn7yh0Za3G/AruQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DJ6OIU/Rhjy8XY451E0jFrw6U46RzwhYd0lkkFmmp/0W+EAOKpo8n04u/FPKmYa9y
	 rppKD74H3WUDGXZPcrnRSKzyV/F3lfbxckItOAJGMF48uUkZMPBsvted6nEG1vVFqv
	 56qgAgO9aYnQ61B3/fTdrd7uD9jC8IP55i2FBPgvSPEJyLWwzGI3cN/kiYvF7kwUua
	 NFEMREV7jdfFNhf7f62m6Tqej/TbZq+wLKLPp49JEn2j+MakA3AmwQnio7jiirFHNJ
	 4AkQ3ZGCi3QXI4IqM97xBPGx2VYsRZ+dARW0yTGnWAYMysLGXSYW4kKHAql+XYkjxq
	 WeUqceDIVOlug==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 0/2] net: dsa: qca8k: fix qca8k driver for Turris 1.x
Date: Mon,  2 Oct 2023 12:46:10 +0200
Message-ID: <20231002104612.21898-1-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

this patch series contains two fixes to commits that broke qca8k driver
on the Turris 1.x router.

The first patch is another fix of qca8k's regmap implementation on
big-endian systems.

The second patch locks the MDIO bus even when accessing switch internal
PHYs via ethernet management frames, since it seems that internally the
switch still uses MDIO transfers and these can leak outside of the
switch back to the MDIO bus, potentially conflicting with the WAN PHY
register accesses.

Marek

Marek Behún (2):
  net: dsa: qca8k: fix regmap bulk read/write methods on big endian
    systems
  net: dsa: qca8k: fix potential MDIO bus conflict when accessing
    internal PHYs via management frames

 drivers/net/dsa/qca/qca8k-8xxx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.41.0


