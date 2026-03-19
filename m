Return-Path: <netdev+bounces-269587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEQHMiU3vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:49:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CA62D047E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B88F33001FDA
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AF038BF9B;
	Thu, 19 Mar 2026 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6U5yHFq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF930EF84
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942532; cv=none; b=aOmg9yQwbTsCn3hII1vogE0WGwXWxzJKZ6r6h76O4vAe3o2jCluAHg4+hxncvi9GW012T2dnS6ONPujl+5ydpjbz8Jzei9IR2Gxgp8frLNkH6xqPIYNydDrb8Sid84iF1xORJ0iL0eQGvWPxBT7oOE4KtNZIDumqoijZ/700OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942532; c=relaxed/simple;
	bh=4PSsgcFvwZYUAVpXo/xDvpo1BAdU35PCxtAzbJFtdyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRlojix9mO3dE8gzcv5oIl8voBk6k0IMDKgoWWH2+56IrWS6cNj/ZP3fRlBCQNdCV+l1xue/rDa1mjjxZKN/Gl+HmXQ7/t+Yh6yoWHPNORZHPZCxkNZxVew4Izy2fVoc1yYjTatxj3SzDMRyQj8anEaW8yXfY0J5ApgqyPgF3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6U5yHFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773942527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOXBaFOXc2ApWDENFqu1LAGlP5XKnLrcLRkq+P5lPRc=;
	b=P6U5yHFq4bVBXRkcdsvGtXIXUplg5zCZ67V6yLLEIFA5Cuyr6arlefwBqGU4wjpPzg167J
	j8/mROn3ZkJw4BprkHF6K+l+GcDrNCBw9QgT2/ByzLM/X/Csrk4GbRhZIFP7VaIJH3lRtr
	ZKGU1mZFNSj1uEdcz0QpGA/0t1MDyGk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-uR9GqzxlOnCrEZ0Uy6vpcg-1; Thu,
 19 Mar 2026 13:48:43 -0400
X-MC-Unique: uR9GqzxlOnCrEZ0Uy6vpcg-1
X-Mimecast-MFC-AGG-ID: uR9GqzxlOnCrEZ0Uy6vpcg_1773942521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10A951800611;
	Thu, 19 Mar 2026 17:48:41 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED77130001A1;
	Thu, 19 Mar 2026 17:48:36 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next 2/5] dpll: zl3073x: use FIELD_MODIFY() for clear-and-set patterns
Date: Thu, 19 Mar 2026 18:48:23 +0100
Message-ID: <20260319174826.7623-3-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-1-ivecera@redhat.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269587-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.900];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68CA62D047E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace open-coded clear-and-set bitfield operations with
FIELD_MODIFY().

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


