Return-Path: <netdev+bounces-291749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEHAOU7AFWrRaAcAu9opvQ
	(envelope-from <netdev+bounces-291749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:46:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D905D8FD1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24A9B30242A9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4AF36F915;
	Tue, 26 May 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMtMCdoB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6536D9F8
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809756; cv=none; b=EL1HK27LyetVLBCKDXiIP/uCUzJvY/8O8nD/1Qk70uRfCkz+g4splduXCk6jPRM3au9LwI8X251rKnXDcnMfjANF46d2iaNui/I641AqniJfnLqhc2c82/qk5agqUon/wz/LZa9TXT0sATuJdk4yTak3VmEgySHjj4yzQtmwY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809756; c=relaxed/simple;
	bh=jiI6JVqUd40KITCoI3z0+3aaLBxavhh/lPPGbglhYxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM57GM/PI0ScmdjhO5x9JPdIrD8uh3FR7GywplY9QToYWmeju/ve2MMuHJmgDTaKvFXRBHV2gSv5nuCDbKz1Nd6OkDmAGS8kiWNxJVAjape2n5P7RUwel0igd1ZhUwb/Xe4oLsbeE3OE7xw0fQQjsJsSpZrO3g+pWLbwq4k0MeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMtMCdoB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDC31F00A3E;
	Tue, 26 May 2026 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809750;
	bh=YBc0rxKZ/y2qlKn+HBCpEnHt70rPi0oczGV3YS6kwSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HMtMCdoBk2C3luMJFoXvc1Kn7RvAZZp2Bu0zojx7Od+9rtmp9s+XEYhiU+FmgIU2G
	 Ruql4jp7TW+kFsYqclXj3OA4zW7eI8Dsgfcg0wBdsaRpUrDrs/4l2Trwy7W3pgRfH1
	 7svElaRRqvUkAZDa5xGLROy+93F7rEt5yn6cKGa4WoAj+XFP/FwJ30TyvvEdcYQejf
	 UV8m1Iv2r1GDp2u/HSyzcNNiO/2mQrwCUC5LLsuNhzB//Y7Y3ntP/9+wGTECNnU6l9
	 t1SBJP0s87RRFOFR/QHVHddjeoYSFMal8vDMsX8IhESPTltXFaO7KgWVXes4xM01bh
	 uD7/k6bWAIRrw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: [PATCH net 02/10] ethtool: tsconfig: fix reply error handling
Date: Tue, 26 May 2026 08:35:25 -0700
Message-ID: <20260526153533.2779187-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-291749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,lunn.ch:email,linux.dev:email]
X-Rspamd-Queue-Id: 73D905D8FD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A couple of trivial bugs in error handling in tsconfig_send_reply().
If we failed to allocate rskb we need to set the error.
If we did allocate it but failed to send it - we need to remember
to free it.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: vadim.fedorenko@linux.dev
CC: kory.maincent@bootlin.com
---
 net/ethtool/tsconfig.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index e4f518e49d4c..e9db4ee2299d 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -224,16 +224,21 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
 	reply_len = ret + ethnl_reply_header_size();
 	rskb = ethnl_reply_init(reply_len, dev, ETHTOOL_MSG_TSCONFIG_SET_REPLY,
 				ETHTOOL_A_TSCONFIG_HEADER, info, &reply_payload);
-	if (!rskb)
+	if (!rskb) {
+		ret = -ENOMEM;
 		goto err_cleanup;
+	}
 
 	ret = tsconfig_fill_reply(rskb, &req_info->base, &reply_data->base);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_free_msg;
 
 	genlmsg_end(rskb, reply_payload);
 	ret = genlmsg_reply(rskb, info);
+	rskb = NULL;
 
+err_free_msg:
+	nlmsg_free(rskb);
 err_cleanup:
 	kfree(reply_data);
 	kfree(req_info);
-- 
2.54.0


