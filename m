Return-Path: <netdev+bounces-257704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHbjKkmphmkEPwQAu9opvQ
	(envelope-from <netdev+bounces-257704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:54:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D047104B6A
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3303015465
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD555309DB1;
	Sat,  7 Feb 2026 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB/Dz9CY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3038FA3
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770432838; cv=none; b=m1hoa/uKXNqOVOXsudq6J9WE2RvOwTHFYVq7WAA65Bb0+J9C6/bTUH0l1p2NLSffZo5m+WRwuXwwAdsn7JUULNmbe6vuRFuTJiwNSnZo2PmHgBFV53tDB94hBg9o8+JUGFSOIPjByVq5guVrxZ123bAPtgPA9MxJeYfvZ82gDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770432838; c=relaxed/simple;
	bh=qx1Jl8fKbXVfQo+2LlM1C8vtQEmuPtK1SLpDqKvAMRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKy84v67S3B4fHQ4/3w6igiDFBdGFN/IXM1z1oETiCW3l0DhI2MP6RhO5vwbXBAFStM8rxje0T9jsM4jxPAczOamAc9xwnulELiXkZ4Qrzan/q51DwODIeNe6A/ex4XpVnQnG6G6lXJLYJ7Hu9uVXNj0bFgHKjKNbHj1kgJYBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB/Dz9CY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8876d1a39bso193576266b.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 18:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770432837; x=1771037637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML3AMg0Eja+zFme5wRXmPhd9dcxAi42x3kc/admjyJc=;
        b=AB/Dz9CYFXwnM0RtBIOLdmLKa30KH8Y9Xuw+7iBfXoU91LdCPN0vvGKSj9v6Drs/lE
         AqrkcbSj9mS/Zh7dWfW0ZVSdx6PWXaRq9f4HHl+cQ+7ZGiyK4xbn0z1sAd4XNSpMS48a
         Up9Ts1rlgBgVpXZmFhPdwTe6cOH+F28k1o0Bq5DVfP8w86ru6o6b3ecsj4xM7F2J0EHR
         N8rt1xb2hoKLCCM3rB1R3PkUvclAowRUuexdPGOR/cX9ywkjCdeX76Lx+uuR/+rpRulS
         4zEMWJ646h9SCb7PdOvchrwu2n/axXkvcnXPDkg6pmfhPhlw66OgeioX6Vb4XHgt5mFs
         5Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770432837; x=1771037637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ML3AMg0Eja+zFme5wRXmPhd9dcxAi42x3kc/admjyJc=;
        b=sJGFiuyG65yY37EG1JmU9vGbY4bTeD9ZzZe4jBap6Lyc2SHHz7VDjW1PBuphc9yB4k
         Mcn1hkcuFzvaQjbqkfFivLyII5Qdp8BuBV3phb5Y8g3NzKjIi1WJ3ntmTMUn8IQVFZDb
         TL3J5R/MOXmJzjHkYaHarGy/E3aB2JHum5ELkZTzQG+UnAB69yvNBOMNtHNnG8FT8zdS
         JaYVykZyL83yB9H4cYE89YyI1lRTj1JORRbKgp1s7u4c/vg7jjgl9FNyX3AYTOuWwhTa
         3/3mUSwfV2BCE8pPCOumBcg8qptgj4lkRkz7WIZIEgc6e1t3rjoWybsW1Ia8uUP1V4xx
         crQQ==
X-Gm-Message-State: AOJu0YydSCXCj16p239QILaJ8eHR8cI9W8kWCyKKFTUgt2WDq+Cg5gyB
	2TDoS+1ihtP9J+p36Ogedy7NsDXEBwzCNIblaqHoXMAPtHEpkdKrEJMlmu3IzJnM
X-Gm-Gg: AZuq6aL/+fNTzo+Csww69p7zLaa0yQz8rZ/19AygrbeD5O6WdgEZzqGiQ5Dq9ZiAwzK
	ZdAWWUwXZgzPQM5h77Iz1Yyntk3D9EAI/IAV+RxnCU09K75oYI8dCRkHYdvMn4w/OFB+qNCmyIn
	/IOBiCFk9sRWcT/aTxax+DHVj66CnJ4cCX2xL6Iohz6kccRcXbsXvRecVFOFBWwsSm7kh4gUMx0
	l0Xfpr41A2IJR6R3BCf1kzdxeEOXvDb6TE/GyrIv4uzBztrd/ieFOaOaVyShesRPGpzkNoLIJ0C
	fGUCgPb998VI6FRc6+yeG58K7DiE+N6hV0iwJXmgNvV5fS52fdgVN8IEbs7gbTRmEsncMgf76rq
	Zj04gRjNTiyA9hVGaYIBN9vfozinGWGKsAacAObxzBdZA2PAa362lKkoF21KOJKt+8U1lrSyyq/
	DgaInpNKo=
X-Received: by 2002:a05:6000:1788:b0:431:16d:63d7 with SMTP id ffacd0b85a97d-436293bab38mr7154758f8f.47.1770426341018;
        Fri, 06 Feb 2026 17:05:41 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fb81sm10293381f8f.20.2026.02.06.17.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:05:39 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V2 2/5] net: ethtool: Update doc for tunable
Date: Fri,  6 Feb 2026 17:05:22 -0800
Message-ID: <20260207010525.3808842-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257704-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D047104B6A
X-Rspamd-Action: no action

ETHTOOL_PFC_PREVENTION_TOUT enables the configuration of timeout value
for PFC storm prevention. This can also be used to configure storm
detection timeout for global pause settings. In fact some existing
drivers are already using it for the said purpose.

Highlight that the knob can formally be used to configure timeout
value for pause storm prevention mechanism. The update to the ethtool
man page will follow afterwards.

Link: https://lore.kernel.org/aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..1cdfb8341df2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -225,7 +225,7 @@ enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
-	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
+	ETHTOOL_PFC_PREVENTION_TOUT, /* both pause and pfc, see man ethtool */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
-- 
2.47.3


