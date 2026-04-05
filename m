Return-Path: <netdev+bounces-275440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S5AxAyv60WkeSAcAu9opvQ
	(envelope-from <netdev+bounces-275440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 022FC39D78A
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11C223003728
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C3367F3A;
	Sun,  5 Apr 2026 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4SIX1PD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D1156661
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368738; cv=none; b=oAggqgOty3o2OlGnX/TvuuovY68NinzCa2bEyUP8qrRVzLFq+TgAX9tWvdcpOItTw0vSI/BTRIgjuCXKhMH/zv7GK/78M284CDOaForyByNrCXGNbj9LGQ5SEW23FG8reAA38hBlpxEpKR2p/sQqCcqsxnIpXtC8hGLWL/HEl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368738; c=relaxed/simple;
	bh=lT/bRLlRJz2TXBwRf8tmyCchxDMHIq6OT8qVPtA0uJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQ/G+5MupOAasX9gQZuX8ruM9ooXT+ng1GrT4mrv88P9hRMIFAVmOOTxIwposgazwlcKX2YUF9+8iZRkhMhD/Wx4TH9BLdp9gQWL9+BI/40UxJw/zpQHbKIfq/wnmr86FVYNuUKc/xDBEY/60hxUVtbpv5cyCvrAe1gUMHyMQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4SIX1PD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79c28eb73d3so2544887b3.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368736; x=1775973536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptPDoCMW146kcg5edeNG1cmnxOkXaU3uM4gkuh/sCHQ=;
        b=F4SIX1PDKCGsgfk0bFcNatZp9o1mmPELho+W5Sm0vEo33CYkSzrdIpdpyoOJERe55N
         85oFSRvuhTdlY5yhLycKGAiyEf/Op5ndhMnPZaVJfnEKFZ+ByDB1j7XjcoqUbf9VsUAH
         OTvDblvAj4KE4r+2ffJ6FcJ2fYVyB5jbD5Qj6NUq3P2BdfjSk6ymZzw+JCOkfnbkVZiV
         FLEst03ZyDUyaDt5wq+R1F9tg58HuIU2pa1BKwcPbBUqdvPlaEsK1KuDsBVpg9076Kx5
         aSoVVeIZaUbxIYo1WstgLBHN/2FYtA5CuLEisezsdXZuM0A8nxAgGa4h2ANjYaY0Tlsk
         8vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368736; x=1775973536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptPDoCMW146kcg5edeNG1cmnxOkXaU3uM4gkuh/sCHQ=;
        b=Q7nuw9ALP0i9pNq0kbafd1D1GJ4KjtsQ8HEdvJ4wF0cil7j+9tflSsSyPojGSz6DOL
         bnS+dOxbv500ahS83WQtKErCpPxVCPO+8sUKwRCimrpz8O8ogQRw6KKsFyjabC56dP3k
         wY7z1OkP7HyklAXs67vNTiBrEFmoOiI3SPUPHbJsFAyBFgMblbjwP5TqRHVbKOaZF25t
         Z9v0POl6kSgJFkmFAzsfEMuyqpVplk8PPJEuyy6FhRLHsVQI5cizGKRseKwbeaL+Zxti
         bAUt+2Ail5t9PiGOBEgd2vBr9YHkYZxjDnHU2chjukirPLIkYhY3RKDFPRImPp5RTdBR
         OvuQ==
X-Gm-Message-State: AOJu0YzQamJ/uCqilhOfTNYOqmpFbNhfEqJWvC7o0gfWUzCF/0RvNIFn
	I4MwAzMRVtmgeMQPgpFvfNWdnkHyBSlFMt7EVxSri99KQqDm0FCS6+DAROzA1cjA
X-Gm-Gg: AeBDiesFXE27HLCp23u97dPp2zR4Bhz7aqnqGUj/UnqnUITq7m6tEQ6B4T/pAhSW8oe
	qAht5l7+O5dF1MHoqJwSU+JG07qnsO8f5LbkbXzvdaBi1tDBwLHFhbWASoFKlYE0eaDyFEckO3O
	uleJXtIyCF5LDr1G8cPfg5POTbz7SaYA7w72WIQ1WRuVKORyx3M4/NdLxEXbPjj3B/+JS3y0XN6
	cc1B9lLDDCS/A/s574s7FIeb0R8cRwiaViX+FEPOZWUi4TO5v1W2EYQRGFS7flDsZY3chHhgmiJ
	S1uRXBYoVNByRl1f4qICfhNro4TVAz2sXRRuI0TJVYsidiEcn90esNkZ9+lH/wdeN5OJI05Cw8w
	ROMX7DpGVPzN1Ckea539FqztIL6fTfTeR9UGVocJ1MKLW/+ppSNPdKCfsNnF1dBlrFKh6A5fIS1
	SNrx9K09Rk9VNTUJXPUO87l3Vw
X-Received: by 2002:a05:690c:488a:b0:79f:99be:1587 with SMTP id 00721157ae682-7a4d65444bbmr60931147b3.7.1775368735814;
        Sat, 04 Apr 2026 22:58:55 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36b55266asm39261977b3.0.2026.04.04.22.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:58:55 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v10 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Sat,  4 Apr 2026 22:58:47 -0700
Message-ID: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 022FC39D78A
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
 include/net/psp/types.h                       |  15 +
 include/uapi/linux/psp.h                      |  13 +
 net/psp/psp-nl-gen.c                          |  36 +-
 net/psp/psp-nl-gen.h                          |   7 +
 net/psp/psp.h                                 |   3 +-
 net/psp/psp_main.c                            | 101 +++-
 net/psp/psp_nl.c                              | 368 +++++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  54 ++-
 tools/testing/selftests/drivers/net/psp.py    | 457 ++++++++++++++++--
 12 files changed, 1126 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


