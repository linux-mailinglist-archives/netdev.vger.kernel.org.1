Return-Path: <netdev+bounces-51569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0177E7FB323
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09E01C20BFD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000914280;
	Tue, 28 Nov 2023 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Te2WRIGc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j/pWxzrz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE899
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:49:11 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701157749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XMKvs9k0lrDJpPKqiFsLE6VhMPcM38DJ/QVMxQep/fc=;
	b=Te2WRIGcjjGUtwN5hRVhm3KaaGBek33NGtt+/bT7r02EUUjMa+ROQ1mwL5JgOZaGZlIpPG
	APdR9VT6Tab/BEjsb2t8mF0sDc1tqQw4QMmxZZrCGnv00lD+YfAfVrbk//G9lu/nHsRa4M
	30LxdWkoil6gPYShCcMpKXBM9T5q3y35DAkn8EQI+XqMAVh2CK5ynM/rj42EJVzKhKr9hA
	RJLF783YE6XBTGE0WMjqd0I9v8oJhsDPRmQpQG01Fbn6RTTc3oQKb6jEt573vp3lhuO9Qv
	OGLjxN5h3gaw8W2vRUbV5C5YxgghtHl+fTvozOSIlI+qqCPrAnNMtFJg+l7yXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701157749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XMKvs9k0lrDJpPKqiFsLE6VhMPcM38DJ/QVMxQep/fc=;
	b=j/pWxzrzdjRvt/3dNVZNDx2lo7GvDHVoHpgZPS0scjrzysTB19kcqisA6VUHxIk7ivs8Ba
	gXCDIk/eIwsBQnDQ==
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
Subject: [PATCH net-next 0/5] igc: ethtool: Check VLAN TCI mask
Date: Tue, 28 Nov 2023 08:48:44 +0100
Message-Id: <20231128074849.16863-1-kurt@linutronix.de>
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

Patches #1 to #4 are minor things found along the way.

Kurt Kanzenbach (5):
  igc: Use reverse xmas tree
  igc: Use netdev printing functions for flex filters
  igc: Unify filtering rule fields
  igc: Report VLAN EtherType matching back to user
  igc: Check VLAN TCI mask

 drivers/net/ethernet/intel/igc/igc.h         |  3 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 36 +++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_main.c    | 21 ++++++------
 3 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.39.2


