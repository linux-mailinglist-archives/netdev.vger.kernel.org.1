Return-Path: <netdev+bounces-284555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P3yOZw4+mnHKwMAu9opvQ
	(envelope-from <netdev+bounces-284555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 748674D2C0E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A8E430B6CD2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12314C0402;
	Tue,  5 May 2026 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stJ0RRhC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E733A3E9A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005663; cv=none; b=aG9xVW1qzlRE53LOrEGC30HBXdrF0/cRH7X2hmMuDByAKJNgapBG3fo7t4Hx92PKGZhZbPpYPnYKDO8nfMttJPpf8acUo5zNeuPAQ+fjWG4j6xcJcLjcihpbUyKK4dTDJqlsT3rKIM2sWarcVBDjE/kM6PKSffEMHYR0nFimUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005663; c=relaxed/simple;
	bh=z9crCwe7rX7Mram2FgQSb/0FBR5Vy9InpMtWAVeDhuc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gqq4XKVe5a643S0tgHF4JjJRuXvpqPyLFip/1pMQo/6EesdsXAH3qjLVhhgTvUxzS2Pc7aidEOIiFikKnI68cFyX1uIfado6l4K6fbupbH/0KTYP4YgnNy3SLZtCNWRMWcLXeicZW0YirJxPN76jr7pZlIM/qaMaGO9T1xH6p7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stJ0RRhC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48d146705b4so15176755e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005659; x=1778610459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+otCYoEYq8tITJGMUn5AwoyVWpaSds7MSzdEdQ+mkI=;
        b=stJ0RRhCVn2/0kisqf26nbL4OXyc9AO5BYInq2c1aeQENEwwBz5mkTq3IQ2f3hbO6g
         b1y9CJf3Rb0Vqjn8e/I3xdjZVZxDsSKsEJCNltIqQwUFbfhdVaY+d7sQ7f2gserDnb+k
         yl874Nt2Ckx5Tw32CHe+x1qVpRwjC0HhoY6PMrKhA+ZvVykW1ZKhvvA4zDZOZqGOXiZk
         jivUOZzntqDfQ7VBFGBr4PhDNzt8jsQqhn4y3WlIiV42gCPa4JktIuiyu2sP2EM3idc3
         0y4czF/sHtwCp871edVWzf3PSc9aFVh2PQQ/IcnAoldtw334oDcnat9tpyNjviiAQjIl
         LXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005659; x=1778610459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+otCYoEYq8tITJGMUn5AwoyVWpaSds7MSzdEdQ+mkI=;
        b=epaqGEXFM3vKfcCDKcHVV/MQ+wfZa/6kFGPqqd8wDwkYybGvmHJESvLX22XO5wymyY
         HW7b1I3Bzfc79TEYpQiFSwiuR/eR6L4yQcISYsT5jtBwlUZ/AwkuuRunubnwFqqpsJcA
         6m0PGxIRXC1+qtya9iz+NwNe6i6ogebTmfM99xh3/oOXU0bm3Z5DS3BMatHKVU7B+1Nw
         Eq0ouMz/OLFAG+EH5AR+ylfKlXZ+ePZnU2pSJPSntL7wO0SZL+9gF+x8c+ImAwJC3tgW
         u6Sk9XsUTgWKJllJsbF8k9pJvtxWEJ9heK3fS0dISIl4ELscGWyVsIkjEfr8HSFGIBdi
         mMjA==
X-Forwarded-Encrypted: i=1; AFNElJ8yRwPvvw4h1rBxLgp2wNFs/8GHBnYJHTKiy0bxGFo7oliqJbiFsLETFqgBQF+tFOFSAr1Q+3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyroQMe2007N/JEQz4ofzBywJOzh2/ZZyU/MMu8c+9NTfVHGybR
	nk8Z85HyST0rucEhzZ+N+MkaPEk1yP8N/B3jlhjAqQwrKCIfC0ku6abo
X-Gm-Gg: AeBDievWsS07PPKOcCAGIZbCeF+0xepZRcidDganeI+YPuPREmArsIfgmj5GXnvBha8
	gjIh9WPfvapIo2L1hoRLpQy0F4L9PQ77aW3s1U3gEKWPgacBJ1bivab/EPLOqoTAn6rjbRHqXDS
	mNZ2yNO41HSfVaRoj2hIYKAmC87Rjn/GGiFj45t1r4nKIUF3k6QOfVVgr25zsuYnjcif27r/0lt
	Hju/PjMR9bm+1aNY0dprgYc3EwqJTpd+shw5ydwhnu8HGprdfi/BWBa8BF01sDW5N0JZDYVZydv
	IL7MNZHaOslUBwJI3WACuSIr94JLP9BciHjqsb0LCD7y0eDpQNd/yIREpDshv3v4AHMm8ozwKip
	5jUWgpX4eLZEldTK472O9vlOm9anfSzq7QzgoMRhVat6obaSSJzY27/CNJ1H7tgp1C4bB/hAnZW
	YAqd/CpDOZ/ScHdDGsWm0xrZ/hBz5tkaOAMpRj9uP3YHwd3+rUKSH8GHVdYbANPTcjzNksXkyLI
	zhE0mo=
X-Received: by 2002:a05:600c:4f53:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-48e51f42798mr6028415e9.14.1778005659102;
        Tue, 05 May 2026 11:27:39 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-59-227-65.retail.telecomitalia.it. [82.59.227.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm408208245e9.5.2026.05.05.11.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next RFC PATCH v5 07/10] net: phylink: add .pcs_link_down PCS OP
Date: Tue,  5 May 2026 20:27:08 +0200
Message-ID: <20260505182713.27644-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505182713.27644-1-ansuelsmth@gmail.com>
References: <20260505182713.27644-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 748674D2C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284555-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
index 4ef31bb4eb05..ef2306840c5b 100644
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
index aef4a4fcf6e5..aefdca01b77b 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -523,6 +523,7 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_link_down: torn down link between MAC and PCS.
  * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
  *		     at the MAC.
  * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
@@ -550,6 +551,7 @@ struct phylink_pcs_ops {
 	void (*pcs_an_restart)(struct phylink_pcs *pcs);
 	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    phy_interface_t interface, int speed, int duplex);
+	void (*pcs_link_down)(struct phylink_pcs *pcs);
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
-- 
2.53.0


