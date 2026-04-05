Return-Path: <netdev+bounces-275419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGvRHtWm0WnDMAcAu9opvQ
	(envelope-from <netdev+bounces-275419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 02:03:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D196F39CE68
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 02:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CC273006B06
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 00:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FDEBA45;
	Sun,  5 Apr 2026 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="BtDlb1nT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719640DFB1
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775347410; cv=none; b=RtYsCOvg54TDX16YiArnbxyWh8ctvpCG49C/U6dactFmoLPJ7ZFCiPqRtJa0TGqjpWe6Mb58QsFCnd8O19IZgGdvVLBlPoqpg7qy4Zllz4pR2dGBZRhXfcc/jmdFnns6GPDbWRB9bfOgzXp+O3o1SPLpFZdjXlZJwHlesfrSjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775347410; c=relaxed/simple;
	bh=eT0BY6+jZMne8BZ+Ndpq/aSw3ClUrczrR89b+z8vpLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hylPPcm8CIzPU0rCZ6gnRNOqdoJQzeIbyOrhV23avroNr6oqz9/enUfxih3s+smI9mhlYqPZiOSb+5MVpMRUwfJ/G/BwUye2sgeUDxzrR+ke8c0wAgsyT/u0S6OP/uxki3tfTFaU83O6wr1BZ8vuFlfIg/d90OZEARrnkRcrGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=BtDlb1nT; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12bfa7fe691so3282106c88.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775347408; x=1775952208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZAq/JoXbDsaB10E9ei7z4Jwk5QHy8JrT6TkV/e+ag4=;
        b=BtDlb1nT9QNkG6jXGKGy1fCDuaMQ/GBU803I6L3cjUSyjwZmig5a394BKB5kfjtBOv
         MbyaQHiKeAuPNKwBItHAVecpDNt9UB0zRDp43Zy+02FKuos3xo9MWxCRTX3Lt1NqWPMb
         zC4s/RxcUmuEmpz4dNYw1YVwNnNocJ1c+W6gyzFmbd/HHIXRrmGRNtH5Apn9hVnEo3Og
         gCSOSngdaYlzVMY/5CrXYFTuWK2XSQEXE1aCnaqvJK9j/CTbVxmkJ5xBSxCe0tyeawYw
         MoUNCI5G2x2LMUaBqU04+99OLZIaYLsVNXydiasH0vA1OA0whhPU7BXoDN6UllwW72yG
         TG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775347408; x=1775952208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZAq/JoXbDsaB10E9ei7z4Jwk5QHy8JrT6TkV/e+ag4=;
        b=BOsSwfR0zQT6FtS1pFhGsKEN0di/surAULy26iFsTFkWBQX9LnVafRD31/pKLh8sai
         ovziRcVqht0xnh51IgslAQgdsd36ylC1aGPNhaBZInV2Kh/7mfP02mGnfLpOIhAnHsCV
         ON9KRNr5+bzBN4dQkttaRvaabuiMTZdnnBv3Sq9044OqDZBjffi6CSkfGENDkRdvhcQa
         q6U3jhy0LQQWtsDGzDFtFzH6diVE8FpjkRZrIkoOx1v5UBLzEMlwCfgrgGOuK99flrLX
         YE5o3LgVjRIG6Sq0jksoczjZEaY+a9G3asENeQsa1GWOKeFcws/5A5zDlVBhrKXl7r8b
         g5Rw==
X-Gm-Message-State: AOJu0YzuGmTdjdYV+sgsgP2ygt+lgCmT8YrK+1nbBqEKsl4FuwZGwMQB
	379O3HSIQQMILWSErxdzChVBaUI6mtNuYz4CziGLPBfRz0auDX+WA7PW+3BokOqS2D4tDDhCHWo
	fMHGrIw==
X-Gm-Gg: AeBDievVsFjNkO0vThKAxDtAgjN1rm0yMXcljinTKUXEIb3dCDFcAlGRBV0prOlTEkY
	GxvqDspAmjK0kJsCMRdbAMUgF0h+SkNSvOOdXQTk9dtX/ZVBfQ1ak987SAs9/MO+sHrizfiiKyz
	a9TNoREsZuUe1gfQ+jBxjsX/e1JtJ9nhoG9WeeiX7A8jgcDmNzh4UOwFvM91LO+/efmiIO12z4O
	/gVHSrXXgh89lnGbufbEh6ZtMmyL35Zx5B3RJkqtHqsWc7I2U4j4qdoRM8ASfbELayWAAdSW+RM
	tTe12QjxuUZC65LBvqe5p2XM3CDTo/F3lWcuagEjXyCCCL9bPVkrtkuDNJKlfB8nqcO+/zRNBgQ
	JyM3SCr3yKTt2cl1BjFkEo2BVGn1GGExvTekBouUXzCphVZrIkkQPh1EE1YqwSguQwsDnYa+dqe
	+frNBf96V/pZlXZQdbiPUFLz0oksDD2Q0aWaa+1oRseV3vhAkbyqyJCg==
X-Received: by 2002:a05:7022:418f:b0:11b:88a7:e1ac with SMTP id a92af1059eb24-12bfb745142mr3572419c88.19.1775347408405;
        Sat, 04 Apr 2026 17:03:28 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c07a8703esm1567831c88.8.2026.04.04.17.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 17:03:27 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] bridge: cfm: reject invalid CCM interval at configuration time
Date: Sat,  4 Apr 2026 17:03:24 -0700
Message-ID: <20260405000324.548623-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275419-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: D196F39CE68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
the configured exp_interval converted by interval_to_us(). When
exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
interval_to_us() returns 0, causing the worker to fire immediately in
a tight loop that allocates skbs until OOM.

Fix this by validating exp_interval at configuration time:

 - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to [1, 7] in the
   netlink policy so userspace cannot set an invalid value.

 - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
   not yet been configured (defaults to 0 from kzalloc).

Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Move validation out of the datapath and into configuration

 net/bridge/br_cfm.c         | 6 ++++++
 net/bridge/br_cfm_netlink.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 118c7ea48c35..dea56fffa1c1 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -805,6 +805,12 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const u32 instance,
 		goto save;
 	}
 
+	if (!interval_to_us(mep->cc_config.exp_interval)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid CCM interval");
+		return -EINVAL;
+	}
+
 	/* Start delayed work to transmit CCM frames. It is done with zero delay
 	 * to send first frame immediately
 	 */
diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
index 2faab44652e7..1bb33c8f587b 100644
--- a/net/bridge/br_cfm_netlink.c
+++ b/net/bridge/br_cfm_netlink.c
@@ -34,7 +34,7 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX + 1] = {
 	[IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]	 = { .type = NLA_REJECT },
 	[IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]	 = { .type = NLA_U32 },
 	[IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]	 = { .type = NLA_U32 },
-	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = { .type = NLA_U32 },
+	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = NLA_POLICY_RANGE(NLA_U32, 1, 7),
 	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]	 = {
 	.type = NLA_BINARY, .len = CFM_MAID_LENGTH },
 };
-- 
2.43.0


