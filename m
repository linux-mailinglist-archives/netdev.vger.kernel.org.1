Return-Path: <netdev+bounces-245231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEFFCC9575
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFE04300A21F
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ED8252906;
	Wed, 17 Dec 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF4KZAkQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tJc+77zq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7223EAB9
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998020; cv=none; b=E2Vmt1uvv8Q1uiShrCPd83V4zj6aNBtTNv9F34jYLaHMAQe2Kft58UIgwVCCaBTUQ2bnB3HkMARCAEEn6FiF2MJZQU7b8hS7jFuq2yQQ9Ub+JSoool6T0x1Zeq8ec7tJA9dP4i+K+8HzkdkdzyAkWPOCUk2b047VPIn6o+jZBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998020; c=relaxed/simple;
	bh=BBYK8CgBjBl7PtH9kL65a30kKeC/0Zqhs2FdFxfB88I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3ppNek3K7lAZtVMzW/j+Pxwe5tnAtako4UeIG/4D9xW+DjFn2bGTC4WP/TfZV02RcJLeF8u3sNExga9GvzqG9JJGiresGnP4n4KJ2psrBAdPksnuOfBXtmoHJ4dXABcev1+p8gNkvWSG1aF8MXNxZ35IQVCZo5OdgXaDgAml3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MF4KZAkQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tJc+77zq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765998017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lfGk7+oVfvLYko0BsDkxGdiAvj1TWHX4wJkqB0V3lQ4=;
	b=MF4KZAkQDB9BK88v/l/wNWwiWVXOwIS/rF6/rnTKpAgL/QpYKpxpiGO6mwdt61RaLg1OAh
	Vi30vD3g8+Y/YJ0LXi0EO6s/PonKOu0UR28rksXPQpgZX8/UpzhZ1F1n5ckc8JBWyOAiYG
	4EqkC0Fe0ylPYDsXKnv0jLh7JJSOF0Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-_uqN3Ey-PdmZZrLed1fCvQ-1; Wed, 17 Dec 2025 14:00:16 -0500
X-MC-Unique: _uqN3Ey-PdmZZrLed1fCvQ-1
X-Mimecast-MFC-AGG-ID: _uqN3Ey-PdmZZrLed1fCvQ_1765998015
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477c49f273fso76614305e9.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765998015; x=1766602815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfGk7+oVfvLYko0BsDkxGdiAvj1TWHX4wJkqB0V3lQ4=;
        b=tJc+77zqQtsKwhu6lxUum8hZ9GMYxJVVuSeILgHPvab9vgzEYlKY1bFbYQVQmump1b
         +LxZbE0MAqkzuJ37FwgDIw0Na6445VX/T4+jKZO8GvSJWnYrJe0Ojet1LM7VFCJmWVGF
         /6SdwE0j0dcHaABCyj/DphrnO00d4nsuMN+SAZjizapbqNuAq2E3q0gTsVHV4q4CnA7J
         GC+bDkULfaBTGH+Fi5TZgQ72d2mPGyAZwjXqV4ZlKLK1PKt9626c7DabZn5At5Dfrxj6
         1QlxliWRueltRWvb2/B2KKOmcaQQMC7HIgvyFGVQ5ow4sukhZOvVRLu6iDCP9hO1qoEz
         /ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765998015; x=1766602815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfGk7+oVfvLYko0BsDkxGdiAvj1TWHX4wJkqB0V3lQ4=;
        b=NqpgSXOkAnv/VYnSlhVYGvCeeTfdl5XrtFpsW0ut8Hlj1dtLBK81jwIlH9VxWz/5LV
         1pQJsVHonwDSn6+GcFoivxyvRAxg9nTeeT0S/pUJcwYi0UJ1j1UhvdK9fuZKp85Zk++3
         KGOCKFHgj6nuZaOBsgYRLdpD0JSDi285D7utG8zyoju3+aSnjFAgvMJ5tvQpteMVgLzP
         deT0zLwuOSiW1Tx2kD6euG36dHmDf+J25spSjSJ2ExzSoMTh/jtVbvvSwhtK/1ON98Gg
         yl0gNs4cM7vkX4vnWZobX+cpRN7xmK3oMkWZcKi/4vc2a2W/YxUkWzs+pXB8LL2FpBqb
         0KiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGlAoh7wbYA07BmR7kGlD0L6gvju/d1i841fpYZw+Wd5HldI3XKTe835OnzUfDtXItp1DOVi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27cJOodDpopu1ZL2Rd/oLqPTB1rxBZcCr0I+VjFS1S4g4zXNQ
	kFE8WhNg3RDJtw9CS6Z0OjaA/2Y2W0DqYVYRN8uNAvDklDeKiQOj0xLNXG/Ec7YASwYRF80Gmk3
	qaQfMzS9Ojj3dTcYZMOIrfXXctuK5Aj4geL9ikckzBQe6T+JSAkZAs8xQfw==
