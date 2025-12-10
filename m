Return-Path: <netdev+bounces-244252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3712CB2F66
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 14:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03199301C362
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF56D312835;
	Wed, 10 Dec 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO2yZj32";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH/PSYN+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52083016F5
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371596; cv=none; b=b0azUqSxDY1rhTO6+jDSRH8ldubLm+G5GBFUdE05YiKHvI2hOyet+AmxHdBzcJYkXHuUxThOkswCG3XFUPmX9TY0FlZhCPin132Y0nHItU8pjIsaEBH9flO6JbgH1C3T+rVtato4RjdmzNqyjQ35TOVVL9GM83Drjb4Pil6b88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371596; c=relaxed/simple;
	bh=ak0zk3gk9dscRgHPIHRm8SOh4OobwF6XpRs0kjrWVvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HhN2G3zUqLHBNYQMWbw82bV6ua91NVbKEQMsjifhVT30tq6+ClPmjQijFozCv5lGd3smPbli7zoxm2wL8MLgiDmMd1ThpIVtS0DbAj5+iu77qCB+oTImZiBa68TAgTh3MMNXQGhtbVhffnCtFdDaDaL4oCHvmWH9oms/mugJoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO2yZj32; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH/PSYN+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765371593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hdea7TA7HkU2z6SeSJ/+Gi+F/fI64K0I30DUSHQkoQc=;
	b=MO2yZj32UlTUrK7dp8TGFBm2gxyONvljgvrqr56IRbwgHtTQXuBmbCugjLS6c5dCOXIbYR
	7ZCmCgHmku2d/Cs4refOEryA3Mm12IlCygSquvAgzK3tx6aWC9Z8Z1z0cvYqSDU0jKZWuV
	YeWhHCTMGMzr3RRuMeiVwmsLgW69f2Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-d0Sih3BkO1W1ODcfI1wglQ-1; Wed, 10 Dec 2025 07:59:52 -0500
X-MC-Unique: d0Sih3BkO1W1ODcfI1wglQ-1
X-Mimecast-MFC-AGG-ID: d0Sih3BkO1W1ODcfI1wglQ_1765371591
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b7178ad1a7dso690199966b.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 04:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765371591; x=1765976391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hdea7TA7HkU2z6SeSJ/+Gi+F/fI64K0I30DUSHQkoQc=;
        b=FH/PSYN++FXKe5DBfQF6aAc+KZFq4dmK3ZXWY3OI6UDvfL2LEzKsoJgQhcPEmCETu5
         TWa6ogUguHgIRASuA55s8uZ/m0k0HiKt/z/6qsLd1TMjeL6l+MB/Fx/iFeHy34i9j48m
         MqKrZzIUmp7nRQ0rKRBatMCwdlUaO6nZapKf0MnEI/Ob0j5OT5zXL2sdAhLpuXsfnmna
         JWn2fI6n0oAGKrW1aTbyq09wBGIeJwFGy8W5VJS2u8hCTUe8UbaZt75kO26nfmhDumdD
         K4UfVHr7HK7o534fNOtnOGoYQNDA72bt+4rD3Xql93w8TkXdSy3WYUfqoiEcNaoMEA3j
         JyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765371591; x=1765976391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hdea7TA7HkU2z6SeSJ/+Gi+F/fI64K0I30DUSHQkoQc=;
        b=M4VRlwY61FrFKJ5AWLR4eyHf7dY7Ej4lYhIKMVfQwRJhRwrwAutPKZQdIc48shF5f2
         9W47vK9K4MtoSU2AnAnBMzVbemr9CFf8AKmeFXtEhjkJ3t1dfl07ZXb2kJ3ElTyLbi9H
         1a0B4qv4ZqZiCWy6tWYkYABO6sLM4q1nopABhYyd0jLoYTrMy7HGWRuT6PR6n2VNVhSX
         dXSb3+p+kL2Jr6hzEVTXY3qEog3ywaUkffn14Pks7xj5Eym/KndFEdbYyP/H6OWtFKLj
         jpr73VvqhsMK7L7SHKXfvtGKhqRgwRnFR2grdMxFnbs25wYbmugm1kuxTp6jlZQGx1Nq
         w7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUakd18uMWL17MnRkpYYUiG1ImZDblzHQ2fhRV4bK5Ma2wSYDd4gsTpwmOj51phLtGvHho9Rug=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2mi7J28wvW60TQochLHIKo5b5kBRsQqeLd/hJ2+aE0gKbPm7
	XCiHrD0ysPUafV7cQ8VncgZ+fZ+B0p+rpvUxuToK6mIdoMiP06qYcLqACD7hKHpoc6nK16UcBT8
	VIyW13qGL7empNmLaVSX/+IILqKbwgy57vOxLLfafNvS4NA68awlv4ulczQ==
X-Gm-Gg: ASbGncuSzDsw1lju6qHK+OhgOISLciRVTrFPZnS5JThJ7ZbM0Tzd7Uleh/o3EeJs1GL
	coasopSIeG7WRaVnvz/ozwtxFISoq43MBWXwv5nLIJ+8WGis5TBojJaGtsads6t3oHgbgO6ZyWS
	ysWz1BhjIXV5MBBV/+ptEy+EGScKQ+gQGgqmYOGGor7fMARMXSKceS2nxMakqLCrySpkm80OsQv
	QQgkasSyBecB8k4d2E8j+mhW48Wp/oTd56jmBettEVcfPgLw4nKJ85ouhyHSoSAgaGwvCrtphiq
	5JiRvutCw9Sbyw79iqczoiCv+109GzEH8Mzb8YlR1VykWMRsy895N89xqKHb5ISuhtNVHgvIjY1
	5w6KExUiuyj6wDrJUFhVLp2GoQ9VNyt5dHw==
X-Received: by 2002:a17:907:7250:b0:b76:c498:d40f with SMTP id a640c23a62f3a-b7ce82b6bc2mr264488766b.4.1765371591339;
        Wed, 10 Dec 2025 04:59:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFD/RgOwrIPi7WkgrO78Bl7tD+Npi2QpygX3/PnLEHSGRESyVFSi5nO8eJS0uupHmKIWoOkg==
X-Received: by 2002:a17:907:7250:b0:b76:c498:d40f with SMTP id a640c23a62f3a-b7ce82b6bc2mr264484366b.4.1765371590901;
        Wed, 10 Dec 2025 04:59:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4977ecdsm1717111466b.41.2025.12.10.04.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 04:59:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7B6393CF58B; Wed, 10 Dec 2025 13:59:49 +0100 (CET)
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
Subject: [PATCH net] net: openvswitch: Avoid needlessly taking the RTNL on vport destroy
Date: Wed, 10 Dec 2025 13:59:44 +0100
Message-ID: <20251210125945.211350-1-toke@redhat.com>
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
 net/openvswitch/vport-netdev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 91a11067e458..519f038526f9 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -160,10 +160,13 @@ void ovs_netdev_detach_dev(struct vport *vport)
 
 static void netdev_destroy(struct vport *vport)
 {
-	rtnl_lock();
-	if (netif_is_ovs_port(vport->dev))
-		ovs_netdev_detach_dev(vport);
-	rtnl_unlock();
+	if (netif_is_ovs_port(vport->dev)) {
+		rtnl_lock();
+		/* check again while holding the lock */
+		if (netif_is_ovs_port(vport->dev))
+			ovs_netdev_detach_dev(vport);
+		rtnl_unlock();
+	}
 
 	call_rcu(&vport->rcu, vport_netdev_free);
 }
-- 
2.52.0


