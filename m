Return-Path: <netdev+bounces-269166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPgYI7b6umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:19:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 241412C1EE3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27ED23197262
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF803F8816;
	Wed, 18 Mar 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="P1ZY5xpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300153C2787
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861238; cv=none; b=Il7XAcGQ1stem62wsViql04tREiTwdoBoWsrIZ0yY/OosWJrOOPaNXyG+j+F6Qej9fyrQ6auCEDVQsTS9HYbqgYMV4iVavL2MY9yHabk88uOuParAMS62VFzl27BlpLXGV24cl7CdqBabapaC8bz/2w/zWXWWyISeugwbGSnCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861238; c=relaxed/simple;
	bh=92aqkYJ0b5GlsxkwOgN+ntPd5LTvqgJxwBWqWknd7Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXnsSGYWkn75nXgez+FozW7/uyCVc32hwHdUNBf7EV5GcBQXnajmOHqZHub0Swa6qIlMPKZuXQIG5iwbm08yobt+xT5R+GOPc5+zO6vlyzc2Cl8eLzHRIAORq9eTDfA/llgqFR8ytG8kRS2fAAwpFZh9/ZGq1g3ooXxGoJ8Xs+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=P1ZY5xpd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829781b2b01so186180b3a.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861234; x=1774466034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1W18gZ6DTQpQ6YetxkK8bSGbSnx/tyFrgmhuV+UxdE8=;
        b=P1ZY5xpd1+Fq7EEncA1vrMQYR3hMOLllB3OD5ESebPE7CmC3Kdwy5NvQL8JTLu3af4
         pKm/EvqjCPsPaxesi9T4srYqxUgHrgSg1lQCW0SkrrKWuZEsaebpJuy/xQZuMG5/dRkt
         Tp7r6L/LRQv9Wj1G678cJFEDpwPlEisumvq0c1REKQk8Scm5ByW/eXfQke4a1dAkWr2y
         TZm3rCqEYEIJUS4SoEFGmFQxR7WRqhhnOI3EHFHoaNvp4/Whyqfi8TYvigutOvbPaA/w
         vra1ke2ja2hlHQLef5wNKmZgGG4qPN4mRwDk71hudwGXGrknX/WV1RVzaQqK0X+naFeO
         YzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861234; x=1774466034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1W18gZ6DTQpQ6YetxkK8bSGbSnx/tyFrgmhuV+UxdE8=;
        b=OZiwHWQtUEQr6xhFmpu6tskH8/htJzKZ2l/44zuTz/6kBKBpSUVZdYX9fSJwr+Undh
         LAPnUKDaIMyL/VJU8rt9syh6g6QnrnLmItPx8PSmWsg9Q9KnwpkCalFWu/CbsC/VJOl3
         0TI55dIbNRW9xgSlz92H1DwQw7qdbKINvljU8xF143zILi/mkK2/fE+guADlkgw88RgZ
         c2hpFzVarWeM9G1nh9LjW8kTh8CwYY5E10VtlqfcIl4vzCgn7+AymwzK/dWg/BA/MDp+
         DymAOz4VoFrDuQbogJBsRL9t3oc0oeZ1w5LKVHpsp56LnndPAh4OgmVY8OpKPI3pFAMd
         1tFg==
X-Gm-Message-State: AOJu0Yx7nZIyx56PZVAPCJL2Jwyv6APAzvezcKyrMAO90Af9gSJ7nmF/
	45BBbu29+5g2GwdEy0Ku5LTIX/xMqCioDGD9RejxfbkBtjO78axMzNumuRCO+r8iF9Y5Bx6kogv
	8udAlfZU=
X-Gm-Gg: ATEYQzy+5EGnLKlW/VnltmWgaGKIUNrEfb1TqkhH1azWhV86kXp95gfbklb8JbKkPyC
	eJLKKYX1PhHufBIdbBbPSDeUwSDPkFrAjXmnVxg4Y1G6UEhPiJIjb4TmAlohsEZpaEVKuim072N
	LL14pVo93mETO2u/YIOQkQ1WOR/DjR9edjUyfbU8CyXLSeljCokmDSp+8MZkGRaMXL5Cw2Wp9Uh
	zeh0sDvZr08UhAuHfxcjGKy7eIPbRsRRtX0YlLOm65GKSEjXWHIYpnBcEibkTUcU46Qz3YPCuRk
	e7IXidlmOJhQgQr9OZz9ZJhyhgiprTsZicR/+ROpGpfJpzMxHy2RoW9dqSN39wyMiKVXMSzSlow
	37BJafucLIS7xtYn4tPXK4Q+Mim156ooh8warRMPaL1Hng0gYxjPpRe546eW+8SLDgcWcBpzW/a
	E6TfE=
X-Received: by 2002:a05:6a00:8017:b0:82a:18a2:91b9 with SMTP id d2e1a72fcca58-82a6aec1431mr4178624b3a.49.1773861234007;
        Wed, 18 Mar 2026 12:13:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b58f7f2sm3902845b3a.24.2026.03.18.12.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:53 -0700 (PDT)
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
Subject: [net-next v3 10/12] net: bnxt: Dispatch to SW USO
Date: Wed, 18 Mar 2026 12:13:15 -0700
Message-ID: <20260318191325.1819881-11-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269166-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 241412C1EE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wire in the SW USO path added in preceding commits when hardware USO is
not possible.

When a GSO skb with SKB_GSO_UDP_L4 arrives and the NIC lacks HW USO
capability, redirect to bnxt_sw_udp_gso_xmit() which handles software
segmentation into individual UDP frames submitted directly to the TX
ring.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d9ca4933ee62..5c3b3adaf701 100644
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


