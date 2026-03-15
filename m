Return-Path: <netdev+bounces-267958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mbz8EQ4Tt2krMQEAu9opvQ
	(envelope-from <netdev+bounces-267958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:14:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937B42924E0
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 282F1301DB9D
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6303793B5;
	Sun, 15 Mar 2026 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFd/afty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A29F374730
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773605643; cv=none; b=BpCG/dOiEI9HhVLm9An/Ph7VKW+gLRtg5A9epN1SqZe9aSYpDXppSijBWz2yZVN9K7dl0cvfGTbkRFhpd72JcNeFGQEAn+VVyVyuiX8Xt1DT2qyRy+nhm/XEqbBWcUfI3dgzTNfPPuipWfp69GTSf2W+7W4PNQuCQSsxwH/YPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773605643; c=relaxed/simple;
	bh=JTnQBr1hO/xWpfU8xi05c29yIU36GnMsbOVQH5ITFK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtBOCaZPY0oRVFlNpiuS3uot5UetUPmTXzuNXh0kgmS/tbrA9fClI8rJuWWB+rOfExqeT7b4RbdgNypGAP7FlZkDABMEay8ambMNC15dH1S8uNHGx7Jo7eaZLUbOXOk+Iku3IATpsXQ05mtVHZtLuegmBkiy2+o3+UYOUgmj7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFd/afty; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a159c1e65aso3776286e87.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773605640; x=1774210440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9624syQHi1GswpveoPaw7f2G3Mt97gB4ud0+FlUOGv4=;
        b=jFd/aftyI1L2TMAuCU8+y4e8ZWVfx8+FNbeoNYJKxIuDsi3BGQ91NAkkwjt9nA9VQJ
         OlUg9y9e8jVktud+5VOfqlWZ2elu7CjAhjGVqG1wES6qEjJ2k6JBm7+9aqePC7/PjF12
         Dl01j7uIkBAqJq4Zd62WI3TvNvVgagNQQlr8nEX6tlBr6Tonsdlo5NPpdSkxxuAAj09O
         keFHpRq5kd1OZ33gW3zTOrthyChbrAyk51C9aux1MThaFSqlTY6XpmW8g1+btxgu3kUc
         RlgA4GKLyqQr3nlti0Xx+Nxpw6feFSTgg2V1iqAGsOidC5uuEd47/FWRPmCBIk6GjcWH
         ce/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773605640; x=1774210440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9624syQHi1GswpveoPaw7f2G3Mt97gB4ud0+FlUOGv4=;
        b=A8AIVGOxKwMvH2Wrt4Su9iTt0mNOXl2GTPDwD7OReZVIIodu34ZikR/Dm93sVFjQe4
         ZhpFq4nosnBlU2FJX3DVnOO82AKb7mo+YGMkaAfkFon5EXCYKDq9PE4hSFpsxwv+yWJw
         LifyMOSC8cwY/kxFxdRu08MMWGb5ETyAQCx49rpCPaC5Z91Ql4D5Vhn5fqt7th3TlCOQ
         Z+r65ZS1py/izRq3fXHrUOvgg8G4ap6l+XXq3wBNWcYf1kU2iVPZsUoE5f+3fBLK8K0A
         hugc60J5XpuD6H+FsyXXnM7PcxT1vfrv9Y5WCpzVQevn9VE0AlxE+nbj9VFaAjLsy9Kk
         GvlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj+KrKInp1n/jnhE4KzPwF75b/9oonSrf4HP6l8UcWcO7kgjdgHex7UAX/XlYHeeoFAjgEKRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXOrSIjEiN660b7NY27QbsmuqAaZ3BXtD3Ww/JaB5E2iurVPp
	NGHPMzOzoiZ0dU+b1kq0FpARAFDjw0NL46q62udWTzT3FVBBzca42xjWCrxFpg==
X-Gm-Gg: ATEYQzx65hVicUhNXJuekSpt8cT9OyuFNphneb5R4vNyX5MfXVRm+dR5qdyCYF98pse
	mz4lvWwaj+ZA/p7AWg0re+ULVMv+52z/KLsZanNp1F1irPWQaZGaEITz9bfqRIUu6h2D8asg/yc
	VhB4xra4p3AnAyEpNKIQ0TP5xP0P3befJdg0llgkM2/ce1XctJ4dXI64PTdvK/UXbWD0saDQeGd
	3oUhlbop+yIJga/3YMzb+jf/ezlO+e447KT+x1SWClQvmAQ35XdIRWxspTcfAzg3bTIVPGDTdER
	CjFq0/ljN98+9CfHCZ+xTS0kTv5TKVa4auzQ7RFLQ5vguhDpqXNJu9rdYTmqoiqk9Bfi5N4gG+l
	lArlXGllffIpQgIlC9z78M7IQsZSCPRD+Tgqem6p2vEb4S7N+nymzeifflRznCVQu969VtM40g0
	ZrO/R3Czu5OdgV8h5Ayp8OUlB8YtMNPKJuMuaQ1UALhp1eVK8GOGl3Da1Rh7dpphVMDDMGXCapk
	Q==
X-Received: by 2002:ac2:5fd0:0:b0:5a1:1d47:76e1 with SMTP id 2adb3069b0e04-5a162aeea90mr2571448e87.3.1773605639284;
        Sun, 15 Mar 2026 13:13:59 -0700 (PDT)
Received: from T6NXCV08J99224A.lan (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33b95sm2970945e87.15.2026.03.15.13.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:13:57 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH] net: macvtap: add missing blank lines after declarations
Date: Sun, 15 Mar 2026 21:13:38 +0100
Message-ID: <20260315201338.12943-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267958-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rayfraytech@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 937B42924E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing blank lines after variable and struct declarations
to comply with kernel coding style.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/net/macvtap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index b391a0f740a3..bfaa80a77876 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -38,6 +38,7 @@ static dev_t macvtap_major;
 static const void *macvtap_net_namespace(const struct device *d)
 {
 	const struct net_device *dev = to_net_dev(d->parent);
+
 	return dev_net(dev);
 }
 
@@ -46,6 +47,7 @@ static struct class macvtap_class = {
 	.ns_type = &net_ns_type_operations,
 	.namespace = macvtap_net_namespace,
 };
+
 static struct cdev macvtap_cdev;
 
 #define TUN_OFFLOADS (NETIF_F_HW_CSUM | NETIF_F_TSO_ECN | NETIF_F_TSO | \
-- 
2.43.0


