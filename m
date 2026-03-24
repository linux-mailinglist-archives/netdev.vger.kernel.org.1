Return-Path: <netdev+bounces-271276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLwTFTTwwmkdnQQAu9opvQ
	(envelope-from <netdev+bounces-271276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:12:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB031C2B2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5076530C74C1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3503370F0;
	Tue, 24 Mar 2026 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AgVSJnWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA90332623
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382920; cv=none; b=e5rPBeT/PalRxtnhkulyPF0Vey+7fRxnBrs1oUnSifCrg+yGm+M4OqMZhXYHdk6G+lvXzhpXPXtNFdPzFDAdFwmNCGBi2DFoBF7fHDxONG36fMyPVFQBcAgy8NZ2t2Or7/i++sxjurXqZWmOWvldY+tnGkdO3kjo9J/rZJQpxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382920; c=relaxed/simple;
	bh=wlbhBmmcU5vccLBMkzSDxzOKZsBV8R9a8i1WZeDoby8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0x5ncsMraN91wlCdvVNZVGombfpx3L1evbGTOUJSONRYFIK4KijyNl3FgspQT/lT/BRZysNJcUNI8N+QGPxSQmXFHJfj+TWtg6aubNbcOgrDRK++ybJWQ0hoLE0KSwwj3RIVgn4xjar/GkW7x3AqpOhSztVNMW5hajaYZm20FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AgVSJnWu; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-56cde757d3dso1607976e0c.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382912; x=1774987712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUyZiVTNKsqn9jj8gYUSvfoN+c8WD4aQmQkycQsfN1o=;
        b=frRqTikUmaK039LjSpBdAKDx+Lh9qU8CnoRR/g9apEyJZw8/FXJNBHmPbeb2ihqhpW
         NOfsp4vM7XfD61V7+HZBOiGLRqUMzDczeVU+sGqgfN3iRFx0ybNkUTuyshk0xU7uLJy5
         0dKHaWbPDaL5wQLMz5FZhSPXttch9PJXzDSiFNF9sIithp1wKudVVuWpTm1VbxTcstgF
         78Chl/N7JxxEa4TSxaTrZ1G27JekOlIz8kueUSmQs9RNM++AFQasAHQOKT8PCgdMlRNW
         RXxiCJBOCAF/L2ugmFvQ/7AEbJxRLvRrHw2ysYdkMlD1ws1rUIfYB6OeKM5I1q9iXVNV
         YSbA==
X-Gm-Message-State: AOJu0YxFpcZQYfMqYk8MDIbYP+qTrxdtZ9ZoNGrE7W/PUEj9Gw3dscaz
	JAG5/EJIUlgx/3i6AWtpkARbPDMVtc3l1kZ6pWzZOCi60atY33dSZ2TyBOLkZHObg0lbY/9Nvw3
	cp5A/EEkeh1mtjQSstWhFNbWIRD8tEDxAh1yZHRwEbqMZ8SYLbagdx62TzOLD0+aQV/ntVIhz++
	1TjG8OPYq/szVlCYA2MSnYc9NLRmdxppskDz0rs5L9l8OU8hthUt6eNK79XqvUdh1VYo7z5k8Eh
	prugfeZy2qRvv29FA==
X-Gm-Gg: ATEYQzxVES7TSrkBVodf/ol8ATUldIaf4e7sOO7NwuZvXe+/+IpkkykUAo0EGxzielP
	J6ublJv/5kQk8dgZu958+pZQBIzTIf6syFQ6nTIDgsfZHxRg0DGVVr7nsnndSNdtV8qPd2rPrkO
	a5aEG5brD9mdF+SfHs8Vb+gOAVB6Yn3YpDojlmnTaLIGVVMBTkQwF4iORur4CpA51oKVPpVTx/q
	09Z+fZciV1SbLpl17TmDL/cLLC8uQvEk0ipblJDdU4H9F+TbvLhcqDI0t1K79IRjJV43fCC9NOv
	dzwSo4PGNI0ArBpNP0xgSVG4fJBY5+c95DFkMFCpSJ9vfM6Zm7CLp9BBVBQ7cjxaAEmp7hWp5FS
	eXJycsYIOMdgKcwXB5EtYNjo4TkO5sS5xgHuWeLpmvSqJ1nGmxgIIN2lDlxXzw7DnrMhEs5fGl5
	6n+xULpkQI6tjYhQL4MeNMi74g9rMdADidXnyfMsqCiTzx3jgPzTDHf32EyxRhDvMHFw==
X-Received: by 2002:a05:6122:3788:b0:56b:9ba4:1372 with SMTP id 71dfb90a1353d-56d220694cdmr587809e0c.9.1774382912412;
        Tue, 24 Mar 2026 13:08:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56d1f0623f3sm141471e0c.3.2026.03.24.13.08.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2026 13:08:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35842aa350fso29640561a91.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774382911; x=1774987711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUyZiVTNKsqn9jj8gYUSvfoN+c8WD4aQmQkycQsfN1o=;
        b=AgVSJnWuJefgE748kSGGlNttX9eGuPVhvmw+gDfPU/QCD2Ax4yXTS7FJkwXxqtnm38
         Kpc1AuawNzyZKM+0f80c4zGdrrZ+l9Z6VKTIROahKtB6oLnAJ+ryzYjX9nI+4fOTfQrA
         VVISlOX+XtH4Vwz1ErAj43ffD8fxg0Wj/FTYw=
X-Received: by 2002:a17:90b:1647:b0:359:ff8a:ee3f with SMTP id 98e67ed59e1d1-35c0ddb0bf7mr575852a91.30.1774382911288;
        Tue, 24 Mar 2026 13:08:31 -0700 (PDT)
X-Received: by 2002:a17:90b:1647:b0:359:ff8a:ee3f with SMTP id 98e67ed59e1d1-35c0ddb0bf7mr575838a91.30.1774382910805;
        Tue, 24 Mar 2026 13:08:30 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a80163bsm9930057a12.1.2026.03.24.13.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:08:30 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v9 04/10] bng_en: implement ethtool pauseparam operations
