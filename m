Return-Path: <netdev+bounces-282024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAIwNrvv8Gn9bAEAu9opvQ
	(envelope-from <netdev+bounces-282024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:34:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A9848A069
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 492123087CE1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2043E9DF;
	Tue, 28 Apr 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGS92ReR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABAC37BE71
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397296; cv=none; b=GOBzTUtNeZSfGvXTmJU7LHtlU0KGj/eryn0EP3t22eEYHrJy+3dVX7dzTa4tk4a0U2+KevGCGdEe4eqX/WgftDlstyaOSIMill066mXF/seJEaYq9520KAgmb9e8C+8QPr7pecFWL3qNEwbIOJ/7NQqE5Fnik8kNppVfLcLHb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397296; c=relaxed/simple;
	bh=FZkPLyz4iy8JIkfq5sjfg8+HsGK+VmVs0AAYqDsVXqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbhGPf27tBG8ASCDIqOYOLMdWNR/MMDpyXH2FBKJng/gO0MwirhIIHUNawCb/xLD8ugbW+P/5qv+ekEboJMkxavaiTX2LRUtnQTA5AHx2ieePJNeKF+++kthHpPSYwzywc21P8L2IN32Epoz9OZsnNka71KDfkSMTET3aQyLXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGS92ReR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8eab809593cso1017489285a.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777397294; x=1778002094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2cPAm1wDcQ/uIsNTaahkJXXGkH27N19gjb7Z1QCBIs=;
        b=DGS92ReRZEDz4GbVu2jCoVGusJau1RySDmuUiBOAxjv7C8+BHMBGgFME2Vl7xVvHmJ
         eI6uPpfrffUPZJCDOdYIDlQZtNe/IK/ifcjwUaI9Gi2MbpZHYfEqnZ7nFYEayfMMEefb
         5QtnMx5OUdHgZGQY3iOzmi9GIZaf4O2Uf6yVG0UjryIQi3hTGUbcWfOmodpU7jESvwje
         mkCjc6qJOreLbntdWqymU1/KmILZvVDlDY0/jEsQNtBrftJe1nettvMRgucshsOAGZgN
         GMxgx6s6+pvpOqCXrNABxykEIux34YEt/coJFuyQIFDi6Q0rjViAU/b5MQE1M/yzxr7Y
         CR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397294; x=1778002094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2cPAm1wDcQ/uIsNTaahkJXXGkH27N19gjb7Z1QCBIs=;
        b=f2TQHpn/ePfD3fDzA7edc1dF6sDz3k7MVz1G+B3gmJ4MVqewnFLNI6Qsjj8ghMEMkK
         BffRvTo0t1D4NgGfA3QFudiQ2+v07VSAh85qXf9ak8uxaTAV3/DBpajVnI9Tof5ooqnz
         F9MBB4BghVYRhiQfYsp52qXTn0PI6Q5//X27E1dqnbi9UA9AfxyH0oDVVihIC9AnnXrf
         fF8k/N+QQaLY0fENBECUayAQlwedwclKo95whpEmrLc0BL0hbYjZx/UNspQw+SV++YBq
         CXMb2YoCVtlyTJQDZHPkqvvNPK9eiFh9x30Zz4F1ZJhr3wmwOoMXEqWVEasfMq+O/IXR
         /mjw==
X-Forwarded-Encrypted: i=1; AFNElJ8d+laWcAY+MEgdIWaBLDi9O/RnBYEW6AEeEhg2myKmtlUjkoPgqGsyP8BQ8YyMgHNhZIaDibY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZWRbRLkimHAxKDB1B+wWThKU0a7uTmKyaRgwjwhYXitmRCKtf
	NxgGGCee2WyF7FNyb6HHgnyDjXuhTxqqCWa6yGihXeKG4oizXQKzV6wU
X-Gm-Gg: AeBDiesZDTOgV/4+RKTNMWW7u+c9Z+AgjUyQUv3PUHbnl6mXJTc2lza1YzlTOZHhLSu
	lfaI7nvXx1vaFp0nxlD+ldoAmrMzaqkBZco/rU7h/yUGVzqYAgGgK163/E7+ILaLizib+xiohUJ
	Pd1Kmj/eOHjgcdpMQT5JKNHYWH5x52A+bZpXBSCOijcFeRaEcBAWIjEBhu59eTEOhhnWrKnlql2
	mgciNoJQYr7pG4soIHIvtrW2FD+gIpKnqwtHHhiSAOgs/sc6LUEhWjWYOWubVrrCDqrjNTnxk4N
	KGxL7SyT/l7CiuQ4D7V91fLHPrFSnHpUbs6GB9ZPUJab5+QwEzmwPHvNbgFC/VuqWPWS2rKQPZT
	LMH8Sx2lyEgYKCai42fpoXaYozgMlQy//QWorYTtxbmUL3gDAkmEPaquUe5hWzHi+D9LSpdUPHX
	QrQVyF+UB75rk9UQpK5arQIhEvET2hiqs30wBnyJkcnzcgiLdRYwtSOC13gJupaSCa5mM=
X-Received: by 2002:a05:622a:507:b0:50f:bb54:d3d2 with SMTP id d75a77b69052e-5100e1d7110mr56064571cf.51.1777397293649;
        Tue, 28 Apr 2026 10:28:13 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e299d76asm26253676d6.48.2026.04.28.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:28:13 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next 1/4] net: eth: fbnic: Fix addr validation in pcs write
Date: Tue, 28 Apr 2026 13:28:07 -0400
Message-ID: <20260428172810.175077-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 61A9848A069
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282024-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This patch contains a fix for addr validation in fbnic_mdio_write_pcs().

Cc: stable@vger.kernel.org
Fixes: d0ce9fd7eae0 ("fbnic: Add SW shim for MDIO interface to PMD and PCS")
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index 709041f7fc43..d6a124889f52 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -125,7 +125,7 @@ fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
 		addr, regnum, val);
 
 	/* Allow access to both halves of PCS for 50R2 config */
-	if (addr > 2)
+	if (addr >= 2)
 		return;
 
 	/* Skip write for reserved registers */
-- 
2.43.0


