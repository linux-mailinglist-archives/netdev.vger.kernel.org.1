Return-Path: <netdev+bounces-282422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL7UKE0h8mm/oAEAu9opvQ
	(envelope-from <netdev+bounces-282422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:18:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8EB496B15
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA0E33002296
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4C9312831;
	Wed, 29 Apr 2026 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OVxeak6B"
X-Original-To: netdev@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9C330647;
	Wed, 29 Apr 2026 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475515; cv=none; b=uUU/ktwK3jdDovs7wh0ECuXOg5V5TmpeD5AUIQNr9XvE4l0k8qLHJ6wPbPfWI7GdN3GZ2sUl8Pvknpj4vIvR4sXrPBGBVF2h8l/wZFRsN0pdgtvoWdfLI04OGUOYid25JLsiYn6W8msvsY3rOPkGwNUtVY2fII6Km6hpdoKO66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475515; c=relaxed/simple;
	bh=3UR++BeS5c+sreQGfv8/5xNW8PFw4JqI3NKjVMn1qzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/O1eWBtWo4vLpnF8aIeVT0ZK+X5PQ+O2rOwf99NuQqYIzCtQrn+1KeODchzJCwXDQKh0btfhPki7IRy+oRgGPOzwYF4xXgp6MrM755t0iiZy16PfrfQjPPPiG0G6gGbO9DgxgZaTi69X7BoCWy7K9avOshmVSikwovKT+Q4hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=OVxeak6B; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:638c:0:640:aae5:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 19C40806EF;
	Wed, 29 Apr 2026 18:11:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp) with ESMTPSA id dBcjYW3YKSw0-Hcvx5Goz;
	Wed, 29 Apr 2026 18:11:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1777475508; bh=0r8LOIgbDyLwek6hXKZtp4Lb3fZVq6pms/tQIP/iL8w=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=OVxeak6B1NIWWwJ73c8wu8B/JhhH7aOwPHXEgcMvSgxU0EJIl5rlH+f/sfHRysfn7
	 jQ2b1y2qo+l6CLSaQk1hbxDlyFUvoKKBpjqBnt/ATIzsAt2DRLgsEhIWNrL6hEUqq7
	 Z/D2NKdns1tvdk6AhfiKEy1W8PcIK34tyiMX4/T0=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	horms@kernel.org,
	darinzon@amazon.com,
	bhelgaas@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix division by zero in qed_init_wfq_param when all vports configured
Date: Wed, 29 Apr 2026 18:11:33 +0300
Message-ID: <20260429151136.19308-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C8EB496B15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[yandex.ru,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amazon.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282422-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

In qed_init_wfq_param(), variable non_requested_count can become zero
when all vports already have configured flag set. This happens when
num_vports equals the number of configured vports.

The function then calculates left_rate_per_vp = total_left_rate /
non_requested_count, which causes division by zero.

Add a check for non_requested_count == 0 before the division. Return
error when no unconfigured vports exist to distribute bandwidth.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 42c6dcfb1f0f..b287e04c8adc 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -5105,6 +5105,13 @@ static int qed_init_wfq_param(struct qed_hwfn *p_hwfn,
 
 	total_left_rate	= min_pf_rate - total_req_min_rate;
 
+	if (non_requested_count == 0) {
+		DP_VERBOSE(p_hwfn, NETIF_MSG_LINK,
+			   "All %d vports are already configured for WFQ, no unconfigured vports to distribute remaining bandwidth\n",
+			   num_vports);
+		return -EINVAL;
+	}
+
 	left_rate_per_vp = total_left_rate / non_requested_count;
 	if (left_rate_per_vp <  min_pf_rate / QED_WFQ_UNIT) {
 		DP_VERBOSE(p_hwfn, NETIF_MSG_LINK,
-- 
2.43.0


