Return-Path: <netdev+bounces-129141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85697DCE5
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 12:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4701C20AE5
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D81514C9;
	Sat, 21 Sep 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="pOmm+qkG"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF42943F
	for <netdev@vger.kernel.org>; Sat, 21 Sep 2024 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726916295; cv=none; b=Yfu9ae3b7enNLF40yofyXQ5BdOWruGs04HGAd0TxA5pDh25YpHTK9C1XhxzChPnP12Vq7SnjXkBTRn+9Jny3+fmllD+4bO9geUPppHXneeAkYHjMZCBtuqwOmis1t96Kb620k2SInKeDMrBL92tA7K7gO9oebK21Khw8xSbiSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726916295; c=relaxed/simple;
	bh=gBos5W5mRAfutyJyOhn+5L/09YqfpFJwzFVODPP5Ta4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=pCbFCbtF8ONVIYKeGHzf+2hmNYdnb6QMkxhba81b/FU5epKk3v3ubII4QWPEZDsrsnPVA4DHEYHjSucOE9VT7TAiX7CAvzm7GJlw7vGuo2YnUMAV09XOzzqeUlG/stCgtPGdYq3jX4ZPdgsjdL9IDZLSCS8B94GtUWL0Mklu/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=pOmm+qkG; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 25852 invoked from network); 21 Sep 2024 12:58:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1726916284; bh=XZ1zPgh5hBbHBPZOe+hQHqV6mC+CtVY3QnXEJuv4ZBs=;
          h=From:To:Subject;
          b=pOmm+qkGosRXs10OUA6yvmr2c2iU+n8NXJN0Txw9t24UrMIG9ESKJQVkXUTneUeWt
           yPUV35DgOdLkIl4Iz86dUA0zSEhwI5WpyF6LP1xV4ZyG4Z+5E70lYt/pHKhYrYN8tO
           HydeyrA/Zl6AU4gqahjiUKZAtNNhQY24MKBBVcPo=
Received: from 83.24.122.130.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.122.130])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 21 Sep 2024 12:58:04 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	jacob.e.keller@intel.com,
	andrew@lunn.ch,
	horms@kernel.org,
	john@phrozen.org,
	ralph.hempel@lantiq.com,
	ralf@linux-mips.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/1] net: ethernet: lantiq_etop: fix memory disclosure
Date: Sat, 21 Sep 2024 12:58:00 +0200
Message-Id: <20240921105801.14578-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 8c9c186f11b69236d6471e0ef346831e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [8QOU]                               

Changes in v2:
 - clarified questions about statistics in the commit description
 - rebased on current master

Aleksander Jan Bajkowski (1):
  net: ethernet: lantiq_etop: fix memory disclosure

 drivers/net/ethernet/lantiq_etop.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.39.5


