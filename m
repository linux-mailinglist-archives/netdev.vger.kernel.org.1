Return-Path: <netdev+bounces-132250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1D991217
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B238B20399
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6771B4F2F;
	Fri,  4 Oct 2024 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkRMApVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357781B4F10;
	Fri,  4 Oct 2024 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079357; cv=none; b=YUyErEWsFZzJEHA0MCQUIqOknbkLq14qgWt4qT6bJUifBFC8SYpn6qMdYk/wg3fjpLFuUXyY+7dZQ5U+rvVEB6tJ3uI6uxkl1BFE7KaIxDy8kZE50XgyMFPnPFKmS18T5/Xkrg+ykfpmLle+CWX3pAw39WF9tm7JKKl76+EH1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079357; c=relaxed/simple;
	bh=9NEI04r9pk8boDaYvXCembqpldoBVVZtbkdO8qRVlM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXea+BlcQV7fhLrXhn/qXZsXDXsKQAPG+UHGlFu8aP3ilIn6wJmPP+GOEEVLk16ZdE0w0r5f/MyWrOEnHnwtE14YpGPQrkNLva9BOxlY5qUgbHH8PhZEznXcx/fGNzMNuc0f2CT1SIe5DNTGkb7cIrcAT5j+v78W4GmeB1aqnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkRMApVR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b86298710so22684495ad.1;
        Fri, 04 Oct 2024 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728079355; x=1728684155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7LQPL2dp8286H1r4DQT1emsDyU52+A7xIUGZ0lQE+Y=;
        b=lkRMApVRjo5qEgTs6+Xi2BPfY+o2BolGLbsWvtKJHFp4r+Nsg68+D/ngfY50C1Ixvm
         17Sr8I5u7igr8OWlXWCepZWpigdH0+ZUdkq9R3jguLkOW7Sr7Brm6SZx8h7KJrPfmSJb
         UjUDoFt/J5yEQf1LS3xDhJpUCKtqs3msWFD0jup4yQ6AJpfmDwAoOQNtrqJft26TOsbb
         o0W46N9IwCsnmhiIzmPuCJnwdpWZDIdPoB3nOkrJqLqhnVzIwlgx6sedAvpgcRerMpth
         Bt8VO3DQJMHG5pD9/PQzAT6DAMc7SHvVWfvO0rlwU1L1WYcB7aN+uFiDMlhkLGikfBSa
         mAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728079355; x=1728684155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7LQPL2dp8286H1r4DQT1emsDyU52+A7xIUGZ0lQE+Y=;
        b=kbXm2Z7ty0blDKJs3/UgZnjkGd7A8+Ilt44bA++Me2tfXs0qx02MzP78z7DTNy3Bzr
         I5W5nfzOu8uGs69QVCC8CdTnj/gp49AzNMrXk/qIWZU0mVvgvsROmeOHO7OvyUWSuJBi
         b0cmPMLmIRWP7lZRcMf7B2QGxPWIIlVw0p8ud+KniZM2urJOh32YUHHxBTpqvSwZPjEy
         X/wFOXJoyPSJ6jsThaKtZ+m44qxUV462qNJWtuYg0OB6IMSmw+XnfnjxqxR5Bp8cdMaZ
         DYa/xYoHST+k0fgqEVeCxl1b5MpLJTdxaBQtCpIaUC2MobqtejcBrXPcksel85iWscfk
         fvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Fworl1yv/pqfTjFEOCTHJ+MIIvJ3i0bmXYGn9CzcEr9DrmjENUWrIK7NHNCmJOqw2oQCPg1w92UoBIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrxXQ+k6VIAjAA1dUIodL367KiYNfgjKXeY1wiMvY7zTIJhaC
	yAn4orJqxBqPH1cR+jRzbsV9wuUyI9V1V2qnIrChRDrSAu7VIwslm/AuqYm7
X-Google-Smtp-Source: AGHT+IHOBlqK4t0Ugk1DYhbg8qvWKMMjeYMRSHbROPVg7LgukuY2HwwNWTs9c2+uLUryf/d0ZanPQg==
X-Received: by 2002:a17:902:e806:b0:20b:7ed8:3990 with SMTP id d9443c01a7336-20bfdf81003mr59860875ad.12.1728079354324;
        Fri, 04 Oct 2024 15:02:34 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c13968b54sm3045795ad.207.2024.10.04.15.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 15:02:33 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan configuration in dsa_user_set_wol
Date: Sat,  5 Oct 2024 03:32:06 +0530
Message-ID: <20241004220206.7576-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WOL configuration now checks if the DSA switch supports setting WOL
before attempting to apply settings via phylink. This prevents
unnecessary calls to phylink_ethtool_set_wol when WOL is not supported.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 net/dsa/user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 74eda9b30608..c685ccea9ddf 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1217,10 +1217,12 @@ static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
 	struct dsa_switch *ds = dp->ds;
 	int ret = -EOPNOTSUPP;
 
-	phylink_ethtool_set_wol(dp->pl, w);
-
-	if (ds->ops->set_wol)
+	if (ds->ops->set_wol) {
 		ret = ds->ops->set_wol(ds, dp->index, w);
+		if (ret)
+			return ret;
+		phylink_ethtool_set_wol(dp->pl, w);
+	}
 
 	return ret;
 }
-- 
2.46.0


