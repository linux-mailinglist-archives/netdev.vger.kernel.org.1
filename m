Return-Path: <netdev+bounces-296773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2U+7OBpRJ2r9ugIAu9opvQ
	(envelope-from <netdev+bounces-296773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9CF65B2CC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rYbNhfcy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296773-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296773-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCDB63018AF3
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5327B2F0673;
	Mon,  8 Jun 2026 23:31:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268A45039
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961484; cv=none; b=IsOxUQa0QhtgbcM7KoQGc80+lsCwXyuKHsqHsFtoPMm/OvgrxSGQZxYCcZxGKSUSB2y1vUj3zxzOJwHfXNx/E15GumhECslt8g601W3IewE/TWrSBT5NorzHHrGYxMx2Fe6tKSh9PCiloKOwyPYZ8/UXCinL6HALy28doev4yG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961484; c=relaxed/simple;
	bh=R3RrB+PNyAyn2RXt4mpTmR95HpXcIbP0+m0veFSkENk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tt9FA6GadYp0Flhs0JG2Qy0YbDF6m729lDuIJSi1k6NGg5TYpJHIg8kRz4sPBf3gf+o84IbcjZXEl5t3TXPKMIwFiyAg1msV6ASNctZp+eoxqxj0Ju8H5teOJUoWOfWnyQCVG7GY3a40+haVKt42ZiYrA1jaz0n1LEyBPSGsKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYbNhfcy; arc=none smtp.client-ip=74.125.224.43
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66050f7af22so565212d50.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961481; x=1781566281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WM2nMmF4tJNwzAQKaPtTl6VkmZ9sUDuJNy4ZpqSl4LM=;
        b=rYbNhfcyAjZtH0lhR8tfZwYi07d9ndzKIGXtDku50uzi58u60D1PHJjEbBSX1OXnAR
         buIRUumgUlUXRdMHkUiEchvK6lPJHSmV+fV4EG6cBIxsXH52KIkpVOFhOmAn/D8t7tJF
         obqD8gYnhdsKRGpwVGkgHcUykeGeeGNGF/+DM/Dhhx7Nqpb4fXLDx/0aQzrAe8HvyAjn
         h64B9WhVZpngN+f6voWJYVnFjDRvD6bD7Dyud6cC1d1up6dqChmUtqo2aBgKHaPxYFNc
         mkO36UqtVtoV7gTO2/YvX8YN/Vcz8PUybprT06RAeOXTZWvKKnIxg8otQZ9lhFsWEID+
         nwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961481; x=1781566281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WM2nMmF4tJNwzAQKaPtTl6VkmZ9sUDuJNy4ZpqSl4LM=;
        b=oGSK0qZVJWWsTPKazwFadA0yyyX0OkIvTzCPoiwPpxJChnCg7iyJYlnrCoEFIIUOIb
         ntUDUkTu9p5mf4/HQ8X8YE6XyYJ9LSVfJ/X+h5+yB3Fk4wDuE9pVRUv8KfJEE12trWhr
         x1tMvCiV8IlYzTeumE1TdgogdGBKBXN9F4jnvMLH6NAsGHpevDOBrvbKZSDJN0Vg1KEg
         yBokTDTlUGdcIh9lEP8R+n06izoy32lKxtCdOLlSAZF23kR6to5+yTMyPyTWsYQ1VsCF
         GAkzZGKk6p3XMEUMzfU8ve/bnE388dhnUJbHERN0HX+cc8nbL72Rp4hsf6tTZgKJMKkE
         kPng==
X-Gm-Message-State: AOJu0YzbvBaocNHpF1ywneQebgsNTTwVGS6pTWasOnWa+vNXLlfuJMAE
	dAspZ5p/7fRgZimcj7z9Y+jdNiKEPJOXF0xMzbuwUrr8sp5yNObhwV5x0+glBA==
X-Gm-Gg: Acq92OGNHBurEU9oY1hbDPrXQJrJUNANQfphDLIrPv1DVZlLYkA1eNUQ4kLv914J8Cw
	/LkRpFwwUMkcyA54EnHRL5CrBfqiYCsK/tPWUK7BTKIF3IQndGlExQspD0TmF6kkoGIL0N8KlYE
	gQDYMGYaqLvXfZyNgnVQOfQagb1YTpoKHpe2FQQiSYG8+2BjCh2aanQoFns0HEwbJGEEWv86+Ib
	yUqhe5uGhsuLvr4NgX+g6kWlh2mNzHn5h0EH8JudPvGnra3lXWOvi3Xuwq0YqRKNmFpbPzEeDBx
	6KTZQMxRdrX0G3xKsIz4863RA9yZRGnQP/jDaqB9/5SUVOzAGPhORiXBgR9QGNbmX8Nzx41NwO6
	w0Sq1TevoWBIQvHOllfMWMM0QOuzOzZQ3YsL1JMiIbwQo1wjKeNDXAMdNqbCtdRkXNQSPletIOy
	wBDV1IysW6sLeLpbKtWCEMlRPT9rFCqnmdbTD8beVIwnQEjw==
X-Received: by 2002:a05:690e:1c07:b0:650:20d6:7098 with SMTP id 956f58d0204a3-66106f58bddmr9260737d50.4.1780961481181;
        Mon, 08 Jun 2026 16:31:21 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:70::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f3b494sm10073302d50.2.2026.06.08.16.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:31:20 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v16 net-next 00/10] psp: Add support for dev-assoc/disassoc
