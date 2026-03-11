Return-Path: <netdev+bounces-266439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPNPHRbcsGmHnwIAu9opvQ
	(envelope-from <netdev+bounces-266439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:05:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBEC25B438
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 835C0304A579
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811E328B63;
	Wed, 11 Mar 2026 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZciOML3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00902848AD
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198353; cv=none; b=k3bSLO7OxZior5UrUmhw9FtJiukTrGrHHD2uJ6q7018Fod2SX2IEhdl4p/5SZwxbzDN+OvnIyVcUqhzRgfjVsehqb2U/26DqjKG2hShlNLRW2lL8rQR3rLWDsHQ06yChMw867EcBlAIq1JcNktEPGMEwuXdPtcYYnSG6XM+Cgbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198353; c=relaxed/simple;
	bh=g0jP/cCy0U+7vBEtzVQh9T91m2nfewDiwa5GpQYX8hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaZpldtW+2faoiCFjFb4LRo60wM7PSYX2vYZAz42bmQEC/QFS3QlzY96YQ2fJJNqDERSepGZAC0/jNHaoH9+qN3O5w6wSx3BCuKdwV4vR6fdJIiJkbAB7hVuWydrZaZ2V1vo0gjWUlgUh+HydSs7ad2vLs4Mh1EQij5s+i36yzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZciOML3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-467166cb638so956936b6e.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773198351; x=1773803151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95ZRrtc4eXz3V4yj62Q+GPsi5hI9uvUkZWMdSqVx+RM=;
        b=BZciOML3J05tgEuHCeUpKJ979BzwmjZ5M3RcxhcHptbOGQE+cLL/4PD6q0lMuniqEx
         3pqZ6XQ0nxZ2J6NQsP7b4K96Q8iymyJEBnmp274PdCN/BhqiwMjxX3q0qwEM1cJVQQtJ
         JNZK1nym6Woy4HgqsWB/P6gXyYLud54h73bg4I1Py3sDp64CcTfvJy7p3ne8Ftl0eQdK
         ZctrsiYXbI7qFWnxu9FaksD32zHNbVqlMcenfITbmxG3mS3/gjaBwMEq/LaT4e+LNeSy
         f31x4YjrYxAJwj3GfkCH9q/myztAE2XBxFDrgLiUvrdgGXy9+bgvQMl0yRlPhne9CnAL
         s14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773198351; x=1773803151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95ZRrtc4eXz3V4yj62Q+GPsi5hI9uvUkZWMdSqVx+RM=;
        b=TsOR1Eb3ikT/trwkwUEvQPviHMOCmWf2Blws2JOFrCqjAtpeE2CmNFx/kJGJ8Op84U
         CdnSl7I2f6xmlE2QTsV8Bhfm2IF2zPZ/+7rN6XvHI1XD+TJb2bSt80z/LsTzIX6TNie1
         kNTkeSL4/1AUCPvNWBqztvBHV9Fl6cmwfflA/bdswU3cdI3OQS6IjttUoHQT+vD2cna2
         fpfnIw8UrPnK2elQRPTtkHtgwsKI5rBWa6HvsZzGXjP4r9Nnnl9QD2Hi4xnaBiaW4Fui
         Jdoc/gIfi8tTluffo/Ip8N5T2EzEbMAJxBCxPdz0oi3tqGQ358ZHyCS11s6TYnCRf4pG
         Yf4A==
X-Gm-Message-State: AOJu0YzDq1pPCsiLfJg16TJCbkXB53cl5lInwXmAJ5vdXhu0kEuE0y7B
	42NxVR1+zyqLnhptzPwXpyTIA8Q1XVX9OqYN2WgJe0f9xHUVKUGQ3GZAm8M+cgChf4M=
X-Gm-Gg: ATEYQzxLXtJRbdgm+nEgcolMpJ7elLYYhlfUBPYRozL4RzxLTuB1RaegIO2lIJ2qDIe
	HhJMLjNbKTBfqygjXfrg1Iq0+7RY7vB6mfyf07rcnuTkC+7LPcTELyfFpeEcYZBoOGu784VsAMj
	RxvUmZyTZRvCXjys2NI7vZvdF1OTNYNc+9lrpUbOYkPq8cVkPJj2tq4Ao53EaVR8Ek+X8jiOpwg
	QHyFt9vxX3X9sJAM7SQCHqwQtwTaseroS37PjGXRs2SxSkZQingmR8MJ7LUZW4tmCP1Jh/D9D5d
	aWb8GZTW3y9qnrTkmnmb/PhOxThj3SbS7jn2/K4HuLNrAJMfpaFoGeBPLDPCE9yRTD0RGfKXSOq
	GgdR08u1CROpQnqQ1MzLGfcz8bl5qYr12if7OK8gohtTp6jCLkxPEo43GUyY8Ke4OYcPIFTrLnX
	Ms4+xAuxLB7GWhSb3ZtLhVcpRWs2/B9gnLMVk8mPRbdE962d8tlBytkbm0w++PP7nfP9qBMgGAs
	/ySkB5oLdfvftODpVtFmNc=
X-Received: by 2002:a05:6808:30a5:b0:467:2a6e:adad with SMTP id 5614622812f47-46733425bc7mr575564b6e.11.1773198350583;
        Tue, 10 Mar 2026 20:05:50 -0700 (PDT)
Received: from ShravyaPC.. (r74-192-25-180.bcstcmta01.clsttx.tl.dh.suddenlink.net. [74.192.25.180])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342ef6fesm468393b6e.14.2026.03.10.20.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:05:50 -0700 (PDT)
From: ShravyaPanchagiri <shravy112@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	ShravyaPanchagiri <shravy112@gmail.com>
Subject: [PATCH v2] docs: octeontx2: fix typo in documentation
Date: Tue, 10 Mar 2026 22:04:50 -0500
Message-ID: <20260311030450.8461-1-shravy112@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECBEC25B438
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-266439-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shravy112@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Fix spelling mistake "Crate" to "Create" in the documentation.

Signed-off-by: ShravyaPanchagiri <shravy112@gmail.com>
---
 .../networking/device_drivers/ethernet/marvell/octeontx2.rst    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
index a52850602cd8..c31c6c197cdb 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
@@ -323,7 +323,7 @@ Setup HTB offload
 
         # ethtool -K <interface> hw-tc-offload on
 
-2. Crate htb root::
+2. Create htb root::
 
         # tc qdisc add dev <interface> clsact
         # tc qdisc replace dev <interface> root handle 1: htb offload
-- 
2.43.0


