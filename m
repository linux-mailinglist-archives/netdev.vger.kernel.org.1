Return-Path: <netdev+bounces-288438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ/gIZp5B2pL4QIAu9opvQ
	(envelope-from <netdev+bounces-288438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:52:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D7955722C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDE753044474
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CF3383C94;
	Fri, 15 May 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwUocyPV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87453388E4B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874012; cv=none; b=fAXtoD1qYLd2zoIHkh2DGTiEp8R/VwmXBywyPGPtN3xb5AYxhLYUVhcSxhrF4WzuN0wL/OWWG79Ei2l6SJhhfeIAOlQl2dp/0b/JF6yl3kRdTDDr8oLY2Z3RApyL23Dink3fGLqd1LV26U8n72oNycnoFHR/89T6LtiOB9PNkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874012; c=relaxed/simple;
	bh=fbnvVnfVCfubo/pp1vAfcXrUKRC3oJrA/MTifLYqGpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBbnjQnO+UClNL79dVlh3DQHWFMLfob/gW6Vzgo78eLUMR1+USj7Gae7S1XxrSqaKAGO34NJqpRNCTZ6CwuWLmBKnMvB9KS4O0xu2w09qQCWmf3iNEI3l84iUI9NeBvnaJG4FEL1RtPtNH1LIJU/Zt9lTAPiJ7fNv1UfKcMSCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwUocyPV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778874009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2NIKn4fllHYhX5+M/ITp2qKgfWxapBax0f2YdEN9IqI=;
	b=TwUocyPVrqCMJLWaELPZb2UH1gzkoB6Qe3hrrfgdpBi/R+mWqhvpYr2933nBfSZWuRvA/E
	vTmk+TMSYt5zOFdfgb70pnN3H8By4lga26qNGp1X+EaIZgkFKu0E5LHMyW+5MDhPRuEJKX
	V7hEeAWXWspM1qlD7cja/7TH0EOSNWo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-J1NJyPYiNi6o-AQqTU_Q7w-1; Fri,
 15 May 2026 15:40:03 -0400
X-MC-Unique: J1NJyPYiNi6o-AQqTU_Q7w-1
X-Mimecast-MFC-AGG-ID: J1NJyPYiNi6o-AQqTU_Q7w_1778874001
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE4BE180061D;
	Fri, 15 May 2026 19:40:00 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.48.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17AC930001A2;
	Fri, 15 May 2026 19:39:57 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: zl3073x: fix memory leak on pin registration failure
Date: Fri, 15 May 2026 21:39:56 +0200
Message-ID: <20260515193956.351092-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 89D7955722C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-288438-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

If zl3073x_dpll_pin_register() fails, the allocated pin is not yet
added to zldpll->pins list. The error path calls
zl3073x_dpll_pins_unregister() which only iterates pins on the list,
so the current pin is leaked. Free the pin before jumping to the error
label.

Fixes: 75a71ecc2412 ("dpll: zl3073x: Register DPLL devices and pins")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index c95e93ef3ab0..d6232aa371be 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
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


