Return-Path: <netdev+bounces-294720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CjZvG9sPIGo2vQAAu9opvQ
	(envelope-from <netdev+bounces-294720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F936370B8
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:28:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LIvrw2fd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294720-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294720-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA273049799
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BABD3C81BF;
	Wed,  3 Jun 2026 11:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9334404A;
	Wed,  3 Jun 2026 11:20:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485618; cv=none; b=R2gFyPP/ZLmQHCO0/+bDZT8nnne3FBBUhzo7lGo8RCh83Qn/FsFqNfB7uXxTpjm+PuyEWFRV4ZJmlRrY1notp3nIxZ9zbi42G7nwraJhYXUWLhm7DBKaONmuENfFr3RoZaeVHj2sLNNLTLVFOdZcu7iOzvWNDdyNWyiBqmxMVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485618; c=relaxed/simple;
	bh=XoROFfvfDRK+UYBhkKFl+wuz2PDGpekeBCa8zlw4ynE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/2iUzqUuoYGiRWuQEBsyE14JJWiRazYCr7RrklZzSASV0FfyTLDcmfvhE2mB0i/DaBwQy0JmB/LYQ35gHWiqyVLyIMtlNgpCgd1bG5tHULxEwxpIIa7BhVl9XbB6e8D8oivH5GUvNnGIsrocnNVG0pGTiJTP+IrTfqTQYvI7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIvrw2fd; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780485617; x=1812021617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XoROFfvfDRK+UYBhkKFl+wuz2PDGpekeBCa8zlw4ynE=;
  b=LIvrw2fdYB98jenzJZ56LTsjbVf7QxolKfw/gTNevlE5oHN1WOBTWqoc
   oIWqumsDcpw3GE0CtDUi6mIqfRDCcIr8bCQRujOnri797dSnNKa8JUBEN
   s4b+X3g9hF63uVkTCHk5StJzSAPdFRm6IdawYtdTlvXuHEGL2N93gJvhZ
   xOsSssK0o4CAZ54mFcMBNRUAh+SOCBVsxH9DNDXcujn+IQV4H/55dMCH3
   Tgt1MPvVy0Ol2gk3PsTDqNmGfc4dNVmHUiXnCL/gk+iXVWMSMarp5t6tD
   bDDxyO/FeeQxusechyYe8L6u85VOFct97pq2p/+sJ/YzchlMZgMf8+p+r
   w==;
X-CSE-ConnectionGUID: w1t6fByOSSel4sGaViXzOQ==
X-CSE-MsgGUID: NaeSTfv6RA+arYw7Yp3P5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81471359"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81471359"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:20:16 -0700
X-CSE-ConnectionGUID: A1nSEGfeR++nOfojIjyS/Q==
X-CSE-MsgGUID: leoj0jl/SEO6N2qF72x2tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="248142268"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 03 Jun 2026 04:20:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4F8FC95; Wed, 03 Jun 2026 13:20:12 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] net: dsa: realtek: Use %pM format specifier for MAC addresses
Date: Wed,  3 Jun 2026 13:20:11 +0200
Message-ID: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-294720-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:from_mime,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23F936370B8

Convert to %pM instead of using custom code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index d96ae72b0a5c..103039fe3086 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -573,8 +573,7 @@ static int rtl8366rb_set_addr(struct realtek_priv *priv)
 
 	eth_random_addr(addr);
 
-	dev_info(priv->dev, "set MAC: %02X:%02X:%02X:%02X:%02X:%02X\n",
-		 addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+	dev_info(priv->dev, "set MAC: %pM\n", addr);
 	val = addr[0] << 8 | addr[1];
 	ret = regmap_write(priv->map, RTL8366RB_SMAR0, val);
 	if (ret)
-- 
2.50.1


