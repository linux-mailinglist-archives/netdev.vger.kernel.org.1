Return-Path: <netdev+bounces-162949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B20A289A4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A731613F8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028D22AE73;
	Wed,  5 Feb 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLdq0isV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840922B8DA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755902; cv=none; b=GOQf68ZdqvoS3nm7/Akn4Z8ACkC9tCZ00Pm5mLPOauvlPmN2MdvL3+arDpbGf/GnoxCYOftvYEZImMonuUvyT/3S4NkZ7FBNIAPYaQsFanEGdUJ+ogiel8slYJj7yWol5amdPiSU1A1oJvWaXo6V92HUgUsKbvWWh0aqOPW/tH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755902; c=relaxed/simple;
	bh=27fe5ryjk/OaLjPyQGCWhvjedtM8clikj30Rqn9X1TA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mP0z3q1/XOgMDTinRzJ9Rn88blciGwAKW6zK9jiNd7nwYpd7LcGLSwlcnCQGwNFQGWxM3+zWS6XIhnDkrbBTS+MShDeYSkoEG7py93GK9qRjwSHvPr/udHo5OZ660Le9i/KYhxsnYqp6JcX9+cLqyRt9ZY8vVmYwy9QxPnlk8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLdq0isV; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eba0f09c3aso1672571b6e.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 03:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738755900; x=1739360700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qEqyqvJmczl49ujmfDVHQ8/j2V1XoKkO4iF9HFfdHwY=;
        b=QLdq0isVlnj3TSNmFs+sZfO2dN7RqyVGrw3QEkdFXPmIOZKL77BqeI8zqq7RUJmhhA
         Wt53vs2qq2OFFLMPjBHY9gySjQgDUjp1ViVdjtIMSevszBX2zPoiHyo6Ukc39ya/pOJS
         mJuOvdQFb1sT8TUxvspS01PwAtqhIFjjn/fHr+8ac2Z0dFlXYb3ltSKpu0hHEmI/uQuX
         i5rmobFKazBo09lhZE1WpKsp60SOxV50ku5lQAh31cLWkAfgKc1LMAr75vpPeWRfgwwd
         vKnilnmhfqZBg3QZp+FsnMpArTp0M7UZVr28PpgDSj8bJkl5HDfQV4h1bMToN/PF1z5t
         IQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738755900; x=1739360700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEqyqvJmczl49ujmfDVHQ8/j2V1XoKkO4iF9HFfdHwY=;
        b=GiNdqmw/94xzMngaVYoZOeUQ5OKPe30PQI5r+b9bW61Ghzzwosd57ulBH7Jv11BGR5
         wRA8BDL8AUdRn7yyjLXQ5kYtNGl1RS9mltLhnKLH34nmu+NR5fAU7wieVm3ZAaLbpH8A
         hRosmC2BvI7fnqJIJ7KweokfZoKvK8urNzBKhQGoCwla8MqKeJHTdIKuA9zVio2YUDTi
         cDhyrXPZ7FaKhhOGTw/GlcTDv5AsL2St62Bg+V/prWlovLsXoagY99YxGyQolIIJz8+5
         YNWTd582O+KuxkjxSd2bpkJwCMc+Qs2VXKoYG6ePd4oHGYK25196ummkasejB7JSuwe3
         ZFEg==
X-Gm-Message-State: AOJu0YyDymoQepm517Mg8mr4nO4fkwfzS07JN0tqdE0ryl2okExwYopL
	02jDEpFsPHdlg05itrHy/IVzJCkwxdKpVPxrESgjJmo+aLO4dNI=
X-Gm-Gg: ASbGncs9IiloBWNqPFz/r5ShRyY/NlZQZxIVz4n+IxkFSCb0A4sOQJjwc2y8yhzGAaj
	hvXbXCLi2ZcjWkn6UzqNFTCzXc36yFm/Isb+bjaz9tfkmVT4xZjSYa5BIYjBpNPa64aq+b/4fGd
	x04gYNPoHlPvdyRdfXxYGLCW/wHb4r8QYoY+AeWTPx5qOXhIzs+mne5a+fwg9ano7l1DnAw77KJ
	KHiWVxRry5jj6ZJwR2y+E3o4hcayTr7HTXoo4kpbb5S6h4uF93TKm+D128bVD4yctdKKZ91flxf
	Yyi4f6TgG+jH//M=
X-Google-Smtp-Source: AGHT+IHRCKqYwq+cFMMyqvJDIWNDtpfaH9TUAMEbTu+fM71K7hkQmGRdBcDi873MUT8/wO7/dDdiWQ==
X-Received: by 2002:a05:6808:1a16:b0:3ea:5ef1:c95 with SMTP id 5614622812f47-3f37c2263c1mr1533175b6e.25.1738755900224;
        Wed, 05 Feb 2025 03:45:00 -0800 (PST)
Received: from t-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3332bb032sm3592306b6e.0.2025.02.05.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 03:44:59 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net-next] vxlan: vxlan_rcv(): Update comment to inlucde ipv6
Date: Wed,  5 Feb 2025 19:44:48 +0800
Message-Id: <20250205114448.113966-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the comment to indicate that both net/ipv4/udp.c and net/ipv6/udp.c
invoke vxlan_rcv() to process packets.

The comment aligns with that for vxlan_err_lookup().

Cc: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5ef40ac816cc..8bdf91d1fdfe 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1684,7 +1684,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 	return err <= 1;
 }
 
-/* Callback from net/ipv4/udp.c to receive packets */
+/* Callback from net/ipv{4,6}/udp.c to receive packets */
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_vni_node *vninode = NULL;
-- 
2.39.2


