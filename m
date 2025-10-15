Return-Path: <netdev+bounces-229551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B6DBDDFF4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAEB4266A4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33731D75C;
	Wed, 15 Oct 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mrzSQhaf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA731DDAF
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524077; cv=none; b=cNk4m+s2YH/NEwtYrRyvKvvug+UiqToVTt0s6k7edq0CbZ2tKe7mkDdLCDF4hqbPZjGJiZwERE/CqWExOglcD8C1r3nKT8nSfLupJjPzYDUAnW3d/ilNvVF2QMIPyWMqZcq0Fs4HSVXEaSoCieRl2sPsuZADNcM+1pIuZyncJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524077; c=relaxed/simple;
	bh=zlAWA6lAmWBGFuiYtzMhVaY/0YT7pAq9umdSkR6GfMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvXLNLVkJClCs4ZRZ62D6cgLOsY94RvgllF8Eizd11tr+qwLh7m9DR9OzJvLw4RmZIe6MXlQH/AlAkF0NfV18jzJovWLMapa3Au2I9Z/+HL/eGgRpsD9+xLDfBtdN3FiGqBTlRWqcMuuQf/4Ytk0ugUUIDHvWf6kdzLZVEiOU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mrzSQhaf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 648741A13B0;
	Wed, 15 Oct 2025 10:27:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 329BB606F9;
	Wed, 15 Oct 2025 10:27:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56F12102F22C9;
	Wed, 15 Oct 2025 12:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760524070; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=LNu33L8ch36XV1cxGKgfSp3VX2drrLW9N8Hj5z/i8aw=;
	b=mrzSQhafXforNEw0F6kYH3MNXoL/dVHRTdiC2HIEhVwsAJ+CGjuKjlRoQ0ks59MMKitynJ
	lIZtyI9CYYmfNiciyApCb+qZyprauasRMJ9n8bFCDY8JKgH0i0ohcqhMHFe2GVN43CWtqQ
	h4wtx3/ioG62e9D5c+y4B+gJeDa3NbOnnRsrcvWYvb1gwL0fjAu3SE6YDod/NmmdzGCaaT
	HbHro0ZpyGy2LDJ1iytiHhO5kwGBfUe2wwEcGxhabSxX4utJNxQWMokrfJKeH+8AB+lLId
	YbL1o5EevDqCCSbOWpip8PDXdsQOAsLy2IvtzGcjEjfKiDVvpCIpxTB2kA+S7A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: stmmac: Add support for coarse timestamping
Date: Wed, 15 Oct 2025 12:27:20 +0200
Message-ID: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

This is another attempt to support the fine vs coarse timestamping modes
in stmmac.

This mode allows trading off PTP clock frequency adjustment precision
versus timestamping precision.

In coarse mode, we lose the ability to fine-tune the PTP clock
frequency, but get better timestamping precision instead. This is
especially useful when acting as a PTP Grand Master, where the PTP clock
in sync'd to a high-precision GPS clock through PPS inputs.

This has been submitted before as a dedicated ioctl() back in 2020 [1].
Since then, we now have a better representation of timestamp providers
with a dedicated qualifier (approx vs precise).

This series attempts to map these new qualifiers to stmmac's
timestamping modes, see patch 2 for details.

The main drawback IMO is that the qualifiers don't map very well to our
timestamping modes, as the "approx" qualifier actually maps to stmmac's
"coars" mode, but we actually gain in timestamping precision (while
losing frequency precision).

Patch 1 is prep work for the stmmac driver,
Patch 2 adds the mode adjustment. Most of the plumbing to compute addend
values and sub-second increment is already there in the driver.

Patch 3 makes sure our NDO for timestamping provider reconfiguration is
called upon changing the qualifier.

Let me kow what you think of this approach,

Maxime

[1] : https://lore.kernel.org/netdev/20200514102808.31163-1-olivier.dautricourt@orolia.com/

Maxime Chevallier (3):
  net: stmmac: Move subsecond increment configuration in dedicated
    helper
  net: stmmac: Allow supporting coarse adjustment mode
  net: ethtool: tsconfig: Re-configure hwtstamp upon provider change

 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 62 +++++++++++++------
 net/ethtool/tsconfig.c                        |  2 +-
 3 files changed, 45 insertions(+), 21 deletions(-)

-- 
2.49.0


