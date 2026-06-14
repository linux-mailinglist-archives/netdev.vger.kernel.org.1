Return-Path: <netdev+bounces-299235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J7BfCcTSLmo43wQAu9opvQ
	(envelope-from <netdev+bounces-299235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 18:11:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4F6817C4
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 18:11:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QSCcWuBF;
	dkim=pass header.d=redhat.com header.s=google header.b="hc/1kF5c";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299235-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299235-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF5203002307
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C82848A7;
	Sun, 14 Jun 2026 16:11:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2270830
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 16:11:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781453505; cv=none; b=WrRp5UnGYiuk7rEnohUyT6jiynKy6jkStSHcBz5p1orblhDuwBN/Xkt2v11BOFkIj9dQJfVspXneZL577Lfrp9efMHUS+jR6WgxwlqlS8SKZ8HLPyibo0XRSgF74E1pzE6eaulf5TDMrNMteJJOgryAPPdtgqFJxxN6jtGb65jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781453505; c=relaxed/simple;
	bh=7lnHDMOyFIMBRKoBtIkEfhEiKa9AwRRO5mCQD6nUUWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMHMbEXm176lp32GTdcKgWy0weOekOfxeXC6TlNJZjDajcue+JjQ2xnX9HJFKSy4ZlM//rzgxwgNfh4X2hF5Xv+2JzeOD+y9B12t0BRPF3b0NRmIYH0ia/ascKjXvHcyRC5vrtl4LC/01Hfx0jm7E9Hj7bvUtpn/e/G4WCnbrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSCcWuBF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hc/1kF5c; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781453502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QPrD7vsVlbzeiOG2gzgEPheKRSPg/FcdoyT9Knl/jB4=;
	b=QSCcWuBF0P6TrNypTIpZD3tFXu2pEFoxW9DRQfDIpzYybEDCvtGd/WifRG7FIYL65jUgc0
	MMsO71raOw81oroyGOjE0z6wFO4LhFADXGQoR0pNZAUMhAqhwV1/bVTZduHvrMLfGRRqkZ
	zPRb7UOL2kOveTFJofZWVsVBXCLMo+4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-f9oCVDbsOsa_PBy2iznHkw-1; Sun, 14 Jun 2026 12:11:41 -0400
X-MC-Unique: f9oCVDbsOsa_PBy2iznHkw-1
X-Mimecast-MFC-AGG-ID: f9oCVDbsOsa_PBy2iznHkw_1781453500
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef93c359fso2181536f8f.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781453500; x=1782058300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPrD7vsVlbzeiOG2gzgEPheKRSPg/FcdoyT9Knl/jB4=;
        b=hc/1kF5cqi9FaOeO3Sgxvv2cZpjDhnpAS6pMo/AMhIQjn/wrQoQMPUrVo6vMli8xMG
         YBC87zn6cEXI+vG9TtH2NHUKSy3Pf0pM1dlVl07fGiY+R4qnuN11cjCrB5R3OJwx7LvH
         pjRxe2uv5YPyZYicf5cpDW48jxmAQoet6YqlyQgk6g0okZV2kkIPM+rMSvzUTONtzZ04
         ychD6fK0bHgIQIvErM/EqD8CgNMmR8vpFWuvQTdipUBosNyWF0h9PuxWQRuoMjtSz2t6
         dHxac810KQavEvk90c8ctU1aOAMAbSct9PELxKf2r4Mvh0uRDhLlyg8aFvT9CHq0ZU2q
         Kieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781453500; x=1782058300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPrD7vsVlbzeiOG2gzgEPheKRSPg/FcdoyT9Knl/jB4=;
        b=RCW7vPRLVDaV30nqJoa/IOTa0GGQArBT37N2ouBt7uvFziYdmjUDu2gTvBQScAXq8v
         NEVMKy9+1xN1YX+/KEvs8LlOouUOiStk9lIK6eDPMBRH5dgLl8vlhI3IsR83zEAIuJeH
         GITrUqh2EadUpMeQ9vpLrQFa610T8Xtze7l5SN/WLpGjgTwef+gHIoQ5foosRRPDCv3y
         AluSb3ozucs8PA2z1JvXhX7QZZQaevwm+Q7cm0zXPpWgdcn9rqXVXbFXRDpag9jwP7C5
         h/PKYkLm/trcJeU5Fg1rLRMzEjLcHYXVi6/8st4DVwf3/+gshMIWgptnTPOK1XERWZYf
         12jg==
X-Gm-Message-State: AOJu0YwiUSYyEO3jR/L87nSGQxq9WquSvKc/KDXwsPwBnHmB1oVDeHev
	wZNjEVFtvjBFZ9qlJr+PwBrYIGng0rD06BaPjsSuuDPdabiL7sT24mfDMRho9NX0b+SgsrTvh7+
	VcX3m7CketD1PtxXF9OgDpWbbcLqwzXryaX3VkNAAgOhBjFfKZju/iIyQIQ==
X-Gm-Gg: Acq92OEg1N00z87dLMMx+lcRJjoE6f88rHmD63ZMdJMOPJg9hT4jmmZMu0XpzPLKC5i
	jQrYcTksOph0imKsPELvAJQL0X9yM0MNp3LOxjgn9z+3ZyOWGGkn9mSvECFQG06KZXpDNmCfaaT
	Q4LgUXmdXO4kl2AtbkuvusCsUifxryoUmwIS57JpJs3v0OJk7UOEtjD8gM9uWjCX6cYz1KiQ7ur
	P3XBJ8LjH9vutrpGeI1GJB8r4rGl677pghWKStwC07uKw1MoDgvfc++IGgrkrgmMi7riwTCEVat
	VrmKok4i8M+FQ4AOqMG8T3FApdDV9WstztNN0sVoGt8vwiTCfLLh5c5PZlp82qjdPhp5khHAB/b
	WRwzpnyyAIsmLu1zhtVnRSJuwCA2eqw==
X-Received: by 2002:a05:6000:290e:b0:45e:f381:cd7b with SMTP id ffacd0b85a97d-4606da6985fmr15513347f8f.8.1781453500292;
        Sun, 14 Jun 2026 09:11:40 -0700 (PDT)
X-Received: by 2002:a05:6000:290e:b0:45e:f381:cd7b with SMTP id ffacd0b85a97d-4606da6985fmr15513312f8f.8.1781453499874;
        Sun, 14 Jun 2026 09:11:39 -0700 (PDT)
Received: from fedora.redhat.com ([2a0d:3344:17d1:b608:8e5:8aea:ed86:b36b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d933esm24468783f8f.33.2026.06.14.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 09:11:39 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net-next] i40e: add devlink parameter for Flow Director ATR sample rate
Date: Sun, 14 Jun 2026 19:11:31 +0300
Message-ID: <20260614161131.192068-1-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299235-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mheib@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:mheib@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheib@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8E4F6817C4

From: Mohammad Heib <mheib@redhat.com>

The i40e driver uses Flow Director ATR to periodically update flow
steering information for active TCP flows. The update frequency is
currently controlled by I40E_DEFAULT_ATR_SAMPLE_RATE and is fixed at
driver build time.

On systems with a large number of queues and high-rate TCP workloads,
the default sampling interval can result in frequent Flow Director
reprogramming for long-lived flows.

The amount of TCP packet reordering observed on some systems is
sensitive to the ATR sampling interval. Increasing the interval reduces
Flow Director programming activity and can significantly reduce the
associated reordering.

Since the optimal sampling interval depends on the workload and system
configuration, a single fixed value is not suitable for all deployments.

Add a devlink parameter to allow administrators to tune the ATR sample
rate at runtime without rebuilding the driver or disabling ATR
functionality entirely.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 Documentation/networking/devlink/i40e.rst     | 19 ++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 65 +++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  4 +-
 5 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index 51c887f0dc83..704469aa9acf 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -40,6 +40,25 @@ Parameters
 
         The default value is ``0`` (internal calculation is used).
 
+.. list-table:: Driver specific parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Description
+    * - ``atr_sample_rate``
+      - runtime
+      - Controls how frequently Flow Director ATR updates flow steering
+        information for active TCP flows.
+
+        ATR programs Flow Director entries based on sampled transmitted
+        packets. The sampling interval is specified as the number of
+        transmitted packets between ATR updates.
+
+        Lower values increase Flow Director programming activity, while
+        higher values reduce the update frequency.
+
+        The default value is ``20``.
 
 Info versions
 =============
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1b6a8fbaa648..88eb40ee45f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -487,6 +487,7 @@ struct i40e_pf {
 	u16 rss_size_max;          /* HW defined max RSS queues */
 	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
 	u16 num_alloc_vsi;         /* num VSIs this driver supports */
+	u32 atr_sample_rate;
 	bool wol_en;
 
 	struct hlist_head fdir_filter_list;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 229179ccc131..16e51762db45 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -33,12 +33,77 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
 	return 0;
 }
 
+static int i40e_atr_sample_rate_set(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+	struct i40e_vsi *vsi;
+	u32 sample_rate = ctx->val.vu32;
+	int i;
+
+	pf->atr_sample_rate = sample_rate;
+
+	if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
+		return 0;
+
+	vsi = i40e_pf_get_main_vsi(pf);
+	if (!vsi)
+		return 0;
+
+	for (i = 0; i < vsi->num_queue_pairs; i++) {
+		if (!vsi->tx_rings[i])
+			continue;
+		vsi->tx_rings[i]->atr_sample_rate = sample_rate;
+		vsi->tx_rings[i]->atr_count = 0;
+	}
+
+	return 0;
+}
+
+static int i40e_atr_sample_rate_get(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+
+	ctx->val.vu32 = pf->atr_sample_rate;
+
+	return 0;
+}
+
+static int i40e_atr_sample_rate_validate(struct devlink *devlink, u32 id,
+					 union devlink_param_value val,
+					 struct netlink_ext_ack *extack)
+{
+	if (!val.vu32) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "ATR sample rate must be greater than 0");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+enum i40e_dl_param_id {
+	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
+};
+
 static const struct devlink_param i40e_dl_params[] = {
 	DEVLINK_PARAM_GENERIC(MAX_MAC_PER_VF,
 			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			      i40e_max_mac_per_vf_get,
 			      i40e_max_mac_per_vf_set,
 			      NULL),
+	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
+			     "atr_sample_rate",
+			     DEVLINK_PARAM_TYPE_U32,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     i40e_atr_sample_rate_get,
+			     i40e_atr_sample_rate_set,
+			     i40e_atr_sample_rate_validate),
 };
 
 static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d59750c490f4..9c8144970a34 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3458,7 +3458,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 
 	/* some ATR related tx ring init */
 	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
-		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+		ring->atr_sample_rate = vsi->back->atr_sample_rate;
 		ring->atr_count = 0;
 	} else {
 		ring->atr_sample_rate = 0;
@@ -12745,6 +12745,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		}
 	}
 
+	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index bb741ff3e5f2..7e29e9244c3a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -372,8 +372,8 @@ struct i40e_ring {
 	u16 next_to_clean;
 	u16 xdp_tx_active;
 
-	u8 atr_sample_rate;
-	u8 atr_count;
+	u32 atr_sample_rate;
+	u32 atr_count;
 
 	bool ring_active;		/* is ring online or not */
 	bool arm_wb;		/* do something to arm write back */
-- 
2.53.0


