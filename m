Return-Path: <netdev+bounces-262221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNSQFTBko2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:54:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A025D1C9539
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11618310CC22
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88215313E03;
	Sat, 28 Feb 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIA/dAJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B7430BB3
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772312645; cv=none; b=Ry+GidbbGpISHQATT1KgocE3DjVdj1Vi4p2uiidi65cphkPtxNkITM+vrjX3hHffo9Ewo8WLCjYVoGW9ivWpa2SnSSyTkuzki9KHuwpDy/NPRZ6MkFu/a2qmjrhjD2EkWWXFV2WZrRzbMDKvdaVUWkAbdbiEnayvz47Q9qhzhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772312645; c=relaxed/simple;
	bh=vBEnpf4UjvSCu8cugji2tsGiN+WeO6tctn09eypx/3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uh5reLUv1uTlSMwwKyGEqTrOsPYizozfcdllYcMka7yTIGRZoBB3rY4Ib7KtQRD7nFRSI01RMZSv4hl5hgtsDDjf0w0pe7kyMSVb1i/pjipvG/ADSAFBT9EMAp8BAJuPqE4gNrLLv75Xm1/h4xNaNL46ihbpjHTcGDt7fA5xmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIA/dAJ3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so18691715e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772312642; x=1772917442; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Adxq2U5COjMrrCHDDjEJQG++v+swEjEtVNdPRQknj8=;
        b=jIA/dAJ3BZEdvdixKknJWC9LY804e08wReJMAH6uChTxB4+rJBSBF15AVkrL0frNJH
         h5CsewH0L7K6KmQPmkUSo5N2XxyhmjruzoBoNtHhf4GE3Ph4z8mqg0lTlQ1Vfj6P9JSk
         8BHx4P0cO3TqT7PiPS0ScEKBZJwbVOH6TfcZ0H909RBREDyryashLCwW1wSAnfc4ggvk
         bikbq+oJ2xt6hPg8eoLZm8Yn3EqE00WQ3h7GsxPUxFW73vSHxti/dlfCtw5WaXc7b2NP
         r/EqzMQiqAatwx+sMODvxeYR+IxGs/dlnJYOoIMtEGkeoTNnUtNhz6Or8PyzgK8xGlV5
         oNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772312642; x=1772917442;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Adxq2U5COjMrrCHDDjEJQG++v+swEjEtVNdPRQknj8=;
        b=YejO194pVL54X2t+dGqn2Y7N5kE9gJrPCacR6ZnJ1N4I9ETBPHNsN0iQ2FUrQovc6L
         r+dzFRthngf81VSsQ2t/95xtjTnpdMccQldacTnVEKtUgeSWJVx2HYNUFv1g84Vowuvz
         id6DYs1zW5jXJCDtWAI1cStWE18VXiSxQQh47i2UqaME2kvVVwmSF8LbIk+ubWLJIJeu
         4q7O5KeWt3fsX3vAsrM9coOO59F1KaqpiF86qnMjAMOzC9vvCOXs71CQ5ovtRE9kdDcW
         utQ60SAwelVKYpQuc6C5DYskOSYMeAEyfBVj8U/afnLAzWrc5aHdauJ3CbYZg6Nfv23y
         6bIA==
X-Forwarded-Encrypted: i=1; AJvYcCV9tzGvQrqWq6ADyU9MeIRFXk/THxR0dLrzPOY1TyeYqAs/lzwMhLZCJA7QmRr09dy4hYkv0Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKVE/rIFahgN5a8UEBW9kRC6nrO9Y2YtQEyHiCFe+sECFjf/u
	Ym5FS+Zmf8wkMBKTqlamPTYg+umIBv8hLzwfhezQ7OflLUgqJ6gX7VhQ
X-Gm-Gg: ATEYQzxZ/Qr508qBaJV8lRPoGuV31Vfb960oQwafAxqC4KoaSNzPxcShtvCaW8Lz59X
	eF1mS0RpxDrszalUDzqyvZYzePFTU0UHc5XcVdcFRvBcreaH8bhfeXyaeAln2kXDbynQnxBpiXI
	DZMdpX95JDXeHe0FVvUY+63dLOYhEqjM89teB4HgfATRmbaqq5Ei/b3miFjVm/RsPgCNC+ZpvRn
	DPgIWSDrLrfR5vf+iwWqUiOeBd3OSyTABYNFGaGDI7Yg33LaB3hQl5rAVQJT1OYN2+1SB3+zexx
	9ffeSSpmAgbnw3aOF4rFiDz6SFccQUAnsDHy8tWrOgOqvjZBOWi+MiSuDSp0bHM7FOEKrl+tixE
	U/xCqVf2cAwP/XfuygD85gSJHSLB1WF0oMbdjaX6JjT7+TQdgfJ9wbxdjGc7HZZtlJvSFs9IvZM
	sAUeGxdFtRWBjhHo7Z0XXm45gns+HMt04I6rd4P+3M28bwDQYAJ0qio2Zo2CYLufE=
