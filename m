Return-Path: <netdev+bounces-290093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ7QN+gTDmot6AUAu9opvQ
	(envelope-from <netdev+bounces-290093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:04:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29259919F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A18230022EF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A63636166A;
	Wed, 20 May 2026 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu9jzpTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F923559E1
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307425; cv=none; b=u9igQMPes7E3bepu1Qe04nsOJw/c/rO50gLRWqm//+YXbyYScUb7lgCSO5n/kkenMW9gh5h7umH6rgVyHVMDBdCxyeUIHyuBY894tmfDtPBnOqqXOI8byqLkdURdc+cY7pgKBrmjigeSb1qqdD+fQM8v/H4ziAHVGcI1tFCI+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307425; c=relaxed/simple;
	bh=Xvv5fQ5F5xIWtEaWElIAcf+23Bvf0pXPnm8EdudGugA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dswh8/UwH2ucfHFjCgNvcx9WMpqiFp9WgjzJqLQr4LSTKB0OMuU2fhdjeMYImk3s7BjSBy9iG3he+MFsb1oWmVerCSlv+s+bWNyR/n56Zq5KD33lRNAuIqP+NXHqyb8AJJialVUbSZxDWJDoV10jCQ7P0IrAawJLhp8TidYbASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu9jzpTC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5c5033f6so46583571cf.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307423; x=1779912223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pPtDRaFJhpJpi9KrC1PwJKKtOYZtFzoBHFHqlj56RU=;
        b=Tu9jzpTCpVUUoJ2IHa+AOCrOEK2khueqdyh8456OVxgl9CnlLHpAVWtg7SQmuv8yAY
         brFTb5lHB/7KRCQ9hZVHlCNnhHnIa18EqghllofejEoi9MKiOkjQ6X/S8rJ6YRTbhW4l
         Mm2eOUqgMrXDrrL2r/quvFaux6JCmxxHUUob97km6GDbNT+d12cLCRNXZy3FZDRjB6aM
         xzBOzH4jp4gGRKDOnMm+zGDEbzfNGrrKO23i0nWPePaAt0eYHaRVlQcQHKdHjN36o2nh
         s9LFDdpAFssZ8X9wPwBpIUlgzq/DT6jfIJglWLm7xgAXwAdQRTy7wHxmq1eeZtFfnxi0
         9NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307423; x=1779912223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pPtDRaFJhpJpi9KrC1PwJKKtOYZtFzoBHFHqlj56RU=;
        b=ckrBIhZkFh429dR0B4oEVrQQ1dfB5mAfQQGsGEgzNGhWqKE3DwaGivMu7R2RyuDson
         k8U2kA38mKsYPDYn263WAjgdFlPptAzMUCm54jGPgVoHxwXY3K9OCaLquoXycjem8DMC
         +LVbt6nQDFhOTI0MtEKICK7+VcR60E0uIJ4fWrdFJvYFFlxYuX/Wc1jWHE9g4cL9EnEf
         GvQJT+ZSE7Bt8RM1KLB62O8mf3X8IhWA6nDJzongiLQsZBscR+uP6sMGlP7iKiwSxi9Z
         5ggIt+2GKqMlvwR318NNj1fnjnHh7dTfK416d/GvfQmriIcZhESKtGZdGVbeWlhk+Eu8
         7F/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8f1VQV9nhvN7lPOvMAufFXqbUCZSGOP3SVNn3mO1hwF9+/ZKGRZ2MptGpePwxeQtCAtgxIpPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgK65zrg40DGg1M+aqNzDgqODus+KREbM5lGXlOxY21UGsPYm
	9/TetwJkV5moRVpWQY1Y5EQhKEjQgiLQ0mHihYAaEdxcN3A6ehYw2IhE
X-Gm-Gg: Acq92OFkjqD09baSBmvT6D04L2SUe4hV1llO3ha/E9Py8Q6aH2wvjw1xn1n/b0CNW5v
	1hwcOLYhcYZDCJCDJJ/8dZDRQpy+BrgsRGf14m51PMpGpGKY2ZGx6Q1Ce0w3kiG3eONNQYkyEem
	xDbQ1HRIYfPOynqbUrP/6NKLE9pXIgghYYUlCjDsEmAxILNWOPUxw22AFEys7Ql60l6Zfo1xTc1
	/ofZIpiTe0cchIXjfu79C9id5Q3yApdG09etCr89wwD4z4g+AA+Xi7BoasIybkdRwQ7LSfpesk8
	HdG63kZXHqE2O7Ksz4x3AkI/cg3ifzvwTSqCu/RF6U0tbao0B12Xx6yaeUx+zH/2mxE+QccrxTD
	RC6PTxCBJTarvj6epUlRiw3HBOr6Ft/oaGHQyE9LAyssMk7AblaFbcBlCxo22d3GPqTuDg21WoV
	s/G56ATdGX9cGlOmqXGNGT/z9BKsMeVjQc4dGqWC039n59LopnEOjwa5tE
X-Received: by 2002:a05:622a:d1:b0:509:1b76:e9b2 with SMTP id d75a77b69052e-5165a276812mr354941421cf.55.1779307423016;
        Wed, 20 May 2026 13:03:43 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm188849301cf.15.2026.05.20.13.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:03:42 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Chengfeng Ye <dg573847474@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] net: eth: fbnic: Store max_speed from firmware dialog