X-Gm-Gg: AY/fxX41p32YTxvnVmr6EeBMp7rdoeNrikQBtJhw0onsPCivfTdax4zEZWwdZYkcjyG
	S+OAxkplU+NjD4HIgF/crpxXvWu37DGVLiUR+BRXviEf2tGjad1yYd7B96NAbNiP8kIQQmLXmQN
	o98LP5fNN3q5TIAVa/c2Th3g7nphrIlA9+uqtzQWB1crk0M8UCkfgO19BBf65chpZ5uwNGzBhay
	CbBmtki1wL0jtUBSvwp322vK9axLa8gsAcdoOeFPkpRVVqhYgV+UWiIK6HRDm1keWSRXyUY6LE/
	2Hg6N/PGVwbcb21DKRV2WwFmHz/cUzjBLLlWPGX5MXJV/mHekrKL8WPX/LSEsfXsyZyjv3/DJqu
	jwXimew3Vp4TRC0u1BmjK0A==
X-Received: by 2002:a05:600c:3b84:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47a8f89babcmr208611955e9.3.1765998014769;
        Wed, 17 Dec 2025 11:00:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu44GbYRGIduy2dloYuDSn8G1tvEdfmWy81SKIKbPB+oe9uJ1A88Mup8nlb7/yoPxURaa1Tw==
X-Received: by 2002:a05:600c:3b84:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47a8f89babcmr208611655e9.3.1765998014394;
        Wed, 17 Dec 2025 11:00:14 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723d19sm7782105e9.2.2025.12.17.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:00:14 -0800 (PST)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	aduyck@mirantis.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net 1/2] i40e: drop udp_tunnel_get_rx_info() call from i40e_open()
Date: Wed, 17 Dec 2025 20:59:50 +0200
Message-ID: <20251217185951.82341-1-mheib@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The i40e driver calls udp_tunnel_get_rx_info() during i40e_open().
This is redundant because UDP tunnel RX offload state is preserved
across device down/up cycles. The udp_tunnel core handles
synchronization automatically when required.

Furthermore, recent changes in the udp_tunnel infrastructure require
querying RX info while holding the udp_tunnel lock. Calling it
directly from the ndo_open path violates this requirement,
triggering the following lockdep warning:

  Call Trace:
   <TASK>
   ? __udp_tunnel_nic_assert_locked+0x39/0x40 [udp_tunnel]
   i40e_open+0x135/0x14f [i40e]
   __dev_open+0x121/0x2e0
   __dev_change_flags+0x227/0x270
   dev_change_flags+0x3d/0xb0
   devinet_ioctl+0x56f/0x860
   sock_do_ioctl+0x7b/0x130
   __x64_sys_ioctl+0x91/0xd0
   do_syscall_64+0x90/0x170
   ...
   </TASK>

Remove the redundant and unsafe call to i40e_open() to resolve the
locking violation.

Fixes: 06a5f7f167c5 ("i40e: Move all UDP port notifiers to single function")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 50be0a60ae13..72358a34438b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9029,7 +9029,6 @@ int i40e_open(struct net_device *netdev)
 						       TCP_FLAG_FIN |
 						       TCP_FLAG_CWR) >> 16);
 	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
-	udp_tunnel_get_rx_info(netdev);
 
 	return 0;
 }
-- 
2.52.0


