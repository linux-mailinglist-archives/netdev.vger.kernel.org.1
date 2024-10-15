Return-Path: <netdev+bounces-135650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573E99EB18
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0511C21890
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1841C07F8;
	Tue, 15 Oct 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bR5xbrlP"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476A1C07CC;
	Tue, 15 Oct 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997386; cv=none; b=oz48GXf1IjZmfdFNjqcWBooxugKmv3hI/J0TmFcVnJsTiA+X3UCIRtUZo8pC3liENbbnnzmhbt2nlyPXTgMy6Yt56wqMSmS0mTm4Irm45bPTxF6sT0kR14wAa7WQliooxv+VqIq/7/cvA9GXUaX29OUco6d7X4qV4bZEpOd8B74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997386; c=relaxed/simple;
	bh=KsxbVLLb5mSXr9MzEnFI0WZ6wgABIMOU16O5rHYUfAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GM3tb+nU7zxCs4/hTeo50mXvex7eA/daKkKiOHsogCW9hzhSOPRzmkti6DJWdNUNUw0u/jbGsuxBKdEniTeJY7ej8V4qlo856MLD1ltvuyFj9qs33jJm870heiK1z+Sbxm3sR6SyW4kkZ4K6yxiVhgf6080w0rnx0NggxLugJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bR5xbrlP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD437240011;
	Tue, 15 Oct 2024 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728997377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tB4vniWUxYC17UqKEQJdi/0DMe6E+5OaeMyfhUbhiaQ=;
	b=bR5xbrlPWX4u95XKip/MkJK7Wc6MKFo7FSbzplH2dJf+y3zWSswC2hOl+EX0nT0fYdNhRA
	FPfArP8eyLqsfl9+JIgB6W/hK0P8zRuLh02uADrNkRTImbMUUJ7KWy6H8hzOtiPYY7aqb+
	WM+I3GoY/OsdddGWMdMdHUq3cY8eVWw1Q1RksaLmrz9+CK6wweuYuTkcZIsqyuo1vaOcbS
	Mt68Y9kUfQbGUiLQ1v+5OtlKVFZZKoo8sAhglzq7307SVd8h5xHKIC0Pn1pTBAzkbHnrPH
	aUo/cEJwxvUNQsP3Iwqd2Df/k9q8+rRRPY4gm+oe8MX1jK8ptOyFAIlFNJpSLg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kyle Swenson <kyle.swenson@est.tech>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: Fix out of bound for loop
Date: Tue, 15 Oct 2024 15:02:54 +0200
Message-Id: <20241015130255.125508-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Adjust the loop limit to prevent out-of-bounds access when iterating over
PI structures. The loop should not reach the index pcdev->nr_lines since
we allocate exactly pcdev->nr_lines number of PI structures. This fix
ensures proper bounds are maintained during iterations.

Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index f8e6854781e6..2906ce173f66 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -113,7 +113,7 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
 {
 	int i;
 
-	for (i = 0; i <= pcdev->nr_lines; i++) {
+	for (i = 0; i < pcdev->nr_lines; i++) {
 		of_node_put(pcdev->pi[i].pairset[0].np);
 		of_node_put(pcdev->pi[i].pairset[1].np);
 		of_node_put(pcdev->pi[i].np);
@@ -647,7 +647,7 @@ static int of_pse_match_pi(struct pse_controller_dev *pcdev,
 {
 	int i;
 
-	for (i = 0; i <= pcdev->nr_lines; i++) {
+	for (i = 0; i < pcdev->nr_lines; i++) {
 		if (pcdev->pi[i].np == np)
 			return i;
 	}
-- 
2.34.1


