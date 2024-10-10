Return-Path: <netdev+bounces-134047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40CC997B91
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACF91F23065
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA354198A1B;
	Thu, 10 Oct 2024 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2RMtudG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856C186E52;
	Thu, 10 Oct 2024 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532849; cv=none; b=uF/JLjy3SgzXSFRVcef/1Hw6HIvis6Ke0STNO30tsh5Gc6EWXn4uE+297Y5rYtpAr2nR7PmvjeIMS6gPlrvcwM3GqOtdqi3ErsJQxtrZXPfO+A/+1ZkgkY+bRhd7QXkAcvI5X8CBZLiSOC96ekPxNrcJwtFBTHXDXbssvrd/ZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532849; c=relaxed/simple;
	bh=bMiKiivS6Hwq0GnIZyU6rmvR5xet7idTh0v0HxIRiZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW+JJEWwLyhlxtDA1s8oXtfdXwx1zEPqU5fbtRbEteP4XEMuBviqM8+5JV0E87u4H6KVpwPjT1dOZrjdgECWdOuT4y/CC7Bz3XjbOLyjWTntZngBZl778uielab86GzLDGCC/u7M6bRS3P6pJSP8dl9Y9k0DJCrOIgr/RfkD8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2RMtudG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e1a715c72so397911b3a.1;
        Wed, 09 Oct 2024 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728532847; x=1729137647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXUQxyqRIc3HsDOFZodLKypqEMMMkzcDuxRdse3iogo=;
        b=A2RMtudGawvpVyQ1mIHRviRLxPI0LZQoNGkbC/v7Ced7NQBumH2TnhN7aLqX3FYgt3
         ryWHwlhdkVsk+myLQ8Z8aO+MX6liVRdEQRjNnleOZJJjz7ndHkEPq6abc8wya43cE5cr
         tB+KMi9alVhshI0iFxpNPZrnjoi+xsICZjv0/hBaQpGMC8nNUsCpaPPKvlhXBT81WxtO
         mnsTg20zsFKwuJnRVpMqtWZZv2FRn3zEVNwSW9Jp1hnOjv8kaRqJifrKKZi/6s0MF0xk
         0CDzXYgmQTemBZXMzkdHje/8BAK+Fpi8FYW16ouQ2YZVrAx2/pcNP3WzDtLTmwcR6m6R
         spDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728532847; x=1729137647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXUQxyqRIc3HsDOFZodLKypqEMMMkzcDuxRdse3iogo=;
        b=nFOtvEYvWV+w5dF4JVY2MoxzAEUeh0YMLdCMtYRmMLmpXls4hm2iBLDJVvzOT4Hzmr
         n5Ty0autY1cycO5C4/CHuMHyjFUFIxGzb+QHwGRIUpk0k05AuBPnUAgYk+Fh8zTjsALb
         dMCsmUfeUMiXkCLm4BPJQETYAQGTRDH2J6oOSgQwLIQ7dXy/jWs2OukD8rxODs+lBWcH
         xj/drJHeq+qIGOYDO7Fv4+PMQURvwICCzUNW/Novrub5c/6aPINBONpG18pM7i2SkJ4c
         thY3SfH5axVaU9Qa5kLUWhzqccMoGPmEo0s8wuqm6DsZPF/16dYImY2/YPtrb9mMCcne
         MvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWJqfQQo5u9SqJ7snGOPBUtu8RTu/KR4TkivTFo0GgWx5oanNBJAGJLTFfHxbpywV3nb2v2jVMuuX/KeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQOWIJRGNpqK0jjUhsWecpWRw0OKmzz74VEfznJHwj8W6M4X9
	ek4MEP1PqjtFFp+0o87GpcqMKr9WJT/dnNQS8bDEpaobqQjB9bhUbxlPZeRVl/I=
X-Google-Smtp-Source: AGHT+IFzm4OFZjqxL0RAiIv9HM898L7vC4IxecD9LWuzhi9tjGPCcMSzNGtJ7AGnbqSplIGtH8d6dw==
X-Received: by 2002:a05:6a00:4f91:b0:71e:c0c:598a with SMTP id d2e1a72fcca58-71e267f5216mr3748080b3a.22.1728532847426;
        Wed, 09 Oct 2024 21:00:47 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5dfsm187638b3a.199.2024.10.09.21.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:00:47 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/3] netdevsim: print human readable IP address
Date: Thu, 10 Oct 2024 04:00:25 +0000
Message-ID: <20241010040027.21440-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010040027.21440-1-liuhangbin@gmail.com>
References: <20241010040027.21440-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, IPSec addresses are printed in hexadecimal format, which is
not user-friendly. e.g.

  # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
  SA count=2 tx=20
  sa[0] rx ipaddr=0x00000000 00000000 00000000 0100a8c0
  sa[0]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
  sa[1] tx ipaddr=0x00000000 00000000 00000000 00000000
  sa[1]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627

This patch updates the code to print the IPSec address in a human-readable
format for easier debug. e.g.

 # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
 SA count=4 tx=40
 sa[0] tx ipaddr=0.0.0.0
 sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
 sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[1] rx ipaddr=192.168.0.1
 sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
 sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[2] tx ipaddr=::
 sa[2]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
 sa[2]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[3] rx ipaddr=2000::1
 sa[3]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
 sa[3]    key=0x3167608a ca4f1397 43565909 941fa627

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/netdevsim/ipsec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index f0d58092e7e9..102b0955eb04 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -39,10 +39,14 @@ static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
 		if (!sap->used)
 			continue;
 
-		p += scnprintf(p, bufsize - (p - buf),
-			       "sa[%i] %cx ipaddr=0x%08x %08x %08x %08x\n",
-			       i, (sap->rx ? 'r' : 't'), sap->ipaddr[0],
-			       sap->ipaddr[1], sap->ipaddr[2], sap->ipaddr[3]);
+		if (sap->xs->props.family == AF_INET6)
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI6c\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr);
+		else
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI4\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr[3]);
 		p += scnprintf(p, bufsize - (p - buf),
 			       "sa[%i]    spi=0x%08x proto=0x%x salt=0x%08x crypt=%d\n",
 			       i, be32_to_cpu(sap->xs->id.spi),
-- 
2.39.5 (Apple Git-154)


