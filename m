Return-Path: <netdev+bounces-251603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ObtBL7mb2lhUQAAu9opvQ
	(envelope-from <netdev+bounces-251603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:34:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7AE4B5CF
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE4558CA0E0
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39043C05F;
	Tue, 20 Jan 2026 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OLVS4qq/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64433D503
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937031; cv=none; b=dg5d6kyE5OdX3mFENEkyi2BDqnQnMWtgvoUOOCR9fYYAdIFoOxb5L2V0iH/qdB1ma0i2nYtmiltnt8c0gc6tztO72/Isa0835V0+YSLEjus86wupXvfyA6Z384+9ZE1HCM65/D/0Nzbg0MezR9oEn043H+yrfktQh0nLMoE4DpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937031; c=relaxed/simple;
	bh=JzAyKfDTx0BFtgiqvO/69rmHbEbm7auKLjdFUiyja/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sz7Uqxo3dwxur6/7ICfTPb5YsX7uepDkNdWxx1M6YbY6El+nESDS+5vrfCu+beT/toWiFNnl+GEbMlXpdxa+ELmZG0qc+y46HFm0rx/GoZhDxGBuVXo3GwhBwTkwd3Yh0AqrkZfDsYnHx/r8If2mIfD85Utzx/29ND0fIUbWfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OLVS4qq/; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a0ac29fca1so37268675ad.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768937028; x=1769541828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBH9IYUNT7nCPgNVRXgCvNMQD0qR0SzPf414KhLR8TU=;
        b=Luo+vgCHSq7C5OGwNaNLNUx5qeCDP5wqoByTsGM0+NhlzUcfdXVtJsS74tSahT5HUC
         Uz+7lwCQLEvrgWtN24YpSlDR8vNWJC5XY4u5kf5sMxg0HVS2NCp0+2/6bjueqxJsGMex
         nkB0lxzZ2eM9szl15O6bS5wn/Ipv7FdQBE4lK8jqlhEpgZYZWQobnjKS3lvvPEFx+GLS
         yz8nKObk7yY9JhHzBu2Hv9w0Rmm8II6n8UuSLmIS1rf5E4V5tk0Drj8qADFBOQqp7mpz
         eQmcIwdkaRbetFG+Z8vSNTWmcpL0o6ca7fAi+7+zPnMm7i5o5t+G6PX8+IzP7RXG5/HQ
         WCaA==
X-Gm-Message-State: AOJu0YwPRdy/mcEg75X2nq4YbdQ6RHC0lvQtabQfe8j60Xl+YZShlDqM
	V5CdwO9W/UxVY1hy7d5fL1ieTSEFFY0td2ch0sYwUvUvv6h5k8otj7keIJehBQrt2NGexFwmstF
	deKGQWjRoXILPiUrWkWtJDUzU2pkRo6eDawbK8zI2qhSP0PllPlHJ05veCfDhuCVzWm3ml76fI6
	5pUZC72p1Nj7T1SWSWKlqHAJ/3aDnfYAjoAuLOI0aXCFesxhGdNhowTHzYevrVQJbK3lQDgiDJK
	5glmlH+4Q==
X-Gm-Gg: AZuq6aJJ46D0w1U9T+9Pt3L4jFwp3p8Q05v8V6zzU7wWLb64xqMedYKxphOFQggOW0L
	Lo7Fes0U6jba9bNNd4qHjM6BKtsb9VYk6hqx8pNLen/tHK/PtN4uIlcEOqsDxPgVUVOzIA8+Xlm
	6BLhvOxGyfxslFpeL3Zdzgn/+/5hYbmp54hg6vTk2z/n/CWeIinWzyK/IuY/uCkehCsS8BPo8Ki
	mR8Sch8+os2GgyML5lF/5AM5i/75hew0l3a5wc4gHtNB8TtoM8qlSpKIFSdKJGx6SDvZNw6NSIq
	525w51DEOjrTZAXdTItLWTRQ+9s/Tnzd3wbx5d+DlOXzqNtOtFthxQSyQPWEvFuCB6QCZbPzpOh
	F7SS5I8NMJe+tmXaKRCGlLyIeRdzmazwYsl+lcgcUuhwQfJaugFH4tU1r4kSd7aD+dt6h8Z+Zoh
	DTWF6F9Egqv1IzeyM991xzXavQnOQ85Rc8BE2efz38Dc0=
X-Received: by 2002:a17:903:240b:b0:2a2:bff6:42ef with SMTP id d9443c01a7336-2a768b7a530mr24651625ad.7.1768937027948;
        Tue, 20 Jan 2026 11:23:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7193ac282sm20402115ad.58.2026.01.20.11.23.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 11:23:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-122008d48e5so10387000c88.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768937026; x=1769541826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBH9IYUNT7nCPgNVRXgCvNMQD0qR0SzPf414KhLR8TU=;
        b=OLVS4qq/rNOTFZ1B7MbP7M7ga4a2CIa4nr1d+dQAV+F2V3epT/fnOXZF7/R5UBZJhv
         apRvxHN2YBMRahhkfniGcc7L3C0Q1r32j+3W8ElkgOGHAlO/DX7l6WJlWAOYrPchKwIs
         oRFvi/Uv8bMZYP7sjJUKBOCme+ykbnHw8bUDQ=
X-Received: by 2002:a05:7022:128c:b0:11b:a36d:a7f7 with SMTP id a92af1059eb24-1246a966c02mr2000742c88.16.1768937025824;
        Tue, 20 Jan 2026 11:23:45 -0800 (PST)
X-Received: by 2002:a05:7022:128c:b0:11b:a36d:a7f7 with SMTP id a92af1059eb24-1246a966c02mr2000711c88.16.1768937025047;
        Tue, 20 Jan 2026 11:23:45 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10e21sm22207223c88.16.2026.01.20.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:23:44 -0800 (PST)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH] net: bcmasp: Fix network filter wake for asp-3.0
