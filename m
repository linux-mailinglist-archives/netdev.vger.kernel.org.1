Return-Path: <netdev+bounces-159691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D4A166C8
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 07:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EFA16845D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541617CA17;
	Mon, 20 Jan 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OiQw5maz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ACF1494D9
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737355615; cv=none; b=TpBb9uKXM8x56XIsuU08zRPzZ8cwd779JBOMJZQMXhWpdQxOxykSdCPnS5WWBPn+6ymT3VhHn879JlQx6E+0Tb+Er+vqQPwYJ8LN8m/8UfSw/3tk1OawZUrKzvYk1kJC7v9Oupm3X+ThS6iUMFk3+2pAHuhu9cM375aArQyvU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737355615; c=relaxed/simple;
	bh=5pqQZkMykC3JXMoqaN+ZurnKZHbS+SxjBXDSMJB8Nb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rPf3RVQjm0HugH3fg9D/rMp9G17XOAi0/AZG/FeQoX/aV/qs11QSjqAWO5QGSKzTpWeJBt/MuIL2aRMYWYJ/l292pvY9+DWFGPLrwhWIA7bHhP+Pqx7iOHfA/+Cjudmjn2vVxzc5mw3dh4FZCf0AtgcZbuLoR3kok3Kyor3pdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OiQw5maz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef718cb473so867809a91.1
        for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 22:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737355612; x=1737960412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1FL1zXGcghyakq5jJFnYf6HGikGvxGm7H4gRI67R3Q=;
        b=OiQw5mazhRNet3UON4tn0A1XIpxYEPnnctU6hbJDOcpPTM5zf8Szjhe7fOIYDzow6v
         C4a8N0OmgiZ92voGrcOycR+kD1SFR8lNFFkDDHMrA9I5MxPjGYhSQ+VKoWjm2It3jZO2
         6tlfSn/omIpUg0RDsiIkWRuUsPXQPGHLDzJag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737355612; x=1737960412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1FL1zXGcghyakq5jJFnYf6HGikGvxGm7H4gRI67R3Q=;
        b=DN28p8in/xtAJFgYReeFFnSWouJ3WrqGOBzo7J8rnoPluS36H4MaTNiKD2qy8dWlAx
         oEZT8FzCMzHyRgTiqhERclikN46CO+J+aLYQy7V2XpYy+Jwu/m13DQ9bWeZUKPOuzQjJ
         o8gOVptOto8OOZUSwvUr+owU9BJwD87OnOuEjBmLmwmJzJRBJbV6E8SqjUeB9tfCQuPA
         WRf/XScSo1pOTs19kYBbekI0aNgo5GEhR1hkWAZwQ0Uy4YwLSW5Yb0dVTLN55PqsmoNB
         sDBLNZEdyW8u5o6HbDJQzLeKPRrl+Q+liKYzOO5wXSza96NZ9TdWhCcLmU7dqcuTP6i9
         Sd6A==
X-Forwarded-Encrypted: i=1; AJvYcCWaOS7GWnMCAbbkFBj7FipffZHs7oNCsqWuGb2RbeXL4J/3OczTWDVCCxMwyti/2usJf8L8od0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYBfoeTt/ysQf/W4SGpfJ38CIiz4ZZ3ZLYOb4aTy0FyNOxZ12
	Ea9YA9Rs4Zau+D+/ICIjhFT/0gPOqNSNq4gZ0k4lIBRWJVB6uiS6uigneHYbaA==
X-Gm-Gg: ASbGncueYcsAt+fnKl21eySHDXSWtgycMtWE+JMdr8gK0NnbkPzY/N4zuBlBpo4IBzs
	ou4CciVDKhM+NzdcTuQvAGQIkoVffLGRNJAncyvfzOaLcsXHup7rLjR/nl5xOffuN6R9ZU/Vc0A
	PWPeDkgj1ezJCpFqDU4jONk+QrBdu/i1nFNfEi8u9EFXmcygJq+4OxMetqFWquHvleChN7S1h4t
	fbewgbYx1h3Stch4nBwH10yPSIJr6+y52Mwc91wS5XC+svMDOzcq03g6heSEx+IG/j0W8Qt/alD
	s8eZJpeC2SCQ0W0eWy46h1+OXiiChHRFkotaiw==
X-Google-Smtp-Source: AGHT+IEYpgRdLItQd5/Tlw0NlvDB9gMR6mMU3xksiQtwizDh2l57h4EiKgvPCSa+k6iJA3IpTpnLkA==
X-Received: by 2002:a17:90a:f944:b0:2ee:f59a:94d3 with SMTP id 98e67ed59e1d1-2f782afea54mr6765626a91.0.1737355611976;
        Sun, 19 Jan 2025 22:46:51 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c191e2fsm10949617a91.19.2025.01.19.22.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:46:51 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v5.15] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Mon, 20 Jan 2025 06:46:47 +0000
Message-Id: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a97de7bff13b1cc825c1b1344eaed8d6c2d3e695 ]

syzbot reported rfcomm_sock_setsockopt_old() is copying data without
checking user input length.

BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old
net/bluetooth/rfcomm/sock.c:632 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70
net/bluetooth/rfcomm/sock.c:673
Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064

Fixes: 9f2c8a03fbb3 ("Bluetooth: Replace RFCOMM link mode with security level")
Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/bluetooth/rfcomm/sock.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 1db441db4..2dcb70f49 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -631,7 +631,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
 			err = -EFAULT;
 			break;
 		}
@@ -666,7 +666,6 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
 	int err = 0;
-	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -688,11 +687,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level > BT_SECURITY_HIGH) {
 			err = -EINVAL;
@@ -708,10 +705,9 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-- 
2.39.4


