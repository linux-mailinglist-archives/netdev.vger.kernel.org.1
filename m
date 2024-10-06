Return-Path: <netdev+bounces-132448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E37991C0C
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B711C20FDD
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD06F16DC0E;
	Sun,  6 Oct 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLjWVY1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BAF4F1;
	Sun,  6 Oct 2024 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181732; cv=none; b=tNXxm5UMO/y2+/+Nt9dkghC3/rbATONxekvCGkBToStNQnpcUYAbfZKj0pu5q6U+ta+74dt50ic6wtqOXNjZ/uF9MuCsmt2XtoXj3rCLCXIhWdylItZACMtH/ZoMSZo8kF92c14l2UiAEeKTTy3FzkHXdtDa97vUXtefwQ2YMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181732; c=relaxed/simple;
	bh=lCh5CXqspTJHc6tMFpUfxpdV0kFfI9PM8erAFghW+jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5PAFE1CjekBAMtzDZz2z5bM4msUtkH6+QbXgjW0B5Sn1VJxwsfrRZHNI4t8KuyxDoNPBbRAnZLH7oXMJAkRdRDfp+ICX44gqeYRjGVDXTQQVeAHA2AkVS3onzeBMCFMGSqx/C48RZiqtFRsO9gOMnDfZpAOTMUqAXTgtQXu2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLjWVY1P; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so508010b3a.0;
        Sat, 05 Oct 2024 19:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181727; x=1728786527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xnx/jTUrppaejL5NvesEO2y/0bRFcOzPWh1DuJoDJtM=;
        b=XLjWVY1Ptr0TB4NjfespGLABBFSU5lIMKcn+vW9hUqKfpnS6G0r+l4Fn8T/RMyis6t
         Fdotg+qVNkQeBdmD0srO8WztvkzNvo2fP+Pj3XSR4kT0+kicpvEXLjO8Oz6C8LcwkT63
         E7d99WtAWPdawmRdjNR7/U6mubJ9L/EJyYi0VyJ++W3zhS1vF+BUd49mlD8NHtfF2F52
         61dhWgOX6vm+KvaOVy56WTOebhYei5ET6Hmkb9XkinCXXnfcHCJmjA6V/1p4gzBFQW/X
         vzQAIYAN9eJb4hlnB/hXPHqBoPgO/cRWcUmfnidwj4pfyZ30E2et4gHREknKG4P9Gta9
         4ASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181727; x=1728786527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xnx/jTUrppaejL5NvesEO2y/0bRFcOzPWh1DuJoDJtM=;
        b=hBH8/mpT124yAeLhqouxwdxPhZgX7n/NV8CjfnWpc27kAo3fH5gOD6NURxo/IRU4ZV
         z1gMMZ9fYd5XW5xfqd4Tuyn9a0tDEsAnOLlaJEwZVsvwPOcNDlQW8+yp5J0L9R0AojPQ
         +VDOW5htphnlsFsyzb7Zn/roBhciv+nmsVlQ1yylF4OC0/DzEYJmAJMKNh+16Cf5XsyV
         wdx2V06Tov9Nbfe+KsFkaJkAo3WYTTGeRvNtahEJSzD24a59i0GbSUVdZoowenndH0jS
         nX1ZNte9JfYUaVoUwR/872HClvUFw3NZUleiY6BwtnS+Ue3f4MXxCf2107EKUL5ITC6e
         6vwg==
X-Forwarded-Encrypted: i=1; AJvYcCWLdV1dU/ap9LIrUFjDujtrfyps96DodwCbXxio7NtZY/7UL/oXlKSeK47Cp+qB5iRx5eXBmlJdnGv4cYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYM02g6qooaw1toYAiIsHALHPrrlzA6OiB8CYccxrqXBmoPBFB
	xK9Onx4bkIT2P1AgSAns5G5jomdFHhpDn5RjJNrtlZebIaeEGuuqvm+R1Q==
X-Google-Smtp-Source: AGHT+IEG53HS5UgJUfwEmmqcivrDI0MzFEEtd0mkURmUZ4fl+NAgwf5/LGrEGyaTWEgvtxiIktghWQ==
X-Received: by 2002:a05:6a00:1485:b0:717:9340:a9d0 with SMTP id d2e1a72fcca58-71dd5af2697mr20404033b3a.6.1728181726680;
        Sat, 05 Oct 2024 19:28:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 00/14] ibm: emac: cleanup modules
Date: Sat,  5 Oct 2024 19:28:30 -0700
Message-ID: <20241006022844.1041039-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The modules are fairly old and as such can benefit from devm management.

All except ZMII tested on a Cisco MX60W. No problems found.

Rosen Penev (14):
  net: ibm: emac: tah: use devm for kzalloc
  net: ibm: emac: tah: use devm for mutex_init
  net: ibm: emac: tah: devm_platform_get_resources
  net: ibm: emac: rgmii: use devm for kzalloc
  net: ibm: emac: rgmii: use devm for mutex_init
  net: ibm: emac: rgmii: devm_platform_get_resource
  net: ibm: emac: zmii: use devm for kzalloc
  net: ibm: emac: zmii: use devm for mutex_init
  net: ibm: emac: zmii: devm_platform_get_resource
  net: ibm: emac: mal: use devm for kzalloc
  net: ibm: emac: mal: use devm for request_irq
  net: ibm: emac: mal: move irq maps down
  net: ibm: emac: mal: add dcr_unmap to _remove
  net: ibm: emac: mal: move dcr map down

 drivers/net/ethernet/ibm/emac/mal.c   | 107 ++++++++++----------------
 drivers/net/ethernet/ibm/emac/rgmii.c |  49 ++++--------
 drivers/net/ethernet/ibm/emac/tah.c   |  49 ++++--------
 drivers/net/ethernet/ibm/emac/zmii.c  |  49 ++++--------
 4 files changed, 79 insertions(+), 175 deletions(-)

-- 
2.46.2


