Return-Path: <netdev+bounces-274872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJp5Ov9Cz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B24390E85
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A4D8305C3EC
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E9434DB52;
	Fri,  3 Apr 2026 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNLmMxqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BD33EB17
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190764; cv=none; b=szQ11RyvUgqplEURJjpVcL4/bgNJGzZuVQ1CuRpEzLu6TvpF/E1HUdbAiDcmmY8aTYKwqa66AT+ajWFCIGyYj+k/3g7uPsJLVByVw+GK5L1LeYJ3D9FhXQsa7F52fUvjJLh0Hg6ucRFRDuKtjdAE/H1W0pGHkwG0GN1BMYsQvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190764; c=relaxed/simple;
	bh=6P7WQCzUCugzqGWzY6HWr4za6D2G7bZgb1ptjzOP9sc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QW+tXRSCTYsp5KyYYr2xewZq4Fxry3NUUVYBsGtA6zVb9tZAKRwPh7yV+UwD0W0QZ6eifVtEfIsRgIQrHU/nURwIhDhFavVqA3ERMVyUkG3u1RtS5P1/TfCPUYUiJUqGBhdQYd9BtY7e2PrmziVFFLqavagaR6vBDcx3HV6uTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNLmMxqd; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cfdc479f5bso435173685a.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190762; x=1775795562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nm8W8xZfOSf48/wfAzjlndZfXj4u/rmL7wwjGtVwvrg=;
        b=RNLmMxqdx2hfxGeplQoMYpAZZt0/EhvIMwOp50qGq1TwGiH30OzJ3oJWMBvrNP58Ev
         ZnmS0ToWNmofNoIe33D6fklYf+ul2qRN++uDut90oEbwQ4MlR67pcoYeeyMZFMfCv9KY
         AIzZsdDqH2nSb02/D16aE6Cb+qbR0G6T3oU15M+cwKtO0bbVcxB38Q1Px9SvWJUDhflc
         AaC7sG+J7Xc2FfoYiQ3p2FBsPKJGt0COQ2EXKnOk+ngxotZkkhCRV9mTOgAtljJmJGFo
         nkDUNy5uI3xnsmW27+Mu3H3vpQILkybZg699TykmcOJQGcxdoEcyOSpJ7AphJzOyT+Ps
         t9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190762; x=1775795562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm8W8xZfOSf48/wfAzjlndZfXj4u/rmL7wwjGtVwvrg=;
        b=l6c7b0tDY693PQtmuQqyibNOLONPzKRo4ZietvoxQN26FnoQIz7NB4VybV0VHyd5Vs
         hLEjbWz2XYzKAv0ziH6PhXXd4teRHF+DdaieqY+pbuvv/Z3l5eEtmed+O69M8T5HUXE/
         2fF4r9ra7GyTikLDHu1J7ERPyqAdfHC/uQkdFlgNNjTDhXkQoKYNP/L2zonvw4fExndy
         9B0D9fnnfRwgekOn5/rNwxpp3KyGe/wnpxw0EaO8KIVjeztG7cVcUvVt5SAmCQoGj6/w
         RG1wJuLp1x21R8ZUvxLDO1YqSB31Muwq6juoea+FqKmBDn8LuQA7mvpqhIFEuuxqJpEG
         m3uA==
X-Forwarded-Encrypted: i=1; AJvYcCVtnHGKRFmHPjF9zx8eQ2r7N2rR/JEr+ICfNs79ekd1iYQgZasyDA4vWk/7ULlBnd2FTOpcrT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCewYpoXxGULIfRI4HTgPng5PTUZVtfxXhxB7w8psIIADQ6iN
	V0eMtGkK7iCUWWxRCEt438hQRrik5tREhvmCskGThFGggbnD2Lru5p6GZkfhDSjj7PSzTyx7mAB
	nN63zuC+dM4sAhQ==
X-Received: from qknpz11.prod.google.com ([2002:a05:620a:640b:b0:8cd:93cc:3c40])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:44ce:b0:8cf:cf45:1422 with SMTP id af79cd13be357-8d419963ad0mr279002485a.27.1775190762406;
 Thu, 02 Apr 2026 21:32:42 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:30 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-3-edumazet@google.com>
Subject: [PATCH net-next 2/9] net: mvneta: use tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, 
	Marcin Wojtas <marcin.s.wojtas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com,free-electrons.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274872-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,free-electrons.com:email]
X-Rspamd-Queue-Id: 91B24390E85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We must fallback to GSO if a TSO packet has too big headers,
or risk corruptions.

Fixes: 2adb719d74f6 ("net: mvneta: Implement software TSO")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0c061fb0ed072aa192a0c5c7a3209b045540721a..5b52e125220c1f293cd9696016b6ea527e6f86f2 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2823,6 +2823,7 @@ static int mvneta_tx_tso(struct sk_buff *skb, struct net_device *dev,
 
 	/* Initialize the TSO handler, and prepare the first payload */
 	hdr_len = tso_start(skb, &tso);
+	DEBUG_NET_WARN_ON_ONCE(hdr_len > TSO_HEADER_SIZE);
 
 	total_len = skb->len - hdr_len;
 	while (total_len > 0) {
@@ -5320,6 +5321,7 @@ static int mvneta_setup_tc(struct net_device *dev, enum tc_setup_type type,
 static const struct net_device_ops mvneta_netdev_ops = {
 	.ndo_open            = mvneta_open,
 	.ndo_stop            = mvneta_stop,
+	.ndo_features_check  = tso_features_check,
 	.ndo_start_xmit      = mvneta_tx,
 	.ndo_set_rx_mode     = mvneta_set_rx_mode,
 	.ndo_set_mac_address = mvneta_set_mac_addr,
-- 
2.53.0.1213.gd9a14994de-goog


