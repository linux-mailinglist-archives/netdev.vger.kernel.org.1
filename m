Return-Path: <netdev+bounces-260303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOCNEsUGnWk7MgQAu9opvQ
	(envelope-from <netdev+bounces-260303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:02:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB9180CB9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE0D230152CC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1251A9FBC;
	Tue, 24 Feb 2026 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrqB7QD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CE12B143
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898560; cv=none; b=inx1hU/8uomu0ahSsyUpQNkV7I453PYmnhvtWqlTsa9xbTYZmtCjDnoLqtYjvBen38dUsfw9EWxMpkCG2ETMznXcShaArt/AD5WxLJoZS3mjhO1Igpp6uOOGf6JtyOxC7LceMGT6lp+JuwzaX5pcOM42pNQTubGoMOQFs3LZws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898560; c=relaxed/simple;
	bh=OhTarnoYllk3gzRnVEJor5qQt15MI10wefzMzv+PZNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fx3npq3exw8D2A/hTLJGX85q35eqPrNWLILVcLmmCxSfKNQCtsqt5bZxgkBfVMoCfqKnJY/KLAr2P2lwgHPXKD6LscJZkAkl8dj4+YCToaQksbmc2vzQJVma7DWNwFCSwyqO9Uc7Iil4mYq5WRi07+Lo0bj1UmSOVldqHLavsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrqB7QD5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8249fc726e9so2573506b3a.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771898558; x=1772503358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dWRu8L6R1n4ykVyzbX3oEtnM0B63C+dsb7N5dNHQMs=;
        b=HrqB7QD5IJBs/u9WuJmNYwdFFOPfKDqR43Jj2YmvuhyYDbE43OBeRuoOtOuOxLiMd8
         uPxS8mH58VSoOQ7/7MmCPWI3+qYHg/mDdxxAU0kLo6j70Ybr5mTjT4T95dCu1NYA6imS
         Mvq1A/gC7KT9fx9mQ+WoBPRb1+tAcyBO4OYejgNUtpO6MB3aUaHLCOUMUgvWJZBeQoO2
         DGXYo+126RAxi5T5sS3cSGkTKcsq6rBSBzFia4oNfoHC6KsHFWMX2X2ZGWXXa6Bvf6i6
         ZfxJaowBMqbHEqKPBdMNRsyMaOEZxqMUpYmpCQMGQyWWkZ5FJt1AeKzZ+Gai1vHbFp5J
         C8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771898558; x=1772503358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dWRu8L6R1n4ykVyzbX3oEtnM0B63C+dsb7N5dNHQMs=;
        b=dJymRRAgf/58ZPGtsuZ5lWnUY2gar94uJi3exBb6Mwg16D7VNoVhIw97bEhqTPbaKR
         mZiYh74KPfOYV6DM1nEgkTFoah9OXpeo7j9OYphmxKHwZcGzmFJ1x71c4Ckfc89A2ZIL
         rD09BrEVMDq1JvJ105HiYbtyazz4dk/12TfJNB1Qn8bAhixodEKFcv33W83xHSCgF+MQ
         aLZkuXtUisFfZvSc2YnYDNX4Ttf09vEziaDL3Rr2ENiCJL0PJ6JG4+kOHPuTYLCDg87a
         i/8B+ShHYgDRJa0rTffdqmiOJmugzT9QAeWQ05uPvPQw5Zx6YZa6c8EdOzsfCDbtaiDu
         Qphg==
X-Gm-Message-State: AOJu0YxoMFHSt8STZLkrxsJLuOrfL55MNR1RW4n5JHJKqB1zBIBUvFy6
	An3qhYQH8BEzCtxqA/wshDKJZl67JhF8joWtnmNXbvop0ShkVcoZe19eoO6ZhYOQ
X-Gm-Gg: ATEYQzz8KCmcX9MPYh9ZtFEdOETlJ0mSHQLkPZTgJ73ZIEHyErEgnzuhPKSr4FIWxU1
	ZchloEtLWS/O3vaJHzMurg/Dghq3TAvt+TPruSD9JdqW61vyR+ypCxAUMLOXz0k8Wxumj/A+6XW
	B88ue58OyBjZo6BQjWSbjwEEMWVud/d0EXpL44NiCBWpnXTOTJeYRcUipzNSOsa8QJPPDALD5Y4
	ATnifjB2GK1UQPxnjYwb47k7gMFCP1lmv+ZHgczy7lWuA4H3gnA+tA9o5pzTUixmTmYbDmJmbFi
	v6SqCfzOAGZkeBM0p2mcRwnXC3FigtHWFuKdA9OklXY6u0xMTCJFK1mhxFTfT6aEjt+DBPd4CQW
	KgeVJLTJk75Nqir4BbgtgzwogXo8gQW3zet7V4dkZvBwQq45rDb0xSJLeLgWFHi8fv9iJIlNJpJ
	2z0lt56qL+MQu79nVmqGQZ0TrhNlM=
X-Received: by 2002:a05:6a00:1d27:b0:81f:9b97:5e4f with SMTP id d2e1a72fcca58-826daa64007mr7800879b3a.47.1771898558468;
        Mon, 23 Feb 2026 18:02:38 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd6c30dfsm8802099b3a.27.2026.02.23.18.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:02:37 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] bonding: print churn state via netlink
Date: Tue, 24 Feb 2026 02:02:14 +0000
Message-ID: <20260224020215.6012-1-liuhangbin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260303-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69EB9180CB9
X-Rspamd-Action: no action

Currently, the churn state is printed only in sysfs. Add netlink support
so users could get the state via netlink.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_netlink.c | 9 +++++++++
 include/uapi/linux/if_link.h       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 286f11c517f7..ea1a80e658ae 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -29,6 +29,8 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
 		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE */
 		0;
 }
 
@@ -77,6 +79,13 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 					IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 					ad_port->partner_oper.port_state))
 				goto nla_put_failure;
+
+			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
+				       ad_port->sm_churn_actor_state))
+				goto nla_put_failure;
+			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
+				       ad_port->sm_churn_partner_state))
+				goto nla_put_failure;
 		}
 
 		if (nla_put_u16(skb, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index e9b5f79e1ee1..83a96c56b8ca 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1568,6 +1568,8 @@ enum {
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
 	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
+	IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
+	IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
-- 
2.50.1


