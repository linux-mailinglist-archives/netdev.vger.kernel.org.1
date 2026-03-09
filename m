Return-Path: <netdev+bounces-265689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJmEEnMTr2kiNgIAu9opvQ
	(envelope-from <netdev+bounces-265689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:37:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B333823EB0E
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18181301F996
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F237346FBC;
	Mon,  9 Mar 2026 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R37WumJw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D559340A59
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081307; cv=none; b=Hps0XyJV0V2r2OdmsypPGbzMrmqvGCsoTMpNZ9zc3FGTLH03Ys9NpW0MK3LxF4V30Gh3bWay3eF8IrlShkYwl/ufYJ9lAV8lK+cR8/GNSSufJ7DDQQsXyvbZSLfREy5KF1mn8tlDoTcQjYBBIt5WiiLNg1QI00PLlp5EWdWuWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081307; c=relaxed/simple;
	bh=GYLyb5hpy2e2Yo7c3xeWEYb5pENWyLeOyEwMHsX72R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C8nDAIGlfzjQwAiZAbBFJdRyiO2RnrDQBqodTkuUzt3hpboeBxqZ8Xc86S53MYuFdPbL6/0NP/pc0gIcGVkUvNkNhjS0dTLFbZeKDfQJs2G+MCQjrrBH/d2N1ZYg10TMnC0sUB3DCCmPrqgnV16+31MD0ncCS+Wy5cT5awkhKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R37WumJw; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79852e01cd1so5652077b3.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773081305; x=1773686105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eVpgFgXoeruYouAkfc0JEALekSnCLZeaR3hMoMDJ/8c=;
        b=R37WumJwdVMl+cjBBPON0SzRv5Ro5iTnUY+L3WcIChw58LfiR8bJ4W47ewBf727MYy
         rWfhcn+QzAg552StHHxw/JbLMgTIA+TGn7J7rUxh9C910pS/6wyPcaAynEjeI8Itsd1B
         3yCNdGfMBk+hlwFdnbflAoWd9gH2Qjz7LeY8EBsTSvHEK+T09e+5N8v5LQ0ZijbrMJFf
         933MUPjVeMPomGhd/pfu7DH+rPryYFhRd2qMQ/08Pjsrn8Ziqhopu/0ZPcHONeJDEYp3
         cFNQnUSd06TeH3ogJCno1JcHWK6/SX8Z+HIk3zL6pICMFCYalrxaMoWliXAyCkFBRUGP
         rBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081305; x=1773686105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVpgFgXoeruYouAkfc0JEALekSnCLZeaR3hMoMDJ/8c=;
        b=K0xIxefWtLC06LDPO+Y2BAc1/BbRJwf+791uGcMhlC9ZXPUo3A+MoLLEjtxXqGvL73
         Acfsg2w5jUiFrQRAJdapndTkZvCldqVhj/FE6817eJk55wwrWOtSaQfIGbEBntC2zJVH
         xFbvf/l7sFfW9ewii6gWRGmy76Sbp5zawstOq1gILb1wszoca1tM8Pof0YMPqFtMvcmF
         5kiqTJELJ0gS5qmyRJB4+eIXHVFQ/p6MM3pT7OtDpRGwGZ2/gDVbKOaCm5DoVHrdmEVW
         CTSYFpTdRpm4nPUd0X69QciuoSIvKO1xwmjB5FEUs8DKLMOy3omyxUcBzaTcIna2O4lj
         AOlA==
X-Gm-Message-State: AOJu0YzF6c6fzgZXnFRTrFgyc4nPcCoSF5pM8nVqSBTUeKYRR56MN/pz
	xVoSvTCElzWIU/fypHSfwVdsDEai8XOzXDR/Ass7DuaysE/sJPFBODkHCqW6LQZAgZo=
X-Gm-Gg: ATEYQzyFCO22JkKRkQh9b9eDvWtO2/j5/7Z4lTIOJkTfrKT0APsMNClthMVdpz9iO2W
	rQMQ6JNB7n4tUFavjT+wfb5XnKA6JbNtdBNDWrjCpE5DH4cH/073rNcPoE2fxY+ZwXufaR/0ceJ
	3xRSCubQNlpSZ60fEvk0cXZcHHaJ3XW+VGnPP28Rlg8KfZI5zbs6IEJrjwXIOithWgk6w1lspoC
	tpdHsRvC0WmYyrpnb76Y/vmFrVgq2pTDhfrIUQRnNvW0xPcSkQFFaxIbxFNll4zZoxsLLu4bzTr
	ie2YCFTFnKu0m1InlN5mYCueHwfvf3uUI5bTRysb4n3WROP/Xb3UGMS+HQUX8+vwljyNJPAbfFK
	55U4KzZtdL+xP7FkAxW8y/9hmWQlAkFYNGmk+/bQkn0anpnJX7NkfcQtc9flqE7vk8TRoKyMThi
	Viz37TQ8AtPlr1JaGQQEhJTWxB
X-Received: by 2002:a05:690c:f09:b0:798:7879:1ad2 with SMTP id 00721157ae682-798dd7bf509mr98414337b3.7.1773081305110;
        Mon, 09 Mar 2026 11:35:05 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a515d1csm2573917b3.4.2026.03.09.11.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:35:04 -0700 (PDT)
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
Subject: [PATCH v3 net-next 0/5] psp: Add support for dev-assoc/disassoc 
Date: Mon,  9 Mar 2026 11:34:48 -0700
Message-ID: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B333823EB0E
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-265689-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fb.com:email]
X-Rspamd-Action: no action

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

 Documentation/netlink/specs/psp.yaml          |  68 ++-
 include/net/psp/types.h                       |  15 +
 include/uapi/linux/psp.h                      |  13 +
 net/psp/psp-nl-gen.c                          |  36 +-
 net/psp/psp-nl-gen.h                          |   4 +
 net/psp/psp.h                                 |   2 +-
 net/psp/psp_main.c                            |  90 +++-
 net/psp/psp_nl.c                              | 298 +++++++++++++-
 .../drivers/net/hw/nk_redirect.bpf.c          |  60 +++
 .../selftests/drivers/net/lib/py/env.py       |  54 ++-
 tools/testing/selftests/drivers/net/psp.py    | 387 +++++++++++++++++-
 11 files changed, 997 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_redirect.bpf.c

-- 
2.52.0


