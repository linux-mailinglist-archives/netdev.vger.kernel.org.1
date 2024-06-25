Return-Path: <netdev+bounces-106349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033BA915F37
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CCD1C22C6D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF2C145FEE;
	Tue, 25 Jun 2024 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2y77FA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894A146593
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298873; cv=none; b=PR3vaTbjKHZI3qoqLocwGklScRd+53JWdJcgfVm1x1Ar6KNERFvE6ki27qFJQ1sw2vo3N0TE+wVjrPDISDJhfMSUHvtN0JBLbffQ+YdytFJjKimOOoMOMtTIqSKgS7OUa7XDio6rzV0d6BFEkvslHKOG3GGHx5z/gaUU2d/Y8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298873; c=relaxed/simple;
	bh=pe+EdMJcKrRKcDduDb+Lb1e+v0jcDmBEJDFtfW0q3/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1sezUcRxK+D8RqQ88Brgo4f+BbkfRY7rhIBjGpM3gLVMX6WgR9JdnDsnEKg7xf/7IqhlmxdT5PJ+0qMGykZ6yZe3JnxCRmxr3mhUpbp8oOOxxk2lntP4l2uMlBXQJLPWHMdNQ9OPUVc2mL/iuIBE++MuX1WBV4CjUa2EIIwHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2y77FA5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706683e5249so2084993b3a.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719298871; x=1719903671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ93mRWYn1qF6Xrp9j0c9K1NAmfefo/xDrXsvMyKmVE=;
        b=B2y77FA5MkxvnH9tM75CcXd38UbzN7NJdPe+CB3ztXL5YXawI3Oz3z7X7rn7Itpg4w
         tVkzHU5SRmkTag6wdDlpzCjbdIkaNg3tU98jjgayj1jNApp8j/vZyTBjhzG272P93aj1
         n7hGLaaU8Ku+CjppVpdXnEAdgPnWpYHKkn8UTo52GlvYo4/AmbrK/ti0jhzY/ya2cnwA
         wiClnVOTG8RBA7OCoVd6Y9/HgE6e/N2BlwJ+xOY/fTsNzfW77bWW/orv+6AEk8RrBYbH
         +42goEg4lYchQFEc5sPuHvfGMhVrrKRSNUlZyCT3H8PrOTTfKgxDd5Z2GvZMaTPhDcJD
         mhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298871; x=1719903671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJ93mRWYn1qF6Xrp9j0c9K1NAmfefo/xDrXsvMyKmVE=;
        b=mdXCIQJPnPew7c+YARIo2VCgki7QufKJCwu6py/BHklYInx8K64JoCahs8/NFYW4nI
         uFccIlr7fcfi3ZueV3FN2labcBWY+AejIAED5Wj2U4muCwGUv8/sd7+k3bbZlLEKGUeG
         w5hKFKGvEaTY/q/906rM111ejoqIS8bQJiffk+x9JZ4QeN4iRPWNA9AHqZLM91gtXnJj
         XMzsmV6FfTFt6mmT6hzPw2e2NbFHzYCAiNPm7FYa+lPHjSizXKnPu6173Qqj/jx9XilV
         JnEIv50im7IkwkkqobMdq41LTcIaL8C6SIE/fWjQNa0uPX6oV7hS/xMVVlHwSlEjkYk2
         uxxA==
X-Gm-Message-State: AOJu0YzPI7LY2utyS7434l/Rq53ODEXDQAR9/5efrpY/ESTy9CAuEWPt
	PJ6/gtoN88QfMKb/V9nZj2ZssDSo9f6rMZkyet+6rxTYRtaKr5l8/+folWeCzZo=
X-Google-Smtp-Source: AGHT+IGnPIDMEM8T5arGLOBrP6MYIrDcOYgJIMSdElLYGBhFbSwhSYHxg2IA/MmiYqQpDFytk7Y5KQ==
X-Received: by 2002:a05:6a20:3d8a:b0:1bc:ec05:1d61 with SMTP id adf61e73a8af0-1bcf7e6bb69mr7478293637.1.1719298871007;
        Tue, 25 Jun 2024 00:01:11 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107ae7esm7308864b3a.42.2024.06.25.00.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:01:10 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next] bonding: 3ad: send ifinfo notify when mux state changed
Date: Tue, 25 Jun 2024 15:00:57 +0800
Message-ID: <20240625070057.2004129-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, administrators need to retrieve LACP mux state changes from
the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
this process, let's send the ifinfo notification whenever the mux state
changes. This will enable users to directly access and monitor this
information using the ip monitor command.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: don't use call_netdevice_notifiers as it will case sleeping in atomic
    context (Nikolay Aleksandrov)
---
 drivers/net/bonding/bond_3ad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..7a7224bf1894 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 		default:
 			break;
 		}
+
+		rtmsg_ifinfo(RTM_NEWLINK, port->slave->dev, 0, GFP_KERNEL, 0, NULL);
 	}
 }
 
-- 
2.45.0


