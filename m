Return-Path: <netdev+bounces-247535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C58CFCFB929
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B780E30B472D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3342571BE;
	Wed,  7 Jan 2026 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+x+qzSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201925EFBB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747929; cv=none; b=dF8aQz+y7ivLqHwqHgbLGx+3kG8nHg8cG3EDW3gr5ReLmNTD2rUdWpTbe5okfXlOuNQfkEuxhVEO1DiXOkNQv68ZPqK8fTtrJgbnCLiNv36yRKnDeX2JLYSaVmSLRtxz8r+caMKa7LxbxEFIulCvLetEuCpPY2TuJ6YwX0K/y3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747929; c=relaxed/simple;
	bh=SLCRHGnMwqJIhJ0TpClv/X/QfNePibMx0MN9q+ZLWOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jEkVDlvNi7ryhhakSu27OqFe4vShpBe2FfShhrx08nps6gDbfZy3qLupGWJj0nKnMqeR+bUnUcqyH90aVU+IcR8lNZfTOoWa2Z+spPjus61ZVL5+JJ8njjlw01zMvtI++VJw8VLvQKFr1yae90S8KAmFe9uW3i28cDY/B7V7H+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+x+qzSQ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ae32686ed0so3085701eec.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 17:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767747927; x=1768352727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4zvVVulXdWhqadSyWFUhE3bReQYpV8j/iFRIL/Etmk=;
        b=z+x+qzSQanQi4Lu5ypxT7VlhiLGaNTWXjaxF9YMEhKJPIKKdr9KH8lw1rtULrwJ1dJ
         pHHSeu509nr+y0kgnc8gHZATMiN7wUHzsMmjn+sDwKASnawSqUv5e94tZ+gf2B4KXvYO
         wOWi+Dc/rFgeH8W1rczpb2SFRltHaSezL1GdrOJXKEcOaw8XCIQZrTy63Y8P5p5cs1Jf
         l/fql/ufTOsCUNbtA6o4EgKk21n9LF72aY2et2oOf0PB8Ek3NH5U4aXkyCKKxexhZzq8
         WCyiuU3PF9/HAG/Rlk33QHS3ghqZ3z3Z1OekUbaX0NdrEjdTn1gzhNUxoVaGVxyD0rz6
         SyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767747927; x=1768352727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4zvVVulXdWhqadSyWFUhE3bReQYpV8j/iFRIL/Etmk=;
        b=WQDOdUGHnhf58X6DPyHb5VlvV7KZoAfBF65ucpI227m89hIPjQTSvOIFcwHZKQwthS
         eH2FtKBiQp2tIxgVngPLxZ0eagcRjWR74fr7hMiHfhHwU6BGVMomXspXquBiL3QU711V
         fN1SYrYp9HsfGvY4DZ5VlVAEbcfjuyjWCXFSexFk2S5gWqjZ2cRnm25bY3nOsRCsVo/r
         Dq8mXcnCzpy95by0bbmyZbuz4uO9JFAeNemxM4Y8M1fH31D6Qu1Us+g8yx01C5OnzBgA
         iRFlHIxrFDqe4jfj6cCObe4C2o8AvKa+bVmyczj21cpy5tR0C5DdC2x04ProTP5ybQtq
         TMRA==
X-Gm-Message-State: AOJu0Yyi13MTd5mkKwM3QzyUv52wQRX0k/PMsobPRCm8cR/Fy4ztGH97
	s77CJ18i291pSI7PYAJkNnedMhyIFEs+Uc8g0tmjfmRD/Qw8SjpK7P9uwu4sTiXGGv6nDgOW5+m
	208Zfyg==
X-Google-Smtp-Source: AGHT+IF/T2qxWGqmumi/bkN87o7jran59XQI0j+hSUBAJ3tgiDQyNNjx2d378nPm27Dc1IaYsAmT8P6LEV8=
X-Received: from dybsy4.prod.google.com ([2002:a05:7301:7004:b0:2ab:f916:f31f])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:438c:b0:2b1:7486:3a6e
 with SMTP id 5a478bee46e88-2b17d20777amr392773eec.12.1767747926653; Tue, 06
 Jan 2026 17:05:26 -0800 (PST)
Date: Wed,  7 Jan 2026 01:05:03 +0000
In-Reply-To: <20260107010503.2242163-1-boolli@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107010503.2242163-1-boolli@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107010503.2242163-5-boolli@google.com>
Subject: [PATCH 5/5] idpf: skip stopping/opening vport if it is NULL during HW reset
From: Li Li <boolli@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"

When an idpf HW reset is triggered, it clears the vport but does
not clear the netdev held by vport:

    // In idpf_vport_dealloc() called by idpf_init_hard_reset(),
    // idpf_init_hard_reset() sets IDPF_HR_RESET_IN_PROG, so
    // idpf_decfg_netdev() doesn't get called.
    if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
        idpf_decfg_netdev(vport);
    // idpf_decfg_netdev() would clear netdev but it isn't called:
    unregister_netdev(vport->netdev);
    free_netdev(vport->netdev);
    vport->netdev = NULL;
    // Later in idpf_init_hard_reset(), the vport is cleared:
    kfree(adapter->vports);
    adapter->vports = NULL;

During an idpf HW reset, when userspace restarts the network service,
the vport associated with the netdev is NULL, and so a kernel panic would
happen:

[ 1791.669339] BUG: kernel NULL pointer dereference, address: 0000000000000070
...
[ 1791.717130] RIP: 0010:idpf_vport_stop+0x16/0x1c0

This can be reproduced reliably by injecting a TX timeout to cause
an idpf HW reset, and injecting a virtchnl error to cause the HW
reset to fail and retry, while running "service network restart" in
userspace.

With this patch applied, we see the following error but no kernel
panics anymore:

[  181.409483] idpf 0000:05:00.0 eth1: mtu not changed due to no vport innetdev
RTNETLINK answers: Bad address
...
[  181.913644] idpf 0000:05:00.0 eth1: not stopping vport because it is NULL
[  181.938675] idpf 0000:05:00.0 eth1: mtu not changed due to no vport in netdev
...
[  242.849499] idpf 0000:05:00.0 eth1: not opening vport because it is NULL
...
[  304.289364] idpf 0000:05:00.0 eth0: not opening vport because it is NULL

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 53b31989722a7..a9a556499262b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1021,6 +1021,8 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
  */
 static int idpf_stop(struct net_device *netdev)
 {
+	if (!netdev)
+		return 0;
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport *vport;
 
@@ -1029,9 +1031,14 @@ static int idpf_stop(struct net_device *netdev)
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	if (!vport) {
+		netdev_err(netdev, "not stopping vport because it is NULL");
+		goto unlock;
+	}
 
 	idpf_vport_stop(vport, false);
 
+unlock:
 	idpf_vport_ctrl_unlock(netdev);
 
 	return 0;
@@ -2301,6 +2308,11 @@ static int idpf_open(struct net_device *netdev)
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	if (!vport) {
+		netdev_err(netdev, "not opening vport because it is NULL");
+		err = -EFAULT;
+		goto unlock;
+	}
 
 	err = idpf_set_real_num_queues(vport);
 	if (err)
-- 
2.52.0.351.gbe84eed79e-goog


