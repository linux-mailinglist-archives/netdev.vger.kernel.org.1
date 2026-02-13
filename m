Return-Path: <netdev+bounces-258574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHTCJnHWjmmhFQEAu9opvQ
	(envelope-from <netdev+bounces-258574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:44:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05542133ACB
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 08:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CCA43040A81
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C813030AAA6;
	Fri, 13 Feb 2026 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m04GoKsx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479712CDBE;
	Fri, 13 Feb 2026 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968682; cv=none; b=DLryfowCJNECfZ7UslAe3mwFPfxZzNN4tuDmtzN6h8aYwTFnug6z5Ky9WxErqr90oGduez4WbwstD3DQV6lE5A1klF8FlUliROEE/0ijlXikpPu8t9E/YtQ0VqKlTHyoHDEonPgyDcHBFDrl53j5Ajkkz26MS7ScR0qotA0ikxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968682; c=relaxed/simple;
	bh=ytEpvfMtI3uon+/yibMgub7a8aVn05m/KvxhbcrZtKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFn+AOTy0nTbaiqeAFGhwxYFIGcfXkP7573lRDAAUVQh4fpS+iQSzcK8QX+5GbKs3od94KtAqcBt2BLPH633cKjpP4H8q/wYq09AjYb7fzWgSbfAZ/6bcsUysOex1R1NFlFFaAni0CD4kPNNDsOhdRpEo3eXfwMzX/xI550n7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m04GoKsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5838EC116C6;
	Fri, 13 Feb 2026 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770968682;
	bh=ytEpvfMtI3uon+/yibMgub7a8aVn05m/KvxhbcrZtKk=;
	h=From:To:Cc:Subject:Date:From;
	b=m04GoKsxBRq+Y/Qew7vt54ecMh9FnPon6dMgLv+nrXK2UU9VScz2OXGIwSbfHNyFB
	 uIMgTUboylvdJndu9CILGNhdui67BDah+wzf1LYJrM86QQ3rSv2GXYlijDVAoksRTC
	 kJIOgw4ciNri5SN0KPTuCmnfDPxTiC7YRk1IHsM9VBk1KlNC7MLTn1EMsPIqmRamup
	 AxbIvP7/8GFBI9Pp1Ffy6AXpTYDaZgne0OaSpDhCcs2AzK/ow/0f1CDnqA6/1D0KD7
	 iGPfe5w4YYokl4Wb23iNKt3zBI4/nnw6Jcl6zwuQMHlWQ2NDEJw3pZVnfBQcsZ3npH
	 Ul4IeqOCadUng==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Breno Leitao <leitao@debian.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Biggers <ebiggers@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] printk: add CONFIG_PRINTK dependency for netconsole
Date: Fri, 13 Feb 2026 08:44:00 +0100
Message-Id: <20260213074431.1729627-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-258574-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05542133ACB
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The 'select PRINTK_EXECUTION_CTX' line now causes a harmless warning
when NETCONSOLE_DYNAMIC is enabled but PRINTK is not:

WARNING: unmet direct dependencies detected for PRINTK_EXECUTION_CTX
  Depends on [n]: PRINTK [=n]
  Selected by [y]:
  - NETCONSOLE_DYNAMIC [=y] && NETDEVICES [=y] && NET_CORE [=y] && NETCONSOLE [=y] && SYSFS [=y] && CONFIGFS_FS [=y] && (NETCONSOLE [=y]!=y [=y] || CONFIGFS_FS [=y]!=m [=m])

In that configuration, the netconsole driver is useless anyway, so
avoid this with an added dependency that prevents CONFIG_NETCONSOLE
to be enabled without CONFIG_PRINTK.

Fixes: 60325c27d3cf ("printk: Add execution context (task name/CPU) to printk_info")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 4154a6f98c74..93d78b201d63 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -333,6 +333,7 @@ config MACSEC
 
 config NETCONSOLE
 	tristate "Network console logging support"
+	depends on PRINTK
 	help
 	  If you want to log kernel messages over the network, enable this.
 	  See <file:Documentation/networking/netconsole.rst> for details.
-- 
2.39.5


