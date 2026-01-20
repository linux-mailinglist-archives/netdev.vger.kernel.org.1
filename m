Return-Path: <netdev+bounces-251353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE4AD3BE7B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D15634C776
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D703563D7;
	Tue, 20 Jan 2026 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDIrnssH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572363563C4
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768883793; cv=none; b=RcaiajJtmz+xWaFHpuyF1HMJN+UBOv78WvS2RaZKGLQOxbSRaN2rzMiqgG2pEljYIno3MJIqW8iYT9xUUfFYsXd++Qn6S227IZRn3NykhmNLeg/NbCeGV3npynz4An26BCE5qcFq1pw8u4AFpc7N6/peYjPwKJGHNT0qOi4aCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768883793; c=relaxed/simple;
	bh=RbmYS+GbmO5r9aIsVbkZb99LO5fpXfIwGvbgj9g6qUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlRP12OLNcAL+LVzuPkvNMZ+PYuxeD5Qhm+w+Vk4iaN+rYXJhSzsUTwVJ3sZ78PPQjfrFsDbU4L9pzqvORSB9OHEB0qCh6rOK7PZaQky7zvNbVwGBpvPMgJzRC4s03QZMkZPG+WwPdkO033hzPPbuJy7MX4tGdi0cIHh+AX2/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDIrnssH; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso948874eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768883790; x=1769488590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB8/RdUGEfLZjhmXdp52kQTD2QqD1w42DdvzuHTbkg0=;
        b=fDIrnssHsZHhl1JrOcn8DT3G7fCEhTDqkTCHS/kruE5DdkNGBzbJskcjkpVIdd6uc2
         Al25X2f+DM6rXYGCeEk3f1URs566WG8zRjrj0Yn1HO1Gs/+X+Ruenv2yNjhxoNIQNAhi
         ONDG2V1qjwkGB3AUuXEvHd+UGzxip9nrhPmQTQ7v9YfGA2RiqmcWEUKEdKiacUyEMyVo
         DZkJLS+Ea8NXwENx3TbfMgBpdDQ4Ieh5nNksR9HUszR974MCHG6T6kqImpS47lCZB86v
         1FZQQIzcA3XcGO4StBhMaRSkZcDu6XQOVexIbZ4TnkHsAC8FHL5vxJKj8JxZgI+0ypog
         I/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768883790; x=1769488590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yB8/RdUGEfLZjhmXdp52kQTD2QqD1w42DdvzuHTbkg0=;
        b=oP/ZxK9tFrzIaoQMw1F4GasaWk+Rh7m7UWLCH5QZyUbPf3+nW1wzVxSklkq4Yc40n4
         LENMnH1a9L8SR5ERkfLIEBeJn+lFl4YMKlrlQynFhIRGslQLp0QzeFse1tDh3TWKPGLb
         qGZjDY8Ui6fhB0HJMiUlWqfNp68K61EB00NfIDvvFdo72NxBQnmKt6FKTJKc9H3xVDQu
         VvQiQCSETfle+N/SYLerL5MZvYsFKL/Wul5LJLYbLsmvmLTaijpasSfBSnsLQ1mFDKtO
         xlcGPJn3lEn6JUbqeFMqGLbOpJ58RL13+c5CFT2GXtcKMRUWuYXqrOpdza9+hy0Udad+
         alMg==
X-Gm-Message-State: AOJu0Yzp39fE68i0F2hzKWmFgqO0p1FxjRafCH1LhJ4JHUYa3+tJlz7O
	ceXR+fl1CYqz6vrg2jfavxcJz9KyNlwMXUcKObwWzXV28T0Vc+V2wX0o
X-Gm-Gg: AZuq6aIEIwdu+8n6HM/+r900m4JanfFGVsf8MjhFgN3DtVC3nCQQheLtaoKMFCewSKL
	/HqJn36Mx3HWBGFFAwwKQQaCoQ8Kk0DMuWuReYMC4kyQGlweRpkbAGOSr+oxavwi2nJgHVEfSBO
	+l8NeI8bkIlP5fXbP7UVOnUEIUR5HXfuqflYWSJLzS2cIxpzo/oW1xzQyNDyKr/A+W1DXFQTyKj
	xG2cVuRF6DSGkDFIBozPkIbuc62yC/Sf6214OMtCFY7kKiy5XVzGsLa7fwkxjKTGUS7k1rrQb+O
	B/9ASckdU9OU04X2kgr79gUlsNuTmNikp/ecIvH8Q5t+OawiTqHHYP8iERSyqXctHqekAhsaNRG
	S3yNZ4EBeBL0YY4lddQ+jNOppW699BH9P45z45NsVc2LyBNY6Axc/4dcE3IqAiwQ3KpP8N7+M8l
	ix3FKjRcpBOZvAvToFBtfv
X-Received: by 2002:a05:7301:9f09:b0:2ae:5e93:b6d with SMTP id 5a478bee46e88-2b6fd7e55f9mr304430eec.38.1768883790053;
        Mon, 19 Jan 2026 20:36:30 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6fc2820a2sm1030314eec.35.2026.01.19.20.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 20:36:29 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next 2/3] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
Date: Tue, 20 Jan 2026 12:36:07 +0800
Message-ID: <20260120043609.910302-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120043609.910302-1-inochiama@gmail.com>
References: <20260120043609.910302-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for 5.40a version that can avoid to define some
platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 8979a50b5507..54c7b1537ab9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -396,6 +396,7 @@ static const char * const stmmac_gmac4_compats[] = {
 	"snps,dwmac-5.10a",
 	"snps,dwmac-5.20",
 	"snps,dwmac-5.30a",
+	"snps,dwmac-5.40a",
 	NULL
 };
 
-- 
2.52.0


