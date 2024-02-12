Return-Path: <netdev+bounces-71090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DBB8520E5
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 23:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DD9B24835
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C464CE19;
	Mon, 12 Feb 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="e78XzDiY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090A487B0
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775553; cv=none; b=ryIA7vC5VLlvqcSubCYkzivRYRoqyDFRr3Qcju8DhSopP7lfLYUyeUcVx0+UF5WHpykmi/Wx3lpU3Cc3yibM4gv3Xoh/2TupeUwdxJGs3hhwswYkHWs7ysxmcfGiNBz3KpQXmvEGmPOMnIv5ehZ+y9WFfcg3cxB3wrnIfzt2OXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775553; c=relaxed/simple;
	bh=VJrp8Vvaog3yrnjcar07WPi5V9SYC05Ocpqg/YPGU3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uuxLeCQCgUpmT9XbDPYsQ8cWW5/RT91T9SwHfrJqX0UwvCSiZPeF+TSB/Du1UwtEqAZUV+rayK5qHXrol/jRDFNIWP9nDTNuIn8Mpli0hHb+czqt43dYaQJ5gnyDCfZNqXBd/jhTi8E9+8tqILYe9YsnecADYfgJTRddiT6GvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=e78XzDiY; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e2e58feaefso185881a34.2
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707775550; x=1708380350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oog96IYEdiS4xj+niEFQh7UJcgvUbwDKzZvToX9Yy+M=;
        b=e78XzDiYD/VIGf/ldPnVmnQLKG9i6L238mtLqc47Wg5khOuf30sa5a/vI0raEXlOu8
         SQO+CF9KqNKiYEy63ZS/nIn22MjdAl83SBvHpuSqm7tfzTiQU+cBteVvKA+SOL8zOQQ/
         UJm5wOi3UqllsPJ7r8h4ER1IpLHTlKyeFWXHDkMvp7v3l5mBU5u+hqOH3MT7H9ujgiNW
         WGYqe2SaSdUbEArBz1lUzqn6yHMas9fG8O+njDLA71moOwV4NFrJ+JM4w7jDOjEH/4Mw
         iuwuc4KkQvWt7nCGebvajlOcKg89NsE+TgbmbU4qbiSCYzU4XycOPcXxxtg0mW+xCpmm
         34/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775550; x=1708380350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oog96IYEdiS4xj+niEFQh7UJcgvUbwDKzZvToX9Yy+M=;
        b=qbJRJQ67cspXY6BG8/6NmvAXCV0t62eQ0VnWBGARYA9o3i5GcUTw5GsEGFCLnwQZ2R
         lvpw+X9sUec5ipfcj8D84rnJHKm++UPm1Gh2MMTGltCA+8+LJNLzSKJn4m+AwhL46Us3
         o68gjQevHGDCNST8VNFf1WJu7cvdv/H0fEOzkNodr/dv24E79uH4+7P/e6iKRu1LhzOM
         oFxGPbSyTyBRqFyICAeKrOtqX1fYRLprRprLKcK5n8jZPraOpn3ArUwRfI4c7SZKXXzg
         d/mRbe1GjVS8g6jnKDGWdh+qSpfK42P6PbHAAniP39tK5JgAcQmmNP1CO+eYBwxCTYJT
         590g==
X-Gm-Message-State: AOJu0Yyu5ZZpArPp+hnYRYKVrVM/4iQVvBI4NGPiZrlKf9DhU5e04xdI
	pX/KZhFHKlh0Pj+XD8L7DMoXMQNCeCQ7lBippPsZ49djqarj1VrTYLEOXR9Ktrk=
X-Google-Smtp-Source: AGHT+IHFsfrYZQpU3ITDOG7J6rn5D7QxYlUihyKZSwf4wAv5Dge71VxvMVTA0a7FuED/phPT1kuqBA==
X-Received: by 2002:a05:6358:7596:b0:178:e2b3:98da with SMTP id x22-20020a056358759600b00178e2b398damr12834322rwf.28.1707775550335;
        Mon, 12 Feb 2024 14:05:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8qqywRG3HKr8zDgSdRXl/jsOCY3IMiCq/AXf0Ed0oECvyY+PNp1ClZD0YHCOzWvsMOsKkzXOgZBYmo20eWRY+0Dx0xqumWG+tZbaW/EfQVaKAO7kTcMSS5PZH4NneU3Sg/b0Jv1Sp7CXtsxdxw+92hV6CG8ZtTRoHagbIzHImKYAr8My7/5wFNLPSL4/1jF+KzRZs
Received: from localhost (fwdproxy-prn-016.fbsv.net. [2a03:2880:ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id s73-20020a63774c000000b005cd78f13608sm918663pgc.13.2024.02.12.14.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:05:49 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v10 0/3] netdevsim: link and forward skbs between ports
Date: Mon, 12 Feb 2024 14:05:41 -0800
Message-Id: <20240212220544.70546-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the ability to link two netdevsim ports together and
forward skbs between them, similar to veth. The goal is to use netdevsim
for testing features e.g. zero copy Rx using io_uring.

This feature was tested locally on QEMU, and a selftest is included.

---
v9->v10:
- fix not freeing skb when not there is no peer
- prevent possible id clashes in selftest
- cleanup selftest on error paths

v8->v9:
- switch to getting netns using fd rather than id
- prevent linking a netdevsim to itself
- update tests

v7->v8:
- fix not dereferencing RCU ptr using rcu_dereference()
- remove unused variables in selftest

v6->v7:
- change link syntax to netnsid:ifidx
- replace dev_get_by_index() with __dev_get_by_index()
- check for NULL peer when linking
- add a sysfs attribute for unlinking
- only update Tx stats if not dropped
- update selftest

v5->v6:
- reworked to link two netdevsims using sysfs attribute on the bus
  device instead of debugfs due to deadlock possibility if a netdevsim
  is removed during linking
- removed unnecessary patch maintaining a list of probed nsim_devs
- updated selftest

v4->v5:
- reduce nsim_dev_list_lock critical section
- fixed missing mutex unlock during unwind ladder
- rework nsim_dev_peer_write synchronization to take devlink lock as
  well as rtnl_lock
- return err msgs to user during linking if port doesn't exist or
  linking to self
- update tx stats outside of RCU lock

v3->v4:
- maintain a mutex protected list of probed nsim_devs instead of using
  nsim_bus_dev
- fixed synchronization issues by taking rtnl_lock
- track tx_dropped skbs

v2->v3:
- take lock when traversing nsim_bus_dev_list
- take device ref when getting a nsim_bus_dev
- return 0 if nsim_dev_peer_read cannot find the port
- address code formatting
- do not hard code values in selftests
- add Makefile for selftests

v1->v2:
- renamed debugfs file from "link" to "peer"
- replaced strstep() with sscanf() for consistency
- increased char[] buf sz to 22 for copying id + port from user
- added err msg w/ expected fmt when linking as a hint to user
- prevent linking port to itself
- protect peer ptr using RCU

David Wei (3):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports

 drivers/net/netdevsim/bus.c                   | 135 +++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  40 ++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../selftests/drivers/net/netdevsim/peer.sh   | 138 ++++++++++++++++++
 5 files changed, 312 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


