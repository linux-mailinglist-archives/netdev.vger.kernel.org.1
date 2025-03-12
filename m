Return-Path: <netdev+bounces-174316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15795A5E415
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C2D177AA1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC3A2586EC;
	Wed, 12 Mar 2025 19:05:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53B23CF12;
	Wed, 12 Mar 2025 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806320; cv=none; b=ZBa8c6+/gyXtv1oIB4U99azR+qK6vqrZdTxLpAFxkjMrEedFILYsVI7+jb2xv+1dNSlR2T0GGEd4FpZdZwYtFMPoj8LlYD5M/kUKapeJ2H6P7avTIPfiy62Jyvydc4Z9IY0fKzbWHnEjGTUWZXXqE6BUapv2kfIcCYSkmr4zT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806320; c=relaxed/simple;
	bh=0VEaS/ukPPi9Zli5QKPTJYgAzUeL2GTOi+lMq6UJ8/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3K1onXFgnL6G6NBdvxNo2aEZ+pDT6F6LAjUki0s+SwKaisunt9MMUlK4J6/sbnGR7VSpBcGHI+ukKXj3pa4hrPBZP1wtlRFjK0ewCzXCSNk4xW5rcpWSFRQvMau/X3EJl/TVW9wwaf4v0V99L3D5Fp7cgoCH7Up/crrr0Snw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff80290debso488829a91.3;
        Wed, 12 Mar 2025 12:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741806315; x=1742411115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0u0DffRqw5p0axRipakAJNl1YOnA9nhsVlI+YwH2wZ8=;
        b=MBwAg5gaZASOLUofNAXOU9QDAJ+o7DJJKpCFBA/w8+LyhcQbdHbA3QDSfUIu0K9xgL
         wgRpNZT/zf8JCPRLuUKdYoP0XQrsYHmAoWX0RBgHVEsn10G36O3bCg51D3m8ddWe769E
         QRYh8v2bnZ784lERjyEsEpUxxrRrd4O5qqvPREDIIJLXz5iSJCGc5kPCQ6TLjNN1YLmA
         uUsf+8qohRFTJxHCGluXyOeXNbaRuSpwOfQvR6e5Q/IXWkVzqToX8roXoD94FtnuAIcW
         RK/e52vI/KPI3wvTTJYtRhyl6EHugnHdSA+Sbx9Se1bjrTc+XWPYLOsrl1a3pkl3LZ4R
         F6JA==
X-Forwarded-Encrypted: i=1; AJvYcCVsn9AVgKnmpVAW2O+6XsGiTEEqzcJSIg7GIcHCM6q/Ws7cKMxypnqBUEm44ouICD9snqHrv/J1oYWKog0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjybghXWo8h3saELoZ2PR4dr7koSoRS89L+aRoAGyAKezfJthl
	uVkTLtBq8BxTVJRpW8AH/dNWwIRn9CqmAWl6NBadegiboTKXhtl1UGLNLZyAGw==
X-Gm-Gg: ASbGncsRn4FG0eyXYO92of7z8sjAWLvgQZ6J1eld/lwEjp+gYG6ZoEDtNFxV2p6RqfM
	v/NszGJHI3SnZ6I0UDoe+itnUf34qbm3JmhEQBFaBTkeqdORVUsMDopktFrAgeEg5sHPrzby0Q8
	EbMEokQp+n3va3HEdOlRJXJEqcV9d9K8t/4qgQryXxBKrnVHKAqZkO0chvrj3fJWOCr9nfriBYE
	MljRapx7W7bvqzFz8KsMKuYFWV0t06i7rX4rd6qxhqVXYxPmklWTw3I/mD1trYbyzFv3fkid6f4
	JeoygGlvEprrWEEWMnjvS9B076TwCxsf/gJiITFJxBXUkZbM6Shv9n8=
X-Google-Smtp-Source: AGHT+IE5UPbhhTrmzcCrSNJ9kZYj5Rs1fLGRFUGdrAj1RFh95UijYoL3tesCtiLy38eoCGdOVsHL9A==
X-Received: by 2002:a17:90b:3b52:b0:2f8:49ad:4079 with SMTP id 98e67ed59e1d1-2ff7ce451e3mr32133940a91.6.1741806314693;
        Wed, 12 Mar 2025 12:05:14 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e974fsm119947365ad.78.2025.03.12.12.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:05:14 -0700 (PDT)
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
	kuniyu@amazon.com,
	atenart@kernel.org
Subject: [PATCH net-next v2 0/2] net: bring back dev_addr_sem
Date: Wed, 12 Mar 2025 12:05:11 -0700
Message-ID: <20250312190513.1252045-1-sdf@fomichev.me>
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


