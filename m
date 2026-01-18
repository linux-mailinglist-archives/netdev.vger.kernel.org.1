Return-Path: <netdev+bounces-250773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66515D3921C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16F593015024
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8281F1932;
	Sun, 18 Jan 2026 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFNaxSaA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045081E5B9A
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768700394; cv=none; b=qC1oUNJhomgeJlrF0Iao0yJtBDxYXEXNRHW6LWtAGx505SRLLPoE7/DOA90DgkVOdEs/dG84lAbNKU1GF4cdUBGeFxvckoXyyCGJgFyJaD7tz2f6fejDVKwN9ED/i4w2InVP3vchTsUnj0gD4/8KuCD/MH3LEy7yOhLBPjpCx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768700394; c=relaxed/simple;
	bh=Itni9SNfJdb7Dhz/FCbUKIbVg6MfARfvhe9M09DKCfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/gNzsj06N00VMXeFZXnGM6WQZ1+bC4/179jPOSCGJ4Xzf7LP8wpsEXkr6eSGAWgibLqA2G/BQkpApgzeKpaBgFWH4GBRj6ERJ0SwGsUEk4mtMV84RcccXUIkuaqkjqr6AJpI8nDzMhh+4pPMIEQRBezyJy7kNQeJzuCtlpqTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFNaxSaA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0c20ee83dso29506185ad.2
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 17:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768700392; x=1769305192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYwkrpDpNTFizksR2j091lBfcUhZu5HCF7/lQUtqnk4=;
        b=hFNaxSaAJG3wt8VPn6sBEjEtckIrbao5POZXfza9fItW8lc0rFg3eZl62nKE7M9py2
         iTgpBvSy4DPB6kZ3rLZIcRFSKPCVRI2yJOGFNSJOdd026dRIDf53DkGkSIhKz2lM+1MC
         Ti/5E6eZMoxy21Y9klNGRTLUQvk52mOcInk3dGYHdNaH+VXTw9qh7OMq+DBUdVZbM8Ah
         QiabPYwPg6lPZSeKZTZ6mO9cQ/dQVRIUyAQ5YX66umjdkFaxRZP6G8cmMx+Zq/d9FwRb
         Uae/FX0AP7oTGt/F3EuCgt1CGn5N6aK9T3JtWxVK6KPX45Ofum+HT6Lh2gVBfC9OXc2V
         L1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768700392; x=1769305192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYwkrpDpNTFizksR2j091lBfcUhZu5HCF7/lQUtqnk4=;
        b=QS0Bf8cGqH1ckuxZf426HnTilNA72Hoel5ljnEAp3qLJ3faJ2VpLsrEaw7O2H0VR4Q
         2HQ4NzKXlMAS+2MPTa4na9XFjbevN7BMD/P+dlj1sDoj7IRWNgnhh41b+echRBRGdYgr
         s4kcC2tn4FoozJytPALx6Xg3jk41OX7ARmtkIljUbMrqvlRXUTYb1Iq82MoURks6Gf+2
         g+1lwdwdFvaCL5DTkunlK4F70/dPMUpsarfe7tTMhjRjXfIqwpsFfxpCTKsxSJmhQ2EO
         S89lszZl46V5LxHdL05D83ZCdIVC3FLnm6RWAVnBCLMU1MkZ/6ZZ/W1R2lPJGzro2Z5M
         aOTA==
X-Gm-Message-State: AOJu0YycTc9ctPtJOK3zW2GMPu4asoNgjJ3xdRcolYPGfQDAt9o9sYQd
	8VFpix8PtdU+L3glvUyRWud+HJ8KFtRIFsjFFVcqp6U7XtQS5MPFpY1xHrrM0w==
X-Gm-Gg: AY/fxX5e4K5738f1hU4sztIqhJc6Yd0VUeK/8Fnz0EoSP/EVpaE37oJfeQuwH6XMWAA
	yTMnjEQuxCm2+tNkZMKbnXi2EQUNbymBTBMHwAfdPL2LaJ4ZCXc5XXPCOv9rQfENiXCwvGi4X24
	ckRNZ9YJg9gGk1Vehcm+0FnTh7X3BSEmr9sCH5h+1xzf3ciqNdfvPDKFqOJeHXCxlfnY58umsqO
	QwWUsSeJPbaGPqoKtStTYyIi3Wiksvrfad7Izw0MfrkcjfLe9pUaswqLuzTsmwFa5ZPxzYEh+OD
	8nJArsSOIw3TOrT4DjFAeGqtvQ7M5Xrj+fV/AxHkqAic8hNQPwMzzT0NFPqpctYwzQJbbwSSoMz
	s4Aa+rN9LgZx2xxWbQFUPTT51tbRJdBp5+whbb2U23oe4fbDQVJAi3NB/sxUdId0oSyt60ZD2QH
	5VruKTXUBc7A6U7KX3nz8A1pjskPkxr8tG5lx64lRR4q7Hw/dY0w==
X-Received: by 2002:a17:902:db0a:b0:2a3:bf5f:9269 with SMTP id d9443c01a7336-2a7174f0127mr83993075ad.3.1768700392217;
        Sat, 17 Jan 2026 17:39:52 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbbf5sm56030615ad.47.2026.01.17.17.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:39:51 -0800 (PST)
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
Subject: [PATCH net-next v6 2/3] net: dsa: yt921x: Return early for failed MIB read
Date: Sun, 18 Jan 2026 09:30:15 +0800
Message-ID: <20260118013019.1078847-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118013019.1078847-1-mmyangfl@gmail.com>
References: <20260118013019.1078847-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch does not change anything effectively, but serves as a
prerequisite for another patch.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 5e4e8093ba16..fe08385445d2 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -707,6 +707,12 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
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
@@ -716,10 +722,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
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


