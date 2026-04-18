Return-Path: <netdev+bounces-279526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMUQBNe442kiKQEAu9opvQ
	(envelope-from <netdev+bounces-279526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:01:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B80421B78
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F703301700F
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD12DCF61;
	Sat, 18 Apr 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxuI4WZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D69443
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531668; cv=none; b=K/lY6NIbCoXTkndLa5sQbbVMhXNWzj/8r+piBEv6WyWT9VFbPnoBF1nOetXe1MokR/uqt8XdW54gllUHVY/GApxuUQfiW44vYTfxOyP730OAHKZPBdzMLTjVfSj0NOKfnvR0P82lhdjGnWZR5NQ2guOIzEVEoXOPChjI/fPQWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531668; c=relaxed/simple;
	bh=wOpQ/+jocGU6jNgqw7WU3Mj/H3Bj5a+SwQC52Z1uaoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rf1ZRZz+Z14hG9azTSP9ztkBikwXQmuFQlli8q80Y9rPavEb5fIMADe2f3axAsuNGBY9dB2vHPHC7BNptVM9KdO5u0QHlIiR1ZYwB6EDZ92X19cBdyj5Q57bi3UzvnfJmfeWQu8LwM6812GlCLUUioTN/vocCk95me7RQb6WTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxuI4WZw; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651b8d1830bso225437d50.0
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776531666; x=1777136466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K261C4A4/PxWqopuaOPxWYQl2DmGrlkrxdmGFZiUhs4=;
        b=GxuI4WZwePlgy2noO240aiMH37v6ofYLFmESsEgR+oBdaQJ3spcFM6iEJ5Qo97UYpP
         mf2bpbEeGnv+es0ojTqN7Y3XYOEaBMeeV2ArRqy6B+RZUFxHt7VrASuLb/UmqZjTqIC/
         ROI6QNT8m9lmRzDXIXbXa63uP8uADMWohnl9w8CdIqP036XKSGVhOm99rui16xJkliOy
         tGMxH92jd3l2WFSSV37GgSmiRMH1vbkeSRidkuMQ6cBE/WLnPAcxdKMQwhyiUmeUrH+3
         jRjk69Nv2TF1TD5Uuvr2k/4jaOi8LLPhYKZ5RilEMBncIyqSUyMKVf1ociHn97GZxh/+
         8TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776531666; x=1777136466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K261C4A4/PxWqopuaOPxWYQl2DmGrlkrxdmGFZiUhs4=;
        b=ksF+w7CU7srDUBk4YQK45YHHLNhqJlWlPnTQCmobRpDetgiKI2Hf/WIf7OYfTbDPOV
         4PHuWBcUtaaXovNMD1jtCts5YZHXsNpjV89zez4ITt/vluJlaJpwKEc4VZAguYtKsXdC
         EEd/H5mjHrwCL4WsRD6ITFRnXA/3uj1aznna0REhLWBNNi1TiWMZ7fVdgKyedofRvwI1
         jxYJxuc8DBa+NjOlxuJCdejGzn5A3LlC6J7xXVjw1fR8TlK0vPM9BOuaZQ1dv+YgmP4b
         w/2C3kAnKpM43ux/edKwU7f2Zjnwv3yf/qpUEpnvK9tspOVnGs0f4/CzHiSPWCh6rCHT
         nhqw==
X-Gm-Message-State: AOJu0Ywr6cnuOUSZ5+4RgBuo0DGSxzjWHLgqRpOE7IohHfJIEJ8xnwJz
	Kmd+TK8rxqY3AUCl7h7QLLWiIQOWZaqazS7L42x7UerfiyICwwZ9rrzhGuh+dA==
X-Gm-Gg: AeBDieulwpXROx4XM/HcQwmkMAu4I15SF7g9kv1lFcJO8Spfp8ZP+hgwi6jenTMcBR5
	n78QlOXFGsHEaySng2Uhj63J4MQOiJdEVR8zBFA5zwErw3eqMq6rhVTZ2QatHFeUiKXkDzUTCD0
	sve8NkWrWQAatmQy4psws2g0EMyuLbrNcq5Uk9oPzJzdLF0rrDGiwxJ/24uvxVHpKrLm879NKgM
	N0n7LdHNeiryAbu+KrwQ+ZL9YP0WNlrZzS2ReCUMVZQbp/nF5shAhaaTzPUfkz/cPclwafmUgXo
	07nY3wXOJ1k9TONaA7PzT43op43fPc9On9letjrc5LUt1Q3VriINYlixuf2pFrVQv9KkhjnyT8S
	Cj+gLfQfZZXhY/Amwz0eZEMG8dS8QNSdkMpIL54mnRjF91xI7VufmXEF1VUQMAvoDBkuZq2582c
	tXqUQArRRCD5J+KESmGCdtt+ErZu5oWMyQhh7m/bhTe3JD
X-Received: by 2002:a05:690c:6505:b0:79a:c473:ca05 with SMTP id 00721157ae682-7b9ecfc6ecbmr51365847b3.2.1776531664208;
        Sat, 18 Apr 2026 10:01:04 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99b88bsm21182637b3.31.2026.04.18.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:01:03 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v12 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Sat, 18 Apr 2026 10:00:50 -0700
Message-ID: <20260418170056.3490525-1-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.979];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86B80421B78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
  selftest/net: psp: Add test for dev-assoc/disassoc

 Documentation/netlink/specs/psp.yaml          |  71 ++-
 include/net/psp/types.h                       |  23 +
 include/uapi/linux/psp.h                      |  13 +
 net/psp/psp-nl-gen.c                          |  36 +-
 net/psp/psp-nl-gen.h                          |   7 +
 net/psp/psp.h                                 |   3 +-
 net/psp/psp_main.c                            | 104 +++-
 net/psp/psp_nl.c                              | 402 ++++++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  54 ++-
 tools/testing/selftests/drivers/net/psp.py    | 457 ++++++++++++++++--
 12 files changed, 1170 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


