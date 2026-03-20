Return-Path: <netdev+bounces-269935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHFQJUtdvWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:44:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B6F2DBF93
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D5463038411
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C03C73D2;
	Fri, 20 Mar 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="zT5IGejI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180573C6606
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017718; cv=none; b=DbdzfZlgbToPLcNVPihNOckmcOiveV8LjOU3SlSQnZ1rQmh6AaZ4/g+59JvMn51Csl9N9IHP56y6645iTN55VTBcTlvcmgtmDJpFbiGZzwtPsL0P9zzaFOqkLP4XWJvdiGYsFkyyGU0U+jhwz0hZ/9dACuneSSNyfPsJkezAA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017718; c=relaxed/simple;
	bh=gslBSKZShQvzxVkH6sGFPpyp9FY7xq0VAK5AjMnweyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmgVw3phsMfoV4/APOT8fVQOP7yq6/xVBCjmBJxGwJ9uOaaq3Me1IU9itEw0sWrqwQeGZl05lzUZAehHJK1jDTxkIMZX8KjHg1XKDh7sfuO59YVGHcLcxllLAcVvCzVf0LySxmod6LetiLML5omDD0VjTwWdqXs9vN30ZIE65dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=zT5IGejI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35a1230c60eso349525a91.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017716; x=1774622516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uAdY+e8gggzhdpu+gz9irB9nQPMWzWHkt4c/tYpJoA=;
        b=zT5IGejIHbV0yYLpKjp3nRqerevCz0auN/yEDyUCxR0BDGmFd1Epzlr/nJLIssbYeL
         EZ6d+mhnwoG7pntHONsnVe+5kREDturZeItZyUirGZF476Wk6VA9n0rNPI6heGoErKsq
         qnf0x2vwmGbtCshBWNqf/aKGIsDYhZLu2BY9U+sPb42TRo+wf6Fx5VayeKy937LGJh+x
         xiQYs47PrQ6rvSOFM9io1IUah7SvDUxMa3W+cbi69MI34v3QZszwvZh4k8ACHUYGUY0A
         qh+JkTde3txXJbQC1PU2PpvUyrMi9XXV5TEH9I92rAgf03eWNweffdVsbdMMbQ7zsyb6
         iYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017716; x=1774622516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/uAdY+e8gggzhdpu+gz9irB9nQPMWzWHkt4c/tYpJoA=;
        b=nJMYOwWe2gg6rgCevB4p//nCA78yjb7xgcKv2nM43O8zln974zRzDpBbSeC2ernXBY
         uEmh1J6/R5GveyKfaJg1CpMlglpTfBaT90BSPLDrTwxM28IIu5FQr7lRqbsVwq/4Vpj8
         o69X1xSBLb/5rzMTM218FBIb00A/IGzIt19NrmF4DXJEPQAQzjVFYjdAYXGIeUB6y7vU
         oi7wJjpH5JOPmr5RX7jYG+Dc6Z3JnCFvcK0Fsi8bFWzYjDj4dzQI1hPQd7+I+p9fPpqV
         Kmj8M6f3klMXbVATKo3Tm4J5KLWlR8U+DB5Jh8tLkTzHlRuuZ1Bdavs5x8muqP0wWPcl
         yP+w==
X-Gm-Message-State: AOJu0YzYqPx20ZYNiIL+CM8wbUQ6RLNS4iXl64G7PrWGtCqJlEv1FKx0
	Pe+oGFM6r2tR9KDDrfEMlWtm5Y4Y4kejf7v+8/cnw9clm3S7DjkOxKwSDEm2JKpOvbAGVY2BpZz
	u4bMpYZM=
X-Gm-Gg: ATEYQzxgQctRTQVC1I3ZUNjDLbTodbgby1BxJ2kaZCQVdsRQMQPFZ665GVoJcUJWZ/m
	FJZp6mepURgTsIjgnpkR6QLcSXmSaE1Bu6UyRldn6D1X8krAUei2/PPM8LR48qRY56HCFCwY5Gd
	FpOupdr7M3Kdq8m2TReInYnTjRp051mPSilUJN88eJE/O4POcQtsTwy2UVmd/vl3RWtFum3xZK8
	KcqS0upeYWDTEwurRRr3pvxTFAvFBuJAcWX00yH7woXkVECHLuzQgSsD2B842JnCpRMn3gpHGvG
	rAV+JbdzlUNhxRiHA55rE/omRauQH+vG8YmxcWmG5utUBJfHXUVcgVfhmyS/6nIxm7gdEOKn10M
	2q8AlAGnEPhhEvP5agkSwCcaOHBHyEyWUKWSs9NsnAT5mtyjKdqDzhNMqy5TbvBffZJNxgw6UTq
	E2yBU=
X-Received: by 2002:a17:90b:5107:b0:34e:63c1:4a08 with SMTP id 98e67ed59e1d1-35bd2c98e30mr2359076a91.20.1774017716125;
        Fri, 20 Mar 2026 07:41:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610db9asm5592015a91.15.2026.03.20.07.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:41:55 -0700 (PDT)
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
Subject: [net-next v4 03/12] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Fri, 20 Mar 2026 07:41:24 -0700
Message-ID: <20260320144141.260246-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269935-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,dama.to:email,dama.to:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7B6F2DBF93
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
index c982aac714d1..c9206977fd54 100644
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
index 90fa3e93c8d6..8147f31967b5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2950,6 +2950,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp);
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
+u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
-- 
2.52.0


