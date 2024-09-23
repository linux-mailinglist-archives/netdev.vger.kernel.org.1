Return-Path: <netdev+bounces-129330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203497EE44
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FE11C21773
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82271DFDE;
	Mon, 23 Sep 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GtPndt5U"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134648821;
	Mon, 23 Sep 2024 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105681; cv=none; b=AW+KW+iK9+3soBtYgP7p9A/3lPF7rEsSBvz2uyldq8GUFJzHo8CmIqwvToBYZPkyKRJf7qQAjdoX5IA/NS9Xbf24dbBND6FS1oJE8pQ/La1D+9V4iKyrB+DYE5/WMmGqYeVewJ9dilH1hOJ0SZFgnnmcR8/o6x9gXi89NorhCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105681; c=relaxed/simple;
	bh=1ihrzNsoHedW5QPdykkQhnC8mXnzUD4yi+qABSdH45M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ks88BXFNvCn+VyhUEZsCFhOEoOyeyXQxoIxvi3vCvMiopHFn5/Azzo2c+HmsNLjL32JNVz9YsmTyT9Dgc3epUMwIIEO/6l+qHRNUNWzZqK8okkBNDWY7yUF+GtrGogkmgGSXhEBZGzT+CXxVO2+2/+U9usLUDnTEVfVGwVj/GiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GtPndt5U; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D484740007;
	Mon, 23 Sep 2024 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727105670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Shl/P3rqF6pZR6bKikAxoyuuEMEI3xU//Kez0cGjkzw=;
	b=GtPndt5UFh6yJ72Um4s3NyDYRWjI4Duyw6di438owEeCLouPGjxXaYob65CjbiSrEJiS9s
	RhBsyaEY+uHpMVuA6AblLHxMaMA/5LHnhafn08qqM6ccR8E9ZZHyu1B6tuVx57dRrU9ofb
	v7A0xfBiy0Jdsh0i02bCRCnRvsK34CJrjjGAgYQow4Wf98VYOMoX6BxzEts6N6kXtQwxQG
	DTzBRBI10fO0jGN9gTHdys4uRdwWNlemWxAXxBn/bd7V2h8gLOqdTnia0c0EofYgX0AwGT
	JH9pcHucscDwUXr0A7nv2DU8zZgF/9oJXfLzNVaDVQ3p9Z8LdHFaCpfgvw6HAQ==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kyle Swenson <kyle.swenson@est.tech>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: tps23881: Fix boolean evaluation for bitmask checks
Date: Mon, 23 Sep 2024 17:34:26 +0200
Message-Id: <20240923153427.2135263-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Fixed potential incorrect boolean evaluation when checking bitmask values.
The existing code assigned the result of bitwise operations directly to
boolean variables, which could lead to unexpected values.
This has been corrected by explicitly converting the results to booleans
using the !! operator.

Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 5c4e88be46ee..1a57c55f8577 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -139,9 +139,9 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 
 	chan = priv->port[id].chan[0];
 	if (chan < 4)
-		enabled = ret & BIT(chan);
+		enabled = !!(ret & BIT(chan));
 	else
-		enabled = ret & BIT(chan + 4);
+		enabled = !!(ret & BIT(chan + 4));
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
@@ -172,11 +172,11 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 
 	chan = priv->port[id].chan[0];
 	if (chan < 4) {
-		enabled = ret & BIT(chan);
-		delivering = ret & BIT(chan + 4);
+		enabled = !!(ret & BIT(chan));
+		delivering = !!(ret & BIT(chan + 4));
 	} else {
-		enabled = ret & BIT(chan + 4);
-		delivering = ret & BIT(chan + 8);
+		enabled = !!(ret & BIT(chan + 4));
+		delivering = !!(ret & BIT(chan + 8));
 	}
 
 	if (priv->port[id].is_4p) {
-- 
2.34.1


