Return-Path: <netdev+bounces-180825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98539A829B0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02BE7BACA2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47662690CF;
	Wed,  9 Apr 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="IdpHaas0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2903270EAA
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211081; cv=none; b=NSxlAB8orCu6SdjC50Sk2ux10E+RngU/G+wyn0TSanpJOf9hMYyMqX1D3b3rKGLxc5WKf+bbyhMUtsEucZPozYcrwDOu+oh8IwB7wZwklY/5nL1dtfkq9lq1kl+JxZ55RVj6Ezrcac5atRApMZYcfXorpQAd2PTknJQZvIbGdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211081; c=relaxed/simple;
	bh=tgttfTZZZ/D1hFSlmEA7nx5+Dpc/hGP/mG1ejsxckIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cYOINJagxm3qdYwJ99bYpHUVWi7P8qx0mYFEgqSP6fLiDDB90YmvEknx6hc2cI6sMh2uPxPhPBojKMQxo1UxQNJmd7Eg0zgHxmBhJTpQp4n99JBQLMoWUSXfTZeTqiywIrWuGmMI6+r01XD6wex8CM7A7w11CbTJwYzqdAdcE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=IdpHaas0; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1744211053;
	bh=IxN4o2EaAC8/a7bOCaNQcitb7gKd4FociPfhGKST1ow=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IdpHaas0EXLjur8Omy/uCvEYfqVxVca1y3prhnIVpWHZXy2EBI9fYknQK/CxEwIgl
	 oHh1thrcxPVKMm6Lmutp49qaYVwPSbD2m4eKeFgQdr+NKhKzm40CyXkNnqvOHqEnEF
	 lkngT53AD5phbx0dV9AbEoCjxG1Pn46ePGfojCeg=
X-QQ-mid: bizesmtpip3t1744211049tcd95cf
X-QQ-Originating-IP: GlsjGo+mGX6/LnF+FR9iJSbSTmDukXRKMBd/0qhvwpE=
Received: from t5820-2.fudan.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Apr 2025 23:04:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6662912278723557277
EX-QQ-RecipientCnt: 3
From: ZiAo Li <23110240084@m.fudan.edu.cn>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	ZiAo Li <23110240084@m.fudan.edu.cn>
Subject: [PATCH iproute2] nstat: NULL Dereference when no entries specified
Date: Wed,  9 Apr 2025 23:03:30 +0800
Message-Id: <20250409150330.1238768-1-23110240084@m.fudan.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NybhH3S+IWZnUgI4xEwCCU3QGi41XE6Z28jP1+0hk1ngfsRQ1hBR+kVW
	O7fj+cqBnJZQhRwLc4yvK6hqCse1SDPuAMB3ue+64Sww1fybK1Cch+2zOCdM1+61tcLURjm
	QIBtgSG3qUiAgOP6HedxrzrMlKWbjhnMnPOiMxmr6kHZSKojckUZIizv7YtpnWDd8lNgPPN
	q14/CXZt9vA//nBGN6H6PSl8D9rHpMt69+qKg/F7xRPLqYudKlDe42bYTYkxqEPC6hSEBef
	rC2sYzt+85Dnli88hIrgc0HB83DqAvvse2C/IxCQbTX6uUrbyVbG5WfMzrojh285eNyNDv8
	vENE3hMdsTmx3xj8eHdi7jYUrlO4w2dTcy+x2y9xrzwMQgNcxq0mOH5RD/8LWAQ77xS4LlO
	B9soB0oIk0gu1MAifEnYWqz9O0WeopjCfGMw3A3MyGtd2I65M285CNxpVbvnKLiLVrP5zsC
	IZ9W3lYCsVVqROkcVKzAkAaIkyWxZ8jtBldP1LpbBdZqZK64Fph5z1i37SLGPJfDIchAVq6
	jpaBF/W066sfJBVZGmSUw1fmM1oqUxZnd3ZH1TqeW4cuk2fAiTVFyLokiJR5J2fprv+2WUD
	MeqoBZSvjU9ixtxkAPcP/dpnIE5CQen4BLi4VhJUCK9iR5hvAeb2zednLGVJefl5/DpL/DS
	fQD0cd/56GHWbKViU/5axIHfGaNQyL/FvhSccYW76b4SKmZiOCqxkFdjzqAu4hmPmifT999
	ZoG18dSU2sYhuzVNXc/bOGWGHOSDy7Wu6GkRnz2lSXfmw0743fi6YjjB6wndJh2EZorYHMu
	0Ol/kqPTuPcS0gzsPP23EkaswG85n+jMs9wHPBSJLOad6Y9ENk8a0FMcvPAxYv0K6WdlEde
	Kw3ku1w1rb1tBscvosyVJRsBJCCf75hEXqYoHuHo3yHXmpeukV1GswOfmkFkZQzsibVjOb4
	12C2nBcVxdmV9f2itwh3F4lxSfuMJhCOyvGdwEVHCPX2jQ2cRsW/N69UqLPmQsICkouhpUJ
	jmK+LhbWEfJCNwEG38to+gljJW9UrgPf1pCb1NNw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

The NULL Pointer Dereference vulnerability happens in load_ugly_table(), misc/nstat.c, in the latest version of iproute2.
The vulnerability can be triggered by:
1. db is set to NULL at struct nstat_ent *db = NULL;
2. n is set to NULL at n = db;
3. NULL dereference of variable n happens at sscanf(p+1, "%llu", &n->val) != 1

Signed-off-by: ZiAo Li <23110240084@m.fudan.edu.cn>
---
 misc/nstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc/nstat.c b/misc/nstat.c
index fce3e9c1..b2e19bde 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -218,6 +218,10 @@ static void load_ugly_table(FILE *fp)
 			p = next;
 		}
 		n = db;
+		if (n == NULL) {
+			fprintf(stderr, "Error: Invalid input – line has ':' but no entries. Add values after ':'.\n");
+			exit(-2);
+		}
 		nread = getline(&buf, &buflen, fp);
 		if (nread == -1) {
 			fprintf(stderr, "%s:%d: error parsing history file\n",
-- 
2.34.1


