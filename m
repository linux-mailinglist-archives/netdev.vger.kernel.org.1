Return-Path: <netdev+bounces-236488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79018C3D04A
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 19:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCC944FD8F9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD6346FB7;
	Thu,  6 Nov 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Lod9/K+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com [209.85.221.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959A27F016
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452191; cv=none; b=IazmWvXPjdAKgczW01Z79zv1RdB+LPAA4/VEI/nDcAj9YDl6+u/dZZisHj+mNCBHaH/Z7M+uYnLES62/yxrDvsfMoJrRDieoEDDxoBeZp/Kz03A9llAwS2CxFNwWw0NueDI+pboezf+Wma/hV7zf6jHnlSXpC6xQpVPunW/iAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452191; c=relaxed/simple;
	bh=9tngFstlyz98+p0OT0UHfF/tfciRN50PQ0cPoY8teds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLtzW2fMq8B6JGSYBy2IqtmQokj94H5Niy63OG7Js5ZkehwaGfjpKH4EKmWPHsS0PwOdtTsKmOc1RsOf2OAePYfkww53329ufNpk3IfBwxaCSzgS69tF3WOACZ04hnabGvhAh4BkgfULKkB+E4Iw3D6Co80RV97vpX58lOdhLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Lod9/K+I; arc=none smtp.client-ip=209.85.221.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f99.google.com with SMTP id ffacd0b85a97d-429c844066fso163566f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1762452188; x=1763056988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNQuIPcbM/dcwp1D2vrF0ESeEf1khgGX+lt9j3s7Iyg=;
        b=Lod9/K+IrmcDjav/+k27vnQWveCeRYcYSJmM+JmkO0gLnaDPd13snNkFgH68QopWHi
         fk5eyUHAvEbn0KJnP4hNCP/VLZql64CeWVXsVvOg6ZiGlLVdK6T8/oU9/J2DvFegHmPv
         tNjliOHv3Z3Zxr/6boixLGQgJwOSvYaC8pN5TLBqiWx4XmpO4g+slpXLkAoH4JW9EZuW
         xJ/S1CTfX5xDDalyP1xY5+BO3+qgTTAr2KCDT5NBLboe0nCt5qe+ccnyjqlVexesWlK+
         REYa0oVlOt89nv9HoG+U5rQlSbuzGFcrP4K9Bvpd+5gvfmsrX2jeUyPN/5ueH9o0mbTo
         cXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452188; x=1763056988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNQuIPcbM/dcwp1D2vrF0ESeEf1khgGX+lt9j3s7Iyg=;
        b=RpOwAV6i0iEEkAyidETpZr5JsJHiIF9NA2zb+st/5p3g2rQ9BjjtiN+yNIrfA77wUk
         npRBHdeKQ00LyL+qQuDoFmENmePkMmzcn4YLSqaC8l2rxNN8qgUwKvosJypb6tlltiHq
         Pe7oTQkQ44KdEP46TAift1xcGtDskOlxBaKLuM3UtMvMX48AnINZPStOzrUQMt/q8Ly4
         nbYozCi+t2Lx2RFYc7pzr2zWCt3yE8YmElY1Lyol6RFrl5zI77Rfy6XwtcxSe2iffZHp
         fCjLWJfWAoOcH5492BGf/Ppf9MZAydLNtQXfFnxN5kMuD0y53PJvlzwN0GGI+ZCXo4WQ
         A11Q==
X-Gm-Message-State: AOJu0Yy2WDzac3d2bWD++7g/8RElt/kdss08//RftI7SP9y38LPgEP9h
	LHGPABmc6ZgxCXildvFDbEEfAdmdl21aaovhYXMwGzUro5L5aoXDiS0+KNzRdn2pxUSN+xqWILG
	923PPtJfMohw83FpzCVXIbrmjzD7BI7bROlBT
X-Gm-Gg: ASbGncsUlBIvgwECjinZ4PHlyaKfnBaBwBCAGmawQ2LusReSEhGt8z/LziycB7A0V63
	cA4uYMzC6SEqa8ZO8a5ugmsbxNdGbMxT73eTLbMcbqJSE4wIidSh+7R0wg/PAur8OZaO9kj2j4o
	Ja6Z5WbdHFsH4sU1e0lXuD4GZeg9X0pRmpkfgvQbywsiWRczLPMZJ4PxczmS8vVuGUx4XnXPA5B
	GJrgDzVvzmR7F10oHBk3y3g88PbN5WbsXaoizmG/VflEAr+hnJymNJSX+rEnNCkDliOrkws+FBY
	6qFp2JdmgOeXduUeBRPv/Nvzqf/2gbX8wdWjso7gVbinylZoFLGum0BL2i1oSIlKOJYsj+VzKdT
	nGRQ4VGetPwMvGgft3jm76Ic9Dl0+iLbuMGWtTKGozsK+9B7HuGMGSg==
X-Google-Smtp-Source: AGHT+IHgRpYUo5LWj2h5iZet/vXYlCG6U/e2FdhuzVncF1zpa+P6sL6FtA+/PpyweuZfs+8UjGauF8LXM4kV
X-Received: by 2002:a5d:5848:0:b0:427:401:1986 with SMTP id ffacd0b85a97d-42ae5af529bmr52391f8f.9.1762452187589;
        Thu, 06 Nov 2025 10:03:07 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-42abe62df78sm13231f8f.9.2025.11.06.10.03.07;
        Thu, 06 Nov 2025 10:03:07 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 6590A15CE9;
	Thu,  6 Nov 2025 19:03:07 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1vH4KB-00Gg24-5E; Thu, 06 Nov 2025 19:03:07 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net] bonding: fix mii_status when slave is down
Date: Thu,  6 Nov 2025 19:02:52 +0100
Message-ID: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netif_carrier_ok() doesn't check if the slave is up. Before the below
commit, netif_running() was also checked.

Fixes: 23a6037ce76c ("bonding: Remove support for use_carrier")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 drivers/net/bonding/bond_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e95e593cd12d..5abef8a3b775 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2120,7 +2120,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	/* check for initial state */
 	new_slave->link = BOND_LINK_NOCHANGE;
 	if (bond->params.miimon) {
-		if (netif_carrier_ok(slave_dev)) {
+		if (netif_running(slave_dev) && netif_carrier_ok(slave_dev)) {
 			if (bond->params.updelay) {
 				bond_set_slave_link_state(new_slave,
 							  BOND_LINK_BACK,
@@ -2665,7 +2665,8 @@ static int bond_miimon_inspect(struct bonding *bond)
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
 
-		link_state = netif_carrier_ok(slave->dev);
+		link_state = netif_running(slave->dev) &&
+			     netif_carrier_ok(slave->dev);
 
 		switch (slave->link) {
 		case BOND_LINK_UP:
-- 
2.47.1


