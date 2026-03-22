Return-Path: <netdev+bounces-270290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tXBmB/Jqv2lk4gMAu9opvQ
	(envelope-from <netdev+bounces-270290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:07:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A30C2E82CF
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B22300EF86
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 04:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050724BBEE;
	Sun, 22 Mar 2026 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2+VCuWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BCAEADC
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774152430; cv=none; b=FN6wTCmOImB8qVee88ZuVA7fe3u7qRFwtgglpKf41Y7pjflaowqeXiyuCgPkfAJbrIkCDmNMVfgvYYm6g8A0mSgaqUykNx3mjC7m3lOLXua4D4M/cfO9QfIXy8//KK45JSb6IgIPagB8izPdYdYoXsd+gTdPlZhJlDikR6Rq18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774152430; c=relaxed/simple;
	bh=6QKJ/o/UMoN6AFZHk538zgXfkaiJvw94BxEAWa+rpcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ai7iHaJPD4GO2BerVoORh9Bz5aAyj+tbdMDkhw8YvmXMsoGV3qhO9/yWAB96WjbhA/2hNjcxPU6z8OIfFUjIAMJNjUNLxdwWNckqmFBDQd6C/u6/bAWxoI6L0WU+AiRnB2tHlktTOFebjC4xH9nXt04YIXCNkMUs/rijMma6E0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2+VCuWu; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-797d6bde07fso1793087b3.2
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774152428; x=1774757228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoG+JaouqTi/pnddvyN5S5r5OtSSTJrktrk48CxQhG4=;
        b=C2+VCuWu+rKmIjNLHh0FDga72sKkdE228BDC/zlEHJ4NehhqU4sPpWD3RAOMU65VOP
         pW76arx8pkU92wzDJkXSP7lzgF9FC/HqO8RXJjwf818m0K8uaIXQzjxQITI08Uv09GfX
         g3gu+UuJbnsQ1qJZ4gB1n5Jo6z4VSuJvefLkn5PTvNE+vZQesIxdyJbtC5AeTqFCU+1l
         bV+FxMzNrVxGxvy/lQGTJu/o5zWCYQXtla0ir+jegjjaADzkSqasDDbY67yvw+UyScCT
         D4Zhlt+oVQ+unbjRi17nui5M00fnXzbFNYAw8TV8zF3Ercw+6HCPT1W8znuC71SRxv9X
         BrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774152428; x=1774757228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoG+JaouqTi/pnddvyN5S5r5OtSSTJrktrk48CxQhG4=;
        b=tSwur+5V0N10EgP/nTUnoTmLsZlh8mZu9iJro2m+yRhYU+NpH82OEjnHFyyOr4nJIr
         hCWnN8YrkKP/WrdLvZPUfFqQL3Cwra+/rafsVp8T9WbIsy/vhJY9igLefsCg9ZFKFr8w
         mS/QRttxZtR41iN/7obKnMnLDOxJ6ddo8ErW7LvMM12krA611G9aqNxLgL0FkKB9rjAf
         knksDCBL7dEuW4Vtcq9TsTR8zlitxLxwGETHRxHJFwJx9P2GRTWYkfn34LbD0YEsUYlq
         RvioaxEBddz7Hr0fh9WVKMUm5ErzEWy166yd8CqjH5E910Oc+q3NJNDZo+2FDHUoMgL0
         uy0A==
X-Gm-Message-State: AOJu0Yw1JBZjY9gekSDW4XoPUY4comWuSYRHtoqfr/GXqqFR/V5QhVxL
	rpn/5HMM5gr5GjWYfl7q9p0kcOBpINVv3tPsRy5viPRvcCb8NpJb07i3NwESInaF
X-Gm-Gg: ATEYQzyX1vbUXgJvktZJBvrqFy15aokmf5q6BlOdn+kb+Lu5cBkYYOE+QDguz7IrOu4
	X2x1BRT2Ld/6/pClisGHJR0M+OOle+1hsKoa0OBRhnuZqA0CpiX3JJNa40kqBK6gPAUEfXsnt6z
	owpQ7fOz6n3hFQb12k54IQehsm7q0w3TW2mXiHyM9+FKbRzFLh7cr7Z0FgCSg78KI0NVXb4JEIT
	M1nzynBwNX/aczCRXqCZkiEGQW8HcvxYuesHiG7WvsrTXsy5SdYVqU2my+Mx2IzBtcxsO9xzZaC
	t0U0Nl3+PJ1Z9wjUYkyv8e/XlinhC0YbjJ+H7LLMJoVN9e6cHfw6SeJbjOr2Yt6TmiUTOj6L+wF
	cu8F98gG5lEUMVetOVTEjwnzt34ywaLOVNb7tGSUjbQcrdnLcNRM8kCbuuUqjpZNnxUxhll78jx
	BQxmnEnH/G4AW1gRsiyCSaWUnWBa2T9c6UxA==
X-Received: by 2002:a05:690c:9688:b0:79a:6d99:b272 with SMTP id 00721157ae682-79a90c113aamr73527767b3.6.1774152428023;
        Sat, 21 Mar 2026 21:07:08 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabe7f88dsm4222402d50.13.2026.03.21.21.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 21:07:07 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v7 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Sat, 21 Mar 2026 21:06:46 -0700
Message-ID: <20260322040704.991766-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270290-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 6A30C2E82CF
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
 net/psp/psp-nl-gen.h                          |   4 +
 net/psp/psp.h                                 |   3 +-
 net/psp/psp_main.c                            |  96 +++-
 net/psp/psp_nl.c                              | 344 +++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  54 +-
 tools/testing/selftests/drivers/net/psp.py    | 492 ++++++++++++++++--
 12 files changed, 1131 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