Date: Wed, 20 May 2026 16:03:36 -0400
Message-ID: <20260520200337.204431-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520200337.204431-1-mike.marciniszyn@gmail.com>
References: <20260520200337.204431-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,makrotopia.org,gmail.com,intel.com,trager.us,oracle.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-290093-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF29259919F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The OCP spec required LED signalling to signal the difference
between both below and at max speed capability.

The firmware init dialog already contains that attribute
so store it to support follow-on patches.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 0c6812fcf185..59015769ca28 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -561,6 +561,7 @@ static const struct fbnic_tlv_index fbnic_fw_cap_resp_index[] = {
 	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT),
 	FBNIC_TLV_ATTR_STRING(FBNIC_FW_CAP_RESP_VERSION_COMMIT_STR,
 			      FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE),
+	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_FW_MAX_LINK_SPEED),
 	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_BMC_ALL_MULTI),
 	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_FW_LINK_SPEED),
 	FBNIC_TLV_ATTR_U32(FBNIC_FW_CAP_RESP_FW_LINK_FEC),
@@ -667,6 +668,8 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 
 	fbd->fw_cap.active_slot =
 		fta_get_uint(results, FBNIC_FW_CAP_RESP_ACTIVE_FW_SLOT);
+	fbd->fw_cap.max_link_speed =
+		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_MAX_LINK_SPEED);
 	fbd->fw_cap.link_speed =
 		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_SPEED);
 	fbd->fw_cap.link_fec =
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index d84723e4cfa3..55c2ebc223d0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -58,6 +58,7 @@ struct fbnic_fw_cap {
 	u8	need_bmc_macda_sync	: 1;
 	u8	all_multi		: 1;
 	u8	link_speed;
+	u8	max_link_speed;
 	u8	link_fec;
 	u32	anti_rollback_version;
 };
@@ -241,6 +242,8 @@ enum {
 	FBNIC_FW_CAP_RESP_STORED_CMRT_COMMIT_STR	= 0x10,
 	FBNIC_FW_CAP_RESP_UEFI_VERSION			= 0x11,
 	FBNIC_FW_CAP_RESP_UEFI_COMMIT_STR		= 0x12,
+	FBNIC_FW_CAP_RESP_FW_MAX_LINK_SPEED		= 0x13,
+	/* 0x14 reserved */
 	FBNIC_FW_CAP_RESP_ANTI_ROLLBACK_VERSION		= 0x15,
 	FBNIC_FW_CAP_RESP_MSG_MAX
 };
-- 
2.43.0


