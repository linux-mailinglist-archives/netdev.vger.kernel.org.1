Return-Path: <netdev+bounces-168662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396CA400A9
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B0F7B0AB1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9A254B05;
	Fri, 21 Feb 2025 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY9nNXcq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE8253F39
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169112; cv=none; b=j23cljAQa8ii8gxyw6DydrQ1lnjB+qNKZIUa3FeU5GvdrGjs3RuucDBwTJcr9t4sIm77o2MH8G7WFh7wauILodPbenXLNkERfxyahz8czaQD8bh8JLH7ilDkS8uNjjNRa7Sgs6YE6kUzpbzRosPOFuSflkprrSptawf1N2oZTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169112; c=relaxed/simple;
	bh=UQvJ8TwOigWO0FYaap4gRxRl+TXT1bVtsMv/MzGY7Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVtkdqqo3YxPPXbhrSm+NVzDGxatH24for3Sga3g9+/2Fs5MKI5KrtLwAAWuEAGBlBTxwgLA/651QSQL6/BuSNvLau29Mvu2lted9DLeGR+SfGKub7WlWRvFvbypGcneQ5S4huSd9j8eWKOPfvC1EwM22bP2rE/wqUn/YM4sZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY9nNXcq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so3871480a12.0
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169109; x=1740773909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0N59OGdTJN/A2/YOiQmlL2TDzEel3iIKLuRSf8Ulc4=;
        b=AY9nNXcqxuAFvsVSVX1zTYEWRtx2ORujLs0+NVTsIQCFId3DQbIhC/Rqku4YJ7lQ3O
         2Y6M9FWbO+/6JXFHpv/mtDqNTu+MTmUc/GNzDiDOpH9+/IS5okCbTiaaeJDONjGvdFSs
         3tOp2QqwPycU0riEy29IfIjNg2LX7rcPohp9bH1maRCBSCCwShRhBZNrzpYs0tkpKBPQ
         AzDlm5/P+0OMUSS8A/UpN0rstROPXfTPw9ifYSqb7x9/qM6v0coyiWDlmE5cNr19GTrQ
         blx6jKhurgAiRNRSsrmBTf3ArmKAL+yM7CqO1xvBpqZecgTHpA5FtimMIkJAkO0dr4KV
         awnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169109; x=1740773909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0N59OGdTJN/A2/YOiQmlL2TDzEel3iIKLuRSf8Ulc4=;
        b=XyqyjcWsq+DKr0+rdsfvRS4rFqtmLJtS/GNH3dmv9E544su82x0J6wVSK/wlkhA/Xu
         n+ttth805lm+TPubUhF08n71vOkWFOdmTt0/WXoK2WpOi+w7JQ1u5JQGWTxMrbaMR75I
         4/2t042TZYeiSpGvF6sEGdHYtjs4cPxxdtlPKWrAir7/Q591eOrhXq0/bgK3jQMw3Kg0
         eTANz71S4tGun288LySc8lK/ZP8saB6liRqN4ge5S4IAWx7w8dsKD5C1ab/F/0AhQlqx
         nbtBRni0dZIjdTjPyR7Kx6xkGbW6WfDkoxjo7eK/4/3h7p6KsTL523EElvNm8djOqK3d
         F/lA==
X-Gm-Message-State: AOJu0Yx1lyh6tPPc+nIg5+/T4I1UxKoIiHX0WLI7TNLvJtxNj/pYdCnc
	d7iBH4XhwOq0hh0VWUUnksH3QR0NBHSrYb1QMjNTcJt3sxN3189VaLnbnpWO
X-Gm-Gg: ASbGncsytwwCX7Ca2XZE03H5e92V1oKY6uZn3ScFsq2gCDaedZZHK8LK5YmGLge9mNk
	RRYcm5cSQwB7pkos7RNwXHIdE2r4+cWeTASDRv9/c0mQdDSsXYFWg/loPLoCL4xqMtUwqW3Iu9V
	Z2PMoxggYd/u+8nnNgIoq1UWz9lViEY90tmJtxzWQzgCf8dXlpdeDqjig0vPyib4vyRoDjIArNC
	AHk6HGealgPv3KYTrGmZ7l0uGjqhPtVuE64PUBgjwqdrWR3YO+iNc7DHpjd719/kWtmG1Cg72XI
	/J349hj8Z7wZMGgJjV0zWqkq
X-Google-Smtp-Source: AGHT+IFUq0NHwKHO/eQ5uBFR8m/VP/SyVKgupAL4JTLC9IAnXv8HWfBStVyflKDFjk+APPHi9o4/Wg==
X-Received: by 2002:a05:6402:510c:b0:5e0:4408:6bab with SMTP id 4fb4d7f45d1cf-5e0b7108e97mr4164601a12.19.1740169108719;
        Fri, 21 Feb 2025 12:18:28 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e09072247esm4693938a12.51.2025.02.21.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:18:28 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jdamato@fastly.com,
	sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev,
	sdf@fomichev.me,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next 3/3] eth: fbnic: Update return value in kdoc
Date: Fri, 21 Feb 2025 12:18:13 -0800
Message-ID: <20250221201813.2688052-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250221201813.2688052-1-mohsin.bashr@gmail.com>
References: <20250221201813.2688052-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix return value in kdoc for fbnic_netdev_alloc()

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index cf8feb90b617..79a01fdd1dd1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -611,7 +611,7 @@ void fbnic_netdev_free(struct fbnic_dev *fbd)
  * Allocate and initialize the netdev and netdev private structure. Bind
  * together the hardware, netdev, and pci data structures.
  *
- *  Return: 0 on success, negative on failure
+ *  Return: Pointer to net_device on success, NULL on failure
  **/
 struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 {
-- 
2.43.5


