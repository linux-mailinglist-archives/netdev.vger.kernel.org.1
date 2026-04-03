Return-Path: <netdev+bounces-274878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI9rKUNDz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:34:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46728390EBA
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 185BD305B5F0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C95207DF7;
	Fri,  3 Apr 2026 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFp3sQOD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19978355F36
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190775; cv=none; b=XsFej7GE5tbt8zvjsjPyCWQIQsqzmezJRSnQ4xBxeIYaMU9ebsfN68mQxNJDCUWMcoIipomlJI+puggKyk2FcTDXErNdXqFfyFilO0SmK3ICV++VS/AEzgngnlSgSIIiZmoHUEVd8t+NMG2MZM26JNY9kR1BuZym+ATAcngYw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190775; c=relaxed/simple;
	bh=mxHgQ/mC4zuMzQQwM9oEWP2Y+5peuHhCCYbO9OpBZlU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uFxuyg6aGgVU+NdPwXS2jHuc04WOZlqWr2y6O9S2tCZX8t+Qy+UnqQHBIFNLiPFXTPcpvLHWyKKodVxm68+DiB9/nf1fSH6LIQoDPl+B7gqZuaJ8eJD3NfveU/djoN8cYJpTKahkwHmLrKJE2pW8dobAlXoPj6S/NhDfKBU5J6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFp3sQOD; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8a0ef4a7021so25009666d6.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190773; x=1775795573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1rhXDS3WrBPEeXWdLc810CtUcsfxLqQZ4w3SZY4Nfg=;
        b=jFp3sQOD8yEoodCmmmxaOe+x4zXDsKcIY6mEMGfFqJxpJHV6qHigdTHJj0Vlxw4l7V
         HRShFGFSoO6gWbpB9wvReu8w9pyQhI/ZbbhTQVmWL+2kx9nQgbu6kURF+gtdFC9OCjnU
         AbST7HGUdFcZgZAQPkyBlM+Q+IsqotY9YArTIblaYHc9JOVe+0AgVxEHCjbKzoYuJgiF
         0/9JTDxZGXiWJUU1nI8PA3wulCBJ5wXonUyS/0c3LTeCJwFALvkCkTg770zu55p+u8B4
         38dJvMA9083Yt9w2/sS/iK1eRRR6SrxtnmGi1WP87bh2u18v/sNdcIC+HjbqKcSlMUtR
         YfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190773; x=1775795573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1rhXDS3WrBPEeXWdLc810CtUcsfxLqQZ4w3SZY4Nfg=;
        b=gRomifMWwQ/lNH+qMFapYnHY7/rpQ3tp2weJlR8fjXJdbWqic5PtFcrNSvNFIGLHjq
         VI+G3OnSXAKktEyuMTF4ME2miYvFQ1juPvPqG9W3ntkt88cesG886UxO5x3c9hCRrHqX
         EgTpyqwO/ZNX0XKs0s+il9eopwcDNnc5m0bA1q7b28MLE3UIAAtAd5jdF1BW/am6EJ/j
         QLMrSLtdPIn/OoQkUlof3Zjq+OI8hBXDTTLnusiN7Xs/Cxuj7aIxCiFwd7RGhSNIkuPC
         e2xARx52Y4hFMZPMCHbnp43szlecb8YT6+EPHTVXy2fnuTKVntQsYm5X1T/Bcip1TZCX
         60lw==
X-Forwarded-Encrypted: i=1; AJvYcCWglsQO2n46y2jiretYozo3myRPKRKXZfvPLjGRBBROkmrH01aTQEFrNDZqiXQlylPfOTMRgMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8R9vkMcTxXwGC2BKsZbzDIzrSQIt3i2IL1URwYwIEwsnDOK9
	UH0bohdlxa/OUFPN45Kgnv8wWrkVBDwQf3exXjCcdlngBFSGnaSuJDB67fFiG+W6cGzGquEekcV
	h1tJP9dSl625vbg==
X-Received: from qvab25.prod.google.com ([2002:a05:6214:6119:b0:89c:e38f:6b77])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:8081:b0:8a5:5a37:511 with SMTP id 6a1803df08f44-8a704fa05aemr23569586d6.42.1775190773028;
 Thu, 02 Apr 2026 21:32:53 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:36 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-9-edumazet@google.com>
Subject: [PATCH net-next 8/9] net: mvpp2: use tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Antoine Tenart <atenart@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274878-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46728390EBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We must fallback to GSO if a TSO packet has too big headers,
or risk corruptions.

Fixes: 186cd4d4e414 ("net: mvpp2: software tso support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Antoine Tenart <atenart@kernel.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f442b874bb5933b298773bee7e6140e753bce013..6a065402f62605a9333c9050cdbb793ce547e74a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4318,6 +4318,7 @@ static int mvpp2_tx_tso(struct sk_buff *skb, struct net_device *dev,
 		return 0;
 
 	hdr_sz = tso_start(skb, &tso);
+	DEBUG_NET_WARN_ON_ONCE(hdr_sz > TSO_HEADER_SIZE);
 
 	len = skb->len - hdr_sz;
 	while (len > 0) {
@@ -5795,6 +5796,7 @@ static int mvpp2_ethtool_set_eee(struct net_device *dev,
 static const struct net_device_ops mvpp2_netdev_ops = {
 	.ndo_open		= mvpp2_open,
 	.ndo_stop		= mvpp2_stop,
+	.ndo_features_check	= tso_features_check,
 	.ndo_start_xmit		= mvpp2_tx,
 	.ndo_set_rx_mode	= mvpp2_set_rx_mode,
 	.ndo_set_mac_address	= mvpp2_set_mac_address,
-- 
2.53.0.1213.gd9a14994de-goog


