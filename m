Return-Path: <netdev+bounces-114978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3915944D67
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F94A282CAC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F824194AE6;
	Thu,  1 Aug 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeNigTw8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EDA1A0711;
	Thu,  1 Aug 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520061; cv=none; b=F7Oga23v3Bf/7G4nM/1U36QaQcHXnChmAWG805zjZZZzOhczGxlbekDEFkQDa8Xvhsrkh+2CyGcOIJmUKPhFtZ3ZPbOqnfONXeDEsUCZAMvS4+0Rxdl1BhjVwh1TjVAsl7HTIbr2xbgjq4lVWJDc1CrJFltLQOVF3fPCcSzrpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520061; c=relaxed/simple;
	bh=vjGy2uwfzEZ97a+3aof+3SKng4NXWemh1/vsxGXJlzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GM2XMW37S6gswVLdwK8jilMvLjGrioKJkTYs/hfEobmOwa/UtJiy1yjIaeqPpq4J+M48M1fv7m3TJztmyfGz9mzCxPKqSFpMaY4kzKLyC+X9oVeHQthoKBEoKvLbC4rS/V7iDb1SiQXnfGfrcVmXHCERjZ3EIKcYvp5J1ZQDSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeNigTw8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fec34f94abso54591965ad.2;
        Thu, 01 Aug 2024 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722520059; x=1723124859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6oyUrXiQ5KRnBrLzW15m3SL4jVMTbgLQ6TAxlm3G9Hc=;
        b=jeNigTw8W2C/hBosgxV7JWLMspnKat8okY3ZseaD/QyxTTXuyrX7JmIBT3PjIbPsES
         4AnANsgIbA5+mXk7i6f+chQKUlBwAUYPkQq1jb/SEx0LUF5ho7D53GE3STVP1WRIwSNN
         lPB8jElp9EHNZe0j9viD5m9FihDrva3JeO9rghTrfSDKv4I8+8t7VZm8bzmEzFVT6MV+
         mzqPpSdCj0TxgIscQu71LhvmTjwU5/hwX5ca8xBXpaO6H9p+v7ronqkOZTynEAW5Shmq
         iCx+UoXif/a09IeKhyagN2jC09IWW/GvljX+XJaojQw7zrvdwBIKIaKZLvoeTpJhelyv
         DJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520059; x=1723124859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oyUrXiQ5KRnBrLzW15m3SL4jVMTbgLQ6TAxlm3G9Hc=;
        b=mtGZb2bX/Aah1I2+snErGpcLB1kLhR5tBhgUpDog+VtJiw7BD80hqRC6Bvy0dyXP6h
         RCpm0Byeo99tYFnWjQlZrmHQBTFzx+LQAVJeo49qYYyvaXdArkHNBBSu3Zjw/FK+HzgH
         BCdfUu62Tmb0fipqcpmQlc1jYG7Eo3MHDRT2C/ujcWidrKNoZGmWJZWsBUucHIquYfGR
         LuFlC+bRfH9czFwcJfVyCMy/hfE3VTYvHy1mX/7gZ61ZcWtkfd/CT0Ev4Ynnj4DLJqvt
         c5etlrjoCRXGeBGQ8KYpDrszolZMgYZKZ7CeicnDgz9+8IZZ9Xd16vApJmEPEHxaRZgf
         QQGg==
X-Forwarded-Encrypted: i=1; AJvYcCV90A+Dl5og9QXPFtjFjmgxAQwj8xUuoWRw3QpeTIOPVqpfLU02kpZ2ajIDeMc0HESqcZa3IXfwoqvYgToQG8htnBJivpzFGIUePk8p
X-Gm-Message-State: AOJu0YzIbGf2vJzNc3Ms5gUsjLIeHJ50GReDja4LSWOEdFAr3NW3WIfC
	UhOTetpzhfoiO8a8Pf9Eq5us8f+FCLTk4QWvBiG0v/ZhzH8+Ndg/
X-Google-Smtp-Source: AGHT+IFfeAhrEmDM6jOnfL5ofrZr5WaVDCLtKFEqLNQlj0uawfZtGGNywhT+ed6VYVqPvDXKX6TqSQ==
X-Received: by 2002:a17:90a:8d18:b0:2c9:6278:27c9 with SMTP id 98e67ed59e1d1-2cff95405a9mr245888a91.38.1722520059292;
        Thu, 01 Aug 2024 06:47:39 -0700 (PDT)
Received: from mythos-cloud.. ([211.46.174.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4aa0c2sm3302534a91.46.2024.08.01.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:47:38 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH] e1000e: use ip_hdrlen() instead of bit shift
Date: Thu,  1 Aug 2024 22:47:10 +0900
Message-ID: <20240801134709.1737190-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no reason to use bit shift to find the UDP header.
It's not intuitive and it reinvents well-defined functions.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 360ee26557f7..07c4cf84bdf3 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5731,7 +5731,7 @@ static int e1000_transfer_dhcp_info(struct e1000_adapter *adapter,
 		if (ip->protocol != IPPROTO_UDP)
 			return 0;
 
-		udp = (struct udphdr *)((u8 *)ip + (ip->ihl << 2));
+		udp = (struct udphdr *)((u8 *)ip + ip_hdrlen(skb));
 		if (ntohs(udp->dest) != 67)
 			return 0;
 
-- 
2.45.2


