Return-Path: <netdev+bounces-247532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0927CCFB8E3
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0B8303C99C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B123BCF3;
	Wed,  7 Jan 2026 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngMkZEva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C421CA03
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747916; cv=none; b=XYC5R46uICr0klAuOOkdCvDZoBtVDO0ZjHM0Qu/ZE6k/Xjo7CJzqTsF2x9nDXq3+k8Rbri9kf7e2Gf/ssUhC17Z4NsaehKgZ7YRb7VLB93BaKQyxXaWYl/6WXrH4teJ6B9b33gDjkXF2UmwgJDaXsL0jJoetsgPw3IAZjtOH9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747916; c=relaxed/simple;
	bh=tkLJE6mxW9kD6LFeLnXQRH+Qpbe3qoEP5gnI/ETjkYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VhS3v0zZYjiPmvq2OwKWGQCJ3OX08NtZ0ZSOiQlMhWU+Orwywni0tEyAj8r8gRer/hDqyPSkx8NHV8NdSA+6XYQKEV10YJRuWCKr+N5ckjhDpu39wvGblZnsV3VTmQ2Kd9V+u/1e3YZh6XEimL0+E3qh8Dt7ADHGERoBASq4oDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngMkZEva; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--boolli.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11ddcc9f85eso296764c88.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 17:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767747914; x=1768352714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVMU6yQcsBfSJN4wWGFbhK9cF/Gmku+mF1OJ5kiuDgE=;
        b=ngMkZEvaoOJeqICN8hRXap/kBc1i4Bz/RtrQUWwJdzGQimL8qZkqbgldFklLrGbZOd
         RrOT4NvbDjbqvH6Rz5J3GBKddRa34QnwvyyGeZC2Q/Hk4rTnr5WmGaLQj6mqZkxUHbrB
         Bq6g1sCjixw0CP+5TgErbCF9HrC6bUoiYwa8xUTH27Dvywa8KBh+MXOeHRRcWxQZIEwD
         qkWTjcUoe8mVEJ5XOf9K1STmMNJiUQ8wTkA57XBT8FncoQSFi3hwnefeo2RYQyylOqNC
         SmLBb/HRW79dP25b27/yDUzCYpYGvb/ufceAc7N5z4v8rDLJL85nFq3w+x76+c1vL+Fw
         oXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767747914; x=1768352714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVMU6yQcsBfSJN4wWGFbhK9cF/Gmku+mF1OJ5kiuDgE=;
        b=Mwtandbh+KfqiA40McI/Zfbl8XFGrA6vnyvA1/FuK1gai7QGJISZoDz06ubQH7gvEV
         LU6ahRmKNLMgRBvvyn3WtZtmysmic6rcSG9Z3ypwKUsFPiOoZSV5YCmhqsYAUahSCGOE
         Z5Q5ZoGhDvs3aDNWMtAE9E9CHyJ+BNvm4ccyeE+8TMZSO9ij+9LjqWB82H/vBoSaYcPb
         d58Hp956yt625SXnyjq9M6Bk3Yb8CrnL3IPYqJr0mCs9oKmLdrmxUwIsw9rd0T8fy7F9
         L+kCbBqagYxJDwzwmP9/V/9/P8N2QgWWm+3EY6gNws+3sHPZbNK0GsdUm7ExKJMzGp7g
         6+oQ==
X-Gm-Message-State: AOJu0YwGNTeyVTqOyoKz9I6eA+D4BL7nDdgXhdqYX3fFKSgQbh2hPV5W
	7MtxjyPW8wBGg7cxBd9Ojp9sd3oU7ZZg+MS/woaMfiSr9tm7jd4VbZynYf1tzyJ3BidZaIf5J8Z
	KoV2FOg==
X-Google-Smtp-Source: AGHT+IEimtIxB0kDVopi3uqHoc0Swa3Du9lb+RqD1lMp8iOBNaJDFMF2YObFUEkWmzhx8yWtOHWSy33uHcg=
X-Received: from dlbcm23.prod.google.com ([2002:a05:7022:6897:b0:11b:1a9a:d2e8])
 (user=boolli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:249f:b0:11e:3e9:3e90
 with SMTP id a92af1059eb24-121f866f776mr891858c88.25.1767747913845; Tue, 06
 Jan 2026 17:05:13 -0800 (PST)
Date: Wed,  7 Jan 2026 01:05:00 +0000
In-Reply-To: <20260107010503.2242163-1-boolli@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107010503.2242163-1-boolli@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107010503.2242163-2-boolli@google.com>
Subject: [PATCH 2/5] idpf: skip changing MTU if vport is NULL during HW reset
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

During an idpf HW reset, when userspace changes the MTU of the netdev,
the vport associated with the netdev is NULL, and so a kernel panic
would happen:

[ 2081.955742] BUG: kernel NULL pointer dereference, address: 0000000000000068
...
[ 2082.002739] RIP: 0010:idpf_initiate_soft_reset+0x19/0x190

This can be reproduced reliably by injecting a TX timeout to cause
an idpf HW reset, and injecting a virtchnl error to cause the HW
reset to fail and retry, while changing the MTU of the netdev in
userspace.

With this patch applied, we see the following error but no kernel
panics anymore:

[  304.291346] idpf 0000:05:00.0 eth1: mtu not changed due to no vport innetdev
RTNETLINK answers: Bad address

Signed-off-by: Li Li <boolli@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 57b8b3fd9124c..53b31989722a7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2328,11 +2327,17 @@ static int idpf_change_mtu(struct net_device *netdev, int new_mtu)
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	if (!vport) {
+		netdev_err(netdev, "mtu not changed due to no vport in netdev\n");
+		err = -EFAULT;
+		goto unlock;
+	}
 
 	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	err = idpf_initiate_soft_reset(vport, IDPF_SR_MTU_CHANGE);
 
+unlock:
 	idpf_vport_ctrl_unlock(netdev);
 
 	return err;
-- 
2.52.0.351.gbe84eed79e-goog


