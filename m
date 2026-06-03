Return-Path: <netdev+bounces-294970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yw5FINPAIGo77gAAu9opvQ
	(envelope-from <netdev+bounces-294970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:03:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E063BF6F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:03:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=q5YsvVyn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294970-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294970-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92283080E68
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2684DD6C7;
	Wed,  3 Jun 2026 23:59:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E0392C20
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531192; cv=none; b=tMhr79g8qdksmle6L1ufUyKEqmljzL2S9TlUEiyZ1YOtGNjLRGPKoR4++ykxcOB4B5egY7vsF2l0W3xEDmx64CmPWZcDsofEaHLh8PqDWR1y7dMSJbLBqMR5se5v8NQnSRExIs622u7ApyF2w+Fn4PHmfViQueRgLOHHxTkfGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531192; c=relaxed/simple;
	bh=x0Dl1Wd2igQ9VpONxhyjqOketadJxHCKYKkWBsg8MCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o2LIGiZE+lFSNLhG/xQZnta4HQa9bkt7npERwdIJDqUvp/rCL+k5k1ZYSPIDANB7v+e9G9kg/uoT1SqV9F5csiZQabqqnUXvBGtsm5iR1SvLuSoNadYY7JNUuOs8eFScfT6zgP4Yp5v2CVoETRCSAP5MF0zJAf84wTUedegooGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5YsvVyn; arc=none smtp.client-ip=74.125.224.45
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66042b348a8so20659d50.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531190; x=1781135990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5o8glJ0q70pHtgll3hPt/3Ci8GhUb8O/mftl8gLADxs=;
        b=q5YsvVynOoE+rOCG6kM9M81mGg9cZ8YTjjT1W/PbotAmam7kbJ+MxdnfrT7sQ9//FL
         vCWb0WyLEBqlFzc0xs7LsuyQYPA8vx/n/PlaTy/UoxVrtIzJb2viIdrBS6DQvUuWYPmT
         nB3GKmLUiXpm4LEarQ8OBcExtT5uFOn70yn3k8gl6qjdcxa7PXiHqrbyep18mzuTBZuY
         DvU20+K8GoY+vBvJh3SNAmcNccAfuKcsFJvnyqsqJjEQNXtCQHuVeAgh6Bej2VRPF2Zw
         Cz38dfcXpdEFhF1MgsoUs9AUawDzusNZQpa4UXxuwzu3XfKPS4y38G2HEQ3wfWB8BFgs
         J2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531190; x=1781135990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o8glJ0q70pHtgll3hPt/3Ci8GhUb8O/mftl8gLADxs=;
        b=HteIhIAN3BWFfPM7Pxnc2iBtKssW0+IH4cfA2KRyyb2vLa3wtTB3QAJaztPONcMHhk
         Ti2EIx1D7WxyeYmlYSp9GooBSp3MCmA3cDOG9cisgdIxvxalLCMnzbFEKGm3zcitt/Cu
         jmhEKH9b2/sKvxJRen0AFFrfgsJNMEBQ4r5ogLxIpUrgIOGS4+4djEr+wNZFO1lyOzGz
         POszoP4t+PnvKVni7NrNHvNmFZp8Z8tR41t0EzF1yLnZONUgDV85jL9lYXlpDheJ2dHF
         6baaa7xhV0jtAfGV/o+p2Q9HXGq/TpzYUdE63Va7fwWniJsqvdr/1T2BpMRyCJsvGvSG
         mQEA==
X-Gm-Message-State: AOJu0Yxe0aItcGoW9rNRBPy4clOCQDDXToJH7BiJH5I0qIkLsgbYiSEz
	P4RxQjkv+N4gG419vUy9MrPDqjDz9+bCBxjKd6fO+KE3sSIIzOXB0ARpMiTUTQ==
X-Gm-Gg: Acq92OEPA/n29QwpcHGv6l9AoJIOF3xwxbPrrCrAqWeYsXWx0zY1lV4ej/Ln/8KLg72
	Kk4WIqBDEyC9GIW+7NsWUzbG+QReeNYoSaYZvVlDxro1Ls8341RX3o3zbYWU3kYDqDPlrtGnkM4
	qdsSuCKcD+79C7lpBDduVZzc9mC2Yh/BlE731jy/CC8VWSQoSY3MtZkgZiQyhLV8EQe/NPA9wOm
	7dVLxKwsN3FElUL32a2URIbDeT+3F4mbk5X9Bu8Nmy9B4FgBU7L+BfC6RSvu/yJ18QR/x37c8gY
	bp6v89ZuhlfApV31nmLhmsN5k5cRXg57VaHtnbrv3hcLmznNOM+AEucxLXvhB+RE486iI/SyDyw
	gDMlM6a7tFCzYa+L5KDUaOEkTkbXmv2OqdwCR0HdvuyMzxBgH6nZNSCo/3EHlRc/w6dnPw2bCXg
	CDiq96mVcLVSexs9nQxa2B1qBvWk7l7ye2iA==
X-Received: by 2002:a05:690c:3489:b0:7e2:a956:4078 with SMTP id 00721157ae682-7ea2fac8a5emr35714427b3.4.1780531189775;
        Wed, 03 Jun 2026 16:59:49 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea819esm25605227b3.10.2026.06.03.16.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:49 -0700 (PDT)
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
Subject: [PATCH v15 net-next 00/11] psp: Add support for dev-assoc/disassoc
Date: Wed,  3 Jun 2026 16:59:29 -0700
Message-ID: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-294970-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E41E063BF6F

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
 .../selftests/drivers/net/lib/py/env.py       |  54 ++-
 tools/testing/selftests/drivers/net/psp.py    | 423 ++++++++++++++++--
 12 files changed, 1043 insertions(+), 79 deletions(-)

-- 
2.52.0


