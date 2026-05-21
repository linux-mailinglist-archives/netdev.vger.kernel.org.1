Return-Path: <netdev+bounces-290265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJmPGJe3DmrBBgYAu9opvQ
	(envelope-from <netdev+bounces-290265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCFE5A047A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA33B30183EA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355839D6E9;
	Thu, 21 May 2026 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pxq7AHQZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F239EB40
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349366; cv=none; b=Qegl7GsDRS2G0PWcAOIA0H4V37SL3tgRCxgjJ6lYrqPsQeq3P52xgNLwz5cyA2SgURrXGS6eJ3s9yvzOyu9HWdJm8mNtk4MdimXtWEKwpYdhdSxauC0jk7NjYIGuLG03uEsNPuZdeEZzJpHAPyKn7aNTO5sP5QbhGJZpOJi5USM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349366; c=relaxed/simple;
	bh=tktVq9JMPVsy5zDE32jnjHbEwlypplpwbDoixRuEe5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gotg8e93sIbC23cUNvzBxpLeR2TeOP1rtesh2B5tMNfZam1wEIVn7K76h4XOM0sV0BsvJcop+Im2EgOEpu7s9wK+ZCVOhDpNr3/dpPM37Jmzb3GKPmJ8LcsjILSjW9xWAu1H6vlL7QwRYqe6lmylWz2I8XhzhQ9g//E1T0j9/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pxq7AHQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779349364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oz712sY0S2BpVP2QIYr07sRP4GmuPZWauVckLnL+RJA=;
	b=Pxq7AHQZ88mO+FnRLnoPjRMI3qYlgOEP4/UGEhQNA3N1lo4ffwoRvllbBaOU+r6xm4p8Cm
	xyjvQgQb5TfBd4R3z/APIhlNV7o4MdYULHu4iFgxOKmj4jUSR38+6IDWa3r2riyMtMZDCc
	n4jO+MBDkntZwRpuayS8mjjDlyZfFeM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-bedWjxUyP5-2kDk6KwSN6Q-1; Thu,
 21 May 2026 03:42:38 -0400
X-MC-Unique: bedWjxUyP5-2kDk6KwSN6Q-1
X-Mimecast-MFC-AGG-ID: bedWjxUyP5-2kDk6KwSN6Q_1779349356
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A6E01956048;
	Thu, 21 May 2026 07:42:36 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D605919560A6;
	Thu, 21 May 2026 07:42:31 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
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
Subject: [PATCH net-next v3 1/2] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Date: Thu, 21 May 2026 09:42:19 +0200
Message-ID: <20260521074220.432590-2-ivecera@redhat.com>
In-Reply-To: <20260521074220.432590-1-ivecera@redhat.com>
References: <20260521074220.432590-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
	FREEMAIL_CC(0.00)[nvidia.com,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290265-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 1DCFE5A047A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
the NCO mode of a DPLL. When connected as a DPLL input, the DPLL
enters NCO mode where the output frequency is adjusted by the host
via the PTP clock interface.

Update the fractional-frequency-offset and fractional-frequency-
offset-ppt attribute documentation to note that for INT_NCO pins
these attributes represent the DPLL's current output frequency
offset from its nominal frequency.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes:
v3:
  - Fixed Signed-off-by position
v2:
  - Clarify int-nco pin type documentation to describe frequency
    control via the PTP clock interface instead of generic "controlled
    by the host".
  - Tighten FFO attribute documentation for INT_NCO pins to describe
    the DPLL's output frequency offset from nominal frequency.
  - Mention both fractional-frequency-offset (PPM) and
    fractional-frequency-offset-ppt attributes in the commit message.
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


