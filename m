Return-Path: <netdev+bounces-276743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBdhE1Dh1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E23C4BB1
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E852300B592
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4037C906;
	Wed,  8 Apr 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm9pxzfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF3378D9A
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775690062; cv=none; b=SS26jQyJM+mtPz39veSWcNTx23PC6RCdfF2sDNSxrTxxyMMQsthTVgnqrmmd1CGdvst1qvrOli2NtrvXauGjx/QNtQ+lFFDiwKGWFscfcFByxtAkaUzo5jblrF50zbvu3Jyjx1q1650ZRKtTszDb4RgITq8Yiki22ZwkexSHSao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775690062; c=relaxed/simple;
	bh=4DI3UTKWXa45k7rBshGYEhy3rIJS3jWdTiqXInXk/7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D1S0443CG2wRIR8S+LWrsauaBc1nZG7ipncMKshcs5xLlzAwgcC3w21i96VVLAFyiQyFmm2QWOcVV5Wkef8iQqZcAxuKposfiGIcxt7GgnWrkUQh2dKORsXZuQul6DqCNyC3DDR10gtyZR+6jykgq1HLlY6j70KvikGTtnIQQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm9pxzfL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79cb99982c4so357667b3.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775690060; x=1776294860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kH4c94FA49c0TJy55eoQY3vUARS3b82OuNqc8fcj3KI=;
        b=dm9pxzfLO2x8fqYlVTirBbj2+VcY0NTYLObYM0yWRtfD+MYDj3kM0JOClrN7vnBqjM
         yg7KasQFlFv+l743SPbxGpcXEYr9Hu+SQWPLr5csV32I9DeEmWO+lJptZzPlFHbNHfJe
         BGTQTeU/ysh2RiyzCCi+H5YPmGm8XB7ZDGKtrtcLJBYQbivvWJKGzzl1/O06nbNzCBSX
         1mVkxCJVh5co5OmhmdT+EFnm0fhMZGGeGRjPCS3lzIWEBUsKLLyuOKNHVUchSXmkMcyY
         dKI/YN9AqCCaRb6pSo+KwrKnrGXNzIHiZl1Ub6/F+5t5hK8dYqdc9gyPWuVRFQMU2aa5
         wlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775690060; x=1776294860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH4c94FA49c0TJy55eoQY3vUARS3b82OuNqc8fcj3KI=;
        b=AA4Z1WOmvM89OZ9QdN+pqLI3C/eRBtifmI/xK/Xp3+32P+tG/GAEXkTqTyODfTU0kn
         RH4whk1yu8TRsPekK7B/1M+4Mtu/pAsLYz1QDv9Q+fXuSBbtfOZ7XTpLmzHDQpAe1pQX
         lgjauw5iIKJqw/f9BPAXbNvTV2d0XEF3dKLog+fiZBmH18fPAf100jACoFKMUgx5neiy
         xwkPm6Cy4ESrgI+KfTk9DvoetXtv4S4tfbJb6/g+wn0TZyr4gXFxprJtPmoh/wi+iTaO
         0fZcsc9k00JlePOE3lXv1BQD8MxvnFh8SCqBHrvlRn78Gi4/87mRow1rXnEWdQCclPGo
         XtPA==
X-Gm-Message-State: AOJu0YyGkPaB5onHlrSsje0zzfszCJPheVWfmDRWn1HUahT+gygIKiCU
	6jxfe0pVFCzaKgiGUkrp5ehpbcWzG2oZgsCKNacgeORsP3+AHT4K66/u18pFz7+1
X-Gm-Gg: AeBDiesskwIbrCKA8FZ6SN/91V7sDVwCH5Pn3VMpBPitfxY8YkiP7pGJIPYSbCDNyxE
	WgDclSYnHgLCyQJmgewr+NAnuaIYC11DjOzFrMeWKtqUDRquFIlDlH7ly/LcI8jUi2YjkZtnXVd
	KIS7GKL7JWPOwrfM4P/c9QM1ebnSe9SnH2TCaDpky6UzA3AHG1e264MlHTlUnJbqvd6IrjsFGn1
	DKjuuZDLcuZzCOoWN4Gg67nR89lIo08roq8oNNv+2DkZzvK96bxJ0MYvRsLLlj7LtwkwgMn0HPN
	jQiNGMDe4yJeKPp0YyGQJZOHl+zLJTVF4hsGRUg08kd5eClyLFt3LBbBishYyhDDaevBMwoPYsM
	4ncPl36Q7u7Jp4w2jnq1/rCdI57ZtbehMTbWWCJuGrRzYPCubEDTXcIfd49D5TL9fhBooJ/rI7I
	/xSfKD5iRyxCMU9kHHO+aU10k=
X-Received: by 2002:a05:690c:660f:b0:79a:649e:2686 with SMTP id 00721157ae682-7a4d5c5ace2mr138009047b3.5.1775690059488;
        Wed, 08 Apr 2026 16:14:19 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e320670sm90710897b3.2.2026.04.08.16.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:14:18 -0700 (PDT)
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
Subject: [PATCH v11 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Wed,  8 Apr 2026 16:14:09 -0700
Message-ID: <20260408231415.522691-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276743-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E24E23C4BB1
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
 include/net/psp/types.h                       |  15 +
 include/uapi/linux/psp.h                      |  13 +
 net/psp/psp-nl-gen.c                          |  36 +-
 net/psp/psp-nl-gen.h                          |   7 +
 net/psp/psp.h                                 |   3 +-
 net/psp/psp_main.c                            | 102 +++-
 net/psp/psp_nl.c                              | 374 +++++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  54 ++-
 tools/testing/selftests/drivers/net/psp.py    | 457 ++++++++++++++++--
 12 files changed, 1132 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


