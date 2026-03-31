Return-Path: <netdev+bounces-273569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDisAuCmy2nJJwYAu9opvQ
	(envelope-from <netdev+bounces-273569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:50:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6036851D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC79A30A1246
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0ED3A9623;
	Tue, 31 Mar 2026 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdLEbs+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F043A9D99
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953849; cv=none; b=afJP61JSPQhuTx8LkGM7n3djriDNy98e4Aoz5Ddl9HUNMbLFZhLUk7g4ZybwJWesca6JLTKw9jRJnSoP2vsZHMeemcTCtlY6sp92ZnmmVeGLfzjDkPC6rUmtaT2ln2hzKVe1WIyg0GXDOENWROF21+u9iU8xvrxcxNXlw2Ary7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953849; c=relaxed/simple;
	bh=YQeIxDJ3em8cDjCthiN9QigtOKJGNRzkqs9f3uOZpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgZzsC14XtiyN2STrn/7l7c1Lbh+0oJylOEUKwKlm/wRfFjsyuZiuJQj2uz41iuOQGrC6J4j1Q0HcRWEfVDg965zvS/d4K/kiQhYGLKxo2tGWWNnSbMlHvOWY0yJUccPd6sXHKiXABjMYOj43vVqKA1ZZOATB6QrA8DJrAPPvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdLEbs+Z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1828987a12.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774953846; x=1775558646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6llizdqrxhxeXZpldB/jX1ydpLfLM9IpYcXgdeXc7g=;
        b=QdLEbs+ZeXC8Sezyq6NiIzKpumxcksIkWkDWdTrBQD7F0wldeSRCvFpovWp0qvIbjQ
         9GNo3GdL0JUpcQnGSP06bjxlYhGkEwVQJgXzL5t08Jg64xp7E+aZRu/bNXzNUngF0j8u
         NexWJswdI/2HGkeAi2GQBx06SA1XfTXz0qqacsWi4Sm0e0DdbuEMQOPP2pk5iEMF2+d9
         atTK2qCFjJOTf4zR1YjHBobG6LGBkMrA3r+27MP1GnE0AS9ZHs9TmGTOCHYDpt0kdhLa
         8ZrxF8n/Rs78iIQXkqzYzZfJad74z7irf6ULYIplHNs5Jo4E/FM1M56ii8QaFXoZS2wF
         PUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953846; x=1775558646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6llizdqrxhxeXZpldB/jX1ydpLfLM9IpYcXgdeXc7g=;
        b=jq6bGZoL89ddUt03zRXcZtcwvLpht4+PSMKejvUoIeePySmplXhGD+USDLDULkw8oG
         UXHvyaBw5eaJjZKaDsOJYFHV7cPMGBv+aQmcQzbEm7EeN/RsGV5oZAmjqrpWA1RjbTpE
         3xS3dMhFJcNUzOv8imB6TBmcYXXlcS4vwS2jprBMMZ/gG2241ndIsiRbrGA/WB8utNP2
         Kas9QYh7etRMa7v59Oizm4Mbu4hyfnGEnzjTVR0YAnRSH2twPWfRD6ViWtLgxZ8W8+1A
         YigFsBEEQxz/0wbM2WGei84oyRfeC/Ug4cIcAzqiuMGAwrIWLE19krTTOfmU+XpLE0A3
         2KqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtO87qx0RZyIxvfowTi9BLxoDOjTaAEXDWy4DEdF6igE3hOUZksNO7M9n+X5iRNAXCM8lFiNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaX16rq5HK6fVNQY5wN0NANh03aOd7Y6MjHj46hS4jZ0Dw4fPA
	/74cA/kscwY8eFlT/oB2cDtNw91GDtM1xXZcqsrZUQuujiGyRoQdUj03
X-Gm-Gg: ATEYQzwFFlthGz2DAx76LnApacQ6lcYjoiadJA+AYDzTHi7c0m6i2ddWZ5hnx3Q/Id+
	4lQElX9oXqpzUWwfxVXY4YjbTZjtCSKJI7X+iV+iNMC1TebfAEmsMmOBR9x709xlUkOc9/wTsKH
	tyYcwj+jfwzQTzbmRt+X7kvBAYB1MuquHmrss245oPr2FN0y89SCsLR9abzwlcig2ebYQwx1v+H
	e0Znc6W/HrDNIkG5QuJ9anFrDbXGGmcwOa+l+OHOSCVsl+b6WtmIq7c+psp6nmX81gu2XOB4uyQ
	7JMZpN0WzV2N1od3UgMwmhtmYyKuBoJ9nZhfs0G6UVT0orpwFqJvMcYkvw16wExOseuCQz7W7nR
	m0+rqvxLJgMC4YROFnmKtpo167Om36hPujKeGtij8S4Nxa3GA8Wi3gBLh8QHXKrdhyFL0e6W0kR
	tTYyGKBi07S3fmDOKCXIs7IuHj89zBm+lJDJoAbujs+QOmPnnNQAY0JD+WGu9bW6SpsELuaKpdU
	IrkkCOD0TKvtrvYSm2NDewBsYVRRr4BBsWeoxwVoPhHg6Fta0NX/y/U5Xk8Z+O6Hcvc
X-Received: by 2002:a17:902:da91:b0:2b0:5ec1:97c1 with SMTP id d9443c01a7336-2b0cdc238f3mr165881155ad.7.1774953846473;
        Tue, 31 Mar 2026 03:44:06 -0700 (PDT)
Received: from ip-10-1-46-91.ap-northeast-1.compute.internal (ec2-176-32-72-196.ap-northeast-1.compute.amazonaws.com. [176.32.72.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b25f2016a0sm33969045ad.29.2026.03.31.03.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:44:06 -0700 (PDT)
From: Daiki Harada <daiky0325@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daiki Harada <daiky0325@gmail.com>,
	Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-next v1 2/2] igc: use napi_schedule_irqoff() instead of napi_schedule()
Date: Tue, 31 Mar 2026 10:39:20 +0000
Message-ID: <20260331103924.36422-3-daiky0325@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331103924.36422-1-daiky0325@gmail.com>
References: <20260331103924.36422-1-daiky0325@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-273569-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daiky0325@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DB6036851D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace napi_schedule() with napi_schedule_irqoff() 
in the interrupt handler path in igc driver
Tested on Intel Corporation Ethernet Controller I226-V.

Suggested-by: Kohei Enju <kohei@enjuk.jp>
Signed-off-by: Daiki Harada <daiky0325@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 72bc5128d8b8..712605886104 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5688,7 +5688,7 @@ static irqreturn_t igc_msix_ring(int irq, void *data)
 	/* Write the ITR value calculated from the previous interrupt. */
 	igc_write_itr(q_vector);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -6059,7 +6059,7 @@ static irqreturn_t igc_intr_msi(int irq, void *data)
 	if (icr & IGC_ICR_TS)
 		igc_tsync_interrupt(adapter);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -6105,7 +6105,7 @@ static irqreturn_t igc_intr(int irq, void *data)
 	if (icr & IGC_ICR_TS)
 		igc_tsync_interrupt(adapter);
 
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0


