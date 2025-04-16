Return-Path: <netdev+bounces-183391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBADBA9092C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAE03B09A9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9AD213255;
	Wed, 16 Apr 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpqKoQdO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF21FBEA9;
	Wed, 16 Apr 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821867; cv=none; b=lN4Q/Cb7ygTV8eaVL0Y8P/P/ThxQpn73CYKZrYROf3fsl8Igs9fwjx3kTEEWOksT3FOTep2Cxqbe3ViI/vtwTN1S9OweiruKINhIl29zPoIPjYzUnL9cRDXiLRcwMIkkSXpTmNY8a6ieXmgFRtKf26ehiTdON8ahIYNdUbbl/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821867; c=relaxed/simple;
	bh=iqPra9prVNMgodRRIcMCpxQAVaTQdicXu+5CN0hR31c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gq0AmSyRgxA46s69jh+DAayNkzDE9QbcSKXeeAkpKpkSRYHUzh6/+LK24/v7Vls3CPHm1sZJ0OtLjWsUmPSuEkQppFRx28TxoVnAQ564zmN71SB8+ceQA0OFOhvxyhiisu9fzlMXSxEg6V6HcE0TeFRc8YOJKrNR3wPjxW+L1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpqKoQdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA187C4CEE2;
	Wed, 16 Apr 2025 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744821867;
	bh=iqPra9prVNMgodRRIcMCpxQAVaTQdicXu+5CN0hR31c=;
	h=From:To:Cc:Subject:Date:From;
	b=SpqKoQdOC+Fzgwl+wMhWLB7uh0/azwveEtf4Y3rQcBKPzr7DUUoncxexeiqi8hI3e
	 Hig6yo+Ev4QS0ps3fOhQC4bna5yzv1xljWW35iwz0g8F3fRXxpcXnt44tZz2zZ1P4s
	 IPG8LqZE2h9m7zHKXdbjBhVh3C12f8MagiFp7SO4EgY3HTIhcvZzKOiLa+LNRuQxux
	 TbS6h2mGWy0JSACTOYT/pfItaFtShDOEWTClzvzmfBTI6ZZHYIC3ckCyz2gZ4GB8Qw
	 RkdvJJFSI+IyzO72thV42V8tD8CCpktgyeFS4bmGX8CnW0oHFI/zeXGRw1M7UWv5cy
	 5Kjps87p3lyHg==
From: Philipp Stanner <phasta@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Daniele Venzano <venza@brownhat.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philipp Stanner <phasta@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH 0/8] net: Phase out hybrid PCI devres API
Date: Wed, 16 Apr 2025 18:44:00 +0200
Message-ID: <20250416164407.127261-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a number of minor issues with the usage of the PCI API in net.
Notbaly, it replaces calls to the sometimes-managed
pci_request_regions() to the always-managed pcim_request_all_regions(),
enabling us to remove that hybrid functionality from PCI.

Philipp Stanner (8):
  net: prestera: Use pure PCI devres API
  net: octeontx2: Use pure PCI devres API
  net: tulip: Use pure PCI devres API
  net: ethernet: natsemi: Use pure PCI devres API
  net: ethernet: sis900: Use pure PCI devres API
  net: mdio: thunder: Use pure PCI devres API
  net: thunder_bgx: Use pure PCI devres API
  net: thunder_bgx: Don't disable PCI device manually

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  | 13 ++++---------
 drivers/net/ethernet/dec/tulip/tulip_core.c        |  2 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c       |  2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 14 ++++----------
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   | 14 ++++----------
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  4 +---
 .../net/ethernet/marvell/prestera/prestera_pci.c   |  6 ++----
 drivers/net/ethernet/natsemi/natsemi.c             |  2 +-
 drivers/net/ethernet/sis/sis900.c                  |  2 +-
 drivers/net/mdio/mdio-thunder.c                    | 10 +++-------
 10 files changed, 22 insertions(+), 47 deletions(-)

-- 
2.48.1


