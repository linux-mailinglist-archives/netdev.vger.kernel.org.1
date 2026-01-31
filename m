Return-Path: <netdev+bounces-255343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP0fOh2MfWlXSgIAu9opvQ
	(envelope-from <netdev+bounces-255343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:59:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA4C0AA0
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02471300BD86
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68C31AA81;
	Sat, 31 Jan 2026 04:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXer9pxt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB531280F
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769835546; cv=none; b=KISGlQgqQPQGgJGJtullHjXgfulSglJ2zvnzcqKia8PuaJlfT6rha4g2KxIx8AZOz9CHADicDJbSzIxXASFKJVeYnR2wZLjjL4SMYwd5PJDOOG8HXlyQQ/xYpkfHP9npRUmIEUqWms1zMWJxHTVECuoozSGshX5xsE/oLLjHZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769835546; c=relaxed/simple;
	bh=2GZLRT9z82eo32ajMYil1XWFWbsHS4zIb7d5VQLWge4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgoGrgLnrDUCNA7+OEU0TL0Philfx44dLgjqWZU/rrtmA4fcSgC9imQlBtU8yS3mzy/4jMaz7bZMBWWPqW/GZEU3+Lpb79r+eoNJ4mN9EsCSwZf0EGm2WVb6Fvt5rpBrlYNAM+HURL/L490LaWi71BjPajI+XEr0gDvX3IRQbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXer9pxt; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8230c33f477so1242210b3a.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769835544; x=1770440344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMHnkDKTQoGZbLCcgZR0yAaHVlDgJD+BWV/gb/Cwzx0=;
        b=TXer9pxtlXC+UA2R+yBezGuSr4CuQH+WoVOQDeOrVA2O2Wq/VZBrG5pfF0Ujes7SSj
         Lbv9FFxUI879KPeEy07MYPI1+rZHZor/aQqq1FC8fXOpj1G6tCjyS52HfAvUoHUW/vrg
         4F5b6R1onwYP4Mduyjo7EeJtwu9uwojDEYqLmyt/6kgN9FT7RcG8syjfbYxnBLnE5QBv
         Ol2RUmrDa9fU0uPahWZnd5WkychphciXUcE1OtWfupht4IXTAj5Kf75540hZ8vZFdaLD
         7PE5nmoUV5wyb80ckA2I4Rd8cKv8RDEPX/3n9LIWI8UVTNzDDO1ZSWZXCt7EHLjf81Sz
         utIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769835544; x=1770440344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMHnkDKTQoGZbLCcgZR0yAaHVlDgJD+BWV/gb/Cwzx0=;
        b=wjLs8jbc4cabCKTEgh2Mn4gfaziCKUgSCzTuSXeBRHlFLRWFe8ongy7NZ0Et2vXxzB
         IdIKaWpXp8kKDe3rV3QkA3YuiII2vtvMjl+BOjgRetCuzftVGIFVYyElL2oGcZOdeQFp
         wNtF7MX99L10TUNMioJQewMoDyKh771L7iq4hjlG/6NvZzye4cHwJ8EkM1OgKR3lkQT5
         4Y71HkL//u6nu/OEATDfCnLkHPVFWNPvOtrcdLRkVk7I6cLGHn+9grtL1pH7bNM4gBwe
         QvishtpHZxZf2csg30xOO1btOnspevArEmp0Y8yHDmqgC7cOF2E1Nqit2LK5kz2IBQ7G
         iK0A==
X-Gm-Message-State: AOJu0Yxcm1S5eHIGU8yZeSVNuTJClAO2qcwiUhjJOJN9w2JrWs6RYmno
	1WzQ+TrfuzYNVZAZdm6G/dwZKfQcfVobiSYVuqwbn3eGo27kJH6woewFkpcu66e/
X-Gm-Gg: AZuq6aJvEOWLALTm8d719635QlMTiIsdxejvhnMsv4jDF7g4DiqCX/m53u0VM8G7FJr
	bes5D0cXK4UqlP0UibDZf492agaR91q5+HIEqQaHr2F81qsrmnPyblCWTd8FmyQoImOVEAyla9N
	pxrK2Tp9hTha6MfUS5Owxd6HUBg4x+8hYSBb0r/2s16dJJDHC12Wcmp7CcuSu4RjLLLbLIc22hk
	UqNNxuaK1mv3BUA2RPHA1RdIFzBBmbbNC0th580q8Jfg/JknfTBGl0lxEHZXNpkDilAvcHvJEB8
	9jxlT+q1+pdHau5Y7lGmqP8rWjBVQ0DsMkWv0Vi2UwppNoXMNq7xg+a3iNwJTf3NAD7AyUOn/+M
	OMXJGMyJ1bPRy3bvELVO1BGEHG8fRAdP52X2n34m+gM2VwJi9BmNBU8UeobN0ShGeGSA/CV9SgD
	1ggXLuy3Gc9QkIpiy/A+fec5P5e9wzoyc/j0Q=
X-Received: by 2002:a05:6a00:21ce:b0:81f:4e36:38af with SMTP id d2e1a72fcca58-823ab9853f2mr5741246b3a.60.1769835543956;
        Fri, 30 Jan 2026 20:59:03 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b57fafsm10305245b3a.26.2026.01.30.20.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 20:59:03 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: dsa: sync dsa_mall_policer_tc_entry with FLOW_ACTION_POLICE
Date: Sat, 31 Jan 2026 12:58:16 +0800
Message-ID: <20260131045821.3451873-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255343-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33AA4C0AA0
X-Rspamd-Action: no action

New options were introduced to FLOW_ACTION_POLICE after struct
dsa_mall_policer_tc_entry was added. The following commands will succeed
on DSA ports:

  tc qdisc add dev lan1 handle ffff: ingress
  tc filter add dev lan1 ingress matchall skip_sw action police \
    pkts_rate 80000 pkts_burst 100 mtu 1000 conform-exceed ok

resulting
  1. burst_pkt, rate_pkt_ps, etc. being ignored;
  2. burst and rate_bytes_per_sec set to 0 without any error.

Among new options, some may be useful to hardware offloading, such as
packet rate mode. Instead of making decisions for drivers, extend struct
dsa_mall_policer_tc_entry to all options of FLOW_ACTION_POLICE.

Drivers should reject unsupported combinations in their
.port_policer_add() implementations.

We are also aware that .port_policer_add() have been implemented in some
DSA drivers - they have already been affected by the above issue (since
we didn't conduct any checks on our side). However, it's up to them to
decide if options should be checked (which may cause regressions with
previously successful configurations), or they are satisfied with the
current behavior - if not, they should submit their own patches to fix
it.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v1: https://lore.kernel.org/r/20260126061340.757543-1-mmyangfl@gmail.com
  - fix DSA core only
 include/net/dsa.h | 11 +++++++++++
 net/dsa/user.c    | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6b2b5ed64ea4..4c177b168ec8 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -21,6 +21,7 @@
 #include <linux/phylink.h>
 #include <net/devlink.h>
 #include <net/switchdev.h>
+#include <net/flow_offload.h>
 
 struct dsa_8021q_context;
 struct tc_action;
@@ -220,6 +221,16 @@ struct dsa_mall_mirror_tc_entry {
 struct dsa_mall_policer_tc_entry {
 	u32 burst;
 	u64 rate_bytes_per_sec;
+	u64 peakrate_bytes_ps;
+	u32 avrate;
+	u16 overhead;
+	u64 burst_pkt;
+	u64 rate_pkt_ps;
+	u32 mtu;
+	struct {
+		enum flow_action_id act_id;
+		u32 extval;
+	} exceed, notexceed;
 };
 
 /* TC matchall entry */
diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..2a209b83c701 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1497,8 +1497,19 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 	mall_tc_entry->cookie = cls->cookie;
 	mall_tc_entry->type = DSA_PORT_MALL_POLICER;
 	policer = &mall_tc_entry->policer;
+	/* until they export the type of act->police in flow_offload.h ... */
 	policer->rate_bytes_per_sec = act->police.rate_bytes_ps;
 	policer->burst = act->police.burst;
+	policer->peakrate_bytes_ps = act->police.peakrate_bytes_ps;
+	policer->avrate = act->police.avrate;
+	policer->overhead = act->police.overhead;
+	policer->burst_pkt = act->police.burst_pkt;
+	policer->rate_pkt_ps = act->police.rate_pkt_ps;
+	policer->mtu = act->police.mtu;
+	policer->exceed.act_id = act->police.exceed.act_id;
+	policer->exceed.extval = act->police.exceed.extval;
+	policer->notexceed.act_id = act->police.notexceed.act_id;
+	policer->notexceed.extval = act->police.notexceed.extval;
 
 	err = ds->ops->port_policer_add(ds, dp->index, policer);
 	if (err) {
-- 
2.51.0


