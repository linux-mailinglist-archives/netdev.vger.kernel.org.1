Return-Path: <netdev+bounces-122566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97065961BDD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 04:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA7282F0B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E13CF74;
	Wed, 28 Aug 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0RgRLSf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F18E1B969;
	Wed, 28 Aug 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724811017; cv=none; b=H013OC5pdoKdz+TPm9UdLPSl2c8clOaGp36m485pH3CmyjXx4NaW17mnF0V/LE68+TwEBFifGfO9V8rxWFlaRiZTObVJZc8DNHY/YyXdqGo6XVQqIU3G9YKesp1gCIhZ0fDqVVAMAd7VZKOkyXQ4qyux+8iv2+DzSyB0bk8fPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724811017; c=relaxed/simple;
	bh=YnraXbuMAyBodV9ntlz+t4fwxVSILz8nXLl5MIf5Ul4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy4qSe8GyRh/GT/coptIXpvjgYbm0yWsP4zxx6qAYIB3mKR+eFXCeabBDPtr5iaHPGWtCZ/hJ5GI8qvIpWyBiysQBzU1hCpHhxS+k7S0vQOxOoJKxdfzv0QOa782eoiBp8OYngDKDbWk49zqctmh37dgixds6GPy3241govF/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0RgRLSf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714226888dfso5566278b3a.1;
        Tue, 27 Aug 2024 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724811015; x=1725415815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jaCgYhDkdwka4s3wYKCaRdmg2zYibfECqqUU2iudIxM=;
        b=S0RgRLSfvl+G0GtQ0Mz3bssxfHI+fwkFQw+nUTV+9oi5ldoXDLL2VothgmTvW/35VL
         +T+epF2SCnb0DTk7eiINWDaQG6z5Zg87+4Atbx5nPZsy5UZCHTjhkkF0MAs8HUM5i7WB
         KnmsPq9ZUQCuzSMyAmwQ0fh1TNUUMhdLpKplbvzRET9fVmWW1vr+HrPH3W+c0ZpDe8OR
         MvDhfQt6LwrVPcnRvdM6h7ikNd6wpYVpUiwxAQ7PnYSMheILU06McfXuCTM1mf4H7jCy
         mcqIimsz8xmXC+WJ8KaC5fFOcreQbSa6kClyqbhMq1wsDVfLshi2dmTyxiN823uANHO/
         pV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724811015; x=1725415815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaCgYhDkdwka4s3wYKCaRdmg2zYibfECqqUU2iudIxM=;
        b=cqBpcSqZx/bsk+MQ4dp0KoHMnUSL4p6i72qFfhg/+T0M7BDUZqgfptTuUvoUcTrHe4
         q2jv7x0aCI3AxZNCSTXrrpFxTy1ahYO4+jZ1zl9pzfH6RWY4ITdj2h6+L7XeHHvrUPsV
         goxUSXVqmXYXEhN8P+F2dCGTBNIUoOaeiljB7Zq7WXnhNeIiIuY/Z9HVjr1Mk7jg27hi
         SS0uNyblUKRKpFh3qaOcMylB+nVoZbDxhO2NfVqVB5rsEbg5QyDBFiZwignd6c9uWxj2
         1P2D7TFooSgAjKKS3zohyiZTsg+iiXJR9yWJgbEeRqP2lEJGRfqp9JEMaqa/dC9NmIei
         TIXg==
X-Forwarded-Encrypted: i=1; AJvYcCU4SCG0ME9HVsV/MP3e4Ti5k58wgfShzyrTlxxxprJ6BzFG1c+1hUk3LqupiochHeni32lR4UsOmdFokdg=@vger.kernel.org, AJvYcCXxbVquva01lyt/AYRqFjdrUpAA0Zv2lSGGybqevYr3mBaSQNMQkXBfaNemSAFRPHpuEL/7l2sb@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvX5ka3jLsx4bH5zRd9u+cAIHrQ4xiz1CFwIkbEVjDtAIcSlU
	LYP8ykjXeBeWTPOj20WJiX127lVy2jLvQFIihBoObD1GEFh8y1nb
X-Google-Smtp-Source: AGHT+IFSrZ1BVnrttvH/o9cwG0JvR2yyl6z6oZFT96/BLwfCgAoZnaGU/6waV1kmLfjhgd5RWAPoPA==
X-Received: by 2002:a05:6a21:4d8a:b0:1c1:61a9:de4a with SMTP id adf61e73a8af0-1cc89dbc101mr19151398637.24.1724811014970;
        Tue, 27 Aug 2024 19:10:14 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343403b1sm9153136b3a.211.2024.08.27.19.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 19:10:14 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [patch net-next v2] ethtool: cabletest: fix wrong conditional check
Date: Tue, 27 Aug 2024 23:09:19 -0300
Message-ID: <20240828021005.9886-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ethnl_act_cable_test_tdr, phydev is tested for the condition of being
null or an error by checking IS_ERR_OR_NULL, however the result is being
negated and lets a null phydev go through. Simply removing the logical
NOT on the conditional suffices.

Reported-by: syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5cf270e2069645b6bd2c
Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
The previous patch was sent without the appropriate tags, apologize for
that.
---
 net/ethtool/cabletest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index d365ad5f5434..f25da884b3dd 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -346,7 +346,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	phydev = ethnl_req_get_phydev(&req_info,
 				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
 				      info->extack);
-	if (!IS_ERR_OR_NULL(phydev)) {
+	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
-- 
2.43.0


