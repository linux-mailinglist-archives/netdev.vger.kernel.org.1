Return-Path: <netdev+bounces-85889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803A89CC2B
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2821F24DED
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14258145356;
	Mon,  8 Apr 2024 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6Hf2AW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94113F006
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603085; cv=none; b=en3C6slFCIt1vBG5JDEYT25zJCwqB8bSKr16PZcarGtFuhwyRitjauVysySH5D9oNCJiqbHE/rb/qglgrVSlpP8WacMqFPabo/5KAfq8R/y6oM7yhB4Etsezvzp1L9/+ivcc7t5txFsbttdPiZqOT0d3hEjN9g4bI8vs7QL9utI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603085; c=relaxed/simple;
	bh=4G+TiPVu/ybLaQ4K2c4JOUc4TMKiA9ya6HYe/TgwC8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fN5Elw0m+4wfKZKm9/NXlTEaPomTeV52oICm5hhy9GPpLKIegVF2yYG1JfkMv61ybMlfUuCPiWcuewVhE1fsHksAsPHQiAdWKD07LXritPPXKFdmVNXPd+iMEAQicGj48fqvyQKCBbHxQwZuo6HzMrq2K1JEack10NRle+fu8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6Hf2AW9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so56274607b3.2
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712603082; x=1713207882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOXhkQgI/agt07trD6VJWCcnX+2mbEQKTSXSaTtmwmo=;
        b=g6Hf2AW9uITmhpzRtiNMe7/ELCHD2dZh6N7Fim23VYRidG+rU8yt1pP+qbvMy0nTaP
         8QqwjLHcrgZXmp+PERjRPU5QATjPttViFY+SpKCjHTRCkLJX9BtP3BfsNI21oQ3ZkOQp
         JUqz+VNbYZMYpw/dqoZdnv3WWaRGK9QQQsLlxp9UzBKAiFkpe77BTsYN6ueN0Yt1iY6F
         TrTC1rsG//cVTF6qvsoCd5prIv29uFVb0HqwPsILi7ngZwfI76PEzCQmXYDtOMLJ6taT
         UiozUd7BNfuxaWCAkHY+68mTZLeKxApBNvRRebo4Y1cBj87w6mxHvX9lm6x+adb4RNEl
         eL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712603082; x=1713207882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOXhkQgI/agt07trD6VJWCcnX+2mbEQKTSXSaTtmwmo=;
        b=iIbXDy7mXfSMtQGOb5YuQ0osmapKOwDUNoGaNeGEl0aAv0C3z8wiHJ/vQK2c87Ugnu
         CdmckgeMdrfpAtNd/EncWjnwODDSZDl5uYzamUVaSHfzmfF+2p2jYk40dRTLO6HlwFgr
         caGrQQ9hkY0qPJ5CGSWj/0B5QgQFmfFn57EkZnoChZBlXwb7kJut2UaNs8XA6WXBdF5l
         M9gfkbBAs42tfORsbaoWyp9mUxAoY4FGX0AdpcuTPKuAB/oBDwVtJiWBTJdxD0qHaYBg
         oU45Wmxoj4ql9XMVq7XZzHkKDCKshbToDd5cawUzilOdFJ2NCLmFYCJVxX6mQkin74eM
         Dqtw==
X-Forwarded-Encrypted: i=1; AJvYcCWwP8SQWq7vBsCZeb/vEej+jx9kd6NIq5ZXp2wS5xV+L8+/oXXu/dQMiSAOvtKgx0g59Z2rxizS3grK6/Nkto5L/1XhJVzc
X-Gm-Message-State: AOJu0Yx0invpxeDFhytZIVDqtgW5KaoPJvV1naqmakjAbABaPeKKamMO
	usqZVuXWRzDGnVtCYb8idC9hlndVak0hWUQ4TplodjBOKknhKQLvmrZkzkyibgsic7ANEYVuzct
	aOPinXyDfIA==
X-Google-Smtp-Source: AGHT+IHU/uJORMNSDsci40QqYa6FwOiCZiXNrRu4fIBkw1Z6GVKh/2BmQHXM0rrx5WnZF1fRr6o7VK4hpoiNgw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:d7c3:0:b0:615:768:ceb2 with SMTP id
 z186-20020a0dd7c3000000b006150768ceb2mr2285545ywd.9.1712603082527; Mon, 08
 Apr 2024 12:04:42 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:04:36 +0000
In-Reply-To: <20240408190437.2214473-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408190437.2214473-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408190437.2214473-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] bonding: no longer use RTNL in bonding_show_slaves()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Slave devices are already RCU protected, simply
switch to bond_for_each_slave_rcu(),

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/bonding/bond_sysfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 9132033f85fb0e33093e97c55f885a997c95cb4a..75ee7ca369034ef6fa58fc9399b566dd7044fedc 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -170,10 +170,9 @@ static ssize_t bonding_show_slaves(struct device *d,
 	struct slave *slave;
 	int res = 0;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	rcu_read_lock();
 
-	bond_for_each_slave(bond, slave, iter) {
+	bond_for_each_slave_rcu(bond, slave, iter) {
 		if (res > (PAGE_SIZE - IFNAMSIZ)) {
 			/* not enough space for another interface name */
 			if ((PAGE_SIZE - res) > 10)
@@ -184,7 +183,7 @@ static ssize_t bonding_show_slaves(struct device *d,
 		res += sysfs_emit_at(buf, res, "%s ", slave->dev->name);
 	}
 
-	rtnl_unlock();
+	rcu_read_unlock();
 
 	if (res)
 		buf[res-1] = '\n'; /* eat the leftover space */
-- 
2.44.0.478.gd926399ef9-goog


