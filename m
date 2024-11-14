Return-Path: <netdev+bounces-144813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7AB9C878A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EC01F2140D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8506D200120;
	Thu, 14 Nov 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLDgXFIN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59E1F80D2;
	Thu, 14 Nov 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579617; cv=none; b=WSaorosuwCvn1LMSJwnIxAtmd8yExX77qvErMfLsthenb2SQrdphsk69YIG2nyl4sM/ml2XBCOekxwjazKzS82/u5JZ3FLmzp6fjuDrMiFSBqLcaQpPkfdsIBDrbPJuji+FxYIWs8mfaSOQQz2/yqF3urRQqtkDGhljMdvQzBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579617; c=relaxed/simple;
	bh=Zj/1hkrQNcNwCq+kQCz6JEFTpDafV/64BToL/HZE2OY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FAb8j66pmMCs2ruiUjdtj+Awfxn9/YimUiwp9NVc9AwUiX6PZ+99Rc9N/YDYGuI4QOxX0H6eW+6Wu1HRLv/mQaNAoQe5ZSsVnRWWMmY7IrbgPzJ4mEW7whNPsYDtaNBiq7inQHwto8SNELB8QRoHSs/yjdMggAO77u3IKzqRyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLDgXFIN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da209492cso449866e87.3;
        Thu, 14 Nov 2024 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731579614; x=1732184414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXs2D21LwohnP+U2rvw/liEYSUVRSTi/JkMTk288k0I=;
        b=mLDgXFINIDN/tbysgIEnblnyP4PTCe/us+wVcRvCwjvvpUAulcQGvDfkgZqx7ASe+2
         EmHuA2tRXOPtpmqJPVP22pyDvUD/yHYcgabNoFYePUVsfWJUHdmb8lZfnImEt1bRb+ee
         S4Qkk6dSenNGtXEGddkpJpPsEfwSODHRuc7dq69n9pOZQZLM804lotcrzV2HMs7P1GrS
         QtegBb/4mmvBbRE9zq/dRbg5KVI9diWy9qwpiDvrfIJ58c6tl61AYnQ6NMaEmdRJuzrF
         Fi7wq+oWNsiijtQm3EqhwS15aGewYGrYAsWNyG22WeEAlaNbYJv51Iv6Nslg2DeqwnKT
         D9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579614; x=1732184414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXs2D21LwohnP+U2rvw/liEYSUVRSTi/JkMTk288k0I=;
        b=dwwLIijzkTNjMtIW91zn6UtHKdlKWJlp3fzwGWH0XVcaFmhmaMhiPqHWlmhxB0wVw4
         8VhVBepTiT8XnvkTnioigokEnKqueaLPuEbV9uuV5ea60sxplwUwQuEaNQa8ogDrqeql
         1xsq1eRVFxzHvvmxclMdlsZB9CEFCX2gf3+78591Niw0OkdX3kMmK0mgUZsJhnIqVo9/
         OhbjozAErobAqp/IVmjFap+Q60UVg64T9PPEvWOTAqvYHDhfvxYBy5sG+ALIJt2nKyZG
         lpIkm0giY1+OreOwe561k7L7sBmlwC2hvh7abwxbPZWfNgzTn8AuG/bWmPHp1aatLNPB
         yaGA==
X-Forwarded-Encrypted: i=1; AJvYcCUt2j0uD5m7Zv8MRfMdqtlTX80QpmFpwy4khNfNHJD5tzmo/f6IthRPZoHZihC8xyJSBREsl9XE@vger.kernel.org, AJvYcCVCoOcQ8VvA7E9U+ZwJezOt2PFVYnJxTOrw9SXmCmYbZLIo9eWGwehaOtD49GkiBjOcGDHEdt0txUPI5uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgMdbBn7g3bvXgSqymapesAQXgJPUaGNCwv3C2N88xNGREjf1
	QKeJirK0q3YL2/lVc6SKBMiFOW0XxPW/j8ahD/p67PtvoPP3vNaN
X-Google-Smtp-Source: AGHT+IEijiW0XUP3xPsUKgtPzcn5M+JO4pbrgaMa4MN3iDTGrZpnMwHsGrkyC6K3HgljtvtI7HrCPw==
X-Received: by 2002:ac2:4f02:0:b0:53b:4bc0:72aa with SMTP id 2adb3069b0e04-53d9fe8b1c7mr3288842e87.34.1731579613557;
        Thu, 14 Nov 2024 02:20:13 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada4076sm1048920f8f.16.2024.11.14.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:20:13 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] octeontx2-pf: Fix spelling mistake "reprentator" -> "representor"
Date: Thu, 14 Nov 2024 10:20:12 +0000
Message-Id: <20241114102012.1868514-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a NL_SET_ERR_MSG_MOD error message.
Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index ae58d0601b45..232b10740c13 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -687,7 +687,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 		err = register_netdev(ndev);
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "PFVF reprentator registration failed");
+					   "PFVF representor registration failed");
 			free_netdev(ndev);
 			goto exit;
 		}
-- 
2.39.5


