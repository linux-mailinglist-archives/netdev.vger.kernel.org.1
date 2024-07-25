Return-Path: <netdev+bounces-113042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA50993C780
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62A61C21CC8
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABC626286;
	Thu, 25 Jul 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy+bU9Lq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AF19AD8B
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927038; cv=none; b=ZMuBvbx/SKSa6G54d8KWYAP/cpp1rx354NRAH7nb8RxOaOGplmmUgITQftUV+IrWt3Tjl6IZ91NggiNE+sAO1mHkXycEeskDaVxMmTsFZA1PbiILjgrjwvKTnBvi0sGRwG42Te0iKPESDP4rh76n+dlSolkKZpqsU5g4r1iaAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927038; c=relaxed/simple;
	bh=P+A1SYorTb2M7rrppfbFGD7w6JK0vXLklFOZAxwENhc=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=su8A6bSl5d3/OGBXpqpxvupOXCX3TU2vV/+JBbmBpuFdDG5Taf8n3csRWUeh0R4zLPSqS6b1sUtnalE6vIL6PE1FNIcg55Pe+QdcfSh46Y3Yjw67CE8RlLxwigGDI9mjTc7RXlmUgdIb/oEJJWtlDSyKkC9hfYPVvAub9C19VbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy+bU9Lq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d333d5890so80441b3a.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721927036; x=1722531836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=dnF9AFn2rKNI/84aos11pq3QkaUgboWd1fJf1nfTwec=;
        b=cy+bU9Lq0bZmMrfkmaqgp+cRm3BB8Hp1ETzOzbtzAOcST9PxYn7e4+OPZ1nAljYEBK
         KNSfHD7u8Vg7OSvVdZM+RUpSr+cNjTwZcMZOn+hcLkGknmFykrPb1CsgdscTHyFs7TYu
         5UzAqbHHb+UcXI2LpFdV/WegJ8ivOHTMU0Xxl6SermeuvP33k+nN0ETjBxdDFPnRuDbx
         RcxYWDxq2KmTslLbaSwxaYwQ/uHK1M/NlT5QAy/zZX7keo3gAOHw5rh3CmTBj5cP8Pco
         Va7MTEbJV1Ps6bTz7s/FWjQ1kvmw3TdZ0kTmIT2PSNc7EKkWq/fUJhZKmaezY2yGYLzj
         3Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721927036; x=1722531836;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnF9AFn2rKNI/84aos11pq3QkaUgboWd1fJf1nfTwec=;
        b=Jb/KsjZGHOuSBYjCPJBjklPuhu9F6ncNYgM5MYiYKmjd6EGPQxj9AwuSddFdsJG07e
         5HrbU5VeLdgW3b5fZm6eyAZls5NHVQu1TpzUwkx5Xzlny1GodAcXGRpTVPiQMdGUbVk2
         rmL8gA0j6/3f8R9OSBWzDtTgL3r0z8JlTUqBfKBXNy/U7okBDkt89Qr+77VdRWQ6xCDv
         786QZkE654Bitj43hIhZ60ucUhoz8YmVdGHcxOWZ3EIJ5IcvmGg0642XOYxeXUZF+0MX
         kAfYNwgoP2zN9RLiAlshxlhatltHotG5qsyVWr5Rkl3m0l9dghmJ2AESbWOnUZ4qEYs9
         2X9A==
X-Gm-Message-State: AOJu0YxugSP/6bZX3t2mn9zOGkuORiiMx7FLRqbW94Nd5aoGJs7miyuX
	8uox83rhvyKeU8/ss6V6/OZcTyJmDEoNL3ASOzns8JDsn3H+tyiPbLsGyA==
X-Google-Smtp-Source: AGHT+IF3/iJQlknnxWRkyOoka+FQ58f4CM37fGkLcCoX+P/7pXV+HSMJfepNZGStahjGvhNOF3NFMA==
X-Received: by 2002:a05:6a00:194a:b0:70d:3a45:5b48 with SMTP id d2e1a72fcca58-70eae8ec630mr2844803b3a.12.1721927035520;
        Thu, 25 Jul 2024 10:03:55 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8146aesm1342157b3a.131.2024.07.25.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:03:55 -0700 (PDT)
Subject: [net PATCH] fbnic: Change kconfig prompt from S390=n to !S390
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 kernel-team@meta.com
Date: Thu, 25 Jul 2024 10:03:54 -0700
Message-ID: 
 <172192698293.1903337.4255690118685300353.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

In testing the recent kernel I found that the fbnic driver couldn't be
enabled on x86_64 builds. A bit of digging showed that the fbnic driver was
the only one to check for S390 to be n, all others had checked for !S390.
Since it is a boolean and not a tristate I am not sure it will be N. So
just update it to use the !S390 flag.

A quick check via "make menuconfig" verified that after making this change
there was an option to select the fbnic driver.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index 86034ea4ba5b..c002ede36402 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -20,7 +20,7 @@ if NET_VENDOR_META
 config FBNIC
 	tristate "Meta Platforms Host Network Interface"
 	depends on X86_64 || COMPILE_TEST
-	depends on S390=n
+	depends on !S390
 	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
 	select PHYLINK



