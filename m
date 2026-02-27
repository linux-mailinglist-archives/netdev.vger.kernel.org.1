Return-Path: <netdev+bounces-261895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EZeHn64oWkYwAQAu9opvQ
	(envelope-from <netdev+bounces-261895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:30:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 927CE1B9CAD
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27F8A306B44C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBCD3624D2;
	Fri, 27 Feb 2026 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEwLk5w+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82743C054
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206023; cv=none; b=LZbSEbgw9xZDuOvtlOUEoTv3zdWdA4JMjhPmbgqknPwdLzvHXQVPzVeDEL84U+zKn7rDxSfmzxhVd+l9sp5RjRx8PVdY3ilWfwELbL/wPWTZO59xj8phndhj2MKInKj+gp7IfuCFlT/hHkJelqL2Y4Bhf/mCxLI4kN5rchhlvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206023; c=relaxed/simple;
	bh=DsCvTnRonbBjO2JlO28mIxQ6YAbIlpWMICrRxDHCp3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u54nH7qYGqnAcwss02JiVUAMk9AJGthpkx0mK9Die4HlVWJ1j+X5uhMYJgVmUM2IzBeIvJ/tQZaTZqM81EAEzkjc6/d3+xVtwAnbQmux9HrW8tLCogVGc0VICHZvgOQB/Ok0c/aT4nz1+WsXnT7uybpJc2/Zwd7FHk9Yl6x00H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEwLk5w+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-826c49b7628so1456579b3a.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206020; x=1772810820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX9CCCw8zu4UXrbXJRhFhr2cp9sA+7MdybCVq3xcDCE=;
        b=iEwLk5w+Kf3q5yOK6GSPqVYzOPjfJrhuLsFuv4x+oEbMbDj/kQd72GoJS2yLzpy+ai
         SBLsrY7CkHs8AAZwSX0dT5VgVNGMvGGualCq+wcHNoJqM9hQ9fGXp5or+1nixgq/8PVu
         2R6EAixSFyqh6ih6/jcDaqoqdDNaY7Zr6D8zY9+jaAu8fqHAMrt3AkPxEEYoVhCIcLmf
         dPNIIlqhRJFNp7jlhHdd03491thNzNlFNhtYYK7BdLnxW49w1PnhW75/UACsnJbXjY6r
         +/YYoSmXhNMBbH8OMOe4Kt4hIrotYrwffgtMDo3EpOfRnxKphNa+DvKZdk84oFQGW0GZ
         ElOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206020; x=1772810820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rX9CCCw8zu4UXrbXJRhFhr2cp9sA+7MdybCVq3xcDCE=;
        b=MmzpAUqTKcaKtO//TLhGg3w0Ve6eAjk2cW92FwK+0ucbgadeqT4vBX+JekeW88+F8E
         8Pi9YoYo68QRHofDdGtxAcKdmlmE5JrDOfxXx6OcAoMfnNOJwNVrkTGbKCdZfBs4Otib
         bDLmeEtP8dL/sPHlRporQ3eQh/yKlqaNQc3KUVc3Byr6tkAMOs5zCk/LunU89JaGs+2y
         rDh2U7wqX8dX5EhrFQ7fjzJDQZFgKEecUUNs9X4/meWguZ6+cm/F752aY2/rRhKE7SEr
         k/G0Ix9cpZL3MxJmlq/ke7K7hrHLQocdIhjzN7Lz47p0YGe6emla3HVeWchbXu151kvF
         +XNA==
X-Gm-Message-State: AOJu0Ywf32ay5aHG4LK5uQpaYtkUFKPgFiENxZtNzxaFLSHywmIXPxCQ
	/MACyWypHzHTEFOCet7wcA4sTVveyDK6q/FihgLaZEWeh3e9cKkJ2mr2XBLfeg==
X-Gm-Gg: ATEYQzyEB44rXGWb3xgn6HY7AUt7BlfRSR1nuU7hCemc3ZAdrjiuEDJOn9LHcG1HFAb
	0VlSL9i2YnhleLmFIK9GYZbgfSUpzsP145SzDoawGirGCavujes7F8OEQSRalAFjq36DBAfgTqF
	DUNUkh1z/u8hTwz+ZgzQIMoErLqkbBDKb6TFnLwaBt4bTFYEbVea+kQtodEHcbUg9cvERljlPQQ
	ENgevVckly+yTVTclXhBT93OMMJ3mklsjVbmpfWT1QMjT6hpeQoDNCbrQYmT5DzDNCgUlhp06J+
	I7fCbOK9NyVA1VxL+c1prgVZLoucQcOcdOjVkha3h3My7rNLF6fQ98udad6JRADxV/vh7Z0NJX6
	z8bc9p1bT65vF/FKL9uw8PAu15LzMZFV0wZ6a/0rf2UW+XDZZ0vjA/2mA+MQPvpYo46ligr1bRa
	97TVxfX4VI9EUlyCgXYlhT19dLgJCG/rHkuV2MNqu+a9haUMGgZAOZVEjrY79Bzs8mxT66EXl98
	tcZqow=
X-Received: by 2002:a17:90b:1ccc:b0:340:b912:536 with SMTP id 98e67ed59e1d1-35965cec355mr2681607a91.31.1772206020190;
        Fri, 27 Feb 2026 07:27:00 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm9053211a91.0.2026.02.27.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:26:59 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v4 2/2] net: macb: use ethtool_sprintf to fill ethtool stats strings
Date: Fri, 27 Feb 2026 23:26:24 +0800
Message-Id: <20260227152624.164964-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227152624.164964-1-seanwascoding@gmail.com>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261895-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 927CE1B9CAD
X-Rspamd-Action: no action

The RISC-V toolchain triggers a stringop-truncation warning when using
snprintf() with a fixed ETH_GSTRING_LEN (32 bytes) buffer.

Convert the driver to use the modern ethtool_sprintf() API from
linux/ethtool.h. This removes the need for manual snprintf() and
memcpy() calls, handles the 32-byte padding automatically, and
simplifies the logic by removing manual pointer arithmetic.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bc35f651ebd..79ca19097b2d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3145,7 +3145,6 @@ static int gem_get_sset_count(struct net_device *dev, int sset)
 
 static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 {
-	char stat_string[ETH_GSTRING_LEN];
 	struct macb *bp = netdev_priv(dev);
 	struct macb_queue *queue;
 	unsigned int i;
@@ -3158,10 +3157,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 			       ETH_GSTRING_LEN);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
-				memcpy(p, stat_string, ETH_GSTRING_LEN);
+			for (i = 0; i < QUEUE_STATS_LEN; i++) {
+				ethtool_sprintf(&p, "q%u_%s", q, queue_statistics[i].stat_string);
 			}
 		}
 		break;
-- 
2.34.1


