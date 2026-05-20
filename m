Return-Path: <netdev+bounces-289972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPtmM2zCDWr32wUAu9opvQ
	(envelope-from <netdev+bounces-289972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:17:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7406858F6AF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4E8A301E558
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB43E92B7;
	Wed, 20 May 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBn9GBjK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE939B94C
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286617; cv=none; b=Ii4pZYtFin2JHLD538vfhPfP8n7qWG6jUodg5onKC9VNXi7qT/7VmR2CRbnw3tEHtep4WXp4h/kXewg8McRJsvHHs0iLXJG+O0aGHT6r7Ak3RBCo9EijVyboVtsoKKfop76hqltM0wgsrfTvj3YWd9uuAMzD9S8yQo3dbW3D9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286617; c=relaxed/simple;
	bh=0brtW1b95iw24iU58TPlwkxsh9ivQXA9CUxrYavu3oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbuPc65CVcg66UjYii8ShEUga3J0baGv6Zyh4H82qCklh9mLk79ztwJpkOapRtSz2drFBOIDjqViSCwC0YhwkS8plN4Vo8TX507JnY545O898PfnkX5zBSsV4ksDK/p0ttApu9nNggU1+ylspNUzTEsh/4Z/d4Oq4rarT9HpwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBn9GBjK; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-910f734b477so545991085a.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286615; x=1779891415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5DoMls1QAAyY4rhECCtO93CkScQuRF+sIDiF9nKy1o=;
        b=dBn9GBjKI9agw7Zu2/r9sEQ13fv0qvbbsPfCjhlbV00v8pSxc1w/tPTYuOQqj/b1fc
         uWcvDrnMhAoannevMg9FhpL9N03CZ0JQN7gljnWGpEX9BC/R34OP120xYhGYMNeL0kY9
         g11o2TATmtQWvZ2Xmwz+v4Czrx8Dp44ZTSIPJm/J5Q4+mhHLM1zKrJs53/6O0NNTwGSj
         Qvr/WBq7+wU5M1KoYwtFVPLcuKGlTce5GF3cBquUYYBN6g0HJh4taGrD9A9wpYX1Hvtj
         m01jY3ueUZFohKAOGnbPw4TBFS4rKA57uZDHovg2Od1glXISDnYZ/Uw9R6KJwA7GAUa7
         YLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286615; x=1779891415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5DoMls1QAAyY4rhECCtO93CkScQuRF+sIDiF9nKy1o=;
        b=QSAcT4UFJGZ3tgiLj2kxwg+Z7EhQ0f69RAZwNo9Fa0sP14zDS4jUTdZDYiNGfybisV
         nwDMHt/QMVf4cc4Sy3yMxTqWqGZ/V4ebHcrnfOmCoIXiJy6r+a80129WCUPyhIy5oMSO
         sMVmWHyHLKtoh+JjQtX93toGd8y0R8Yo3q/X9KHnv8kSPsfWQghgwRcfz+OnI7Km7SpS
         r04nuSj3vfReHamX87DtycieMa48/80pEDKoE2BOxKXU9hQWpyLg8SLACSO1E+R2g6QK
         lbGFPz543Zb6tCT7YZyiE9XA+UptBygWce+WneIKMhVtSSChT8YDOjOw3OgvFYsY/PTO
         6JcA==
X-Forwarded-Encrypted: i=1; AFNElJ+lAA3ukjZgpdHAzyHplBk17SUxktmawp6S4EUAJVF3fjmPc7LQAEFwogR21j2Zy9mLzpUmnfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87YIvF92m667FjB7SJqtoBRYOGC1BjE8HEzMJMS4CQPCXgUy4
	ANzY2vEo7MzpmGJBCjeCgTRSaiMDaNUGi02k5rXvkju3PjecrECgMNYh
X-Gm-Gg: Acq92OFgC8AjpshOaOUqpq3AcndthmuUWVzA1uayAdOvaKMY6Ny074Xeg0XsLZiCgN6
	YkDgIc8RFzYkLgsFgvktWYbHmavqPlN4nZyXrJQ3Nlav5Xyw7FvWXhJdm+xCIEnLAwsjDCcxLor
	W9gCdX+PYTl9/jiOTVWu4wO2vPloNQ36uvbl3GsHnt0GYxCnknVNPYlaarLunz6c0DJIJGLl7OU
	+UEpdHfMm0FH72HFBrHMOPRdvRCxA9j7Qu7Ss0viSp0t2bTnymW2NC7ygvyTiyIak6MviR3ovJj
	Zhc7fFYif23pvv6GWK339w961TT9MqGYoLhnOSH3Tt+cctH/g6levNF4QmSetT8NhfXQoAzLrBo
	7AH9S6CVJVyFwOEtLWFLa16EjvXP5hWOSZ2AnKjFFwby6jZ1J9pqFjy/4NUgzMxQboE8qUEkz1c
	Fg8Lu1g0w8AOtTLzRDTUAbmtrZerzD5wC64EjqYWoynkFbL6l2otXB8UUGRHKWI4WyZrHon/3bg
	rX8hkgIMvGkOYd15Qe2
X-Received: by 2002:a05:620a:298d:b0:909:b197:4692 with SMTP id af79cd13be357-911d1335796mr3440636085a.62.1779286615084;
        Wed, 20 May 2026 07:16:55 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm2138952485a.5.2026.05.20.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:16:54 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] ieee802154: admin-gate legacy LLSEC dump operations
