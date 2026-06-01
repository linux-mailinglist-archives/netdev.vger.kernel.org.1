Return-Path: <netdev+bounces-293685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLjdHedkHWqwaAkAu9opvQ
	(envelope-from <netdev+bounces-293685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:54:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193CA61DEE6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94839300FA88
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6EA39C649;
	Mon,  1 Jun 2026 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADCYa61t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A039E167
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311238; cv=none; b=LSrEYuTuf652F6YKbIsViHAuPGNUGQ2fLox99xVybmJe4qeFVaVCJ/cp9nEGao7MyqUB6srRsINsfM6a+T1DRj11al6O19EBWhi/F5phW1LAfZvLyuEMB4FemQDlCDNDava7iJMjsYTdM0M5Vv5idiXRdHjJ36F2kCqD1wYZ2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311238; c=relaxed/simple;
	bh=oAkF4IXnjMiosmEc9YycpmWPvCaagq8LW8Ceu8nAr60=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfUTM11h65I7+jfi38HBhf/6s2UyNyDU5nw/Hppsz9Te7QO7CknWiGjDgXMfouUUTGbpIbyuckEqzgmT7s6ihrU1m/JPkSa1Y3iv95GBlWWcbBOIUnWUqaDOVjrAxv1xUifBlhcmMbWobqpujm5V/HtpAHz60KPxmJjQZzEnF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADCYa61t; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eee266c6cso2718988f8f.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780311235; x=1780916035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dozMnH/MzCaOgkZHqZM5eTN7b80tupvfNNp/Xk7R7M=;
        b=ADCYa61tnx46IBQeUBxYbtBrRjHXEVLn0c1E7OYfzUxKR8FJjxumPjmpvPxKn4Thf2
         4GHOf9uv7kvqkvU2ms7fEOnN37FYm9fcDJDquOv5Oe09peKCUGRhY+ffnDhhxOKycGbm
         rSSzph9BI2l+xT1uRHOzFuO1n0E+0bfl7MPQvk65EiqfXYXWJ1l/hslF8US64/Ur2tfC
         BwqhBGnpTsSUh/HMBFk9sGSlnnjxiiq0d4H8XXwXZe0yWlJ3bet5FMu3YENeZ9lnOsOP
         wlcsNBoEbXG7hQLAn94AXjNHSKc+7W2fqNa1jfnK1NaoV6Ja7YY9SVjfX6MRhyvjIqvm
         379g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780311235; x=1780916035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dozMnH/MzCaOgkZHqZM5eTN7b80tupvfNNp/Xk7R7M=;
        b=Rw3AXGA8rARuge6dERUE9WVkz+DAbD7eEkph/qGxH7H0IFoti6I0z3yDAS4Oq+xS6U
         aQ6w+TszSbwyFuVzXmR3FAbS4+8DMjRbUMwXOj4jxf7iM3jtpnk1RJOfs/Jn9jGnJQwq
         mjp7TJZ2tmrnNEUv7a69ddzp8l8AYdQW9OoUOGeGgV4B98JVR62DGbgb+xfbyLotCfE2
         rOYsqvf9AbOsGQ+eKoQ4TqZk6nOJSjKI75nXP5gHodwGa6YQkziMaQ1vZsRM+isiMvWu
         r7breYy+1zHuyjnwKhst1EvhoHYzE51OgPFmz4jeQWus7DHB+J8aiuMy7sF+SsKl2kUI
         CwFA==
X-Forwarded-Encrypted: i=1; AFNElJ+3vXfyxzdUNbdRTC3Q1+xIZPx4IJs42JJOD91WTCntar+QSAW6UqJStgV8nq2UERQNwRmE4Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/yPN2FflmWCHFZJ9jcQA9KnlXCE1OCTSSIrBhTG/E6rDSbQT
	y6idUCDmPG1bwRZGm6peE+4qfmB/UZX7nvYFVogPeiesa1iN3iSirlK+
X-Gm-Gg: Acq92OGEa/+lgB4ffIClozt9Sr0ZKF29AsSClpYwOIwGVH5Je3+G2J0inCJxtTsF2Un
	wE4BwYBqot8gSYRvk1ZCmQ9HgHJzStsD2TTcQhoVt1tXixTtXt+LvPN5H5/PDSmoWOaRNfUoqJk
	I1BEhovLa24RYmUrUXhEkQOLezPZnSzeNpp+FealJDyeIs+wkBe7ez2uVCJlKYQnKc2EDI1Rzc0
	gjXIz0HaMTZR0hw90y4r/A7IV0A1mv8kM1GpYsFhvoAGghfyJp55gPYcn30lGha5VnPZqXpDcef
	kEl55pQrB6qTo9+oM8ZVgr2fL+ElModfmRsT0TdVM0vn97++TF+YGvN3u9luyuYdJadndrZZYSl
	jXDreuLivWCNzVMM441uwgfUag3RV68LTQQ3qWfJTXhMoCjaNEtEQj+iF1r3s04KgF0pIsyWYB6
	nV/xIu/8yPb0fkd1XtuKSStxhoPcQVTJuSzoHoZEZIqnLNpZVa/4NpvsFNlWfC2+jZe/ac4OHih
	9ZyDKA=
X-Received: by 2002:a05:600c:8b71:b0:490:add9:7f88 with SMTP id 5b1f17b1804b1-490af395bffmr10667175e9.21.1780311234518;
        Mon, 01 Jun 2026 03:53:54 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-42-252-49.retail.telecomitalia.it. [79.42.252.49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c967c77sm257319895e9.1.2026.06.01.03.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:53:54 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: phy: as21xxx: force C45 OPs for AUTONEG
Date: Mon,  1 Jun 2026 12:53:37 +0200
Message-ID: <20260601105342.28865-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601105342.28865-1-ansuelsmth@gmail.com>
References: <20260601105342.28865-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-293685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 193CA61DEE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With further testing with 2.5G NIC, it was discovered that the PHY
require the C45 OPs to configure and restart ANEG or speed higher than
1G doesn't function correctly.

To force C45 OPs with generic PHY function, clear the C22 bit from
devices_in_package bitmask.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 97ca37c6929f..a6686b4908c6 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -616,6 +616,13 @@ static int as21xxx_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Even if PHY declare support for Clause 22 register,
+	 * Clause 45 register should be used for ANEG configuration
+	 * and restart. Clear the C22 bit for devices_in_package to
+	 * force C45 generic OPs in generic PHY ANGE OPs.
+	 */
+	phydev->c45_ids.devices_in_package &= ~BIT(0);
+
 	ret = aeon_ipc_sync_parity(phydev, priv);
 	if (ret)
 		return ret;
-- 
2.53.0


