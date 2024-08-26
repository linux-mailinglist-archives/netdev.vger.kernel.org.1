Return-Path: <netdev+bounces-121908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A6D95F333
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142C1B20CB2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A9187FEA;
	Mon, 26 Aug 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAbnp+yk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89910F7;
	Mon, 26 Aug 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680048; cv=none; b=icXQXV4ysU1WMXAj3K+i0lhKFWxciqYGgcz5ICIMkMYiwWPQ2rdMjjUOPaHJrjhbACx9a70sX9FUVxdqwI123SqXLC1r2f1ZTFMYkC6WLRJTqqSAr5mVOb8+9EVoAuvSTmifA+pa9jBZN35vdnE3GUEC7IrRsnCuJkNaV5sOPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680048; c=relaxed/simple;
	bh=QJUO0ob26O4/AxkgYTmtRVDU74a8iup4xgwMtEIks74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2KUjjZJ6uasf+No1s+8cjAw7tVrR1mNWNqVZDbjoB4ARJvVhYGVfO/uvC77dR31aT7sTIr2BX8Xr89sqnlXd6cDMSXH882gxgOR4WVrPX0dnOSyOkj+7Y8Z20M/t4n1dvePrvH9RuuyWbOmx++UMeZ7yAmfMVkZCeDYnxvxfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAbnp+yk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so3360538b3a.3;
        Mon, 26 Aug 2024 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724680046; x=1725284846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uc/PKblA1vsid3XNP6gMO/vAjdYLIXY7Xs9okBM7Nng=;
        b=GAbnp+ykHDIpmzaFulezcacDV36NZK7BMX0lhYyAem52f6ondDjDSi1CKXB1E7ibLn
         q0rCVSpyaYeMT4f2iYmv3Rq/QjE9hGYD7UJQsq/35eXy61PE1mollcbY7U6t9z+Uu8vD
         GfV5BW3+ZmnhPcuDMV/c13JcqZ6fRSHHW9mc4qPXF8mFELGt/RN+tAoVkFRvS06INrF1
         Rq7etLzW5yNwczSfQNgjDh4Xl+ugarMExMHeg3FMQ5hzOzccky5Lb9l4ezda8/cxha0u
         mMuq9i1P8+O2oH+zWxAGh3SF68/FbO24uyAwEf+FjFQyu3EzE1xjGWIpcnUun4tCch9e
         Lm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680046; x=1725284846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uc/PKblA1vsid3XNP6gMO/vAjdYLIXY7Xs9okBM7Nng=;
        b=lSUop+1sAo9GWaXcwIMPAiuLe2rEZDbKFhZkGa3G/k9yHWeJE7dgkVvtgRbBhjU7By
         nMhRPfHX2qGn+1jhaW0Dr7+OK4vImAVH8Ku9aLIoboODXaUHabuUgOLVDcHBE8Y4Fg1p
         4ZWC9e2a3+LeMtb9ijoZ+hAlWDm/jzsVwWSC9rCjSE8IHnpQDk47UBKOcnxVOtaX+leo
         4t8MVZbCwMMq7Nwu2JsDkaTVJt3omopaMaYbZxnTmGWkHA7XdO/+wmcvAZgLEx9WMIHl
         9J8zNVzUBgAohGALDtU4LvWvHz60H1kvGP2YvZ68pQsDHN3gmdpP2Bz/lEEfxlLpGI2L
         E5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUi7mhxMupPsLPC9UUTRCcc4E2cHU3as3RjmanB2vFNvbHudVr5gzKmU+q630qA5XVtzdOsLpl7@vger.kernel.org, AJvYcCVWVmzisOoB19xwDzUjkvlpYhm0+gF8rDYN7E3p+TVCjmmfQlKsPMbEmGrN1/wa4JklhQTGFByKh1kXlb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWNFf6P7i9CMP0ZTrMMFRVL0K/tnI1Y1HkhMB5wkLgttPhSnN
	g9Azrr7PaMemDAQpBYs2pjqPrutFyx1RhiFmLUwqhBbDLzKCNd65
X-Google-Smtp-Source: AGHT+IH8qpOey9XnUHQ5rX2SdKV4GiFlO2/vS6OpzdazIn7lYiiJzHnQcB08m9X1NwPNdvyCbMg0DQ==
X-Received: by 2002:a05:6a21:6802:b0:1c2:a3c7:47dd with SMTP id adf61e73a8af0-1cc89edb8c1mr10889390637.42.1724680046005;
        Mon, 26 Aug 2024 06:47:26 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434231147sm7036533b3a.34.2024.08.26.06.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:47:25 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+c641161e97237326ea74@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [patch net-next v2] net: fix unreleased lock in cable test
Date: Mon, 26 Aug 2024 10:45:46 -0300
Message-ID: <20240826134656.94892-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826121435.88756-1-djahchankoike@gmail.com>
References: <20240826121435.88756-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix an unreleased lock in out_dev_put path by removing the (now)
unnecessary path.

Reported-by: syzbot+c641161e97237326ea74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c641161e97237326ea74
Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 net/ethtool/cabletest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 01db8f394869..8c5aa63cb1aa 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -77,7 +77,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
-		goto out_dev_put;
+		goto out_rtnl;
 	}
 
 	ops = ethtool_phy_ops;
@@ -99,7 +99,6 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 
 out_rtnl:
 	rtnl_unlock();
-out_dev_put:
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
 }
-- 
2.43.0


