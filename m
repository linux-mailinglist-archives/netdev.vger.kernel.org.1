Return-Path: <netdev+bounces-299427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NoU3Ac3wL2qRJQUAu9opvQ
	(envelope-from <netdev+bounces-299427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C776863E0
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JUj7679Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299427-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299427-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2D9C300B28E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4A32BF52;
	Mon, 15 Jun 2026 12:30:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897B3EB10D
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526647; cv=none; b=JtqpquDqesMcu4MgHEZSYOPELTqSxuPfhFMu7pk+qctHUJWjOOYjuuh1B0IInQeR+Nj8ldGqyDMxtbtQv6aZpAJVkc/iIvitalwWb0ZBVorjiuCvTrKy9Pjr5a8tgt9DoLiu8o9QcrMB9u7SKv3tDx7yBYy/LkdjSGuIHBrrUl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526647; c=relaxed/simple;
	bh=LiGJAO0/VUutQ0zWhOKOU6ESlza0YssOsxbuxpLi/68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMVZ7i+JrI2SRajw32405dsH3b+k0SdLpjYmmNNxvW6KFOXXPqbba4G/KPEPnC6lgYs+paWPLd5rtZzEVYvtN2opioWUMxXSb18rda/uVCyQu7yY9gIgS+B7Q0a4+IFx2E28ICEe0MSWH3FT4pJYrgloD33Sdm40eNRlW0HoiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUj7679Q; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so21712055e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781526639; x=1782131439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeREqKwyBL2tZifBDIM4b8FY1VqpNjyArTkAWxSLkSU=;
        b=JUj7679QAhKQy9liM0ZUDJxZDiorzbE3AQnB7jRP+WS/UfXqFu8LWqH7HapAU0W0Ql
         hfq2MeIAatms7DTfxiU0v0LANMzaV4Eu3aSmIE6z9jVQEIxK1aZZ3lK0KDGZj9qKylEy
         BxPFVGJ99MfPvSSo+vGllmY1HxcgzUJv5N1gDp9t/COvoUzOBkABLsqdl4H7PcM9GwDa
         cojVNi4bqYWRExTyHzH0N4ku36m0MSPoDqq4W7BzwrplMFUH03Glm7aROHDNtBlvUj++
         dP6y7Xx+jOY9qRumEVi6cjNYIP2w5fyJM93bL3FMPX1GD4IgWpnsUSiTmntjLI2n/VhR
         XCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526639; x=1782131439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LeREqKwyBL2tZifBDIM4b8FY1VqpNjyArTkAWxSLkSU=;
        b=lH3PrZVYz/1wzcpjB1WIeF+MkxN0y8frzY3xg2qjVMY1J2uoX8yQmp8ImcY02J4gC5
         nbYYFNZoFkam8CvnCHF8J1XMKPA5Fm4kv+zLND11D+kh5wjnbfo0u62MDSLhfOnDOGAC
         sY/QLsEL6yp6UBaJlRgUpWpqSBlGbzrM++AkEwGkT33hveylOlsBKF91NPiHVeF+R9EB
         9HHYBEqkLKQfQYo57L6ijYZlUb7/W1Qiwb9sExnQ8q3r8eIE2zP1osiIfVG5VOAM7Kir
         jYjcuxoDB6hpWhQFP+GQ1SYTrQ3nwzlC9aZv4/o2a4MlJnAWngKlO0bAVK7vAUdi+ZdM
         TkIA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ml5Ccj2yetMrtmpcQVL48vNHqs5oXZqCKDil7qeZPsTebwh2iCcRo44dgrTyjZJLPqIobegY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmm3UwL2ZYi/u1FTQLps9OaNJfS33tlUvA9/si5m5+zOhYMXSO
	vwQNAIMthB/XpcWE0DdnrMmLUGjrHIpz1Wd+qHkc6Q84fw/xTyLZglpS
X-Gm-Gg: Acq92OE6kTfU1ptSlCL0USu03s/xJaDKMeq9ovqWXsHNrO7s63cc108ku7d/yK5N+0J
	Xu7aQEKCWOpRadYTgVaRKcrccOaMNBfYBO6Zck//12icMaTbmV0aFq6xe6TQyg4VH0F3uc0GD3o
	9CM4484cgWe0WsAmVGT+H+nT57rCvQ+Gfg1eTbSxCLvBt7eN16f8zno8TuhYJ0jE87iFI7Ruyra
	KdDJPBntBRUH0rMX990AtOjvMiCAoP0EMUzXwqLk1uOBBukj/loj7Mu2Sb8yV5HlbLhSS2UOQcg
	vwUjV5t18Jx6+YA6hSPQNOy8iPHEhG7zgh5apCiNOpN6yc8ffHwLSYmy4dBhGI+ge8MUb3yMgs9
	Bwvwv3Fq5RVWtrOh9gFYjUSTZb2PdO75FcPLLzTAIfKlgzMlrgZ9R9wj8gm4+GpYKjA92wff3aI
	p4yc2Aa1fFfF6w5QOciexjf2EPVRYELL1VZM6m7PRDYSnr2T6MtrtkFPWydOroNaW8QA==
X-Received: by 2002:a05:600c:3512:b0:491:9969:739d with SMTP id 5b1f17b1804b1-4922011393fmr139236575e9.29.1781526638312;
        Mon, 15 Jun 2026 05:30:38 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm191426435e9.2.2026.06.15.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:30:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v7 03/12] net: phylink: add phylink_release_pcs() to externally release a PCS
