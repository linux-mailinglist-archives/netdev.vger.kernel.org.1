Return-Path: <netdev+bounces-269160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAdEEbT5umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:15:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC672C1E10
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F8A304E0F2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2AE3F1654;
	Wed, 18 Mar 2026 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="i7USbMRR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B23F0A9F
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861224; cv=none; b=CfK6v/Xmn3BghhMKqu5i44zwtXs4B+D7DX0/MLXYcGUrAQ0n+Yc+ylxSshc25QST650BriId3NoAeZhSFW/PasQYEjckcUGQk8qCxOIhsNCwsdwWGYh0LOjOQyCL7tA/LgfKTJ6idhqsRZPrxWuY2VBMtswJZ6TcGEuZW2nTfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861224; c=relaxed/simple;
	bh=22BZ7U1/BMBwqwa8TSe0Uautb58lPHHPr3F6DM186+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go54lOiJtDhkPcAehaR6t3vUzVJbreOdqNFB5ZnK3Ra3f7Me3qzUQACxJ31MrjRIgBIylw3wNKucwhwe/77RjNUokpglfJY4w50RLABWjOuWFz8PcHHStwGJhFr9JiRwMD9RDCIKoxtVlAzutLeC6YhIQY+CXOMU35J2Dk3AO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=i7USbMRR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso222333a91.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861220; x=1774466020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIDc8NJNVATknvweSjylLv8e3icsVcoxO5WK/CBbVqs=;
        b=i7USbMRR7+oP9OfJNMFZPBEYnJBbWBo85TFXK+iFkAHgz48l5oVnMicfyZx8mBtQVs
         sr028sfpeM/fx0OsE6jZRNPP0paN7WZhRL5t6/Mmg5S4vxWX9qfI1/2uUVHRe2fjJJus
         hKmGRkcfIVXyS8qTC4T37iwMUDErxICXQPdblgtc6PXzqppNTKUnqzZz+9rCSQmILdab
         cThZ9J1rog5NMk0x88J8Ha8envMoPcnwo4UFhQ3E2L5yAwwTLEEbLnmnObvz7DH1wX1B
         A9odChHHXR7UBJ6Vo+lbSNkaKH79EQskHDii9D+Ek+fmCDjdfYNjmUCJvpZDaVfA2vch
         cODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861220; x=1774466020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIDc8NJNVATknvweSjylLv8e3icsVcoxO5WK/CBbVqs=;
        b=f07ZK7Bxw8LBANoV0T2YBs7uj0ye3+wP1vAsugJA4Xglcg3sCfmj5f2xKphh/n5wa/
         wOhVDsrOkiTynU7eGH9wv6Kgvo/KyNlhDn9CtCe0ZH+bkUxCrIMaqSELj3tkO8PRn4M1
         NuDQe/nh9FbnUAlG/Bj6epFbhIIOHnEfz2Ob7O1Sicm02/NJrZY4NcvGB8LL857IDYQ6
         7uDrI0ZFUmEC79fWTBVD9q7FajoOOz6L31mPrw8OoJlupBYESUO/dcxg4Hg533S/5+Ss
         FFtK2oJpkEry4Hku3PnOt+AV4OL0bx4GHCc5+1zvbA7mQWw4fu2Gy0y0niSiQYYEwmVU
         6MLw==
X-Gm-Message-State: AOJu0Yyyl55VbBIY6dp83jItRYknBfIdfH4+2Zb+iOwwxNKbDGfmZN8l
	4m4jpV11hmPNOZYBE1WUPgo1BUvTEr+31vXTbp8PhM7Cm0WXxICGKdKL1Xfa3VHr35pPv5AZn8J
	UIFkUS+o=
X-Gm-Gg: ATEYQzzr1MaV8+D4eMGQsJVLpEKUQ/a8G6Vm2+EfsZeTEQwnDv+zGNNBKruc6FILy5x
	IA+HMxNIpKOH/vO9SSv3PFENRBGETYHDYXaU9F7LxtbPBJ8D6EQRcf07EoA08Pqhq4O+tO+1ymY
	EnCQsdkU/DQXoOPIAA/PydT+EkJIPvuNSm6p4cDUe+UVirQ0cORHhF4RowVXS5bTqT9VsLSgDoB
	GBuCsWk2fTv8lt4c7jfheCtTeKWd1BdGnkDJqiNDUJ1WsUe6QSy+hP/8Z8AZM+xWYPsHxXJB7mu
	Ef31QUGP1BSU11c26LDFSg+d9ZjBoFS5FbCmaHln9Az1fjkxcDujfMlsdwMy/wsEgJ7ztk37vQj
	jPbxlA4xfTdFHubunC31ZucxlXyFUh3wpoYc3F7Xi5fs+IJdEYSiFIAS4mLvteFCIzBVCWZOptf
	a3c9t7
X-Received: by 2002:a17:902:cec1:b0:2b0:7114:23cf with SMTP id d9443c01a7336-2b071143943mr33841125ad.36.1773861220125;
        Wed, 18 Mar 2026 12:13:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e5694acsm3287526a12.24.2026.03.18.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:39 -0700 (PDT)
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
Subject: [net-next v3 03/12] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Wed, 18 Mar 2026 12:13:08 -0700
Message-ID: <20260318191325.1819881-4-joe@dama.to>
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
	TAGGED_FROM(0.00)[bounces-269160-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: DAC672C1E10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Export bnxt_xmit_get_cfa_action so that it can be used in future commits
which add software USO support to bnxt.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
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


