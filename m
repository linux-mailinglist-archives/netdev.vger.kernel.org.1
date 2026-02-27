Return-Path: <netdev+bounces-261849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J9AO16hoWnEvAQAu9opvQ
	(envelope-from <netdev+bounces-261849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:51:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D81B7E7A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1DB43052B95
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792603EF0C6;
	Fri, 27 Feb 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH7PYHEa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2126B777
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200284; cv=none; b=d6gYjTMTjIzKgZEoR5Rjdm1WU8SbNSI9BsC5MUT/hI5bqArN77hRqJ27bd05ctX3YsWthy148Gw4idnRSxGg0fn6ppMqYWY0V16PXUZAkBvbbsRMd/CQXWQreAyGDdQaecE/E1eyvXC2JyoAa1uud7nwun+/o2bVajw7FzfEyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200284; c=relaxed/simple;
	bh=bUd/xXUGuKJ24g8t5OvXHAIJtGJa6BG6HQ75B3oHf3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N63kBPVpykYkisO0OoVxvcPJiQnjT5a950NS/N+4y2s9kQplU37D5Soa7fWnGtwZYMV+eqmdWjINxyihM8WU5Q5b/9jPoYtWT3VTt8BolgQIhkby48jx6EyVOSuu6VWHFYSJ8hPKcbvphDeEP6b2gr1GxjhuWY20OnStoGp1oCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH7PYHEa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adae92249eso22685955ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 05:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772200282; x=1772805082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Rwr90VfIR2c5Obok3TP7RtOjTugeK3LFAwPdco+WUw=;
        b=MH7PYHEaBUMIAwxcZY1h8eADYRRFHCFSgi+THmxoXnskbw4nB89KECY+1/UC4PfTyG
         YoN5+TWCSSJqD2PTR4trkqzZB+9dqjfi45z84/H9VZo19ma9H+j2eyzY6863Kv2sOMX3
         BXyZ+wxzRLbp89mB/fpeqn1dK+sO68Uz1R2RZMM5L3TRVWZ6St/jIEDvxB+Uyj4Ey9YN
         JoxXZA5diV9LvNHxix/bldt1mC60OFsgSN/3Vug7HM+I2st42bN70xA6MnN/NIzHALaI
         yc4oftGIQ2lfqGPNdrYrAjkimiWYWalqB5A7chfpTFiBMbi3RqFtGeThiAw7dwQGPRns
         Or5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772200282; x=1772805082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Rwr90VfIR2c5Obok3TP7RtOjTugeK3LFAwPdco+WUw=;
        b=mRey3QnxXNIrPm4vedB+JyRIeIJWExzlTo2vrDUxVmxtTawfXl1ntm3PST6hV9kZo4
         DQ8frDp2WHzUl/DeL6Mu5/uEmLeutX6OyhxQe8egSmwqDdDceddP7LUevKtWT5uj5ibn
         v6zqRGPMHslV7omYNM705FwSFz1HmuQTj/WdvJ9z1H8ce00pcbZVwwDIviqQeK5mIhbL
         fqha8GUn+7lRunwxQWrcj3fDCenf8SmXKiiFISf6926g4vMLfyV62M+ZWc+7EFpX/PB7
         Pe78jcgWJtCCjrTxaeWH9+prk5RM9sjA7c1+HalEYTpzyoztYJryEeOllySBqnKl5L5n
         chQA==
X-Gm-Message-State: AOJu0YxQzVe+qtqFQiuhdtXECLrZ9+HcI7CYu5Zo7O1d0KWCXYgobQJJ
	1Nnf8UVFFaDDU55oURs4s3b93ZNpv2WoPunrdTS0m5OlJrcesj6AvW0W7/bzmg1z
X-Gm-Gg: ATEYQzxOp5zcXQe5UThIrGtaFUnhe7h+Wp/Seqj+DJw8/r7FYLhaEJea99kkc237A9e
	s1fqdS6MSq0yziEetNMO/a6wy975W2HOPd1hgvu2GYGsq3ndg9Ftfm3zGCVIHSR/5+5oj4ab2jm
	V5n+RSZcZWheZgfsSvR7+hCUHZfgVKCksGa9/kzD/XA6f9QzxOIfEGqZpsdVFZDBvDFmhXc7r5a
	kVlV7mLxgoZfege14Rq61cjr7YeIIr1Hi7zV/9g8g6j3286nE/GRZmZBE8/N30Sd8/kHL+StZyT
	n16XEjsUgmUa5Haso3S54Mj9mKlRixdY7BNqpTQ+Iuk8S02viniFykEEHe16d2B3xfvoXhb5a1y
	HkYszlMniXKeRJYAuhOysbJfvE+cMZCXpmvB5QLpwOdEkwZGujvP6amgh4y/YXXhNGkEx2WpuPI
	sE3Tt05yURtdCS7mfpmLxMyZWvW55wUI35fD9PTQeUuHiS
X-Received: by 2002:a17:903:2442:b0:2a7:d7dd:8812 with SMTP id d9443c01a7336-2ae2e4b55c6mr28716625ad.38.1772200282171;
        Fri, 27 Feb 2026 05:51:22 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d24b3sm55490275ad.78.2026.02.27.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 05:51:21 -0800 (PST)
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
Subject: [PATCH net-next v3 1/2] net: dsa: yt921x: Return early for failed MIB read
Date: Fri, 27 Feb 2026 21:50:53 +0800
Message-ID: <20260227135057.2730254-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227135057.2730254-1-mmyangfl@gmail.com>
References: <20260227135057.2730254-1-mmyangfl@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-261849-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 857D81B7E7A
X-Rspamd-Action: no action

This is a prerequisite for another patch. It does not change the
behavior on the success path.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 98e8915dd6c2..a968a3fb56f8 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -711,6 +711,12 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		WRITE_ONCE(*valp, val);
 	}
 
+	if (res) {
+		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
+			port, res);
+		return res;
+	}
+
 	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
 			mib->rx_128_255byte + mib->rx_256_511byte +
 			mib->rx_512_1023byte + mib->rx_1024_1518byte +
@@ -720,10 +726,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			mib->tx_512_1023byte + mib->tx_1024_1518byte +
 			mib->tx_jumbo;
 
-	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
-	return res;
+	return 0;
 }
 
 static void yt921x_poll_mib(struct work_struct *work)
-- 
2.51.0


