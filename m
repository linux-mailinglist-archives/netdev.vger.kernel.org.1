Return-Path: <netdev+bounces-254676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL4tDxUse2lRCAIAu9opvQ
	(envelope-from <netdev+bounces-254676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:44:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F58AAE3A7
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A60F3009FAF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D133E37FF62;
	Thu, 29 Jan 2026 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3BoS78Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF092D0C95
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769679877; cv=none; b=rXjXy3KK3F0QjInZvwCuR9twGiRyQ0SXTVuIGuU4OvsIzhuSRXxch10XFON2eDdCDG98JxMRe1T2K4ZIyX3uaA4VO5mTXONHsO8ztm4UD9P79F1mI9Eyg3pVTCR2do2GEOZk2OzDkzj2hr60z0bes2yIYiVz+3Tk+JWAJGYiXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769679877; c=relaxed/simple;
	bh=MI+D2Ic6bz3jYMbMxWU4odca96W1KdTlxUzB6WUQDjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcyfh/Zzk/qx2LEqtC3B8QNoXJmIy6uyWV4Vg7pHOznVuMgOdhYhe+VB4NVexGp/W2xpCgbwR11IBb7r6yWYkoyzkIbt1e3bLgZl3KlNiXYEMBdsnMHP0xRksg8cdBkKcVy9dDmf/3fC8Msz7cLGw0VcrZ7+JIdEBidO7+uP/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3BoS78Y; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-5f52ed75c45so574469137.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 01:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769679875; x=1770284675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEB8Yp/SddLVwrY1R6Js1dQZWhnZcm4xY82a3ZUzWc4=;
        b=Z3BoS78YspPjS4+5j/4WIz8I0i8W6YRxeryEEam83NiDLjMlHJ3izLLknuhcxIiMrs
         OCus3DS3b+TI5+NHSVHudawIDxkXv4LkYN+/YFfSUdH0ARSN3vbXsNt6z7vEYsXtLNOd
         2NBXR1fmLDlcI21qmtMZD5rcLGhTsJvKtoATHfjyN0GOcA9dvojAT3DTsQuOhssvur01
         bNQ6iUkcynB3yexnSa06mqxdv+TwvSilpX5hLYnBMmdUOZb47nwWSU7fAmCIH+FQSaSg
         nO7+3bXMprz/sxiAib7unDGjzMW5eJUnRlqZOp92vapBblN55kdxIw4MRESMnIfylAQO
         MnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769679875; x=1770284675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEB8Yp/SddLVwrY1R6Js1dQZWhnZcm4xY82a3ZUzWc4=;
        b=aTBea4xpCg/BrvkOy1QUd/1Y7RSdf26+MmTATUxBt02DbgnbKhl/wTDbnu2eM3pZhj
         upnp4vC6sfpIWNRfxeizWqL/z0g2+dB6FaKlNBUPi3Oj/bnEYI/lOYGBENn8Ozog5iRf
         in6WtehoTVMlZfa1HypdJXBB9Pplrbz8GTcCBLXi/YsNiwm8g+smUQ0YZ5u4R3BTTkbE
         BTgh9bqkjTNx1ZWLRtkbMT/qcA317+OoAqMo8heyxWKsokzNYZv80lrLflb9+plPU7Nj
         kXsVloXCREkfMTRFSUYvOfbccgtzkvatTiYWrLrXasTx9VTEcNP+e51Q6pbnvFRwUIOA
         xkug==
X-Forwarded-Encrypted: i=1; AJvYcCWxNzY65HM4/Kr21KmitV10L9bcfNOv/syBRzFPoPptKMNhnGZX7AeztZdJ7rbT+CQpBfakNU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlIAQZ4vfdmS9OK+C25KswEig0XywWTulSe0jjz/G5nuEXIXcQ
	NgWkKm46wRko+rjzpcWe0C2mVPWgmJvud9hgRR28pLXS7zfpLS8JYegJTskR6kZQ
X-Gm-Gg: AZuq6aKG7PefsS6Kc/bvM95vGssQv40yPAF3NBxRO7EGSn9XBgdfhLQEJJcD/vvKFwQ
	78JocDHaPNaQ7N/r/tAUKT/K8VhsoOWkkoz3Kg+RCGD6ZxQg0zCal/p5jFgFURb1tsfdsYRefNb
	pWiauYHcVJlgfAgUr8/svPrvH67XUJ8Cu2DQQPgs7yBePQXZmsEl2RhUKpYPDyFhdh2z3M89SlG
	QEhc68GCbxgojruMUJPn0VrQA4i4wM8DuOsGIL0a3wOFgxY3GX2hBJi9JG/WP1h9FyEVNd1r2hU
	oFxeUT9KUzj5e4MKycyLfRgr4jJMpzXLCoU0IfeRjMBpMVFDzeell1aX3tq+N6pIZpK6nSHSn1f
	uC4h0lX0cLsiXHo6jYrgo5ILjnnxyRnJsmsuTW4uAR3Hz7W6avjVkFSZuge1pS56bjEj2ZSY0Z8
	qBiJZ2Ibvj5F/RwFQL1E4XzOwSSwOGJhquuRV5JF1Z63Qv6d2X+xszEuRoKn4b1W1GrDDasam3E
	qkyIniroZhIkYRKoo84K9Ni21nb1HnFvw4kefVzrq2UBYhkpPxy477v2U3V+KYbddMyJwkpJKVH
	mGae
X-Received: by 2002:a05:6830:828d:b0:7ab:e111:1a57 with SMTP id 46e09a7af769-7d18512db09mr5036559a34.31.1769674175726;
        Thu, 29 Jan 2026 00:09:35 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c831394sm3317768a34.31.2026.01.29.00.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:09:35 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-x25@vger.kernel.org,
	linux-hams@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joerg Reuter <jreuter@yaina.de>
Subject: [PATCH] net: ax25: remove plumbing for never-implemented DAMA Master support
Date: Thu, 29 Jan 2026 00:09:04 -0800
Message-ID: <20260129080908.44710-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,yaina.de];
	TAGGED_FROM(0.00)[bounces-254676-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-ax25.in-berlin.de:url]
