Return-Path: <netdev+bounces-261170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJE5OXbAn2lOdgQAu9opvQ
	(envelope-from <netdev+bounces-261170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:39:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F301A09F3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75B12300E71A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F926FD97;
	Thu, 26 Feb 2026 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKiGfCxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1622727E0
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772077140; cv=none; b=RqCHA0jKRhnH7P3XlsuK3t/DYXPseldYBCuXRldfRO5PMRyByOD+Aw11DG2TY6Ahmd4N8eo/Lb8uwnweCyoHC7xlf71+186L0jAmA5hURS2g7kRjE6GGLZTJsy+NsyZ8PL7FBJl2QoMKlOBtfBPxGWG+mcNk8J8BAdTH+am0gQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772077140; c=relaxed/simple;
	bh=bB0r+t3MStEJYfFdIZEamdfecKmA2qhnsq10iuPWnSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sauvFRQ2hD0y3/q/Pdh95SyRgU7v9TM5WWGF7ppayrVcVPSCtSZ/Ck2hs5GDMOCjKoMFYkG/STxoVaXzUyt058v3gKLdyphorRMF12u9q5l576MeZDKw3lurR3Bdh6S3ioWYjqSdjWWbzqXC5EncmE2yXoz9hV0QJTIfuTCYpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKiGfCxW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad4d639db3so1633075ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 19:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772077139; x=1772681939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZs2Gcum8CYI+PLbOFcOYoDkS/lf+U8mq3F4iU4slkE=;
        b=TKiGfCxWxSwhGYpmgWlCRzyOBggsS2TpX77Tk5qBEoivBhKh4GsXNFei/tcye/eXN0
         LKfS9BVtla7cPrD16jFAQAVv6i7w9ZI48FNEnm/wcW5G6lY0UV/NMAU+yitqxik+MrdT
         gbBDK+y/PEEPpbCzLR0IF43m+1wOPzs/Zc0kAecZ4sTqzYaFyeP5Jn9FSUBeCs3BD4Hb
         oO48961hHHExWdV4xvu4BCl1xw0l5Fw+ldE8qN3MkadgFJfG220k9xk31TTTjM6H3VZf
         RIEtCkYzQ6QSRI+hfU9ZE6lGshYS7vmSua/18IapJLie8ew28iGQL6hAySJVKSVJyUSm
         oFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772077139; x=1772681939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZs2Gcum8CYI+PLbOFcOYoDkS/lf+U8mq3F4iU4slkE=;
        b=eoKAkkaAtNRBWBvsZWkg9m7sJGN556coJyqTcMQRgLbTPzOOBbxTKpRWeMGBU4KQdy
         g3tWbjwxXGCheMhyFJYbFU6MkyqEkDt4qLNiYPkpk2uKNH4qYwf9r3R3+JWRsNWpzEOq
         CjRHc/1dYdXhZy7nSHY+FpOLwxzxYvEog1ztaUN9/BjRqQhUeIh18nQ/kyflobpD88WR
         mVMniVOBvykAMIqg6guWaQxjbA8Y5P8YtWVslcBagb4zJFYg54TwHqCwSFUthRMXrpmL
         uO9V+qad5wu7eofZT+mtzWt6LOHXptv0pDFMPXP5yOr4gUjNXb97rDjyJtzGosXmOF7r
         IUbw==
X-Gm-Message-State: AOJu0YzHA5m1nLX5RPwnriRqVzG1Epv61jggyPmrEHyfvvVgURQhei9l
	UqqZMT+fHZ85yLcBoy0Dvh51yPxfdqTMbvim2ZXciiiXoX7Qij58rngXyf8fZMZmhX8=
X-Gm-Gg: ATEYQzxhSuHaMvbF9yhK4ia3zSBlIrmZNiB/A/zc8gist4AE98ttAxv/Wvzog88r5CL
	Ok0MZSQVyg2sk9ai8qMZCZD8BtiOydS6Yq01OCgdFIBET4nuJAxkTeZNUSU4Z9yMnwAyoc6CkDw
	Exz9mpUAFVqL/63JpAq0RHaG9a7aJ0NUowi0GmFvvGxLZtfWWSN6JB/BOO4AkpA1OLNULkp3prT
	s9iA/5HsDCs4/cXpQZszyVPUt3Nba6E7XiMVpnrFFvdCIO2g6VJ4usg1GAY6vHU+hzSk6KoCec8
	Qf6xcTtnKtHRSaVdoZJy56653tTIpe5PqVsyQSMdZbNPdwxfngEan3YLWKPISAD/8n1yZbdH07B
	MqucwKMl9gRj+svEJKrPuElzjxfIez/fQi+7kSR+X/hRmpdn8vbegMoYpVfFt/2Edbg+nU4ry33
	alhEMVhOAaq1N8TrFfIQZitE3lCAA=
X-Received: by 2002:a17:902:e812:b0:2ad:da26:c2e0 with SMTP id d9443c01a7336-2ade9a606d5mr29587395ad.31.1772077139062;
        Wed, 25 Feb 2026 19:38:59 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa65sm7327625ad.58.2026.02.25.19.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 19:38:58 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 iproute2-next] iplink: bond_slave: print actor and partner churn state
Date: Thu, 26 Feb 2026 03:38:44 +0000
Message-ID: <20260226033844.18244-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261170-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44F301A09F3
X-Rspamd-Action: no action

Add ability to print both actor and partner port churn states
(MONITOR/CHURN/NO_CHURN) via netlink attributes. This provides
visibility into the LACP churn detection state for bond slaves.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2: use print_uint() for unsigned int variable (Stephen Hemminger)

---
 ip/iplink_bond_slave.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index c88100e248dd..f4b28fbca948 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -86,6 +86,12 @@ static void print_slave_oper_state(FILE *fp, const char *name, __u16 state)
 	close_json_array(PRINT_ANY, "> ");
 }
 
+static const char *port_churn_state[] = {
+	"MONITOR",
+	"CHURN",
+	"NO_CHURN",
+};
+
 static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 {
 	SPRINT_BUF(b1);
@@ -148,6 +154,26 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 		print_slave_oper_state(f, "ad_partner_oper_port_state_str", state);
 	}
 
+	if (tb[IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE]) {
+		__u8 state = rta_getattr_u8(tb[IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE]);
+
+		if (state >= ARRAY_SIZE(port_churn_state))
+			print_uint(PRINT_ANY, "churn_actor_state", "churn_actor_state %u ", state);
+		else
+			print_string(PRINT_ANY, "churn_actor_state", "churn_actor_state %s ",
+				     port_churn_state[state]);
+	}
+
+	if (tb[IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE]) {
+		__u8 state = rta_getattr_u8(tb[IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE]);
+
+		if (state >= ARRAY_SIZE(port_churn_state))
+			print_uint(PRINT_ANY, "churn_partner_state", "churn_partner_state %u ", state);
+		else
+			print_string(PRINT_ANY, "churn_partner_state", "churn_partner_state %s ",
+				     port_churn_state[state]);
+	}
+
 	if (tb[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO])
 		print_int(PRINT_ANY,
 			  "actor_port_prio",
-- 
2.50.1


