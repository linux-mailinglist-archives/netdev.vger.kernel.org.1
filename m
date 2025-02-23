Return-Path: <netdev+bounces-168869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9B5A41246
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 00:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D7C3B19D1
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B9E2045B6;
	Sun, 23 Feb 2025 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DX5BZ2v+"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9415666B
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740353822; cv=none; b=GFzu/bGZNhMZda5oIhFEwJ53da+UV2w0X9cb00EHyVrRCBmeSCOnoHz2AdjnPN8wtuB9hgAbYh9fUEI9kdTu6Ws5EdA2qFV9NMbDi++GuZevUxX36HfQsZc0j8p9ZZj0E24WJZLtykKcX1EsUTiYwkl7f6mdeR1D8KjSpdVQgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740353822; c=relaxed/simple;
	bh=Yop4/s+Sou9hbYrxOiyrJs6aEMFpqGj2bcNw28tiP8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyIGdeU1tjLtCBdAgXyKPmMN3kYJiDBup+LBZy98eJWQCtGh3ugxjin1kJFZoCUmz8V4N2LF98gxjLMleJ5Z5CK+EOXGb17yljEWGPCRoEF94Yau+EDXA1eMHrEy+U9SpcOrO3mmhXgbLyiV9mORLaPEEF4xCIO2MM8vfYpAeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DX5BZ2v+; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740353817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=grsJR/twTl2brq13919098Zme6VKzC6hvEwh05sMYbY=;
	b=DX5BZ2v+mQUIlO/ehTV1XQALgHmqYmtHOpF6dwJ1+9U96jvcS9z5JsD4ftaQfWD+PNKgOS
	RajwQ2m6VmvKQ543blqvE+cSKW8YZW7Vs3kcr5hK/Kj5ctPU6eJDyvZBFaZmK8lMGcZsfG
	O7tDVlE5LuokcqU7y1KrrR0Qnd67C50=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: renesas: rcar_gen4_ptp: Remove bool conversion
Date: Mon, 24 Feb 2025 00:36:11 +0100
Message-ID: <20250223233613.100518-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the unnecessary bool conversion and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
index 72e7fcc56693..4c3e8cc5046f 100644
--- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
+++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
@@ -29,8 +29,8 @@ static const struct rcar_gen4_ptp_reg_offset gen4_offs = {
 static int rcar_gen4_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct rcar_gen4_ptp_private *ptp_priv = ptp_to_priv(ptp);
-	bool neg_adj = scaled_ppm < 0 ? true : false;
 	s64 addend = ptp_priv->default_addend;
+	bool neg_adj = scaled_ppm < 0;
 	s64 diff;
 
 	if (neg_adj)
-- 
2.48.1


