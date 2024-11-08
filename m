Return-Path: <netdev+bounces-143157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00219C1488
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19071C21217
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBAC86250;
	Fri,  8 Nov 2024 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="bzMD7npz"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F3F5028C
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036285; cv=none; b=usOPIc+2iiy+ikvfE8IJGyB82+FhNPpwx74aHZv/Dt6oQv2vBTop9+624oJlAlpPoq9rolyhwymMENqXkx+ZJjaaJU6XxFAKN2F+op89QDmkl4HGaDjHXjsFG8Rsnx6JqZcK2fZ4Y/7SBTxUBmevZ8F+8CDbIAsLRnXigP8fSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036285; c=relaxed/simple;
	bh=lLSqoKq/T4l6RBJ8zfCbt5aQRxyzGo27J1eG6/wasD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQRy/2UMs1QdI9QICX55aSnEe5U3ohn/MYrcuPJVF6RlGDaGSqXSyQwtoeBne+05h8fMKESFOB25jUOWogOBvezujPRPh7hGZgerUjGGeNgtWiz9Bx2rnL1UBZVWiVr1uVXsiWt8FaMjTc4Ni6Q+NKUhtQiPdL2MV83hONDIaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=bzMD7npz; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D0B512C012A;
	Fri,  8 Nov 2024 16:24:34 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731036274;
	bh=xxqdA1Ic8V67HLWIqbU77R3bHiXDwP4kE/vbjO4ZSws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzMD7npzH1OoVSJwcWGFuB3gX2riaz3JzN8EKGe+ZSkEHoVrTeZKEXmG3H9p80UPd
	 h56xCtehib6k5IPStqTI/+kfjDrDZvRq8jCKg0kbJt8aNd9ylPCx5FZsBaNhitWOvB
	 lapNdIBPhfmMKyS/FS5xUHFRyCxeSx/cYR0pgM0Tu1W0eRzJzd6ty54WAgySDq4agq
	 4Lk3IeN2Ll+LJqbB+e9X6+Szrto2IksCEJk8z+CWj+6EEDpQ5nyI8oX+QvCve99dgr
	 gTFStPP4In4197sKk+N1lCZjfYAJCnOng8xz3sElOq3yjAkt+LFRDm+TTR/RNBDM0X
	 XufOwFvYb2Crw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672d84720000>; Fri, 08 Nov 2024 16:24:34 +1300
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id A5FC813ECD2;
	Fri,  8 Nov 2024 16:24:34 +1300 (NZDT)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id A3FA83C0261; Fri,  8 Nov 2024 16:24:34 +1300 (NZDT)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: davem@davemloft.net
Cc: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 1/4] net: bridge: respect sticky flag on external learn
Date: Fri,  8 Nov 2024 16:24:18 +1300
Message-ID: <20241108032422.2011802-2-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
References: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672d8472 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=m422leTbPw5OI5gFfpkA:9 a=3ZKOabzyN94A:10 a=ZXulRonScM0A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The fdb sticky flag is used to stop a host from roaming to another
port. However upon receiving a switchdev notification to update an fdb
entry the sticky flag is not respected and as long as the new entry is
not locked the host will be allowed to roam to the new port.

Fix this by considering the sticky flag before allowing an externally
learned host to roam.

Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 net/bridge/br_fdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 1cd7bade9b3b..d0eeedc03390 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1457,7 +1457,8 @@ int br_fdb_external_learn_add(struct net_bridge *br=
, struct net_bridge_port *p,
=20
 		fdb->updated =3D jiffies;
=20
-		if (READ_ONCE(fdb->dst) !=3D p) {
+		if (READ_ONCE(fdb->dst) !=3D p &&
+		    !test_bit(BR_FDB_STICK, &fdb->flags)) {
 			WRITE_ONCE(fdb->dst, p);
 			modified =3D true;
 		}

