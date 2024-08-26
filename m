Return-Path: <netdev+bounces-121896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865BB95F262
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF201C211F0
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B017BECB;
	Mon, 26 Aug 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3MjPI1S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DE17C985;
	Mon, 26 Aug 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677647; cv=none; b=oiyA7f+6uvtFrUg9GuZdY1egrPDddLINFTlrbM0NWUmgxoXAlXQiPTg/2M3Fq692o54FT9dcmw3hn5O3MVqehXJVrDS7HTvMjPvlIjjukKuNMYgvEX7GdFy0D510dsfEzH29PHKO55/PoWMVkeSoq/Lpe0mHirRoWHEzbcGHkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677647; c=relaxed/simple;
	bh=Tm560mVWC62ebtgeH9UzDbDfVz3a/kuqxIo8F49eQjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muDw8CtgKr47ZcWkahV0XxAdSTfp/3lYfpPfEDWEaxwJkvNrZoIFFrCyB1RJ06on+52m55Elm49RVctMleJmxh61VmgInRU65bh/LSoPrLAbmMNcT7Scc2Esd9J79bptJteu6raZwKr9uCk90JlKMHlJ0BfVxSGcdlPJJv9J2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3MjPI1S; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20202df1c2fso33717065ad.1;
        Mon, 26 Aug 2024 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724677646; x=1725282446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjSIkEAguZvpp5zFP4qTDSn4cL9ylZImedCGDs8J790=;
        b=Y3MjPI1Sl8cX7EBwrWmk0qyfW2Q+HQd9j9rjlNHymerTsBfhqXtlwpXf4FtqJ+XCWZ
         yLPpWa7AZwS0yeA9bqeRWwKwVtMQ0l+vkdU2OPqV6dsjbHPV05rcJbivQ0x5T4/L9Zy7
         mce9iGxvX8aR/QbKaePdOD5n0nc8Anu4nBxz4YguitQZlEQwYcGwy8wqdLpfX9qsmN/+
         KUFn4TaiEz9LsltwfFcLEJ5RI1G1Rk/n5mY85FShTREYidOUzgOrFnVFMUWWumzQvS9x
         szV6xIdlnoo76zJEv8ZA6kyiBYgdOXawHeIaOilYXLFkroSnZ7U9rk/1JfterCtCSwKI
         lkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724677646; x=1725282446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjSIkEAguZvpp5zFP4qTDSn4cL9ylZImedCGDs8J790=;
        b=ftgjZcHhsReWt2+yKt+xHi8/rLUqJAgG/158OOSEOU/Yab5Lcm6Q3AIY0Gdm2S7F7B
         mveFTuIWw/46964DVFa0eYHHM0/Y3BsZ0zVMjW30Bi5ajTGhAdCat5EPDGFb/wYQySvV
         KwUr/5hqoflueTWF9WNairbADEWTnQpbU4FUFbnN0on1PerCOoJYw/URPRdHF4Gq0O2v
         V1ifpxL1vVhEuPrDAtbcJozQLJgCNe95e+JMufH29IvUXlMrd6vo6mMWuXu2WJtyKN6r
         M953BuyQn9EE7drqEhKGudmA0tfk4KPLiOjGer3NFr3nuUAYY1tDkIjGKgvzfPZf/kw0
         TmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaHkMJ7lF4KguHPjvnjVXTEfmcAS8Xg1jAT2bvN+2542QnFPp1fHPocxwFMDWjkOY7EZ/M1yjD@vger.kernel.org, AJvYcCXM3E4+U0NivqKPGjepPR0Z3obrNfKIAnlz3hAjJYVJwXjkJIyw/1HaziWduMnVGEc/rk5j3VuWBbmRGHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rrhn45wKQ6FyfWWgWDXKsE5Gz287/b6ETwRcnsadqw6dtV06
	4KZtAIrZ4I7q8mYNB3Tevjqmgya6uWRPosbhkk8Pxw5YSIah735C
X-Google-Smtp-Source: AGHT+IG202UJ8Q/mYcz90DLjjI54Jr9fnHjviwfSQ1zKgvVkr+IAMOe+qpIUOFxiXsnnb2XPTDhJ3Q==
X-Received: by 2002:a17:903:6c8:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-2039c638710mr111386975ad.31.1724677645630;
        Mon, 26 Aug 2024 06:07:25 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557eeccsm67326565ad.84.2024.08.26.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:07:24 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kory.maincent@bootlin.com,
	o.rempel@pengutronix.de,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzkaller-bugs@googlegroups.com,
	Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
Subject: [PATCH] net: ethtool: fix unheld rtnl lock
Date: Mon, 26 Aug 2024 10:06:50 -0300
Message-ID: <20240826130712.91391-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethnl_req_get_phydev should be called with rtnl lock
held.

Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 net/ethtool/pse-pd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 507cb21d6bf0..290edbfd47d2 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -226,17 +226,21 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
+	int ret = 1;
 
+	rtnl_lock();
 	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 
 	if (!phydev->psec) {
 		NL_SET_ERR_MSG(info->extack, "No PSE is attached");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 
 	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
@@ -244,17 +248,21 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
 				    "setting PoDL PSE admin control not supported");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] &&
 	    !pse_has_c33(phydev->psec)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL],
 				    "setting C33 PSE admin control not supported");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 
-	return 1;
+out:
+	rtnl_unlock();
+	return ret;
 }
 
 static int
-- 
2.43.0


