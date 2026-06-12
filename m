Return-Path: <netdev+bounces-298564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w58tDKHTK2pVFwQAu9opvQ
	(envelope-from <netdev+bounces-298564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:38:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EAC678604
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:38:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ew1GvMeP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298564-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298564-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A9A30C4335
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABED368282;
	Fri, 12 Jun 2026 09:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC2345731
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:38:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257085; cv=none; b=KyoGpg4nnVfL8eOBt4avCiILBq6MhdVcMY6E7J6E3gFNImiAj9NN4hl2skvZyiM+FjJ0dJ8HRt4NH+5C3U9gzq6ILf+ytXUX7bFdazlUBwi94TSSrmXcQ3vkNuzq75qOXf9gccmLacwoKp3FWr3+CIVZkR/F4P/Ef50l6UYswsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257085; c=relaxed/simple;
	bh=jcYu28Tlw7oEARjKeA29kcjH5C6H9evj+8Bc0QC96ZE=;
	h=Message-ID:From:Date:Subject:To:Cc; b=cDmPFgQdY/AdQd//p5fSdUVJ0mai60992tr51TfwYzeHl2A2jMqEsw/+nOT3m0icCX+XMqZntFAJFsZp7Qnm6xUblsbxVTSrjEqA6kM6GnT+6KpJmJmQuIMsHxWr9bDEEV9rtWpkm0+gq+Wedfu8bynXMsm+L+oh2q7dt9du/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew1GvMeP; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-842848fd613so770200b3a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781257082; x=1781861882; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXbZalzcxo6/TsrxZQxu5oks4UtJk6D2CPv/MBaaCkM=;
        b=ew1GvMePpZTP1cxHZYyFjdQ5YDGkAqQ/1M3OIbs+aMFF9UaPASOVRtev6X+prwijyZ
         HTYXRzCBqomcgSmCEedF6QfcJN4UQ7tGIUivEBVACXtCyu4YZclyOG4M7Nd6ydfa6NFw
         VeYVF8nzjSlMzBJcry5Aae8WgRCSS6+a8Uo8S0nu0Zfj9UsbsVSLcoLhsPkzDVselpph
         rbA6Z9qbP3Gd4f9nuBs3s6CRzohLx81zozxCRAbDQ053oXywi/GE34ikFFNLnWhz59dc
         tBXd3bv1l158Ip+9IZpYs+ADCBEM4R/92E6fScf8H6f8mwUlU5oB9ThKxMC7GcnIDmyC
         s90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781257082; x=1781861882;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mXbZalzcxo6/TsrxZQxu5oks4UtJk6D2CPv/MBaaCkM=;
        b=P4r/DD9sz1Gc9NwbKa9VatcBNNJI2WLAE9vStJ8H7f2MRPLPcCR1S8AGAiOkjvvqtB
         g7JPDXnlkB123p9+/bs99iwAjYlx8OZXfvB8nuOnpHDzhFqG7WWoiE36BvP8kyeli2By
         xe323bdaFeE6f03zUCZwU2gUNBTqq2TqQY/uwsXOv9YC60YJcHHsNQCCjTBBEdjnWG6u
         AP+Fm/gY0l7ERn2Jn/umbJVlxIaMDvPNe1fs9Hf/rHfzxCdyfWnhwULmmhUoIOQDoL5o
         t+ItdvXY/j4vRag7fVpHW7Q4UWINZJKPi/s+MiLwg0H5QTXO1P83Fc/28CKuZ0Vjg+nQ
         S9gQ==
X-Gm-Message-State: AOJu0Yy1rrSm6tiY9FBjSub45tUW9gTKxjH2td+N+bIHGJCqKIrGFbzM
	WfGEHt9SmQCG+ewCcHz7r2nuIh3931EUMP8n9+tFj20b3PCnhV/gOvb7hPzrDudw
X-Gm-Gg: Acq92OGDODgFV+paCW4DF8oRf/AwdN+2MbTdQjaCNuyX9yLSkP6OVOSWH+CNmRl7v2w
	gq1/nArSb6VsnKUC3uVFQJgL+89g3RIrOQlUAbWOfGoNIQG5wL01XdsdSCj/9cVECjpqY2uju/W
	f5FZXOckjzSvr4GAg6wCTIoKLOoRjIc+1C2NUDVLTtBbXKDuD8O+1SNp02uKAuavOR/kyk/ntAr
	0KKqnMjl3TopubfJKqHK260iCpSKWZLWgSCRQ0+/xJoPqhgyQLZAv8XG8SuF74P0bMSldV3Lhb0
	3NoyLk5rxWHZsABoRyi8s6Ll6iphkcWTKpUHynl4k3Xs3Yaj1J0QtjTcoi3uPznSbxgiKA5sZOn
	tkE8Gz20L/t8/nELvAwZcSKwZayhmzFHiMIXKINKCZLXijNIcc0t1Cs7+nu+QdyptStzDyyHDy4
	RODHpdNfiPxVtc/bBN
X-Received: by 2002:a05:6a00:12cd:b0:842:3801:47f with SMTP id d2e1a72fcca58-8434cec2dc3mr2271540b3a.17.1781257082521;
        Fri, 12 Jun 2026 02:38:02 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b04b6bbsm1724054b3a.56.2026.06.12.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:38:02 -0700 (PDT)
Message-ID: <6a2bd37a.4034e349.1b41bb.1caf@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Fri, 12 Jun 2026 17:37:00 +0800
Subject: [PATCH v2] net: airoha: Fix error handling in
 airoha_ppe_flush_sram_entries()
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mx.google.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87EAC678604

In airoha_ppe_flush_sram_entries(), the outer "err" variable was never
updated when the inner loop variable shadowed it, causing the function
to always return 0 even when airoha_ppe_foe_commit_sram_entry() fails.

Drop the outer "err" variable and return directly on error, propagating
the error code from airoha_ppe_foe_commit_sram_entry() correctly.

Fixes: 620d7b91aadb ("net: airoha: ppe: Flush PPE SRAM table during PPE setup")
Link: https://lore.kernel.org/netdev/6a2b40e4.4dd82583.3a5c46.e52f@mx.google.com/
Signed-off-by: Wayen.Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 5c9dff6..a124f15 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1330,7 +1330,7 @@ static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe)
 {
 	u32 sram_num_entries = airoha_ppe_get_total_sram_num_entries(ppe);
 	struct airoha_foe_entry *hwe = ppe->foe;
-	int i, err = 0;
+	int i;
 
 	for (i = 0; i < sram_num_entries; i++) {
 		int err;
@@ -1338,10 +1338,10 @@ static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe)
 		memset(&hwe[i], 0, sizeof(*hwe));
 		err = airoha_ppe_foe_commit_sram_entry(ppe, i);
 		if (err)
-			break;
+			return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static struct airoha_npu *airoha_ppe_npu_get(struct airoha_eth *eth)
-- 
2.51.0