Date: Mon,  8 Jun 2026 16:31:08 -0700
Message-ID: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fb.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D9CF65B2CC

From: Wei Wang <weibunny@fb.com>

The main purpose of this feature is to associate virtual devices like
veth or netkit with a real PSP device, so we could provide PSP
functionality to the application running with virtual devices.

A typical deployment that works with this feature is as follows:
     Host Namespace:
     psp_dev_local  ←──physically linked──→ psp_dev_peer
	  (PSP device)
	       │
	       │ BPF on psp_dev_local ingress: bpf_redirect_peer() to nk_guest
	       │
	  nk_host / veth_host
	       │
	       │ BPF on nk_host ingress: bpf_redirect_neigh() to psp_dev_local
	       │
      Guest Namespace (netns):
	       │
	  nk_guest / veth_guest
	  ★ PSP application run here

      Remote Namespace (_netns):
	  psp_dev_peer
	  ★ PSP server application runs here

Note:
The general requirement for this feature to work:
For PSP to work correctly, the egress device at validate_xmit_skb()
time must have psp_dev matching the association's psd. Any device
stacking or traffic redirection that changes the egress device will
cause either:
1. TX validation failure (SKB_DROP_REASON_PSP_OUTPUT) - fail-safe
2. RX policy failure after tx-assoc - packets without PSP extension
   are rejected by receiver expecting encrypted traffic

Here are a few examples that this feature would not work:
- Bonding with load balancing in round-robin, XOR, 802.3ad mode across
  multiple PSP devices, or mixed PSP and non-PSP devices
- Bonding with active-backup mode might work without PSP migration for
  failover case.
- ipvlan/macvlan in bridge mode would not work given packets are
  loopbacked locally without going through the PSP device.

Changes since v15:
- Rebase

Changes since v14:
- Selftests:
    - Dropped separate nk_redirect.bpf.c BPF program and reuses
      nk_primary_rx_redirect.bpf.c
    - Dropped _setup_psp_routes()
    - Added _assoc_check_list() standalone test
    - Added _check_assoc_list() helper and use it in various tests
    - Notification tests use pspnl.poll_ntf() instead of manual poll
    - Renamed _nk_host_ifname to nk_host_ifname
- Kernel code:
    - Addressed all comments from sashiko on last version

- Address all pylint errors except for this one:
    C0302: Too many lines in module (1035/1000)

- psp_main.c:
    - psp_dev_check_access() calls the shared psp_has_assoc_dev_in_ns()
    helper instead of an inline list walk.
    - psp_dev_is_registered() before sending DEV_CHANGE_NTF.
    - psp_attach_netdev_notifier() comment was changed to plain text.
- psp_nl.c: kzalloc_obj() call drops the redundant GFP_KERNEL argument.


Changes since v13:
- Added flags: [admin-perm] to both dev-assoc and dev-disassoc in patch
  2
- Added psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF) in psp_netdev_event
before calling psp_dev_disassoc_one in patch 2
- In patch 5:
  - Added _find_bpf_obj() helper that searches test_dir first, then
  test_dir / "hw/" as fallback
  - Register clean up functions with defer() so we properly clean up for
  failures
  - Added cfg._nk_host_tc_attached = False and cfg._tc_attached = False
  after deleting the netkit pair
  - Replaced hardcoded cfg.nsim_v6_pfx with cfg.addr_v["6"] and
  cfg.remote_addr_v["6"] so routes work on real hardware

Changes since v12:
- Rebase

Changes since v11:
- Cap max number of associated devs per psd to 128 to avoid overflowing
  GENLMSG_DEFAULT_SIZE for netlink msg in patch 2
- Make common function for getting net in psp_nl_dev_assoc_doit() and
  psp_nl_dev_disassoc_doit() in patch 2
- Only allow NSID to be passed in when user is in dev_net(psd->main_netdev)
  to avoid manipulation of dev-assoc/dev-disassoc from netns other than
  its own in patch 2
