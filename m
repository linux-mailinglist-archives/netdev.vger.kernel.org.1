Return-Path: <netdev+bounces-267990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE1VA8tWt2lsQAEAu9opvQ
	(envelope-from <netdev+bounces-267990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:03:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6672933B6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00EB93039EF8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32E712E1E9;
	Mon, 16 Mar 2026 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2Z5zFle"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459221576E
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773622874; cv=none; b=NzGKK5VToAsSLWan7VqELEqFZZgva0fw/Ng3q8Jl2wAO8dFhklSpCTt+U4SLPAGF9KazGzV/83q1O52JnsVpAhcs4uW915EEPp4jm56xh32usbyt2PnP+zwWYjaxgg0klYQ9sUZ1CfUukQ9hRA+nwBf4XaoVkErRZndDBOP6xEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773622874; c=relaxed/simple;
	bh=3McREo9Kk2UYPLjGgyLNM8Spss7Ow8fhuceAlqV3l6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGFGD/MAVQhJf+aSlhM4LsKFJnwI5YXKFdqECpzdqh7dPr9VCjzPDox/hhFtMrPz42umMGGLf38H/n5RtF49ttayIs1OY0Ex2oj8VRxGpzFYGwURMg+dpOR6RaPK4qFiJp66lzgcluIn1IjwZDr/9LcHc/1c8yDZDXshKpANmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2Z5zFle; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82987437624so2085586b3a.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773622872; x=1774227672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB9g5jx+x167tNjxcGl7Z3iDMBhQp91ckzQQIEVj78E=;
        b=G2Z5zFlefQMMHbl+HaFSozcJ970IEMwR/eGgYoGpjPg8DTYA80/b7xeXVQFeb+//+N
         l1er5OtQLxHqLDr7pMKTN9ayuWRZjItIJJ8WA3xX2tcDfuWg5eFxT3+0Zf7lUD5LiO9D
         9WlsrD46kqk6H1cLkUmRlPX/A870Alqtw+FNIPKpSnmYYuBMceKGZXtJR5/7a1LwDdkD
         VvKck/dernJk5ygLQjaLsHEowv+XRcn8kgYXTGDXpsxlie/wBGsrneAzzeAXcYG7cx2Y
         TtD7WNmU5XgBb2Vbge6Em5vHtBHRspFmezbJjTYkS1UVAjpL+D5YL8cg6nrOuYKDinK7
         xkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773622872; x=1774227672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iB9g5jx+x167tNjxcGl7Z3iDMBhQp91ckzQQIEVj78E=;
        b=QjoliIo87ru1ngVvTSlHL3EtB5+oS9f8ye/Ri7H6UddNjLx+UUk+BV0tGQw0Vygy17
         DjMcx1dzNt1LeOPGtCBqKvf6NfCef1c5USnDbDiWeJhKwTpiSmjkDnFju6FeEwdrs5k2
         DXvvpGJIYNPIisYSciaIMSRsoXyQhOe0AP0HBDOU9HNllaWwSK4d9690ZT+MhIe7DYHX
         8TsRCuuMa6VjqZmY+jnn/b/PIXYt8eMkLDayZnvj09mb6OCSuuI6zYpMwputBRimnMx2
         V8fFUiMMUFVHlbamD0/upHDYzvQPR/5IRzHW5cOYd65jo/WhKZUIzq62JFUBjbbF7Ui3
         3Wcg==
X-Gm-Message-State: AOJu0YwFaKUwgoAE60W14brEn1My7ISH6uJj7eAxttF1WJbk7WIy5nhF
	yP4pGa5e2VQZ3VxBOBc05VALZhfJVx/ubb21FL1ea1Y70BsHKRK7UC83
X-Gm-Gg: ATEYQzxUhf9Jnd59N7gOs+yV5CNUB9HxjBIeD0LgciGZn0gE90k5No50pGdFPTvHsDz
	nbmIroC/pu1Zw8bQi1XX3co65rQ2SsN3oL2INiN8RRbYs4APgNB8Bk3NfwZfJzKcE7cWQ82RDvL
	0zKeOErrJqXQBsADsNMqcPgomgTybvdlchk8WUdbSN4/NFpyiXFm38FE53vJ/MMg/5wPIdLpbcq
	PIyjvmEKgfymj2cW4V98gB/bJgUOuUTCrqx0oJYRNNVBc5BEpoolZL/b+RVSS2lyQgVakiEt3O4
	ONqP5lVu7EARb3feMocIVNfiF8VlDYhMAzNsVS8rFqH/Fue4hfXM4PXQNJY5y7u6eXdyXwbUa3c
	OJifaPjm7v1QPwetE5h/2vXhMPisDTDja5P/offcmEp4Bbt5Pgcl27HUOT30NrMYCCXKtRTPfHn
	qiI4HSw3IM6QgZzO/vhobyHUmyiHVWzuUw5A==
X-Received: by 2002:a05:6a00:929f:b0:81c:ce40:b29b with SMTP id d2e1a72fcca58-82a193e89a5mr9456189b3a.15.1773622872449;
        Sun, 15 Mar 2026 18:01:12 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072419efsm12308166b3a.11.2026.03.15.18.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 18:01:12 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <me@ziyao.cc>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Zhi Li <lizhi2@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v10 4/4] MAINTAINERS: add entry for SpacemiT DWMAC glue layer
Date: Mon, 16 Mar 2026 09:00:40 +0800
Message-ID: <20260316010041.164360-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316010041.164360-1-inochiama@gmail.com>
References: <20260316010041.164360-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267990-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtv.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spacemit.com:email]
X-Rspamd-Queue-Id: 5E6672933B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a MAINTAINERS entry for the SpacemiT DWMAC glue layer driver and
its DT binding.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2265e2c9bfbe..dd72d26ac837 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24834,6 +24834,12 @@ W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/sp2*
 
+SPACEMIT DWMAC GLUE LAYER
+M:	Inochi Amaoto <inochiama@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
+
 SPACEMIT K1 I2C DRIVER
 M:	Troy Mitchell <troy.mitchell@linux.spacemit.com>
 S:	Maintained
-- 
2.53.0


