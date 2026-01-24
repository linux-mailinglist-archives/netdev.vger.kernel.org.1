Return-Path: <netdev+bounces-253076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8YT3NC2+dGlk9QAAu9opvQ
	(envelope-from <netdev+bounces-253076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 13:42:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA57D9F7
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 13:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D87EA300A136
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23511314D0C;
	Sat, 24 Jan 2026 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="kK0yA4oq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B830EF65;
	Sat, 24 Jan 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769258537; cv=none; b=hQehFyXsoFe0RPz/NX0+UYIu4E3asL+GLveJBJ2tVpz9x+k8v7Dtb/3aH56VwGsDWwQ/+sJsDv+WI8EWMdep+qggXAR2JU18NbUl2oofFuzzckTeYmZ+1goJMqHmWb/YXrlD8IF77u9DkKWdvYMdOk9rTPcWa+dav9ICI4+hus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769258537; c=relaxed/simple;
	bh=wXbI2ebRDOoq84cZ9bB1VVhMb9QvXLCOEt8/P71oaQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uWDAlr8odVtMIEO1FAGgFn++fRW5H4ASSq2wiTyEqx9c+IsfBdYFEvvRlzCkGAFpKXgP+26i2MQSORUdATGU9p9ApSv0zYlHFbtLXfVynBTzy5bEKUYBzksD2UIZWcRMqHpB7Ab+jfKHFtzoF9u7HYWIeIGE4ZKfM59zT2HmPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kK0yA4oq; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31d4a5554;
	Sat, 24 Jan 2026 20:42:08 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	marco.crivellari@suse.com,
	vadim.fedorenko@linux.dev,
	kory.maincent@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v2 0/2] net: liquidio: Fix memory leaks in setup_nic_devices()
Date: Sat, 24 Jan 2026 12:42:03 +0000
Message-Id: <20260124124205.102499-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bf006aeec03a1kunm29d30d5ebf2e6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTU5DVh9PGkkfTUsfHkgZS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kK0yA4oqR0GMI7NdXi7UBoF/DRvqGru21aUie/JoQM1Gom5dpGF+TVa0jUTnDIm4aAVyLK/dKYR6b0w+HJ71JYyCQBjCf+6xRMBJWBqe2b3CuwZBY5+zupzlOdHd6gbAPk5D49jDd1jorWY8J2khQBpRyLRU309eS+lqafcuvSc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=AlWe/Y1Z6XVtrVx2ekD0p9HbqSA0Wn5QodoKhWiTXX4=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253076-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:email,seu.edu.cn:dkim,seu.edu.cn:mid]
X-Rspamd-Queue-Id: 44AA57D9F7
X-Rspamd-Action: no action

Patch 1 fixes an off-by-one error in the cleanup loop. Using a do-while 
loop ensures the current device index is also cleaned up.

Patch 2 moves the initialization of oct->props[i].netdev before queue 
setup calls. This ensures that if queue setup fails, the cleanup function 
can find the allocated netdev.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Changes in v2:
- Add patch 1 to fix an off-by-one error in the error handling loop logic.

Zilin Guan (2):
  net: liquidio: Fix off-by-one error in setup_nic_devices() cleanup
  net: liquidio: Initialize netdev pointer before queue setup

 .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++++++++----------
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.34.1


