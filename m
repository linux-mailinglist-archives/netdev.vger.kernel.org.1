Return-Path: <netdev+bounces-285617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K9cNutl/WksdAAAu9opvQ
	(envelope-from <netdev+bounces-285617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:26:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 863834F17FD
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F16453004D22
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D23254A5;
	Fri,  8 May 2026 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVb32eW8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6014F70
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214377; cv=none; b=ZXR9lQM+d/JsS9w5TCJ3S6tcnoACzixvXX2C/8HehnE2ncdwc9Xt3EyjJ3ZtahZ0px5W2w2xIpX4eVd1vZROacyBuxmiARoyiGbcl/iIbjbh2CMqv08uygou1BJu0pbSNSjgYzQ8/+ZBy5p+ixM6kV27JEU+4tEiXcXaTJkBiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214377; c=relaxed/simple;
	bh=aaSHgCMQLohi4sTq0My9B5Wa6nItpt+kgA3B/jP+lKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NFmGvQvgtWEp07QDNXV7bTiOc7emBw05swmus7G1OmJJyJHXJ1Cy0Rr/GdgQtI8UvqTaHHz0PegiiBgagDOsMe8y7lqcRXc3JFYG1nsADC5doU/zAXa3hx+e3K25eGStp2plsZkRTiXFxJ38gl+l6yfR6c8iN9Y/wF+R9rj/HEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVb32eW8; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65c83b7e2deso189340d50.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 21:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778214375; x=1778819175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IuDPPHgRrI0xOu1LJOWYLSVywx4ixE00BXI1Fan9Bhk=;
        b=TVb32eW8TMOTcCySSKPJ5z+hq7694xgiYVUdig3jfzKnsPl0HQt1TBJPKcNK8at9x4
         WUvUIQvAmZa+dnLXYtNjwA6COZpXAMWvtJ0Dou/d/BfVbvwcwA8gTlMqxVh+Zfng9022
         tfIu5Bu6UnK5+P8E8/j7aAN8lQr+3sfeeD9wLmcB2bFBMvIp/sKbKuXu7un+uxJ4sNNe
         0LPIs3auLGPE0lhGihdWKXFwxZGNMBxaTDNQ6YSsV+bBjfcoeaxyUgDI5hBJlXQh91bc
         28vjaBEzvWn8F6qPjtp9JKH9A4RAY84jJNWhPZhwM1FMMF9Sqfqn++xJCI2tMQiqIfs8
         BNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778214375; x=1778819175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuDPPHgRrI0xOu1LJOWYLSVywx4ixE00BXI1Fan9Bhk=;
        b=tNwsckiKLBtmo2/JK7AFRe/eQMEUnMwAnbX3lIBW/cQNXhyflfiffBemXVI4Nff2SW
         XYbDArkeblfUPKeB80wdNB41j5PsddY7AJBGbpM8xWqhdt+xX3ag2hRvtfD3JlTo/Yc6
         VDeVp4XuisMYkoZhEFP87DmDBF9kY7B8kx6kljCGVs2XLWrsxq52j4SyPx5SyGcj3dWY
         Kcjc+Kxakvw7qjPPn+GlKPwHTONhO6b0onRu3x/glGmrQuUhlKXsNraBXrak2j7GsyRc
         Q1Jk5pxNseq1sV9CyAP+q2y/H6UoumMRIz8xGrYzVtG6m8BA6dbB9xuK9erSwX4gXh98
         N64A==
X-Gm-Message-State: AOJu0Yyg5lxcnCnqKWZ2fWLD+TlQoI7wCCIBRTefWv68MRIZyTXKfTqk
	2ukFHEfXZqXCTaObqTQz2fFEPnjliG2G/IzE7wDUL10FUOjjLFiiU6YhFcYuLQ==
X-Gm-Gg: Acq92OFhJfcngkTcDT7SktTpk9jqF9Y8vrOBD6Dc+xn97sqMWfjhMVbuz8xweEpbNem
	Aygx03S43rNG+YbjY5QV/1D4/CqE2JseFEtROmKyGRORxSD9CxFwH8kULiOz7NwFNYafZanRUuA
	+dRu4icuv3bJCMCfxTEATNwqJqOoDbS27Gc6N/m80NJx0tgYKcoEjORD0spbHXtJFjSLwaskHVc
	kNg90G5COE0PpVe6D4Gxl6Khq5IUHJ6GyMmR3EGMJ2rXMCny+AvGfyfwisfEBNIiYtYGiG/P3hC
	6X1vCLprW69ZNKVmszkoe5nQL0euvqAF1JOk5nuunTaggvkEbiavd8Yk30o14kjish63+0DsWyv
	SPAs02bYzIOVO/9TqZ34RZysCGTZ3QNAdPipmShmPAMRDbqNz3RyJFNLAjmSzdQVHxWa0agt1rc
	4pgPKfV3E7wYkifB2Tw87IhiYg
X-Received: by 2002:a05:690c:281:b0:79c:adbd:4f15 with SMTP id 00721157ae682-7bdf7c08a81mr69358267b3.2.1778214374810;
        Thu, 07 May 2026 21:26:14 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66896b35sm100518147b3.47.2026.05.07.21.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 21:26:14 -0700 (PDT)
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
Subject: [PATCH v14 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Thu,  7 May 2026 21:26:05 -0700
Message-ID: <20260508042611.130945-1-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 863834F17FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285617-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Action: no action

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

Wei Wang (5):
  psp: add admin/non-admin version of psp_device_get_locked
  psp: add new netlink cmd for dev-assoc and dev-disassoc
  psp: add a new netdev event for dev unregister
  selftests/net: Add bpf skb forwarding program
  selftests/net: psp: Add test for dev-assoc/disassoc

 Documentation/netlink/specs/psp.yaml          |  73 ++-
 include/net/psp/types.h                       |  23 +
 include/uapi/linux/psp.h                      |  13 +
 net/psp/psp-nl-gen.c                          |  36 +-
 net/psp/psp-nl-gen.h                          |   7 +
 net/psp/psp.h                                 |   3 +-
 net/psp/psp_main.c                            | 105 ++++-
 net/psp/psp_nl.c                              | 401 +++++++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  69 ++-
 tools/testing/selftests/drivers/net/psp.py    | 435 ++++++++++++++++--
 12 files changed, 1163 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


