Return-Path: <netdev+bounces-288070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJI5M8cUBmp3egIAu9opvQ
	(envelope-from <netdev+bounces-288070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:30:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9027545E18
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A166D30072AF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D023655FA;
	Thu, 14 May 2026 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDRWyMGM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681D26A1CF
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783426; cv=none; b=bGtNTC0NZlc2bafwQkINudQDwnXkZBNUfettievjMuU4IyeYG69qyrG0s9F4mW2CwDPU9HAGpIPEQYs2gJ/gCQK/3fxfHVNRCSG4FIRgeyyADYDmJCfB6S5Nw5KIJNffNKv09MYEPOQZryV1zb3z3Iu0vWcCUwg91nV4fqPrsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783426; c=relaxed/simple;
	bh=Geh2ltdSeCVx2RDd9OVcFGSMPDFuS/R9rLGG9L0n78w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNkgox79habwkcQeP6Jl+fb0KI7Q0gK2vn05zH3v32JitxKclSnMAfXA3WBGRj/7O61dDukPRbYJkEtnKNfATYOkEcFcNnBsIlJtcHQRonnRWbizE5o110Q3tBHdwYpwBDhlQK5t7nYwVM0grKcNINHbvgf97vXnNz2IT1osOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDRWyMGM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso51864865e9.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783423; x=1779388223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDvdudeeJAHgJGuZXL6tml+bzI7syuTzDcLB+eMLOx0=;
        b=EDRWyMGMjir7OpKYn0HyzUeZIzVBWxj31SB8FtQr49EyffcWq+6Xj2MscHdzqwhYNe
         qrzkEWhuxR4rdKZFvWaoWzeqSTmgCjxZm+BOuQ/ZShdhk1cXPLel70PEzZlx/7wxU938
         /3cBVSN/twyjYPfZUeugziudPcDBg4OrKm3P23dLVVm50kpIq/9u90WFFeTgSEGJLn44
         TOf+eXa0v9v363ViOyeUGoq72nK6U9nBu1Ngdj/lhkNfg0Ma5ugk/uhofJAkFommqTgr
         u+pV8I8nV0JVO+XaAMxR7NusL9dF77VblO+h70UIlYa102sCgBJXp84iLUWZHrV9XBYc
         +i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783423; x=1779388223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDvdudeeJAHgJGuZXL6tml+bzI7syuTzDcLB+eMLOx0=;
        b=U3Pw1zKS3T6O1M6M35k5Bq9COoaQpykws8icG5tpSVKZqJBOxqanq8ylvgsn+L2VqM
         X7g5VKDpxeArStX8LyhxjvyFfo416Bu50SZQ1oJKL3ZPzNdA7/IckTID30qieMMQJ20m
         vSHU9jIt7bCbtkx5z3Aj74613EVfhQt/bZwJYrZ8vESz4YFu1PRNFr6U5/SyvtUNZUNw
         8x0c8X+tNyIabtxS9Mu8ZCJhLfHV6d5NUPQd6m6ifbppbAm8d/eUgwHBD2JFwvI9NqOp
         /7jG9xqFY7onwvKIiIBj2o/MvoX2ky8hEI5c1UVsE0CCznj2ZF1sL2gfawzqnOmneK9O
         O6EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VpzLzf8Q+sQt+yBUFxS2ml5caumgk1oRWJC/ez5y0TszSqW0u34/rwBdElUWIROxvJZFXGG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KTZ+vjB8GDagV2+Psn5CNexNYvL+qT28PQ2u992fTgu/CfQJ
	BWNdxNoOhT+HP25UHKjP+9o9zLr0E4hAYkXt4ErkMkCkYjC6BcMYzfdq
X-Gm-Gg: Acq92OG2jTc9n4DpJgPKJ9GPSaAFAN9EkiIE+PzbRgyLEaln4ZLhEUHrd7U5OTEiZn8
	jbsfv5AblFg0voVf7dktsALX0eKdw8+9OVTg0DNuece16bgj1P9ENmfCbF96YPP6TXrac1VpUkj
	yByWetHgMYUZy7ngvcW171VPtGwbqkZcXI7v3lpyqUh1AD0eSFY5EnJsf+V5cs8Ubi+LzfEZ4H5
	UWywBROKvGRKm7TKjcjVgs+nIJG/jW3g1q4S+aLYoXcIgd4jV0JhuZ7YrSfitZAbt0jNYXzYWAE
	OiKBm8+CyXwRchHTqocBljb6kfAjIGm0+IJvgcE0G+U8jnt6K12eNPqQfR38JN8wIxhRk9C31dc
	4L7jlnH/7ucEf/AfvJ1P9ZIQiPZMFouORmSr9zZNemoO49Vg6mDAx9/xjACAm0zaSlgXiOqBkLN
	p6qskWUazHcXnOBUQEJ+RNhgG+TttJq7sQucpu8IulZEGPmIFv5Eq93gVqZ+yAw3tb8fTxQ15fM
	K8kx1z6+T4=
X-Received: by 2002:a05:600d:8447:b0:48f:e230:80a1 with SMTP id 5b1f17b1804b1-48fe6328b5fmr5516255e9.31.1778783423173;
        Thu, 14 May 2026 11:30:23 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd76801f2sm31320475e9.7.2026.05.14.11.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:30:22 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
Date: Thu, 14 May 2026 19:30:19 +0100
Message-ID: <20260514183019.49527-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9027545E18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-288070-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

idpf_idc_vport_dev_ctrl(adapter, false) clears vport->vdev_info->adev
to NULL but keeps vport->vdev_info itself. An MTU change after that
calls idpf_idc_vdev_mtu_event(), which dereferences vdev_info->adev for
device_lock() before reaching the (!adev || ...) check.

Cache vdev_info->adev once with READ_ONCE() and bail out if NULL before
locking. Use the cached pointer on both the lock and unlock paths so
the unlock matches the device actually acquired and cannot re-fetch a
NULL slot.

Fixes: ed6e1c8796a4 ("idpf: implement IDC vport aux driver MTU change handler")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2: cache vdev_info->adev with READ_ONCE() to avoid double-fetch and
    use the cached pointer on the unlock path (Alok Tiwari)
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b7d6b08fc89e..9f764135507c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 
 	set_bit(event_type, event.type);
 
-	device_lock(&vdev_info->adev->dev);
-	adev = vdev_info->adev;
-	if (!adev || !adev->dev.driver)
+	adev = READ_ONCE(vdev_info->adev);
+	if (!adev)
+		return;
+
+	device_lock(&adev->dev);
+	if (!adev->dev.driver)
 		goto unlock;
 	iadrv = container_of(adev->dev.driver,
 			     struct iidc_rdma_vport_auxiliary_drv,
@@ -172,7 +175,7 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 	if (iadrv->event_handler)
 		iadrv->event_handler(vdev_info, &event);
 unlock:
-	device_unlock(&vdev_info->adev->dev);
+	device_unlock(&adev->dev);
 }
 
 /**
-- 
2.53.0


