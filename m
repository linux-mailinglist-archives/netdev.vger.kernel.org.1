Return-Path: <netdev+bounces-260460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNAbGLuFnWmVQQQAu9opvQ
	(envelope-from <netdev+bounces-260460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:04:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D134D185D8D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16B3430BB756
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DD37AA81;
	Tue, 24 Feb 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBIi9VFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016D37B3F0
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931051; cv=none; b=Xrdrm+EFyOWNUFE8j399GSw+aaoDgFMBJt9acCg16i0HvPV5Voc0+n0121eI9EH3gY0LyQac39t3j9IF2srnyLB2WSDEDydnt6gCTF+HRLCoM3S2j62OIuxrL2XhtA4gotv0G7jozEa4z7i4bo9nav5RDtxUU+19HJy9Paq/OQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931051; c=relaxed/simple;
	bh=YhP3pWD3TXopGx3GMHZR0Qk/xUp7dOSyYuWyrPsIuDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mvQFHCXIsr4GzqP1KqanALUkoua33pi4k5Clmybs+4RTk88FdrDHnT1TyqJ/0Fnfm5sDD9vXBcSolxUfd237zgYyFo6jSDwQOlo+FyZ00KKMc6EDO8HR30jiQOwpZ82W83bph3W6O1TEtMWn4+5ND7xm0fGBvDhb9bH7tnV8C/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBIi9VFt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8220bd582ddso2440147b3a.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771931049; x=1772535849; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RaCMqhL6lxzpAmD/kp38IfatllhbkDsa2tr+B08/V9c=;
        b=MBIi9VFtIk+EsaC3MqvD1YxbZixbcBwaoHkSoUhdFQEiG6cxbnGh09aHhMJE4+FnSM
         Fpp4zzJ2/cejfS8bfFkKaMFhw4GOqelBC7QISFllo2Kdsazh7CSKad/k/3wWS6eqKloL
         AdA3daICxdyi9O0ZdCk6lO55UAf+dend/4RoY21GriTb07XqkvoIZUqozZ8U8rEUXVBu
         OH7a5gJKIPJ5vJiPb1kJTQnstNXcmI7kQxOgHUVIOJ1Nyd9HHrN4DbFFe571HXFgc8lU
         eUNYEufjGVK04T5iCSPI/ss+JJqYRCNYl7a8CkoSP3nVlT2U0lbDr05L9A4y0fEu342o
         UBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771931049; x=1772535849;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaCMqhL6lxzpAmD/kp38IfatllhbkDsa2tr+B08/V9c=;
        b=T0aXj+Uxrg7rGsgx1Kq928Z0lG9FHLccETTKBKOrFVr0YVTTVwb24K34TDkmiLOLn0
         GQHqet/6ALkUZ2VyL8KA24qCkPvZi4SaceoRjGqj2ZoneLOOLRrIns5K/kLz2CBtYE6p
         dgdHjIwIboCVuYqhg3/8U8rhZ865Z7DYPFNhcFh6pFMqlzwjndzOQEToprQCNbKR50Vy
         tiTij67tQxOlklBQgoW5DnhCk0kvvhmYdO3KqLLO2KaCONVRFt9451MXFwozUvUDC8cJ
         4/lekhfsGBJNngQBs7FLDH45HNNd0jT/tmIdcc03v8qLmrETUU9CFu2v+55kmYGQpNlz
         y27g==
X-Gm-Message-State: AOJu0Yz8Gejoyh4da0ViL8btW7GEJkBTf8hLXAOkK15PNfqMgl7cYKO0
	QfpOA1OJsAoT0m1d9CrIBbk6sGuFJhPTQu2LxypVyM5JP2GQ+caIW95K
X-Gm-Gg: ATEYQzxs5a9leFvdWslnfwfGjfKaxLQCQuHKq+iY9o37zGV/afQhqyeY+6ZkDC5j9Du
	GGOji2g5Rv9Vam9DfAGkVfTzII5fSFPPhkvwTpJDYoYCum5pR0bLkJRYE2UB8n6mfLW2YJXDqwt
	/TDxvN493kD/dwOFiWd9DePUMeZhN3XKuqKDiakom4XA0rjLPGiQwWXBtQRu+rpP7VRZajek2yN
	rGkXcnVECpNBIXqFrJ9C9kenIuitE/OJ4ebt+uuWgSmFf9ri10k4mAEsUF1ahBa/yT3r4ZUDX6B
	Fz1rkhVJpS+NTzjhG9x705BxwvopmIxCxep/Pzx2iAZyCjHT+LaHMNWVdI7muvzgLs3hZHql56h
	fsTz69qNIeU7XYWB1XfhX8EgVJfbWii2HdhPo3WxaZgpKTOxDQYZQ/AEOHoXu+wdr4QSn9U0CoQ
	d9Vxb2wfyUKIxYEyJvsFOppUz2F4XvfGJu4P9J7g==
X-Received: by 2002:a05:6a00:37d0:b0:824:9451:c1ee with SMTP id d2e1a72fcca58-826daa272b3mr7054959b3a.55.1771931049176;
        Tue, 24 Feb 2026 03:04:09 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:a117:e2f3:ee55:ed0d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86c93fsm10770584b3a.38.2026.02.24.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:04:08 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 24 Feb 2026 19:04:04 +0800
Subject: [PATCH v2] dpll: zl3073x: Remove redundant cleanup in
 devm_dpll_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-dpll-v2-1-d7786414a830@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKOFnWkC/13MSwrDIBSF4a2EO65Fr6WYjrqPkIGvJBdMDFqkJ
 bj32gw7/A+H74DsE/kMj+6A5AtlilsLvHRgF73NnpFrDcjxzhElc3sI7MattMqgNlJBu+7JT/Q
 +mWFsvVB+xfQ51SJ+6x9QBBPM9f0klBVotH/Oq6ZwtXGFsdb6BSt+oYSYAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771931046; l=1330;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=YhP3pWD3TXopGx3GMHZR0Qk/xUp7dOSyYuWyrPsIuDs=;
 b=5u/X65JHjzcU1mGbmNoIxhPiXThwebGfY+M8acfEzq6+k5R2JlrXoX2auxAlF0pKsgz2zw6DH
 wJJrhLnQJPZBkEqw8InYgP2GA7qo3IVJUdFgM6+0eGkyIiY4cO2pyr8
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260460-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ustcgu@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D134D185D8D
X-Rspamd-Action: no action

The devm_add_action_or_reset() function already executes the cleanup
action on failure before returning an error, so the explicit goto error
and subsequent zl3073x_dev_dpll_fini() call causes double cleanup.

Fixes: ebb1031c5137 ("dpll: zl3073x: Refactor DPLL initialization")
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix Ivan's comment
- Link to v1: https://lore.kernel.org/r/20260223-dpll-v1-1-d99f18c12bae@gmail.com
---
 drivers/dpll/zl3073x/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 63bd97181b9e..569c2cda5a02 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -981,11 +981,7 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 	}
 
 	/* Add devres action to release DPLL related resources */
-	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
-	if (rc)
-		goto error;
-
-	return 0;
+	return devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
 
 error:
 	zl3073x_dev_dpll_fini(zldev);

---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260223-dpll-40c3c8b2ab38

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


