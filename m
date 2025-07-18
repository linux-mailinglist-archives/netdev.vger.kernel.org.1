Return-Path: <netdev+bounces-208082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D32B09AC7
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 06:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8CC1C21CCB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B861DE2C9;
	Fri, 18 Jul 2025 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYUrRsiV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64191DAC95
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814689; cv=none; b=sv1ADrHXXlG00hZbzDMiTIy170prcXy16+Ttw45ixa5xO0ABm7t2gWgomLnaxtY8aoVRdeZoMIgSeu77uPKsJDQfh9A7SbsYjYkaSubN96q13d9qL7VfREmomjwNTEnaVXk4i8ckWZExh0WgxKTeoTrCgKOWB9PCH4JkW6VwaJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814689; c=relaxed/simple;
	bh=aZ1vlw0U+xUXBcBkJYnH4XUI5WVoFRGaNjb36SlbmCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIM9aCHcwj82hPW6gvvw2+NjHREHywoiK3ugVdJhwvHDqBUfpVm45QJTsIIbXqLWOT0P1DqKZT9x2jqzAe57/wK51JF56xCRU/BzQ7ufGJ/LVkObbCaGTlenSo8V/GHJhtCIicPgM0LfTncLWVTpMrzXSElJoK7hqWkHcnwZdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYUrRsiV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b321bd36a41so1354387a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 21:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814687; x=1753419487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ubegt/Ntsn/2UxEwvuiRUKupjAlt8NVaYUWH21Mb0A=;
        b=HYUrRsiVeYTt4omj1bHQm92NJisF2mM9gcFBY/XIIAYDYLEp+PhWf2qjf5dGPg1Fcc
         tZ1BXba5esTVTIZKOVLATgzH0F12jMJpjjAfc59ge7mGn/tIt9Cs8WULVYM0+fGT7dXJ
         vaSa5MCpM39DPounqOu4aYT2KhlW/hcZcydY4cIUl4dU5nM3P69daEYCHFYp6Wvk6Gud
         ngOTITqKn3Cfby7CoXE3Q727H1DaYDeZBFLyKoP0R11oAWi/+3Gl2/BrbZJ0/EWHZOGY
         CTf/MFLGqtbshuUD4LWOJLEoRwNPn9GhuiWqUp6vNqFys6KpzEgKeL0baHZb7iPz1IlB
         NeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814687; x=1753419487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ubegt/Ntsn/2UxEwvuiRUKupjAlt8NVaYUWH21Mb0A=;
        b=r4nKvwzQJDokJsEE6HmoWp5wvmbyJKFtm8uo9hQxJzb4k1g3sqMPRyEzGVrKo2la9x
         axVK5J504hIe6Wp5ej/2b1s3xM5oPgZZb/5h8xt3yWw53it9/nlTgWeA0mgon/r0TDpV
         XZBe2NfIeNtsRwKayx0KHYa0c1eXXLKe7DjThoq71yO4Qt/6AXH3nErUZayFK4MvWf+O
         G6a2H8MYE4hxC7bvqA7MH/k7KrJxOB1v5hpUvX8ALSYiBHizPnLsM9kje7Jd1VA5a79N
         AWC17dF2Xea7aa3HlmLEgfrF3EqBTnM9vICxRk+mq4FUAvRwO16AaYV/vWoaunONeTFi
         R7fA==
X-Gm-Message-State: AOJu0YycyQeA8drkXlpGJw8dZiG38kObZ055p4u6hfgkKfJJRnRo1F6V
	wLE1bGxyT2t+rCXA9s7/T8ziE60N+wWynU8zelLh6OzxpKUAxaGqD3ghbvrDA+Yo
X-Gm-Gg: ASbGncs3X4RdpFxuB1YWWkZdfbdx9pOpkcdLu/5AqXa4N8gdgnDlOUm4TN9YBwd9djd
	0tU/JUNho6XjThOtybRbkm0jQevGbrvJPvRot+vkL8ZJgmWl61cECkjXX1Avp8YUpQIbc9SwX6P
	zZPAQmXRFqCMSIYkrPCgaqM700Z/vP54yivNxSd4txfmZoZiQ3yaj6JO+/LgncAvizy9ZZqhU0d
	5sNNVfmLP5jAi1dei63DbwCiIJmVtPwSxiSlIL889IfRqtjOBuvZnNoFrBJi2HGRMre4JlomReG
	Q2GKk9UWKbLfGs18Sd5sBSWedaWXvgqNL3Iutk8VO7kRjEMOaDUcTOEpRMqnSKZVjpn7LXqFn/U
	NYmCozE6ODzP+SL/CLffP6JTjgiXi/S6VXW8=
X-Google-Smtp-Source: AGHT+IE8JHczJFxlvXL3kuvsAHKRmvo+4kAKGMc0sVE4uIvXWjH/MObxTO18KMLE0ORy0+Pf9yB7vA==
X-Received: by 2002:a05:6a20:7349:b0:1f5:a3e8:64c1 with SMTP id adf61e73a8af0-2380e08ececmr13943127637.0.1752814686526;
        Thu, 17 Jul 2025 21:58:06 -0700 (PDT)
Received: from krishna-laptop.localdomain ([49.37.160.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff62789sm374991a12.44.2025.07.17.21.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:58:05 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	jdamato@fastly.com,
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [PATCH v4 net-next 0/2] net: RPS table overwrite prevention and flow_id caching
Date: Fri, 18 Jul 2025 10:27:56 +0530
Message-ID: <20250718045758.4022899-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series splits the previous RPS patch [1] into two patches for
net-next following reviewer feedback. It also addresses a kernel test
robot warning by ensuring rps_flow_is_active() is defined only when
aRFS is enabled. I tested v3 with four builds and reboots: two for
[PATCH 1/2] with aRFS enabled/disabled, and two for [PATCH 2/2].

I had also posted v3 as a reply to previous thread [2], posting again
as v4 in a new thread (apologies for the confusion).

The first patch prevents RPS table overwrite for active flows thereby
improving aRFS stability.

The second patch caches hash & flow_id in get_rps_cpu() to avoid
recalculating it in set_rps_cpu() (this patch depends on the first).

[1] https://lore.kernel.org/netdev/20250708081516.53048-1-krikku@gmail.com/
[2] https://lore.kernel.org/netdev/20250717064554.3e4d9993@kernel.org/

Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
Changes v3->v4:
  - Same v3 patch sent as a new thread instead of a continuation.
Changes v2->v3:
  - Wrapped rps_flow_is_active() in #ifdef CONFIG_RFS_ACCEL to fix
    unused function warning reported by kernel test robot.
Changes v1->v2:
  - Split original patch into two: RPS table overwrite prevention and hash/
    flow_id caching.
  - Targeted net-next as per reviewer feedback.

Krishna Kumar (2):
  net: Prevent RPS table overwrite for active flows
  net: Cache hash and flow_id to avoid recalculation

 include/net/rps.h    |  5 ++-
 net/core/dev.c       | 91 ++++++++++++++++++++++++++++++++++++++------
 net/core/net-sysfs.c |  4 +-
 3 files changed, 86 insertions(+), 14 deletions(-)

-- 
2.43.0


