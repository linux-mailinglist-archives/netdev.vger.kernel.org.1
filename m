Return-Path: <netdev+bounces-212803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CACDAB220A7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331FD1AA784E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091A2E2827;
	Tue, 12 Aug 2025 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1HcdkPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D22E2657;
	Tue, 12 Aug 2025 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986972; cv=none; b=YFWyxZS7h2BSx+GfO/0xPdyhNG/o8857VdEiRG5pJjLBfx49GpQ9aplpFXnW3zf0TAVJ2wnEdvRlK9UVDZ3ZT9OsYgd+Z9fABwUJn9e9qJ0Gd9HLiJA+ZBmjOXgWOUguoLd0JFa22draV0C+wZrLNo+u6d6Tlc8x1RnN+EtzJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986972; c=relaxed/simple;
	bh=fJX20PohZpCHadUb7Zc2OniYoY/K0awKaD9ACu1c3jc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ug3A/8EiPWZa5GeVwUx/ztkOPmr3qX/iXgAUs2r4DTDWfXvjJ8++IsA8mTodgLE92XhbKNQqWdY21W5yK7zP4frGWgffv3S8RUN61oHpJdIRRmn2Vd5Hvc54u45SLjFICnMYBgMXMmw3bPMiVRc7Qt2vYOli64UxlIrVnNx8gnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1HcdkPY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459d55ba939so2388465e9.3;
        Tue, 12 Aug 2025 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754986968; x=1755591768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YbyGTm/Kphup1yQ5OdKhT2GE+zUDtJtHd0XwG3yDXbc=;
        b=k1HcdkPYU6xZZHO5/JOTOkhwOb0hpYmXQUmBTkkxMHnorHfGvRaEhgaxjDW08qL52y
         8S6hJQ9p57SADuHKQBDt1AvGRMBKmQ2vBEH/XQwZYsYmO9AlW7vZ+j7HV/OMMLd6C1h4
         mvq4TwyD4LUOhonGdNAoKqJkMqYVKPehhIHJxgU+4OFg9PbODMbH+a1TXTQo8y/fIPnV
         hHvZi/49LTDfcBW+5fviDvQux8QEltVYk/eQbH1DpgzL+eMJzcvJkFQ4dqoe2sKiB0dG
         d4CuUXgZ2z/C5UTRHKnJOmUi76Eyu+0rPmE081Ie/JvedF69DunIr++tmJUfMJHMVMgt
         tnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986968; x=1755591768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbyGTm/Kphup1yQ5OdKhT2GE+zUDtJtHd0XwG3yDXbc=;
        b=DgqGcS8kj/6GTnxLuHZRYPfKJIYB0KrPDKULP4T233X6HPEnZQDysCCPSx5CfPYUkZ
         WRi/z49gPPwJdhz+zniqv1ZcpPJBb1u3Uyp9H+ymirBNnIlH8lOIbRkAW4YSbvdukNEN
         7zM5WwsX2FJu1KzfQW8vSerVSCIKaKGD7/N8+/CQNmTJEbxp6Ritms3DrdecfPtq98NB
         OJbT/kih/0Ki77mso+SsLHq+iexBGpfaDGccCsaC+M7zh6xmgR8JhFtpbR1gfa2qqcp0
         GnZA8qJRlP+C4PDzKyz46Z94HzARDGZ9tlAyPKEEcecKjMs3PGU7ZrcbjbqFQZvuLsfU
         A/lw==
X-Gm-Message-State: AOJu0YykqP1f8nraWTgAlYCdmkD09+W6JwxhsjauHCrQJ1miPYUjvXS/
	FHZ9EYpqweKsuBLAHXtiGQrcrJIsSQgYrgzBu5pvZdnKeuGuSk2rg0fwyBMQD0b5eAU=
X-Gm-Gg: ASbGncvzl45exy7FteWg5NVB6MExZ5U6cxQtq3s2JWemBUu12dW+PvJbInWoeniyxJ1
	518aQBEKSDRLDcdkGobnwFlqM3yRY13dXbpueHDl1+XHOEiN/WbJldsi5MPgYJ+qS5prsgy/BKv
	ZfaG+aQ7szZYkngsMSEYfqx9NGZfeBOFvzfA+3nHsDX4DcWdO6hUp4SP13RlRF+HkH16z/Ny80q
	MO+lZQKbLZ6ygIA1PCowIz3BrbbHpsSbOpg8M+ymGGVVAb4jGrykRAW26z+jeEqxWOlCOprIsul
	3qgO8Zqpmpp+66ocukLN08n6l8HsZW0Nb/0aL/TvzFqACVTJEQQjaF8mL0Et1s7yPRpSj7RAJSZ
	n0oA3qkEdhOE7VsXnYIeIlkzUd5FxMzwqVckFTyG3ZqrXpLsthuAk5s9R5bbor8NoKFiJxidv2V
	Ulb2fJwrM+
X-Google-Smtp-Source: AGHT+IFVpnUtIAvOnPWm8jbKDKspsCrZdFXLx787xQt1P0oYsLh7XnWPIpJj+MxukmZjQbC+KPQDmQ==
X-Received: by 2002:a05:600c:3acf:b0:458:b6b9:6df5 with SMTP id 5b1f17b1804b1-45a13f53375mr2090295e9.1.1754986968337;
        Tue, 12 Aug 2025 01:22:48 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b90fdc85a4sm4142823f8f.60.2025.08.12.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:22:47 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH net-next v2] tun: replace strcpy with strscpy for ifr_name
Date: Tue, 12 Aug 2025 10:22:44 +0200
Message-Id: <20250812082244.60240-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the strcpy() calls that copy the device name into ifr->ifr_name
with strscpy() to avoid potential overflows and guarantee NULL termination.

Destination is ifr->ifr_name (size IFNAMSIZ).

Tested in QEMU (BusyBox rootfs):
 - Created TUN devices via TUNSETIFF helper
 - Set addresses and brought links up
 - Verified long interface names are safely truncated (IFNAMSIZ-1)

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
v2:
  - Dropped third argument from strscpy(), inferred from field size.
v1: https://lore.kernel.org/netdev/20250811112207.97371-1-miguelgarciaroman8@gmail.com/

 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f8c5e2fd04df..ad33b16224e2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2800,13 +2800,13 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	if (netif_running(tun->dev))
 		netif_tx_wake_all_queues(tun->dev);
 
-	strcpy(ifr->ifr_name, tun->dev->name);
+	strscpy(ifr->ifr_name, tun->dev->name);
 	return 0;
 }
 
 static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
 {
-	strcpy(ifr->ifr_name, tun->dev->name);
+	strscpy(ifr->ifr_name, tun->dev->name);
 
 	ifr->ifr_flags = tun_flags(tun);
 
-- 
2.34.1


