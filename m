Return-Path: <netdev+bounces-267553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDZzEE5XtGlbmAAAu9opvQ
	(envelope-from <netdev+bounces-267553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:28:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF5F288BB7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898E6301E3ED
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6BB3DD528;
	Fri, 13 Mar 2026 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+4je4rl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC83CCFDF
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426495; cv=none; b=GdB3ML89vcqwmIE3reFFxVmNZRS6PHeIpNldHMn5KqSoXAZ7/P4w/DDC4y5dXd+X0lPNxtAFYOEdj5GDo6HwXYrKdWte7cRgJjYGocPKSI4inAZqE7S3AWQJ2NE9qBGJttSzI9uC02qmJPtQhy+/mskSSj07O8flBvxJcMKpCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426495; c=relaxed/simple;
	bh=3CjIp3swzP3/82xqRY2i6iQNJwGtqTqcznAwFIxaK8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T7mTkkMgtgr7Wsd06R/q4jvCNbAdF3YnwISuKva1idpaKIO8l89GuZL9tls/+MbYAkxeWnzg886ekxkCUVjCalcqQQplz0iASMdGyqcDjLmXVdRnQxfB28KbTKlreV72cs3bvE+g+06tKU1CMS8dLB6coXdmtYRd46REjf7gAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+4je4rl; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64c28495b3dso278745d50.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773426493; x=1774031293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yd1ogSKuUnIHlkYpBTpx9Vm9jbW8OTb/gVF2HdmYSdI=;
        b=m+4je4rlpvsAQX/3am29u+V2+FtnqRzl/3rPG9YVPuhU2I6IrqCuDRuDXkql3FCCAX
         dmPwMuposHrVJdOlg+2kQNDs4yxKcei7eYLlEMuH6vHmgAKrYTBDjzhtH0e8ScnCbOLr
         mhgIxNvtpZ1BR9Ulb1WkkRHJ2vR3GymQLTamJFl5F8x9MAR6iNf1LI3cByJkVKkHdrFz
         LoR+PKN0LdS5kkFsjCld4kK1nzBjn6aOmhEn5f99fLirJJ8n7wem0u62BdD0mq77444w
         8QHflTOtnEwZcRuEuiehEkwTDk0Gtymj2gnb4arCk6srRc9Sl6WIKDHqDjF44IqS7zWD
         CtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426493; x=1774031293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd1ogSKuUnIHlkYpBTpx9Vm9jbW8OTb/gVF2HdmYSdI=;
        b=HRwYny4my2oH2+xispNxE/xN/YKPX+58/XZAWnZQgwR0orUd55BZ6aaBHPVrltutZ/
         cPUJ3oQbInHvumGxa3UqO09sCBLZrI7mNlbpw1q/5BIlh43ZkcM+O27TF8xdp/tGChz/
         kcZgjO957NKbJxg09A5F5+1skdW5nsUQtbOs4kI8ZqTu35qwo5SCuZp8y/Vqx9lcWdII
         qyt1jXgR/cvyg4ATaMqmbQPqa30KzOecu72Abo8NUGo/lKeqXxXm8oT4UHHjWY/5/uTE
         3Xr2qkmP4E15/2/pYtmdd4coreFSrJ1I6R8+ZDumrTTjJMqRnoQSoIsBfXUOEKC36c69
         D53w==
X-Gm-Message-State: AOJu0Yy1hY/9RJ+yhHfqUnK47vyBDEXrT9hUgOYETVOj4IbRfhcH/1uw
	jquaU11/qQErGmrzsRgubxaxpToqv40V4dxtbg9rXV4dnjfBH3iAokOHhSGRRmRr
X-Gm-Gg: ATEYQzzsQ8HI6qSwXHyiGryrCXvHYj3omHTB6tgM+PDs3JVgT8uRVCFrJKpggJEeKM0
	KfMUUd3EAruw5ODTpvD0OqqY7nPwkOlvHHPlJJUTmp/Gpe0ocEExgc95GU3gfVdOiUnMyjTsXEx
	CGh8C4HRsoeqj8/Ee/j5VKka221hYjCXWJiN73wiYsLISrffzJ4ywBm/WSqRPk2vU1yGandLOEt
	ra3BEvZqFnj3IWKihchGa6hrMJ0KR0aKwd/TTj9GsJqz2vinK98UREqTSz7mEA9oFmvEpNEXXfk
	Ho4j8s9jL80rE2tAlrfiy1Z1igFHLQQSGNYWRZMtLede0TEhFwmgr09zV2992l/wEM7eHqQXa97
	Qg4wJBVW7gdB3PfM9t0o2kJ5r2CEnXHQuarhnKLJvBG8jJ0oOq6z/K97/PEEsA4hSdZC4KTa6fF
	ldgoiAnu54c3Weq6AdyYYCUKYm
X-Received: by 2002:a05:690c:6001:b0:79a:2535:a21d with SMTP id 00721157ae682-79a2535b14dmr20957657b3.7.1773426493440;
        Fri, 13 Mar 2026 11:28:13 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:10::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f37b98sm51946917b3.49.2026.03.13.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:28:12 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v5 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Fri, 13 Mar 2026 11:27:58 -0700
Message-ID: <20260313182804.696100-1-weibunny.kernel@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267553-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DF5F288BB7
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
 net/psp/psp-nl-gen.h                          |   4 +
 net/psp/psp.h                                 |   3 +-
 net/psp/psp_main.c                            | 104 +++-
 net/psp/psp_nl.c                              | 344 +++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  54 +-
 tools/testing/selftests/drivers/net/psp.py    | 500 ++++++++++++++++--
 12 files changed, 1145 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


