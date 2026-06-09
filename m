Return-Path: <netdev+bounces-296927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 33GLDmm4J2pw1AIAu9opvQ
	(envelope-from <netdev+bounces-296927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:53:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D74465CF4E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:53:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=CJPIU0qi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296927-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296927-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA4D830031E0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 06:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909FA3D6497;
	Tue,  9 Jun 2026 06:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2D3D3D18
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 06:51:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987896; cv=none; b=B0DD7s1+qJByVCXrPZmUGf+/WOvsEfmDnOtxbEKBSIXY0RzzEVN65O78rgzDh2duMBiX7tncpAASqcpR/nynGGDSwa7TCY5i/YptbY10bQbKz1i5+pJv1cFGn+G2yv1M6AIATuEUiUFUiNKeeP3WAqnfTto5SGfsCUFTeZG3Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987896; c=relaxed/simple;
	bh=Vteap/nHF7sQj3OHKsy3ErbiZFhlDHkL1pW6lncRNG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICJVJ2K08ylfDv8VaAjhcdd679uHiiqBV3fysd3yW++YdusC1CaFR54mB6aAynWBFE+B8/6jBXQ2Sow8Rgsx0tdPxiXqpnIYNEnp91riiSASGHNtD1k9f7LtgLMD00rOTyKOQ1kcLw8Lu3oNJqUHFyGQ3i3IY12u44SA1JFmarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=CJPIU0qi; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso35250405ad.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780987893; x=1781592693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUoCgjqP8cJvxOnwB2NaZqkz+8bhLbudTMsyg7OmkZg=;
        b=CJPIU0qiGGGdSpWrgrNrNTIb8nOLqySuIdweAFx9W9/RRhPb0UqaKqJGYEgxi87Ckb
         5GwBGqHQmmh5wvlNr4d5eJbUxzk02znG1wvJbjCV3GAJReJfIc3bQ672bNI5mA1RW3Zx
         0oDQMgwPQEpqNlk7HIass2ju5o4e2OuydDgWAAaMstevvENo7KvBKb4HyMJUE1fw3/sx
         dap0xRXa8QmruillykbqEGYlAejN0EHKIgkpWCZ7rU8pmxxgUTH50OMEHsYqMjFVp2vR
         PJUiRB22H+LVzTUrPVzH/hXu+OBuRKiqAkv227hO+NuSzJ+9EA3Qj1aFpW0XWYnDiMe7
         pAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780987893; x=1781592693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUoCgjqP8cJvxOnwB2NaZqkz+8bhLbudTMsyg7OmkZg=;
        b=o2qaCXy5hMkM7WJ4dAPScu+yDmuBnjRl/XRZbSjb1NmYMZijAKf0EGom7gZ7oHB/jk
         eD5E8SGSJ+uAD8R6ZQB7afjjJEcdV98JMNQOcoWZvb0OE1x/lNRMi7oHNq7v90D4r2hl
         HpeYgW6UttBM4Q1Wpq9+NjHtTBT9UFZG8bLq0/13nysejDbDzSFpUhIIKLxL9U7pBNHv
         EDQyNRvcFagLobDfRN4jAjRMD+xyHG14TS98t/Wava1xsRNR3Yia6xC8VrIo70uDELBh
         Z7MWkEEYaF0eQBnnVZ0kfvSPBz6/4CrnlMzjZhSZNOqJVQ46Z4+oFS926yeRVDLWJPdp
         fJ8w==
X-Gm-Message-State: AOJu0Yxknf2aAdIuTW29LuNd4OZN0wYXul840cg6zND34bBU13r+LTMx
	s7ingPwAB7vnQvaE+/xzN6/Vpk1By91JAvj/LyWS5VgRBz89a352ykd8xKzgCowd7scXSCceAe7
	LwMKqofPz
X-Gm-Gg: Acq92OGm/LIvB/9K7htOjxkSFFrbSHdCy+67uMKFjTlcwbskVlqL8B9Nnxr8psVhCp7
	zzFvqtuBPhvYC70N1f+xYNiJx/v7EwTkwvG4FZ0lPAY/eM55OTWKa7ZM0G0MGTRGH43eE0GTC4y
	MiHT0Ucq3uwd55XYRkCYVtfcPKgqihdQzvKfS57Vl2FPUKFbYd2HOWMXW156N2iNWy0cV91ObT9
	eQNndZ4JGc4R/uUVZqJv2Pzlppfs746bDZjL/CnWcOybgFkUMEkC8kUeZb2rq5DuJbIU5xshxIV
	fUMZCAjSzVNnCcXWGeZ7qnS8dXOnTyf0A376hQ3GcoK/MIlZHS6moH+Lk+7bCJ+Ci4MPU17gPiL
	Tu/koch6MCe15z9KqlmBWbVdsZP6HLII+qlbeUntTizzFHhMLeF42P0/CzTKnCYyy4eW/llUPFf
	594ArlPnxZdXWqy/A=
X-Received: by 2002:a17:902:ecc3:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2c1e8339808mr212606545ad.33.1780987892776;
        Mon, 08 Jun 2026 23:51:32 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6cea3sm197980385ad.7.2026.06.08.23.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:51:32 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	razor@blackwall.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v4] bridge: cfm: reject invalid CCM interval at configuration time
Date: Mon,  8 Jun 2026 23:51:16 -0700
Message-ID: <20260609065116.2818837-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296927-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lists.linux.dev,blackwall.org,davemloft.net,google.com,redhat.com,gmail.com,asu.edu];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:idosch@nvidia.com,m:horms@kernel.org,m:bridge@lists.linux.dev,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D74465CF4E

ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
the configured exp_interval converted by interval_to_us(). When
exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
interval_to_us() returns 0, causing the worker to fire immediately in
a tight loop that allocates skbs until OOM.

Fix this by validating exp_interval at configuration time:

 - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
   [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
   netlink policy so userspace cannot set an invalid value.

 - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
   not yet been configured (defaults to 0 from kzalloc).

Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v4: remove the Suggested-by tag
v3: Correct the fix tag and avoid use magic numbers
v2: Move validation out of the datapath and into configuration

 net/bridge/br_cfm.c         | 6 ++++++
 net/bridge/br_cfm_netlink.c | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

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
index 2faab44652e7..91b9922dc3f2 100644
--- a/net/bridge/br_cfm_netlink.c
+++ b/net/bridge/br_cfm_netlink.c
@@ -34,7 +34,9 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX + 1] = {
 	[IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]	 = { .type = NLA_REJECT },
 	[IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]	 = { .type = NLA_U32 },
 	[IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]	 = { .type = NLA_U32 },
-	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] = { .type = NLA_U32 },
+	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] =
+		NLA_POLICY_RANGE(NLA_U32, BR_CFM_CCM_INTERVAL_3_3_MS,
+				 BR_CFM_CCM_INTERVAL_10_MIN),
 	[IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]	 = {
 	.type = NLA_BINARY, .len = CFM_MAID_LENGTH },
 };
-- 
2.43.0


