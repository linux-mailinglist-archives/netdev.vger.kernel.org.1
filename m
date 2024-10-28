Return-Path: <netdev+bounces-139427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13469B23F4
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F4A1F21DBC
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF018BC3F;
	Mon, 28 Oct 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aXfxEZra"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D366088F
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730091275; cv=none; b=QTfJmFW6xUDAN7KeuVTVpRzZcrsAiSRqmuR4Qfy2R3fiE4xobgH+2RlcvhrPBQtEBOpH6XzZJBzyLrrykB8tgHks/sHzAv6lL1oHCXPs2EhbgCczzCY2sYjESY8I/cifKlU18du5TNr71MIlpr79gHX4S1Yw9R8MckVkMn4Pg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730091275; c=relaxed/simple;
	bh=Zi9nBEI/a7Kn+wlTbD7uvQXpnKp2x9AN18w96em8jcQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S68YfM+zphG+Qz4BXLAODVGlHI6zQeIuTcOJPBPR5HT1Ug8UZzEGHJ0G+aEKMgNaLeZ5AcPXzCQhBJ623Uvn5A2Tgi71TjiXXKvGQNP9KuVxbKb3YZXI6PCjqOJ9tuQWGtQD6BZ7OaWschaFCsLxW7JmdLXmRZvCWhQlVhrnJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aXfxEZra; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730091264;
	bh=xOi4GHvh1q27KWtVQsFWk2kK562SeEKLJxTDDtP2aLs=;
	h=From:Subject:Date:To:Cc;
	b=aXfxEZrayXV2fySSTlf00l57x9sW04GAWrMlxihw8Jfv+Ccmm5PcT30zXX0lHCjEJ
	 3KDi5SgTFp366J+AjNUstZN2qU6sl3glI5zMfHkow5p9b8YsGpgNC1Y+we62jFd4qH
	 oMg2RI8hRRfSd+MPxD9StvelWW7MfwTf21zPgekWRQclynB0gQjQuKGYEHos7ZpdW9
	 U93DqN+7Tc6bQs29B6YC9oqUM66AGVsdWoGHcltWuVZ0MmiOB4UniJBALOepig4zgB
	 jCVbc8UqWzMq29AB+OGeYBbLs+KfvgZ8O61PBF5B/t4GW4JMy6q2jdIundh7n0s9k4
	 MVFbwdBi/a5pQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0A9D969EAB; Mon, 28 Oct 2024 12:54:24 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net 0/2] net: ethernet: ftgmac100: fixes for ncsi/phy
 handling on device remove
Date: Mon, 28 Oct 2024 12:54:09 +0800
Message-Id: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPEYH2cC/x3LQQqAIBBA0avErBswk6iuEi3MZmwWWWhEEN49a
 fn4/BcSRaEEY/VCpFuSHKGgqStwmw2eUNZi0EqbRuke+fK7dcjyUEK7MNOwmMG1HZTljPSHckw
 Q6II55w88vc+rYwAAAA==
X-Change-ID: 20241028-ftgmac-fixes-abffe9b49c36
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

We have a couple of bugs in the ftgmac remove path when used with ncsi,
when handling the ncsi_dev device, and now the new fixed-phy device
introduced in e24a6c874601.

Jacky: you may want to incorporate a remove test when running with NCSI
configurations:

    echo 1e660000.ethernet > /sys/class/net/eth0/device/driver/unbind

(and probably helpful on non-ncsi too, I guess!)

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Jeremy Kerr (2):
      net: ethernet: ftgmac100: prevent use after free on unregister when using NCSI
      net: ethernet: ftgmac100: fix NULL phy usage on device remove

 drivers/net/ethernet/faraday/ftgmac100.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)
---
base-commit: e31a8219fbfcf9dc65ba1e1c10cade12b6754e00
change-id: 20241028-ftgmac-fixes-abffe9b49c36

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