Date: Wed, 20 May 2026 10:16:39 -0400
Message-ID: <20260520141640.1149513-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520141640.1149513-1-michael.bommarito@gmail.com>
References: <20260520141640.1149513-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289972-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7406858F6AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In net/ieee802154/netlink.c, the legacy IEEE802154_NL family ops table
builds the LLSEC dump entries (LLSEC_LIST_KEY, LLSEC_LIST_DEV,
LLSEC_LIST_DEVKEY, LLSEC_LIST_SECLEVEL) with IEEE802154_DUMP() which
sets no .flags, so generic netlink runs them ungated. The modern
nl802154 family admin-gates the equivalent reads via
NL802154_CMD_GET_SEC_KEY and friends with .flags = GENL_ADMIN_PERM.

Any local uid that can open AF_NETLINK / NETLINK_GENERIC can resolve
the "802.15.4 MAC" family and dump LLSEC_LIST_KEY on any wpan netdev
that has an LLSEC key installed; the dump handler writes the raw
16-byte AES-128 key bytes (IEEE802154_ATTR_LLSEC_KEY_BYTES, copied
verbatim from struct ieee802154_llsec_key.key) into the reply.
Recovering the AES key compromises 802.15.4 LLSEC link confidentiality
and authenticity, since LLSEC uses CCM* and the same key authenticates
and encrypts frames.

Impact: any local uid with no capabilities can read the raw 16-byte
AES-128 LLSEC key from the kernel keytable on any wpan netdev that has
an administrator-installed LLSEC key, by issuing an LLSEC_LIST_KEY
dump on the legacy IEEE802154_NL generic-netlink family.

Introduce IEEE802154_DUMP_PRIV() mirroring IEEE802154_DUMP() but
setting .flags = GENL_ADMIN_PERM, and use it for the four LLSEC dump
entries. LIST_PHY and LIST_IFACE retain IEEE802154_DUMP() because the
modern nl802154 family exposes their equivalents to unprivileged
readers by design (NL802154_CMD_GET_WPAN_PHY and
NL802154_CMD_GET_INTERFACE carry "can be retrieved by unprivileged
users" annotations).

Fixes: 3e9c156e2c21 ("ieee802154: add netlink interfaces for llsec")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ieee802154/ieee802154.h |  8 ++++++++
 net/ieee802154/netlink.c    | 16 ++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/ieee802154/ieee802154.h b/net/ieee802154/ieee802154.h
index c5d91f78301ad..fd9778f705503 100644
--- a/net/ieee802154/ieee802154.h
+++ b/net/ieee802154/ieee802154.h
@@ -23,6 +23,14 @@ void ieee802154_nl_exit(void);
 		.dumpit	= _dump,			\
 	}
 
+#define IEEE802154_DUMP_PRIV(_cmd, _func, _dump)	\
+	{						\
+		.cmd	= _cmd,				\
+		.doit	= _func,			\
+		.dumpit	= _dump,			\
+		.flags	= GENL_ADMIN_PERM,		\
+	}
+
 struct genl_info;
 
 struct sk_buff *ieee802154_nl_create(int flags, u8 req);
diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 7d2de4ee6992b..9c9fd14d0ca8b 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -98,20 +98,20 @@ static const struct genl_small_ops ieee802154_ops[] = {
 	IEEE802154_OP(IEEE802154_SET_MACPARAMS, ieee802154_set_macparams),
 	IEEE802154_OP(IEEE802154_LLSEC_GETPARAMS, ieee802154_llsec_getparams),
 	IEEE802154_OP(IEEE802154_LLSEC_SETPARAMS, ieee802154_llsec_setparams),
-	IEEE802154_DUMP(IEEE802154_LLSEC_LIST_KEY, NULL,
-			ieee802154_llsec_dump_keys),
+	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_KEY, NULL,
+			     ieee802154_llsec_dump_keys),
 	IEEE802154_OP(IEEE802154_LLSEC_ADD_KEY, ieee802154_llsec_add_key),
 	IEEE802154_OP(IEEE802154_LLSEC_DEL_KEY, ieee802154_llsec_del_key),
-	IEEE802154_DUMP(IEEE802154_LLSEC_LIST_DEV, NULL,
-			ieee802154_llsec_dump_devs),
+	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_DEV, NULL,
+			     ieee802154_llsec_dump_devs),
 	IEEE802154_OP(IEEE802154_LLSEC_ADD_DEV, ieee802154_llsec_add_dev),
 	IEEE802154_OP(IEEE802154_LLSEC_DEL_DEV, ieee802154_llsec_del_dev),
-	IEEE802154_DUMP(IEEE802154_LLSEC_LIST_DEVKEY, NULL,
-			ieee802154_llsec_dump_devkeys),
+	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_DEVKEY, NULL,
+			     ieee802154_llsec_dump_devkeys),
 	IEEE802154_OP(IEEE802154_LLSEC_ADD_DEVKEY, ieee802154_llsec_add_devkey),
 	IEEE802154_OP(IEEE802154_LLSEC_DEL_DEVKEY, ieee802154_llsec_del_devkey),
-	IEEE802154_DUMP(IEEE802154_LLSEC_LIST_SECLEVEL, NULL,
-			ieee802154_llsec_dump_seclevels),
+	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_SECLEVEL, NULL,
+			     ieee802154_llsec_dump_seclevels),
 	IEEE802154_OP(IEEE802154_LLSEC_ADD_SECLEVEL,
 		      ieee802154_llsec_add_seclevel),
 	IEEE802154_OP(IEEE802154_LLSEC_DEL_SECLEVEL,
-- 
2.53.0


