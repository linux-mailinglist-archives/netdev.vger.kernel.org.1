Return-Path: <netdev+bounces-232161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5CC01F23
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E05C04E4C8D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F332E68B;
	Thu, 23 Oct 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK0t3XsS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEE3074B1
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231547; cv=none; b=evUcrFoMhjV2z1i8mGWnPAvR4DDVkoScC9R6meh7Z9Cr3FT/S1Fwd5iWPLn9AkfkYt8CbSOxdwoKcSVDYP8E0CoxUOdHxsFlb+RQD54Ys+2XnxP62DfjJ1sjG87nPwaH++jR2vZt7y30hlQaftx4Z0hjmPkvtXZ8lcwzz1eh0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231547; c=relaxed/simple;
	bh=S/0RC12Ct7sLa4BGsyULQ2Ksjr+REt4si7cQXyJnPMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cr7ycxEJ7FPkeSqFF6pmGP441PwelMrwbQ5pLS5he/cmu+gaKasrNG3Uqf3iLL1794SlGh1BXqahgl/UtLq+Zy5ltUgQ+nLu00TEzDKvG5bsGFLC6SLGv1/6B0/GSXla9yvjv7Glq2JzWSydgkXZUDtpjJczUm9T5aKK+4lh8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK0t3XsS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47118259fd8so6276535e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231544; x=1761836344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWoL1UZ/q1eqzSis7uaNsqbiHg0hktnmtvNBWCaQMdw=;
        b=cK0t3XsS/M4VuNiPBiOYP1ol2tFmd0l8dpUUmCpo4sNlLm6yb03+S8xPd4w8PKE08K
         xRH+FeRICVyrzmvc+6FBWtj4y7phnSTi+9ImuZ5jmLhIZKlo9HcajY/AG+98Uz6h/lhx
         jeprgLMO7+CDkilpM8FEj1RV2Br+VWRt+ikk5h02urws85egyZE5ZICDBjkq3QjnO3vX
         2RKvbz7pYGGma9+Dyhc032DBvbFvEnGUT7EJMj+ydDWiDx54EgsOCytD2QM29FjI1nx7
         mDe1pprPNjyNYnSsfFxqLyLuPFHZtkeJ+Wb0H+Kv6VFAD/+iz8Q67JnDlWllgM7o35t4
         haHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231544; x=1761836344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWoL1UZ/q1eqzSis7uaNsqbiHg0hktnmtvNBWCaQMdw=;
        b=be3XALcdIHkQGcCulC65z+V99fwoxhNR8YcVMrdcmWRdU/MHaqqTMtBCL1lsVbQLmd
         sHJsvV+jZpdD9sAOC10PIRhbjW4lvyoX2wWKyUn6E3JUslpLURdVW3Z9umz637gu/SQT
         9ldvjtS/QXDUeSOh9KzaepA6yw0KEtnX/q0W5+XthUE3lPAmMMXdI66DzdyVcPRJu73Z
         7EqZ6y0VJWYs+RQAUgt8i4qpmxgGdJk4f3n4sI+7WNi35nqNgQ0ilJ/4STt6/rRl/OvY
         THY46+Zn7QyhfhVIZFwWfqPxE3+ziWOLeJq/5JJKacKGPRMMMiHuHSyg2QrxTx1R8gUC
         DYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6WgnOkti765yQGDCWMBVGuJ0VkexEwZQ4tIA70WKK5MrHEsw2SwxhU9bPZKt9jWEPR1WG9NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbguzYc391To2YuTrU63JBI5obxroGsJ5/tWlwkhSMkPNtCVb
	yxSQTQb7fEVcR/uj8IUa3msHMS2dBXguHD5PuD0mxnHnu8uJzq0K9h03
X-Gm-Gg: ASbGncs/5ArElHW4GLxJEdQGPD3jiYm92/Btw/KRozPdeA+0iQiiigSglNk9bHA1549
	cdIIb2ltKoMCSEHwgVEkJOeAvWnyGVgesPqwhGvFfbE0QdxIfWIlMb86CmO56zzAzmLMLAAH0/K
	fsXi6tIiogenvrIPnm2j6YJ/KX0qb2szJWvtycGJa7OLfW17oC9mjdmBjWWaL6vX68VRVkR84Fu
	Wf0FExJ+peC9Qfpo2/iblj9C6OBzG+fqJmua7/TWmqwSlifA44bGo5VpGXtJJ7c1WYRQOJYvK9G
	uklTQIJvoGNuv4btl3UiQR35Wr0QjwLBMvBLYy+CXda++oHLkf6CGrg9XO5uh79iyQqD4EUhFIo
	TdicyxmiHS7SLxTE5alkFpw9DxHJk9C4lF/PWG/hVcDuvA+tDcFyoNL0Bvwq0oY38RogPS2uqux
	4a+zd9D8ZWjAoQROjbjqsFDFfst9amIm1wSmzif25Q
X-Google-Smtp-Source: AGHT+IHX3KE00pQn3aNP1QwDiE6EhD5Q3hRD8inmO43mr2wuZ5/VM7zYPzKmzGmrYwsAVd3vpyhaEw==
X-Received: by 2002:a05:600c:4f89:b0:46e:3edc:2811 with SMTP id 5b1f17b1804b1-4711787750dmr167242385e9.14.1761231544110;
        Thu, 23 Oct 2025 07:59:04 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-475cae9f292sm39822325e9.5.2025.10.23.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:59:03 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 0/2] net: airoha: initial phylink support
Date: Thu, 23 Oct 2025 16:58:47 +0200
Message-ID: <20251023145850.28459-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This trivial patch adds the initial phylink support. It's expected
in the future to add the dedicated PCS for the other GDM port.

This is to give consistent data when running ethtool on the GDM1
port instead of the "No Data"

Changes v2:
- Move setup phylink to airoha_alloc_gdm_port
- Better handle phylink_destroy on error path
- Fix bug for device_get_phy_mode

Christian Marangi (2):
  net: airoha: use device_set_node helper to setup GDM node
  net: airoha: add phylink support for GDM1

 drivers/net/ethernet/airoha/Kconfig      |  1 +
 drivers/net/ethernet/airoha/airoha_eth.c | 79 +++++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h |  3 +
 3 files changed, 81 insertions(+), 2 deletions(-)

-- 
2.51.0


