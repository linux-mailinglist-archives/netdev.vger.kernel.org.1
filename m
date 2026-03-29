Return-Path: <netdev+bounces-272852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FwCkHFSoyGmjoQUAu9opvQ
	(envelope-from <netdev+bounces-272852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 06:19:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8623509CC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 06:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDFBC3013B49
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 04:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B8487BE;
	Sun, 29 Mar 2026 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAiAq5Km"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192A611E
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 04:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774757967; cv=none; b=jpKlUfFh98fQsJwxwzIk9mOIlISF016goDfA+43ibMGGUjGkx4WCM04LYb1hqT1FtGfSbCPnUl9Ok+BKmKDHoqyUKvxlIdRGaBwCvGFXt5lG5OE1KqVYL7rJeZkjQOG/DjF3awfBT3/xN8OJpgzKk7bxFAqAvEuVn858f5Pa+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774757967; c=relaxed/simple;
	bh=UYMjBsaDPlg9vJ2VOvgt3CKGb7tcsWe3Y9ALyr55rtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sjPfkBnpj4TCUgiXJJ6HABegKtleZDDR2hkyE/rWsWABa/PCkGucBQkkCBt0O6RC8IzVZyF/owPBifofx0XijOKLF0nWbkE9XKcpPAhpNPwxrx/eW9hLqBv+DKJS4vrbgDUkoIhB2JSoKpxnLhmkQ6MlDGa1rPyC9Nk3UVG68Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAiAq5Km; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6470d549e10so432603d50.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774757964; x=1775362764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HQiX9mpxapi4T/wlYvB6G0UpNJk+qVsl0t8ml0QyMs=;
        b=hAiAq5KmZus4Uw6bmJqXwmFPP6+F6aq1wIAfTMpJTkQjI3cb8EfMqaYJrObbHxDfBs
         nhMf33xsUAu6Nzb2QMdDWZL1V9RoAo4Q3Pvd0eAOXbHV5ZMF8hZRSeZsP4gq0inmDqT0
         4htH/J+DoA6ksP4lrzW9gno+6sBZbJBwldSACvKrP20SSli+WUQH5ouK5voGmmDcNgc3
         wMTmjUB3EIpAT2Gws00+jaVlKy7ScHkCbr4vzq0UefII3izWollY/R+ovyjhf7aTB6/O
         11w+NczG/Kyr4y/jBRrEToLMBeuRGDOSTUG3SmYYcD/+u6t9d6l+WUH+tfoDQE6gr9Bq
         NeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774757964; x=1775362764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HQiX9mpxapi4T/wlYvB6G0UpNJk+qVsl0t8ml0QyMs=;
        b=C1YliW2wGxAQOxB3SbrMeGxQP2qPDu4wdS38+wBEsXpofu9M+Onia/gx3s5ztc1WLB
         wkmUbEOaRfKKdumW4raPzmAxK/0HvvwGyRmk9VaJqb5VCsHyHLMO3Bui/hsalKEdEIKN
         uKH3ZZIrxRbdO9glkcu3uALWD7KoRNDYGePSc40fT+/8bC/WufHfBhYmz9PeGM1jQHN9
         PtbbjwRV6ZrZ8uGvOW/Kt9K9WP7JMGPQ1JBDv5TcNvhDx0cul3gvpPj0o4ONPaUXrm+N
         qRYezs8pzOnXN7QHE9hq4JTYuRbz70Xdq4STEoRjIASoMhTa+xspDNRG6HSow4hBX6Bl
         aHog==
X-Gm-Message-State: AOJu0Yz9lYSpGNuDsEjO4tIRB+DCuPQ0A3dTolqrYKb8Jw/l9UmF5pBo
	LVVm55900dnQU9IlSFNw4MnZ6G/YoiKDHcnm2v9CWkWVKj9c1GmLXdD0u/PEATUa
X-Gm-Gg: ATEYQzzj4I0BJou9DoMlhLQ0OA+BOhaXYU/JO+/rrHXEhCE8p3fSlBR0cGQmnSd0bnf
	z2jQPlQ3tHls3s3ykBA0F5cnpVUw1YkDzkV04psfa39Q0VAPeFm+vDsIuOQwNuW6jqOytRO3oM9
	4nm92/VGiIEhTfi8bj01bHtmc7sqb0NYizxufnRGbIY7yI8SLGyluVp3EBo+TatMmxxKWmtrtqZ
	j9hycaJViHPuRHpPWY4KK0GCpEnkwTBLjyoOE9oGrQf7EoClIHxd0gXzkj2L9JC+6kF3MVKN3i4
	ZbYagT6qAazBVcOiltsNlwnxCWHR46zE3YmSFpCk19udMh9cE11XsYPN09Eb3GL39ltp46iPJL4
	Qi9FtaEhqPt6uHSAo6oA0FU8jdRX94n7CjE3Ks3pfu843IcOaxNZnjnZdiJbTTi/zdhTXDbzuL/
	98FaH1ff8uWyuS18ITJDgmXd4=
X-Received: by 2002:a05:690e:408a:b0:64c:a894:f701 with SMTP id 956f58d0204a3-64ff746149cmr6421328d50.7.1774757964370;
        Sat, 28 Mar 2026 21:19:24 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-650092059edsm1994128d50.3.2026.03.28.21.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:19:23 -0700 (PDT)
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
Subject: [PATCH v8 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Sat, 28 Mar 2026 21:19:16 -0700
Message-ID: <20260329041922.3850747-1-weibunny.kernel@gmail.com>
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
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272852-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.392];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 9C8623509CC
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


