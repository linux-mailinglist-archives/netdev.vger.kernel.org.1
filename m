Return-Path: <netdev+bounces-172375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40028A546CC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E818923AF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1381120A5D5;
	Thu,  6 Mar 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOhR2nlo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909420967D
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254486; cv=none; b=Hfr9aQJRFbg9/foMP6vAq5pm693i+DLIT8BtuFWz+djCIfIVQXTSvIb5FvX03GvBKsjDF92eSQhTO4AWw941S6RWU6i0DX02Fa7pYZb9gpn0kVsBEPCWxPU43AhNFU/4P9MwGLDz7miVkNvRaSJNw7wHEG1haXUDutrxryTT4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254486; c=relaxed/simple;
	bh=3ho3qGo1lVmXuX2dMlnltG2fGWa3E3AUvtUOA6OLNpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TogEIEaKacvjzo3TeMwdOaMBZkdXWFhrdxnJx5ix7ZMn34iFPF/HM0YizS+/KK6t88oIJSDglFDuksddYJHaBMP+PxefEGfDjCBZpi+tujPay/1jucQpVo3mjp8Ht78gsMxwyCYmlXohVOPArq7UK9JNYuG2serYYnvBN+chDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOhR2nlo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741254483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qhoIeIC0J8+KZetLEFZda/wAPxtts5eJjpdjM7DSGkg=;
	b=bOhR2nlo4ahUXchJLlAeLIwfSc/EDcYHFrCuS2JzQLr9bv5IDNlYf7DAksyQGbRy4XxByq
	zsZWw8ZMmXcrICmFdcPjDmNiUIot9Pu7s/avIGVtvW7aXXYdBveuBpOKxIAt0BsGrXiyAK
	yShl7ZFeG0/9dz0tLO9T7iVbXVpBs4s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-zdYQC-eiPsyRSi7xyZGkug-1; Thu, 06 Mar 2025 04:48:02 -0500
X-MC-Unique: zdYQC-eiPsyRSi7xyZGkug-1
X-Mimecast-MFC-AGG-ID: zdYQC-eiPsyRSi7xyZGkug_1741254481
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912fc9861cso24559f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 01:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254481; x=1741859281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhoIeIC0J8+KZetLEFZda/wAPxtts5eJjpdjM7DSGkg=;
        b=cljaOuKkBhbX5+I2gXUen9d+EAYIdb7UECHH7XFk3d92izNO5d0vMXRXCrZjp9f0zL
         aFzh7gIlrFsv2wyq6+xTIOGl714c/Hl7RadxHgGyc6A6R9u1+XIo066JjmVlb4fB3fae
         LaGt/qeE0nj+XOGiOEdoTVsb6R3CZkohpa49L9uIxXWpnLaDH6O1DIiUlljF+KGNRY7G
         ShkAEBTBKscUkueqUiMiMpsX/DajKHFJ3kB8vaE0dSSQclrYi/D5HEzitfUYAsCZM+7w
         RJuAESDukIj9Ckd2IlI0wki4kHvUQ6EU+hdV+om3kku2xT7dYKKvzlL7zi9DjLLqzATt
         Nh4w==
X-Forwarded-Encrypted: i=1; AJvYcCV8Fd/Qjwz1W/irTCl8ERlicd0TfZtLD/5xlmDlJkGmLu7a6jAeiljxd8W2oaDmlKnBRT1eCrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJrxPD0DuPScsTQOI/2epmaX3U/6o3ZkfmOrAS3TWgG02K429
	PdrskjHeESud2kCaiuWdAb5MDOHG0QuPfsXRd5g4Ee/IzCfinYYQl62S3O8nbcZS+2OuYGjVrqh
	8f25V4lG2/Np1YrzvPdFuw3ujBojgufz2wUEr1ZDoTqV81Q9Dj113OQ==
X-Gm-Gg: ASbGnculhjlnoTYiMdfuZsjcy5AKk4+LI8GXIMRMRqA71e8SFqHn8GXBt9f51eNlxNC
	NKGImQDIl+qXOlhb14C9Oumx3Opmw5sUj16oBECqAjb09QEJIaFl1FeKJKrhR9TSCwCNFCak8qz
	Ojius/SdfMMiou3dWqCQ1/8v37MRc9ppllyOQjMMqOVTFtMaRvJM+8QVkZybYZsbINY8dSI2CrI
	qHhtHwle36e9J8o7d0Fc/8GpkhSeh6ZpAYoNJAFubgSP8fenc1gz32AnKhKCHp/wzJyRicRI4TS
	1kmvyETtd8WTa7vT7uFJXhKGUSr71Ea/ED9ZjEgLXIqODsDSAL2r0iiW/VK1ahQ=
X-Received: by 2002:a5d:5850:0:b0:391:4f9:a039 with SMTP id ffacd0b85a97d-3911f7400aamr6723545f8f.16.1741254480849;
        Thu, 06 Mar 2025 01:48:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaiIHXbccL0gmNV8J9au35MPia1hghbbM07U8lOSRBfu151n9eSAZV97mDiHYuec/YepoOoQ==
X-Received: by 2002:a5d:5850:0:b0:391:4f9:a039 with SMTP id ffacd0b85a97d-3911f7400aamr6723518f8f.16.1741254480467;
        Thu, 06 Mar 2025 01:48:00 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm1507462f8f.99.2025.03.06.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:47:59 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] net: ethernet: Remove accidental duplication in Kconfig file
Date: Thu,  6 Mar 2025 10:47:53 +0100
Message-ID: <20250306094753.63806-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated
folder") accidentally added the line:

  source "drivers/net/ethernet/mellanox/Kconfig"

in drivers/net/ethernet/Kconfig, so that this line is duplicated in that
file.

Remove this accidental duplication.

Fixes: fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated folder")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/net/ethernet/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 7941983d21e9..f86d4557d8d7 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -21,7 +21,6 @@ source "drivers/net/ethernet/adaptec/Kconfig"
 source "drivers/net/ethernet/aeroflex/Kconfig"
 source "drivers/net/ethernet/agere/Kconfig"
 source "drivers/net/ethernet/airoha/Kconfig"
-source "drivers/net/ethernet/mellanox/Kconfig"
 source "drivers/net/ethernet/alacritech/Kconfig"
 source "drivers/net/ethernet/allwinner/Kconfig"
 source "drivers/net/ethernet/alteon/Kconfig"
-- 
2.48.1


