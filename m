Return-Path: <netdev+bounces-288656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM3eIi2wCGrz1AMAu9opvQ
	(envelope-from <netdev+bounces-288656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:58:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974E55D017
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71679300646C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A1379991;
	Sat, 16 May 2026 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMTJGR4V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C630EF88
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778954283; cv=none; b=ipIB7/KTdpCYxNWN7XJEAP9FUig9OajwLMw2nV7LOamA8KC8rNQwN8MTBt3oKCtRTr0iuFOOdxa8PMvqgXtJSDQOjLR9Y5qyv1XLI4/X7pFW+12NZo52ZSyMD7y5eD1hddXYX7bjZNoIV8dSKJhfFOKpl5oQ++qiuA/Y3uqpCBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778954283; c=relaxed/simple;
	bh=T8p5PbMu6UDKILWSJjQ1rFYVYldSvGN+tDK5DhIG440=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNAnbtNmuLQVQt7Iv91nM+/nqir87cRhXd13dhLshOtWWOLE1U4mB57zPL2CEh4oZEkxxvq9UocXlXF+5w/vKPajzPfWXr7nRBNR0KsaNdYeY0VQGE/8yBPGhdc4JoZr09vcWk+B/w9gIhcUbkhq8dQ5+LedpYS/tUAbA4048aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMTJGR4V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778954280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhQtsJ1+a4+bBPyFykt2A7jiDOqPdZlXQw3maRFRXCw=;
	b=gMTJGR4V3MMNtMbAj4NE25waEgX0deq+t4dZ4yuLG+cyUsXaOqLQo1awrsZluDzvGlOp9c
	S+FpG6Ds55gaiDwteSH0EQxiU5s+tQwPtL9criS4vyw5F+wGIttiVxgLUIT+m5pcBFHCJS
	k/tZev36Z0Mw0OoACeeFhgbw+R9aMJc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-8afApkwvNjSPu6TESAftIw-1; Sat,
 16 May 2026 13:57:57 -0400
X-MC-Unique: 8afApkwvNjSPu6TESAftIw-1
X-Mimecast-MFC-AGG-ID: 8afApkwvNjSPu6TESAftIw_1778954275
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CCE21956080;
	Sat, 16 May 2026 17:57:55 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.48.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D28D11956053;
	Sat, 16 May 2026 17:57:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Date: Sat, 16 May 2026 19:57:43 +0200
Message-ID: <20260516175744.26749-2-ivecera@redhat.com>
In-Reply-To: <20260516175744.26749-1-ivecera@redhat.com>
References: <20260516175744.26749-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 2974E55D017
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288656-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
the NCO mode of a DPLL. When connected as a DPLL input, the DPLL
enters NCO mode where the output frequency is adjusted by the host
via the PTP clock interface.

Update the fractional-frequency-offset and fractional-frequency-
offset-ppt attribute documentation to note that for INT_NCO pins
these attributes represent the DPLL's current output frequency
offset from its nominal frequency.

---
v2:
  - Clarify int-nco pin type documentation to describe frequency
    control via the PTP clock interface instead of generic "controlled
    by the host".
  - Tighten FFO attribute documentation for INT_NCO pins to describe
    the DPLL's output frequency offset from nominal frequency.
  - Mention both fractional-frequency-offset (PPM) and
    fractional-frequency-offset-ppt attributes in the commit message.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/netlink/specs/dpll.yaml | 13 +++++++++++++
 drivers/dpll/dpll_nl.c                |  2 +-
 include/uapi/linux/dpll.h             |  4 ++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 91a172617b3a9..5cdb93e8649a0 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -162,6 +162,13 @@ definitions:
       -
         name: gnss
         doc: GNSS recovered clock
+      -
+        name: int-nco
+        doc: |
+          Device internal numerically controlled oscillator.
+          When connected as a DPLL input, the DPLL enters NCO mode
+          where the output frequency is adjusted by the host via
+          the PTP clock interface.
     render-max: true
   -
     type: enum
@@ -453,6 +460,9 @@ attribute-sets:
           offset on the media associated with the pin. Inside
           the pin-parent-device nest it represents the frequency
           offset between the pin and its parent DPLL device.
+          For pins of type PIN_TYPE_INT_NCO this represents
+          the DPLL's current output frequency offset from its
+          nominal frequency.
           Value is in PPM (parts per million).
           This is a lower-precision version of
           fractional-frequency-offset-ppt.
@@ -499,6 +509,9 @@ attribute-sets:
           offset on the media associated with the pin. Inside
           the pin-parent-device nest it represents the frequency
           offset between the pin and its parent DPLL device.
+          For pins of type PIN_TYPE_INT_NCO this represents
+          the DPLL's current output frequency offset from its
+          nominal frequency.
           Value is in PPT (parts per trillion, 10^-12).
           This is a higher-precision version of
           fractional-frequency-offset.
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index b1d9182c7802f..2dab99202764f 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -61,7 +61,7 @@ static const struct nla_policy dpll_pin_id_get_nl_policy[DPLL_A_PIN_TYPE + 1] =
 	[DPLL_A_PIN_BOARD_LABEL] = { .type = NLA_NUL_STRING, },
 	[DPLL_A_PIN_PANEL_LABEL] = { .type = NLA_NUL_STRING, },
 	[DPLL_A_PIN_PACKAGE_LABEL] = { .type = NLA_NUL_STRING, },
-	[DPLL_A_PIN_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 5),
+	[DPLL_A_PIN_TYPE] = NLA_POLICY_RANGE(NLA_U32, 1, 6),
 };
 
 /* DPLL_CMD_PIN_GET - do */
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index cb363cccf2e2a..9245827de3cfd 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -127,6 +127,9 @@ enum dpll_type {
  * @DPLL_PIN_TYPE_SYNCE_ETH_PORT: ethernet port PHY's recovered clock
  * @DPLL_PIN_TYPE_INT_OSCILLATOR: device internal oscillator
  * @DPLL_PIN_TYPE_GNSS: GNSS recovered clock
+ * @DPLL_PIN_TYPE_INT_NCO: Device internal numerically controlled oscillator.
+ *   When connected as a DPLL input, the DPLL enters NCO mode where the output
+ *   frequency is adjusted by the host via the PTP clock interface.
  */
 enum dpll_pin_type {
 	DPLL_PIN_TYPE_MUX = 1,
@@ -134,6 +137,7 @@ enum dpll_pin_type {
 	DPLL_PIN_TYPE_SYNCE_ETH_PORT,
 	DPLL_PIN_TYPE_INT_OSCILLATOR,
 	DPLL_PIN_TYPE_GNSS,
+	DPLL_PIN_TYPE_INT_NCO,
 
 	/* private: */
 	__DPLL_PIN_TYPE_MAX,
-- 
2.53.0