X-Rspamd-Queue-Id: 9F58AAE3A7
X-Rspamd-Action: no action

The AX25_DAMA_MASTER option has been unimplemented and marked broken
ever since it was introduced in 2007 in commit 954b2e7f4c37 ("[NET]
AX.25 Kconfig and docs updates and fixes"). At this point, it is very
unlikely it will be implemented. Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 include/net/ax25.h  |  8 ++------
 net/ax25/Kconfig    | 14 --------------
 net/ax25/ax25_dev.c |  2 --
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index a7bba42dde15..ad3d7626130e 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -116,10 +116,6 @@ enum {
 	AX25_PROTO_STD_DUPLEX,
 #ifdef CONFIG_AX25_DAMA_SLAVE
 	AX25_PROTO_DAMA_SLAVE,
-#ifdef CONFIG_AX25_DAMA_MASTER
-	AX25_PROTO_DAMA_MASTER,
-#define AX25_PROTO_MAX AX25_PROTO_DAMA_MASTER
-#endif
 #endif
 	__AX25_PROTO_MAX,
 	AX25_PROTO_MAX = __AX25_PROTO_MAX -1
@@ -138,7 +134,7 @@ enum {
 	AX25_VALUES_IDLE,	/* Connected mode idle timer */
 	AX25_VALUES_N2,		/* Default N2 value */
 	AX25_VALUES_PACLEN,	/* AX.25 MTU */
-	AX25_VALUES_PROTOCOL,	/* Std AX.25, DAMA Slave, DAMA Master */
+	AX25_VALUES_PROTOCOL,	/* Std AX.25, DAMA Slave */
 #ifdef CONFIG_AX25_DAMA_SLAVE
 	AX25_VALUES_DS_TIMEOUT,	/* DAMA Slave timeout */
 #endif
@@ -226,7 +222,7 @@ typedef struct ax25_dev {
 	struct net_device	*forward;
 	struct ctl_table_header *sysheader;
 	int			values[AX25_MAX_VALUES];
-#if defined(CONFIG_AX25_DAMA_SLAVE) || defined(CONFIG_AX25_DAMA_MASTER)
+#ifdef CONFIG_AX25_DAMA_SLAVE
 	ax25_dama_info		dama;
 #endif
 	refcount_t		refcount;
diff --git a/net/ax25/Kconfig b/net/ax25/Kconfig
index e23a3dc14b93..310169ce1488 100644
--- a/net/ax25/Kconfig
+++ b/net/ax25/Kconfig
@@ -63,20 +63,6 @@ config AX25_DAMA_SLAVE
 	  be enabled at runtime.  For more about DAMA see
 	  <https://linux-ax25.in-berlin.de>.  If unsure, say Y.
 
-# placeholder until implemented
-config AX25_DAMA_MASTER
-	bool 'AX.25 DAMA Master support'
-	depends on AX25_DAMA_SLAVE && BROKEN
-	help
-	  DAMA is a mechanism to prevent collisions when doing AX.25
-	  networking. A DAMA server (called "master") accepts incoming traffic
-	  from clients (called "slaves") and redistributes it to other slaves.
-	  If you say Y here, your Linux box will act as a DAMA master; this is
-	  transparent in that you don't have to do any special DAMA
-	  configuration. Linux cannot yet act as a DAMA server.  This option
-	  only compiles DAMA slave support into the kernel.  It still needs to
-	  be explicitly enabled, so if unsure, say Y.
-
 config NETROM
 	tristate "Amateur Radio NET/ROM protocol"
 	depends on AX25
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 3733c0254a50..c504ed9c3a88 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -82,9 +82,7 @@ void ax25_dev_device_up(struct net_device *dev)
 
 #ifdef CONFIG_AX25_DAMA_SLAVE
 	ax25_dev->values[AX25_VALUES_DS_TIMEOUT]= AX25_DEF_DS_TIMEOUT;
-#endif
 
-#if defined(CONFIG_AX25_DAMA_SLAVE) || defined(CONFIG_AX25_DAMA_MASTER)
 	ax25_ds_setup_timer(ax25_dev);
 #endif
 
-- 
2.43.0


