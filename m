Return-Path: <netdev+bounces-123446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B3964E2C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16257B231CF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4CA1B8E92;
	Thu, 29 Aug 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfthLrGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE714AD0E;
	Thu, 29 Aug 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957327; cv=none; b=Ax1CA5kv3SIV8mMBJ6JQ7tCvIsqrGnh2xHLC6sByZGLGXi4vWYTN8GxtpsxTlzNh5x/EE6JparoiBW9VS+itAnCHhL7XtrypVR7SfKZ+RriTqDFh04DqJPKknKFR0bakbSvDJuMtUKpWC0sBzTkVMTHynrgAH83QUmvbhG30KuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957327; c=relaxed/simple;
	bh=istah6vc2tNFt+M1SwcfEf0qvf9cDVJBH2QeCzGSsc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdyiVv4s3I/zYc8UFLbdXVqh7ERaY5Umit0GqFIZDGdOlDfvLD0FDLKIRoheOzpXFqC8gqoFhFF5U/q1I50YyYwXzQaZS/h+3BpEt+wA/21r5RL9OtlYazJCjGD6Snf9q8qyPTqBeBcdYZul1XsmwuEs8JfAO2zNBt4SBRjtoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfthLrGr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so785320a91.3;
        Thu, 29 Aug 2024 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724957325; x=1725562125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yAXkve3ej6VjWM0bdgOizJlJUrPW1egXhNTQds12FJI=;
        b=bfthLrGrTAYiV3TD4qt/0+Y0h4yreab4+Cwrhe4h4oRRWsxIWSy0OQcDLTiFZTScO1
         YYg4XscD+hrUC6uW0x7J32dDvJaFDshuGxc7KD4ifGfIiObpSr9lrX++Qw4xe62JWw9m
         tDokTAByME7eWcG82uLL8ujkVQl781z+OWUvMO13SCV+3GV3DWxUgCIRUMIZw3cZUNAH
         2NNzNaL7FQ96jfQUqpuW7tCPbLB9nioXM5IPPP0IiJmQRZWEmuCJNHJoo2r3XFRVnA4F
         Y3zqj+JZDJxE0W5xxDPGIZGy+l9pZhTWtj9B2BqnNONLNezh96UlxGY/sjiF9yXiXwIA
         i5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957325; x=1725562125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAXkve3ej6VjWM0bdgOizJlJUrPW1egXhNTQds12FJI=;
        b=XZN+wHwofK31qZsv8z+DEkun4qrPaG+s2oJGwiFaSv2RJrKqa7gdnaaBk4BSp4Wrk1
         uPgR/GDLx6w4/drARW67O5zO7PqojpgzYD5PfA1aXdpne0KlQRI/ApZyr+rNjmQkSbxB
         AbWSvVVOBPVudlfCoD9d1cwlT9S6hZfGgktHBx78+jQEiAQ01syT4DVDCrld5R6BFb2i
         FeCb+MempXxmDyOApGXPbkCvmIrw/l9tP5niGlbI+3t/OcEOXtkLpYietBsg7MT3rpaf
         TFH9L9Kqq6MlKQ7SXvTHj42cAtWG3g0a5k7sG0rVADNhTQ73iM4aEigC0xEUIpU7wddt
         W9/w==
X-Forwarded-Encrypted: i=1; AJvYcCW6RoaV1et1Pbtr27o8JTgCaCKjSS5xV3ut3Zb+FhQMee9GzS6ocGLF91ks+aBOMkpn2cyp6SOKw684/Mw=@vger.kernel.org, AJvYcCWQaZp2lA6wjJuz+/1CFuLnT18F4/7tB7BLaZ8YWR22lcJQLwco+ckoWJhS4pnu2pyrFaXiIWGc@vger.kernel.org
X-Gm-Message-State: AOJu0YyUb/dIaugR+2xwOZwAAws4za/3rBIa1Z+SJCwR//PW1NnxBiuP
	zfHPLVgjq/YzHWbSP9p4yiiJBPmfoUpF0rg+oKXbMrtI2bPFCNVi
X-Google-Smtp-Source: AGHT+IFBoB52jgGZUNQ1NuBWOpSGkNrmB8jr7+iWptbAKULbyNH/UFEJdNQYQwCOtyMaPYyhG/y4tQ==
X-Received: by 2002:a17:90a:3d46:b0:2d3:cc16:826f with SMTP id 98e67ed59e1d1-2d855d3de9amr4202038a91.0.1724957325088;
        Thu, 29 Aug 2024 11:48:45 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b145f60sm2028989a91.33.2024.08.29.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:48:44 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [patch net-next v5] ethtool: pse-pd: move pse validation into set
Date: Thu, 29 Aug 2024 15:48:27 -0300
Message-ID: <20240829184830.5861-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move validation into set, removing .set_validate operation as its current
implementation holds the rtnl lock for acquiring the PHY device, defeating
the intended purpose of checking before grabbing the lock.

Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
v5:
  - fix patch formatting errors
v4: https://lore.kernel.org/all/20240828174340.593130-2-djahchankoike@gmail.com/
  - remove .set_validate op, move validation to set
v3: https://lore.kernel.org/all/20240826173913.7763-1-djahchankoike@gmail.com/
  - hold rtnl lock while interacting with the PHY device
  - rollback to v1
v2: https://lore.kernel.org/all/20240826140628.99849-1-djahchankoike@gmail.com/
v1: https://lore.kernel.org/all/20240826130712.91391-1-djahchankoike@gmail.com/
---
 net/ethtool/pse-pd.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 507cb21d6bf0..b56b79f41a3a 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -222,13 +222,10 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 };
 
 static int
-ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
+ethnl_set_pse_validate(struct phy_device *phydev, struct genl_info *info)
 {
 	struct nlattr **tb = info->attrs;
-	struct phy_device *phydev;
-
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
-				      info->extack);
+
 	if (IS_ERR_OR_NULL(phydev)) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
 		return -EOPNOTSUPP;
@@ -254,7 +251,7 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 	}
 
-	return 1;
+	return 0;
 }
 
 static int
@@ -262,12 +259,13 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
-	int ret = 0;
+	int ret;
 
 	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
 				      info->extack);
-	if (IS_ERR_OR_NULL(phydev))
-		return -ENODEV;
+	ret = ethnl_set_pse_validate(phydev, info);
+	if (ret)
+		return ret;
 
 	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
 		unsigned int pw_limit;
@@ -314,7 +312,6 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
 	.fill_reply		= pse_fill_reply,
 	.cleanup_data		= pse_cleanup_data,
 
-	.set_validate		= ethnl_set_pse_validate,
 	.set			= ethnl_set_pse,
 	/* PSE has no notification */
 };
-- 
2.43.0


