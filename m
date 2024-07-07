Return-Path: <netdev+bounces-109685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 483869298CD
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 18:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EFEB21BCD
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502814436A;
	Sun,  7 Jul 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="Pdxrv9e5"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4A3AC01
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720369048; cv=none; b=mrB/S+5wvAopKdKB86Ap2iz0bQmxhV93K51r+x2al2+STKk66BgXguchVcBlV7dRWIF9/GUU00neBLIIm1Mq/3bI6aiLXivrs737dgyAzV5nJtpEcTffvDhL9O5I3sWZ8NBpncs2Z8/lf8JCB1yAGLvLNbCTvppeSFHqA/c3qsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720369048; c=relaxed/simple;
	bh=8LHfo1rOAaQlxdS3v/jalYjcSDAndZe5MOazuNAN9xo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YwVpvDqZ5/JAVMUs1DcYUP5JREKUDYG8eHzFCv5auKuKwaNkLrnZZc0gOuW0hy2sS+q+RyUayvd1VZl1/AVy5pRQqfqxVUbYqN3ESoBfxVBJSlQBgODIvzTHE+J8EDpH0j8+Lxyk/SlryPPbrc5T/63D3WRsv4k/tEiAURYjRdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=Pdxrv9e5; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 5204 invoked from network); 7 Jul 2024 18:17:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720369041; bh=CCkAjOCiFaYK53JrnmxFZ2Ne9oZgyxcNpzrxjvr891M=;
          h=From:To:Subject;
          b=Pdxrv9e5fNeSSFAVSKZ1ah9Hx09tmDmTPjr7cmhD99wvwK88Hdw442LX0E+36TUnM
           DX6sY/2saZYAlOKja9k2jolVOL/hWWAqujmpTzfxWXYt1k/dMs25sKqrOI7SDrB8Ys
           G9nyx9wCX+dNJhwkR5viUQUipajBij90kxb/AFHo=
Received: from 83.5.245.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.245.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 7 Jul 2024 18:17:20 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	u.kleine-koenig@pengutronix.de,
	olek2@wp.pl,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH [net] v2 0/1] net: ethernet: lantiq_etop: fix double free in detach
Date: Sun,  7 Jul 2024 18:17:12 +0200
Message-Id: <20240707161713.1936393-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: dcc5dc2a3b3bc3e7b28cde8500ac2682
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [oQMk]                               

Changes in v2:
- Wrap line around 80 characters

Aleksander Jan Bajkowski (1):
  net: ethernet: lantiq_etop: fix double free in detach

 drivers/net/ethernet/lantiq_etop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.39.2


