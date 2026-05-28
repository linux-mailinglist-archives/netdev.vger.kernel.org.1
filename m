Return-Path: <netdev+bounces-292838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCc+EXeoGGp+lwgAu9opvQ
	(envelope-from <netdev+bounces-292838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:41:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B615F9540
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EEB6309E646
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45717356A0D;
	Thu, 28 May 2026 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qACQo+rq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2E35200F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000573; cv=none; b=cfxtcEWgSdIm3SphS0bZJfgNrxxOTs4gG9mNSI/wiX4s3B8cnBpubuA7E7+/YBasbRREL0ct0HxAuzF+oLKI4SiOZFqsS0j0MM/acAjip9UdZlWLuHmHSJIplvWF0wpUi2jey6L1XuMmPS5Vtas/rRsrkqFpS1OiPc9ayy9oBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000573; c=relaxed/simple;
	bh=x6oGcWWWDQfDqcCU7PkoHIAD74jyO7vWkfckEQCPXvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGMlzar+fIZFz628G3y5aO/JjqMBoFAOdsBpMmkMBtAqTYBu70JbpeVN/LIIetHiJBK9oLv0x+449Wa9OmVgpPeeAw0M8cccJeRmS2ObCYXAKpUUb9rMgevkYpekNRx+mdEqRoSkHVPnfFZNaa+T9DZ8oJcvmpRc27onCzk+jYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qACQo+rq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-369002b26f4so7785009a91.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780000571; x=1780605371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ql2aRaaprs6WrGu8tmGWv8UQcUIzHaXz46Uq9P4wzk=;
        b=qACQo+rqaNjX3IDEUhvolkl/Lrajil04iTM55vaqtQGEbvDb1BIW1PpyEEzoEyjIDn
         Doaf6RvQCI51insdXXLtiyofm41WWVJU1zZdIxVvtkoc/6pzirS/4+Y9GiLifMRQmPaZ
         oSxR87IaCZ+Ki2Y52AgdZZesK4rnnmpu7CqH0wqoVdVleuWJx8LHeso0Kh1nsjk9Sc1S
         +qyp29pvyNplehKmzMKBhSauoQutDHvyy9AgtOWfjvtNZYEnKogAXyxXF1Md06Ui0DEm
         ZzZLTQOPkGhiRukJwMygOYGetJWaVWaO8zx40VwNubS08BhFfnpR4BlOfjQr7tR5zE3I
         F/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000571; x=1780605371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ql2aRaaprs6WrGu8tmGWv8UQcUIzHaXz46Uq9P4wzk=;
        b=WmW5O4S/Ir825lH0ICNdbPeAco6vaHY/5efpYfxUPoLC3e21a7cLX8E/HC0IH/4fj7
         xNvbJr4X8YlEudgyaLBzKxnC5zl499c1WJowBO41MIc2vANUpTEz/DnVArgeXGzu3js4
         2aUlgrWHeggkYUv3fGAuFxdWM06JdX2+GxTulnd2AUcfiUTsHcd5oAFugbBvVwWumJ6d
         Vlc7S3pb+N4UlGbBNF1+v991j1h387rHewbEfIvT45smPIq01vCekt1GIP1eVBMhA/3Z
         NROY7zaMKZ8QNtt/dxZKRLva95QI8XHFTmT3kK/EBfsswgr5hR5ZwOe/NIbGQ65whraz
         aBWA==
X-Gm-Message-State: AOJu0YxMRxyF9IE1onYYAyDlZe5SjfGielTIWdnjnTEFtF+p3hmbuUhn
	5mQKr+7QXq+vHHxS5VPr4Rb8CXDBDfhlr6ZHrU6LW8zUej3a42surp2dSavWOFVg
X-Gm-Gg: Acq92OHi8fKtEJahdZf/0xkELYobIDczaWvQVl4Q78v53P8MtusZZqTO2AI+WUBnxfZ
	qVTKSoeuT+yM+R4AC6XjY65JUt+Y71/W6bVi+5WQfHX9FYfIxyeWxIktWs6sWsKbh3xjoXne0FE
	b1man+j1h7afztUa6SomjAuRXeIjiK4cfO7u4FJpP+kg35BNwJ0utIU5SFeE7sd0Kt/BwaSevNW
	vl6ST5nXLJd/fOZvZm3hV17OPAfBAVGsc+47kMDKZFid+xDOUXseiP128TUhXd84B1exfHd7kly
	s1i9DfYglcHNJqAZCMxpGNhzfZsYRZtBEi3OVHA8BX43HbKF0YIDE7UlxLwsKmjNJLySamJIrt0
	hl0X7hW4xFk4+oQ2cY5/mpTqkj+bw/AlZrrlj3I1UAMOvB+HYTvEsFdKZR9Aouwg8ztvchLdMlX
	WSw2oTPQdPbPWwCjm4LeQ0X/WLlEq/fEJ7UiW2MhIi4xTp/hcAhayRINyDqT3XAbJa05432w==
X-Received: by 2002:a17:903:18c:b0:2bd:8dbd:17e6 with SMTP id d9443c01a7336-2bf1ed4d997mr3553615ad.35.1780000571010;
        Thu, 28 May 2026 13:36:11 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e5ca55dsm1870645ad.7.2026.05.28.13.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:36:10 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: sja1105: flower: reject cross-chip redirect
Date: Fri, 29 May 2026 04:35:44 +0800
Message-ID: <20260528203549.1918040-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292838-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 24B615F9540
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver silently accepts a destination port on a different switch
chip, then programs its index (on another chip) into the local hardware,
which redirects to the wrong port or possibly crashes if the port index
is out of bound locally.

Add a check for it and adjust the extack message.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/sja1105/sja1105_flower.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_flower.c b/drivers/net/dsa/sja1105/sja1105_flower.c
index fba926f85b47..7547999a113f 100644
--- a/drivers/net/dsa/sja1105/sja1105_flower.c
+++ b/drivers/net/dsa/sja1105/sja1105_flower.c
@@ -391,9 +391,9 @@ int sja1105_cls_flower_add(struct dsa_switch *ds, int port,
 			struct dsa_port *to_dp;
 
 			to_dp = dsa_port_from_netdev(act->dev);
-			if (IS_ERR(to_dp)) {
+			if (IS_ERR(to_dp) || to_dp->ds != ds) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Destination not a switch port");
+						   "Destination not a local switch port");
 				return -EOPNOTSUPP;
 			}
 
-- 
2.53.0


