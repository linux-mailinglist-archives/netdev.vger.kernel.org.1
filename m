Return-Path: <netdev+bounces-283260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W0K0ISLp9GnpFgIAu9opvQ
	(envelope-from <netdev+bounces-283260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22DC4AEA7B
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040E3300F9E1
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258FD2BDC32;
	Fri,  1 May 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRR+PhUb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B09463
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658143; cv=none; b=ABuoqxrawj75vJqMwYp4TZK7qqwXKj1CzINSFldX1W7Qvxphdfece0o9Da1gIeQQG3Sj57v7OXybiKz22UySAlPFU/6lCvdadlV91J39RK3RYrEzzdW4GRRNq/0095+XROkY04JGyFMW/3S5/oW5ZCaTqdtsZuAoqFSsugNM7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658143; c=relaxed/simple;
	bh=wOpQ/+jocGU6jNgqw7WU3Mj/H3Bj5a+SwQC52Z1uaoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdKm1yGk7jPLWR6DzBrDKrs6pFPdulTsv03b2xmisxz0kEURvGr2WeXd9mJSnSUHu8l5Zi50vhXT7+GC8o2eCzXzW4rnv+Enb3HpuT+M6ipw2yj7o8iMx2/duw1pWGvTxn7H86CC82AkxNAUeDt+IVIgG5szjUxsoyddosV2LqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRR+PhUb; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6543c251311so214935d50.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777658140; x=1778262940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K261C4A4/PxWqopuaOPxWYQl2DmGrlkrxdmGFZiUhs4=;
        b=sRR+PhUbyNx1qaCU3xn1ZPfAV5LOsanWcsWdX9X8IrPP/9QegeA0FuhrfuB2tGP/JH
         TY5MWPHPuGzMj7ZTlJ5ZtQ/hb7AEWFx0HKPi+m5Ka7ol1NIjwtHCgUiJWGL1FqLJKcA8
         OXMMFefJjyGIgcX+3zpDMhLG5R3cjleFEgHEKBy3Qf5fi5kAlrgsj9y+7jw1ojOkrl9M
         JJtyI5BqkG31QC+7MPZMRGQEEkqfy75Lm1hgc6Lb8y0HnlofIcqwFLntRlooNwtrQGVk
         4KsCdocfdQ7VFxFAANB+l0cjCZrCtdrXewt4WB7JTxv6HhMmCaHvjKR0GKGxw/53KQpN
         WQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777658140; x=1778262940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K261C4A4/PxWqopuaOPxWYQl2DmGrlkrxdmGFZiUhs4=;
        b=OaW5uLluIkMpRYhDrkxpYwg0JFscphdTS0OXT/cEYHg0cIwahBCS80oliwwbA81gmg
         2ETIj+4JAEMKx2sI7vRgWYHX4puHw7tL+PbFCkB+dDrb+ty0iYWwL4o/VfreUjyc9R/e
         n/e96/lWCYDEdAlQVQbnhTpXnebclHCdNcsQrwEHHRA3dW5ztZCcv2/BxGjTpMFF2ab5
         FMsyyPIhwHGvRrlJhXGPXoR+9wxMVlEpYVhf1zDNAy7JHuuloDSWloWHI8Abl2E46HxL
         zlZqG+d/TV1hNlDp0Y7EVCGh7eqnKm11j6DWCLlwsgn5KCeCwrHTqKrxsQLdmySUR0v9
         8mMg==
X-Gm-Message-State: AOJu0Yxz1R9CyDXNnRytEzQRWnPP7DWlsYkAg8w4mohuIqeszHVy35f2
	kyOxrd4UY3bnjvQEQAnbGm90kYAandoKqiJMnuWu6UrkQzXx8YtO9LPNtQyfbg==
X-Gm-Gg: AeBDiesSwFm2dpvacjv+kD1Wo5tFqND3JYXICE/GQaKNWepzp93VN28zLfFjOS81aGp
	0O/t+4w/0o5Bo7fT31vMF0tHGsqTpcsMQ3c5Ke/D3Angq0Epa6lrIQ4lKdiLaXKkJt3VIEnvdIa
	19VwTvVMBM3OdPZwwqjEMDU7s+R8EIBxLiGaXPLTUsyC34F/jLRJ8fGvQqvK20Q8shhY49gF/tW
	6JpatsTaO91qjRehpNJbdnYEfzr109aowcsUck0L5ofvgbgNtXbeYSmEyxoBrACc2BmMS8tgI1H
	y7lUBMpLyE+FMes1NWFuGRe6iWRo/TPWibJhOP1VGyIoqWP705reOW+KXRwoLZGBGjaOSyiBy7u
	9fXlZeyngzqOoQ0jGNRmAXOVQanso9UIxGX2C4mca2S9Soa+y6mzgmjY0FBKMscnsYtsyRR7SE0
	gfF9H78NfD7U5Uimxy0wwD79450O+e4sVsv+s=
X-Received: by 2002:a05:690c:4882:b0:7ba:d65b:af0a with SMTP id 00721157ae682-7bd770e4e9emr2871887b3.5.1777658140096;
        Fri, 01 May 2026 10:55:40 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm14161087b3.11.2026.05.01.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:55:39 -0700 (PDT)
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
Date: Fri,  1 May 2026 10:55:22 -0700
Message-ID: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D22DC4AEA7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283260-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


