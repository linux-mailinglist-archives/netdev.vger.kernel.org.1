Return-Path: <netdev+bounces-297112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YD9SJg40KGpeAAMAu9opvQ
	(envelope-from <netdev+bounces-297112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91595661E3F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mDBG478I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297112-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297112-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B16E13160CF6
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAC494A07;
	Tue,  9 Jun 2026 15:13:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B316495534
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:13:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018022; cv=none; b=K8Vdc/8UyKvkR6Wd+CXmm02SErVQsfAvIOpT5rtjxLXlVHj85Pemzj/xj44NrSZ/l/VKltkAnlDU7q9zMJqIdctH2ttD5bfloTGJM6KS1RL5ttAnyS/etgCCmZNnjcFog60FGo9mKw8gDTMAdVUHdSYx4bY6+6Lje2x6/fwWk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018022; c=relaxed/simple;
	bh=tpAXJdZq6BjF0DfbpXDCqiFqjsTUCSKFfSE16ogKceQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNop0Q4BJGs9bGl69HWxcKEQSsVoowOOtqUokSVMkrad/zqh8WDS+W5btU8/aaN10xY4cio/m4vQCQcMY0PkQB9URzDPKrHSQLkvTLTjul14KeaqCNrH8f6Sslk0cDNhOWHczMHXt4EncaxBNlyNe1D6XqsvmKGRVTIsB2H0HA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDBG478I; arc=none smtp.client-ip=209.85.218.53
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-beb7f26ed62so652283466b.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018009; x=1781622809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCE+R9wA56VqH4pDqL6DakPzOTQgXi/PURE5D91YIjM=;
        b=mDBG478ILZBk8Rycj2Q5NuQHr65L7wp5JhR5wTxspx9r/zngFDFH3Ayc7VbnOEzQLO
         AHGOYRKztPAd38+0BUEF3irHU4T+YQSx4fZfDnhZMIk41s/ezIg9rtSVKiLylm9jeA9P
         F81/sm8+zNqKdpD53hg1eCmd4Wged8xIMwKerZkWxUHUOKpUQYmawIU6JYz4qaFRjqjd
         LzxCjONVJMmi/02gh37F/l5M0CP1CSNTucZmM3pOBJA8t0VMvqurSb/cC9mFYRwYherk
         ZERhPJrbhdXbFjFAp5f5k9qpfrYMA5NawbcWfGBzhboMf8HHFqiWWRJRoDtY62iQVuZe
         RjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018009; x=1781622809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rCE+R9wA56VqH4pDqL6DakPzOTQgXi/PURE5D91YIjM=;
        b=cISf59kOIFr5L00lFWGe3U/xqh/Mh/HLlHBp7RfKSpb+NDWevGZ8vMDfC+b/tpS6lp
         q1qVyK9AT1ocseK16mWUnrBu1AkPa83YU3laNG88l70s5NlJKERxnkEn7bfAn48/8m7k
         1C/tWK2r/qk16ni/+kZX0lIweF8dL21Bu0RhGqDTwF5YgUoXXsPLkuPbxmfsuJn2ZrkM
         GLVKaDPF/GuoiDX6TfltCk7BxtLySD5b/7f4RA8a6cs72V2kOp6J8Hn7om6DtL3NbgOH
         crsZPZT2n2G8eDLXqUAu3Pia2NUNr4X4hh089ZXA81ywyXLWed1oI9DYfh0UZRRvkV5K
         0v5w==
X-Forwarded-Encrypted: i=1; AFNElJ9EvMdn3ERtbPdrR2BophlNn+8stgEB7buaL8zExR46V8IAD9spIlcy3Xzo9UmifFxKTtlly54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUpQ9yT9GR75SmNv1l5Af07m3ebM8S3p+BdRuBkOFCOQQzBss
	n42U+vDAjxHUMnt/HmsTFb+mzZkBHGSdF9G/eRJnFI/zKdiqWcRoD+MG
X-Gm-Gg: Acq92OHcJWr32zH01/zm7xw7NifzUqkNRFuqeqs23nxaQ/wIGYNJG89Ahm+ZJ52qpIR
	kePfZ69jx5jZikbWewtS9h8hePwloBq8LqAG2yvbI0CIElijUq8JX7E8OVX/Cn5S/sWQiJoKDKO
	xM002pbstHRLFMrgZF10qGEQM6GF4r2gw3g4FP9zDt/ChuqOjaskO/EVgxn1mfzGfDUP2jmj/fQ
	do3kwT689cK7fuNZ+Lod3yFwXqchtOK1zSeVUvBEsuUZ8W76bSXXXIHcDdfU2ulM8a5ud3RQ5c7
	nktZk63IimQR14MH6l+mJnoRJBIBhqmAXHh12zg4N4uPkU9qNhI5WFOhCIjhMVxjxmP05+RYKrE
	KQWt4sQg5Jyb8UgaXzO44RLA313MIxF99NHXtOQOIK/9bfEf4pZODvBgmI17xt7xmw82jJ+OYNw
	QnfRrj4pIRkZ8dL5CQ/thwGLIO8IlVhx9A
X-Received: by 2002:a17:906:cc55:b0:baa:1d9:66ff with SMTP id a640c23a62f3a-bf9373dad65mr128724266b.20.1781018009295;
        Tue, 09 Jun 2026 08:13:29 -0700 (PDT)
Received: from Ansuel-XPS24 ([2.195.136.12])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bf0517721e5sm1073637866b.9.2026.06.09.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:13:28 -0700 (PDT)
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
Subject: [PATCH net-next v6 09/12] net: phylink: add .pcs_link_down PCS OP
Date: Tue,  9 Jun 2026 17:12:05 +0200
Message-ID: <20260609151212.29469-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609151212.29469-1-ansuelsmth@gmail.com>
References: <20260609151212.29469-1-ansuelsmth@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297112-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91595661E3F

Permit for PCS driver to define specific operation to torn down the link
between the MAC and the PCS.

This might be needed for some PCS that reset counter or require special
reset to correctly work if the link needs to be restored later.

On phylink_link_down() call, the additional phylink_pcs_link_down() will
be called before .mac_link_down to torn down the link.

PCS driver will need to define .pcs_link_down to make use of this.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 8 ++++++++
 include/linux/phylink.h   | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 65b67c33e12f..38428b375eca 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1036,6 +1036,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
 }
 
+static void phylink_pcs_link_down(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_link_down)
+		pcs->ops->pcs_link_down(pcs);
+}
+
 static void phylink_pcs_disable_eee(struct phylink_pcs *pcs)
 {
 	if (pcs && pcs->ops->pcs_disable_eee)
@@ -1735,6 +1741,8 @@ static void phylink_link_down(struct phylink *pl)
 
 	phylink_deactivate_lpi(pl);
 
+	phylink_pcs_link_down(pl->pcs);
+
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
 	phylink_info(pl, "Link is Down\n");
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index b65f91c78d8c..79a1496fa519 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -528,6 +528,7 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_link_down: torn down link between MAC and PCS.
  * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
  *		     at the MAC.
  * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
@@ -555,6 +556,7 @@ struct phylink_pcs_ops {
 	void (*pcs_an_restart)(struct phylink_pcs *pcs);
 	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    phy_interface_t interface, int speed, int duplex);
+	void (*pcs_link_down)(struct phylink_pcs *pcs);
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
-- 
2.53.0


