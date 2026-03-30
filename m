Return-Path: <netdev+bounces-273345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kExIDSf6ymmlBwYAu9opvQ
	(envelope-from <netdev+bounces-273345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:33:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88EC361FB3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 812EF30158B0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECF33E51D1;
	Mon, 30 Mar 2026 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iENqiaZs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D23E3D97
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909919; cv=none; b=sFUtvaT1+Ckpl1M4pH04XEjWBdBNi8ZLMJTreWouUIXWY0pHYWVWNOqK8eLI4F5Ejs9iM2KUfeRLmyX6bQpbxJfJrEh+Dg3f7kmwwKIIXErX1Gwr/nxOGQ/bZn3AGKSdqvLFq5EYamjYBjk4jBFUteNdJiEmSvDY3WQ9WkJgyaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909919; c=relaxed/simple;
	bh=ogmjq7j7ONtwTNFDK4k/BdUy3S21dECtMtd895mKFwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AUwsxmCs3qKmL3w1pBYDxkoiEPBX4PM0ifnUkU5XLlnoHEFYUEFfmIDzI763b7Aw0uK2+CslJrzhoNznKUiRR+LILMVTNSIHRk4rJ6WssLwMCACgbXdwinI12SATx16y5FFCChAbQSKAvFwVlzYoOaYYmtRaI6gluFWrlVXnTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iENqiaZs; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ebdab2ecfso815019d50.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909906; x=1775514706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Whfp35kYmokvW3Wj9XuMp1wsSApX3rYZTNeFJTm+bMI=;
        b=iENqiaZsNkSWVDDQjtWnaZiTh6+qH3ViQwHwT/6QvX7FfKCEu3I4Qqf7WKUbc1Gfqx
         cPiiJxitq59JcX6Pwpy6644DzQq+Xja+WJL3yRb0OUQ3zArcgTVw3qgrDqp6t5IN9JMZ
         xJmfJladQixT7CBHHFmlDw5FiFdLOGfOnknXUla7IYczXyYQXmHyE6nU1MICZA+BgbAR
         B0zPgG889kKlvbbu9puoBxqe+X9YU8ahFfWxPePIY0yHKfIvtZ9lAnKizqms9r+se52j
         y3h0s06jWKIp+XOUPwXb5Me4kaMK8U5yXFtD4oajGICG5rHfdycQD8eYtVGH3MBnVDI8
         snEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909906; x=1775514706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Whfp35kYmokvW3Wj9XuMp1wsSApX3rYZTNeFJTm+bMI=;
        b=RuDinG1OYKEzy1/wP4HUfRXGGyZiCa7LJs4E0CuzDhxlE1W5JvfAEJI1kRPJqkCLp+
         QyUgUF9pxADVjsUDyMIaRhkBYJn+cnYFIaWkCw6TMqe0hc86hBbUM7v73LDMHiv82INB
         N1ZvGC2et/tQHtQD7nmkwEI/CzSMIq1KFBaRQqW6iZYyY8Ssgz++XRiCUNji0kS4oiYN
         OsSXlK37LC/7+R/4uav5Lr88R2Sacz38WhTzQ0hB8f4l74J6YO2frEnsspdHFHG9sMdh
         Ad499uwN9caC11aVlje5FgwcnW/2YvK5YY7nGFCNG5yE3wB4cQShjMmc7keq7g8WKwf1
         NPnw==
X-Gm-Message-State: AOJu0YzeStD1iGJx75H+6GjLFNtHGP5bsBufFiExOS5uvqeQlhU6sNEp
	3w/WyzFiVKI57Gj3RPf1iYBjGiO/6l5JBNaKw9O9EBVuHX8uDGwRz1lRHK6KbwTl
X-Gm-Gg: ATEYQzyh8KYZ1rpheMgJWGdwPnKArHV6r5dr3Xv4KkGbtxoYVjlcXrK2TLG6oQD9cZF
	HuJr0EjSwrpX6+aQh+OFQOHsl1zWtqnhbWQU4vc9EFuRQX+g2CRrf02VUS4YcJsX00YbkrCF7Ga
	8eIaK6hmjdRexFwdZxrZXgB6TftgAdlgFrdHcH8uty/WzchyUII5/57DR0RtWdbvjEpwAkL/FmI
	xEyKe2hl6OyPlXHXOChjbb4S17oUTV8q+b22yfiwldCKCCjWriNTLmiSqZhHePOekdHILbW0Ig6
	TwYR4KNlPLUJeoQi2LafiWm0jM24K9I+7oBjagHYaUPZbNflTc3zCmNR3OVLxtGX4ruBwpW+Kdj
	XSK+onWzkKCOejCE+XNEqWi4f8ngaPbZMSCtXu5dw62FKrzL9UN/ZtAsjjj23yx8yv4MYndnAWu
	2XOUczG6PJfniGBSQo6Cmym/H5
X-Received: by 2002:a05:690c:688e:b0:79e:631e:67b with SMTP id 00721157ae682-79e631e1b3bmr50517307b3.4.1774909906417;
        Mon, 30 Mar 2026 15:31:46 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb4521761sm42182687b3.0.2026.03.30.15.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:31:46 -0700 (PDT)
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
Subject: [PATCH v9 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Mon, 30 Mar 2026 15:31:37 -0700
Message-ID: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273345-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.696];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A88EC361FB3
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
 net/psp/psp_main.c                            |  96 +++-
 net/psp/psp_nl.c                              | 352 ++++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  54 +-
 tools/testing/selftests/drivers/net/psp.py    | 492 ++++++++++++++++--
 12 files changed, 1140 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


