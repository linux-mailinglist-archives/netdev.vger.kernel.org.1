Return-Path: <netdev+bounces-267220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IdXI78/s2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:35:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 068DE27AF26
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C941307DC6A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14603BD22A;
	Thu, 12 Mar 2026 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="UQVv55Hd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DC23AD528
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354915; cv=none; b=FCxq5PdCC6oTKurRdwI8Zdj/beXNTcn8wyevhgxSVcnOdNTwMW5oL8fp8lmznm3e567PpF4jwTdisrWg8COhwpm2+91UwbmMeGLu/YPpi5Rbka17g3S4ctRDCs6ZPYwhESJeYIueXk5ntK7/RQQVLhzUd7Mv3HH80xIzriSzRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354915; c=relaxed/simple;
	bh=22BZ7U1/BMBwqwa8TSe0Uautb58lPHHPr3F6DM186+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmAYjh2Qn9b5Mx/6TwSA4hF1Rg7/16sKhPOm6uCR7Kr7g5BQVvusyb3oiFKiFxZ3BMXbR8Jm2YlxauFC1yA2C9aLhoaR55gaDyZT5seRVhmwY79CEcjAB4/axw41F9fiX8iGBnNE6SKZS6HVw7iUrliSugUt5CCL2uyaRYCZe6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=UQVv55Hd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c73bd024a0dso648860a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354912; x=1773959712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIDc8NJNVATknvweSjylLv8e3icsVcoxO5WK/CBbVqs=;
        b=UQVv55HdYDm8FH5yMTRqkWNhgu1+R/hKa6f2BuuiKnMgrZhhw8IrY8VW12d7PybPkz
         xv6Pl+Zb+daIoE9XtveMDLrptEi97zaW/U8BnNxkfLI2R3ko+x1YJuaCMBbExfsSkqMA
         hCPbdIOwtPrwMcd4hCJTQwfqT0MBG/gylPsnTBX1unlgZPZnaWJL7xJJVW5YrfSJoxB1
         uyb/4DSq/3+7hGrmpLR78Bcwf8DLyHt3Doi8tVOmU0c2sbnWQEpxwe3Qm3XHWtfqaEIz
         jAOPaA7BmdaT+zQnt1A0lq+CwvepHv8f/qbMe1hZf7uthhuLLHcMST+/er3cmWQQ2FUI
         8DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354912; x=1773959712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIDc8NJNVATknvweSjylLv8e3icsVcoxO5WK/CBbVqs=;
        b=Iqi7RUT8L6cIfPM/C8DfuUd4XVCM6AtRg11RSMl3CzZWdBUabAwpeCvMh75PyGowrA
         2HneffcKtgd4FfTALTkxbfO2V1Qn/WzxUJlwPMvGKFzzKFFMUWQdWFJij5+ICrrmXuK5
         tSvU/BOJk4qRdc+YZmhuvx9m3um+OeluebTbzszT6mkdIsIWp6Wh8V3938Zb8/hydkhS
         L+5+m7BDOSEtJvQSoTz3XSIKUJoF6q3PI9Ch3Qf3j7yOq3tPdgFt4/VjcPEBBIhAXoeC
         YSpeSl1jdbmQAgtfivtlh1PKWf9qAxAnFZgDCjNc/qAcAbfmC4HWJOQ6ztvU0rGuTkKW
         NQ9Q==
X-Gm-Message-State: AOJu0YzZtc+k3jaKxIbwiy4v5cqA4McIYIf5hLvW0YiGwSsfFaNtN5bi
	TvUxUNRSB77LyDNrs+tqn7dbF2it8/wlKpQtWoCzYIt3ioHUHeE23xUyOclR5T+YED+a6mhp2F/
	IfrfrAZY=
X-Gm-Gg: ATEYQzzeM0J7ES9f4rke5+MFsJdKl3PnXYeqschaKyS7/8fnNwbakMkWkhriHLiFaUA
	OkOn2XW6GC5h7IdHV+4f86wCq8Bzfxxypn6d5vUC9yGt5STc4o5kCe40jpsfNvamvvKU+OBVHPI
	FNKbq5msTZjl4QVOks77mqoauoEczxRR6OmKJTWfFkayrebzmbfhH5AWJ5wAmztBANuo7hUXVR2
	cJg+K8+G6j92SNZaIeDrgBYVpnyTEJUmLcFe1EJGISygVKfuoKO9MuAtfIzoDf+qriIOf4W98yZ
	/s1n2QtZISi1GtPR8KT6WFgNxTK/iGDCLYAUSDnD0a7YRcBpPlIYjtyaahbAJp6sAyC3X2lPoFB
	dOJBdmOz/Kzx9TuB9CGRr3T/BvPJZKdqDXYcFUVAMvF2qki9Hs0JgtKzmdRxytuK2FQb9qK0pQM
	CGlm9z
X-Received: by 2002:a17:902:ef08:b0:2ad:cede:3a1a with SMTP id d9443c01a7336-2aecab22c14mr9107505ad.39.1773354911980;
        Thu, 12 Mar 2026 15:35:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece80a3a0sm43715ad.65.2026.03.12.15.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:11 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 03/12] net: bnxt: Export bnxt_xmit_get_cfa_action
Date: Thu, 12 Mar 2026 15:34:40 -0700
Message-ID: <20260312223457.1999489-4-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-267220-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 068DE27AF26
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


