Return-Path: <netdev+bounces-289318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEKaHpoaDGpJWQUAu9opvQ
	(envelope-from <netdev+bounces-289318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:08:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13D579B10
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD713064125
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A268C3E008A;
	Tue, 19 May 2026 08:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA693D9025
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177737; cv=none; b=LjjVYJ0VijJqNJ3QQjYVgFBCkmf6KbkmE/RNKnRLAor9/TRaU+nqkrNRC5pVJr5Q5QMAQ6ECWq2s8Lqs0dcfu11Bjh7uOye+yOIMoIA9BsrVCmECAR1MVtBJTARH/IDziOWuhluVqd+yesmVUzKGOJP4u1IMbwP5hdOpq/zhVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177737; c=relaxed/simple;
	bh=TEb6cmuYJfPTENVrAfCtApqrrcbJHz/gheUSvizeR88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7Sa35V49nuOEO/ZplR0T99pvQYA7DOBzDWVoiQHyF8FuNow+hl68XxCppXcGBAqvp2mSJK4/Ci/AmB52o0TA4SmxSgzJ6N/PX1Jgea8mpaCKwWYeQOmSS50PTMC6OmvWf/uHeOGTMDSly3t7xrdVN4vbb7GPOYWR5XrdGXx6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1779177668t9bf45a30
X-QQ-Originating-IP: 7Hct6m9U+HHqnCl/0MOWqgwsakBwGyKbyu4YQWKptUE=
Received: from lap-jiawenwu.trustnetic.com ( [115.196.16.37])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 May 2026 16:01:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4605042449393485223
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v1 2/3] net: wangxun: avoid statistics updates during device teardown
Date: Tue, 19 May 2026 16:00:47 +0800
Message-Id: <20260519080048.7448-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260519080048.7448-1-jiawenwu@trustnetic.com>
References: <20260519080048.7448-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MAUQIEZVArhLDz1zgq737M+1sf5baXpX8gFokX1ogTYPO6nKFCCJyc85
	+jdKlmgjimvZhAIrj/kozDGxgHFSvZlkLC2DSucV/ya+eqov+qRmHPk9QGxtdpg2ZmEXQif
	kezd6VdqnFdKlSt63QS6Ruy2ERmBaW/3cHgvn+mfnHqHCL6eV3wj3aaD9mgknsUnjytbQF0
	BWY0IJ0ALhHhCilrkSvlATiARz+WwrKRsAgRS4x4MeLuaCHEvMvsA/0Pg+qM2zo2UwTna91
	TPnCsJ5AgfJC26JTvuih3eKcvVDpq8bG7opZkhPgAibdTXUm9PAudNhcpbumcd/y7dl3COJ
	HZ19vZZFMnHMENgd2B1kaKzoO2vc+3dmNYm46moDAJBVF5gyFek8LNkCrL02JALjwmR+f9U
	jz+rPRDfqC1y3w7ydFXBwqYBMD2247k4YkrRuNsinYyX+7qQ2awjy1U4tUy4hepFIBmesvf
	U01HRjFsfkO4P782J5IrnSiT4fJkkWcsAydg9/Z+VorPE55LInDIMSukWIFb2TZexp8/tni
	HJCX5BdRNZs69vbhv45W1kjngnSN54wY1ccdme2vZE3LLilGcw4gwuOhajH3SxDolypA0TE
	YX7BHgJgysm3nAFAcTjLbwj+GVpFqs9ULlNE2kLALiNyP0UcW1zX+r6BZR7OiuuH+o5/eNV
	lBaesqvzeh58UYHzHQoxXqukse84wo5XRa9WfFy6aEfl1xR4j8M55zqKTy8fywmG880M9ij
	ndCA1qqUBY587VPsgpVMOY13+1N9TGhnwf8h4/KUHWWCklM8E36r0NxHZqtyRc6Po6Kx0gp
	HmOkbEsL09rD1aT/SQHNi2p9b5qFnVVmtxE9mDTZBKp1vrIRHRkD5z7+m4OPCoj3FlQbO/a
	vExVJ16TXUavZhbvZeZmENp2tcGJonAQUMpnU8FiVSzgte7/1VbKXWqd9lMEnI1eBgrxR1o
	rSCNjcHXpa+j/2i5b40vHyncCSz80d8NysOFi5DwgjMK1L9yUAvQjzPVLuDdgq7OhaYLj6U
	xZdexdBkJImFb5Qdq7Q3oC9hSFbBo8olshoQZok30EtRhCO8T75ZLWUwHgDBe0qmh9MYnOO
	gOhB+D4BMEN
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	TAGGED_FROM(0.00)[bounces-289318-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,trustnetic.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DB13D579B10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After introducing WX_STATE_DOWN, wx_update_stats() now explicitly skips
statistics collection while the device is in teardown or reset state.
Calling wx_update_stats() from the device disable path therefore becomes
redundant.

Remove wx_update_stats() calls from ngbe_disable_device() and
txgbe_disable_device().

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 2 --
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index f4a2dd6fa493..8678c49b892a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -404,8 +404,6 @@ static void ngbe_disable_device(struct wx *wx)
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
-
-	wx_update_stats(wx);
 }
 
 static void ngbe_reset(struct wx *wx)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f9cd1caaf0a4..6755464b4637 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -265,8 +265,6 @@ static void txgbe_disable_device(struct wx *wx)
 
 	/* Disable the Tx DMA engine */
 	wr32m(wx, WX_TDM_CTL, WX_TDM_CTL_TE, 0);
-
-	wx_update_stats(wx);
 }
 
 void txgbe_down(struct wx *wx)
-- 
2.51.0


