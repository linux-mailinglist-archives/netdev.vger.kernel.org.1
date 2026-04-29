Return-Path: <netdev+bounces-282418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJeYEWQd8mm/oAEAu9opvQ
	(envelope-from <netdev+bounces-282418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:01:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 020EF496738
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EF013011441
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17D136605D;
	Wed, 29 Apr 2026 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+nv7TZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144537646A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474864; cv=none; b=m7xpu6KYaG3za7QIPCU/dsOWlmUgAkJlTAHhf0fu8Pvtc2Fy+mMkj3cOWVmX3MesS/tqRV6AfLcSAwv/O51/cY8AhZ9gt+Sok1ZnIoRI+Y4gq5WLXH5teSBg8ip/DS6EE3c6L7UNjcH6ZdvvCw/tgYwOGKt9u8xVh5KWXvHSmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474864; c=relaxed/simple;
	bh=FZkPLyz4iy8JIkfq5sjfg8+HsGK+VmVs0AAYqDsVXqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAFS0mnhCdID6M/dmeJRg1+IRYafFzhwWX8b+CP7Reshx+Y1YvayB59mgNcgNq0PMGdntNSjcQ+DvhDZWR1jKiMEa+DxcmamhwTVyC02aP8YaPuQkK1GW5gIZK+zEr7210c+UN7paLAw2A93dAkOfVdVojvcopbSi3yT8/XvmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+nv7TZ4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ef45a6d9dfso953826385a.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777474860; x=1778079660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2cPAm1wDcQ/uIsNTaahkJXXGkH27N19gjb7Z1QCBIs=;
        b=s+nv7TZ4YxAKM+6KPfBAubVKH2bpnbEmNMu3GPydk+hhcamWYB02sC6L2LGjlnvSDB
         Fddw99SHZWDledbhQI094lK8dZ+E6niNZs8eGHwh+nr27ROMPtFXLq/U0vu5+gJ8yWJI
         gKFhmB9yZGrrQ8b5sm3N+CnabquLm7UotaAD5VrzfHvyhJPc8KWRjZAT2frJQ3jUZ0bZ
         LGgjZJc8fWUEqinUHNFewIlGXy2CvjuQlc3HvNRFARh2dysNSEGNL89hWIdwaX5+FjsN
         gkUy3v1xT/oom0/hHRyeAG2REzgVwKGiLZLVq2MI/ekkXQlc/tDnW+CrZQE8P0+rYv3S
         uJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777474860; x=1778079660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2cPAm1wDcQ/uIsNTaahkJXXGkH27N19gjb7Z1QCBIs=;
        b=haBtR/bs78nmEvKjEXGzedOU3eRO8hZ6JJiXEjS1XERMKiKPM5EmCSZRdQA01SZpwY
         Ud3BWwGUD8/iFwepLHTIYvYQAUl8Z3tyU4WO3tJGyxBi7CSE7tpAQFvzLWxe8VT7GWmV
         E3FHCkohooyKm7lALzfW6iqvsledFZJ9RNmkBhvw7q3GlheOY2DVFFnqdBNdBW7WIrYT
         TwQEIj7mhloYKJiIdwkHPna2W36D8DJqFBB9+3h4VplhYMt9oIjqnlcSZidH3HDBqV+Y
         12RvzUcZcJBbcYZf5XmC2mSiwuFagCtO/67+j0kiW8MwhTP3KwhCr5hll15viN5h6MGc
         MPoA==
X-Forwarded-Encrypted: i=1; AFNElJ80VdwLJcuCGqsp9ZYyol6bm2fMZBHBxRGQrBlwA23uEwWZgH74KNnwFi1bYE2kdur2jwhhmes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeor59PBAr/I2/WQs3P2LlEeBUmg3elvQA+f3d0qOotb5z77tU
	bURjM/ktQIus/u2AjSUQqOPUAM05Xu/z/imyKwzxrLKBWbPmvVn/Rvlx
X-Gm-Gg: AeBDiesML9shYTmACO9umaHt1ems8rWhAwhq1oPIcqtWbpyUr3WrvnVaV04EgzBgYiP
	wmHp8ftfWBNp0/5Q1UW2mTVumaYNhfiZIhslmoVtBp18STX85/ZYiOUpdcj0vZvDCNGJE9ZXODP
	vizv492r5Otv7A8ctmvUPMhKDSquLkwpJwoQSkJR1s1aUYJ+K006nrqSafMVV9UuwuAcBm+Ka5u
	LQrwLPermOwOTejU0aGtfJ3P3y/KmKPOS5aPrDCVoNRcLC17Y+QX/Do9mOfjZidDxjpeo/Y8z30
	G4zpP6eWHfg3sXXKl1P4SzFlBqNeWAw5wHCk+rJk0PPCWKQ+6A/BB+s+O/Vzgr6hROoJRciIsPl
	+axJ3xAzeEHSPQanNFhG2wzTQ73dLpV0yeBmQm2epRGOR5/9JgXBGHBZiGhDN0SAJJDevaBxIfR
	b3ss7+qPa/k8Spq0SGBi5bZUfN8TSUJuvy6kynn3VkT9Ve0lC1Ny7PIAbNy/2G2H0t5IU=
X-Received: by 2002:a05:620a:258d:b0:8cf:f215:24c6 with SMTP id af79cd13be357-8f7d7833fa5mr1022963885a.21.1777474852384;
        Wed, 29 Apr 2026 08:00:52 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f5826f7sm216892285a.30.2026.04.29.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:00:51 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: eth: fbnic: Fix addr validation in pcs write
Date: Wed, 29 Apr 2026 11:00:49 -0400
Message-ID: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 020EF496738
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-282418-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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


