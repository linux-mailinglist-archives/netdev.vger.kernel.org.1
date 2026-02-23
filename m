Return-Path: <netdev+bounces-260033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GXoMexUnGnJEAQAu9opvQ
	(envelope-from <netdev+bounces-260033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:23:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D4176C10
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C503D307DB30
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0031C1DFE22;
	Mon, 23 Feb 2026 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl+hNm+p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435A86337
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852863; cv=none; b=hThCOih62nwKQJP85yTh/CXRAOn+eTOkEF2tbJ9c7qiKrCCGlTifUF1A6yvdEPzwY0GBIVlP72g/qsKo/Wf08DqDZq8jKdxBsm9koMwH5dh+i8OFuJHm8flo8dQmCrwZRfo+YccR2wVUQKuXLrtGBL6T1vh/h0ywT1leS8Id/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852863; c=relaxed/simple;
	bh=Kj+/ajwRePtGlW3OIHCvCgyrtRYz91XA0ng0hQ25swQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eNCBfXtqZSeH9xn2sFYXgda1GNn6cSgTGxdK9YjdMCq4c42284mfAvmO19XiMlJT3vCIos3CqNNBaITYv+GZxxoRvcBIzIIBnN6xnpQyWsUErRvPhqhHb1MQNDmtZpqgNjwVO95qqSLuM/QTfRvJ86Z89wabNYquwQOUd2bbYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl+hNm+p; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35305538592so3236218a91.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771852862; x=1772457662; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KC50Ytogn6MLWiOk7iY5VOP4pMvpHMsRtorrT09M7jE=;
        b=nl+hNm+p9GUH+KOFABaQgB9t/BcS36CxFCKwyCYtOSTssj6txy3LtzKfZV7W3oN3U2
         oFWSCCNW4ybhNTwHCmsVKcpQqvrVQXKLrXPLRIA57SzPVmzlVuDxGwBtax8dmO+7hyvs
         /IftdPNPu4dUV8dPPtC7tYbH0ObScj00LjBF4LwgQmolUz2utI9l1ROuKb2HquhyYk6u
         nqJZwXcIAt3ma98AH/Cb3WLsgt2b1of/ZS3mrbnexml+SCUgzFrMiNyEG5frJwnBkquq
         QsapOQ6pozalY0Y1YjVq/2qlfeyeqBtT81p3ahJnmtjwhtX2YysGtNCUHVlK+8xA6pfE
         LBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771852862; x=1772457662;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC50Ytogn6MLWiOk7iY5VOP4pMvpHMsRtorrT09M7jE=;
        b=PiMbj/FilQrXZ2DQOtieSr3ri7lWc+W+yapi+McmPWX8iIpIYAmK600pzGQFTVF53p
         iHNn1VNjzhW4CWezFnZfUW3fx0tN6B+dyopSFlecpq7YlTQLe+ln6vGmD8vqEsM8Wftv
         7jBc4WKwymH3a7+3DKOa6myriKjdcH/v6xR4zhieA6klMXP0bMjKljXl/6GANWvUrhe/
         Y8fN4i50gDFjNOwdfjZ7SUFKPSAW28Y/DbH4vuDnJUNWNHgnL2JwVK/fc9muRbWVqVUP
         9zdKJGOkXY/swi6EGauiZByayAzxIOTLB/3sn8hqbewjGFvz+DfFBfXDwiBTk5fTe+lo
         9dAw==
X-Gm-Message-State: AOJu0YyMMPPNwL1esqy3wrlcqNlV9wwT+ymzpZGrRc5L623hoIF9oCIS
	1VAR1CUp7mQz5l5F7+k9zJdDpVdPdVCpmLe4797b7hqqTcMOY/69C5aB
X-Gm-Gg: ATEYQzytNU0DaGfMUS16Hsn6WFbgwXQndU9jvH7Vne0GS9lQE+Ddb8AvDxQgVRUKBgH
	LqUDda2r9/B7jaDlCw7CKC7J57LOp3q5MLreRf0dndJd6uwy7G6nHQGZR8aU3gV5RodE3yt4bvS
	zFgkD11mUgjQBxojseaQaZJHYgstMDUxeSelOwRt5Xq+GOSrHt27RzjCMJ1FErgXAFezbdUYu3p
	dQFKrhjH3ygKCW6yUU1gorm6a424LJQlDufGP2TiecAPA4iPsd9wHHz/ImD5F5loLecmLziBBGU
	+i1p/GQ26I9t81nd3oajA9k7dfsx0DEZ4FEZN9lI/XoHzaJ/GrUL13ns/9Oe/0T57Zw4vxbpZfN
	+qBB852NMzEn7BpxheRu86RlAiryQEuYFFcu9WzDwT7OHqPfqA52fZJz3OkyRH5i4YiN56C9/g3
	tHwtp0T6J1t7qllnv5zoIJInoom8dZNVzWGKnFLA==
X-Received: by 2002:a17:90b:5410:b0:340:ca7d:936a with SMTP id 98e67ed59e1d1-358ae8a87e3mr8330402a91.18.1771852862153;
        Mon, 23 Feb 2026 05:21:02 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:1cfe:ae34:fdd6:6b97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af93b9ddsm6613074a91.14.2026.02.23.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:21:01 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 23 Feb 2026 21:20:56 +0800
Subject: [PATCH] dpll: zl3073x: Remove redundant cleanup in
 devm_dpll_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-dpll-v1-1-d99f18c12bae@gmail.com>
X-B4-Tracking: v=1; b=H4sIADdUnGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNj3ZSCnBxdE4Nk42SLJKPEJGMLJaDSgqLUtMwKsDHRsbW1AOCcYut
 WAAAA
X-Change-ID: 20260223-dpll-40c3c8b2ab38
To: Ivan Vecera <ivecera@redhat.com>, 
 Prathosh Satish <Prathosh.Satish@microchip.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771852858; l=1086;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Kj+/ajwRePtGlW3OIHCvCgyrtRYz91XA0ng0hQ25swQ=;
 b=fGqiFWh2ai5tigH3W7Ns/6o76xTqxXMhKkzJi0gG/Gt5tD3dtXyhUsqorYn6KKLB6rY93zEL8
 wl+czRsMIj7B9sbANUsbsdLOs7BmbU7E4gnw8bdJ3B2oTfjNl2pCY8K
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260033-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ustcgu@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 692D4176C10
X-Rspamd-Action: no action

The devm_add_action_or_reset() function already executes the cleanup
action on failure before returning an error, so the explicit goto error
and subsequent zl3073x_dev_dpll_fini() call causes double cleanup.

Fixes: ebb1031c5137 ("dpll: zl3073x: Refactor DPLL initialization")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/dpll/zl3073x/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 63bd97181b9e..4ad21caec0e8 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -982,10 +982,8 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 
 	/* Add devres action to release DPLL related resources */
 	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
-	if (rc)
-		goto error;
 
-	return 0;
+	return rc;
 
 error:
 	zl3073x_dev_dpll_fini(zldev);

---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260223-dpll-40c3c8b2ab38

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


