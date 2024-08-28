Return-Path: <netdev+bounces-122561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CBF961B8E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35BC1F245C8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E0335BA;
	Wed, 28 Aug 2024 01:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlAMPDSM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC31D555;
	Wed, 28 Aug 2024 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809085; cv=none; b=fkZekmNLAzgFZgeOdnya5LlA1o2kKh0w3KzHC4KrWiIbo6yAwyNk4xjZ/LuGNOWP6Tz/YutYXefaDOoFqONg+5G/ndxUbQiU+1vFLIAPlUYOiq715sAUgbbQHWdAjmJtcSDi5BpEZ56tZbOgtEGUJg9/NBaS4AuObaJAM9j2eeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809085; c=relaxed/simple;
	bh=xwvhws/h5mSzgw+JQMPqpiytA4qxkjKdkpY8H8uzAV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emD2PARV4GtBpDbfsjMxoextkcNHCqxV1XRUEa2+gCm2swfsKZIIL8PRFCdq69umaux3gmCzfzww+zHj2U3+d21XKj+4NwIdY2Lg3mLI5m9LPNq/N2M+AwDs/FfF43fRe8TDoYR2iFmXeDN8DCOM33wyWPZax/1CJPkzK5slziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlAMPDSM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141d7b270dso4737741b3a.2;
        Tue, 27 Aug 2024 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724809083; x=1725413883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7A8HeH5zap9LkmdHCQZlgO7G4EHWhTJwGPQkgVaXJhc=;
        b=KlAMPDSMGrwIoSD+laQZoXaLJe0AphSxcIQQW5G5Tl6oUux7CmchuKGbv2nh/uSHCJ
         mYyAXnpCh9/Q69OobL8uGUiG7vK09FaFfTmuizLD0zVGnNzSmfbvbdSU81csfHGCHfQL
         JrAcejtptilS3Kt48lT80jOqy9/pJgtRdJg/rssA1OAmUMZj4yPNS+TxmoYDaRzpaSLr
         5771gTYJXP+GmJU/9OF3FVjARKDtVpTYY201nfSFXb3zB5sJ3luSjW6OBN+U1yjLV+jX
         u56MsquT7dbzWSP00ZIDId89zVBHvXm5p7nvJKn20YqF/VxXTeG2pS7F40NX0ahDFN9x
         y+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724809083; x=1725413883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7A8HeH5zap9LkmdHCQZlgO7G4EHWhTJwGPQkgVaXJhc=;
        b=eqCfY8/lP/s8ioph6wuOsEZ9m9weRvayE4DRWb/6H/l2GRg0LmfIFigA/WmaYr3IlZ
         v2UwE/si45Uix/Bcj25+G+4+aQeah4K/OYrVl9eL6fl3KHeeoqcr7aOurfA5QiAfVyPS
         PZbjhgYyyLf8Svnjkz+Tn9LXzY5K9zUwptJn/S1cY0rUpZwRyw5gJADDc8xb9moY49cf
         R9mbVUf7hFhjpUkuwKLI0cSg6IfIx7ugeZfoT8qLmMJ0U9vLtplqSPUVp2e0MIxpxN6G
         kluSpddEXwLj2+RQnBButh4YrcmGPzk/5XndfCcolA5mH3TAQSXHtZZKTkIWTOAQHBO/
         WTmA==
X-Forwarded-Encrypted: i=1; AJvYcCUfD+VuF2Zj8ouuyro4Mi6hMOppJx4HXz2rIXHcWzVW2upGW3hFqHE0mFjTqxS//DATNIdxR73A6/pDC7c=@vger.kernel.org, AJvYcCW1GPEVHgW852fp+cvPuSUwmZP8Ig9pZEBdeDsFlh5tKowY7gDDTGTzIK/PjsvUnH6ed0/S307u@vger.kernel.org
X-Gm-Message-State: AOJu0YzPS4iUDSBejc/VK5E9P7eMQtU4sxeMv0VwLHD4oKzXevqG38TK
	tF+pm9E7uTmckTYD51DnI9TGBfdo5bJ2mIZizUDHRAKF7+SaazsK
X-Google-Smtp-Source: AGHT+IFQY8SehaW+ZQSc3vqYwHobL6TbDXhAUiSrR355eOo0JS8jcBhq6CoyrE/1Pf1PhjPPyl/Hww==
X-Received: by 2002:a05:6a00:182a:b0:714:1fc3:7a00 with SMTP id d2e1a72fcca58-71445d720f9mr16760978b3a.18.1724809082798;
        Tue, 27 Aug 2024 18:38:02 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335e5dsm9083755b3a.204.2024.08.27.18.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 18:38:02 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [patch net-next] ethtool: cabletest: fix wrong conditional check
Date: Tue, 27 Aug 2024 22:37:02 -0300
Message-ID: <20240828013749.8044-1-djahchankoike@gmail.com>
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