- Fixed the race between netdev_unregister() and psp_nl_dev_assoc_doit()
  by adding devreg status check in psp_nl_dev_assoc_doit().

Changes since v10:
- Corrected typo on patch 1
- Removed the kdoc style comments, Use goto style in
  psp_nl_dev_assoc_doit() clean up code, Resolved "TOCTOU" issue in
  psp_assoc_device_get_locked() in patch 2
- Replaced psp_devs_lock with a new mutex in
  psp_attach_netdev_notifier(), Fixed kdoc style comments in patch 3

Changes since v9:
- Added comments for psp_device_get_locked(), fixed lint issue, fixed
  rcu warning in patch 2
- Return error if register_netdevice_notifier() fails in
  psp_device_get_locked_dev_assoc() in patch 3
- Removed psp version and ip version for unnecessary tests cases in
  patch 5

Changes since v8:
- Rebase

Changes since v7:
- Refactor in patch 1 to have a common helper for
  psp_device_get_locked_admin() and psp_device_get_locked()
- Take psd->lock in psp_assoc_device_get_locked() before
  psp_dev_check_access() in patch 2
- Use cmpxchg() for assoc_dev->psp_dev assignment when doing dev-assoc
  in patch 2
- Check for err for register_netdevice_notifier() in patch 3
- Call psp_attach_netdev_notifier() in pre_doit handler for dev-assoc to
  avoid releasing of psd->lock in patch 3

Changes since v6:
- Remove the unused remote_addr, nk_guest_addr and import cmd in patch 5

Changes since v5:
- Remove module_exit() in patch 3

Changes since v4:
- Address compilation warning in patch 3
- Removed the call to psp_nl_has_listeners_any_ns() and check listeners
  when looping through netns in psp_nl_notify_dev() in patch 2. This
  makes sure we only send notification to netns that has listeners.

Changes since v3:
- Make nsid optional for dev-assoc/dev-disassoc operation, and use
  the ns user is in when it's not specified. Also added a test for this.
- Fix psp_nl_notify_dev() to compute the correct nsid relative to the
  listener's netns.
- Only register the new netdev event for psp dev cleanup upon the first
  successful dev-assoc operation.
- Change the following in selftest:
  - Add CONFIG_NETKIT to driver/net's config
  - Fall back to NetDrvEpEnv and run basic test cases if NetDrvContEnv
    does not load
  - Use ksft_variants instead of psp_ip_ver_test_builder

Changes since v2:
- Change the newly added parameter to psp_device_get_and_lock() to
  admin in patch 1. Introduce 2 device check functions:
  - psp_device_get_locked_admin() for dev-set and key-rotate
  - psp_device_get_locked() for all other operations
  Flip the logic for checking the dev_assoc_list accordingly in patch 2.
- Move psp_nl_notify_dev() before removing the dev from assoc_dev_list
  in psp_nl_dev_disassoc_doit() and correct the typo in commit msg in
  patch 2.
- Remove the threading and subprocess and some comment updates in patch 5. 

Changes since v1:
- Update the first 4 patches to reflect the latest changes in
  https://lore.kernel.org/netdev/20260302053315.1919859-1-dw@davidwei.uk/
- Update patch 9 to add a param to NetDrvContEnv to control the loading
  of the tx forwarding bpf program

Wei Wang (10):
  psp: add admin/non-admin version of psp_device_get_locked
  psp: add new netlink cmd for dev-assoc and dev-disassoc
  psp: add a new netdev event for dev unregister
  selftests/net: psp: refactor test builders to use ksft_variants
  selftests/net: add _find_bpf_obj() to search hw/ for BPF objects
  selftests/net: rename _nk_host_ifname to nk_host_ifname
  selftests/net: psp: support PSP in NetDrvContEnv infrastructure
  selftests/net: psp: add dev-assoc data path test
  selftests/net: psp: add cross-namespace notification tests
  selftests/net: psp: add dev-get, no-nsid, and cleanup tests

 Documentation/netlink/specs/psp.yaml          |  73 ++-
 include/net/psp/types.h                       |  23 +
 include/uapi/linux/psp.h                      |  13 +
 net/psp/psp-nl-gen.c                          |  36 +-
 net/psp/psp-nl-gen.h                          |   7 +
 net/psp/psp.h                                 |   4 +-
 net/psp/psp_main.c                            |  97 +++-
 net/psp/psp_nl.c                              | 387 +++++++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../selftests/drivers/net/hw/nk_qlease.py     |   4 +-
 .../selftests/drivers/net/lib/py/env.py       |  50 ++-
 tools/testing/selftests/drivers/net/psp.py    | 423 ++++++++++++++++--
 12 files changed, 1041 insertions(+), 77 deletions(-)

-- 
2.52.0


