Return-Path: <netdev+bounces-171956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FCFA4F9ED
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083347A28DB
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BEA2045AC;
	Wed,  5 Mar 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="H1PWocbi"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05455204694;
	Wed,  5 Mar 2025 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166801; cv=none; b=bf+cPxugXo5E+Qjv3SycjGi9StS7iY9nwf5jp/iBYkLrLb+VrFlUubvLoga2Yw1hVGvySrZ0hISk0U4x+sk0GUz1715TfTS0+McHD0jznJBPW9rR20tfYxxAZNHv0Kn804QNstkrXCrGZcBjMNM+Gbaa52KCdLi4CumHYR/FgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166801; c=relaxed/simple;
	bh=oOiwk0+ykDG0cH/sIcmhEhO1SWlT49rvZjer1o8JnGE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QmuZjF/krGpYvprNrW+znYMREh0bkH5gMJGdyS1qNiiOHNOJxefLFdCHsZZYuToXQ89Yw/UrbdrZqTwysoPRDZmc56Kq0hMYGcAs1kltohXyD05i9zIA3t6HWVD/ooM3JYPXZsLYnsZUjFDJACDxIebgVjSrDoPoiNzP1EwMOjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=H1PWocbi; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id B9955C001B;
	Wed,  5 Mar 2025 12:26:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru B9955C001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1741166792; bh=plkR5jfwB7LHjAkxN83kzZE2Wkvvi98b7PWXv06ISCI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=H1PWocbi+IZnor92m38acVn1zi6V/rAiJ138FmswIl92hlJ3MUT93y/wk14KFYl9T
	 M+3aVeZw+54viHF4y2drkfjRo0qRe6zB5PGusoCJOh5cL/NAzyJ3toywYu84sa/r2i
	 m8CZqoh/xYKLUhNhPSNL4JUGh0yQzgXHm3racZlEWxKLK8yVZ3gvfA1CTrrHHxK4Px
	 gN1DRr2Afm6oNOuU/Oza9mRbyiad8FpyfVGbE8nVvgpKVFteKuHqX6B0yJbiAZnBqE
	 9GzlnuaBYHTqZXpFqIIS5sEePjE9ovkf5J2L0WCNhrEUbgMPcQvAOmmZ+c6OjJOwkW
	 8CZdW9Kzi5yhg==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Wed,  5 Mar 2025 12:26:32 +0300 (MSK)
Received: from saturerate.maximatelecom.ru (10.0.247.123) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Wed, 5 Mar 2025 12:26:30 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Richard Cochran <richardcochran@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ptp: ocp: Remove redundant check in _signal_summary_show
Date: Wed, 5 Mar 2025 12:25:20 +0300
Message-ID: <20250305092520.25817-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg01.maxima.ru:7.1.1;81.200.124.61:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191497 [Mar 05 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/05 06:08:00 #27609135
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

In the function _signal_summary_show(), there is a NULL-check for
&bp->signal[nr], which cannot actually be NULL.

Therefore, this redundant check can be removed.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
 drivers/ptp/ptp_ocp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index b651087f426f..34c616bd0a02 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3959,9 +3959,6 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
 	bool on;
 	u32 val;
 
-	if (!signal)
-		return;
-
 	on = signal->running;
 	sprintf(label, "GEN%d", nr + 1);
 	seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",
-- 
2.48.1


