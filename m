Return-Path: <netdev+bounces-244376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 859A3CB5B2E
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2D233002887
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB930AABE;
	Thu, 11 Dec 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7K3yd3I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHZNTGFN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC830ACF6
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453834; cv=none; b=VXYv159SJPHX7p2FKV57xM2B1hZM4c1Uc6YJ0T6LO52kk0qaggmLtSlYef2QPnefr5Inae50ENTde0VtcBcM5gKMjAqi/dTtBzrQ+Vwh2412Jn57aJubBJlrKyAwo+mbMNdcMI/1zlDOKZUmQ4taq/atFC4t83Bdv8T2XEK+v5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453834; c=relaxed/simple;
	bh=Z+rgsSAEV9BsjDbs+xucaGUbyRMZlkyJALVOsnQMMAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HY3c3ZBEAPPcVA3YTlSjImRnb0H3kagkzbmlFJdVAB4lwURUn6Vyg+H7q99DNn5A8lToty/DMRp0cukpMMB1Xv95QO2H0gBb9K37wbAOP31eoNQPXElLs+VPtF3PWR5k5JsjUa7fs9j2JpmA81d1CzyGT9tbJppk5Y/sWD8dgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7K3yd3I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHZNTGFN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765453832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PR7iEiYSjl9ZrPAUcGL5OXxyDi9qkZ3ly52QHdC09rU=;
	b=N7K3yd3IYEQ7yHiPjKBmf/CJmma3+SWfl6wPczb6dS2tT0xP/6WLsp/FmaSvKjBQbjAUad
	eyhAHLj0lt1sXXV6ODVwwD7lOYx3ntWwqz7Yrgc02LZcxrtWtCfTBdu5s6gp2MLD0UvtnD
	FOQi62DC7+kO9f/bkHgm8gmNLyQCvT4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-CBV37ctAN-WHcsP5yFqPoA-1; Thu, 11 Dec 2025 06:50:30 -0500
X-MC-Unique: CBV37ctAN-WHcsP5yFqPoA-1
X-Mimecast-MFC-AGG-ID: CBV37ctAN-WHcsP5yFqPoA_1765453829
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70b974b818so58950866b.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 03:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765453829; x=1766058629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PR7iEiYSjl9ZrPAUcGL5OXxyDi9qkZ3ly52QHdC09rU=;
        b=GHZNTGFN1DEmdnd5IkV3v6Tk4Z+5cgY/RIodzRFqxhz9QPIlfOx5igDj4geGVicJw+
         125dC66p4snE1CBgnS+t/R11R4rV5y32qZzecRFqzZDnQy+h1XeCLWfKUSasiDkifMJ0
         Z8DkFeTnfKXkoqJooKdA/zd524cZ3/KRKptAKIEvTfO17tloP+uGIfrwELs36b39CjU5
         eh6v6B/TwMwo16Z+VHTwPbjCua+H9vMczv21L6eqeJtFiClGq+tjUyN3qYoLaJWeiNpo
         a3t/KleXjn9zeVES2eSD+xR2FGO4oD+8a2nLK727FB0QeO3dRyw8pQyWyZJBqxGqrHcU
         5yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765453829; x=1766058629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR7iEiYSjl9ZrPAUcGL5OXxyDi9qkZ3ly52QHdC09rU=;
        b=dOAZULpy8F5O0NEiTO4OCSpU5+r+mKY7a5f/o4M7FbGMl6jp3ChZwuGkWUa9uNgMzI
         aMyhx53+bJRROtmUBAftWNQNeFAZjwhZ6yd7oi74JsxQe9nvD/kWSlreu0NXS05AO9mo
         5LvlLakcSNGxgkvoMHTiUCLMh3FFEholcv02J3gzHXLEQxf278tlBhRsl+UV4e2fCSZI
         RDtiunDKLRDiNy6nWsUKCmtVu2m3nXWm9+fiMnvlJHvfFj/iIDECt5RG5AMUz7iXbr+n
         Fl07lWSss50tYR9Qehvr22X2XvmtOL1H2FyOEnxuKtD9xbYyCPmnxPt6fZMYDHFb71DG
         1xaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaln8ccvciPnwPcrYNH1XuaqRc18hh3GlC1BIqpx4Zi+MXOv8pCj74mUz5LjwZoIiJD2Gocp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMCdwDWQ6Z/a44oMmWdMM5NmkOd7q2V6YuImHd/CzSBIiYo3b
	1TnoFOVJoqCk/2LCHgtsHGt0dWA8FZO+71kFOeHyX6k/5coyb+wgi+gsQ1pNyzTKWD2ScbkGs+d
	uNba6OoFQYqcaeCv7NDdtvbGW/ERDlLZIWbkQb8P3+M0mYqGzUWNhccMOMw==
