Return-Path: <netdev+bounces-129391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEB6983936
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 23:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9411C218D4
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114482877;
	Mon, 23 Sep 2024 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="LVYAl0i7"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB585270
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128202; cv=none; b=P6FxwqixtlohVR0nRQeFdqurRAfHe4x/J18jGgAKKck0+qJkUwHeI/aJ2FqlgkLCKD5zXGm2vXEE4PGbpHNUDNX1GZNiaBoT6oMkUtZOe8YK8bi1H8smTS4V0XZja+BPJHujAT9KP7PMCHh4PPKy63suJkYkwls/7D+2symEK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128202; c=relaxed/simple;
	bh=z/eR6ZEr6qVhLx/ZIxviz3H1/uYAycw6Adywjx3BU0U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ePUKboM8WJ2r8dZrU6nH6WpKB8F4LcbzPMb3XLUMz0Jsa+DvyB2zkNuoJ8yFhxKocXu8vD5Gkk9tz5L+FbF33g1ah2oHGC0n/mVpeNDJ9ZoECbEvKi6Z5s8vE47EBUxsTGFjEH1GBstSwX9WukA2N/o1ap7B/QdGU46QLuuu1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=LVYAl0i7; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36371 invoked from network); 23 Sep 2024 23:49:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727128192; bh=g3dTl+Q/XMqPb/RqbE9qwPxfrW7zoD7gEyQacxzuKB8=;
          h=From:To:Subject;
          b=LVYAl0i7G1OjRxJ/jlBax55l3p8br0EtZJExotB/dJS53ocI5YfR/AvoM5qMyutTP
           kP6dNXQ/AnAeenwjUWrEZmXAdjq2b92YUjccTW+nPjhOu/gnlBt4rRgoQK2jFOVHO5
           52cNiCLE70zKrOEkPqq82lxq4DdFV4xmHq8sMUrE=
Received: from 83.24.122.130.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.122.130])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 23 Sep 2024 23:49:51 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	john@phrozen.org,
	ralf@linux-mips.org,
	ralph.hempel@lantiq.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/1] net: ethernet: lantiq_etop: fix memory disclosure
Date: Mon, 23 Sep 2024 23:49:48 +0200
Message-Id: <20240923214949.231511-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 211e50a305106f4f09a30342836ac5ae
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [UfNU]                               

Changes in v3:
 - back to the use of the temporary 'len' variable

Changes in v2:
 - clarified questions about statistics in the commit description
 - rebased on current master

Aleksander Jan Bajkowski (1):
  net: ethernet: lantiq_etop: fix memory disclosure

 drivers/net/ethernet/lantiq_etop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.39.5


