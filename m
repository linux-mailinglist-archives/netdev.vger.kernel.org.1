Return-Path: <netdev+bounces-270172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OLAAEMvvmn3IgMAu9opvQ
	(envelope-from <netdev+bounces-270172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 06:40:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB232E36DE
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 06:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E133033A88
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 05:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7C358369;
	Sat, 21 Mar 2026 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5RgWuaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE2357737
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071579; cv=none; b=CzIFR+g3DGRKFNLIAzma3c8tpnyAoYxTiDWUPBn2olHg4XsMjEizwKNmqkLSxxCU2nZ6pTvuj3noJoVV0U0uvTOx1lRmUvydxlTLd7UVmsZm3pn478QGNptMiAGrQjLEVa/kXzlRJGy+pS7s3T/CaJC1d6qe6LamB3NluCXs52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071579; c=relaxed/simple;
	bh=HYPV5+I8fH/ypfF2AgO784OuRVVErSIU/yP/DXliX8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/8jVb6DK/h6iYSyZU0dBNHxwO7RPCL8XCTy/7cLEwwfCeu6iFwavFQu3X5iBIvh412gs4K5Px9GieM8RofKDT4p6ZJt6vlWKMH49nmogY8j/bclEpFOwGSqDeu+yqSJ3QYBRx1uwkhJ9pRUrKd4vWbjVxAbrVduKgNq+/uXqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5RgWuaK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35bb9070644so785271a91.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774071578; x=1774676378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vLQwDdr1oGsaR2KdQZstZjQxIdivEgvuuhjfe9IBVw=;
        b=l5RgWuaK8nGr3MfLf5HRHrRqSweWoTQ8Fd263KKjtuQHl2Wme/pUs7mA0CyvAoxWVP
         nHRs4Crn7SJRVgFIfRJv2uaZOMYYNoj3oe2RO+A21NBQnsYQF1Qt0CHn7d6PSbX+4ehj
         pQktXM6ZvoJzfClFxPCfiGfgrpELfntjKNKMfiqihB8Ul5g2O4yyNOPmyXN7g72JcOPa
         g9AgZwZ0utmhAv/7CCNDlL/jH9+O/ahYBLwGdTDzpNlJnOc3mGz1vSz7DlNMFQHEPr+/
         r0skttNVEivTtfXdtjbdsWoXV4hL9C2qWY9cBeYtT9pmzZcESjYv7Nt+DLCAr7IWzds3
         ssvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774071578; x=1774676378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vLQwDdr1oGsaR2KdQZstZjQxIdivEgvuuhjfe9IBVw=;
        b=qkEPzBsY9+OuGYQpXFgsHTTRz73aJ7wjloBtx5XIRFEGLDaK6Hxhl9IfA7IUe6rVF5
         esw9vax+XJQ4i09wAa20hq+KLsure6TH+BMmciOiE+EkrAXyDThcrrB0dICjCff4iCii
         Lfuw5CDQ0k+1COe0TbWDLx4p/8oH0mrfg5DB4P+IqqTaH70is+uRmgGm67VQXJubEXoc
         0tGpL67sUwhDok9bT9HFvMp63gdXq0XrVjf+FGiLc9VE0MhFBHrib30KRyQFwki/fgqc
         AqNp5w/xGpDqAvcoykJCy6AfoH05BnfoRTERM8I0zLdrdgezRXOMmrLFm1pwd/ArSJO5
         QVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPiZixjteaLwMroqBy4F99X7XVAwC7FqVxXwAvqbC0VSyUtv7byeEXsuGpr3roYm8Jl4c8pmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZi27MQI5b9WVh3mgp5zosbSugXPT2o0Vertg9/P+OkIxMYysl
	nwVSIJSAO3FprgdbDWq/2xC+FFIicerA962MDLZhtWVaQjYoDlDC0/c5
X-Gm-Gg: ATEYQzxXHjD/OMwMfM7EvA8esBPwb0mCK2IRVT89lf5SVYNIrYsAXzs2hdd6Prjfdm3
	r1d3R5//laDWgL2ttJ6jxBfMFOPc3NKQBLc/csCKHmeBpSWn8LafA2VvSkE1U2r0abz9ZUtxeoX
	SrIMU5XCTIWBgTf3LHFrbJPO24tHV94qtnzvX5kux3amhzR8thjSSrJgVOTERpZ9xmnPjxGPHP7
	iwC9cg0Rx4fiCpV+kvhcCDSV0Ps1stlUzq9bL2Xlp/Tvsm1F9/urZ2pUGEsK+ACm0Xs2BWgXS62
	E9xXfkmCXApbSpW2zS3k+YJ39MrMsqAeVmvs2zJcQaNSUr8+/oBjnJDnGpn4SYEEYHKrHCSUeKS
	UzShfRBW6U4SIq3TIHf04R1LFhADocQ2dBvFGqe464V5jS2OYfLBHACln3qddf8YzKBc9Ry0VOl
	EWjnEv7QiENlqoitGcF5kv
X-Received: by 2002:a17:90b:2884:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-35bd2c9b202mr4116462a91.19.1774071577781;
        Fri, 20 Mar 2026 22:39:37 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd36bc5desm1294856a91.13.2026.03.20.22.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:39:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: mana: fix use-after-free in add_adev() error path
Date: Sat, 21 Mar 2026 13:39:18 +0800
Message-ID: <20260321053918.791068-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-270172-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DB232E36DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
auxiliary_device_uninit(adev).

The auxiliary device has its release callback set to adev_release(),
which frees the containing struct mana_adev. Since adev is embedded in
struct mana_adev, the subsequent fall-through to init_fail and access
to adev->id may result in a use-after-free.

Fix this by saving the allocated auxiliary device id in a local
variable before calling auxiliary_device_add(), and use that saved id
in the cleanup path after auxiliary_device_uninit().

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Cc: stable@vger.kernel.org
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - explain the UAF in more detail
  - retarget to net
  - preserve reverse xmas tree order for local variables

 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1a..70d71594c599 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3362,6 +3362,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 {
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
+	int id;
 	int ret;
 
 	madev = kzalloc(sizeof(*madev), GFP_KERNEL);
@@ -3372,7 +3373,8 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	ret = mana_adev_idx_alloc();
 	if (ret < 0)
 		goto idx_fail;
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 
 	adev->name = name;
 	adev->dev.parent = gd->gdma_context->dev;
@@ -3398,7 +3400,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	auxiliary_device_uninit(adev);
 
 init_fail:
-	mana_adev_idx_free(adev->id);
+	mana_adev_idx_free(id);
 
 idx_fail:
 	kfree(madev);
-- 
2.43.0


