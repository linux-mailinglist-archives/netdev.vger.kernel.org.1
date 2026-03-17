Return-Path: <netdev+bounces-268824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dd5OCD/puWkRPgIAu9opvQ
	(envelope-from <netdev+bounces-268824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:52:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8514A2B4785
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF6A3301302A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E9B37418F;
	Tue, 17 Mar 2026 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3Wd6p8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC418872A
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791548; cv=none; b=e9XGXeTy7CYUgtpMHx1eEt2YzVAcOVhUSgGncDax0HJ6WppSjau+TSJZDWtFh5B5EG6wtzjKw92AVp5TXVyIxzV4RCvbL7NfWQSRNxM22FSRk8X2/Vi9N76kPeDzeGYfXSiSxIIK4WeIU+T/nWH6OeCozTixXhBnzwhlV46/mtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791548; c=relaxed/simple;
	bh=6UUzTZ/tEH4rQ243U90hoXz+8svIm2ZMsTTWgOYCPpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3ExtwSVg9N0ny1SNrXpt0iiLt+5JPddZHYEuD9zSOnnRgNKEOPfDoJrrv1PGEqDrHslvb5fdjxwpiP29nOe7B86lCMljgvIpwn+DMfwenwM945WzWWfNLx7RnrSQE5d7wU64DpV3DWU3Q1iREB4JTlFdIRJUfsb5SLvYLa4fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3Wd6p8Z; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a6a5b22f2so1471457b3.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791545; x=1774396345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sNAcIC2CYdZ0y3RBllLpBnFSvtrw2rL2ijPaByrHvM=;
        b=P3Wd6p8Z4bnhMcywdFUjwzh57bIQPWBPPLTuPYXQSY9ZhYBMuI51tomApUZw/7bpti
         r42k7F2A097S8+p9ZBsefGhKFPGmKYH7BinbiiKkNn/ZdJlnmtweaWhX5Ieu+Pn+eTN4
         Wemxi7THUrF0CqKP6HSPvADQTNkGFwURe/zBSe3R3x+bSs3vxBYrLFACzXbSOT2n3iRn
         eZ5P36sqEQ3kcMrmnplU8G8/NhLcuOA+hTWnRMjAO7bF6MBY48kWN7EmuGlAyqATVDsa
         GiWt9Cvgdy5yrDfyuSD5z9YkjzYFUx9FyHlWe8A6UFjB5YG8+mukOn+PSoRUM0ZTVKUE
         vR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791545; x=1774396345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sNAcIC2CYdZ0y3RBllLpBnFSvtrw2rL2ijPaByrHvM=;
        b=YOwnbAfC0RiQHfrZGN9Gk2EucqjDdmNpn22AYYG1cBft+fj1JbZ57QifqgiUOVZKp5
         ip9dASRto3s6XSKSdv/6/y7iqn5ARJzMZQ+IAYOo/T0nZLWv6bjAnxjBnJ99+tHrNHXP
         +ykkA8fX0wCyDBihSFKbvfxopdnvmHwlznr2TFv69b8TGNy/I+w9mIhszvRmSycpEjRT
         c4xmiIt+IAN+olNfPL1PoKGtV7rqQmXYkf08CqXRpls212m3sK3B5yP115I14rTOxAHg
         ZufL5sYS2oURYMD7dvXiNL85cnnqVa2WKquG3MyST1DVCCyRR6wRYO4ZGnYmxQNBtTtm
         vXBQ==
X-Gm-Message-State: AOJu0YxBXddAGl4Yx2FAnWkhbHq2bk0v0Jg1DP/BoZRbTbIYPa7bF0nQ
	5+9rDA/Mxyh8E4HU8HE6CkihL1GRXg6okV++RZMk/ZMRd853uuGNNOzRlz07HIvN
X-Gm-Gg: ATEYQzxPZk0lumfs1O4eipcYF2/g9R5UmAN6cJQZ20HqruG9cCR+f+Zj6Y7CJVj1a3f
	M+uXhBsdTw0fTswOo1nxl47J4rHsATC93LMPG7yNLI/zoAzOkQZi+JDiooQTVVdAok4il5wKpYE
	YwlXt6PZo2HUavsEVHN1zjd2PDuwegHIqSuJxFvdLbBKGnFuIdUkGcWv1pahgXztUpFFeR1AW3l
	6nufRcaXmjap9VHoM+tOUMTnv26k+PkrZmxuXUP909cmLton1fwNh3VH+wKBCCceIyOugupDw3U
	kdlctH06ZRkLWS3aoJTLBzlDTpvuECVPqj+7U/WDhPIrEbaI0FZO6lp3hxGXAcykqJ9fgToC/Sn
	g+eGVk2W3LE/tngw7u+gcvMaTDIZkGZVGHrfy2RmWeF+5fKmtE04BsD2OhSckhvgdO5xMio6VsE
	2isgQUB9cjWndX4dKW6Nzxve4=
X-Received: by 2002:a05:690e:4245:b0:64a:f23b:e2f5 with SMTP id 956f58d0204a3-64e9147098dmr933420d50.3.1773791545374;
        Tue, 17 Mar 2026 16:52:25 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm700030d50.2.2026.03.17.16.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:52:25 -0700 (PDT)
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
Subject: [PATCH v6 net-next 0/5] psp: Add support for dev-assoc/disassoc  
Date: Tue, 17 Mar 2026 16:52:13 -0700
Message-ID: <20260317235222.700615-1-weibunny.kernel@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268824-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 8514A2B4785
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
 tools/testing/selftests/drivers/net/psp.py    | 498 ++++++++++++++++--
 12 files changed, 1136 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


