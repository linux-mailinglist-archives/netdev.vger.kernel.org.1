Return-Path: <netdev+bounces-173786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7903A5BAFD
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424327A2928
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D87226177;
	Tue, 11 Mar 2025 08:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05629225A59;
	Tue, 11 Mar 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682711; cv=none; b=FcIMr0yCCDxY1LMGbrGrkBrMbJ3axIy0XH4nqSzsKXKglNEN/Ea0VQdsv+7tA/U46JcIDomD/xNQW5HoYySHnhg2gBuaZi/o0RBo+xPazQqFNnfd0C5ZtjyEFhPGQHqEHui1QGxRxhpGfe23/lV6YSoBrcjWE4/5Pr9pYiXjCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682711; c=relaxed/simple;
	bh=0VEaS/ukPPi9Zli5QKPTJYgAzUeL2GTOi+lMq6UJ8/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d21KMdekN0gBPe1S5cq8RVFhKgckyVTL+6uWHAkQEwEBeoK/Jilr8/l4Hfm6yLCeamhMw132CMR+ideqOR2D+d5C8tlViMU9o0LUSmLj6R2LEjkcuDWpp4fegswxUF1R9TiXfppqsy2RDQDe/Yk2ofCRB0Um+4IG+IG51SK6biM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so7995721a91.2;
        Tue, 11 Mar 2025 01:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741682709; x=1742287509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0u0DffRqw5p0axRipakAJNl1YOnA9nhsVlI+YwH2wZ8=;
        b=YBcW1MX7i1UKz7F4VTJm9nzM9NP7fKXvS/ZnGbNpMj6SW8kLF9Ac+5rsQxaI2I/Q7x
         3R0GLbBztVevIERcyY8doOF8wyG0QeF+X5fu93Iq2T/CNKA2QW7RuJADCqGQLHO04Yh9
         mC0IC8z4lftm2QEHUair7Zwl+JfC5ocmjMYqsMZuluT1YdPXp3QJPSVfNCB9Upr3SMfm
         9UuUY1xJQNLmxvBsCnQoTrHYLmeebtZGBHQOIaZtcQHo7sDbdwrghFibOR0b05lJWbg1
         10kIJQlIljZOaqD/XgzdlosYnPtx1eYOROaskU19sD/5LAGHVgYQQlBiESbFuAp94BTr
         YLjg==
X-Forwarded-Encrypted: i=1; AJvYcCXsryppuytFuVf3TPQPSHQ8TV4F22FzlemWkusIF5vebkOLHvH16KAcKJ0Q+oLSDXgPXxPxGn1+lRooLvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3RwyXYdkmxvDxHUkXZo4eoX99+FaqKv9ju4mbBOyaoJSrM0s
	9NhJ3R9qSGhWGhunl4t+G5qbha0/M+Nsz7SNF5VsSiyFh8lQtIVO8W4JOR6Spg==
X-Gm-Gg: ASbGncs8ogIdEeTC9YmSYXrAkuZomKRi9Ben7a/YgAZLeuEhhlN8+tky+iGUAbchLQY
	S6HN3ky1VliKjQJDONMmvUOUe9zQGqoTf1gtm5zwbFQ03UvUYiyx+VNL0CcW1g4dasEsye5XQr2
	MJQPYcycP3HMUbGI4Ba3Vy4LOtoENuAr8vz7kkasXkQY9rVSOhrkQ3acpsBD8shtFfpepI+JnIm
	0iRtIdBynGGkwQTHoto08u+rwiuBb+hQXZwzeHCD90FsH5AHL0Nvx3aqvmkrYedRs5UDT2otUbj
	+Y3Gx9GsPvz/VTRkR41Wq8Vv9VPUbmzzauCQWaA4nh9W1lPh3YH/C8Q=
X-Google-Smtp-Source: AGHT+IH87Svq5gnEedoP2PREc2z6+VFKIXXDim72EdQts2SiSv7UhTxUBDFbwyFJEz0HMehnqjWdbA==
X-Received: by 2002:a17:90b:5104:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-300ff34d533mr3372497a91.26.1741682709020;
        Tue, 11 Mar 2025 01:45:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e7ff9dbsm11220599a91.32.2025.03.11.01.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:45:08 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	jdamato@fastly.com,
	kory.maincent@bootlin.com,
	atenart@kernel.org,
	kuniyu@amazon.com
Subject: [PATCH net-next 0/2] net: bring back dev_addr_sem
Date: Tue, 11 Mar 2025 01:45:05 -0700
Message-ID: <20250311084507.3978048-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kohei reports an issue with dev_addr_sem conversion to netdev instance
lock in [0]. Based on the discussion, switching to netdev instance
lock to protect the address might not work for the devices that
are not using netdev ops lock.
Bring dev_addr_sem instance lock back but fix the ordering.

0: https://lore.kernel.org/netdev/20250308203835.60633-2-enjuk@amazon.com

Stanislav Fomichev (2):
  Revert "net: replace dev_addr_sem with netdev instance lock"
  net: reorder dev_addr_sem lock

 drivers/net/tap.c         |  2 +-
 drivers/net/tun.c         |  2 +-
 include/linux/netdevice.h |  4 +++-
 net/core/dev.c            | 41 +++++++++++++--------------------------
 net/core/dev.h            |  3 ++-
 net/core/dev_api.c        | 19 ++++++++++++++++--
 net/core/dev_ioctl.c      |  2 +-
 net/core/net-sysfs.c      |  7 +++++--
 net/core/rtnetlink.c      | 17 +++++++++++-----
 9 files changed, 56 insertions(+), 41 deletions(-)

-- 
2.48.1


