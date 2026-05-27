Return-Path: <netdev+bounces-292371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II3NJS4aF2ov4gcAu9opvQ
	(envelope-from <netdev+bounces-292371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:22:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E34ED5E7B01
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB34E30B5A41
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C294438FEF;
	Wed, 27 May 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFTF5F0d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691594266BA
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898405; cv=none; b=ZDZ2I5mGda3LSgDmO3mIafkcWHLruB/dbHS9f1QTvIyK5UM6owpWnKNqsCysLiHIw/jCrpzVuTONwiNqI+Tw/X2HjXwgVMmI3ktcHwV7ixyGYKyZnMtF0hcz9X00FTQ8Qzcxc0A4jaU4WLHi1kWP1+iBhq/hQc7ALX1KrULdLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898405; c=relaxed/simple;
	bh=j4Jjp6nEOjEmwAmdRBZ09+RgL1Y8Yi6keEPpAPUlVAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyBaEmHL51Nox1YKFN3q1SaF6hgD+2v3x38D3WbKfjCbTjE6i2SylRrcXgN/y6Qq1EM54IfCkGQWntjc+YuDqO4wG9kRHDDvlGwil6D34/eEEsZjUvQ7VwK2l7AW7A7aKwudjW1E8pQd20ex3V/T5u8GwbRcpMYeoNdlaYCDUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFTF5F0d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779898400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ow8OirZdS6gb+ZP38FzHIeBgDOLzreU2b2dwfvbHcfw=;
	b=SFTF5F0dRcgWi5U3hMq1HSs2+wIk47kLKh2vCm49575u4a6wpxeT7YxTk4OHzT2rhwrbpR
	hGa9X4Z47nsqqFDdIvQfwMU9Jk8uFYtBRDZKoqhBDMj5jwOBJVOI2zDtbYXtle6OzGcqjE
	jQjjy5JBQomiNZ+P+42ukDUUIYJZ+v8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-KPkCroZ6PLixzVA9euOwZg-1; Wed,
 27 May 2026 12:12:55 -0400
X-MC-Unique: KPkCroZ6PLixzVA9euOwZg-1
X-Mimecast-MFC-AGG-ID: KPkCroZ6PLixzVA9euOwZg_1779898372
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 206031800611;
	Wed, 27 May 2026 16:12:52 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.40])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9BDA1681;
	Wed, 27 May 2026 16:12:47 +0000 (UTC)
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
Subject: [PATCH net-next v4 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Date: Wed, 27 May 2026 18:12:38 +0200
Message-ID: <20260527161241.86655-2-ivecera@redhat.com>
In-Reply-To: <20260527161241.86655-1-ivecera@redhat.com>
References: <20260527161241.86655-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292371-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E34ED5E7B01
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


