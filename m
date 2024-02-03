Return-Path: <netdev+bounces-68815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2182B848675
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 14:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BE61F23C7E
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC913D97F;
	Sat,  3 Feb 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezaoF6eL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C9F4E3
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966175; cv=none; b=qJM3ny8Wt5kkYK3PQvkbWPXI8bJBRNN1GSU/Iz7KpodJxciMAkD0CuM/+VkKFaXglxCGwMjW8HolmGC8SxrJKP0YU0Mud7gYAoypSmr77CQg85Hv0wQca5R5mDd2HldZ7cfK9r9T8kMbEHa+RRl1IMUZB2xpkkAkyfgp2LKpxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966175; c=relaxed/simple;
	bh=jCnQwu9oxnE6OUfb4o1wWnS+SElEHPErnXpnNcOKeXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGhk86FwLkylHdvf27IsCziQjJUnH/hPFj23gw2KyjAOI50lH/kQsW6CtnMZ1GorW/BxgAMZ9Z53lhilPdS8npGZtTymHakXhR7wHrB6VUKF+ql5hm/m0TfOYBPNYqf82R1pCZ+Xw+HnflIO+T1kfT8oAfS6ORgsIwTYc/kkkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezaoF6eL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb020de65so25866395e9.2
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 05:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706966172; x=1707570972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsfskhGQrN73VnqHhqYoQiHNCexD5Bnp3Na+tGUbaqE=;
        b=ezaoF6eLZLdpAfigzj/t2055zRXKlAUHy053AOfERRuJ4qxeWEE6cUDo41oHHKQhNW
         7c6kmcnvvfx9IaeQ0UAmFonbVtHqSvmLYquka2f+5Hrt4FW0daZQ7u1o/7PhbcKAgJFL
         ojdw55v1zi4B0fPrE8JOxCjfzAmvT3ggCYk9FkMYUNw0Zli/+DH51HbECMe4WOqEtNda
         x6AHXHxEigsv6M7qLrIukal3Nhb+aKjugDIdYP93nSV6btZYGBXaiMxOVBIspf76oY1j
         51tujFA0KHk753K50nII+GePqjXlPPsROuktglSbjBHJrvukzIrj9uiEMvrV72JP8LT5
         BdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706966172; x=1707570972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsfskhGQrN73VnqHhqYoQiHNCexD5Bnp3Na+tGUbaqE=;
        b=LOSxUT4PuqwMCpFFdfJvVPh0EfkJrPkCwWqzVVCHCgn9C6XGxoIwSHb7oDQXKD1Chx
         yigPEK9fc6fdDMNgziLdDx85UK1as30keINmzCh09l0zA/5A9+YcV+PvES5BCct7pmDe
         17ScyPaBuiN0/h1JhKJ10A5Wl1KwrbOpRIFuZArHp8yrLbYTXGRMMYrP2xF5OyH5c76Y
         /n0iJNw3twPjkl19wP8CVNDH/4RxLwkmRcswhyrP0qQrBxso/A3PXdL7FXiWLE34fp8H
         H2FkSvz9x6X5FX08TzLW0d/dfrivbulWdQwxJAz7LsSibwpceyXYIPIfIDa9cEd9qMY6
         Ff6Q==
X-Gm-Message-State: AOJu0YwbgoQisaMm60GzWrH9pDT87HrtETiiR3xO8CQMaBI9ldVw9jEQ
	uyiVIJPqnajwGgplBVJ2hL4WopUlOlC1hCNHHmUI9qC8dZxFRIt3
X-Google-Smtp-Source: AGHT+IHSa3xy4L+AiX7vdIOFlH4TkzMJ2f8P4z40Z9C3V5WcH6eWO1DsQTQO+VEHNtWQkg9ogrqy6A==
X-Received: by 2002:adf:fa4f:0:b0:33b:29a3:960d with SMTP id y15-20020adffa4f000000b0033b29a3960dmr1216553wrr.1.1706966171610;
        Sat, 03 Feb 2024 05:16:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4g7RTGqOo20T2d4OZtOpWLiBiEQpyKak5xmbMQ8tsPHtM4V6nrn23Eb1SZ0+j87Ob3a7n9g11uPWnazgb4gj2O83DaBu86fZA2HLnqchmZDaEEgNuGSkBeXOigqFZZcSnQBiIX9be1KXGPGQjcQQN3MW4luAuRQWzswwE/rmTurPcOXwAESytI68c5QMkv8NKqRVDX1nRgRF+Dh0bbTSN+voWH8BlXu8mT+7zZafJILJm7yRFckalSkkbdf2Do140ODfgps0N8wq++qLefAbIUUJw0MlID6bgNZWACLqXo0q/Z2yvDBVzFRVYIwfm0GIpOIGAANHRPQw9UKFKKxrQ2wdGUmjddSH3
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d554a000000b0033ad47d7b86sm4036456wrw.27.2024.02.03.05.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 05:16:11 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v4 net-next 0/3] Add support for encoding multi-attr to ynl
Date: Sat,  3 Feb 2024 14:16:50 +0100
Message-ID: <cover.1706962013.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset add the support for encoding multi-attr attributes, making
it possible to use ynl with qdisc which have this kind of attributes
(e.g: taprio, ets).

Patch 1 corrects two docstrings in nlspec.py
Patch 2 adds the multi-attr attribute to taprio entry
Patch 3 adds the support for encoding multi-attr

v1 --> v2:
- Use SearchAttrs instead of ChainMap

v2 --> v3:
- Handle multi-attr at every level, not only in nested attributes

v3 --> v4:
- Separate the new code block with empty lines

Some examples of what is now possible with the ynl cli:

- Add a taprio qdisc

# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml \
  --do newqdisc --create --json '{
  "family":1, "ifindex":4, "handle":65536, "parent":4294967295, "info":0,
   "kind":"taprio",
   "stab":{
       "base": {
         "cell-log": 0,
         "size-log": 0,
         "cell-align": 0,
         "overhead": 31,
         "linklayer": 0,
         "mpu": 0,
         "mtu": 0,
         "tsize": 0
       }
   },
   "options":{
       "priomap": {
           "num-tc": 3,
           "prio-tc-map": "01010101010101010101010101010101",
           "hw": 0,
           "count": "0100010002000000000000000000000000000000000000000000000000000000",
           "offset": "0100020003000000000000000000000000000000000000000000000000000000"
       },
       "sched-clockid":11,
       "sched-entry-list": {"entry": [
           {"index":0, "cmd":0, "gate-mask":1, "interval":300000},
           {"index":1, "cmd":0, "gate-mask":2, "interval":300000},
           {"index":2, "cmd":0, "gate-mask":4, "interval":400000} ]
       },
       "sched-base-time":1528743495910289987, "flags": 1
   }
  }'


- Add an ets qdisc

# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml --do newqdisc \
--create --json '{
"family":1, "ifindex":4, "handle":65536, "parent":4294967295, "kind":"ets",
"options":{
    "nbands":6,
    "nstrict":3,
    "quanta":{
        "quanta-band": [3500, 3000, 2500]
    },
    "priomap":{
        "priomap-band":[0, 1, 1, 1, 2, 3, 4, 5]
    }
}
}'


Alessandro Marcolini (3):
  tools: ynl: correct typo and docstring
  doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
  tools: ynl: add support for encoding multi-attr

 Documentation/netlink/specs/tc.yaml | 1 +
 tools/net/ynl/lib/nlspec.py         | 7 +++----
 tools/net/ynl/lib/ynl.py            | 7 +++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.43.0


