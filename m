Return-Path: <netdev+bounces-121998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6678F95F84B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B0D280C5A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7719412F;
	Mon, 26 Aug 2024 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR95GTWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085F4D8BB;
	Mon, 26 Aug 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693977; cv=none; b=gOGsSmLtUucO8lluQXWbudPqJylomMlxkZb3bzzwremMLdK3eqU5lLLeOkfD4IQ3JgIMC1JuRa9Vx7TnuGQrGXrdfW69HSB5Geut50FMVjASdcJb4sG/U4wDzhv5XwWIO3i23t/kapu2fgm85qa+gqBpmvOx0074MDqwvWUV1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693977; c=relaxed/simple;
	bh=XAdEz3p2q81Vfpbo0wT4Nk/RuNROhuELtinYu772rRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/e0/LV0euxa7AkXhlC0HrdJkpDZCEcLHe//qgUGXphvceW5qZWcD4O5nzSHpGgkDzqtBHoDV4ayL0Q9qkxb5GrK/nhwkPFLuVjQNjNCh8aBwNAV3gWoUBYD1+ztX+kwoimJhHc9s7G9rCTB1JESn/0wNeJSUMrYmTII7kGQVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR95GTWA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-714226888dfso4137750b3a.1;
        Mon, 26 Aug 2024 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724693976; x=1725298776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUr4H0CU+fExDVlEld3qLsA4TGyuO8VF3QfrjQIftzs=;
        b=DR95GTWAyi5LUW/Dw8vJXlIsfO6jblPce1rk0xZN1jJ4gGEMUd/9HiHg6X6pj1y9UZ
         ZpkVnR2hqIbv3I3cCu+Ywp3PcO7rSwlUQgVOgRGtpVDj1lO/PDMIyP2pkOZQElDHPl4o
         WxZ9yehdSVW4Z3MQgrKzr+OsviV0H2RdEHn3lxs51gjt8d49I1dtkV+ii1tmftAkVPYF
         fDhwICbF7Ch1Gfv6BOy/TGfAEOLTuSSEtaqBvY4JJuLhfN9AVlZL65mGzyLOIXv8+7DZ
         z1I88UbyxEMJMlZmIlE8KXCYTXPbroDt9iU4yQ5lyDvp53/PhxF8Pmoch4PZNwxBIQsu
         igDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693976; x=1725298776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUr4H0CU+fExDVlEld3qLsA4TGyuO8VF3QfrjQIftzs=;
        b=S9DPh713WpiFIcmCl3U/ymABMJ3/VhBTEP7rTg6yRfPV016vuNiM5aKYJ/Ekw4EmFn
         sWaMoIvdSRcI+4MwopG46Aw54BTUECIw9EzT3I0Jg+GP8PCY91by5k33qVa5KNLOyWPv
         wG+eSHVz31XgFnZzUONg1iPE1rWsqweyqLXltzUKHC5+f/pPFlQtJxA4TddCD6e9TW3l
         A1WC56cZKKV8Uyaj/IkumailNsG2kwId1T3iYFSMqWYjW+Te0vTJXWtf9TWx1sSiJssk
         img+cW0QANdPkdtlz7wKGyauNPPurNybDRg59C7PcvjctdDzNuCtxw+BsZ53no2yG5wL
         O1bg==
X-Forwarded-Encrypted: i=1; AJvYcCUXfIkvUXqGufwKUVNulPp09U/dsCWZFBaTH6kyGr1jpuvRe85K0I7p+9nYm5F71eCLlEQSPg+SEEf1Aco=@vger.kernel.org, AJvYcCWr3PpbldeF7mh+3pjkI8dvl5fCQTJIA1a+hNF1TExuuC3NvS9cyKMVc4q91glJhvwgNvr9zgLI@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBu6k+VnUkxPArmU2LwiShcJl+Uey/CpReMgUWrUKeOVV7i4D
	jrtnEoW2LZPGguSgAN2yYkNSVUwpoNfBOgeos4O8Bqb9E9qYE8uo
X-Google-Smtp-Source: AGHT+IE/Mv0GuHbGC1Uq51ywTBSiqQa0J9YzXI2ipVV8DYuzOOPPO9z3kFBc3X8Nypno+EBI0+kRCw==
X-Received: by 2002:a05:6a00:2daa:b0:714:1e28:da95 with SMTP id d2e1a72fcca58-7144579d4camr14268206b3a.7.1724693975513;
        Mon, 26 Aug 2024 10:39:35 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430cc60sm7259372b3a.154.2024.08.26.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:39:35 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [patch net-next v3] net: ethtool: fix unheld rtnl lock
Date: Mon, 26 Aug 2024 14:38:53 -0300
Message-ID: <20240826173913.7763-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826130712.91391-1-djahchankoike@gmail.com>
References: <20240826130712.91391-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethnl_req_get_phydev should be called with rtnl lock held.

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