Date: Wed, 25 Mar 2026 01:37:34 +0530
Message-ID: <20260324200740.346029-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
References: <20260324200740.346029-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271276-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E0FB031C2B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement .get_pauseparam and .set_pauseparam to support flow control
configuration. This allows reporting and setting of autoneg, RX pause,
and TX pause states.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 6bb74a84ea03..424bf2d6721c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -46,6 +46,67 @@ static void bnge_get_drvinfo(struct net_device *dev,
 	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
 }
 
+static void bnge_get_pauseparam(struct net_device *dev,
+				struct ethtool_pauseparam *epause)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	if (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE) {
+		epause->autoneg = 0;
+		epause->rx_pause = 0;
+		epause->tx_pause = 0;
+		return;
+	}
+
+	epause->autoneg = !!(bn->eth_link_info.autoneg &
+			     BNGE_AUTONEG_FLOW_CTRL);
+	epause->rx_pause = !!(bn->eth_link_info.req_flow_ctrl &
+			      BNGE_LINK_PAUSE_RX);
+	epause->tx_pause = !!(bn->eth_link_info.req_flow_ctrl &
+			      BNGE_LINK_PAUSE_TX);
+}
+
+static int bnge_set_pauseparam(struct net_device *dev,
+			       struct ethtool_pauseparam *epause)
+{
+	struct bnge_ethtool_link_info old_elink_info, *elink_info;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	int rc = 0;
+
+	if (!BNGE_PHY_CFG_ABLE(bd) || (bd->phy_flags & BNGE_PHY_FL_NO_PAUSE))
+		return -EOPNOTSUPP;
+
+	elink_info = &bn->eth_link_info;
+	old_elink_info = *elink_info;
+
+	if (epause->autoneg) {
+		if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED))
+			return -EINVAL;
+
+		elink_info->autoneg |= BNGE_AUTONEG_FLOW_CTRL;
+	} else {
+		if (elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
+			elink_info->force_link_chng = true;
+		elink_info->autoneg &= ~BNGE_AUTONEG_FLOW_CTRL;
+	}
+
+	elink_info->req_flow_ctrl = 0;
+	if (epause->rx_pause)
+		elink_info->req_flow_ctrl |= BNGE_LINK_PAUSE_RX;
+	if (epause->tx_pause)
+		elink_info->req_flow_ctrl |= BNGE_LINK_PAUSE_TX;
+
+	if (netif_running(dev)) {
+		rc = bnge_hwrm_set_pause(bn);
+		if (rc)
+			*elink_info = old_elink_info;
+	}
+
+	return rc;
+}
+
 static const struct ethtool_ops bnge_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
 	.get_link_ksettings	= bnge_get_link_ksettings,
@@ -53,6 +114,8 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.get_drvinfo		= bnge_get_drvinfo,
 	.get_link		= bnge_get_link,
 	.nway_reset		= bnge_nway_reset,
+	.get_pauseparam		= bnge_get_pauseparam,
+	.set_pauseparam		= bnge_set_pauseparam,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
-- 
2.47.3


