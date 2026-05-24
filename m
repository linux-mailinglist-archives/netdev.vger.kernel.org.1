Return-Path: <netdev+bounces-291215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sbpHBch8E2r8BwcAu9opvQ
	(envelope-from <netdev+bounces-291215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001D5C4968
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B86C3005769
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 22:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB5031E85B;
	Sun, 24 May 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="ZGQe6tza"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2B487BE;
	Sun, 24 May 2026 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662020; cv=none; b=D+YOzzEZSUdR/smfd5Kvnv9n3iTwDNlgUUGMrpvu/de9r65iy9loYXgC02fpPOf1Ru/wnepAk/7cC/lph6xS8FggDjyrdl006+gWza6aULKGtVajJxQ9KsuyQXUPE1BoQhCnXWjACkYc3UK8IJbG7+4wBIGP20ZbByz1wVpp37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662020; c=relaxed/simple;
	bh=P9mhS1jEiML5uhgR4qVuXTdlyunW3y7PmlIlJJsl7qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWv8ixmRfEbyq99ljwexVipR1aaV5wXklx5Lf5nO4sAI2K1CXI0fllGYHvl6/82zQw380sFfGBzSalnscor0ymugwJVWjq/umT3wKEvExbstgqPZcsUYAOJz+PkS6vtJhNqW4j3F130eU/pFXo3yLXwbkMDu9X22hgCb4S8fNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=ZGQe6tza; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 2A5F0E83735;
	Mon, 25 May 2026 00:33:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1779662010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5aXE00zz7XuRofk+goDg4OXqFtie2tJGt3iIoChcwpk=;
	b=ZGQe6tzaLwoWl7pi8zb3vLmFnv0qJfaLZ4+JtmN9//58+2rNBVj5GphNIqxQCh1ho1PflK
	LzxjmZl4FTy/rvycUBGDUlVNmIJqS4EQUp9QEnkk5Lem9ALDBcCM1JJcAX/Una6RNZh6Ei
	AN3On+MRV+Yq5DjcPJ58q+7+g3zrUIlX+9AVe7qzAbenpf1viktNadlsN/16ePfwdeE+5W
	59x5PTMvbbkuASGtZjxSOBufPzUKfpu9LxtA1m2jxh1k5dNsEOsoKro7OsD2FBrVVMxvRS
	6JeJtJsUl0Q82+hJU5Q86vJ/dn/L8FoBWC1lgM+eRzJmd8J/g+/HhMnViuv6JQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id t_dAHGQHsGAv; Mon, 25 May 2026 00:33:30 +0200 (CEST)
Received: from p14sgen5.lan (p5784d936.dip0.t-ipconnect.de [87.132.217.54])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 25 May 2026 00:33:28 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 0/2] net: pse-pd: fix use-after-free of PI array on controller teardown
Date: Mon, 25 May 2026 00:33:04 +0200
Message-ID: <20260524223306.2570676-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291215-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,szelinsky.de:mid,szelinsky.de:dkim]
X-Rspamd-Queue-Id: 6001D5C4968
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two pre-existing use-after-frees in the PSE core teardown path surfaced
during review of the v5 poll/LED series: the IRQ-vs-pse_release_pis()
ordering was raised as an open question in the v5 cover, and the
regulator-disable UAF was spotted during Jakub's review of the LED
changes. They are independent of the poll/LED feature work, so as
suggested on the list they are sent here to net on their own.

Both are reached on controller unregister / driver unbind:

Patch 1: pse_controller_unregister() frees the PI array via
pse_release_pis() before disabling the IRQ, so a threaded pse_isr()
firing in that window walks the freed pcdev->pi[].

Patch 2: the PI regulators are devm-registered inside
pse_controller_register(), so on unbind devres tears the controller
down (freeing pcdev->pi) before the regulators. A deferred disable
flushed during regulator_unregister() then dereferences the freed PI
array in pse_pi_disable().

Both carry the same Fixes: tag (ffef61d6d273). The v6 poll/LED series
will be posted to net-next once these land and net-next has merged
them.

Link: https://lore.kernel.org/all/20260429213224.1747410-1-github@szelinsky.de/

Carlo Szelinsky (2):
  net: pse-pd: disable IRQ before freeing PI data in unregister
  net: pse-pd: guard against freed PI data on regulator disable

 drivers/net/pse-pd/pse_core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.43.0


