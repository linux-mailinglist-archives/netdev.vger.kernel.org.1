Return-Path: <netdev+bounces-222696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B314B5572C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E005568232
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07134166B;
	Fri, 12 Sep 2025 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmB0KJpX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BACF33A003
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706847; cv=none; b=sKSryZ7LqDWN3wlrlec5MOK6HnpbgPVmOaSVtidlPxgz5m+G5ugRJR14FkRHG85gycDn2hVTS4G+LGcyG8VZ9EkguMaDWpVGT41V90SusUDntd0s+7ehvcA+HyulrJ/EtFY7l0FV592Esh60mjftt9+Jkkqrf6oJev1PzmEmomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706847; c=relaxed/simple;
	bh=i9K1yIVISo2iQdbGiNCGMmX6M0Ed8p2gmujg5khZUS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1msMk1ucfQ8RzzVvsRS7+NZEb89HLlL1v8KpA4dgSvmkpzscmgZoX8CkBvg415FsdCfinv1D7HM4ySNkJgH5RqaLknYcKze48boIEQTgr94lC3twVkewEGERnag2Z3XeqnKmNTmjBxsE+IkknreaTT8l0REmZkccHnhuYz1P8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmB0KJpX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3dae49b1293so1278694f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706843; x=1758311643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJf9PqzT7hCLse/9dc5RnwMhZr9VIrZ+OxaGIRW52I4=;
        b=FmB0KJpXntobLEh5anKKetIlT+aOKPdtezTmCZwruXA/z0THXKhk9Lzhvafj7kTBBe
         mox4NOch+Rgntf5TObXKiucVCHfRTKDEkpNzpAynLo25CcTnfC4eC+KZxdjMyLqh1p0L
         4GtOC5MhB60kSEZdornio4QZEBH9ivwEBpBlPTPK9NIPXwMT1XCsSBUrqLJY+d0ARUlT
         4LoJkYsa4iMDNbJ4475xeHp75MSBLFdQUGC5LqmMXOjQzyzUJbA2RagXjIQ5lx8sZ7EH
         fk+jx6HkWf/I1MmoEShVXghMJXBl6tm0i/mPExaUyeuyWj05g4eL/tciGkYeIR9T+INs
         dvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706843; x=1758311643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJf9PqzT7hCLse/9dc5RnwMhZr9VIrZ+OxaGIRW52I4=;
        b=vczOukY3nk/Ex6EJJbAcYSTq6S5ad+ih+U229YfTwNcYxuR4wKpB+qHi5zKACf7SG5
         PDSg9QX2QWG1XcgPngROnk4I8p2tBHmQNE5pRH66xq4OVxHk3FWxKymogRjY1v3A+FDJ
         Z9g9mhVEuwhnQJu30Cf2nw/8JLlaRUnKtvg+NA5vFeKez+ute5Oi1oojgWfa+K/25k/z
         tYzmkE8hbjg9OcNjQjzMvMcldv3/ucV5YG8GBjuY1Xw4xiRJSPpB/tKSb5KmUTlm4mMa
         +8WR2XA9j50xp2ZlDGV8lKZV5XKTcN3xAEcp4ECRbUMZZiYzbxTkU6N6j3pXYwaP48Xx
         q/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUAoPfeneY2btL9qSwlEMS+ra1Cmpnk3cbamehAvi8vqmBnaYmWlffzpke0MTB5jbJidtjzzXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGwBhHjqH8qg4RlamP8vU0BAdTSSXlzZmwtX+iY5UWC66Og54
	wopCap+YnKz1gDN32MRJWf+FHsvMUCBUGITOROlyyaRA6DTES1M19It9
X-Gm-Gg: ASbGnctPsGxB0hveCLCDqGWEEDUU6TW1dmG2o1evwDag4DIiUnZio+IDgJN45TRvWds
	t7z4Xo76pEBnreAkjQG8k6oSVCnHxbxUfIHVRaIoAdP68KRY4v28yuWKGl1wsQ2tqAV4+BKw2eu
	CRnqTX2WtOlDXxu8okUI4IyeYsu9saoeUrWDybO/nwKLXxlZ+wrjTywmw2Og2IX4ocsH5tgxQIE
	VXZshDkLVa4elIzp79d6f0wXHTdqhxT+AKIgoqEoWe3aLzwXCq4WtaAkztIpgVuWT5tLY5asOsr
	+82/JQRW0xi5w023t2SiC+Qy63zi4revZpYs+AylEHG5bEB37l/uMZkscUzojLM+HgzRFrnp4hf
	wj5QHxtJj72fDCE0G/k6F36X88RyWn8d/2GdeT0N3L37zFXdLkVkT6RXjKfrUQRGhADrwLon6
X-Google-Smtp-Source: AGHT+IEPloYMebO2+94+EujzqnwtJ3qCQMiLzStQnR21n7BZH1TIPhWvC/p9EdtNP7maaHHDBFj5RQ==
X-Received: by 2002:a05:6000:26c8:b0:3e4:f194:2872 with SMTP id ffacd0b85a97d-3e765a140damr3473105f8f.31.1757706843387;
        Fri, 12 Sep 2025 12:54:03 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:03 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 08/15] genetlink: verify unregister fails for non-registered family
Date: Fri, 12 Sep 2025 22:53:31 +0300
Message-Id: <20250912195339.20635-9-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that genl_unregister_family() returns error
when called on non-registered family.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 .../net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
index f651159a311c..ad4228eda2d5 100644
--- a/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
+++ b/drivers/net/genetlink/net-pf-16-proto-16-family-PARALLEL_GENL.c
@@ -1402,6 +1402,10 @@ static int __init module_netlink_init(void)
 	if (ret)
 		pr_err("%s: Incorrect Generic Netlink family wasn't registered\n", __func__);
 
+	ret = genl_unregister_family(&incorrect_genl_family);
+	if (ret)
+		pr_err("%s: Incorrect Generic Netlink family wasn't unregistered\n", __func__);
+
 	ret = netlink_register_notifier(&genl_notifier);
 	if (ret)
 		goto err_family;
-- 
2.34.1


