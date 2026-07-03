Return-Path: <netdev+bounces-304586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DLSMGIHKR2qCfQAAu9opvQ
	(envelope-from <netdev+bounces-304586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:43:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CC703897
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:43:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dSkwlRJU;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304586-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304586-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 640AF305EA44
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F3B3E5EFB;
	Fri,  3 Jul 2026 14:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D1175A9B
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 14:32:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089171; cv=none; b=pwT6hLXe3WzyA729dQhL/EE7KSDeNtcTqjXwKsbbE9IWDIl3wBp+1Ips2fQ2aauTYAh/zU2w739eCvZjfNRw0XU+rkdLa1ZuWprv2eTJoyqdatds2GcmrxLFjeapSs/Hw7/Za7sOV1e3Sdk63zvimDqGWZxHbAVYh3gYRn0+Y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089171; c=relaxed/simple;
	bh=GBYvkBVUce+JzLYW8I88F4pVwYG4jSAXUAl7quLV+zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7w+JHjzkHM5YvYDTzqTrgxjlBN09+LWGgPckONB+bcx0No6L8BhPrC1F7oCOKhviSFuU/lLwReIBLBXJz/Pe30CXFy9owWtuOMjQaIKfaxi7/hJoOBQuxdRdEcA4kCYN+CO+9pmkWFEf/wuURdlyrJTLSFP6Rn3l0U5Fo4nXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSkwlRJU; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9b42be8feso5910705ad.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783089168; x=1783693968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ+nbxbgqMeY9SFwzZ4UdU77iZcfjD9QE3SIimOIp9A=;
        b=dSkwlRJUyzgrHkYHq3nHS7640tE43KGXSOVOfrzgPZ0GMncI2qfsrO5KUsgAUInBj3
         kQbySXkOiDQ8sTrXlcuDAbH+QOxXkRKRfRH7pmwnsvetJYmGDi/s1w7JJFHIWbi2vCCj
         /CN6I+4BxhDUtcIQ1CaWyn7g/+Ujira502mPA99PnFyRjoMPtMQ5EQf8iht3JffmcFQA
         4fjioHKM6zBB/LCnz/CpbW4p+/Xq+pQbGHQoYXv1q8vyp90Ja0DvH1QtnvIqZSDExKw1
         0PoN85AlcYQzz3pfdKZDpY+BNdi2jVWb95DH9Xq6r/h0Kzk414hZ9bsS/6FGQ1/BfoK9
         KojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783089168; x=1783693968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ+nbxbgqMeY9SFwzZ4UdU77iZcfjD9QE3SIimOIp9A=;
        b=eJCRTC9e+jM1dtjqbMLYp55ZoFk7vp1Kum0uTCG7fn1ZEuAY/5cJqNd4Qt3PKoVSSg
         jH/QG92inPnNLU5oMZ+G4YWL2oZKYaWcVVpwcET7+Id44Yo3zdLgPnpSSEd08fRJjFyP
         WFwtIA7VS8i5FFEi01dWp0JmbQ7R7SLKyhfhrmhd5/rNicpA1mnDYihgSQUoPFfi7W0Y
         DbLW7y5vuMmlckMot9zwsIlvFxxAgthZGOd0X4st8GsotJMFoEBCPUez0/XHp3R1vN5Q
         RdUVr51pfPw2yP121TP1txFH/8PQwL2gO8PfrRlXscICKtSLUl8tqn1ZB8SXBznrB06z
         pNcw==
X-Gm-Message-State: AOJu0Yy5zzgZoOTRY1hZrEwvET6kM1srbNXmLwMlYzrxMdIo2YxAZDwe
	gUg8VRI145+284Gb+5WbRMcpCtyQ6q8/2QAKGc0JfyWjarSESquWpmZv
X-Gm-Gg: AfdE7ckhpr6BWXDn7v7ccf8Su5VI4ZZBzDEhk3E5NV2G6eofrBAnLdlOwzDJstfVCs6
	PxzW8VJYQ2U8qRBfX44QNzKfoHu2j0Tbhlosg4lO0uibaO+npf3HCEsUYEc3ubbOVA4rtneloK8
	VOPPhV9/0JksCltfjWGE1saHd89u6MfnFLBSWGmljQ8vIJFE1iilseVe+LotcNcxkfDBEnkQwZP
	1Z63/1aFDlUFlo9f7oNNgZH7M1fZf5sJsBx208QpHllCELIVIZ9K+52c0GV/MFC5/MjLvlul9oG
	LrFmOv2CaC6mDoXRx1H19pQEInTLR75k3SBeDUzkfSmJRoWhrj/rZAgA8vGLVihQy0QnqF2ZNR+
	Wl2WLG9J2wfyqFG1eVcQseamjSlRmYoQOtvsW6NCnw3pgIxmyv+WcGBOm7e0AqfR1RIbHbKSkXh
	v+Fu5lR8U5O/1100J/jjZzzcGKFww9F75HgndxdijttQ9ag9x0wgPiqVlY4vE4/5pQtMPaDUaxn
	NZI05LPUrQ=
X-Received: by 2002:a17:902:dacf:b0:2ca:d7a3:371f with SMTP id d9443c01a7336-2cad7a3392emr29599295ad.22.1783089167877;
        Fri, 03 Jul 2026 07:32:47 -0700 (PDT)
Received: from fedora.localdomain ([152.58.57.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm22740417c88.8.2026.07.03.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:32:47 -0700 (PDT)
From: Praveen Rajendran <praveenrajendran2009@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Praveen Rajendran <praveenrajendran2009@gmail.com>
Subject: [PATCH] net: qed: Fix spelling typo in qed_dcbx.c comment
Date: Fri,  3 Jul 2026 20:01:30 +0530
Message-ID: <20260703143130.3685-1-praveenrajendran2009@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304586-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:praveenrajendran2009@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praveenrajendran2009@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveenrajendran2009@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E8CC703897

Correct a minor spelling error inside a comment block of the QLogic
Core module where "successfully" was misspelled as "successfuly".

Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
index 3a5c25026858..19c2b870feed 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -639,7 +639,7 @@ qed_dcbx_get_operational_params(struct qed_hwfn *p_hwfn,
 	flags = p_hwfn->p_dcbx_info->operational.flags;
 
 	/* If DCBx version is non zero, then negotiation
-	 * was successfuly performed
+	 * was successfully performed
 	 */
 	p_operational = &params->operational;
 	enabled = !!(QED_MFW_GET_FIELD(flags, DCBX_CONFIG_VERSION) !=
-- 
2.50.1