X-Received: by 2002:a05:600c:a0a:b0:47e:e20e:bba3 with SMTP id 5b1f17b1804b1-483c9b9425emr120331305e9.7.1772312642251;
        Sat, 28 Feb 2026 13:04:02 -0800 (PST)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il. [89.139.129.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm491790005e9.0.2026.02.28.13.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 13:04:01 -0800 (PST)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Sat, 28 Feb 2026 23:03:59 +0200
Subject: [PATCH] Update old references to /usr/lib/iproute2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-usr-lib-to-usr-share-v1-1-a09da2a7675e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MMQqAMAwAvyKZDdQMon5FHGpNbUBUEhVB/LvF7
 W64e8BYhQ264gHlS0y2NUtVFhCSX2dGmbIDOaodUYOnKS4y4rH9aMkrY3CtpxgnFxsPOd2Vo9z
 /th/e9wPCUUhNZgAAAA==
X-Change-ID: 20260228-usr-lib-to-usr-share-c09a2ffd0f8a
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: Andrea Claudi <aclaudi@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>, netdev@vger.kernel.org, 
 Yedaya Katsman <yedaya.ka@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772312639; l=1702;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=vBEnpf4UjvSCu8cugji2tsGiN+WeO6tctn09eypx/3U=;
 b=BZtZ2PeHKNZeWnUZ6077F9xgsWdyDGnvyKsCWAuoUxaORaDBtSeYqW3n1kCYQ+V1+fNGYA0d/
 CP8nl+7mlStBCWVWwa/W72nECP9CDTQQGTiyT430rDJKzQ0+GtO3OYW
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262221-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yedayaka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A025D1C9539
X-Rspamd-Action: no action

In 962692356a1c ("Makefile: use /usr/share/iproute2 for config files")
The path was changed to /usr/share/, but a comment and a define were still
using the old path, Update them.

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 include/utils.h | 2 +-
 lib/rt_names.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index e0a9c780cb9eb16223905374916813d1b1e7711f..9d3e152775904a7de0cfb5833128590eb94e2f7c 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -40,7 +40,7 @@ extern int echo_request;
 extern int use_iec;
 
 #ifndef CONF_USR_DIR
-#define CONF_USR_DIR "/usr/lib/iproute2"
+#define CONF_USR_DIR "/usr/share/iproute2"
 #endif
 #ifndef CONF_ETC_DIR
 #define CONF_ETC_DIR "/etc/iproute2"
diff --git a/lib/rt_names.c b/lib/rt_names.c
index 7dc194b1530cfdad3bc3b20c3b9e3bb0d4d09cb0..01ad87b41cb2a02b7bf7ec12c8c50fc38830ebfa 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -208,7 +208,7 @@ rtnl_tabhash_initialize_dir(const char *ddir, const struct tabhash tabhash, cons
 	snprintf(dirpath_usr, sizeof(dirpath_usr), "%s/%s", CONF_USR_DIR, ddir);
 	snprintf(dirpath_etc, sizeof(dirpath_etc), "%s/%s", CONF_ETC_DIR, ddir);
 
-	/* load /usr/lib/iproute2/foo.d/X conf files, unless /etc/iproute2/foo.d/X exists */
+	/* load /usr/share/iproute2/foo.d/X conf files, unless /etc/iproute2/foo.d/X exists */
 	rtnl_tabhash_readdir(dirpath_usr, dirpath_etc, tabhash, size);
 
 	/* load /etc/iproute2/foo.d/X conf files */

---
base-commit: 218757a8b8bb431b382d7a104edb6ed4336d3b43
change-id: 20260228-usr-lib-to-usr-share-c09a2ffd0f8a

Best regards,
-- 
Yedaya Katsman <yedaya.ka@gmail.com>


