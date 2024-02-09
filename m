Return-Path: <netdev+bounces-70449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1984F021
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 07:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7241F22FAF
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 06:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C487F56B87;
	Fri,  9 Feb 2024 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTqUJyzL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632E657308
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707459147; cv=none; b=XP0+qDo/XNiyX90jZHxFkS8pEj5/SOnvlxCi+b8xhFbTO1lzXhhdZc6WWFZX3ZGVXOi6DH8ck3iT5hLK50gnvTHv9rITfkc40NrWdLybq69HlNIO1LIDv7bCtn4sUch5nDTYWVs52/7BDAEBglmg+wkp4Z8+7SnrX8qGr+X4wYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707459147; c=relaxed/simple;
	bh=ByPOuBXxZueNIY2WwJa12O35L+g4saZim753xv8FeyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPyAJgcdG2mDQj2LIzzk1k8kl4otdc1bXKdMX9BEBB96fO/a8X6PN7SKu64oBWRUvPt+QWIuOiiyAnezYqZEotDASD8UTqQYPRFxx2JfjP1TuoSq44veyCRDHyUmlisWje/Y4zXDBug3A0lXBrIctObguDSQ7qBJEmRff/vVMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTqUJyzL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7881b1843so5392475ad.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 22:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707459145; x=1708063945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MWvnrhKCarN9IchyY3TV/zfkt+BJdbLxKPHf4mNYsw=;
        b=JTqUJyzL+FRltPf6KTImRHLe+92XqNjDSXrhlhZroGLtrkfoM3oNGK2/RkDyLZ7VOG
         8BfChWgyRDSa/LZ09ibqo4CmtJ0x5gjc0XS6/bloDKXPk8oc9t9vnOgrtELLuaBFkyF+
         BvprdkPWJGLm44EeOkSBdakivNburBdNSM1DnHdE/bC9JCTFuWDoNVqMXMIm6BA7xLV3
         +KEAMzn/9f5yupymZwvK1MZAkne3fnI/GAP3JaZs+J3EyXk0NKUdD6lpy644TjFsd7/F
         ZNurHtX66dbPgRrlpTLllR159usR7oejGNj0tuQxj+9Akqe3d+cLsmCMq8lS0V0Kym2x
         FA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707459145; x=1708063945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MWvnrhKCarN9IchyY3TV/zfkt+BJdbLxKPHf4mNYsw=;
        b=lJicavvYR64qEOZrL+kY1xjz85KsfZeOVS0V1kt1jI21GGfeHSChqB6wxQfkDF5YBJ
         6rryPaXe1DnV52yUifobJ8Sgv1tg8J+aquAdiDfH1sPa+CIL1mnBxl7D1aaWex+zaPys
         1mVGnPzvgRaSfEAjR9Q8xUlOevlBw/1arn4xj2GBC03YGqy5zPWIKCm5tIcbbRwGVOr9
         B0PBjnVONHI+Aim5MMHTPD4uvGDLVkdJHvCS/qWMCW8nmgmRacK4nxF+XJwiM4pln98w
         eDAMkO17wGXlHxcxq+XXYn6PK4MdcL4wWd8Cgd+nTnCZPHRt0FQq/QcFMekrMuCzyrHP
         wSLA==
X-Gm-Message-State: AOJu0YxmxhyPyDf3VBvJtN6Vkzx+pvYcZ4LxQv3kijvCVOrIfv313pzL
	00oinDsmhHx2SpuL1bJ5mUe6mO87u8YHceJ1L+GpM7I/RBhb62R7
X-Google-Smtp-Source: AGHT+IG/bMl4v7GKbooQsWeCJwTBhPZkEdX+XW34XYdFTPQjA8Y5Flcy3khazb4sQWOLToZXRhT88g==
X-Received: by 2002:a17:902:cecb:b0:1d8:fb17:a1fe with SMTP id d11-20020a170902cecb00b001d8fb17a1femr732185plg.48.1707459144970;
        Thu, 08 Feb 2024 22:12:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWILrwhNUOrdjWMaARGUTy1zlfcfVbPE+zwIGTVHywxjqgnXZnzb6ve//9esga9mGC9Gp0MRya5T04aF+ZdkvQJ3o904QGkzG1U2/LoR1uIIJMz3pckow7AemtkigFnX7zheo4a18U1T79cMgWsdLfF0Ji3G0XyXdM+NHQ/1o5yhLIHMrQHYmxYSFMbKY0kXYAGIrpn/4LYadpMuV7Cli2QWkfRl895OmsRxFBTyQo=
Received: from KERNELXING-MB0.tencent.com ([14.108.141.58])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903320900b001d9620e9ac9sm746321plh.170.2024.02.08.22.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:12:24 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 net-next 0/2] add more drop reasons in tcp receive path
Date: Fri,  9 Feb 2024 14:12:11 +0800
Message-Id: <20240209061213.72152-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I was debugging the reason about why the skb should be dropped in
syn cookie mode, I found out that this NOT_SPECIFIED reason is too
general. Thus I decided to refine it.

v2:
Link: https://lore.kernel.org/all/20240204104601.55760-1-kerneljasonxing@gmail.com/
1. change the title of 2/2 patch.
2. fix some warnings checkpatch tool showed before.
3. use return value instead of adding more parameters suggested by Eric.

Jason Xing (2):
  tcp: add more DROP REASONs in cookie check
  tcp: add more DROP REASONs in receive process

 include/net/dropreason-core.h | 23 ++++++++++++++++++++++-
 include/net/tcp.h             |  4 ++--
 net/ipv4/syncookies.c         | 20 ++++++++++++++++----
 net/ipv4/tcp_input.c          | 26 +++++++++++++++++---------
 net/ipv4/tcp_ipv4.c           | 21 +++++++++++++--------
 net/ipv4/tcp_minisocks.c      | 10 +++++-----
 net/ipv6/tcp_ipv6.c           | 19 ++++++++++++-------
 7 files changed, 87 insertions(+), 36 deletions(-)

-- 
2.37.3


