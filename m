Return-Path: <netdev+bounces-137127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D49A47A0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 22:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7628B2300E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B61DA0EB;
	Fri, 18 Oct 2024 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDeFzvJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C8136341;
	Fri, 18 Oct 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281927; cv=none; b=L3XDoFCGrGuATiZID8c952Xfi40Shoi1VUaYT0AaOeOoifHvGm6waQqLM3QbXm3y21pgFBT3v3xOQWmjKZNwCVz9A9j2tILTls7v1j0WHc42XGg7wwiNDitffKR5IfYh0ysb+O0u3coRvNbVY1LIclyR3xAy1ye3Wbc26Lp/844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281927; c=relaxed/simple;
	bh=M6Qw0hensInEvU8qqsRIko64nHxLMINN0V3biCVjq+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTJ67dX/Q4mtt8UyHOsa4uNRxQGaPJ044iKXKyi6s/Sz/yOz+4jA9hyRgmiArLV0YQDnjKvaGTP47SBuoXF83PceFc5ex1nF9vQwT7/jkokaviLZayILx20p5jKTl3VeezsF5o4lplxdxR5AaOvzYEHRYnGMZfMuS+pmIkBxgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDeFzvJF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cbcd71012so23323355ad.3;
        Fri, 18 Oct 2024 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729281925; x=1729886725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxlZvp9Wi25P9voOrnrR/TE75KeagoCWsKqvLGdRZjw=;
        b=GDeFzvJFJDer+3uSXMUH15C4UkcYbwe4Q3yOwgU4EcYM4xuLggPSk5FvCP987tdggj
         dmTaHMvenTtMOoz2nVzdRl+tKKYhI9w4ueEIFmepBnc4Kkqo/PbjqtCpi8U6GLZ/MY6/
         /Ha4TqdVV68T/baY5Rdat1Yt+MQOtApsgpMltkqfohRKOkYncqBQFhpO2z7x58qbBZCh
         s9epUdT67et8iHJ0OD1UZIWyfwPzjVPZXotPJSIMh8YdnThLdki/opbFo751fVSbuFhV
         SWlrylkdOjo7dh1YGhGMu2jIUky3A3yVkpcVEeduMc0Y1asrnXZgBcJ7lvwzGU8RSuuD
         2uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281925; x=1729886725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxlZvp9Wi25P9voOrnrR/TE75KeagoCWsKqvLGdRZjw=;
        b=sOtYZgJdHcWXmBkOufdk5KQ0gy67mRm8RuXn02ONWWmDnrkCGvwydPIMk4ALkNcUYl
         4MzSW6Y5jQ636/+zsRw1Y0ZoXsPyOztS2kcvl9BPieM4nfeOzBpwaGYcNZqzt6jdIgzI
         KaTZhGi0OVO7z0o4JHEAtB3r9U5JF6roRgd1gBAvOsfcWk2o6I6K8zI3+dh+U7IaNhir
         Lr1cIEXvhDU850jR0+ktjEimxt8ODpfwdBtAtAAC3o5xiS64XOdSRM7V/zoQNcTtaCDl
         /A9xr3lP0RFAbU6nAJ8rrNhVeVQQUFlPbUYAAqi+Dg3qkx2BqSuOI2EH8SSZDaED0qQn
         CxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcR4iNT486gvJG/XSAWUTYHq+d46BDonRhjpcWsrRIaJ/Z4QmDy9RjpOhu+a/wNdu5RoyN+kal7XVx0W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7vGR7gUzXPnCWh1Gnk8XwSnAjh6GI+wS+05Am8u8zWdEiTs2
	HV3P4ttaD3PpHE+0CssL//3G6I79tyFpicGQVUMMJ5KLGt9g9MO4zHRWRQ==
X-Google-Smtp-Source: AGHT+IFijJxG1EEv3N6T0D/QUuWjjL9BwDpqYNHyAhqzL/F8lTjXxHKnZfAIc6Mk8dfNTuweK8zvXQ==
X-Received: by 2002:a17:902:f641:b0:20b:6918:30b5 with SMTP id d9443c01a7336-20e5a90624cmr50152535ad.41.1729281924569;
        Fri, 18 Oct 2024 13:05:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f98b2sm16432065ad.209.2024.10.18.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:05:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: mv643xx: use ethtool_puts
Date: Fri, 18 Oct 2024 13:05:22 -0700
Message-ID: <20241018200522.12506-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying get_strings and avoids manual pointer manipulation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 4abd3ebcdbd6..a06048719e84 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -1698,13 +1698,9 @@ static void mv643xx_eth_get_strings(struct net_device *dev,
 {
 	int i;
 
-	if (stringset == ETH_SS_STATS) {
-		for (i = 0; i < ARRAY_SIZE(mv643xx_eth_stats); i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-				mv643xx_eth_stats[i].stat_string,
-				ETH_GSTRING_LEN);
-		}
-	}
+	if (stringset == ETH_SS_STATS)
+		for (i = 0; i < ARRAY_SIZE(mv643xx_eth_stats); i++)
+			ethtool_puts(&data, mv643xx_eth_stats[i].stat_string);
 }
 
 static void mv643xx_eth_get_ethtool_stats(struct net_device *dev,
-- 
2.47.0


