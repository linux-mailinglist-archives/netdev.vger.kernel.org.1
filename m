Return-Path: <netdev+bounces-270676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNmRFZGKwWlkTwQAu9opvQ
	(envelope-from <netdev+bounces-270676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:46:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F912FB836
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 811193063417
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6726F301460;
	Mon, 23 Mar 2026 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="VV3vU474"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4623D410C
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291164; cv=none; b=V1zgNEVgqjiqm94cepmgsHb+lQ2cKNB5u5CI7yz0koCDmWrtbtUearMjX+N2E5JX02PNrBpJQqJ9HG7Pcflbu6f19/yK2s9p6qKwtK0dlQHzcyfQF/Y9L/8Rh3CgyGd1TiS33m7VVfA9NBxFbocRSLSCj8nqcGNjmeoxJNY5nns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291164; c=relaxed/simple;
	bh=26Gn7eptKPTs+npX9YJ4COxYTU170O6WKZvrvc1AeIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sqwgb/byscMzNa1m3GFbOQhl1SMtWH99qZ63vNVmxFsH2G8aIRnaJXtADYAOnhOIhWRAXVZPXEG5gEKmDtYosi9ZtkCfl1PUmcHRsehLctkddSUb44Ya8tywTl5JYnXKggf+BFnIkk12Jeoox5Q0F1jjImdNANkPoOG8ajakRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=VV3vU474; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82ae379000fso1428507b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291159; x=1774895959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4lthBZB51mn3B4jVR5pG1aEm/L5AvpnzXFsSccuXTA=;
        b=VV3vU4743kT0nK03rN9s1zNIFIIhJa8ZnVTV1yo6OqWiEYIj0BiG4LJyQbPdM6ZkYl
         kZ3z6y2JEdlN3dBaFtgmy2wIlUnuL7eTQASdJ1ni0ZDMpXDs5a8WZEASrI0RYIKU8gQ2
         v5yFcDRXtl27ntYYxv86VquxMsHRvM+2Z90RoWFg3zlVYuLucHF73yB0ycDvj9o1hAPO
         pH3hK0gHHq2x3iaVMSaQxxMlR1cvWr7d87EzNRKTaOlXwVdYfKj6uyHHqcDOZNQKulOE
         NRS+UZZnrNU2hpdfTpmDusqfER1DTekMX91Kf+AObxoudBomHSLJyfSbVl/PAdIChJX9
         4mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291159; x=1774895959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4lthBZB51mn3B4jVR5pG1aEm/L5AvpnzXFsSccuXTA=;
        b=hA/wfIcLaKl8KNlSQtyRVExRB3MhhL0QxZLrF52WAqgTsXI/zWFdB4aYOLxIl6nXxC
         TB0WEuCLwjeP2VwWmr2HL42/m20nDEdSa4XSVSkNzWEZeYAhUwXuSprjwwFWbONZmZw6
         jWVaDEyQrTt4tlkn6W6hpf7IK1ewVQ53ca49R0TuP32MRKHQpjvmJ9KcVDa9Jl/QgxFZ
         /iDxb5qvdlmfxfxvTlKFmdtwjsFmRgLWHs4mARwfkcrNFWdex0qYVrISwEMP6lmAXkLV
         eegcoA4tZhnaI9KzfSGVzTnXBhRGa1a+eAl9tLEGT0Zx8+VRl/Z65gqZx2dwbJ3Y2wP+
         Gphg==
X-Gm-Message-State: AOJu0YyK8e0iZZbv1bliYmx9j5a/IUcw2/R4O60dOu4vc5ZhX7H4wl+D
	/Zo4c/9tp/MpvVIDLVa7/olPYn+s8bKI4/rYShvx9DILnu3JUHoF9aGHPVzEpzSypR+haLngJ6C
	Ex+qtVbw=
X-Gm-Gg: ATEYQzyMcybKB3cl4F/NlvSWKiJveNotoaxeldPSQUZlN2KyojeFpLHu1w1q2+Fncry
	IUi+0KqdKMSg1Wk45TXyiumdX7NClVekHdUoFWuaacWpg+lH8BIVKGRsBFL79lR80NJqgZ5apbq
	x2m3FQw+nv06QbUhN/dRDkB2XAJDN0QgKu0f/xsPteoCQ8GDYARUo6IMFbSJx1M1zPRwbXN4uLj
	m7U/d4vW9STJzQSuUbho9cZp/8MNuulK7/QXjKKsjCV9P7glToFuZyDHgP/TXcwyXvX4plGtVwy
	kPxJW2nA/PVmMnCB936b+ZoPEKTwfXExKdUX6/827WPMUg/BEC2Avv114uQHfO7Vmkl5vE2k3Kl
	k/W1vA74Bxl48BgwVNJTdCXoMexgSeHV/WPCvb4WcsMe2byNDplsdL+VSd7oVYZXpNgmUiAK53o
	i7mXQvq9KwXEnegGc=
X-Received: by 2002:a05:6a00:4207:b0:829:acf6:9406 with SMTP id d2e1a72fcca58-82c5bf009f3mr392659b3a.29.1774291158678;
        Mon, 23 Mar 2026 11:39:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc6881sm11664493b3a.22.2026.03.23.11.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:18 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v5 10/12] net: bnxt: Dispatch to SW USO
Date: Mon, 23 Mar 2026 11:38:35 -0700
Message-ID: <20260323183844.3146982-11-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270676-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,dama.to:email,dama.to:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E7F912FB836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added Pavan's Reviewed-by. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 40a16f96feba..737b64f8b80d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -508,6 +508,11 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 #endif
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
+		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
-- 
2.52.0


