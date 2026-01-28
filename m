Return-Path: <netdev+bounces-254139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAK6KP+6eWnoygEAu9opvQ
	(envelope-from <netdev+bounces-254139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:30:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7E29DC0E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FB253004D87
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF725FA05;
	Wed, 28 Jan 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiG3Vls+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF872C326D
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769585403; cv=none; b=kmAwbMReZxDsI0NGHjdsr39fif2Wzah2E/5F31jugP+1IkFRpmEpgX2LmTx2akjGZ/c7XHY10JSgpiG71ybmUtC/EeYUUPACG1F93Zor/3YphPWnwMXxj2y+GVsYIFzy080AJXTOYnx08ywXE09UAPgAw2ooAdTcuGsJWLakSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769585403; c=relaxed/simple;
	bh=RbmYS+GbmO5r9aIsVbkZb99LO5fpXfIwGvbgj9g6qUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MarlqCAHo2EBErNaVFsttEd8rtbcqAiOcGvJkb/c5PnzEqYPHUFz6/lXLLdA7wFt+5yFuW3hAeVhSfhpMqoMf8iD2+kEvpHI+AcIvi/sWifHkuuM2LIjc4874QAxp20jZQrdRZTaEPJ7vE0Uqi8umyZY/UC6j5itUfMZXy0cACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiG3Vls+; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b720e4dcb4so7012418eec.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 23:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769585400; x=1770190200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB8/RdUGEfLZjhmXdp52kQTD2QqD1w42DdvzuHTbkg0=;
        b=CiG3Vls+Gur6TkGzuxkU5VbfbW0xWzRr7hlBQK2nVk3UqkM1qXNUEkWJ7DfnVU9o7l
         PH5B+04YoiALU8upVf7QD+sLMr6ntIwTKGngF3/GnJ/W8Z/HRudS9wQti/DEWy1JtHo7
         vrMzoR7xRM8CUTP6YMnUQgi3AO5N5L0R21tzO880Rr4tTQ8GAorwiEy1QpG96RPzAYjG
         Jr8iMPexAoktaiE+/F/NRo5aH3mXeGmTHAjQSOX0w51N3CDzLBGX1ZgnirjuDmpHmMT3
         tVMgP4H9T7DIDdesVliTpll6xMEE2wd8dW2RnoPNo70UxuSBlQ5Hcy//nTeOjG/W1Pmj
         gbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769585400; x=1770190200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yB8/RdUGEfLZjhmXdp52kQTD2QqD1w42DdvzuHTbkg0=;
        b=SQpa+s65l1xiO8eeYr8gNN0PyUG8GcMDDryWolvVDV7gfMgYJ4jz+MZGZuZ7l98Stw
         quHQx7KTO72l2JpMtVMOc4d+dlol4v8k/k5N0mOOTm7khTWLN49Cczps/EDBHHWjOWu5
         NfpyAO8FNHPl+a2cBJodgFEMKurwd4E0gtMFPhU8o0e6E2P/noy10IXp0aCd6zS3HlO2
         qPotl/ukpAT3UD0/dSzJHpmXS0o3IgR3wMp1UtqnCEFvk6ibDdsUpv7TPMAHdBpw3lsE
         c5RIlqXNmoTdcocqTzzsmPyOsjSmwzVqJxMvBOsl78A6eIm2zyrZCShuFohw/QLfNIYb
         ancQ==
X-Gm-Message-State: AOJu0YzNtUPDOMsYWboq9Md/QopR9oM3HTXIID7+qLYCsVOZw+K37nLP
	V1i9/xD2u2Fe9OhrytfsNpFa1iztL+fsh9J6qnaOtRy2gagBAAJ2SeLo
X-Gm-Gg: AZuq6aL5hnosQcEZQEafkcLzK8cCl+LTf8OtBpgTyCTbDPpEgmFWVr6Dslcm/zlrGmk
	4oiEzfUAesucVe12zbxJBMi4zlFyWFw9b7U+AfkJxq4jT/cbmmnW2soYsBSTRX9BszabcXzoR7A
	mKsWTgWikZmQG7gHwk+k9MatZ0mEj/dmczMk0HEcC/VXMFZ4rHGAv/imqeKZs1fVERhQACB2A5S
	KubGwXRw+7MRsswFdaXFPn7+vICYgJtC7zgauStn6Ny2TxEsirntcC0yHMcuDw8FDnUSbLxAPfv
	aY6NG99VE1YaRu1jgeZAZnBO1eFoo4lwFclQ6fKwXbacSnNIb6kZ2ECOh3qgB4Ek/bhHw9w+pco
	mp52j1LKoa8GGnCSLLZA/jZQj/WYAhnBU1mMhkscRlsNG8qunkGlZpXnAYfaSMgM1K47tzQ2rhq
	fmecXmyF41Ee7+Ikw/wNyt
X-Received: by 2002:a05:7300:cc0e:b0:2ae:60f7:7f42 with SMTP id 5a478bee46e88-2b78d8df584mr2785650eec.11.1769585399859;
        Tue, 27 Jan 2026 23:29:59 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add66fsm1479966eec.28.2026.01.27.23.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 23:29:59 -0800 (PST)
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
	Yao Zi <ziyao@disroot.org>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
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
Subject: [PATCH net-next v3 2/3] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
Date: Wed, 28 Jan 2026 15:29:28 +0800
Message-ID: <20260128072931.875041-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128072931.875041-1-inochiama@gmail.com>
References: <20260128072931.875041-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254139-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,disroot.org,cqsoftware.com.cn,bp.renesas.com,bootlin.com,linux.intel.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA7E29DC0E
X-Rspamd-Action: no action

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


