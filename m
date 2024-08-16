Return-Path: <netdev+bounces-119096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0F954027
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394B21C22276
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8B4AEEA;
	Fri, 16 Aug 2024 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="looT5yod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283BA36C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 03:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780529; cv=none; b=SKHVGwSQrVwSad+ngBna5I6c/2f2gGA1isjNFQRhYceTsjFtAZq+JL9Di79iMFUYzwWUYaxswOqLiSXQoX7qfN5dRWp6c4FFbiBXTs65qy+tVww6Hzwkktt+iqxESCUyfTnRcINtYHXQyz2TiMTt10xQNSFNaG6I39f639SJLcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780529; c=relaxed/simple;
	bh=szrXFqsQZ4jYesZrXzrq4nDwiReAyy6DLv4L6lNnrzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzWtIo/Gw9SPPYkaxdAbzEiQhz1C/JLqBFYG2Up/v5yt9mZYe3Pf5Ibj9S5CGvTB1URiXdriAUnLmhmmWEjhk7u9RlPOi+IgMYRmXb/m1TdBlelAbBlKXquC9b+OA7zp+ZlpHaLjjlfuc2VNIGpH8PrBKwsKY5XG+pTS5i/BuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=looT5yod; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-201ee6b084bso13448385ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723780527; x=1724385327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsBHfxdmsreRVs2bC3ap8Oa7XFhunafujFDVTPaTiTE=;
        b=looT5yod5sdXgf6lkNM8e4svEHG7wHCm8TytDq/3qkyxR778m8xAi6B94tLTqOibF8
         he8TqJnar1GHpbw6hUbL9IvE8RysxcffkOuaUwLhWIIULgdcKKDDMnLwgSaeMp2PYIlY
         e/ZFxaxO6yzehCwnOnYPUeQWcmqB26K8Blz1OvLyUR8PI+cEt8p4qr6oT1p1DrWbsaYg
         +JIlD+kNKgMNVRx1ehoJz6xknDelwnEA3Ner2cr0B0weHO5HtK8uia4pJS2VTMvWGLAF
         76hRZUXohbst0UppwBLRsj9M9woRpEtaAvzYRBeY5UWNKsy42xO0raNnXmaXSiQaxk2V
         BDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723780527; x=1724385327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsBHfxdmsreRVs2bC3ap8Oa7XFhunafujFDVTPaTiTE=;
        b=d37STjTkYQ9f9hrG8IbrqGDXenW4vtpsW1TiyBWc+e+B5p1hSw+V7ZDHUv3IFx8wCe
         xg8ix7eCTQSfeDw0p/pYtQy02GF7FwLd9Uf0p7evc3akJ7x/5tS0Rl78OFafLF5pDmi4
         XXLVrkwrVYD6my3EfR6+YEzRCOHSZn9dZku9bDHVsB/D29NXKna43/k0S+bd1Yg4yNIl
         RS4R2WJ4VLQy4nDKX8mUic37yPp8ScW2Mj7omRKUQqcxRmvO8JFXSd4jVtM9e7cc2hAW
         DaPflATBZLRWtKAGz32FH+OMGNJ9UPiI9TuvYT6MSvGJTQ5vmU6TTIMI1hjiAcDiD1OR
         Lpsg==
X-Gm-Message-State: AOJu0YwBaR4bL/BZ109CdXq5frCKLR2jn1IeOEg0rZtUsiKw3LwOsWLK
	VKSPu2Ft8m8KzBGdwVMCFcJexN2Q5N1GNfIQdsYsq5MG2YtWU4mjeXS0VtBFvpI=
X-Google-Smtp-Source: AGHT+IE1z2f0sK2Kg3o4TPEY5sy813ZbwZQHzTDB40ZuWbUxAdtIzoDOkkhA2c0BxJCW3vaj0PnJ0w==
X-Received: by 2002:a17:903:48e:b0:201:fcc1:492a with SMTP id d9443c01a7336-20203e8fa1emr17013615ad.18.1723780527161;
        Thu, 15 Aug 2024 20:55:27 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037563dsm17112105ad.131.2024.08.15.20.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:55:26 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/2] Bonding: support new xfrm state offload functions
Date: Fri, 16 Aug 2024 11:55:16 +0800
Message-ID: <20240816035518.203704-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I planned to add the new XFRM state offload functions after Jianbo's
patchset [1], but it seems that may take some time. Therefore, I am
posting these two patches to net-next now, as our users are waiting for
this functionality. If Jianbo's patch is applied first, I can update these
patches accordingly.

[1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com

Hangbin Liu (2):
  bonding: Add ESN support to IPSec HW offload
  bonding: support xfrm state update

 drivers/net/bonding/bond_main.c | 76 +++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

-- 
2.45.0


