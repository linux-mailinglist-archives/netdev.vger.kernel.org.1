Return-Path: <netdev+bounces-246192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AD4CE5699
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 538913002966
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB56275861;
	Sun, 28 Dec 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mzbt4g70";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxnRxO1c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CB2749D5
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766950867; cv=none; b=MSE2yWw9mT6CzALOd0S6cvXO+Ov0TUcVDBwRDBhm8CTMTPtZXpmecs+znXk5ki6NWVGyf+TaMy9R3QhliAOTa23J5RV0bME3vNMKT1UNhXTbejivKhuCBsKom+Vi1WLx4NOevGB6222S2pNTjFGvzAflOu5QwbKMeVArF2P7lVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766950867; c=relaxed/simple;
	bh=bVeIHnsRznSRVTSTaThyNQLQnQFJRmgR71IkurwZ114=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byAYYYtMJbuPZgLAmEP90PkyEsu4p/QPdkLvTDK+0fgu/nFJzLK2JBPkqQ/IbuLORwQp5Uxi1Mz1y51svGs9fEr4DGvtbjhAS+Y4qWkZur0GHBnBL1m2N/WApbvy60jCbpbDdE3nQ7iuOazuuuKvhR93Y8xeAGMXOMMdF65PyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mzbt4g70; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxnRxO1c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766950864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tgpPqPLmdsUsSPtNtkW8ABI8hPv+o/LIVKkz7BOGUxY=;
	b=Mzbt4g70xxTyRMrf0klOGFixx6nBsAGaJvT1bDIDlJE7UfP3ZXiz7lLqLoJYswVCSV0igD
	cGuJydR07ZiyaMfV88m2DDm5ZuGqM1VJLFRKFwA+GvRjqWfmLVM4i9Wv7E3rJxChpjk02p
	kBRqWRPANjT2z8f9GMZH6I0TZNDnzJE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-MF1RFa8APP2m18cTekeqwQ-1; Sun, 28 Dec 2025 14:41:03 -0500
X-MC-Unique: MF1RFa8APP2m18cTekeqwQ-1
X-Mimecast-MFC-AGG-ID: MF1RFa8APP2m18cTekeqwQ_1766950862
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso4265619f8f.2
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766950862; x=1767555662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgpPqPLmdsUsSPtNtkW8ABI8hPv+o/LIVKkz7BOGUxY=;
        b=TxnRxO1cTy2txEhXzkCoS7ZR6ZhwvqOfLRe16Ygs7tb0qi5U8YIv8Imsa7GEd5jVhT
         6gW9O6z1VHUrCGzxjw1Pr/IHLZXBjSluY6xbGplobFk91MqB3UQkab9S0wnSgHA2h7bH
         SC5eR83KsVsQXzqqpaGcMMYyiIYurjmi5qESLpE7qcE3pVLI3LHQPanXNPh0Op+rSKE3
         2RkqdzmyqTvvovkWfD6iJ1lvTo0ylMt77mk3KmJ5S3m8IvQ4gw6xkmSuxWTggRudPz7p
         0yEMFm2pw6rg+X0ygVE4UVkwBm8YHZkwGGyTj5jVBp/7kCMsAx++mSiWOgCyX/gtJOtr
         idYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766950862; x=1767555662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgpPqPLmdsUsSPtNtkW8ABI8hPv+o/LIVKkz7BOGUxY=;
        b=tXON8zJd3twT4vXV9IdRb3Jy4HevOS2QrjKunrXY0/K7hlgMP9JgEHKuBIlwXBxzDg
         jh+JOzzo4fCtu3gBRIcmf5oSkzkBLO8GnGVJtouiehnq3QP5xSEsgjCCcGo/c8vDVgWH
         8aNG969Fn3UZ87OG1d73Eafe250bfV6/RQYeu+l7Dx2UbKtazVez1+YOz8+80XaaA0Dg
         neA1t1uXend63eQVNsbXv4HPJ5uSEqFHHzPOWLXd/n33Fcmqxgk475mZrleUk7V0J7qF
         mE0L1NgW7Vk/PRdgHLu6uQdxrjdAortdsxrkkdil9osodcyhDpiH1ejtX5lbah/xGLyM
         S+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUDc0cDGhkopzCor2nk/49vkqXVupK5j2xqs7uYOcItayOkoevj4EYx6bHo/Xm5BxsfOgZ6fP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MbkUp37+94Mhe7xEIT/TL9GYVUONeLUw0xaa0DFN+R3EdulM
	s57C2JYEMXVo1qbcCIat7YTmnsMg43o0AnkuKVWiE8gtNR/D6mQDM7y2+SPkZrnI0asRcfu9UKu
	GXotlF7bH8nlBbs2iUhU63EySbEGx7glKslvulbCqVRIBwz0hTuECSzYoVw==
X-Gm-Gg: AY/fxX6T2Ek5Qun4mBi2BS2mYNh906XwKzMMihdKUYJsYGJ4o6NxvU6H0th8dt9+0Mp
	RcVbl0SnF2fsCuk97rdWDQ/zwQXJKcSTddafVdtjHuUkC/n2Otkq6E+tiqbkFOa720bvXUhdOxO
	kOgSnBCcwpVmYhtB0ujJ6oFdS4yeJ08/JR/E4TIAu6COkw07RPsm+VbdfaM72RyaFFb2aevQ5yy
	0tgL1i99tNl4/tP+I/ITb2ertYN50/xX2535vqEK5CHx3JxTElV/WotiQk98vrq/NqGUcKbUbYS
	7FkvHGUWdY2JThi81SNimM1yvpb3HSZc7Zy18MQSoLDrgn8VW9g0UZG8SfxuCyBXlYHl69qYX6O
	FZosDx9UcgbrGW8xMTkuwWg==
X-Received: by 2002:a05:6000:430a:b0:42f:9f18:8f59 with SMTP id ffacd0b85a97d-4324e50b471mr35307069f8f.42.1766950861752;
        Sun, 28 Dec 2025 11:41:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN0f/djG7K7w/HXLKoMoes4sa8eQvqL8fgjyIBeFFkOHGllELBBbk0GskntGEXjDDsTCwySA==
X-Received: by 2002:a05:6000:430a:b0:42f:9f18:8f59 with SMTP id ffacd0b85a97d-4324e50b471mr35307056f8f.42.1766950861377;
        Sun, 28 Dec 2025 11:41:01 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm25324182f8f.11.2025.12.28.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 11:41:01 -0800 (PST)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	aduyck@mirantis.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	pabeni@redhat.com,
	Mohammad Heib <mheib@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net v3 1/2] i40e: drop udp_tunnel_get_rx_info() call from i40e_open()
Date: Sun, 28 Dec 2025 21:40:20 +0200
Message-ID: <20251228194021.48781-1-mheib@redhat.com>
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

Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
i40e_open() resolve the locking violation.

Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0b1cc0481027..d3bc3207054f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9030,7 +9030,6 @@ int i40e_open(struct net_device *netdev)
 						       TCP_FLAG_FIN |
 						       TCP_FLAG_CWR) >> 16);
 	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
-	udp_tunnel_get_rx_info(netdev);
 
 	return 0;
 }
-- 
2.52.0


