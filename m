Return-Path: <netdev+bounces-260471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKluH7GKnWnBQQQAu9opvQ
	(envelope-from <netdev+bounces-260471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:25:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631818633A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA7F6305EE70
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475737C11E;
	Tue, 24 Feb 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT2brxlL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5237C113
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932318; cv=none; b=QR8vX0s9IsRKj6n6k668jA/30bPSWTFrWwcEn7B11JtwdDbIZeTiLMnKSc8Ih8XHtJpL5YKCbwVRmaVbrEi10EPR4yr247Gwdl2wcpHacH4wxj4c4kG0UgnNL4UMu5k8jT+9ykIEcRUfxCVDBRRz1kZBi6LyEVze8G36uNKZ8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932318; c=relaxed/simple;
	bh=NnA+ladcl5fN/a1cqakfqNn4Wc8T0mbMb1O+39wzdfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBWeMv7twFTBZ3o+XABEPYQPXvHFW53/4Lpz2J0ItikzQPCziyJd38x1308v5/SVQajy7d+6WLp4M0+hojbcAwwv/CX8cduip+f7S7r34Jt7cveoUsJJT0epLDQjHKRurXfcDqHMZgOH96xBhBcDKMc7m0sJlQS+XbM4DV0DoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT2brxlL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8249cb73792so4795812b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771932317; x=1772537117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc5Mczx03HkfwLHmcGZSdli4mQTFqoQ2+whK6vNjKXs=;
        b=NT2brxlLMhdecWT3fr+KAyKfQ1QbNBkiEubvFRMlZq4TgSK5XW7gnq9B4Ojd7iJsO+
         vT3cw+/6XIxz1YcgOgg8wubigMJdL1YfypxTo3jmYyb84uJkRCfPV/Nbs4YWDN1o2JLa
         b3M6LeX7lsWM/KS6gKjBS1cFaohk8rz90i7uBeY3d02ItnSpYFb/zcheIOKcnn6LdRwv
         X0oyVS1XA86kVZVKwj7P0YTtOSj6QLoYd05wD49HNiwHDqM+8Bn3N/SEC1rei+3B8Sc8
         S2lXd0c/qn+BvMicVOAKpPGBmB2gUxkFTknoddqdx3NEMFOSOzm7dkYiueEfPO1/3wMv
         cEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771932317; x=1772537117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jc5Mczx03HkfwLHmcGZSdli4mQTFqoQ2+whK6vNjKXs=;
        b=qwTUQfZ97LS/qAcknoMy0Szkj0yrVMu2n745JY0xjNgt3EGBOuXRckOKtfi+d8soi2
         OjMNqBjUEahjnNFMYubo+fvKCnNUxP7bswm6qU8rSozv69zEtn+mGQQdvc0fm6nS/DFp
         YM/QuY5B05hLDgRP8P1c9/XdrpmhBMJO2aynI3KfPM6LagF2L0Gdo8HjzwLDntHVwSa9
         CNuDqwMtsVVcyE2R8Bzq61pZk6nyzhwG+qUBcOl/GE15D9ab5gtXpZA0zHQTFlsLvXvE
         2RlfOdyqS8TNQg31+XIxv/qYYksjBRLHW67tcvt1FXevG1+EgBWNSjpN7QgkZ9VGL3O8
         qpRw==
X-Gm-Message-State: AOJu0Ywm0t6NjpbKkZSkyRwRdLr8MEHkIpo1d1Wl6iBqiJDuOFLqvJAG
	Se8/S+mFwzKD/2IqcYKgnKMDH8mcgZ5l1z666FG49v63sSU7g2RHY4TmiEkKDas6
X-Gm-Gg: ATEYQzz/xE66SHiNrVZf/k3UuNbx8Dk/tCmVJco3tzMG9zNe4wDoQqCqkqgtrUkWW0g
	d/JONlyutpD9Isq+EBx/ntQ+zD9uHASocFx2j/BEQNrfgS63WbmTpn8kolGzLDleRZHHiArAhl4
	FrW8+fZRqE10FgL7iczJq3ey3LdlCceWWA7LNsz0Bb23yWBhBko4XHqndS1avdn0P2oWxy4Y5q+
	XjvUYQ+Tf43F/6gm7Zw8BBW3Q/lUy9mBltwEXFmK1hBO7nfiXDBdB9WTUSQnK0DEkfo+Mpb5/x0
	IDT0kiXmWekY+qVPMp3jJkDPramAfZ4V44neZIntKpS2K7kGm0LNJkk4bRBsoD+BZEIbaXe9uOJ
	DFgubWrxlxn54M/Ij+ryX1siiFGODUb8Pa4tkg4PLhI6hbQSxCpulMGdFQMrHiaNvmP4S653LCw
	XbGn/Sy5ZPhs1c9CwFhb2lFMIHLGyYQbGcShPCCrSeW7lWQ4OJYx1953s=
X-Received: by 2002:a05:6a00:cc4:b0:81f:4963:4967 with SMTP id d2e1a72fcca58-826daaab72emr12538770b3a.57.1771932317035;
        Tue, 24 Feb 2026 03:25:17 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd694eecsm10262316b3a.25.2026.02.24.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:25:16 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: dsa: yt921x: Return early for failed MIB read
Date: Tue, 24 Feb 2026 19:24:06 +0800
Message-ID: <20260224112411.1561917-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224112411.1561917-1-mmyangfl@gmail.com>
References: <20260224112411.1561917-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260471-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3631818633A
X-Rspamd-Action: no action

This patch is a prerequisite for another patch. It does not change the
behavior on the success path.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 77864dcbb6c5..c72a74ed29cf 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -717,6 +717,11 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		WRITE_ONCE(*valp, val);
 	}
 
+	if (res) {
+		print_port_err(dev, port, res, "read stats for");
+		return res;
+	}
+
 	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
 			mib->rx_128_255byte + mib->rx_256_511byte +
 			mib->rx_512_1023byte + mib->rx_1024_1518byte +
@@ -726,9 +731,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			mib->tx_512_1023byte + mib->tx_1024_1518byte +
 			mib->tx_jumbo;
 
-	if (res)
-		print_port_err(dev, port, res, "read stats for");
-	return res;
+	return 0;
 }
 
 static void yt921x_poll_mib(struct work_struct *work)
-- 
2.51.0


