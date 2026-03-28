Return-Path: <netdev+bounces-272748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCF7NXeMx2m+YwUAu9opvQ
	(envelope-from <netdev+bounces-272748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:08:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2A134DC16
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 484733055C4F
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1935F5E7;
	Sat, 28 Mar 2026 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSshJ/I8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6601F16B
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774685207; cv=none; b=Tf305dcU9iKhFL3KXZkbEHgzvxplrTT5hw6sIl/sapwvCZFgaiYm6r4zoJp1KTZy4Hgc3biL6iFWCTlpAaPbh5/ABc4v4XmbnfE7hTqnBWAHnuGjVYEXtV3y0GU88eneyz9y20EKUOyfiobk6vJbCpl+J7id3AO9uCOCtZaHS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774685207; c=relaxed/simple;
	bh=E74W6nH3ZrQ4E00ZeLeqf9l5vDDcBRk2GgTkGYDcsnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpiR4eHsmW37rXoNWtkbkmzi77D708J0RRpdT/hN18qCKijScCRa4FWB58k0+KXSvMfMWuY+IB4ONCVRxn0jHB1MaYl9w69P8tnFf590pn0uKVsPOBYGm5RtXiEOey2HPaqXX6SASWP2ByTn7jzK/e+IpbMKyb8HCYFNvscESms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSshJ/I8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774685204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECRkEV0y7jPQuSatK5DISHS6RDYSFDFgyIg4X2z/Hz8=;
	b=OSshJ/I8PfMjni3rdlPVLJsV2VJt1yrErh9HNYsufnyFFTOeoOTl5+xlPEnKRoG+ldAyis
	T4iprPXYlIgghGcMMUiF+6oZF+3qAbm7C84mgBAHCiFlAgcJ0+lwRILAKZ2FP2RmjgXq9U
	yf8NEgfSm9GuIeSK8ykZVHNKZ1SdJ38=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-W9HIqAKUOuu50OmldXWPQQ-1; Sat,
 28 Mar 2026 04:06:41 -0400
X-MC-Unique: W9HIqAKUOuu50OmldXWPQQ-1
X-Mimecast-MFC-AGG-ID: W9HIqAKUOuu50OmldXWPQQ_1774685199
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D696195608B;
	Sat, 28 Mar 2026 08:06:39 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F5411800351;
	Sat, 28 Mar 2026 08:06:35 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next v2 2/5] dpll: zl3073x: use FIELD_MODIFY() for clear-and-set patterns
Date: Sat, 28 Mar 2026 09:06:21 +0100
Message-ID: <20260328080624.593916-3-ivecera@redhat.com>
In-Reply-To: <20260328080624.593916-1-ivecera@redhat.com>
References: <20260328080624.593916-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272748-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E2A134DC16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace open-coded clear-and-set bitfield operations with
FIELD_MODIFY().

Reviewed-by: Petr Oros <poros@redhat.com>
Reviewed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.h  | 17 ++++++-----------
 drivers/dpll/zl3073x/core.c  |  3 +--
 drivers/dpll/zl3073x/flash.c |  3 +--
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
index e0f02d3432086..481da2133202b 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -66,8 +66,7 @@ static inline u8 zl3073x_chan_ref_get(const struct zl3073x_chan *chan)
  */
 static inline void zl3073x_chan_mode_set(struct zl3073x_chan *chan, u8 mode)
 {
-	chan->mode_refsel &= ~ZL_DPLL_MODE_REFSEL_MODE;
-	chan->mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, mode);
+	FIELD_MODIFY(ZL_DPLL_MODE_REFSEL_MODE, &chan->mode_refsel, mode);
 }
 
 /**
@@ -77,8 +76,7 @@ static inline void zl3073x_chan_mode_set(struct zl3073x_chan *chan, u8 mode)
  */
 static inline void zl3073x_chan_ref_set(struct zl3073x_chan *chan, u8 ref)
 {
-	chan->mode_refsel &= ~ZL_DPLL_MODE_REFSEL_REF;
-	chan->mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
+	FIELD_MODIFY(ZL_DPLL_MODE_REFSEL_REF, &chan->mode_refsel, ref);
 }
 
 /**
@@ -110,13 +108,10 @@ zl3073x_chan_ref_prio_set(struct zl3073x_chan *chan, u8 ref, u8 prio)
 {
 	u8 *val = &chan->ref_prio[ref / 2];
 
-	if (!(ref & 1)) {
-		*val &= ~ZL_DPLL_REF_PRIO_REF_P;
-		*val |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_P, prio);
-	} else {
-		*val &= ~ZL_DPLL_REF_PRIO_REF_N;
-		*val |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_N, prio);
-	}
+	if (!(ref & 1))
+		FIELD_MODIFY(ZL_DPLL_REF_PRIO_REF_P, val, prio);
+	else
+		FIELD_MODIFY(ZL_DPLL_REF_PRIO_REF_N, val, prio);
 }
 
 /**
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 6363002d48d46..7eebfc1ad1019 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -743,8 +743,7 @@ int zl3073x_dev_phase_avg_factor_set(struct zl3073x_dev *zldev, u8 factor)
 	value = (factor + 1) & 0x0f;
 
 	/* Update phase measurement control register */
-	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
-	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, value);
+	FIELD_MODIFY(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, &dpll_meas_ctrl, value);
 	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
 	if (rc)
 		return rc;
diff --git a/drivers/dpll/zl3073x/flash.c b/drivers/dpll/zl3073x/flash.c
index 83452a77e3e98..f85535c8ad246 100644
--- a/drivers/dpll/zl3073x/flash.c
+++ b/drivers/dpll/zl3073x/flash.c
@@ -194,8 +194,7 @@ zl3073x_flash_cmd_wait(struct zl3073x_dev *zldev, u32 operation,
 	if (rc)
 		return rc;
 
-	value &= ~ZL_WRITE_FLASH_OP;
-	value |= FIELD_PREP(ZL_WRITE_FLASH_OP, operation);
+	FIELD_MODIFY(ZL_WRITE_FLASH_OP, &value, operation);
 
 	rc = zl3073x_write_u8(zldev, ZL_REG_WRITE_FLASH, value);
 	if (rc)
-- 
2.52.0


