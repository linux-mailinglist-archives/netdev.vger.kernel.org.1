Return-Path: <netdev+bounces-52828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5AF80050D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A089281396
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD618059;
	Fri,  1 Dec 2023 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SssFFLM/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LRDUF9T+"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912D10F8
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 23:51:01 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701417059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EqwBLovC5ct849IeQWIt3omI4kJ6O9qsyWxt4uWuYCc=;
	b=SssFFLM/u5i1R8h3UodZcrGSPlEXNIbgBJLBiIrnipg1dXAz/v6fLYLMdezGgB86mILedE
	F0mjHhyf8DHgF34gTGN0fZANdcKsnsstUBFgOWq2uYayzd5DH/LCb4TlkI4Uy9EX5dQavk
	5vg01L085IvcAqgA3W8woVyakkMM7Fl5XFQGvK9XyTk+dS3CwZRiP6Lo4kjz/sIGkaljKb
	fR31m/pRyHf0ygYt9TEdp9H1Qvb9H94uQ7SaR0SZXgrgNO7Eo5oAsGyCcaq6MJxiPWeurH
	W6cj67vKxaYxpa/wN5o9n3ld93dXHntlRSKt24UzZk7t4lrY/oTLVO60ENcRtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701417059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EqwBLovC5ct849IeQWIt3omI4kJ6O9qsyWxt4uWuYCc=;
	b=LRDUF9T+tuvT0Y2WWu751P6bOu42eJSknaAjZ2rlQNtU07K44tGHqzymNBpX0kGftMu5SQ
	uL66Dy6lpTzQLPAQ==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH iwl-net v2 0/2] igc: ethtool: Check VLAN TCI mask
Date: Fri,  1 Dec 2023 08:50:41 +0100
Message-Id: <20231201075043.7822-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

currently it is possible to configure receive queue assignment using the VLAN
TCI field with arbitrary masks. However, the hardware only supports steering
either by full TCI or the priority (PCP) field. In case a wrong mask is given by
the user the driver will silently convert it into a PCP filter which is not
desired. Therefore, add a check for it.

Patch #1 is a minor thing found along the way.

Changes since v1:

 - Split patches 4 and 5 for -net
 - Rebase to -net
 - Wrap commit message at 75 chars
 - Add Ack from Vinicius

Previous versions:

 - https://lore.kernel.org/netdev/20231128074849.16863-1-kurt@linutronix.de/

Kurt Kanzenbach (2):
  igc: Report VLAN EtherType matching back to user
  igc: Check VLAN TCI mask

 drivers/net/ethernet/intel/igc/igc.h         |  1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 34 ++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.39.2


