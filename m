Return-Path: <netdev+bounces-283751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEBkLmda+GlStQIAu9opvQ
	(envelope-from <netdev+bounces-283751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202FD4BA4B7
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E8D930038C3
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A7341649;
	Mon,  4 May 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TMaUSw7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EACA33F5AF
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883743; cv=none; b=EImF9He2DGaM2N/jhLPNNiBjVGIFoOao5pkP9L4S6eQxMXssVH4bgbuFPX9NiX+F90Upjg5yo5IZ7mP76BUHbABttRp7hvKmlMAb6ucqpRdC4BupnG+0UD6kNbDY0jW2x9p5AtLW0wLP0bSvoOGAik4t9DsVxio2BF6FKxWi+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883743; c=relaxed/simple;
	bh=EwhH9FXEY9eVVemYnG/Nfy7it7hYxtfZFl85HqI7Tio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3RB5a+0KyU5sZLL4FaAMn34+N6b73yhsAwqnETUrrYPnqZmXyPqbDR7Njcn53h/vbuZXiXMH0A5PgBEqGN0+m59UKF34OPSr4W8xxX0Q9YY6j+z1Lhn1nRhS9v/22W7r+T8un1Ts0QI7sKHchNxPjki1L9xzvYt+PBdD46jZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TMaUSw7H; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3651fa24c6bso886661a91.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883742; x=1778488542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIxWDMsu2UiPW1jAs9ldQ114F/m53NvXkcrgAbkCly8=;
        b=pHHWPnUqR1LErDPuU99l0RNWDvvRjQZubH4vojwliMFdkW/OXq3lSzNu4jHFOJLj3J
         x4cVu4nXnWrrEHFj/s7CSSFGcjhH5vFXWO75rFj9+IdHg1udgxxr3RABCcTwD9pvA/K/
         8nQP63pxKlf4sYcUYi1r7Up7KIXUeM0gx+E7g9a7ZQLqfP5O04ZGy/k44GbDpTevLO/u
         dwgd8BY7PMgLsXFXS2/t7XtLUBNDh4wZvSjBsZW0D6MhbpIfyOL6hqVuv7EUIIpGw/Lb
         ZdDt1GgZDfIW2tcrncmeqmpaZk5sX+ALYeJoByCG9nbg833/1F8ZcVIC8Z1RHe3PG6j1
         3bYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/B1pwdj7aG7mRO6M8g9HvORAIdx7EU8JLe/aFODYkYgsj6W66+97Ym6TUqKvzXl3aUUMR/N+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfjs02nejNOzjrvvBltB/pH5yveNtPu0i5aQDh26TEzGM5ah8y
	KLjUSWwCxvFIIAcDAzTNEnnri8Mu+H8q3m7hn0AFO2pfLtEP6OSj/n62TJd0dTpG31Uu+EXDnUv
	C3ZDkApz3htp/hDds1tvRC7uqonIHnKVUaLTfZXMzBWeTU2YK/TPIv2FmmHtY40W3RZeaXpeoVe
	kAxUYoRpp02cJf80ZttxlCN44s5PbjQNu0XS32XBogrd3L3axLrWY2iJ/QLUmRcyORqW2mkECiS
	LgviQROPzk=
X-Gm-Gg: AeBDiesNg61pFnYdVJMaDUJQ7ZH+ua9cZwcMHNx4c9/iSzE0Y/pdedHyrwgu9yexWf5
	ZoVDZqsg71DIDK5FUfO9w5CRFhCeTDPB3O0TNOSY8Zn20UZql6uvZjMZ6yzSNrmTpDq8G/Kkh19
	Cfazh9naMVhHooWpoNaZR+b8VoaMMIsDWQgAwJe972G6fMGYW2yc4lf68knNHoOLg/iQColDo9R
	UrjPmA24Q3o7aBq4uGlp4aK5dGdMSMfID177JFWQinKMz2Z8/RE2tjP/AlVAcdyYUMaHVN12m72
	pPgbFQ8X0GqfddYIaRWm/sl8e7ZcXRxMCHcNlmzBByJS+WQzhwUgSz3Coiibbxd+wumHU4+Elcq
	TK2XHRh1Plioa52qkVvW0698K1jIH5kmiYuf4Gvb+0uKHAYrSA2DZzwhkWqY6LASTEYaRin+x2U
	9TotkTkgRc5sCVwo+BU6b3U86qdCZUg52yEM70oCgLd49880DuOgEEsZ5XWr21bwt3RF4akw==
X-Received: by 2002:a17:903:2990:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b9f281362amr84719055ad.36.1777883741812;
        Mon, 04 May 2026 01:35:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b9cab81ee8sm6184865ad.42.2026.05.04.01.35.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 01:35:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8375e2df478so240047b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777883740; x=1778488540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIxWDMsu2UiPW1jAs9ldQ114F/m53NvXkcrgAbkCly8=;
        b=TMaUSw7Hp9TF9sHpOG3MsraUe6SpBHuCayl/aOjTLHtjZsYwHApt/hI0rxezjdkhbd
         v0JwLJWVhWZvnL1v4EfOFRbKcbEDMkTPrSPAKVdQ2Mcxmciblio+mDMmJazF1CdlaMBY
         b5Km7LBot6olDK8BGd3+defo8l6Nzu7v2Ztos=
X-Forwarded-Encrypted: i=1; AFNElJ9e2WAuQk4st6zYnNX0jpkoMuRIlQF2aX6h7VQMi97EVJ64YQT82/Ol+LM2gUqyyIhLizIt6x0=@vger.kernel.org
X-Received: by 2002:a05:6a00:4099:b0:837:a211:4ed0 with SMTP id d2e1a72fcca58-837a211542fmr2781552b3a.41.1777883739997;
        Mon, 04 May 2026 01:35:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:4099:b0:837:a211:4ed0 with SMTP id d2e1a72fcca58-837a211542fmr2781534b3a.41.1777883739593;
        Mon, 04 May 2026 01:35:39 -0700 (PDT)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0183sm12539773b3a.31.2026.05.04.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:35:37 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>
Subject: [PATCH net 2/4] bnxt_en: Set bp->max_tpa according to what the FW supports
Date: Mon,  4 May 2026 14:06:09 +0530
Message-ID: <20260504083611.1383776-3-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
References: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 202FD4BA4B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283751-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Michael Chan <michael.chan@broadcom.com>

Fix the logic to set bp->max_tpa no higher than what the FW supports.
On P5 chips, some older FW sets max_tpa very low so we override it to
prevent performance regressions with the older FW.

Fixes: 79632e9ba386 ("bnxt_en: Expand bnxt_tpa_info struct to support 57500 chips.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Colin Winegarden <colin.winegarden@broadcom.com>
Reviewed-by: Rukhsana Ansari <rukhsana.ansari@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3db951d0c690..008c34cff7b4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3825,7 +3825,10 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		if (!bp->max_tpa_v2)
 			return 0;
-		bp->max_tpa = max_t(u16, bp->max_tpa_v2, MAX_TPA_P5);
+		bp->max_tpa = min_t(u16, bp->max_tpa_v2, MAX_TPA_P5);
+		/* Older P5 FW sets max_tpa_v2 low by mistake except NPAR */
+		if (bp->max_tpa <= 32 && BNXT_CHIP_P5(bp) && !BNXT_NPAR(bp))
+			bp->max_tpa = MAX_TPA_P5;
 	}
 
 	for (i = 0; i < bp->rx_nr_rings; i++) {
-- 
2.52.0


