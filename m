Return-Path: <netdev+bounces-300879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wELpJrHfN2r2UwcAu9opvQ
	(envelope-from <netdev+bounces-300879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 14:57:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F026AAC88
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 14:57:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ef16EvOb;
	dkim=pass header.d=redhat.com header.s=google header.b=tmu596aB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300879-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300879-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36D2B300CE7C
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE333655C2;
	Sun, 21 Jun 2026 12:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A3D8C1F
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 12:57:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046622; cv=none; b=CPuBRi1jGN1TAzLmtqovPddi6cbrIiVsTfM/Hw2c2kU7cNVyQuIxtldqM0K55vDkXLkzSbtPf/uyt0KPtwJeQ7b5kxEi0FEBl044M6Lcwae6NdsKjASDo5GaAMeW3Zv5D4+4jHUN4oPUzvKo7+9rG2rLpc8yTjNejWqSUnxFv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046622; c=relaxed/simple;
	bh=6tsdNqYfR2mQnCMoVuwXT9io3x8jWvThGYkClVjMlbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFoFm7RNFTbgBvSuAZ3qoYrY0A0jLOzMyjatDFiw9GrfCPetYOigWD30BC3DvDibJY3fkgecYtUsDPYVaXhacABbEFCL1wWgxTBCAH0l1+Yt1AGaYhdaZDaOlIVB2PUtiMYIb1yzzJUMMBagtJMBraYFzgGRsDK1+YuFI6nn0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ef16EvOb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tmu596aB; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782046619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4f6w2MoA+XP+TjGC5G5VS3oEg0ZAwkShPaC9GG0r1lM=;
	b=Ef16EvOb2TP9ynCUC3ktgLycqEa9lnbFl3AJkPBtN2ECa2jyOa6QgwiHasTQWSytbIGn0R
	F1MX7RBjabPzDlCu5DIyZSZSQNhUb7XPjyiEirKo1PadEx4zpYVcvt0wx2ZGFxPkAoJ/g0
	DvaF8/+eP/JEBaWmTnubspoy8R28vcY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-ep38fJg5OG257jeSWYSfXg-1; Sun, 21 Jun 2026 08:56:57 -0400
X-MC-Unique: ep38fJg5OG257jeSWYSfXg-1
X-Mimecast-MFC-AGG-ID: ep38fJg5OG257jeSWYSfXg_1782046617
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46250b59ed5so2530387f8f.2
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 05:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782046616; x=1782651416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f6w2MoA+XP+TjGC5G5VS3oEg0ZAwkShPaC9GG0r1lM=;
        b=tmu596aBkpXKC4XyYxdniooDG26Vo7dhKn4APzQkhRWpPahZldqVEK3841Wvi0fCWT
         zlLztLHQeQ2QkMVMxN0MCyJwRYEG9kp23WK3GyRRi74PlaBXldSYT7LgV9AfY4rn3ojr
         eIZszp7YN8QZxcVs7J3qqNtU12NQtWLbhGLhJvQKQ5QhWGXItNWD/drfsqu9W//MFJ97
         wfJPHJe7b7wli9BqL9YePbEFsxNiwl4evRzKIg7wruTk8Z4iXuCO/YXibR274DrrzGZI
         mfcQIZ+HY7bQCMc/fm8eEcJqH0uButqlhjyUM0FUq+BwYD1H9vS628pSUSQfzWDn7bxi
         KSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782046616; x=1782651416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4f6w2MoA+XP+TjGC5G5VS3oEg0ZAwkShPaC9GG0r1lM=;
        b=Wb7Hd+ca2VbEoRu2H+cbjTMIA9/FdUqnAZ4DYZP0NaVuIZlOF+55St0j2sIccrlEcf
         jtcVBHDqazY0TDmMbTzw/M3JGYUMUdAhm0JFJTit1ZVVqU1qGKNqLRhrOs7btRaRg9IF
         Ljga1SFvUkLpNAWlacoTMUNVz2DMXkQBSlkPkh9HZpPMIBNCyGAvXY3fXIn0t5LCosbh
         wHTk9yk8iVoSrZ+bIvMI+IlJiThH4o/K7Nh8aBA74ajDGOl6JDEmWqfihUtXj0IiNtX/
         WqMLileNpllrpfyiszUF/hyC8R3yXzAHJdUN5rt4BO5IKtUHNwmtruF5EZHrgQlHxT9Y
         vBgg==
X-Gm-Message-State: AOJu0Yz8NppEoUzip63ViAjb4auk6FcckVzYmwvCdJAmTI2sLYoJjJvE
	LqgbgRlfRitGv/KltxL2HcIei2UtTXOq9UzFXRjzg4ryd+kUYpkwpUFmzPCVUrde6velVBjK0/D
	P0QPRZ5+gwFVS+B15M2YDiZWFEGZLYElQRGyDJuwqGfcN0wd9LlLBR1fFHg==
X-Gm-Gg: AfdE7ckSsKTbnQeZAGPCM4aCUPBQLN1UcbBJyJZfgTvC0Vtq7ZeQXGlj1hOnoEV0A4r
	MOvTaY7DpDDpSq0pKHfGmh51Lk3h0E+ovumD9Heeqar/uaYVttKt/OKMJWDzpTcFWM8U3/0+cij
	7BouMKZe50Z/VE81FbO8yK79j4AI62SK89LnH848gNoPw8WFY+BQusY5i7RFOdkwqjjN2a1/8fq
	rtzIJOf5/Q9kTddSqmSGev3qZqgxbNMTtSSoSF3+cLD7K9rV2PwYD9Ir8m+Rk5XQ9cjf4k1ts8B
	Ln42KRQmJhQW0HZ0Y4cltCZOAgR+odkLW5A5BxGt7oisC55biBIE0B2/cp2WmSx5AaAj+XCbINz
	bj1hHOpqhNqOPegEhc1qmhYE=
X-Received: by 2002:a5d:4e12:0:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-46509e548b3mr15099611f8f.36.1782046616525;
        Sun, 21 Jun 2026 05:56:56 -0700 (PDT)
X-Received: by 2002:a5d:4e12:0:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-46509e548b3mr15099591f8f.36.1782046616160;
        Sun, 21 Jun 2026 05:56:56 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c4f01sm17884258f8f.9.2026.06.21.05.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 05:56:55 -0700 (PDT)
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
Subject: [PATCH 2/2 net-next,v2] i40e: add devlink parameter for Flow Director ATR sample rate
Date: Sun, 21 Jun 2026 15:56:44 +0300
Message-ID: <20260621125644.253844-2-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621125644.253844-1-mheib@redhat.com>
References: <20260621125644.253844-1-mheib@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300879-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9F026AAC88

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
 Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index 51c887f0dc83..2cea98b631ba 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -40,6 +40,26 @@ Parameters
 
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
+        Setting to ``0`` disables ATR sampling (no filters will be programmed)
+        The default value is ``20``.
 
 Info versions
 =============
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 229179ccc131..cf487efdd803 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -33,12 +33,48 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
 	return 0;
 }
 
+static int i40e_atr_sample_rate_set(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+	u32 sample_rate = ctx->val.vu32;
+
+	pf->atr_sample_rate = sample_rate;
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
+			     NULL),
 };
 
 static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
-- 
2.53.0


