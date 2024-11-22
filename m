Return-Path: <netdev+bounces-146867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB09D65DF
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26B42829BA
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21BE18CC01;
	Fri, 22 Nov 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EtkH+zNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0B18991A
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315593; cv=none; b=jglw9TzwbXDoZl3hRj+hQpZs8HlR1fqD1LdYQbnxFb7/r5dxr3oxhbqLet+EZhfQAZNnEGBfPniFaoEunCxabb1qGXxF0rTU/CuEVIF1GBffFTnSTCSrTQ4fANgclHtRSs5nL9p+0aRUOuoWEwItfW7OltW6SIkeW7s3CCg/+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315593; c=relaxed/simple;
	bh=2zPxNQex4AKqcSVV1nxttXW8N9gGvK1zQkkPuaAxxmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc42hC7qOKFDRC6L8hKCFIr693oZAqr5YUz1ooQqlFAzzi6lbVGy5XbKdYFdXGDA2v+NC0no9bwZDBTgy5aVqCAGwjfPXq17oWQaB7hW1GkrhlJ8RnBM/UO21YiQNkkLXUWddaXrH++jM6OqCOMBxTJ4948Jv99YQ4LJXhSk/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EtkH+zNw; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b152a923a3so151486485a.3
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732315591; x=1732920391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9MEvLA3ulCq6qcBXHH/InNCpijjlgWwIu7JInjaPpA=;
        b=EtkH+zNw9PtytYi/Za/WCaanUrU1CRxH+RqD8n7bLnbvm97sHDH2toO+4MTI6gR9z4
         2prx1dZbYtU3KZXy02zC+RTG9em63oN46zkcLlJDIV4eJnE7qbrbxYmpnknOz4tk64yL
         DLPHifiabNRVIXgl8hMk8c1Cc8hEcK4w9mbNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315591; x=1732920391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9MEvLA3ulCq6qcBXHH/InNCpijjlgWwIu7JInjaPpA=;
        b=DNBWmPji3AfRtjEzNMscwQRSkyIHpEbOKHkUKPqXGQcisIrQNhmACcRQSqeignwlUu
         d/pRaiuavjjQYIzyDneC1zeQOFL8w6BpWYBYeS4bFg2jkX7hq0vWj5SMbxw8h6cyGGGQ
         4BlMDrn8cZICB3uZ8BT/jyZRGarsStoJvXlPtgEj4AeT9qwZKvQydFu2kK69FoPDgCz2
         Ay+NyDw0rcubuX+h/B3JJnB0hbZ4fYYQkyERUvFqgEUO8+Mc/hlzIXRYOisgFVfEQ8Zr
         9gQ8yQ+VNFsbZWwUs2vk02zIynDDyB5Ip1Lpfrv0jodnYlDC760jat/G0DqeBnJKjwyu
         NPVg==
X-Gm-Message-State: AOJu0Ywkubcl4j5X695DN0SIgHTNTbLrRvkVN/YgJl8f0BYpdUdfezX8
	wysOTsjMwZ/Vi1az1LlcWjBX5iV0Qfcl9BwpTyJwMEnEt6dLacCMMv8QaV5WeQ==
X-Gm-Gg: ASbGncvvoJ1YvHnOgUdBkPq35NDY2beMqwAAAOx4LfmODGV0II605ogtjxysiREkC7h
	i++RqgTnPFftCDZJWZhxVyehEy6aIrcamCtjprxcQW8r8XPsUJVfdrBAD0r2ZZZG3HkRAoGr+fC
	d+fkMgQ/FQJSysxejaOrSbSYZXbdWHcAyXmyKAw1IENwvmy9LoK3fSS14BGG6Jwy0W+ZmTlUY5f
	/fLTkM2CU0YRrcKWgBaxdM44FF0ukX4HvHiV6xB3w0mVtZIWEiTPPZpK631VP2mGgIE7SgqRo5r
	kon2I9xEMOnTb+piiBuvmlgc2Q==
X-Google-Smtp-Source: AGHT+IG/X4WBszWRBBcYSyNKhhBlhVTVHGAKvGREF7bkd1SHgwoxYy53345iuqtYjeaaxyG/aJCPHw==
X-Received: by 2002:a05:620a:4710:b0:7b1:5311:1379 with SMTP id af79cd13be357-7b514517ef7mr592922185a.16.1732315590907;
        Fri, 22 Nov 2024 14:46:30 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51415286esm131270485a.101.2024.11.22.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:46:29 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH net 1/6] bnxt_en: Reserve rings after PCIe AER recovery if NIC interface is down
Date: Fri, 22 Nov 2024 14:45:41 -0800
Message-ID: <20241122224547.984808-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241122224547.984808-1-michael.chan@broadcom.com>
References: <20241122224547.984808-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

After successful PCIe AER recovery, FW will reset all resource
reservations.  If it is IF_UP, the driver will call bnxt_open() and
all resources will be reserved again.  It it is IF_DOWN, we should
call bnxt_reserve_rings() so that we can reserve resources including
RoCE resources to allow RoCE to resume after AER.  Without this
patch, RoCE fails to resume in this IF_DOWN scenario.

Later, if it becomes IF_UP, bnxt_open() will see that resources have
been reserved and will not reserve again.

Fixes: fb1e6e562b37 ("bnxt_en: Fix AER recovery.")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5f7bdafcf05d..3eeaceb3ff38 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16478,8 +16478,12 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	rtnl_lock();
 
 	err = bnxt_hwrm_func_qcaps(bp);
-	if (!err && netif_running(netdev))
-		err = bnxt_open(netdev);
+	if (!err) {
+		if (netif_running(netdev))
+			err = bnxt_open(netdev);
+		else
+			err = bnxt_reserve_rings(bp, true);
+	}
 
 	if (!err)
 		netif_device_attach(netdev);
-- 
2.30.1


