Return-Path: <netdev+bounces-71841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918638554FF
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3239CB227A1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C208612EB;
	Wed, 14 Feb 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="aNOcHXVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353D13EFF8
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946812; cv=none; b=Kj+HCoDJaax0/KLP3TrAJeEpUOkFRGraQ1l5kmz9NzBfTFKb8QkdhdmF6bASp8IMGojN8skRj1zgSS8KEuqWT3wnLKegxIUsKlJ4qf51NwceTLT2f1lheqeokPXQ80MsrqfkaKoLCc4rXzxAkGSQSuUYYwPsa8vq8ZTBzVqI6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946812; c=relaxed/simple;
	bh=zAM5FyBfdOj0AR3MA2fx8mTDfs9cuQydwsmc0KVFAgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IDafZzQ3b+TW94jlppj3qL8eePSQpoj/RCC+ppwvBLH/GeiUlaZ/R6ANGpGkYHKiGnuZ6q/RlB+AFk1kWk8zzMUBqmkmfeS4ONPu92p66+mzKGBPQoelV/gHSbEuwhp9CvJjlp7Uoq9NmVxSCQLUxQb1P8MM+nWdDAotP6MrA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=aNOcHXVJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so235385e87.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707946808; x=1708551608; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMEBP0pvYWP1lqddz+rz0Za0zJfmlRQq157P1uo0DcI=;
        b=aNOcHXVJP2jBb1fYThZhMnZX2KN/+JMhtYIglYxm5ZfrFqDDWpNi80mN0FRIvVQ5Iq
         T1YEMte21IB4Bni3t0pMjGQthdaCVZFbiW/wndoFMPGjYNvuAw01pbxyGy335cxYSRrL
         N5foW03TX056HdfuvhVBd8K1N2+jCjgUUdeM3jIzaw8Uz1+gyDlNlAPQBiFyHyrAWiEt
         xnwwNA7O2H3+sxKOo4Y/tdtaQ624iLdhBIumA+Vp4fHeo5qq3TZAuI9Ete+kZZ9NiiBy
         S7WKloIGa+ZDTfr5S7WTualeBkQ8AjwSQUEMgf6hDvXpkN/nigRFYXBN2QoIU7hC+Rnx
         K4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946808; x=1708551608;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMEBP0pvYWP1lqddz+rz0Za0zJfmlRQq157P1uo0DcI=;
        b=rozh/1VhuW5DnzawO90y5bdvwQj9d25jcfZAfAGDIWu0JF5dCRKr2lV4TmZdc0utbN
         20VbjhoereH2yGeZ9S45ZeHD8jwg/R6uiYjA2rL8yGbzx6a9PELgJlbTxp0vgrUZWoq4
         kvGFFOiOJTpZIFftXAZM7F+hUCOFLro77q49fmt0hhdFmn8UtUYgL7otKi7YU+0bbix4
         FG17mGC9XVJgOmGJ0u+FPyBMpUvpuDvXYwTsZsUO+IEv5nOp6oYZwNKLIDbB44U8FeWa
         ADiIFr3yNwP5ItFGljwcQS0H+Ayaqu9L0Nwb9XcG1Um29GZdBeW7xsSFRPFYwZSbylYa
         iSJw==
X-Forwarded-Encrypted: i=1; AJvYcCUThIeKlPYiuOb3vdQizWrMgaSByhnEGgbTWOca03SKlz0L+kTI8nIdy63LK4zdmigCPSlLna+3R0mOmoGQI+QuPk3oNVty
X-Gm-Message-State: AOJu0Yx2SezaMYkwlIk1C/BpyiZNJhGiFMAvYjICeGDKHq0bDssZRNi7
	jmrVTY7p/yUbgL1GGfC7eowjOOC9Dw7PH9+nwXkvIbNDL98H8G8yoXPs2s7yuKk=
X-Google-Smtp-Source: AGHT+IGzaiU4dOC9mi7Fpjr5ZD2zzxeAIZ5jWdn90rtQHEA/W7QQAVeb9W7BGhkx3UN+OSTH6uA0XA==
X-Received: by 2002:a19:910c:0:b0:511:ac56:2595 with SMTP id t12-20020a19910c000000b00511ac562595mr37990lfd.2.1707946807992;
        Wed, 14 Feb 2024 13:40:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIZ/E6DfYF53s2qxsiO8AqTSP4vmwqJMbiuLBH0b01MCoXdGN1LRR4MZXaLM+WeqU5iOKIOXCmLahBhc+hR0YxlJ4Ey5W/a4QLExLv3Qp8WumClZrjSGcdPjVO5mmiSKHEcDMlIKKLs++KFKOnUsZxqyw2uLhjPgNhkxxKDhhoWT4w6cSppz/cq4Db1VnRgLVhNXxDek41OpqjYWAU93ge8eBFUcN3vLnWDj89uOc0uC9tqGkhl1Z6kPihJMsg/NDP2P3AEFVxrBHJnVjO7ag6
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h21-20020a197015000000b005118c6d6a2fsm1433290lfc.305.2024.02.14.13.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:40:07 -0800 (PST)
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
Subject: [PATCH v5 net 0/2] net: bridge: switchdev: Ensure MDB events are delivered exactly once
Date: Wed, 14 Feb 2024 22:40:02 +0100
Message-Id: <20240214214005.4048469-1-tobias@waldekranz.com>
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

v4 -> v5:
- Fix grammatical errors in kerneldoc of
  switchdev_port_obj_act_is_deferred

Tobias Waldekranz (2):
  net: bridge: switchdev: Skip MDB replays of deferred events on offload
  net: bridge: switchdev: Ensure deferred event delivery on unoffload

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 84 ++++++++++++++++++++++++++-------------
 net/switchdev/switchdev.c | 73 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 28 deletions(-)

-- 
2.34.1


