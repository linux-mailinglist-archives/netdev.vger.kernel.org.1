Return-Path: <netdev+bounces-234608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3AEC242C6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 10:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6000C1A20701
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD130C373;
	Fri, 31 Oct 2025 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl+tl0vc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83703594A
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903161; cv=none; b=G0vnzxov+X4DGlFB40W+CMj8uSRmN1Fe9WEAG0qNXzOI1VfEJhtlMBu08b0roskXkDldYhhSa4xno8PtOBXeQ8kf07RXmFXDkhbnBeRb9JgLfAryOzHoVLG3cGT2/YeQ6QrgoETvnZsRmFTeXJLiSbTFG/6r2kW6gIehHGoYMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903161; c=relaxed/simple;
	bh=JPL8bNWBu8JF3otRbTb5NJ4kkNoT8fXU5KSDjVm1TrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YYVd6Is5Lbxv5NlrAgmisukU6/gjWpSehCeBzUOXc0fle1jc5rczFMes/xwAAqXx+BqR7vfWjRF33tHFDQEeygdUp1kWKXSycrr2lSiwj4482gJCsV/87TZE7anbC7ThqevT82AAdDJ7Ybq4L4vA5x/tA8551WmuGm32dY/naC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl+tl0vc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso2003153a91.3
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761903159; x=1762507959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whk1InAlqfQPVCGZSR6YzmDfdpU0Fuun946RqKKw1l8=;
        b=Kl+tl0vcPdr+38CaDWN6R7NCryBCPg3apUPeTSOdN9VQHNbyaF2TZZl9ryD5vXHlNe
         xrsCDh3eRNhYZEaoFrefYRomPYHQlvRZbIOHK/e7J0Vy7CVbVPXdEemUm1IxgqT7bP8v
         /Dm/Si72zQ9zLFfB4mgkoZqZD5FFGvvud4v1ZRhMK/921RPWgFNEWxDYSREMB2IGs+G6
         bcIr0qJVyNWAnaJLF3EamLI5wyerBfz7pY7911Zt2ClXZdaKHk7hoTYVTqZv253uqXp1
         6Po+ojHuUPn4c5ZIIYq/WYRraj03lzkiHq8muWRu5JM6kGarSGu2NPIN6Lu8V9Q/HqfO
         TauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903159; x=1762507959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whk1InAlqfQPVCGZSR6YzmDfdpU0Fuun946RqKKw1l8=;
        b=dgOx56XsQsFExH0YLyCihBAWK3OXJvF0kzBthR0oX4Xsa36NC8rsVWWnGa7TW4JuHp
         ZatnN+mB3Tew3HerMKZ7uUmsLGuKrj9BrxtIgQp8+DmHDkQ2T28X44dnvEYr9DimKu1h
         kAemcBVk4IVaGf2W8xO1/7vzGFfAoT2MjInpb0CUigINcqojj7IaNoxiGsSlpKVdHOjj
         3SeQOejLzoxWCrLo6ucpdI6itsmYvu+3Zxa50YoESsfod0/+JqqXZu/yj7axZKkv8lin
         MNgvKelc9iVpvhHxHITLBMWxZlneRz4JGON3sYDZjqfWYs358Li90SwG8sdNML5YTiI0
         HyQg==
X-Forwarded-Encrypted: i=1; AJvYcCXZaAHb5uHT/PfQokOwnqodpoGHhoFkluPkVKxJ+2JxLHOQOjhqv/TyNHmZbD0WpMSRNlkCQPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ycGigHnKtBI7NmcW5ld/q8YCgWm9ZrYcHF/DObnzLI4WhjpM
	75JwG1a2elVQXqAgsAUxrxA5BslV2ODFGi5dX+2BiXiimSjleXvon5EU
X-Gm-Gg: ASbGncvYtnPfUbrxyapQgyAROrioUjZ7UaUfQusIYwlYN6mHFpXaqYV7U73iBeVabmO
	w4cTD37oDn41RnfVQ/vBFJkzzluQfpMxIsCjaBnpMoAT1Hu6unJ65MaWsByQzCX160WfHcwUMpF
	uvbDsyeXxze+lh386VA8bVHjlLIuGIbbBNtP9diNiLg9dOpMVoojgE+u4TO/rUqAMVWUyXgknsy
	syTHHEgZXbXWxyflGa5MkKD6PgNDfdCr/LKKL/gy9yFZD1EjuPwn6iBBhHaT6Atr8wUzD4e9aNY
	fCHHJb1Wu/xGsmpv2skvQbgSjBVV+eGzBAimFrItRc5LPzAlQ+23PkeZTuhYowV4bo/n6rNpD53
	MCOmenmE2PXxahQSjswHD15y69hnJDEMfxfuTfxe2lTwUUmVjPDKTownLEb6PO5XWqY/+R6WvWF
	pMN9OqMq90998cH+lMmquUDuWfqgju/DNdQ1od5rK8E+c9deAmw3MVPyY+Ww==
X-Google-Smtp-Source: AGHT+IHuJGiGo1d2Pvz4LzhYoENLfISrKmtif+DJjaBZqYyO/scS5TyYiaoKyODvbKcX+7lDqR8Jpw==
X-Received: by 2002:a17:90b:17c2:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-34082fdaa04mr3557013a91.13.1761903159020;
        Fri, 31 Oct 2025 02:32:39 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm1544422b3a.60.2025.10.31.02.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:32:38 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com,
	fmancera@suse.de,
	csmate@nop.hu
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next 0/2] xsk: fix immature cq descriptor production (II)
Date: Fri, 31 Oct 2025 17:32:28 +0800
Message-Id: <20251031093230.82386-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series was made based on the previous work[1] to fix the issue
without causing too much performance impact.

[1]: commit 30f241fcf52a ("xsk: Fix immature cq descriptor production")

Jason Xing (2):
  Revert "xsk: Fix immature cq descriptor production"
  xsk: introduce a cached cq to temporarily store descriptor addrs

 include/net/xdp_sock.h      |   1 +
 include/net/xsk_buff_pool.h |   1 +
 net/xdp/xsk.c               | 182 ++++++++++++++++--------------------
 net/xdp/xsk_buff_pool.c     |   1 +
 net/xdp/xsk_queue.h         |  12 ---
 5 files changed, 84 insertions(+), 113 deletions(-)

-- 
2.41.3


