Return-Path: <netdev+bounces-94921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A408C103A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C31DB2217D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3696152515;
	Thu,  9 May 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao329jWg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFA13C3FA
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260709; cv=none; b=KD1UjYTOGSUt60wC2SDkiZuFlzRmx/qGnYbc21RPWYgtUiBbNLvZHLd4SSr25W2YmcOUCU641zCzdft0LBj8RgQfQke0nz9yNuiB03Jl1vSGeUo634t+xU0sPPiJo/lZEPFR4aMxx71hgE4N9YJfBE+Xg348OfVOzSDQ6y7zWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260709; c=relaxed/simple;
	bh=5feDGkiU/3i5zN8oS+GOrNhHq7cx1e62yGxTUJGMiO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9oyh7ZM293s7gSPc/oxYCT9aGn52nMSoZLQk6QcpcNefrorMPuvS7kVfpxxdn31Fe42zuARP8d/+Bj3rmEtay94RefYL6nH4bG+FkJHBKooyxYsp2aZhkIXy7fmkStV5QoVxQgHBmvxB23qDkC9ia91PWhAZZgWT9vFWKiwRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao329jWg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so7076645ad.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260707; x=1715865507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odFMXhOSiwBrRhHoFio5lg8/er68i0/QmBc+lCR5Hek=;
        b=Ao329jWg+UxoV4Pe03JUT4kYiS9PJB1mH6DKA1ldMXaS0AGp005VAZUgVkO7F4dZCL
         IIFMyKKx/Eh9QE2ZV1u9SuLqE6ghCDL3NI/giKc373I9a22mT91V/yG2cDRRJqMk0aS2
         AuW5H5Kg1WiZThdIpbEES24VJyqp0JjWpFjFhqP52aUu13kVRdkY/JUi0VyH/WoGtqYW
         AnBhZGg/icHN8vxZvRpqS26Cvwy7EExskcQXYZmJdswaA5izzdejEXb00JIxZqUP25ma
         NQXIJVa9/k7m7HmptVPi6WeriIjdqCc1jyv25OruigkUtRz+wzcVsBVCyYrGgFgGMwIb
         cZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260707; x=1715865507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odFMXhOSiwBrRhHoFio5lg8/er68i0/QmBc+lCR5Hek=;
        b=wVEW5PUw8PFxBDuNvUh66+A6S7tgTLyBcjQxzepwH3imCx5BmKOM2mKxtu/uSeY9oe
         U6+f5TeLhRTFc02niFOGpXoqRwSN7TxqjvUNJbyWb3OVCseW2ee5GjWCGB9Pk3rJe+8t
         uIYZjYZP4o7JOEVq/5EvAqbhaaSLol/NqFniDlm5P/QXehs8xI5yB8rCVd39C1UFoHHz
         +ShhU9Q0fDQu8pupfOPRGFqg0zzz2c3BF6OSspUnWDfpsDpAbqg6v+i42qVPKbTwybYp
         AkJzHm8sm8pqRWdTVEWT5lSQROiiUVbkpJpGrgyZK0RUY+A4wHpzpZ6KhBkbVvpi3Hdt
         lL/Q==
X-Gm-Message-State: AOJu0Yz9d2KCAgDYBELWkiyJQfyKfWcJq2e4k4KoE4twebuiy6ggiQhf
	eIs1UsiGCpR1PuGAjkvNvQnB6GvfEkccxdUGqp2MCGcPtcmjGF2lfElYpC50U/o=
X-Google-Smtp-Source: AGHT+IFcblZ47upTgTyIm+HfQEPlZ0PQ1DOKcZhP5gzBQVqoBtBo5w0htQJLVf4xGOEEcehej8eO4w==
X-Received: by 2002:a17:902:d50d:b0:1ec:8607:5f11 with SMTP id d9443c01a7336-1eeb01838admr78227605ad.14.1715260707428;
        Thu, 09 May 2024 06:18:27 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada3d8sm13989055ad.99.2024.05.09.06.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:18:27 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 0/3] ipv6: sr: fix errors during unregister
Date: Thu,  9 May 2024 21:18:09 +0800
Message-ID: <20240509131812.1662197-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some errors in seg6 unregister path, like missing unregister functions,
incorrect unregister order, etc.

v3:
1) fix unreachable code when CONFIG_IPV6_SEG6_LWTUNNEL=n and
   CONFIG_IPV6_SEG6_HMAC=n (Sabrina Dubroca)
2) separate the patch into 3 small patches since they fix different
   commits (Simon Horman)

v2: define CONFIG_IPV6_SEG6_LWTUNNEL for label out_unregister_genl (Sabrina Dubroca)

Hangbin Liu (3):
  ipv6: sr: add missing seg6_local_exit
  ipv6: sr: fix incorrect unregister order
  ipv6: sr: fix invalid unregister error path

 net/ipv6/seg6.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.43.0


