Return-Path: <netdev+bounces-247534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4ACFB923
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D55230A92BB
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55E0253B42;
	Wed,  7 Jan 2026 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALdfcc9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCEE246BC7
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747923; cv=none; b=FpP4dTkjeaqOvTUrI/eCz68NHqZjBPSvk40IlM6AUpNu3R0r1En8QbVvYkbi/O59JB0tWq3znD24zCevRyuQmmDZpRiUayhiNm656YYLfge0CAHuVaICEf8giR758ANkoUK51EPCytGnfISDlfBQUzagXOXhDmH5z1V3GCbXny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747923; c=relaxed/simple;
	bh=bLalVEMbPPKCA6Kn6BpvcZjDujpTlw81pSCK4D5YByo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BUsYHvhQTvh/nzJDnDxUe/VbyTH6Gpo75hsjC7WpxB/0Pml8zMUhuBE6J2teD9u4LLFqiVL1AIA6/j+rN116bjX00LnuIEVOcUj6MCmWQ1t1/M4eH1MAjcK9YWKW7U/3UxaJ/QFt3noPA7UdpO3/2hvm1HB6piwKimYMtJFr5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALdfcc9S; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11f3b54cfdeso1003872c88.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 17:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767747921; x=1768352721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYuKjIoFITh34belvsUGGdGwbr0H2yT+hfJIc/2t9is=;
        b=ALdfcc9SmcmkLscLx5yKf9O1aa+zEf9ZdHVFvGUhOzsW+jZbPByktpm3NGNQMHbYuG
         Zql3W2btAmRBhbmIFDuHAmP0i/kRGg1f638KZEgIxquT9Md6yRqd035QCYo5UoZHPpTM
         oXzjtL9YeRsQYTnuFZDVU+xWMyuB6AFE3YBAV/2+6n58spUMABsYjfhQNW3CwiyO2MEO
         kCYORkD/BzPzr+WNZqBQanaDMbpI1DvanEdwqHPHp0WMsv3umKnr3nlJSJ0m+byM6YSZ
         3FqpPgXOthtyag2Jluj83mr4mjXdhSwpCCt9GIv5veaWMMz2HghqWHS0UXKszved2xCt
         spNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767747921; x=1768352721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYuKjIoFITh34belvsUGGdGwbr0H2yT+hfJIc/2t9is=;
        b=XiIJDXEMEtjZqLDdT0qcbu/9fW0Sn1iI/oZQDqH8G4LvWuiaJ27ExFID0OEVnIudVB
         G6EqZjFuZWwRUuaFRSwI93lrEOYG14ETK2GlqGrrovkRowRg3czWYQVY0WTVWfQ7jAS8
         w7rE37C4OXIdV3Xwo01ceSntvKnwAQ54kBNz5F/UCgiuYhuapUoMCMr28M14Hk2R6zab
         OK46NUPQttLa8qTjxZyQnsA4Mc9RFxrno60jRQ/7jeC8AzxPQCxx6TWd24ie21s7g5xT
         AC+qHnzPUWHkgUc/A/CiZnH8X7Owlxg+xOfpNRGeF6r5UA6co2n6jBZXFt9tH6+AusKS
         9i+w==
X-Gm-Message-State: AOJu0YxPlCM7KObQ+xyjxFEFrMknBqrLNhD9lGEeydnm5BZoyOhY7hNm
	WQgQG1j9G92986Diz1bmnhaFZa7Aa7b1ipsqQLv17oTDXCwEXj9w89egAADmlHX59po1LvliAGl
	0hFkYBw==
X-Google-Smtp-Source: AGHT+IERehY56UWpPh//i5oxfb0HeZGQNoZ+QgzVqNukRsBFB/92C9fjnGE+fl3jAJe6woD72AFL9kZCyck=
X-Received: from dlkk2.prod.google.com ([2002:a05:7022:6082:b0:121:7c06:d4b5])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2089:20b0:11b:2138:4758
 with SMTP id a92af1059eb24-121f8b2bc09mr583152c88.21.1767747921545; Tue, 06
 Jan 2026 17:05:21 -0800 (PST)
Date: Wed,  7 Jan 2026 01:05:02 +0000
In-Reply-To: <20260107010503.2242163-1-boolli@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107010503.2242163-1-boolli@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107010503.2242163-4-boolli@google.com>
Subject: [PATCH 4/5] idpf: skip setting channels if vport is NULL during HW reset
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

During an idpf HW reset, when userspace changes the netdev channels,
the vport associated with the netdev is NULL, and so a kernel panic
would happen:

[ 2245.795117] BUG: kernel NULL pointer dereference, address: 0000000000000088
...
[ 2245.842720] RIP: 0010:idpf_set_channels+0x40/0x120

This can be reproduced reliably by injecting a TX timeout to cause
an idpf HW reset, and injecting a virtchnl error to cause the HW
reset to fail and retry, while running "ethtool -L" in userspace.

With this patch applied, we see the following error but no kernel
panics anymore:

[ 1176.743096] idpf 0000:05:00.0 eth1: channels not changed due to no vport in netdev
netlink error: Bad address

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index c71af85408a29..1b03528041af4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -580,6 +579,11 @@ static int idpf_set_channels(struct net_device *netdev,
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	if (!vport) {
+		netdev_err(netdev, "channels not changed due to no vport in netdev\n");
+		err = -EFAULT;
+		goto unlock_mutex;
+	}
 
 	idx = vport->idx;
 	vport_config = vport->adapter->vport_config[idx];
-- 
2.52.0.351.gbe84eed79e-goog


