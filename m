Return-Path: <netdev+bounces-71064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E79A851DC9
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 20:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484691C20A4E
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7756A45C14;
	Mon, 12 Feb 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="RwUpXEpj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411AA47A63
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765561; cv=none; b=g2fVSg77aNnPM1jtA1iyN6Is5+LqsSVc4oFPiy7mU6FHgbehIZZDrRgzZQpa9boYh6ktyGAovtXzOqJ5VJRcbTo1p5o8tZi5QLEYkrHKKwrrXjIwdZjpI5F5SAqyuflhsU2tdmzMSeiG0Ilx5x+XRPUlGC9yo5eaW1lzwzmbIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765561; c=relaxed/simple;
	bh=z8oqdqEDhRCXk/yo/TAzsJzRFK9GPU2AFNlcqOKIRW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eu2+v0rBZ95HLs1yDmCCe2koRp372ttuSUW19U+UGs/abwHFBJnEwasap13drXfae0XZvUGQzHZ4IPpFeFON56wYlqZjSeL3wiJHPastAdPnj+85rtXceYv+PwIW5iZU5QDp/0queI+mEi6gbOMxDs7t5s/MJX8WlXDKyv500vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=RwUpXEpj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511898b6c9eso1663021e87.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 11:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707765557; x=1708370357; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owO5+EtRA7OjN0hrV4Td8NGEMC2elnvfBXu3RlDCwnE=;
        b=RwUpXEpjELtUUoKM/HZZpC405VMqX75LRNFIAerZfZxuRCak2B1xRgpN/K/LDLh4Li
         64xRhzb7pQRK7u9fYs1is6D/zdmKVD9NWHlUfTyqRAw/Z8sfeHjDSr0bj27nR3/Udhzo
         ramSYCr9cbEJGEZUYGA+3FFTdvmIFr81xZQNk5jKAYinxXUHrcZPwQFTbXOwYba4wFQV
         JPl9UoJXTuNDz82zP72Ftwer1PNTfqQL8s1krrJhu8N/4Mj8Kh7eZLzg8lZBqIf+TO+K
         T1u/5yn+irVnU48uFGOMyZxkps+DCLnrNz8bdasfHTMSZLtydRIjsAb+5I9W3TtT8oih
         YTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765557; x=1708370357;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owO5+EtRA7OjN0hrV4Td8NGEMC2elnvfBXu3RlDCwnE=;
        b=nBDrj7XubpCfv4VVAR4Cykxm+C1s7iz5I8JiG6ALaifc7D8OnDowKz5GBeTo7aGvEz
         nbv38NqT4ZzhpMPP8gxplAe7y6fs+uS0Hw4UY6h6MF2g0G1cryvC6jNkLSh8/VWyVSWg
         oHw/ffkfcnkjs02E/hEp0IJiYL/1FXACVtNYsMzC8aN1SS6urxoLCgIjKXRKSe2VfLpP
         iIgwSyJirUmspYMNvvLN/E3Lmf6UCkbRMIqs3jFSU8nCIXI8dhRfZA7Fso+3t3xbyOz+
         6auhQbtz3VPUGd+qICJxFvZR+dQMqvDpxPTUQxHYSQfVKrFlwu3c8WB50694Chn6+ARs
         uzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmk7vRfNMUPMLkgTtZmTn7H0jQJb1DuJOhgpEYT/0nJVga1LbOjcdcaDf+jvYX8q7jB9u5cX3ljLdUwh/Qhm1S9sGQvv6Z
X-Gm-Message-State: AOJu0YyCJJkevueTnOiQvgtWvTCi7ZzSw/RmyfEMBd8EBQUhiqr289VC
	mpCq/pAGohM5c9QyVXbBKo5uyBO80RfOxLjwKnRELl5yq8W+jLzxnMhUpogfaFU=
X-Google-Smtp-Source: AGHT+IF/Lc0e5GGhvByl3h7ILfvksmYLQsBCRUOzv6y0e7AuRUvXvYkJTuUvcFB9zVgepzNpHxQKtg==
X-Received: by 2002:ac2:5990:0:b0:511:7681:1853 with SMTP id w16-20020ac25990000000b0051176811853mr5041194lfn.16.1707765557066;
        Mon, 12 Feb 2024 11:19:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXS0FWQv1bMUhtf7zrWpfkK1C9iLOEZbUPHxQn8ZQZzNk61uqLuB2OnvqiwR/XXkYOBMtJJyJJILVp2Hx7tlfNpLxLf/3oICdmAM25bX3xip6pfZ7PzxPfCK3Z5AzHN4/qa/Ymcc/7tp/04CmmAdiCBJ/S9d8fPA9agzLtEWzfrU78uS92cA6EJI63J3rZoZNpxgzLGn8myztIxzTYkfkJ+hGCkLlffPPuRFwzr0JZO1abPcfnTfQ1wnxTnc1z21Pnnn76Uko+m1fNu5iuitCMR
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id n9-20020ac24909000000b0051157349af3sm974647lfi.47.2024.02.12.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:19:16 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	atenart@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH v4 net 0/2] net: bridge: switchdev: Ensure MDB events are delivered exactly once
Date: Mon, 12 Feb 2024 20:18:42 +0100
Message-Id: <20240212191844.1055186-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

When a device is attached to a bridge, drivers will request a replay
of objects that were created before the device joined the bridge, that
are still of interest to the joining port. Typical examples include
FDB entries and MDB memberships on other ports ("foreign interfaces")
or on the bridge itself.

Conversely when a device is detached, the bridge will synthesize
deletion events for all those objects that are still live, but no
longer applicable to the device in question.

This series eliminates two races related to the synching and
unsynching phases of a bridge's MDB with a joining or leaving device,
that would cause notifications of such objects to be either delivered
twice (1/2), or not at all (2/2).

A similar race to the one solved by 1/2 still remains for the
FDB. This is much harder to solve, due to the lockless operation of
the FDB's rhashtable, and is therefore knowingly left out of this
series.

v1 -> v2:
- Squash the previously separate addition of
  switchdev_port_obj_act_is_deferred into first consumer.
- Use ether_addr_equal to compare MAC addresses.
- Document switchdev_port_obj_act_is_deferred (renamed from
  switchdev_port_obj_is_deferred in v1, to indicate that we also match
  on the action).
- Delay allocations of MDB objects until we know they're needed.
- Use non-RCU version of the hash list iterator, now that the MDB is
  not scanned while holding the RCU read lock.
- Add Fixes tag to commit message

v2 -> v3:
- Fix unlocking in error paths
- Access RCU protected port list via mlock_dereference, since MDB is
  guaranteed to remain constant for the duration of the scan.

v3 -> v4:
- Limit the search for exiting deferred events in 1/2 to only apply to
  additions, since the problem does not exist in the deletion case.
- Add 2/2, to plug a related race when unoffloading an indirectly
  associated device.

Tobias Waldekranz (2):
  net: bridge: switchdev: Skip MDB replays of deferred events on offload
  net: bridge: switchdev: Ensure deferred event delivery on unoffload

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 84 ++++++++++++++++++++++++++-------------
 net/switchdev/switchdev.c | 73 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 28 deletions(-)

-- 
2.34.1


