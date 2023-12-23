Return-Path: <netdev+bounces-60069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C265981D419
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 13:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699321F22097
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CD9D28E;
	Sat, 23 Dec 2023 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLsuF9ZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27373D26E
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35fe994dab5so3413335ab.0
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703336368; x=1703941168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+OMMnbBlHqC8tR2V6U21vMMBDhENceX7jdbNuVCiTU=;
        b=KLsuF9ZQRzzgKySjAD1jkJgiR0Wnk7oSJ6rnm1qmwN0GkH7xC1/cdzH1Ytl32uXvfT
         hyVoKRZziXJwt2oI3GJd5H+VR2QYaSKENZPrYMEx7WMV9zPaVvjKKn11AscW3M14kfJk
         Y3uj+JpvC1AFp9pgnaY5yylgkDDdztvFQfU3O4+Y4ZM8WBC/Ju7SXl8i6YnGnbdJJObU
         v5mxq92fLIndELf2TZ2xwbVNHvHxWFK8VCPHSBQSW0EiA5xDxLv/XwqHzKgO7HjQwcM1
         LActGMnRu/tOu6LIaj3kMXhY0JW3TU2SQSzwn4yKW3jyLne5MCv2R98SU/D1JWEN4a8B
         T5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703336368; x=1703941168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+OMMnbBlHqC8tR2V6U21vMMBDhENceX7jdbNuVCiTU=;
        b=kL4URph6u1vnf0kFuT9U+ei51kbik4CitEETrxW1dYz62KcexLgP/I4YdSVWkbmeLZ
         /EddgBVaTShWiaP5zsrF9E9SPvLW1ZjXrsM8n3iRL3AODsxyWQV48weVj0CxC4yMx1l1
         +MJLOZi3s2YWNqmZy/x1juAEExVeVEA3cD5IXsfrldU/XqPEmC6vWjT77OFpsGSsewfm
         FgBdCA5e4CgexqZkTlL9KYRPsj/NWJQrna+Sn8rKCCioQHSKWEMRj1VdCMyZ0c7vDC05
         pXqT8ZrtcY7tssUA0imVTmvglYdcAQAuOZmbscOaGn4H46q/0MstMiF6FpJTwktGwMvx
         XCCQ==
X-Gm-Message-State: AOJu0YwzKi1iIcvHazBSNFv7Tkw4lsKrMRo13SMnkQyxYgFACSRXRKof
	DtqJGUZcFl2Va03uBoNtgsOhrQ//UFPuLktsN+A=
X-Google-Smtp-Source: AGHT+IEpTvJyZxItwLvR3GlTwI5Ltx08S8tpdbTNZa28WrKVAjOoL7i/9i254s+9vJpP+m3WH9Iz5Q==
X-Received: by 2002:a05:6e02:349f:b0:35f:eb24:6bbe with SMTP id bp31-20020a056e02349f00b0035feb246bbemr2166045ilb.41.1703336368697;
        Sat, 23 Dec 2023 04:59:28 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d21-20020a170902c19500b001d0c3328a63sm5106996pld.66.2023.12.23.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 04:59:28 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Benjamin Poirier <bpoirier@nvidia.com>,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	David Miller <davem@davemloft.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: bonding: do not set port down when adding to bond
Date: Sat, 23 Dec 2023 20:59:22 +0800
Message-ID: <20231223125922.3280841-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit be809424659c ("selftests: bonding: do not set port down
before adding to bond"). The bond-arp-interval-causes-panic test failed
after commit a4abfa627c38 ("net: rtnetlink: Enslave device before bringing
it up") as the kernel will set the port down _after_ adding to bond if setting
port down specifically.

Fix it by removing the link down operation when adding to bond.

Fixes: 2ffd57327ff1 ("selftests: bonding: cause oops in bond_rr_gen_slave_id")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../drivers/net/bonding/bond-arp-interval-causes-panic.sh   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
index 4917dbb35a44..5667febee328 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
@@ -30,16 +30,16 @@ ip netns exec server ip addr add ${server_ip4}/24 dev eth0
 
 ip netns exec client ip link add dev bond0 down type bond mode 1 \
 	miimon 100 all_slaves_active 1
-ip netns exec client ip link set dev eth0 down master bond0
+ip netns exec client ip link set dev eth0 master bond0
 ip netns exec client ip link set dev bond0 up
 ip netns exec client ip addr add ${client_ip4}/24 dev bond0
 ip netns exec client ping -c 5 $server_ip4 >/dev/null
 
-ip netns exec client ip link set dev eth0 down nomaster
+ip netns exec client ip link set dev eth0 nomaster
 ip netns exec client ip link set dev bond0 down
 ip netns exec client ip link set dev bond0 type bond mode 0 \
 	arp_interval 1000 arp_ip_target "+${server_ip4}"
-ip netns exec client ip link set dev eth0 down master bond0
+ip netns exec client ip link set dev eth0 master bond0
 ip netns exec client ip link set dev bond0 up
 ip netns exec client ping -c 5 $server_ip4 >/dev/null
 
-- 
2.43.0


