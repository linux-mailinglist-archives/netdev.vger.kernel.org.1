Return-Path: <netdev+bounces-269966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJX5Js9svWnL9gIAu9opvQ
	(envelope-from <netdev+bounces-269966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:50:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED81E2DCE3A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3B3B30C4AD8
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28F3CD8DD;
	Fri, 20 Mar 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DienXy3Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898EA3CE48A;
	Fri, 20 Mar 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021773; cv=none; b=c8Cnt2yqAI3etiH94gZSxl3PN5l7hAeGVNTgEY/70MNrJ7wadI5JCINF2C9/u+OpypztIxvhKlCkVGhYeSprAQTsPFcHxDpwDhzENCablWV2KIdniI8pokkrOz4ia0RIXZdtGbSAAiOxRp/i6xE0yEQa79XJIKB82j0OSVQKrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021773; c=relaxed/simple;
	bh=yxsTqlTDLYz3NvilL7JWiv29ZhfMWZjhsNqrO5yO2MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rAUqkGJIlOz5QP5HbiDzMfvOnIro9kebsTNWJHJx46j8bDN0e1Vtgs3wyQKM2si/qsANLXpCP+hrWHJcrOS/NKmJwMPPO8La/84jUiOH2O0w2tl7uYkkWdVS85dhL0u5wctLXMy6ApDeVYbk3P36bv1z1Qpl6JdsxMR9J2rbZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DienXy3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39398C2BC87;
	Fri, 20 Mar 2026 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774021773;
	bh=yxsTqlTDLYz3NvilL7JWiv29ZhfMWZjhsNqrO5yO2MQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DienXy3QtlutpKjRqy4j2ztPJ+4fyeaXtMWmRxhNI7W41YBNE69GGnZPz1btgrodl
	 zM7EVvmRGdv0p/1fwPMGJdGyavNrhHZmo5YYUoru3H98ZDMTqYZGZ7ooMdYsyvm1UR
	 M/9lQAtttyOsnSHodic74axvlaA7ENdOCJaYp8h7OOCUjDRehGZf90d5IU/EnuZzGr
	 JP/rQov1tc7IjXSHYWC/vzGleoSIoDpEwJbtDa+ASCimkPKIHwEIm0TwAQp3R3s1BX
	 UD+MFwvj8rK97DIeD8yiMRtCOVAaxS+ULv0igwTUt8ENwOxabCm5v65DMoea+x3M2b
	 ZZ5jWlnypaKyg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Eric Biggers <ebiggers@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: b44: always select CONFIG_FIXED_PHY
Date: Fri, 20 Mar 2026 16:49:19 +0100
Message-Id: <20260320154927.674555-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-269966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: ED81E2DCE3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_FIXED_PHY=m but CONFIG_B44=y, the kernel fails to link:

ld.lld: error: undefined symbol: fixed_phy_unregister
>>> referenced by b44.c
>>>               drivers/net/ethernet/broadcom/b44.o:(b44_remove_one) in archive vmlinux.a

ld.lld: error: undefined symbol: fixed_phy_register_100fd
>>> referenced by b44.c
>>>               drivers/net/ethernet/broadcom/b44.o:(b44_register_phy_one) in archive vmlinux.a

The fixed phy support is small enough that just always enabling it
for b44 is the simplest solution, and it avoids adding ugly #ifdef
checks.

Fixes: 10d2f15afba2 ("net: b44: register a fixed phy using fixed_phy_register_100fd if needed")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/broadcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index a8021008eb51..35d68dd99086 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -27,7 +27,7 @@ config B44
 	select SSB
 	select MII
 	select PHYLIB
-	select FIXED_PHY if BCM47XX
+	select FIXED_PHY
 	help
 	  If you have a network (Ethernet) controller of this type, say Y
 	  or M here.
-- 
2.39.5


