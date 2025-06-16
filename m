Return-Path: <netdev+bounces-198232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90414ADBAD9
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9001891434
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251A728FAAE;
	Mon, 16 Jun 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exzJVXcW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D828BABF
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104951; cv=none; b=Y71wQvBf+m5Hx5BozFO86euCLAAXXYvjNNc/47tWapFxSaS+QC5WnvEfB/ZRTUlR+miHCc2EmwYVVIcBGaJ0qql+OczxYuwCgrMGKuMoUw8wXgIiK/0F1S2wMHfHYx0LAJBQOANRxcbcwjYI4dikmhLDdZPp3uZwKbAgibfmsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104951; c=relaxed/simple;
	bh=DmT4Bise/vCChRzplVSqDd2BI/p2bI1iSO9roexnDw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frTmG4rhN32JUl/HKuyeofV3FP5m0uAdLSGx8ZC3YsY4gdocKZMe+ieIUsRd8d68JO6lxj4bYi19i0aZzW5jpqvbP3WbH6KybgQzARYiIZ0cPi83dcLRX6UYdnLUaIOwN+2XcfslYZisFNIgmJjIezbgeOn7Ga4rlqr1fUqBWuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=exzJVXcW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750104948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XK1DvpuFfEECjOWlQarzmEVhfydKQ9Mv1sIMUipbGI=;
	b=exzJVXcW/0amqEmqVzNoLzgo0+kjJpNRnk7Mx+h4rUfhR+szGd4XNDjL3kULmKTNJRf8QW
	AJZuvuEMelLyoFh8c8poVSQtiI4u/aXXaw5RmgUeXX96uASpzfOxRG4bJnbdpLRw+V09qo
	AbDw68OXaaDDaeFq/qQGL8veMZ6XYWI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-zrXkJmGlMBSrTAX00TRVpA-1; Mon,
 16 Jun 2025 16:15:43 -0400
X-MC-Unique: zrXkJmGlMBSrTAX00TRVpA-1
X-Mimecast-MFC-AGG-ID: zrXkJmGlMBSrTAX00TRVpA_1750104940
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 840F118089B6;
	Mon, 16 Jun 2025 20:15:40 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CF2130001B1;
	Mon, 16 Jun 2025 20:15:33 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v11 12/14] dpll: zl3073x: Implement input pin state setting in automatic mode
Date: Mon, 16 Jun 2025 22:14:02 +0200
Message-ID: <20250616201404.1412341-13-ivecera@redhat.com>
In-Reply-To: <20250616201404.1412341-1-ivecera@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Implement input pin state setting when the DPLL is running in automatic
mode. Unlike manual mode, the DPLL mode switching is not used here and
the implementation uses special priority value (15) to make the given
pin non-selectable.

When the user sets state of the pin as disconnected the driver
internally sets its priority in HW to 15 that prevents the DPLL to
choose this input pin. Conversely, if the pin status is set to
selectable, the driver sets the pin priority in HW to the original saved
value.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index e67ef37479910..f78a5b209fce7 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -439,6 +439,38 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 
 		rc = zl3073x_dpll_selected_ref_set(zldpll, new_ref);
 		break;
+
+	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
+		if (state == DPLL_PIN_STATE_SELECTABLE) {
+			if (pin->selectable)
+				return 0; /* Pin is already selectable */
+
+			/* Restore pin priority in HW */
+			rc = zl3073x_dpll_ref_prio_set(pin, pin->prio);
+			if (rc)
+				return rc;
+
+			/* Mark pin as selectable */
+			pin->selectable = true;
+		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
+			if (!pin->selectable)
+				return 0; /* Pin is already disconnected */
+
+			/* Set pin priority to none in HW */
+			rc = zl3073x_dpll_ref_prio_set(pin,
+						       ZL_DPLL_REF_PRIO_NONE);
+			if (rc)
+				return rc;
+
+			/* Mark pin as non-selectable */
+			pin->selectable = false;
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Invalid pin state for automatic mode");
+			return -EINVAL;
+		}
+		break;
+
 	default:
 		/* In other modes we cannot change input reference */
 		NL_SET_ERR_MSG(extack,
-- 
2.49.0