X-Gm-Gg: AY/fxX6ZuPw8z5O9EjJi5OToXl6WEbU4Rz3BVL6iCuH60se1H5UGdCUF2KiESPeoMqH
	RFqFoaUExsR8SZ7iX6Q2A9ML3HcCWcof5Xb+vC7IGK+sJtJQzNPVTFX5vGerogMPYUb+ovvx2yA
	NU7LCgqPFWjQq0l9cBbrRHrvpi6letkwr6rAM75DNeYsc1o1ZPCnErbBgOx3FmZB/MKi7Ee9UeZ
	v4LrcVqMD1uQeWDbiGO236QGmgMskxhGF1iuVl4PZ+nlzPACorN6d3PInzCHZBUKBazdCkT6jrL
	+DCPJSNm1nt7sfKo2qOlTDBY2eP7T8JIFzu0vPinbj8DjtCtqRYAyi0IY7OBk/6s6PDl71j27nm
	o0z9fAlWTB0eCtIba8zaptiA9ihfJZP7tUoEQ
X-Received: by 2002:a17:907:c22:b0:b70:aa96:6023 with SMTP id a640c23a62f3a-b7ce8357f13mr615894666b.24.1765453829317;
        Thu, 11 Dec 2025 03:50:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTpdh1ilYIMzAcUMWCxAHOJWluUexnVRm3sq63DN2fy/28cAx7yEGBnAD7+MpsuHrz7095vQ==
X-Received: by 2002:a17:907:c22:b0:b70:aa96:6023 with SMTP id a640c23a62f3a-b7ce8357f13mr615892166b.24.1765453828912;
        Thu, 11 Dec 2025 03:50:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29beb7sm251624366b.11.2025.12.11.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 03:50:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A910C3CF601; Thu, 11 Dec 2025 12:50:27 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesse Gross <jesse@nicira.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Adrian Moreno <amorenoz@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH v2] net: openvswitch: Avoid needlessly taking the RTNL on vport destroy
Date: Thu, 11 Dec 2025 12:50:05 +0100
Message-ID: <20251211115006.228876-1-toke@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The openvswitch teardown code will immediately call
ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification.
It will then start the dp_notify_work workqueue, which will later end up
calling the vport destroy() callback. This callback takes the RTNL to do
another ovs_netdev_detach_port(), which in this case is unnecessary.
This causes extra pressure on the RTNL, in some cases leading to
"unregister_netdevice: waiting for XX to become free" warnings on
teardown.

We can straight-forwardly avoid the extra RTNL lock acquisition by
checking the device flags before taking the lock, and skip the locking
altogether if the IFF_OVS_DATAPATH flag has already been unset.

Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
Tested-by: Adrian Moreno <amorenoz@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
- Expand comments explaining the logic

 net/openvswitch/vport-netdev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 91a11067e458..6574f9bcdc02 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -160,10 +160,19 @@ void ovs_netdev_detach_dev(struct vport *vport)
 
 static void netdev_destroy(struct vport *vport)
 {
-	rtnl_lock();
-	if (netif_is_ovs_port(vport->dev))
-		ovs_netdev_detach_dev(vport);
-	rtnl_unlock();
+	/* When called from ovs_db_notify_wq() after a dp_device_event(), the
+	 * port has already been detached, so we can avoid taking the RTNL by
+	 * checking this first.
+	 */
+	if (netif_is_ovs_port(vport->dev)) {
+		rtnl_lock();
+		/* Check again while holding the lock to ensure we don't race
+		 * with the netdev notifier and detach twice.
+		 */
+		if (netif_is_ovs_port(vport->dev))
+			ovs_netdev_detach_dev(vport);
+		rtnl_unlock();
+	}
 
 	call_rcu(&vport->rcu, vport_netdev_free);
 }
-- 
2.52.0


