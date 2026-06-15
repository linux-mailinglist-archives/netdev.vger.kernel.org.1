Return-Path: <netdev+bounces-299433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9f0YD2TyL2oQJgUAu9opvQ
	(envelope-from <netdev+bounces-299433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:39:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A92686491
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:38:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=stefvXel;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299433-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299433-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897FE305F09C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A103F7895;
	Mon, 15 Jun 2026 12:31:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C43F44DA
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:30:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526663; cv=none; b=QobbO+HAlErsaoHyhhFVEr99qMqkJ/bv9pHqWovHrDlXf+cixmNkKBKOaBivJX6hvVVJ3TySWQS2YctBtW82x3Zp5vmihpkKHkI1dCfPc6wDBZNl1ueKqdivVCzI1j4jaM49bnWAfFt3og47aNETv/cjJiBaXIW0OuYZCiA2rsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526663; c=relaxed/simple;
	bh=30QNHt/uyMqU2qLsz6aFbvIpIdmUJ01fiuBt57q5BGE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drKRs+4gnHrI/O+IRwYoPnZAbbenVxwj4TfmQY/O7PEdLgMcZEVy3Mz5w5nkVqTEOBxtUZqY/yIUCVwV3M4fTX/uMDw/V0Yp+gGqdPl9UHC0ozhCpR0oouoC3TYpGw1Pf/NVipUUiDQedLxauegbUUMWImoyfdvqK6s3e1T65cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stefvXel; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so19210605e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781526651; x=1782131451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nO+Qv6/pUZm+9zWLiB9BZPBet5FYSX8BuSSJgUbckJA=;
        b=stefvXelEs7+hE6oUce+2bPTXSQvm1qihydmKgnMkC314GQI039Ihm6aYez/WWlAHs
         j4/mlU6dlnxkyKnx3tsooeL5HlUgqYNY7yizh9e7YkZf8IAgWM9j0QYhppNor0DC7H1j
         AyYMv7MfYCwAfTVJJBy74tH9zVg0CbkB1MoSD/ewR+kBihBh8h3ls4CLcnZ8+6FWLbxT
         uPcHL2YR+N5Z8fzN4mN607PHJmTi6UUVVOyjPPY2B1idvG9DdIl4W0Q4UjtnCv6d8Gaf
         yx+s+57nHPdbmUUNWS+n8eThuo2n7uuS6aszqC6fYRCexUDDp2no/uQ08HJpj59wXOe2
         T+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526651; x=1782131451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nO+Qv6/pUZm+9zWLiB9BZPBet5FYSX8BuSSJgUbckJA=;
        b=i1Jbs+277wogv/3ZTc8aQpv88Exw2N8Qknl87WiSSpEphDlnNKf9Xna+KiUpEZDOLq
         /KtvSidu5G4nonrdRRM8aCWC6DbFbJz5Ch0gbc/gZw9z22fmN9dFD5+poCYUb2eleXNJ
         LXKhHeMShZXr7TnqIkliFvUEQf6yvOWASdekBs1NOVi6RZcfQBBCmZNtLKr0RaHC5rWh
         46PthtaxPqRJamZlFFu6sssMSnvJfJdNx5B8ACMWkewbPH4T5D6P2JqTQsjXqvKBELEd
         adljxzqYQk3lkQ660oRPTC0iGVRZniypj4anzNXngAv7azgfnnjMc9o2NNPYpf3y3Cog
         L9wg==
X-Forwarded-Encrypted: i=1; AFNElJ9zmIhh54+FE//9+V6pmnTYU8iEGdjvw90VbZfNjUgcHGHLKjEa9s4k7B2qyJ7W7GizjCTm4t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymopAgU23DBM2rB63HSSu8IaPOFlW7qno6VJ7XSbrrowK0jc98
	n/fcEidRZL1ZYXDjesCMAkqZZf9veVZbPJ4Mqx1cXh6PrOU0FbBgs/c9
X-Gm-Gg: Acq92OGKmeWDXrO7SU1AGXgMYNhnzm3wFoU6xyiGu9m4AUf/rCnRlr/MLgcX9CAw7LB
	CvVTVyoXz+aIZ0/yoYoYDhtDz0I3LY3Xvl6Qks2wiEXEA9BOoabbOv4v5s7NpVWAJE/5I0UiiAM
	Us10bFhMhmWeF/YUnWEzBxM7sqVd+njXEyHWhF92mT+lcHMxfjNLKH2/oLQv5Kvy2r4pMtzlOL5
	LgOZ45xLJGF6vmdbb9Zp4yignRamNm0WL/UZLnFDC+Xh/GymPgbSvjsLPbFUN4gUg0X9SXIAJak
	hFHrfE6jzQQMt4u5UJjqaZUd4AJ0NJZVPtWUBNDWgoDGNhny99ssJiejxsZO5wc6r1SV09N1Ve7
	Yes70oEbTsJRmeNKBqo6OWSKW5wNAT2H7TMQ9l/MZrhWjckqt/GTgQPNc68aPKtF4MiKUeHFAC5
	wAJysw5LQNrwPS42efdLNSA2N8G0NbjbG/iZDdecT1Rm9wHWrzcBT7ess=
X-Received: by 2002:a05:600c:4f83:b0:492:2c87:3d34 with SMTP id 5b1f17b1804b1-4922c874027mr31192735e9.15.1781526650826;
        Mon, 15 Jun 2026 05:30:50 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm191426435e9.2.2026.06.15.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:30:50 -0700 (PDT)
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
Subject: [PATCH net-next v7 09/12] net: phylink: add .pcs_link_down PCS OP
Date: Mon, 15 Jun 2026 14:29:45 +0200
Message-ID: <20260615122950.22281-10-ansuelsmth@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299433-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6A92686491

Permit for PCS driver to define specific operation to tear down the link
between the MAC and the PCS.

This might be needed for some PCS that reset counter or require special
reset to correctly work if the link needs to be restored later.

On phylink_link_down() call, the additional phylink_pcs_link_down() will
be called after .mac_link_down to tear down the link.

PCS driver will need to define .pcs_link_down to make use of this.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 9 +++++++++
 include/linux/phylink.h   | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0734c98498a9..1bedac517d21 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1035,6 +1035,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1736,6 +1742,9 @@ static void phylink_link_down(struct phylink *pl)
 
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
+
+	phylink_pcs_link_down(pl->pcs);
+
 	phylink_info(pl, "Link is Down\n");
 }
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 15e6b1a39dfe..eb6c6ca34147 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -528,6 +528,7 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_link_down: tear down link between MAC and PCS.
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