Date: Mon, 15 Jun 2026 14:29:39 +0200
Message-ID: <20260615122950.22281-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615122950.22281-1-ansuelsmth@gmail.com>
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299427-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:ansuelsmth@gmail.com,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2C776863E0

Add phylink_release_pcs() to externally release a PCS from a phylink
instance. This can be used to handle case when a single PCS needs to be
removed and the phylink instance needs to be refreshed.

On calling phylink_release_pcs(), the PCS will be removed from the
phylink internal PCS list and the phylink supported_interfaces value is
reparsed with the remaining PCS interfaces.

Also a phylink resolve is triggered to handle the PCS removal.

The flag force_major_config is set to make phylink resolve reconfigure
the interface (even if it didn't change).
This is needed to handle the special case when the current PCS used
by phylink is removed and a major_config is needed to propagae the
configuration change. With this option enabled we also force mac_config
even if the PHY link is not up for the in-band case.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 53 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index cb07184ce82f..ca4dad4b140a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -158,6 +158,7 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
 static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
 
 static void phylink_run_resolve(struct phylink *pl);
+static void phylink_pcs_disable(struct phylink_pcs *pcs);
 
 /**
  * phylink_set_port_modes() - set the port type modes in the ethtool mask
@@ -918,6 +919,58 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
 	}
 }
 
+/**
+ * phylink_release_pcs - Removes a PCS from the phylink PCS available list
+ * @pcs: a pointer to the phylink_pcs struct to be released
+ *
+ * This function release a PCS from the phylink PCS available list if
+ * actually in use. It also refreshes the supported interfaces of the
+ * phylink instance by copying the supported interfaces from the phylink
+ * conf and merging the supported interfaces of the remaining available PCS
+ * in the list and trigger a resolve.
+ */
+void phylink_release_pcs(struct phylink_pcs *pcs)
+{
+	struct phylink *pl;
+
+	ASSERT_RTNL();
+
+	pl = pcs->phylink;
+	if (!pl)
+		return;
+
+	list_del(&pcs->list);
+	pcs->phylink = NULL;
+
+	mutex_lock(&pl->state_mutex);
+
+	/* Check if we are removing the PCS currently
+	 * in use by phylink. If this is the case,
+	 * force phylink resolve to reconfigure the interface
+	 * mode, disable the current PCS and set the
+	 * phylink PCS to NULL.
+	 */
+	if (pl->pcs == pcs) {
+		phylink_pcs_disable(pl->pcs);
+
+		pl->force_major_config = true;
+		pl->pcs = NULL;
+	}
+
+	mutex_unlock(&pl->state_mutex);
+
+	/* Refresh supported interfaces */
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+	list_for_each_entry(pcs, &pl->pcs_list, list)
+		phy_interface_or(pl->supported_interfaces,
+				 pl->supported_interfaces,
+				 pcs->supported_interfaces);
+
+	phylink_run_resolve(pl);
+}
+EXPORT_SYMBOL_GPL(phylink_release_pcs);
+
 static unsigned int phylink_pcs_inband_caps(struct phylink_pcs *pcs,
 				    phy_interface_t interface)
 {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index ca9dfc142388..15e6b1a39dfe 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -751,6 +751,8 @@ void phylink_disconnect_phy(struct phylink *);
 int phylink_set_fixed_link(struct phylink *,
 			   const struct phylink_link_state *);
 
+void phylink_release_pcs(struct phylink_pcs *pcs);
+
 void phylink_mac_change(struct phylink *, bool up);
 void phylink_pcs_change(struct phylink_pcs *, bool up);
 
-- 
2.53.0


