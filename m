Return-Path: <netdev+bounces-270203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOZAFj2GvmmKSAMAu9opvQ
	(envelope-from <netdev+bounces-270203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:51:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053192E50EF
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 210C330066BC
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660938B14F;
	Sat, 21 Mar 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM3sOxiy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E21258CCC
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774093882; cv=none; b=NgYL9sl704aK/y+uEl12ZkoYsRlfOnX/Mo4NB/IHzHM/nZ+gx7Zk1XL8uHDlh4kU/yzZMcH9DMBYkZJBXSFScn4d8cGexzo1QVkvRMfvaYz5d8NX2aGbPLaX9uSyo/lfj5mkPB8iB37onIF/3OcURV7ghdVV4hf17IwL2x9P0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774093882; c=relaxed/simple;
	bh=3eh1OT9D9BpUpvEjoVisoWRX18q+qGa+eoXu3OkBq4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMfdEu4JWaW2e+F5B5jHGfrBRckAbWBtF048QnwhHwui4voIiaJNISpXoarIp9IbMwUENSquse9Oy9BrFtNXq125jggzsszm8wffuA7pClbKM0PcgIEqCfWrQ05kCV/8CzTmclbXRmQ5jDJpS3AqqysF37lxMd8YGq1t5n0WFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OM3sOxiy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9516a653so12582455ad.0
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774093880; x=1774698680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyLTWwt1nTioiwAe9v9UZu9ANFhBTLIrCwfF5jN5Q80=;
        b=OM3sOxiydeXhfcbcK4R5UBu6OvwfBvW5k0pPwN14pREV1XlseTJihDpqgjOU3/g/ga
         t1EC7NvIeKlHSWHOMSXEFBSpUpjV1KWB72xO76JRQPqaffXAZvvEuBzddwqb9TBUHxsj
         EW7bmdFm6CyJDqufqFoj4141+oJA8j5vLTi9QwBvQ/u9FDAwotpp258iwOM0gdUzLAF1
         ozol7y8Tbbi7Ktuyo0Mzlkvwk2gDisNUjDYgMH95RkAlutGqUzPaCH5LuMAISlzxzVYb
         B9BMa7DeNTgVF7Mg/21WXEF/4mOEOQDsNYBYWgji4foOB4aGrDiRD+c268djPWYvfZiB
         5lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774093880; x=1774698680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyLTWwt1nTioiwAe9v9UZu9ANFhBTLIrCwfF5jN5Q80=;
        b=RERbVoKTn/J9zSpNEz2dWRycWRIBnEvtJrgj+ai2mWGpDJQL//bPmSUQ/m8XEXHm2v
         wsSGXQOEJuRddiDqQ/yX7VsISOxqaj8ut6OwJsSqT74PlfYzbxDUjCwJeZ03Z4RLRm2T
         4LEpIyL4Z5Se063s6JU9C780dE1aeaishM2lRGgGBBLANG83pbRx36ATkKXceElAkmyC
         eyUYodQxq5nWpQ3n+eHIAEuDJBnb6kN70fQ+bfbXotLOnhXcwwe1yokO7cvMU7nDPpG9
         VFsgPbE28SvVvYsQlr5w+4r0jWNArmNnUctGzfEWc0YFzeR5JlsOJVrRbIAhgkk/gbdL
         k8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVItbEPyngxYnOvAITAlEGLyXA/IsaS6rJdUPe/avwx4NLvq6ZmjKLM7fAFkPOipMB8Qf63EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0yfhceYwG/q78bD9X0gPXTTiDclGvl2fh+8SmsOzF/kZhALk
	VMNlwd289Psvy6rFSTmCR6GAZ1PG5VLb3Na7tA/6sUcw6K07mBFH6DoO
X-Gm-Gg: ATEYQzyT2f9+T4TD/9gVrSsuiQJJsOyPwLL2o0J/ROfs7yi1TsoeSV0kgRjUT3DfEUE
	jzrklOH0rNCtSv8LNJO0mA5y1FPgTf6vYHasDhlkFszibbSogVQJb68M4zsyhDh8tMPThlZqksR
	XZs+9/DlcPWIMYn8SAyPMuP9R96jZRSUVasSceqhzCr7pNk/F0ExvkTRaKoPkbr5gqzL5iF5MBV
	wg1r3wnM4GDuNx5ynUhzNV2yyWEg8W2CVMzabRmysxyuna3zDsTLNmyicsmJWW3ly0fdwJAX1hZ
	iH9px5bC/mJtvttaDJwOuQ/hzsWwRlh1ppU2QVzcuG/YrO2s6KKqpcnSf92vLxiNIKV7pg3+cLp
	WcrKlzGPGdU+dQMxavgFSJrGZukdQMc4lf1HpaCf74ICkIYv3q15W0sSyGjrf8611Z0A7R9xbnj
	bNfuWKn2qDcSUWX7/mBkBrjY2CBCRm6A8=
X-Received: by 2002:a17:903:986:b0:2b0:5548:7d80 with SMTP id d9443c01a7336-2b08278afd1mr50197575ad.27.1774093880318;
        Sat, 21 Mar 2026 04:51:20 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ab1sm67487685ad.5.2026.03.21.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 04:51:19 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dpf: fix UAF and double free in idpf_plug_vport_aux_dev() error path
Date: Sat, 21 Mar 2026 19:51:03 +0800
Message-ID: <20260321115103.815004-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-270203-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 053192E50EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, idpf_plug_vport_aux_dev() calls
auxiliary_device_uninit(adev), whose release callback
idpf_vport_adev_release() frees the containing
struct iidc_rdma_vport_auxiliary_dev.

The current error path then accesses adev->id and later frees iadev
again, which may lead to a use-after-free and double free.

Fix it by storing the allocated auxiliary device id in a local
variable and avoiding direct freeing of iadev after
auxiliary_device_uninit().

Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 6dad0593f7f2..a5e7c42a9e6c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -59,6 +59,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
 	struct auxiliary_device *adev;
 	int ret;
+	int adev_id;
 
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
@@ -73,12 +74,15 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
 		goto err_ida_alloc;
 	}
-	adev->id = ret;
+	adev_id = ret;
+	adev->id = adev_id;
+
 	adev->dev.release = idpf_vport_adev_release;
 	adev->dev.parent = &cdev_info->pdev->dev;
 	sprintf(name, "%04x.rdma.vdev", cdev_info->pdev->vendor);
 	adev->name = name;
-
+	/* iadev is owned by the auxiliary device */
+	iadev = NULL;
 	ret = auxiliary_device_init(adev);
 	if (ret)
 		goto err_aux_dev_init;
@@ -92,7 +96,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 err_aux_dev_add:
 	auxiliary_device_uninit(adev);
 err_aux_dev_init:
-	ida_free(&idpf_idc_ida, adev->id);
+	ida_free(&idpf_idc_ida, adev_id);
 err_ida_alloc:
 	vdev_info->adev = NULL;
 	kfree(iadev);
-- 
2.43.0


