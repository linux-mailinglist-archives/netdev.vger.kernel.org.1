Return-Path: <netdev+bounces-247531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8CCFB8A6
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA9813014E9D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A58B21E0AF;
	Wed,  7 Jan 2026 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDdgYpsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5B2147FB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747912; cv=none; b=NgOiuWzmfk5Jk6v2EQ7kOXGsAXgxWy00jUn8239UD07owAj5NsZYVFfRa2fMArG9IJP4/f5WXfXX91X3f79a5BPZVOcOuaEvBb+0qMShqw8XYipZ9r3liz+ubKXt1vnU25G2hk5HvjwRUxz33WuRV0wVLPdsZVuSSw/Hq8HPApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747912; c=relaxed/simple;
	bh=yi5+pMrKmGZ6daJVpWr/Dn5GkPLFufcm3F0dCeL2pkU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gVtDBowZi/cat2u7d+9pKEqJ2H13ub7XDi9Ik3zuowzVSZAvYlxA/axK26XH3IryXO5z0Asut/OzAO6OuZnrFK7TgjgqmVRpJuoeIRPWOzP5W9JeYBaut81MeKDi2gvYUhF98Kzn42CfkZn6diDCDgnp5AETlAMFatzVFAoE9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iDdgYpsu; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11dd10b03c6so1326200c88.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 17:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767747910; x=1768352710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rZnlneAj7hgChlZy1AzKKPt9WN3tQFEPm48Mh4Bhh+4=;
        b=iDdgYpsuG92jQmWgCbYPDN3IrT5MH8F9w3cDa61J4q1cB4wtLgkLAs3XlzfRppfuWr
         xFAgvuR/S1Tfrfie3p8DXj0xjBxGEYHI2hjxMzsPhKxwghGuaVamAcbhIDxlGiauLUPr
         6GHqsQhLDipL8WnidkEs6Xnxmjh0BucAbxBcRcgt8E7rarQxo1lyIcxjou8abxGySq3L
         8vhmKhW6lsmGDrIkeqfdmUjyl5QNvTH1zvQHBNleoVzCZgLBpUO8wQIFay3mvNn9Fplo
         9EsC8fPJKYU4G9HNhQtHXm/oN6wyH59CIfWlqHeB6k+a2IXzx4zJrpzuotGOtlVTqlS8
         h/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767747910; x=1768352710;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZnlneAj7hgChlZy1AzKKPt9WN3tQFEPm48Mh4Bhh+4=;
        b=Ce/dBk0mMhmpqFJh3H32gI8jGDH8ZGCBwuYthNiikq7YDL4ZVh1pswMu1CJudnp3Zx
         rdewTYKUUfSxpNcZWIAlfQGnH/07P3qZCFfOGZBtwkJbGNr5YOLXTzatpJbN1JksR9fj
         Od6TE8coxv8BHZOxbqeX4EdofR7xHIcvqVyrhuH+Myf/mHf21+SuOHLs04JUdBMgGmIx
         bGqJWOlIUvAt1h4Wv7tfWkFVSf8KAc/eVL1Q2P5VBQV/ul3S5C4RJuL8jGhvRNzaTwAD
         4yG39tukeJfNPpWiUciIQ3NYbLS31HWv+5omhfAElvYQ2amPFUd0SX9yln3dcB4Kp0ft
         4tEw==
X-Gm-Message-State: AOJu0YycfV4CnuoQw3DimUft1yy95W0HhA7SuEbe0GzYwGhFWGhgo0PZ
	hC8JY2A4LmUg88/eD21eCP/qNXCGybBkskPrROK4KBBmvv4NmMBGjgJOw2LDNVCRKHkcdSvfXDI
	sqTpPqg==
X-Google-Smtp-Source: AGHT+IEIMwo+GhXyYaav4bZt4bXx4Bq/G6qliaYb7DkaK9GaSdFR8UCT1MNfsEZ7Iz4rAKjp5sPd+77dXao=
X-Received: from dlber3.prod.google.com ([2002:a05:7022:2643:b0:119:9f33:34a9])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2217:b0:11d:f44d:34db
 with SMTP id a92af1059eb24-121f8b8dc49mr645885c88.35.1767747908145; Tue, 06
 Jan 2026 17:05:08 -0800 (PST)
Date: Wed,  7 Jan 2026 01:04:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107010503.2242163-1-boolli@google.com>
Subject: [PATCH 1/5] idpf: skip getting/setting ring params if vport is NULL
 during HW reset
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

During an idpf HW reset, when "ethtool -g/-G" is called on the netdev,
the vport associated with the netdev is NULL, and so a kernel panic
would happen:

[  513.185327] BUG: kernel NULL pointer dereference, address: 0000000000000038
...
[  513.232756] RIP: 0010:idpf_get_ringparam+0x45/0x80

This can be reproduced reliably by injecting a TX timeout to cause
an idpf HW reset, and injecting a virtchnl error to cause the HW
reset to fail and retry, while calling "ethtool -g/-G" on the netdev
at the same time.

With this patch applied, we see the following error but no kernel
panics anymore:

[  476.323630] idpf 0000:05:00.0 eth1: failed to get ring params due to no vport in netdev

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index d5711be0b8e69..6a4b630b786c2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -639,6 +638,10 @@ static void idpf_get_ringparam(struct net_device *netdev,
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	if (!vport) {
+		netdev_err(netdev, "failed to get ring params due to no vport in netdev\n");
+		goto unlock;
+	}
 
 	ring->rx_max_pending = IDPF_MAX_RXQ_DESC;
 	ring->tx_max_pending = IDPF_MAX_TXQ_DESC;
@@ -647,6 +651,7 @@ static void idpf_get_ringparam(struct net_device *netdev,
 
 	kring->tcp_data_split = idpf_vport_get_hsplit(vport);
 
+unlock:
 	idpf_vport_ctrl_unlock(netdev);
 }
 
@@ -673,6 +674,11 @@ static int idpf_set_ringparam(struct net_device *netdev,
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	if (!vport) {
+		netdev_err(netdev, "ring params not changed due to no vport in netdev\n");
+		err = -EFAULT;
+		goto unlock_mutex;
+	}
 
 	idx = vport->idx;
 
-- 
2.52.0.351.gbe84eed79e-goog


