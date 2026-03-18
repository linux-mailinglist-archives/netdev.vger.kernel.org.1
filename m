Return-Path: <netdev+bounces-269093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCPZEX3OummfcAIAu9opvQ
	(envelope-from <netdev+bounces-269093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:10:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E892BF120
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8562A328B378
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C923D668A;
	Wed, 18 Mar 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfjCfClz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C330F53C
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849155; cv=none; b=A3k2xRYK9N7ovO/gBTUaUHPiony17bfmkVEFsIIiVHGxAVHcp+BK/KFoa8EHFdG8v0KzxuFsq+Nt2mwFBvFcZVUJuH5HMwy9+TWu5KPL0tK6pHmcicPJMWDyY7yQq9XCKp0GGTt5BW+MGb5/skE5AU4FuLpnis/7Ag3IXuqm09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849155; c=relaxed/simple;
	bh=TV4oxLctJgNhtEqbA+524wrVBNXAvcpMJdvANV/+k9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YU52gB9g6oSkYcv1hBNREKCuHL2FgkvwiBuGNy+RjmHkgBIfY9aiyvOlpgIag3fivzHdpFhA2Wng0gZ1FDkYPpLh24Y4Iq2GBpwjNcQ/aKdClQiaNX3gx4TxGHI2opC+ka5nOzYD81H6rXKf0+uEAagIszCaEn6AA9cqPwwQF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfjCfClz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0586d5bb8so24418095ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773849151; x=1774453951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqkH6mzjHCAxqSeaCcRc4i6txUHa48rXIDuskLcyMco=;
        b=TfjCfClzuWnwhZKuj6uWtF8WI/Ufr6tDyCG9/38Jah6XXZV1ee9lmsdW2nUTRaPwvf
         LYjC2cC1eDxEjyUUF9yq/TPzszaXyg3s5ga/b+ODW9k6K/OgMB1WrPQ2Vsicy/RSWvna
         omNCylTApwrayuloguDlyGNVV1/JqAiiWbqpP7keMi/dIBrQWCtUm0OXPu5ROmg2/kTT
         uU4nwmqJc4CtI8/Y0vDAT5+30/axkIjg//izTUgvwjNjjY+qbzzkqUfvMeE/CNwQLzdZ
         8fNmQQrhsPulGctRzeJlG4uH8Dz/wI22PLqTEkPoZarLOTd9lZyB2IUWdlsTZTbGCCHi
         24Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849151; x=1774453951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqkH6mzjHCAxqSeaCcRc4i6txUHa48rXIDuskLcyMco=;
        b=MWCktxV4mVD3kDh8dfzZLed0HhYwZlzVBEaEHZLKOejFDhQPMilVF4HZfz0LfRPzsY
         4FNpRNbKpnzNOIgaujB222HAJD/ZerwQoiQuMRPYA/Cz8XC8IQktCz5+h+HKEb/JlG9P
         wloMcOJPtR/1X5nlVsqKG20+LhL/6hhpkj4JiuA6nRjBlezdMB1b5FBg4xocaaYD7hx2
         j3WDcExFqzYIWpA9BoXB60EKpAESle7pqcjk3oWvqxCduvi4uKdSeBejJaVR75J+gU2A
         WbUlDTaQ5KO6xhT4FKJuOW72DOJzKcldrYN4ddVXpEu/LhsiJAWsMpQaA0Bxzqb3Yxv2
         SB+w==
X-Forwarded-Encrypted: i=1; AJvYcCUEqQO4C8gEZlxaFeHH29nUxSpwlb7/8Fre1WblhBUdmLC0vXZvaYMrFtf+VZZw1m8IGyKXAhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkCs3Z36CPa8ZAqhV7kmDKExKphQueHB8JiebPjRixQbEpF+M
	ixvRSZaqqbLcKVTap2RlZYOzGPM2U1kj8GUBtMYhJc26tEt2f5K/dCT/
X-Gm-Gg: ATEYQzzxQohIIWhsTjxgOnDhukhTQzyPntO64oh7anH9sshscbYKdd2MIaTpqTDFvUf
	aCwtGzTycoQTNhdQygb3vvoKuvjzl3CNM0uz0pM06nLKqV91xf1QoCIaNZ312uybGPsZsiJWPd6
	nQOvxKf6+HoC8o9qqKMNxBd5YMJWixZ9iXpMCUUa8T1W+7KY6ffs8vC5Dowh2Jj4ZqdhVR2v2lV
	vlfzTwZtMbHJYCrIOuSYGLyZaXOtP1Xy8fmAVwmkU67Tu2pLTr+7OPGVRm0PtQmsuWiGU0jBK39
	qPQsDjweTSNW47wrBXbBGU61zJqVajE2hCJKSRuV1R5A9VTrzimQ7BgKNUILXgbhdQk0qkZv8ra
	h26s92DeCkghj+Ao5FzXIb0nrNtoGWCGgpq7Is9QziA/E2F3y4vvZq1NEnYq9GaVWC1T4kDavsk
	dtczMs8nO2e878bA==
X-Received: by 2002:a17:902:e5d2:b0:2ae:5629:ac55 with SMTP id d9443c01a7336-2b06e385ab9mr36407775ad.21.1773849151329;
        Wed, 18 Mar 2026 08:52:31 -0700 (PDT)
Received: from lgs.. ([36.255.193.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e43074esm31892605ad.19.2026.03.18.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:52:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] idpf: fix UAF and double free in idpf_plug_core_aux_dev() error path
Date: Wed, 18 Mar 2026 23:52:20 +0800
Message-ID: <20260318155220.642160-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-269093-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.857];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4E892BF120
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, idpf_plug_core_aux_dev() calls
auxiliary_device_uninit(adev), whose release callback
idpf_core_adev_release() frees the containing
struct iidc_rdma_core_auxiliary_dev.

The current error path then accesses adev->id and later frees iadev
again, which may lead to a use-after-free and double free.

Fix it by storing the allocated auxiliary device id in a local
variable and avoiding direct freeing of iadev after
auxiliary_device_uninit().

Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 6dad0593f7f2..0fcbf9f1ddbb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -197,6 +197,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
 	struct auxiliary_device *adev;
 	int ret;
+	int id;
 
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
@@ -211,12 +212,16 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
 		goto err_ida_alloc;
 	}
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 	adev->dev.release = idpf_core_adev_release;
 	adev->dev.parent = &cdev_info->pdev->dev;
 	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
 	adev->name = name;
 
+	/* iadev is owned by the auxiliary device */
+	iadev = NULL;
+
 	ret = auxiliary_device_init(adev);
 	if (ret)
 		goto err_aux_dev_init;
@@ -230,7 +235,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 err_aux_dev_add:
 	auxiliary_device_uninit(adev);
 err_aux_dev_init:
-	ida_free(&idpf_idc_ida, adev->id);
+	ida_free(&idpf_idc_ida, id);
 err_ida_alloc:
 	cdev_info->adev = NULL;
 	kfree(iadev);
-- 
2.43.0


