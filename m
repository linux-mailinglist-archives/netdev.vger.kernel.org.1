Return-Path: <netdev+bounces-274796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM/4JVYMz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:39:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1219A38F919
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87AE63072D19
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6E24A078;
	Fri,  3 Apr 2026 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="sOx9mtqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F312417D9
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176553; cv=none; b=EcXWlBFhAwllMu5tDoPZsXdJCrIMb/0VHIEMVA3lcbtGITLH9MRmJfZNA2tX25cebGqjyeAFuCopptab1O1mTjbquaRO+ceDs5PDe93XCIiXEqPmXPEMZtal1g6QgSKh9AC22pmcU9mCxgbXD1RBuOUWalgCAshNN2LRZ+0TiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176553; c=relaxed/simple;
	bh=iQ727465s3Aho370Tuxfm2rIvW+aDujPQFCVr+k8Ilk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcGv5QKli6cOHaqYFLQEi7PBUfzPPNnYm8E9iSIZmQTtvtF3uMsiEcpUPHF1zBHhBGWgGpITFxV08xW+dRYvfHP6JLaJbXeuSdQlWHL7yNwivHpYu6+nOmji5nYGdNxN+D9f8fnx7qb5oyRkjLH5GPX9R60u7nIyA5ptqCIAyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=sOx9mtqm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso830151a91.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775176551; x=1775781351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgEhIXxIJA8MtEOelbwwhwA4rZuHaEy+H8Ivt4MY40w=;
        b=sOx9mtqmUZ1YyzmzODrUx616tcpW7MqThgqv9tGCw4PBx8molycIalspUTCY/W86NR
         U15K9rV9/AwEVBIpg2MPZoIqiQNWXneO/Bbbpj8v822Ze2hndpAEg/UljqI6HXIgxlnh
         nZcx93oLF0fKDkEyZ0b9sgRvrtysOWgDuXdM3mwU5hTHvwlsh0nal5N93QIReUwM24Mc
         FWBZFj8Pb5q8yAvcld7wZluZGTnFg0cOSMA5CQKohUUAC0iKu0upVxyDqVvC+FudUdQv
         5PwHfEb3G4Hfxn6qERPs0SFD/87GSV6pmkPcooOIRypcF/BduevW/xq8SA9FGzy012NC
         dCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176551; x=1775781351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgEhIXxIJA8MtEOelbwwhwA4rZuHaEy+H8Ivt4MY40w=;
        b=tFLnpphTFeTJh/8G6P/D5+ehMX1/u0rZkZ98gh5wXH5LBG8jyzQsY7ftbUO/E3+C1X
         hhdPDzj4QFiURCl+QFO3qYo7Xq6vhmaAITrqDbCsdE0rygea5wvURMt5IpbvWjOkTTNi
         5I9Up1Hj40uKJuS0pnxmQxUv/Ue73abVb5dzitaDNj7JRbRyCemmvzvi/wSuKPfEUpjo
         FzHeGwxadreiR7Y2bpEMIitNShufn7B8u9IV5BoO/Z2+LwlPcrkLgJf3pavNLxo+I8cu
         n5mVwPUeRVgzR39f05hvrAnuza2mdkS/0UNhy0xQMNyZnx4LVRwpI5ScZIFzhQrVJgVW
         qljQ==
X-Gm-Message-State: AOJu0YyMS6AFGFR9e+WWVwFtOwdyimvgobzGFdcErpXksaAD350v1MH8
	jbZT8cTioB88981Z8Cu0+WJBLRJMbCD8OBw72V4Oo2cUHwQToo9uxm1u4tBiQA7HqtZPUDxVDJ5
	JsWkhSBE=
X-Gm-Gg: AeBDiev1GuoBWPTNvBhGZiUfPXHC7xrF7RealAxzleLIdRQ841IwRKkmW/pY6utPYvf
	xIHbDlMdEn/Bt7SPPuwv4Z9g8reb7OBf3CkQz/sIphC8rMQx4sKusOdp5NzxvdhWIsjiEa2pVx4
	PR8IYZgFo4ioVsXU2V95IdjoWuqelgrPxpqIlHmxdofOYbYN0+BwL4ufCKfJX8CQgStrZehG2Tk
	5EOEpbER93mkw3/9aCtjRZKkeDLzoUfFj4mpTqYXIJ/te83luAGfWjC8QYvJBvvC4HzzYD1NZap
	nARzN71aHopUmn7pDpOLabpHQRnPQbbxcd1pHqlCec0cpXLGVBU1Q3tS8S6gZcdgGpzc0bLdesh
	QexDXRNnNYmy3n6GdWJlzp+6TbmeeU7JzMStokHue1TmD/ogEGwVbmINFTfSUDnlubSfijeqz10
	34b/+PLIQfwl7CWQ==
X-Received: by 2002:a17:90b:1802:b0:35d:a559:5c0a with SMTP id 98e67ed59e1d1-35de597275emr783107a91.6.1775176550940;
        Thu, 02 Apr 2026 17:35:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd367bfb1sm4094226a91.10.2026.04.02.17.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:35:50 -0700 (PDT)
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
Subject: [net-next v8 02/10] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Thu,  2 Apr 2026 17:35:09 -0700
Message-ID: <20260403003524.2564973-3-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403003524.2564973-1-joe@dama.to>
References: <20260403003524.2564973-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274796-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 1219A38F919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Export bnxt_xmit_get_cfa_action so that it can be used in future commits
which add software USO support to bnxt.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fe8b886ff82e..d4288c458576 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -447,7 +447,7 @@ const u16 bnxt_lhint_arr[] = {
 	TX_BD_FLAGS_LHINT_2048_AND_LARGER,
 };
 
-static u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3558a36ece12..2b40a5bd57af 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2969,6 +2969,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
-- 
2.52.0


