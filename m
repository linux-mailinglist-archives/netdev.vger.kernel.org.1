Return-Path: <netdev+bounces-266801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC4MFu4BsmmHHwAAu9opvQ
	(envelope-from <netdev+bounces-266801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:59:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B005C26B7F8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20CA130D28AE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947F39EF1D;
	Wed, 11 Mar 2026 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToARCqZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5973A5424
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273567; cv=none; b=S5+PRZm/WAwxdwuqtlAr4qooOiI7A9KzZdvVDkE32OK0za9Jz/jPFMxZdxMP10yK9OSifn72C6i2zDbZIp1f7AV5EE/TrAucZJWl35hMLjEx00VnXjzCBsiq5PyuJ9/EuNJctaKykFEPPP67Y5vS3X5izDI2UqIrkVlcDXLpZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273567; c=relaxed/simple;
	bh=xALfr9gLmb4EVc9ETm818gzsdS+pQQL7/OhbxqZPKvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mcJm6zUHaKZs1NtDDM5E4UClGwlPZIXe+Eqgb4XAoII0oUTDhRlPUrap5Tk0V7zvLZKJujkoiWWzRr2WcIRvZseOccAXYFWyI+ph+nnAsvMFjIWfQmR8hu3j/AGXtVqvCITl+CrMC5O/tOsCbnGsbHsC78R7Jb7XF9rC/6WLut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToARCqZx; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ad775d002so48934d50.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773273565; x=1773878365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1YvNZa5OyW3paqyFGigH39d2EYczniLgPpXU3KSwy6c=;
        b=ToARCqZxSEJXZyMaF2qpLvn+aiK7bFRFA9agtiaWln7F+eKk7SufrxA1c82ZSmxowf
         jghOra8uoqHdaMvlmcaUl04kTZ6900L1Y41Ok2/ZU84kXKE29RlrdylmcUZWkohQlGpM
         5P1od9ijyD3vb45AT51tzTacCjS+B1wrBDnrOI555PbgDvt8gQA/9oQjQo36yPiL+yW3
         rP0ZE1py2PNQ+kgeJRp8AqsjTJVwWUFRg1iBOEw+JkMyQdFKTIczBmI02Dd+yYKi6qrp
         VPMM74pBb9afVCwhWFGmCpl8SR8y6sob9i9NNDFqjJO/2Zf43eDbQ9kn+oDyPBQ81yMW
         wPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773273565; x=1773878365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YvNZa5OyW3paqyFGigH39d2EYczniLgPpXU3KSwy6c=;
        b=P/ZZZbfsowcUYpeASmEvhYvtor+Ry3yCJzTcHXcq35c5TQ/s/JeohjJP0cuqbOF2JR
         p3cEv5jTNlKTzK5467s47LV1bAHZC+Dj5vvT8Hbwcc3P524CVMpm6H62x9qXLTn0dbpg
         521vac/vqSZewSHhDbkxpRHBBcR/LEIaDGDJ7prBriqjAcyijQJCinnFUfy1y6qdK2I4
         uIj6zipze+NegNiaQ3uNy9r6kVDDcl7IdW/kK48lH1KITGmQTENUhWddTGuKIvQuqxql
         3C8qAt73DBkF3DqTLVtDEz57chdWVI9NfE8J8eLK5j1CwPqACZFkXKQaLNtHZiagXR98
         WOUw==
X-Gm-Message-State: AOJu0Yx90jG4Yv1QCD3ETSNrDDu0zmP4Qls5v8zGzwgVOyDkobphCaJo
	cTrSKlj4jSlk3wm6awf72UgLpGtB6USOzcxoL8D+6hy16gbYu8agpDwI4qQ8OogO
X-Gm-Gg: ATEYQzxk5V62NOyysRDZD4mgoRZPGrFZFeFzoGJchLYy72Gze3NvWPRYReGRer2tQ0C
	EyjCUSBXDkyz6ii53NkkqcgRhe8eGSZQaR9xSYHHqvSdAiWLu6aMISO9itSH4yvSkGx6plgAfWb
	J0AfR1fQuEFpuFESibRWazP/4FqLrIbDdNvaLmZnkqhvUtBaaAFM8528ozbEie7sCvaMP5V5KM9
	VsyZPisUuY63dOxbt5WnREyWFPRGxFdmV2c/Q/oWgQJwOSJGIwU/RO9vV7sPdOBGSvCkjm1nxlM
	UQvf+wjOUtYLoOQ6SxpN+0SPRsD5atf63orWwXnv5HcP7ogdl/R8s7SLpUSeOfw9/ty3oGSg/d4
	F4SJXGOVa9kM7t43/ynkrlHhAkt+NHp/b6bpSC5OUE/KO8CrEB0oLKnXM6Z4fy48rqDGt2RZhkH
	I/uzMOIhjspfuw59jJuN/uUxo=
X-Received: by 2002:a05:690c:ed6:b0:794:c0c7:43e8 with SMTP id 00721157ae682-79a11d4932amr2610417b3.3.1773273558029;
        Wed, 11 Mar 2026 16:59:18 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917dea7c9sm21570467b3.5.2026.03.11.16.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:59:17 -0700 (PDT)
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
Subject: [PATCH v4 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Wed, 11 Mar 2026 16:58:58 -0700
Message-ID: <20260311235904.2392010-1-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-266801-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B005C26B7F8
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
 net/psp/psp_main.c                            | 106 +++-
 net/psp/psp_nl.c                              | 365 ++++++++++++-
 tools/testing/selftests/drivers/net/config    |   1 +
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  54 +-
 tools/testing/selftests/drivers/net/psp.py    | 500 ++++++++++++++++--
 12 files changed, 1166 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


