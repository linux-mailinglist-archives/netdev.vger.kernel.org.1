Return-Path: <netdev+bounces-296162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /nYxBSSYJGoL9AEAu9opvQ
	(envelope-from <netdev+bounces-296162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 23:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61E64E716
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 23:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=iNzk0Duz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296162-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296162-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6A5A300E159
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 21:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F13D330B;
	Sat,  6 Jun 2026 21:58:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9146274B23
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 21:58:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780783135; cv=none; b=TdOPl/8ebnDyi+KbIt14tBwMTa4NA3aYQUgWoWA+PDR8dEYZOhSxYGCreJKtpKDDjn8iwIygqoAMNKS+vo5NXPju9VNYcvimCi9U/oQygsSGDwARoYq04wt1CrpE7ZTv6ESzHdRkz+99p8a49MV9QnWfwsalIw2ED3HZnVbdceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780783135; c=relaxed/simple;
	bh=2Ps+Xuc9znsg0RNzhx1A0A8d54hT6K+VJtoW1ihaD68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9kb9zWJC6ojoDM6avxHGQ07l+SuUBAabtXmmT2ht/lRHiMRAW/m2xaCTEa/LgM0ItSMrvRAHQh3r7fM/EH8uNE4b3g3qx0eMYV5Fli9qIgM54IB6MOBMrdbsDMeNpIJ3polWkTr9w3rpbAMyVwcYEY4szvr49wHx4+SOtT2yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=iNzk0Duz; arc=none smtp.client-ip=74.125.82.181
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3042a388168so1907858eec.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780783133; x=1781387933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHjBft5h4OphRFMIcmac4iz2gVqRE8mh2c47+OSftFA=;
        b=iNzk0Duzq0xSgMP7u4wz/bfTOo1uAYoHy+/pd1CGUGnTe9zGOMG3o7YOhb7IuCd9FT
         Fl7+iOvjMSc/VCMWcHbB8j1u+ajH28lUOctYGG1B64uRTTiHdKhNUOT0c2uVGevT0380
         IwYh+WBOzG5i9bOrzgaR5Pcfjt7LeeknEuMiiaatiVnkBFCpfQggzXwGZ2u1Zh7vS5ct
         1KIEJDJ9q/5lfYSeRZ2IKq3s+FIFnd2M1wwEE/NhOrtK92dR9EFavAzgLPmMprZDvG+Y
         9agY/iyG1uHpTpfUEvBn4yDNiVO2+FaGF9VG2tEaN35vxOtSw/wexJCdkT6qtqt1KNtO
         mU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780783133; x=1781387933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHjBft5h4OphRFMIcmac4iz2gVqRE8mh2c47+OSftFA=;
        b=Z9nO8F0PknO6comER920loc2NTlrJl8k0fDkNd/NbR3wZxn5URlPpuceO64L+8qUn7
         ExWG9wWFuBj6u7f+/4ZFqhgFoEtSn9Jk0JZZLP6cI8SZvxePYUO1kvtp82jFe1Jc7WT6
         IzX002VOdycTr2RSYLCE/+tHwBfr04puLV+FgAUV4q666kEgjJ+hdB4KqevNvfZnaC8o
         B3j9txyQhiwvurCu3Qkfv6WvNNgY0gs/hvRxSUw/ud+S3hRnqIg/jETdR1dTz2GqWWhE
         IDstORxcuxpnvvC5olSXgfNXhlnzuenHTGCRIpgKOrlqRfLl56fWfNrN/STfIL8KJPkU
         1IYw==
X-Gm-Message-State: AOJu0YwG5B8pfQrWWUfewKw5+TvZs8YvVJFSMAlyYPW9MsP/2WcbRuiN
	USz4zngnIXgglLw+ufMrI3jHp0TMsbdo3w2HWZn1kQ21ILGQaR3Ftz7kqem0BeoOm0eDbpy7E4/
	Oha9xHA==
X-Gm-Gg: Acq92OE7qnVNm358YQlSBROd151yBzUj8G/fPlmPYNvECfn6j9qahp5bj8cIYKj+yYR
	4V3+PY/huH9sOWfqNk4H1j8P/9ARsmd7u2gwLEadWnswSN88r0kbEs1x1uFtB7bwDzCjSww0oyT
	mOwi88OSkRXMnPsDLnYqWQVg66cWkcYRP13xW8ECBQ/PJgntKcPKwu6PNGAE0hJ7irrie1ekATX
	G7qWlrSraCtU95hY/p/klr0N2obUtkHfbgyaiV1Li8Wak429W/Yk6dqmUTsvIuGvMlh/dVIMmk2
	Qp3vheoBYcpRFjZGx4cf46ZeGwrgAeTegwyNne5/lisx8yDsrrJFydm3glHqH5B9tBEMLjEU/UL
	SVS0F03eBkmWJswVDM224+zRcMK07iRmqE4Gj5Qwg25r0Lku+Hq5Fq7+CSrBd7FLgLbJqYJi2Vw
	asgtMWVjLBkAf98DfJr2DrsqfAT3E=
X-Received: by 2002:a05:7300:dc8c:b0:307:3a74:749a with SMTP id 5a478bee46e88-30780021639mr4328443eec.16.1780783132905;
        Sat, 06 Jun 2026 14:58:52 -0700 (PDT)
Received: from p1.. ([2607:fb90:eca7:eb8:c719:b925:9617:633])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm14942404eec.8.2026.06.06.14.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:58:52 -0700 (PDT)
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
Subject: [PATCH net v3] bridge: cfm: reject invalid CCM interval at configuration time
Date: Sat,  6 Jun 2026 14:58:48 -0700
Message-ID: <20260606215848.1951633-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296162-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:mid,asu.edu:dkim,asu.edu:from_mime,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C61E64E716

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
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
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


