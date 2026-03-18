Return-Path: <netdev+bounces-268970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPu3Bz6DumnrXQIAu9opvQ
	(envelope-from <netdev+bounces-268970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:49:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA332BA328
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F20B300F972
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AD638E12F;
	Wed, 18 Mar 2026 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxHlKXXy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316D36920E;
	Wed, 18 Mar 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830967; cv=none; b=LGjcToGPl2j4d9wJQUMGH5f6Ohksg//wUcZ7DeIZg8nqHXl0hnwzppM0t3R+YwOwMyewdNV4VgoyhmPQc5EJ6/QTQnlghuV+xeR7vjVPiUEotsRFcqrc+p9/ZkSyZJ8WMmx1ICl06nQm5iDSUJnCSgmIuJkZ1iaarV4IVSy+jT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830967; c=relaxed/simple;
	bh=adVL11Bn9sVPglFjef0NJ/axzG5NgUNfhBPEq00X3JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYHiEQGgU6q0U7Qla++lRbb/8F3PqcAkleYsAl/0zQT3PzBcMcpLSQhyKlvTvrDXWuVqVcrpH1O/kwNwUMSAKnu8J60Q7afXw1UWFYwGahGvcjzkOD2Vh0xyuzzyKWwlulH71ZYmwuCzTKym5Z0Ip1+GdkvrppDCyfuVblU3t2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxHlKXXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63340C2BC87;
	Wed, 18 Mar 2026 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773830967;
	bh=adVL11Bn9sVPglFjef0NJ/axzG5NgUNfhBPEq00X3JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxHlKXXyXxFnjQUGEkEwFOH5ywPaeJbF/W8uEBmlK6rbVsQjDjY10PBTn7V0+LER2
	 TOfnQi55aAtR5Eghew+pSC7EBGb/xTlXli0ksEUh+dL7SVDWSr+x0ffa9IUXxDYE65
	 jzUk5yn5DVTakAARX+IKE1D9PAYl6CuKLbBHPEr4tX1KCma6rfoPQ79ae2fK5shLEw
	 t6rG10NP6b0PlCpjsHYizh1f5Xj/8l/hWOaw3NVFZz+ueAe2jjZ7XtvsAw6qHVrxDo
	 QgK3DDoH7dnClJ0JB7gBylZGXNSWVsQmy+FJntIJnqaa+eF4OTQzaBciuO1B2QMgeD
	 yk958UE6SzY3A==
From: Arnd Bergmann <arnd@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] drbd: select CONFIG_NET_HANDSHAKE
Date: Wed, 18 Mar 2026 11:48:50 +0100
Message-Id: <20260318104858.1868731-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318104858.1868731-1-arnd@kernel.org>
References: <20260318104858.1868731-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268970-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email]
X-Rspamd-Queue-Id: 8AA332BA328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

The TLS handshake code is optional and has to be enabled for DRBD:

ERROR: modpost: "tls_handshake_cancel" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
ERROR: modpost: "tls_server_hello_x509" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
ERROR: modpost: "tls_client_hello_x509" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
ERROR: modpost: "tls_get_record_type" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
ERROR: modpost: "tls_alert_recv" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!

Select the option whenever DRBD is eanbled and rework the dependency in
the symbol so it can be selected more easily.

Fixes: fa8ef6960ebd ("drbd: add TCP transport implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/drbd/Kconfig | 1 +
 net/Kconfig                | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 29ec6ed84251..de9e232d6479 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -11,6 +11,7 @@ config BLK_DEV_DRBD
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
+	select NET_HANDSHAKE
 	help
 
 	  NOTE: In order to authenticate connections you have to select
diff --git a/net/Kconfig b/net/Kconfig
index 62266eaf0e95..769880113740 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -92,9 +92,7 @@ source "drivers/dibs/Kconfig"
 source "net/xdp/Kconfig"
 
 config NET_HANDSHAKE
-	bool
-	depends on SUNRPC || NVME_TARGET_TCP || NVME_TCP
-	default y
+	def_bool SUNRPC || NVME_TARGET_TCP || NVME_TCP
 
 config NET_HANDSHAKE_KUNIT_TEST
 	tristate "KUnit tests for the handshake upcall mechanism" if !KUNIT_ALL_TESTS
-- 
2.39.5


