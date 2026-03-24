Return-Path: <netdev+bounces-270873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGyOBWIhwmnHZgQAu9opvQ
	(envelope-from <netdev+bounces-270873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:30:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF4E3023F0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E283C3031F0C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321962877DA;
	Tue, 24 Mar 2026 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCSJx2U4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C271A6832
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774330203; cv=none; b=Scfc39wa+oOEn+/fNgykNslcAZtvHE197t0OWmraURSnphZPjDq6XSjOdqQmMUdhJGlsZXySFtv/sF9D4km9uEPlw38Hk4OgMLq6nW0WWAOjb/WpO2l3YZkZEkLjTLUHQG5XDnpNaxZ58LeTXytQs7MU4XudpuXqq2owgsQDqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774330203; c=relaxed/simple;
	bh=xNJI8BrDJcjv7B3CyIr/xSgaScE/My8YWxbTHX0hgl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hj2o7hDS/Oa72YqT2exBurgtA5T/puqrvBA4dASjUd+vHf1tUFoAwTWqTdhuXCYac5v1+pZyu0uSb6mic9+9OfR17Az29TN4q+zq5CtvUlgIPg8MIBPCNddJ+LfpSG2mqvKnTXxMmF/BypR7wHoslztFMx/fptrnYZASxk7bgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCSJx2U4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so2012887a91.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774330200; x=1774935000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWQPpxJJ5vqy5RevxN77SFSwx0z5emoC9WwG+dKY3L0=;
        b=iCSJx2U4HZsQdper25KI4WHkLKDbAz3U7F5tWdjc1f9xb56yVGsd4FYIuuGAyIr/mv
         pHz/P5TNk0ZbJZFhZuS/YJWgF2laHydyyW1pJzWnMQ4kwBMwjOdVWk5A03JUWBo7Muys
         nYaNgBJbAXCxthq+hHjn+dtuvY6Ojb8NjRIetdsthC1y8HfZAEUEu5zp34EryzXRcSVg
         fsQi5tZs1ZE7Wifrhem6z+Sxt0JQR4E+67QrodjkQIhHd+AMT3bqRfN11XgWDCgoX0L8
         ayqPjBKP8VLqb8fbZ/9X7R03bMT2iBlHKkp5xcDvfrgZ6cILbG3BxQYVHMy6PLjswzDc
         8Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774330200; x=1774935000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWQPpxJJ5vqy5RevxN77SFSwx0z5emoC9WwG+dKY3L0=;
        b=amr6c9Nou7xUM9d81HWe8HljeU8/CXhYb8uuFzkk01Ahiyslc3bFAXhEuTXWJUi9vF
         3IUt1ioILcr3iEhmcvwbFm15BgyxTla4px7wf3GR4okmotqoeOerqpEoo9xInq3k4qTr
         EUCc1z1r0URRSHPKb5y7wM5Vk6SE/Qkx/vQaj9blV3um+fDXbQduvw4lklOGEiEwh0ix
         IjBe0DKsptgdsIzLUXIyPVoKn8TJIvY1+Ih3Xi5Es4I8dKH1VRmN+pDwMRGVxEjW+oOh
         AlprstveWq+qp4CG8h4JYYvUMn9sF9ekC24fLk0J00gmXyk3XPPAWKBk2JdjwLx8UHCI
         TzzA==
X-Forwarded-Encrypted: i=1; AJvYcCXfwg/aj/zy0QSamlW2TB/KEGVuWtY7bhf/vIp3GFRnjPOn0qnrhtT6WnfobYA3o7/83jAETbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMrfuOmp8Dg544bcC5heXfbyLvk434V04UR1tV535xAX5mioL
	jF5WfmloSKv9qQBeyd3U1hTgViz2h1pO5M8hSd6LaQc/pugb2uJUjsna
X-Gm-Gg: ATEYQzxzscAmCKxglSsJd7qD8CWFo0ndxjjNwUDd2DwDgAen6R8iJyS5AxhqUBqiO38
	qEt2muoKJlM17AlQFfjbxdbLbijHMo/ua0oqhXpASHkoJkww+klA+c+Uypxi7ABxzq+CCfsBh/B
	5mBArDsMFuEiPoqUkJE4fQa1XqUmThlc2yRyjl//C3mJ9/pOvHG2noS/GKhUl4Czv+o0CqqZbXZ
	SHWvUuNwfzZ1aoPefEyEiLTrMDJFBrD73/MEphFjnA+FVilgILRuaADyaqg+tNYO6fKDFpVDJof
	UL8XNqUwZXrnZ5IvRdQGds9sGqOPTAGMqjZ4AIKHeRZFhkkE6mvb6V5MzT/K9k0zoJHZN0RPD0r
	8erXyuavLkLs88KiEFqIlDJIpSlfsqDeTeh63MGK/80UW7wOhjpcjwfjVLBjhdNCieJYZh0dWcI
	el68YUW0kNFd1dzm1884RCIiA2Q8z0riPqMhZ2Eard
X-Received: by 2002:a17:903:94f:b0:2b0:76b1:93f with SMTP id d9443c01a7336-2b082734032mr121627425ad.18.1774330200449;
        Mon, 23 Mar 2026 22:30:00 -0700 (PDT)
Received: from localhost.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516b96sm165458525ad.7.2026.03.23.22.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:30:00 -0700 (PDT)
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
	linux-doc@vger.kernel.org,
	joe@dama.to
Subject: [PATCH net-next v2] docs/mlx5: Fix typo subfuction
Date: Tue, 24 Mar 2026 14:34:10 +0900
Message-ID: <20260324053416.70166-1-ryohei.kinugawa@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,dama.to];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270873-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: BEF4E3023F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix two typos:
 - 'Subfunctons' -> 'Subfunctions'
 - 'subfuction' -> 'subfunction'

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
index 34e911480108..b45d6871492c 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
@@ -114,13 +114,13 @@ Enabling the driver and kconfig options
 **CONFIG_MLX5_SF=(y/n)**
 
 |    Build support for subfunction.
-|    Subfunctons are more light weight than PCI SRIOV VFs. Choosing this option
+|    Subfunctions are more light weight than PCI SRIOV VFs. Choosing this option
 |    will enable support for creating subfunction devices.
 
 
 **CONFIG_MLX5_SF_MANAGER=(y/n)**
 
-|    Build support for subfuction port in the NIC. A Mellanox subfunction
+|    Build support for subfunction port in the NIC. A Mellanox subfunction
 |    port is managed through devlink.  A subfunction supports RDMA, netdevice
 |    and vdpa device. It is similar to a SRIOV VF but it doesn't require
 |    SRIOV support.
-- 
2.47.3


