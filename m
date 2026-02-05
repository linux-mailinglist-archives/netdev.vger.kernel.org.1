Return-Path: <netdev+bounces-257321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA+iHbIUhWkh8QMAu9opvQ
	(envelope-from <netdev+bounces-257321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:07:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4341AF7F3B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8551300D4EA
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3643358DA;
	Thu,  5 Feb 2026 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6p+DbVV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977F33506B;
	Thu,  5 Feb 2026 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329245; cv=none; b=mrsKOZiK09u/EppaQO8OYp7fY2qtByXRAr1VJ4KTT6mKfi6MDvQ30i4z+ScnwP5RxfghdiknoC262ZgylW+tZS9cVIsU0h48ujqQvnywKW/o5gu3MO9SBVWlD+hFCFLQY7924BBn/pP9bVdeFgR4AvzFMw3fFUEElF4Vgp8BSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329245; c=relaxed/simple;
	bh=DBHDHe0eez1p5U9j+/9fUn8+eThUGjBpKlxAzQaMngA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhHhBebf83YK2wyixXxsZRCRCgDF9Fu+Sf5S8rsxOlYUaDH/unkzpqKONgPczBcCF+COMju0ffINzjqjM2Hjl7GykmezwaG3c2mFdt1ZmOAMYAp0mnJt+tqzNLcSnq24OeQEbo3iRtS1rmIxuIkWRH49QHUzhcuFmy2Y1YpPdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6p+DbVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69140C19421;
	Thu,  5 Feb 2026 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770329245;
	bh=DBHDHe0eez1p5U9j+/9fUn8+eThUGjBpKlxAzQaMngA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6p+DbVVMb0Pi3WPEK+btOcyevLaanfhHGcSQiADQ3+NYhdwdOMc3tuT4wRLgRCac
	 1uS1bwIiz/3NVCbPaY/jVkQpY83tymSuPiCgSyR7paqmqekhScneNkUmG9jyE4Em7j
	 VS5PHmru6BRLY/JmTT9kvEHNhKuesSIDRm4pHFs89DBKuHcoFkxnDrCZbmS5Qaauk/
	 14GjUIWXxZiKSYz/LMizrRbWVAMnfxdbphxdd2ug37aqLruyDk3c5ZTo3Oc3ba/B0J
	 cmM8emQgCfZY7HPfCR3bqMNOyskkap1jbTeKuzWyW/D200558tT2sqy3lXGyHaU5or
	 cW12xyS11X7jQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/9] selftests: drv-net: give HW stats sync time extra 25% of margin
Date: Thu,  5 Feb 2026 14:05:37 -0800
Message-ID: <20260205220541.2992807-6-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260205220541.2992807-1-kuba@kernel.org>
References: <20260205220541.2992807-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257321-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4341AF7F3B
X-Rspamd-Action: no action

There are transient failures for devices which update stats
periodically, especially if it's the FW DMA'ing the stats
rather than host periodic work querying the FW. Wait 25%
longer than strictly necessary.

For devices which don't report stats-block-usecs we retain
25 msec as the default wait time.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 41cc248ac848..39a98eb2592e 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -285,7 +285,7 @@ from .remote import Remote
                 if "Operation not supported" not in e.cmd.stderr:
                     raise
 
-            self._stats_settle_time = 0.025 + \
-                data.get('stats-block-usecs', 0) / 1000 / 1000
+            self._stats_settle_time = \
+                1.25 * data.get('stats-block-usecs', 20000) / 1000 / 1000
 
         time.sleep(self._stats_settle_time)
-- 
2.53.0


