Return-Path: <netdev+bounces-291093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGR+LaqJEWoJnQYAu9opvQ
	(envelope-from <netdev+bounces-291093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 13:04:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF015BEA0B
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6867A3016266
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31AE3672B6;
	Sat, 23 May 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr4CMXJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F12D1F44
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534247; cv=none; b=qkOXuJ0NsEiZwocEiRFb20dT5dvSIbwm+w6EMVuDzOAJIB88Gm1ApYjWizq7+dJSra5RuNGa0d+Ckwc+lV2OXBGsFXoX2vc1bD/X1pQ0Ix5pz+FKzAjP5EYSr2ngJPSw4Erjk5R6ztSjlzUO/xIYYGyYDmbpjPtNJuMI0uA6j1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534247; c=relaxed/simple;
	bh=Z6sRU9iMcF8zzNfNxCjZZ938y76nz9plm87nRXx0LvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tx7nsx2iHO7G4ZSrfi5R4ivV0ttDMIUF1I1MKIxI3NJBPpzgM7Fsa+6UR3Ta8VeRSLvjJLqgIO25R4s2JwSfcNLLYAkdDWCas8cc+zx59o5qCcYL3u8gmxY7ipRWP0IWx8oCkv/IJK1zQgNJdBU2StBHrJPS9HgW2zAzVsNdZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr4CMXJj; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-3025d725a05so19459615eec.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534245; x=1780139045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qv+Kb9SdkLktiClnXVwCIDMjCalpuoRwuQC/kT8PQ9o=;
        b=nr4CMXJj+NI9V3PUWAR1efgDMJfO9jL41IxoJpYjw6c0DhSwlSJJXgaTtf1aqi8dr8
         j3HRBLRdNYtYRVK+YwrVDf0qPLubJhVVZeD1Bk5Wl9Q1iQd9K0sWrD3CNoFXIpItpvUA
         lfXrZ1xZecvIhayanbgW8pGs8FueKsOUB/1vCzAM/qAOO3CoHvZ/C1AD+rwWZ4nrA+Mu
         QuQ5gXl9mTh7lRdvJ4LJRdvi7con+L5KxlwTgBMF/Mw3kT8mg/NxRSfPUt9YTcpBpgJC
         ZDLzANw9Q0ldUlBRjLrjJF6Yc8Gt7sbLOSwJGcvtMKoDR3CKblzFcAUi7Xwm8DlLqIhp
         EixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534245; x=1780139045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qv+Kb9SdkLktiClnXVwCIDMjCalpuoRwuQC/kT8PQ9o=;
        b=pflmp0ng3Ze5d0JKbf0zMNyzH1gU2Fv1TVVcWvdzeGH3Gn5cn0Fq3rLAtrvUGFsaBX
         t79xyLcvbZ/VlUppmzwiYSdigiiL+zc61VEndtz2PZgs0uB38EoCzO4GYNlkAmLMXo+M
         sJ6RJMEOLSMEDOQ2d44aPSvg/YsRPN3RtxR2zcuxTjov4TeOYYAU5ERXjl+FENDpKt/v
         lC+S+sZJjN/zoWZLtCsFVWTKI4FZuvIOQ40vceTzBmEtdHHyJX9+mrWXJSz39HuPmTmf
         qRQAH10v3o1Rbj4P0bYmaOYkcK0bIByPxEK0wm4q1SPp6HBcz6danBLnEipqPNnLptfk
         pfWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CFAczXVZQAFYYGmzNFcj+J7Q+rPaSfPnyEkWZCFAFq80Wc4znssg2ErGvKl7YRn3yMLlFP3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYlVTrpoKYOUeJzV+fJ9m9wt8AYOUNP+OsGMnwfFq5VB2MPCF
	cMsQArDoeslvfsRIunO+MoabABu/xEVK+0bI0G7LXVtYSaDUtO57YTIXUn7zpepU
X-Gm-Gg: Acq92OE9/hSw/JxSpONXLsGRO4LVjF8L0xWxDYsQYIurmetGeXyOwlO/SxPBRhxnflz
	5/oosMtZe3pPOFcst19+DbC7K5CCT0jHGOa0nW/Wl5oY4YFbK4HRl7u9MIPAvMSEdJ6t12shTK7
	wqe5/f9vFc1C85FP4R84Zp0JeDCB80whQfC2EsUFuFO2zJMNhu6Y5MHiTDqGzoJYP9h7oD3fT4U
	aBHfWb4ZD0Wsiop0Qka9zgvlQTHEY6+IA4zMLgzP5iImk1ohitlrhthPl1XmKdSpuxztLXhrlqT
	33LSxHFbdCnAoLLtB3rWCYCsiBYXIGCI/5KIIYYwwQmMu2GOtSZdRSFfj6GoUhhYWQtTEpJN1YC
	gcvI4vDeTsiq3e7CHvve11DBu0ItiEP/mbpBDkGqwNnJZzIxGFR6qvqhMnT6Dl2vXEZBQPaq9fp
	LK6b0vSQmIqjQ3wCTFL4Lc+KjSOFN8EsST5D9voM50SEuHYHCaQuP5nHRuTsxfjcn1ig==
X-Received: by 2002:a05:7301:1f06:b0:304:2c71:3f65 with SMTP id 5a478bee46e88-304491fbcc0mr3959114eec.33.1779534245433;
        Sat, 23 May 2026 04:04:05 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f20e71sm3139962eec.12.2026.05.23.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 04:04:05 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] net: qualcomm: rmnet: clarify MAP command ACK behavior
Date: Sat, 23 May 2026 11:03:46 +0000
Message-Id: <20260523110346.1672-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291093-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennylin0707@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2EF015BEA0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rmnet_map_command() only sends ACK responses for supported
commands. Unsupported commands are dropped without sending
a response.

Update the comment to reflect the current behavior.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
index add0f5ade2e6..c1c3d4fc7a99 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
@@ -69,8 +69,8 @@ static void rmnet_map_send_ack(struct sk_buff *skb,
 	netif_tx_unlock(dev);
 }
 
-/* Process MAP command frame and send N/ACK message as appropriate. Message cmd
- * name is decoded here and appropriate handler is called.
+/* Process MAP command frame and send ACK message for supported commands.
+ * Message cmd name is decoded here and the appropriate handler is called.
  */
 void rmnet_map_command(struct sk_buff *skb, struct rmnet_port *port)
 {
-- 
2.34.1


