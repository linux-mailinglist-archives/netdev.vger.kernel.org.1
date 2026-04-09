Return-Path: <netdev+bounces-276882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CtmBcNg12keNQgAu9opvQ
	(envelope-from <netdev+bounces-276882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:18:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D163C7A3B
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A313090CA0
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E2399350;
	Thu,  9 Apr 2026 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="GnWv8TQU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5639C003
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722418; cv=none; b=UYgZEKzZwxVoIfr6TTcU7eTN8wmzPXSxF6SQ4PwUiadSIPfgGnosJGMFnnRe/3GLs0msEnSMMXlrlhkGhhQKn4ld416oDyvFwYrBiXjSb0Zc7ilaCLCfoE/B6vJn2jmsuJGsA36i4Bxf6lZgjYGKLIlbeI6L6cXl0Dg01c5iKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722418; c=relaxed/simple;
	bh=mWGhox8AXmFUrLnRncYPHqWj29USHg6AI1ZxcWStxYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xdc5vusahelA3M3ciNeV0PGxLYDjNCRBnjXf8CZzzRpDS9t7izYTtLHbSgDTtTuRyXppocc99B+0sKyhojj9kGW/Op1R7BSn+cZy3PURDfiCYo2Q8ZFsg6dODme7XV0fFk3lauFhOFnG5Vy2Jom2d9XRl8z667hdyBGsAXrFtu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=GnWv8TQU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b936331786dso64754066b.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775722415; x=1776327215; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DlWAuV2ZEOJrkIZUEM7lgz/oKWXmhKq/PUKh/pIHm3w=;
        b=GnWv8TQU7/gIwZyW7PIk+S5+yXyYWsP0IJ4NqmoTNLlTqXFqJqBByNsjUgaxqmawZ9
         jXbRsD2qI+bseqpRd9tHzN6VO76B37m3gsv3vEfTWlYVVR8CugYErWIHgDx7rGTIfHDh
         J8xJYnJm+Wig6aRirEWtkJNWmq8xVkjWkyMmEGM7Frjr3emQm6Bhdf7SJV4Q601rkZVH
         q3/hZemxwOn24CsckDf12o++46fb4WDSiebFjfzzETtFTQUhH2nNZBVVPjeRJUfzqNco
         XkMxNfGGd13W/7qYc11gSOXZBsVa/0pMF7jF64VJM+kk2IogqCD9gpiXXlgCBArpWe2N
         p+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722415; x=1776327215;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlWAuV2ZEOJrkIZUEM7lgz/oKWXmhKq/PUKh/pIHm3w=;
        b=n/8RgGPEqEq9OLEnN9mpUmRuQK7U1jxfoMV/klQyGheIzyRCSVx6qNtx8/mQoy0ihT
         knSeZ3dFxKaLCubGhLL0HJiDEK4/t3GguMix+YVFOL28K3hxqdlxM8wo7mV4W6BY0/yt
         +GZNfYCGvuilmtbGRKsfMqwiFlAZlas07Itfb8mXaZJzt8yd55HTHT2crXMqgzzEyFVg
         ElnyTKEJExaPrgNufHPCWpka67tTxi2hCNR7yx1Dof6u6NYe4xIoV1yWC+CzmihuRvOD
         uvqmDhbhtvhNAlmzzpr9z3jgy1qQTqHILUZF6R4ARAxRsSTwFgnmGAZjH/JA7xifVEbL
         Mnsw==
X-Forwarded-Encrypted: i=1; AJvYcCW/tg16KoupcJ1JttVV9PUvdeuE3XWpQp77PcKvYIG0S9lT8SJmcHUyVSHZWdQYk5Ao+gh6LpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLdSzw1ozgb9TD461x270HOgJH3LEYCQ7F3FJfOUztvKXiqLm
	n/xxXMHEaENSMg0xoY7ZXtGQPxpSkUawgSOu3NEOxzB85vZiRu46xZq2055bELfmgS2uegQ2Cq6
	V5Ll+2wM=
X-Gm-Gg: AeBDiesmADi1l57TlyKmqmDwuuYYA8nTwb7+krS7AOMLOyint4K7qaJ85Mq49IDKde6
	voeqzb6OvM1U+ScxEwPcMBSW9crwzTWJaA87QFv2J5ups7YWZdEZTpj4UbBu8xDmEtzV6mRQGLV
	5JDMzm/KQOtsRNMgeX9OG7oak5iD048Anl7UlkGsuRpaxW4jbuHxghS0D+VImsNu4598LW4VIQq
	tELN1YDbEig3LnZKCwACHo9UNG7hyim0VVtFKu9a4gpVxErdKBseqA1rGswKdb7mvAv0JPxvBRs
	+t7ph4il0P8GtXwz1KLloeXtvlqap8ATpa3iqz2n6KJn0UrIinMnfu4+flSnxtaIXR2rCj11tHu
	vguI/8hmG7TgggFKkwacYxrDLTHta6l/uQO/DvxVVR3hZut2oFJKVC3bbc/c43u9njWLWQmtpjF
	k2ayVmT3ZKhPOfowS2alBirEPwi7rZkmI7pWd8Y1QhY2LzNoP8anVTluemnwkYkuCuQ6l4Nf3as
	8i4fQ==
X-Received: by 2002:a17:907:d87:b0:b9c:9594:e10 with SMTP id a640c23a62f3a-b9c9594137dmr967380166b.14.1775722414580;
        Thu, 09 Apr 2026 01:13:34 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6f20sm709846066b.38.2026.04.09.01.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 01:13:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH net 0/2] More fixes for the IPA driver
Date: Thu, 09 Apr 2026 10:13:30 +0200
Message-Id: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NzQrDIBCEXyXsucJqoiZ5lZKD0bW1kJ+qKYWQd
 69tcxmYmY+ZHRLFQAn6aodIr5DCMhfDLxXYu5lvxIIrHgQKhQ12LKyG+fCmxIzU0nrRcnQeCr9
 G+hUFv8JMGYZ/mLbxQTZ/V04s0nMrT/lkR5OI2WWaQu4rqRB1p4XFkZNua2s0b5zy3BclpUjW3
 AnuYTiODzyDOqG+AAAA
X-Change-ID: 20260409-ipa-fixes-a575cf2810df
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775722413; l=527;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=mWGhox8AXmFUrLnRncYPHqWj29USHg6AI1ZxcWStxYs=;
 b=J2MpnoPY2PqhNg69JarwyHsbeXDvK8bDP7eNCK1kWpKXkeM6qykXpwNkNLR8+vhXqkqhe+oGT
 Y9C2inv8v6JBb/SwphLOhGMoRJF09Rhozdbaa+530VucN3kK+yyRqQP
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276882-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fairphone.com:dkim,fairphone.com:email,fairphone.com:mid]
X-Rspamd-Queue-Id: 71D163C7A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two more fixes for the Qualcomm IPA driver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
      net: ipa: Fix decoding EV_PER_EE for IPA v5.0+

 drivers/net/ipa/gsi.c      | 1 +
 drivers/net/ipa/ipa_main.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 56007972c0b1e783ca714d6f1f4d6e66e531d21f
change-id: 20260409-ipa-fixes-a575cf2810df

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>


