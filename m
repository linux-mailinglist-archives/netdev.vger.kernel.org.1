Return-Path: <netdev+bounces-289462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAm9K5ZkDGpXggUAu9opvQ
	(envelope-from <netdev+bounces-289462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:24:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9C457F925
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D9D30566CE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08166409617;
	Tue, 19 May 2026 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8/hb9WX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4C409603
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196936; cv=none; b=YQiYXhSeiNErQ7WEedEdHzsWvk17PrQc4SE9+JIhgl9mnEwhnA4FJuKLoCog5YCCZ0LHNS4dHaBEWiBaouBPG0JAnDyMgMRq/wAs1p7pZywTc45Qy5rqo3vOwp47pawhEcm6k6Chaf/EuTlSzRqQqCmJ0TcSMdTxKFMN1p4QdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196936; c=relaxed/simple;
	bh=CDNwvT4agILtR6rw1O5AVk9gtDJEn7GHHuLJcd9T2B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ter4HOb6c/tczguKWbqM3shVCcOrXwljGx2CdwvjFWdQKobbSfix7PHcrs7wrloax11ySd7DK3TykU+HmJ4j64imuIST8mk7Z5Txis1wxWpK9NnGdW5mxF5QucVRKKriH212lNPEFZym/Y4sr2LQKBOp28jrl1CJ0+24Pz1d3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8/hb9WX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779196934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dfACR+DpYMNxcAFiorOHYvOXYrKjsJZ6QVfWGevX42Q=;
	b=N8/hb9WXl4TFXp38PA3q53ECR2NPH/HWQThyHEA0GuEkrFLE8942aGNjC+q/0JYHgnW1nD
	oulA1lehgqK8do3mWAN23rzwLxv7tuSiBv0MK0WDsN5IiTv4eiq92Y3gh6ztkkhhzgosCS
	uuI5+fnwZo73GKVvCbVB4VOZC0bRAW8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-B-0Ow1XCPFi1Nlr1rSXWxg-1; Tue,
 19 May 2026 09:22:11 -0400
X-MC-Unique: B-0Ow1XCPFi1Nlr1rSXWxg-1
X-Mimecast-MFC-AGG-ID: B-0Ow1XCPFi1Nlr1rSXWxg_1779196930
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A86B7195609F;
	Tue, 19 May 2026 13:22:09 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.185])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22E7230001A2;
	Tue, 19 May 2026 13:22:06 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] dpll: zl3073x: fix memory leak on pin registration failure
Date: Tue, 19 May 2026 15:22:05 +0200
Message-ID: <20260519132205.161847-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289462-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F9C457F925
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If zl3073x_dpll_pin_register() fails, the allocated pin is not yet
added to zldpll->pins list. The error path calls
zl3073x_dpll_pins_unregister() which only iterates pins on the list,
so the current pin is leaked. Free the pin before jumping to the error
label.

Additionally move the pin->dpll_pin = NULL assignment in
zl3073x_dpll_pin_register() from err_register to the common
err_pin_get path. When dpll_pin_get() fails, pin->dpll_pin holds an
ERR_PTR value. Without this fix the subsequent zl3073x_dpll_pin_free()
would trigger a spurious WARN because it checks pin->dpll_pin for
non-NULL.

Fixes: 75a71ecc2412 ("dpll: zl3073x: Register DPLL devices and pins")
Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2: Move pin->dpll_pin = NULL to err_pin_get path to avoid spurious
    WARN when dpll_pin_get() fails with ERR_PTR.
---
 drivers/dpll/zl3073x/dpll.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index c95e93ef3ab0..64b4e9e3e8fe 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1394,8 +1394,8 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 
 err_register:
 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
-	pin->dpll_pin = NULL;
 err_pin_get:
+	pin->dpll_pin = NULL;
 	fwnode_handle_put(pin->fwnode);
 	pin->fwnode = NULL;
 	zl3073x_pin_props_put(props);
@@ -1563,8 +1563,10 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
 		}
 
 		rc = zl3073x_dpll_pin_register(pin, index);
-		if (rc)
+		if (rc) {
+			zl3073x_dpll_pin_free(pin);
 			goto error;
+		}
 
 		list_add(&pin->list, &zldpll->pins);
 	}
-- 
2.53.0


