Return-Path: <netdev+bounces-252891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDraBkaqc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:05:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17A78C4B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7C93037D6A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566082C21C3;
	Fri, 23 Jan 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqmqbWMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CB290DBB
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187883; cv=none; b=D8s8TI32T1RwPW0XzNAg/gg5fH8xDuBxpKRrpL2I+Jvhbz4MtPic9IarEKtw5nD/yClOPDlt01teILOWz6v0C9ysxtJd/f4Jrd1O7eLpXcZgIITfPQbrPuyu7ckmMFdHofH/4PsAt9h76qHdQUdfMAsQQFc5KcDCCKXcJ8qsRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187883; c=relaxed/simple;
	bh=nMixvZuuS4oZr2axCrQxgLAwHCuDLILf/R8pKqL+qVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTZzGIhc6uY3uj9KYxaC6IC35/aB+AiAUbi8qY2wcV1axq61e4smMO0qxa0jmQrfXAuRbJFTtDfjraOEZZhLbnXmQGJM08je7JIlZtt9o+gOQrEYL8Ot2CTgOIK6OE1r6S37e//6WVPkoRzvWBUvFT7SKX6d5EF++WHNN5jDIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqmqbWMZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso2687967e87.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769187880; x=1769792680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnVwG+qD/nEigpZjI89PTFpptVNDER/CTlFHRi35/8U=;
        b=GqmqbWMZU/EcVMxP2Hzd9xgDEYbzkBnvJTNyHSFaJslIjRPwsRdCpvGkXRRoZF4rOG
         +zQCTnK0KMcabanCCDCoyj+8+oZecfw/XUHisAmvTOzbNlqIJKRsvkFKl90P0cVVvrEA
         VqOLqFqUjv+wzT9ibrYB13C0VAR59M76C96BZOQ2szYE8W4ECmFk1yzzs4BMMZRCpMz0
         xHN/XLZBm+MjAvzRpn091UIPAiWwrPhTL5zZBL8Aoki7MNr6X36cC28PBqmH22UqlGXr
         1koWqaPCm1apJ9eJ0f9oN+sVtkf/m+7exrS2BVyWcJQHXBfQeOLzIdORT6JRqdWHW0XA
         2BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187880; x=1769792680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnVwG+qD/nEigpZjI89PTFpptVNDER/CTlFHRi35/8U=;
        b=DDS3ICuJLnZU82xcd2FSyKJScUQ/xfNcnWE5UwNpbWLi6eacHHq+03NahLyf23ef43
         ODmKLZwLEknCCJ/Ykg4X0joIRMQPlNlG2wnPkDACoscN+JTbxaCDxzVF/HKPbVoLslpp
         x5JpB3SfNP37NVuJQPSkkC9EDFLUgbwMlLWUKjmdAktg2t7H17u7KjreUbbiWVqGg2qt
         SUGVifAOT6rqJK3oiLFfisubMDT+OgtahU5ntqQdv4C79yiTzhzwDNNYKMnVheGHzIiy
         IKW5nyRlBPjnOapQ/FhttkLc55XxaEc6/Cz9JO48Vz7bxrR/npw1UurRmSIFCaDiN2ic
         s5uQ==
X-Gm-Message-State: AOJu0YyZgrO8DRQXtkNcJjPzPjZeXsNCpNRks63VyMP5iw3/HTudM10e
	u/1I113mMB2ikrIEPuGwHPk48I24OzJBmxIX+pXRvQLkgDfVNqILmg+U+vGRBXYROtE=
X-Gm-Gg: AZuq6aKuuLRndt/5EzbndRd0bGv0+Rj7YzhLs4zd6KZ43n/6oH7jK8OhmPgWTFLsvst
	ZuCgaCjM2l0r3O4jeWrnEnM1RMwh5Xxv+WTfQFFtTjo1l8XJJbJcWc+83GTU9ErCzkHhZcrCOau
	h4UIrx/VkKueaxHXrX9nTuvQSxfv8imkhA2W4bp0KyrMElmSUQDDKoNLhrvlmZZPWdeNRi3CgcV
	H4Y6Tgq/iwuhhSP4XvgwSFm5ApPobbbzkV0CbDqQXSExVAg89GsWwlhs3PmERZTcE1FKHj1JD2U
	VcqXBFHjJefyFydMrk7+eY8jYqusHvrhAoKYgIpq5CuMoBOkNtlAfDdX25JFpK+kpHFWSPpYQQG
	YpTneGpsgdSFcpyB8dK9wAwPiMPv/1AHDXRcUfoe1rBGvW+pmVW0NE2hPkh36G7uiIUWu+z59DA
	GOqX/rWGKgbgyxgd1oAewWrEIbCeS7K2Ub2B//48KFktDt6A==
X-Received: by 2002:a05:6512:2307:b0:59b:7185:757d with SMTP id 2adb3069b0e04-59de4a25cf6mr1169413e87.50.1769187879371;
        Fri, 23 Jan 2026 09:04:39 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48e5fd3sm801772e87.33.2026.01.23.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:04:38 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Julian Vetter <julian@outer-limits.org>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 net-next 1/3] ipvlan: const-specifier for functions that use iaddr
Date: Fri, 23 Jan 2026 20:03:54 +0300
Message-ID: <20260123170412.906280-2-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-252891-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,huawei.com,redhat.com,google.com,gmail.com,nvidia.com,outer-limits.org,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dskr99@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 6A17A78C4B
X-Rspamd-Action: no action

Fix functions that accept "void *iaddr" as param to have
const-specifier.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan.h      | 2 +-
 drivers/net/ipvlan/ipvlan_core.c | 2 +-
 drivers/net/ipvlan/ipvlan_main.c | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 80f84fc87008..235e9218b1bb 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -159,7 +159,7 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev);
 void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr);
 struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 				   const void *iaddr, bool is_v6);
-bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6);
+bool ipvlan_addr_busy(struct ipvl_port *port, const void *iaddr, bool is_v6);
 void ipvlan_ht_addr_del(struct ipvl_addr *addr);
 struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 				     int addr_type, bool use_dest);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index bdb3a46b327c..6d22487010c0 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -118,7 +118,7 @@ struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 	return NULL;
 }
 
-bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6)
+bool ipvlan_addr_busy(struct ipvl_port *port, const void *iaddr, bool is_v6)
 {
 	struct ipvl_dev *ipvlan;
 	bool ret = false;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index baccdad695fd..cf8c1ea78f4b 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -814,7 +814,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 }
 
 /* the caller must held the addrs lock */
-static int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
+static int ipvlan_add_addr(struct ipvl_dev *ipvlan, const void *iaddr,
+			   bool is_v6)
 {
 	struct ipvl_addr *addr;
 
@@ -846,7 +847,8 @@ static int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 	return 0;
 }
 
-static void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
+static void ipvlan_del_addr(struct ipvl_dev *ipvlan, const void *iaddr,
+			    bool is_v6)
 {
 	struct ipvl_addr *addr;
 
-- 
2.43.0


