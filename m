Return-Path: <netdev+bounces-267995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCzbNFdit2m4QgEAu9opvQ
	(envelope-from <netdev+bounces-267995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:52:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F930293AC5
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43CFB3005385
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D112417D9;
	Mon, 16 Mar 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhncS5Oy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90180288AD
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625939; cv=none; b=PVWMGig59Kutwfo2ooXyCMNmT3w/TVu/jbwabod+61i7V1uP01q+RFGntlVHCoyrxO+t6yICn9e+5cLZxn+3/6JsE8U2vbnAlLAm2ApOV6/iB3pENcTpdkD4VvhV+Y7F//AY6TVNDLRqhRhK7CvNXFnCMW3ki2m7PHO6XYHLYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625939; c=relaxed/simple;
	bh=HqjORkXyUAJZ5t09djKo2B+llLHFZYN3T2zYVJKoFPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jP8v4KXcK9Q29FeMgrQFLxmTFvZXD//Lnv1mmeC8YZoxnjSfYM/0GqeynyA8yg5xf0tPvrucVYOzNJVjFzPfnBK3DLsVPQZxNI0Jf3uZ1/T0AMOhpK0big1XY2YZUJx9DdlkaMDVxw/0ul/hfZ+OACe1wr5GHrj/6TZxO+HqFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhncS5Oy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35b85613f3fso1265439a91.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773625938; x=1774230738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPA/F/DsU0PSQq3nz65hqH1FDo0PeiWks4BdWpvXxQc=;
        b=jhncS5Oy3v7pjuYVGPtZEjRJz2ksp+Iaa9xcxVUtNHgdDDOg4DAWVfHn8hN2sgGfXy
         ukJC7t1voPCTpfgLncXLxPlhssWqqRf1g+/zhOej4vZ4Z+1uqYByAvgEE1+Nkkn/CGg7
         XoiYzRHBJPKuFukJOs5HRq8++V5yea3ad6m+7yElGRDSAuydElvenBdi15xSfbG1uinh
         c1LcQcLzENeFcoB/Su9yhqiYgQhnv8qpSHutj2/NVk8PfHj/7LHGkLORI/l4/asGva9F
         oiCpxGFT6F5hknX4vEm2ac2DWNyySD6P4OvLJquA1HkgZJj19UhY1ABv0EbsF9GRoXv5
         IvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773625938; x=1774230738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPA/F/DsU0PSQq3nz65hqH1FDo0PeiWks4BdWpvXxQc=;
        b=NW4obDVpTcVU1S19VJsdi2HNTScOKbYW53QkPG4YL+/W7y8fFn3KoLhNBSu2TVUnS4
         Gpai2pxhMZSXv1hxsNY01Jroy8HHRVNJ9YtQLssj7vD4T9IFfH4RaYURzzwFkTatOsyv
         Rbif9xpRqWVjy5uh4XvtwLyTwL2xL7jgkIKP5kCb7iq9V/+fGoGQjNzhUqUA0kWRUgo1
         CnZfuAzLVx0jve7OQMrYGNaaEt0JLoyKfR2BobWp8cISSrLIh8T44sNgrpQ5leA6uqB8
         w0HoxOC5MbvfT69Tv62ZxFbeSSJeoRs1F8Hu1/xSje2hME1XegCSyQim1sZmHtsUXtuY
         xfEw==
X-Forwarded-Encrypted: i=1; AJvYcCXWaVkZABZaKHA09OzctF5z4yeQoYs1uOEdgAHHSW7W5wc/fhx9J4uEaIXwAnNIslmdiAKBUOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKIXM+qgIPiPDViS8wFA3/1JDSbn7KOg1wFczwVO+z7oxKvBLt
	GX12R6Z0SBujoQmDyKm8oEDLkpBvmeIBhlzt7LUq6m/B6XrwE9VCMV37
X-Gm-Gg: ATEYQzwFKbXozr7AaikMuXN6XX3MukPlYI+MhS1XZYmNy2dL1TKlDl9meU7+3oXz+Mz
	cBsU9xYdkFsksDFvM1ovGA6llfXU3syuFlbYDvvR1Zas/LvGmfPG/HJaWLVQvpSqCEO87+QIoV0
	ilbrEMpjWBjL5BWwCVvb653CUykT4k9ZFmBiRghiay21k43OSCTd7MMdDEfc1FQwKJnLz+qVN4t
	BDMUJZHsywIeyydqMr/zuws1pz3w8VLrG33PvX1nNgtPaQ+eZTtxkgK0h6SKao1qhweZ7r1qASh
	iupjbvQiu8TJUTfSQU9RsPG7oh80ss/G5dxGhVsq4LMUZ3PKqhxenGBHC8Vjb4XimrpOnciV89y
	w1BxWnmNW8VfH8N8YSQWHXSZ3cn3u0MCdNnJlb5038cqrcYW3dI/uW0IbEBHlq3CfvFUIZgmxcZ
	GLB74TKFmPV7Ttr2GODLqp4jnZjKHuiywYypKk2yii
X-Received: by 2002:a17:90b:574f:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-35a21fdd3b7mr10281855a91.21.1773625937953;
        Sun, 15 Mar 2026 18:52:17 -0700 (PDT)
Received: from localhost.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9d6fe68asm725329a91.6.2026.03.15.18.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 18:52:17 -0700 (PDT)
From: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
To: rrameshbabu@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs/mlx5: Fix typo subfuction
Date: Mon, 16 Mar 2026 10:56:14 +0900
Message-ID: <20260316015621.41630-1-ryohei.kinugawa@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267995-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryoheikinugawa@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F930293AC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

'subfuction' should be 'subfunction'

Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
index 34e911480108..d549b43e00fa 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
@@ -120,7 +120,7 @@ Enabling the driver and kconfig options
 
 **CONFIG_MLX5_SF_MANAGER=(y/n)**
 
-|    Build support for subfuction port in the NIC. A Mellanox subfunction
+|    Build support for subfunction port in the NIC. A Mellanox subfunction
 |    port is managed through devlink.  A subfunction supports RDMA, netdevice
 |    and vdpa device. It is similar to a SRIOV VF but it doesn't require
 |    SRIOV support.
-- 
2.47.3


