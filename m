Return-Path: <netdev+bounces-121278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024295C84D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB81F2347C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBAF145B00;
	Fri, 23 Aug 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lYVqsKUO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A97346D
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402538; cv=none; b=ilsflda0zCJUmCiksATSbG9BNasEaRhJvh7bG3N5Z1KcQ0Ml86eAWQwu4UiqaQWR93yqAUTgdsoseYa66B/m92fgPqp/GV9pMW6wXJFUOq4bQyAifMeYo9n5Y+95c85eUCmicCMMziiGInsYeuBlL6vXZ4WPW4/GCK4ne8RWSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402538; c=relaxed/simple;
	bh=er3ldAacAISiKuIrc+S0Cy7dUbUKLUyxcWVpv8fktw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=skfeVo56TtbDGEu3mZci8+g+EivNXpaWF96QmHwc1rD9QOAlV1xMWlEzhobXYnS0pjyA0XA7hiTkYrccl428kotNtuOA4cJ+JABjTbdoYToYHk44MJy/RfBuMkq4AekXy6On3El/4KGl91nax+bQiCl47jVEVAMt6wnOAnDSRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lYVqsKUO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd70404bd5so740563a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724402536; x=1725007336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0VYKazBHx5RAkPfvbSrtx9Aay+RtLgwI3e64WjTUdE=;
        b=lYVqsKUOErvoOXMMyaS0kKfN6aHjhkksDJKXFVbEopASRAj+ng6szgH3UszVmkXzJB
         Ua0fRqPdtG8OcM77QWNA+EgR0h0w5YU0dke2+7fEjdbDvKtTZg/XKiqH75c5HzNUTGNU
         XYr9gUEp1rnla2LR9HhMygDrO4uNdGZlOBa/v7CClnIqpyQ906AtV0x82MB+R2NHNfWD
         1tUtZ0J0hh8dZMJl8LG1vWWmnRZHJMHGr+wCaIrBfg0sRZ7pcVDZtOKZkYu9N12dbR7O
         atgg/Q0Un0FS6bwdE22PvMCIfFAinBjgARUxHvmYROnLc0J85gR/ar1Pl4nuZdUPZ7/R
         QmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402536; x=1725007336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0VYKazBHx5RAkPfvbSrtx9Aay+RtLgwI3e64WjTUdE=;
        b=GWI3xLpqH6oEtT865vUOZPwhZxUPooB9yhuXaKlq9KUXcupKyfOZ7c4gEBMx+1ddzR
         xxEduykUuiwoQHRNULadSGDA5QBs3hTpXokJDMl3xVQ3PZubeNmT46A+T/WxllIDD+lu
         UF4XnpiXTE35ZLEpUmi4stSX9UiSrtwF3GhH5dPlJfs21qlUjhLVZgWyctZTbPYN8vDL
         hGs51YHNv8lkrLU8+ACDVdhcfKXKpsuBIuqFeJyXVmE9c4g1BOVFAC4/Srz0PD65NgVz
         SW02uGYCJwFMLPAuIEXMFDUXa7CzB7QPsVYom+NCvwYDc/Id50F78DLfhHxIdM+7e7r2
         k3Ow==
X-Gm-Message-State: AOJu0YxAPVFyja5dROMgGjvdTzavd8XH0c2urNIG6/YBvePIEzCKK2XB
	Gma/7kGItAZyyDgVWiNDO27lUYXQ6BQW41Kd4ernt7kXTb4WYZdTRjrRUsyfqMQ=
X-Google-Smtp-Source: AGHT+IGshkNTIduaJa/lscFaNRfIY72EQHcQ9Wkq3p+g4GdDaJIuRfyI0KI0dQp5V5Up4zxguq22aw==
X-Received: by 2002:a17:90a:ff17:b0:2c8:2cd1:881b with SMTP id 98e67ed59e1d1-2d60aa0f083mr8560055a91.20.1724402536237;
        Fri, 23 Aug 2024 01:42:16 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61391a783sm3457332a91.14.2024.08.23.01.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:42:15 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v2] net: Don't allow to attach xdp if bond slave device's upper already has a program
Date: Fri, 23 Aug 2024 16:42:04 +0800
Message-Id: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Cannot attach when an upper device already has a program, This
restriction is only for bond's slave devices or team port, and
should not be accidentally injured for devices like eth0 and vxlan0.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
Changelog:
v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
- Use "netif_is_lag_port" relace of "netif_is_bond_slave"
Details in here:
https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/

 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f66e61407883..49144e62172e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	}
 
 	/* don't allow if an upper device already has a program */
-	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
-		if (dev_xdp_prog_count(upper) > 0) {
-			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
-			return -EEXIST;
+	if (netif_is_lag_port(dev)) {
+		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
+			if (dev_xdp_prog_count(upper) > 0) {
+				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
+				return -EEXIST;
+			}
 		}
 	}
 
-- 
2.30.2


