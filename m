Return-Path: <netdev+bounces-110857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9B292EA04
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E7C1F23164
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29441607A0;
	Thu, 11 Jul 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PaRSJRI0"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6334CE09;
	Thu, 11 Jul 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706157; cv=none; b=DVd1PA+RUL5zMS0qMb6Ia1Gj93ILXUfxu/EazAMl7shCCrzh8iCdRVU+kk1cn1ibQX+JBVLfblHNNepiZFSvbLrrFsokPUrOCxhnrm1q0H0pbjziC4grzyefPZ7vHCXH3b4MwI5Xk7QfLkB9V5Tm3hBmF7IT6V8McgCOfOXZCJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706157; c=relaxed/simple;
	bh=L7usCHDaVACaTClnTKJXkkwRy0/lN/L4DvB8pcrdI4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MdKWPQKTJHqiEEP9WSnVdEOzsyBqHB0m4MupOY39B0oLVVJB9tgPwR/nV5P/exabB7qShz4XrEoqL7rAtFgJ46DQaN3n4hlyC9sWC6HHULvQsMP5Pdg0vbWQyIAgjYtrphUuDRNTyh2QbegU4EpQ14Ravd3jNbUTWUYVy6y7QT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PaRSJRI0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDB43C0004;
	Thu, 11 Jul 2024 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720706153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rt2/AtZ1Iqo+6uK6QUDvJTbEKbnlhmjWhOIuc5JOZsQ=;
	b=PaRSJRI0iXH4h67PKz2acSgBROrc6x6Jv2/zBCdDTB4vFirJJbBM5PjwF9qHGMGDqVtKkI
	V9BYeyzURNXK0jI5ZErOFJAO7mG9pFji1dXV36JwWi7RwV1OiRQtuUkWT3hZmwMV8CtWbU
	9msCotbvyLVx69xXKZdNqOMXx8QSXnJuqjq/P2MR21OMYPAaoDZ+1vFFWnh8nLp39DjfHb
	aEvKrNmN4i9MgLjlWOfIeyBJ4IGWQth+nx07E1ISyNUQ8tRFrYxAKFNcl0+MafBizzhnUe
	qyIsdb5noUXYrIR6Z9mVFD2NvTAAFYhOE7HWlSXeGqreZlTV2KGpZOnPgmhZyw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net v3 0/2] net: pse-pd: Fix possible issues with a PSE
 supporting both c33 and PoDL
Date: Thu, 11 Jul 2024 15:55:17 +0200
Message-Id: <20240711-fix_pse_pd_deref-v3-0-edd78fc4fe42@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEXkj2YC/x2MXQqAIBAGrxL7nGA/aHSVCJH2q/bFRCOC6O5Jj
 zMw81BGEmQaq4cSLslyhAJdXdGy+7BBCRemVre9tk2jVrldzHCRHSNhVcZb1gxtBt9TyWKRcv/
 LiQJOmt/3A1ZaMH5nAAAA
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Although PSE controllers supporting both c33 and PoDL are not on the
market yet, we want to prevent potential issues from arising in the
future. Two possible issues could occur with a PSE supporting both c33
and PoDL:

- Setting the config for one type of PSE leaves the other type's config
  null. In this case, the PSE core would return EOPNOTSUPP, which is not
  the correct behavior.
- Null dereference of Netlink attributes as only one of the Netlink
  attributes would be specified at a time.

This patch series contains two patches to fix these issues.

Changes in v3:
- Add a cover letter and the net prefix

Changes in v2:
- Add a patch to deal with null config

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (2):
      net: pse-pd: Do not return EOPNOSUPP if config is null
      net: ethtool: pse-pd: Fix possible null-deref

 drivers/net/pse-pd/pse_core.c | 4 ++--
 net/ethtool/pse-pd.c          | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)
---
base-commit: d7c199e77ef2fe259ad5b1beca5ddd6c951fcba2
change-id: 20240711-fix_pse_pd_deref-6a7d0de068a4

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