Date: Tue, 20 Jan 2026 11:23:39 -0800
Message-Id: <20260120192339.2031648-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-251603-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CD7AE4B5CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We need to apply the tx_chan_offset to the netfilter cfg channel or the
output channel will be incorrect for asp-3.0 and newer.

Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 5 +++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index fd35f4b4dc50..014340f33345 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -156,7 +156,7 @@ static void bcmasp_netfilt_hw_en_wake(struct bcmasp_priv *priv,
 			  ASP_RX_FILTER_NET_OFFSET_L4(32),
 			  ASP_RX_FILTER_NET_OFFSET(nfilt->hw_index + 1));
 
-	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->port + 8) |
+	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->ch) |
 			  ASP_RX_FILTER_NET_CFG_EN |
 			  ASP_RX_FILTER_NET_CFG_L2_EN |
 			  ASP_RX_FILTER_NET_CFG_L3_EN |
@@ -166,7 +166,7 @@ static void bcmasp_netfilt_hw_en_wake(struct bcmasp_priv *priv,
 			  ASP_RX_FILTER_NET_CFG_UMC(nfilt->port),
 			  ASP_RX_FILTER_NET_CFG(nfilt->hw_index));
 
-	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->port + 8) |
+	rx_filter_core_wl(priv, ASP_RX_FILTER_NET_CFG_CH(nfilt->ch) |
 			  ASP_RX_FILTER_NET_CFG_EN |
 			  ASP_RX_FILTER_NET_CFG_L2_EN |
 			  ASP_RX_FILTER_NET_CFG_L3_EN |
@@ -714,6 +714,7 @@ struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
 		nfilter = &priv->net_filters[open_index];
 		nfilter->claimed = true;
 		nfilter->port = intf->port;
+		nfilter->ch = intf->channel + priv->tx_chan_offset;
 		nfilter->hw_index = open_index;
 	}
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 74adfdb50e11..e238507be40a 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -348,6 +348,7 @@ struct bcmasp_net_filter {
 	bool				wake_filter;
 
 	int				port;
+	int				ch;
 	unsigned int			hw_index;
 };
 
-- 
2.34.1


