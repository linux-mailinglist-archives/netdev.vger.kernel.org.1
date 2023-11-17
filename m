Return-Path: <netdev+bounces-48680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294077EF342
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546F91C2042F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A422FE20;
	Fri, 17 Nov 2023 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="voctcqkI"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Nov 2023 05:02:36 PST
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD9AD52
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 05:02:36 -0800 (PST)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1700225821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yZD/Sn1R2SVTne1HGGZ4hKTypVy6dTpTjai+r/elyT4=;
	b=voctcqkI8M3/osfELiL5uRL72hNMig0TDFR1ZR7+xmlj6OJObqtE8LUvi3Qzglfs5uHBl8
	LXIe0hTkwSfX6uE4GncVWtF+JtUvwhSrxrJat6y1cVbAtjpajoljkFtpQ3Q4LBOQqC1y8D
	fGrIKupsOn6duLlxjhLty6v8vm6ONGI=
To: Louis Peens <louis.peens@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] nfp: flower: Added pointer check and continue.
Date: Fri, 17 Nov 2023 15:57:01 +0300
Message-Id: <20231117125701.58927-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return value of a function 'kmalloc_array' is dereferenced at
lag_conf.c without checking for null, but it is usually
checked for this function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index 88d6d992e7d0..8cc6cce73283 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -339,6 +339,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
 
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work, NFP_FL_LAG_DELAY);
+			continue;
+		}
+
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
 		 * work queue triggering. If the number of slaves has changed
-- 
2.25.1


