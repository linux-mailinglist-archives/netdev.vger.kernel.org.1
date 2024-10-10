Return-Path: <netdev+bounces-134046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC40997B8F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918321F2358E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514401922D5;
	Thu, 10 Oct 2024 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6N+e03g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756D186E52;
	Thu, 10 Oct 2024 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532845; cv=none; b=SwpV/c737V2Attr+hkfgVAoHuSl8AHbawQrThrseSjXH0L4x8/IWMUkogLrit466ZtHFv4Ty2wnp/AacmzkmGTIlqJWDeTDBenTqCRVgD/TuODBTPmy8JmfKtDnlQuAQfp6KdL2gI/duU1Udju7glbqxO6ygLmiOoOlHLl5DSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532845; c=relaxed/simple;
	bh=GNmg73xzOhDPF3I3voqIRjRHZ1q41hOCsdWOfWi3zok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocQ5OZv3kjKw5YFA1YCu21VIimKMmRpniT00rgJ//rqf8clxOsl47XQRtRcOmLieO9QsUXB4WhH8/WHTUNDTPfrlDqI80kf8QkWcbqmw51mzTXYT8Pqssd+Xzj+FjMHDIh6qAW3WKn+L3Hc6xE2pe7F1oF9r1VF5lTuzz6PuLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6N+e03g; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71df7632055so477472b3a.3;
        Wed, 09 Oct 2024 21:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728532843; x=1729137643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ty2O0j0kJtmkpbNPVw5qS95uhV4fBvKFxgpGrhlziSg=;
        b=G6N+e03g3/sKpExQyWkkZl71VpCVIMYP+FaaDvG8esGwbJLOldDKamIFgqb7YH1YV7
         7oVvRXbKWTMT4SBK3/GgAcKJTYn/2F0QbsZk/pqVjl38qHShYbYHPqtZkufSACcjSLYk
         a622335B91kDY5b/FelPLhd/N2dK8E+V7+b4fL6TUryWe6R4YJ/WdJYOnExIDbmkNCQ+
         tMX9t9m/QZVWcNgWyo8Q1/vkRVShvUUgfEEIwrpVLfu+rPCfXr4TltbenvktiSzKstXZ
         hZWx+m1mRIQb8tGxcwewlODviyaQkw1M6xOe3TggetNZMuM8IGjWVVYpWCLBj/MDse8C
         g1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728532843; x=1729137643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ty2O0j0kJtmkpbNPVw5qS95uhV4fBvKFxgpGrhlziSg=;
        b=mVuAtHmQ2w49xgLlyXr1CG1V1fCr65D9ywfoB1B4sHfbp9zo/PlW+jF29LV38reECl
         I+8us4ILPdKgTBcQ9ZybLvZ0zLh2WFr+4nD54kUSpe6OzkYArRjLJm1rjHThw6CljGev
         RB054/ty79nxwDcp+fQNvyTyMrIT0HvZkoB0b5ZifhB99WRqbV7KdZ1WdocU0upsu/Oi
         WQXE39AYD7gS2EdoQfWtu52t7yMghfv30urhJnuVHlvwRzsnC9mzT00oHtw5Uym+HaJM
         hKc37fRkxilNcC82ii1CTPyb3QCY23vSXganO14WB3XMu0yXwhjVKySUoiAR/FqSgm/1
         Fldw==
X-Forwarded-Encrypted: i=1; AJvYcCVnpDABemd9SbAtcEoiNdVdY/D0WqI2oFLQ9c8PVUttr/n/+pNz4RARdNbXR6mPDvfFB9U7L+e9rJp1lkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfR2fT2EfuiUlndzLR9WrfiGIysRT1ibJ3BWNjBtHSbN12yGoN
	q+BslbcRVkuRshzF6B4AEbUo+ZiDcggAXH4NiHX8rolBhz3V9Iw5c34WWVYvunk=
X-Google-Smtp-Source: AGHT+IF39t12870pCy218L4olnrgp5N6mtx4x58eXP4vXkjAmRoh0EKmDHQ9Scz2+mlW3IBLEmmqQw==
X-Received: by 2002:aa7:8881:0:b0:71e:659:f2dd with SMTP id d2e1a72fcca58-71e1dbc05d7mr7542981b3a.20.1728532842960;
        Wed, 09 Oct 2024 21:00:42 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5dfsm187638b3a.199.2024.10.09.21.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:00:42 -0700 (PDT)
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
Subject: [PATCHv2 net-next 0/3] netdevsim: better ipsec output format
Date: Thu, 10 Oct 2024 04:00:24 +0000
Message-ID: <20241010040027.21440-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first 2 patches improve the netdevsim ipsec debug output with better
format. The 3rd patch update the selftests.

v2: update rtnetlink selftest with new output format (Stanislav Fomichev, Jakub Kicinski)

Hangbin Liu (3):
  netdevsim: print human readable IP address
  netdevsim: copy addresses for both in and out paths
  selftests: rtnetlink: update netdevsim ipsec output format

 drivers/net/netdevsim/ipsec.c            | 23 +++++++++++++----------
 tools/testing/selftests/net/rtnetlink.sh |  4 ++--
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.39.5 (Apple Git-154)


