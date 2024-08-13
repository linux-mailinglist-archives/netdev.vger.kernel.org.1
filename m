Return-Path: <netdev+bounces-118149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296EB950C3A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23191F224B2
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1DF1A3BCA;
	Tue, 13 Aug 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YB2Fhnz7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10531A38DF
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573683; cv=none; b=t5TfNA65+eC02VD2+erFIChKEPWlhWCux32yZ5oiUjJQpatpXsNxBCo0xKZ6P+A2isp1HuMRGKR7FjMUAefjWEjSaDpGy+ZY0AOJ5iQcRdbbWIp28CdNImnPJ/8aj3LdT0QIfsoh45KUHCkl6qjwUB27g4rROFf5BK5HJWM5LTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573683; c=relaxed/simple;
	bh=/f0liMwdFEKT7a9xgkPkH9Cx1ArNObmnYwWZxxCvP3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RVgitREwbQJr2ZcXdp4P9fVzhjaZoI2oYONacKMX/kC+aBUaEz3AKnqB9N9Op1FHI87S92B2N9la14dl7E7hiWR8PUypNQwOXFCFLdPO3a2Cy+EJqKw9NDn11rEUuc26PAeoLCJFxeI88WZHYu6yvXmZ3YBG37tn8Y1SCrDQliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YB2Fhnz7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e3eb3feaeso9623420276.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723573680; x=1724178480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0FUwl2486l/jeLoGKzs9tmDqeNS+tAHZe3YD3ALXm7s=;
        b=YB2Fhnz7zK4qon2QngSlVmHL7TPsH8eGCcedOwjP3lVLlj7mc5BWm8/uwOs+UzZEwV
         5N1z+UhsM0hxMlM95mXA6A3ljLKKwTSnkjJDDcBwVf5VHKgdYiQLZ2rcTLw03eyLlybM
         abZvip6YyUyDfK0fKApj652piqtCCisnzE4pgNeSj7voVEby7YY2FDqa3o5GZN3tDlKF
         KKhcNonnNzvs1DFjUeKy07RoYSyiEXvXzOHgW5D2BatPe8ioRbOJdeK9ERp0wd7xfvHu
         SRft6LzhVyWRkYEzMhAyRf1kVERrOYWHQa2Ma7V3Di+yxVpcUJepdRj0MM5expl4Ze0h
         ogsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573680; x=1724178480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FUwl2486l/jeLoGKzs9tmDqeNS+tAHZe3YD3ALXm7s=;
        b=hwcyjK5CNIqxbtHXPAXCPzeN/eonQZKPvxR5RE7SXLV/1Cb8RHEX6OmmMjLMNqxlgK
         oAgUl04QCKc9dWH00lHBYtmpEO8aNlcc65bqrNEY6pS5eXMiwFNgLZF09jg4Z8fw8HgB
         Lm8R/JnAVqFDCZlFRKKgmcuZNuu/tMxurBodY2/If+F4fTr3W3Cn3IcRp1BkG0AHPsrO
         FpO8u1sw3iuFk0ffkimHB5tcsYDKSFTmfndrFPqS4PcZV+qXWNhc6RPuc42dCGGruJID
         uMuuMyHWMjsK08TQpMPkWyXX1fCvAtDmn2Up3+14KDE3KE7ydzCtLhAAuJT5Ot9ukDW/
         XNXQ==
X-Gm-Message-State: AOJu0YwQv8aMhH/nK9jW5lRhmgwDqVXqSsLU+0bLKJCH7UjGZMAvWAZf
	f9rN1aJdL+O2R09j4tfW16aPaVidRAjUz7HUgDIw1XFmhLecPqnK2qeEP+bmvnSUq5U6lk/ovpV
	C8zsn19nU7QJX5HQBhg==
X-Google-Smtp-Source: AGHT+IEtLel87VI5FBoqzbu00ocynCKeHOTMNEky1uO+1XuJvYBO+DGemsm7Z+Cht2r0k2SIU65ZGd3kOoHSPEw8
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a25:a223:0:b0:e0b:f1fd:1375 with SMTP
 id 3f1490d57ef6-e1155bafbf9mr618276.10.1723573679918; Tue, 13 Aug 2024
 11:27:59 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:43 +0000
In-Reply-To: <20240813182747.1770032-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813182747.1770032-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813182747.1770032-2-manojvishy@google.com>
Subject: [PATCH v1 1/5] idpf: address an rtnl lock splat in tx timeout
 recovery path
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

Adopt the same pattern as in other places in the code to take the rtnl
lock during hard resets.
Tested the patch by injecting tx timeout in IDPF , observe that idpf
recovers and IDPF comes back reachable

Without this patch causes there is a splat:
[  270.145214] WARNING: CPU:  PID:  at net/sched/sch_generic.c:534 dev_watchdog

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index af2879f03b8d..3c01be90fa75 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4328,14 +4328,26 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 {
 	char *int_name;
 	int err;
+	bool hr_reset_in_prog;
 
 	err = idpf_vport_intr_init_vec_idx(vport);
 	if (err)
 		return err;
 
 	idpf_vport_intr_map_vector_to_qs(vport);
+	/**
+	 * If we're in normal up path, the stack already takes the
+	 * rtnl_lock for us, however, if we're doing up as a part of a
+	 * hard reset, we'll need to take the lock ourself before
+	 * touching the netdev.
+	 */
+	hr_reset_in_prog = test_bit(IDPF_HR_RESET_IN_PROG,
+				    vport->adapter->flags);
+	if (hr_reset_in_prog)
+		rtnl_lock();
 	idpf_vport_intr_napi_add_all(vport);
-
+	if (hr_reset_in_prog)
+		rtnl_unlock();
 	err = vport->adapter->dev_ops.reg_ops.intr_reg_init(vport);
 	if (err)
 		goto unroll_vectors_alloc;
-- 
2.46.0.76.ge559c4bf1a-goog


