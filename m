Return-Path: <netdev+bounces-251538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PuqCza5b2kOMQAAu9opvQ
	(envelope-from <netdev+bounces-251538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:19:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E648710
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6755684D893
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB1322C98;
	Tue, 20 Jan 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0TP4lCr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB8322B75
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925957; cv=none; b=YznpYgtnXxNL9BUORgpGIXYtgP7YryP02FAlAidVymmk0UKPYvwVEsZqiK/soifqgevPfRsKZZjOqKaxKb3Ub8I7RCbFgmBHc3LD2c7uK0E2Tc4BjUaYi10GGpxF4zBfgqz2JjUNBmrhkPjx5OhXnBvtf/3TYeGX4qiVrB0293M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925957; c=relaxed/simple;
	bh=nMixvZuuS4oZr2axCrQxgLAwHCuDLILf/R8pKqL+qVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9F/pgVlK/1N6Vk7Kx3yITyBb7GTi0E9qsMC/UJi5beOpwY5CMcU4LBg1Uv7RnZ+sKQc302o1Q+V2InDylkqy8zDCJKDu4tcl5sapWZ4N3i14W7x5CN+HQ6sTrARD/mGQj6mc7e7L7jYqsrW0AK85VBUXRvUJUaNjXC2/wsgf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0TP4lCr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38316d0c26eso47480201fa.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768925953; x=1769530753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnVwG+qD/nEigpZjI89PTFpptVNDER/CTlFHRi35/8U=;
        b=I0TP4lCrdLbDB6LlhqVvRsP4gSEcit+j4dNvPWmQvh8NNssUSQT40gueJKvdrHi2LH
         o4zLqWjXNjDaz4OrPALg8e8yRMDRA7TsEhPm3piybEFCsH6M4AW53CByeyTmemlB9Lu5
         t/BguFWrQ2A0htwr1fbCkWvBvkS1GkJE0sDDYHEN6fSqd8c1XS+tgWy/zeOfBrsydeEl
         GrCHn7pf1lXAUs+fSlRqS/DyHTrwg9Ovy864R/GLOgRsirVOfqMqA5aNfRC10/hDppGm
         DKbspb55y631aMWHNnImm7JGKkID/Hl0RH/UJZvUvRgBxGyGBZLL1QlWlHcGUd2kN10G
         k5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925953; x=1769530753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnVwG+qD/nEigpZjI89PTFpptVNDER/CTlFHRi35/8U=;
        b=hAXHJVagqjpO7pdKy8s2nupFrNR6l+xJYGKNhVd7kJ/g7Rbo4StKZgW1bXU62XCfBZ
         k7O7HUICX/CuWOPzzNWTnz6udSCUorYJSR6FZJLptaYf99ANkWQWy59oj4i6fo7+zz6r
         qIUIvbPMFwJyApLWNYdck/iHxJqaSGZ5ULP6cEvZNsbeIa68L7Y6d3IYE7b7YlyGgqzV
         pzVFiMjyvOZix/9HZ0mdg4EHJM1tFIzE98WYqpYBCbjkcEyakEj+zPmz3r48CCADuPuy
         sV2ktdVttSJ4svIaSbkG/3DXXapFLVhp4UU5VP5n7UGkPpzfyldVPxxHmt54p3g8EZWI
         pX4w==
X-Gm-Message-State: AOJu0YxBSM+f1PrmBLefy9lP7HCMO2TwP+kgWAVdxx1CRcSLM4/TeS0Y
	6wq63DL8rYYxtBVvDX4Dse+qtBDqPg8zCjqJq8SnNo8N7QEUyr6ICsPOTQlVkeTa
X-Gm-Gg: AZuq6aIWmXML9T5Wi6Yv3zWTbGXeBX5pRkk8bv8rTo9eUYjc1L0xJisHY2SqqEMVWE4
	KtDImgwLW2t3EtlfoBK0IpXaT3uF1Ej572FUHOO9Q8rC5Cng4OpfsR2D4CS4OxGqOO5whm6XrOo
	PjtFNCkws4hVxXX8UD6Ni5tq9F+V+VUecNsDORlIJgmT4H7XroJmuw0CUDVNJFldeKVgBNLdklK
	Y4xSr2PElLBP1yLrz4LSptpeoyNeVhQEcOcJd9I8k/u4enYqn6FHKwrGUAY0Ayqgzf+NdvHFUeS
	ur6hg0v+7NNQnnTeofsSzMrBp92+QH1b//cZ+6TMe8xfPW4aPK00Dnjp7gLtijMtjZXSerWbIUg
	XI/Ca51Tk1poo7Coh2Scv3Ch8Rf4Q0C8CBpvgZcyJzbH2WhdVB9rfreEoKmDOArIeIa3b7Xl7Bp
	Nfbl8hHXhIFGunfDE0/OR9TkT2d5mxG7JI6aYLm1Jy4Yo49Pyex8Tg2bBm
X-Received: by 2002:a05:651c:a0a:b0:37f:a216:e473 with SMTP id 38308e7fff4ca-38386584ffemr47653881fa.0.1768925952756;
        Tue, 20 Jan 2026 08:19:12 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.23])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790d7sm40561531fa.24.2026.01.20.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:19:12 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Julian Vetter <julian@outer-limits.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net 1/3] ipvlan: const-specifier for functions that use iaddr
Date: Tue, 20 Jan 2026 19:18:34 +0300
Message-ID: <20260120161852.639238-2-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120161852.639238-1-skorodumov.dmitry@huawei.com>
References: <20260120161852.639238-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,kernel.org,google.com,redhat.com,gmail.com,nvidia.com,outer-limits.org,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-251538-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[dskr99@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: AC1E648710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


