Return-Path: <netdev+bounces-294953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SHLtJUisIGo66gAAu9opvQ
	(envelope-from <netdev+bounces-294953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:35:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3889963B9D4
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:35:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hx2E4/SY";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294953-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294953-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1380300B5B0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B0B4D990C;
	Wed,  3 Jun 2026 22:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BD4A138B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:35:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526140; cv=none; b=A6yaJHcTlDtAF0WmGvYBrqiUn47EES4vXTHfuJOv7aBeO+wOxabsx856UpZQsRETGKO7HRUmmYHgZ/y6TmcldZBIVw7l8GmmQSJUcRdrXJdwsUzSu9dMknHQWUo76lrItlRS1o/FGXwzIUZjMIinlLGugijWLIM6J9qV79xFiqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526140; c=relaxed/simple;
	bh=8U6kzxDM+s9H+uD0VWDwhPeD7/BCSQimMQPrDj0abJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sszEc9+iJtGtXdKgano7vf2DH+98+rZczJaAWC64EHb3+gSvCQxMMqxioOK4sa4/h2Z+OxInJDEQ8erMXROIHN38et33OlzvaKr0e/nvtPhacViDHD4cKHTSD3WcX6vQlHj17IkD5aioDxCCNlLMW5YEKqniZmxp0LD+kvsW3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx2E4/SY; arc=none smtp.client-ip=209.85.216.65
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36b903567fdso22258a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780526136; x=1781130936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVdTnI0pJfHnWBDHmpVBcU8HLOe/CVl+5XgqFog7sI4=;
        b=hx2E4/SYeliXeRHS5VbCcLMJpt2W8Z54lQ8/o0Lohwpx8oKEk7NtpGQM/iCfzp4Kic
         5p/nNcq46ny1rJlXEzPxtKbB6hwcp6gY6eqBgwDE+DxwoRcnkPOQQQlCXZCnilwIxe0u
         +Q5pOZKLUPS7K3NOdev34CXvgM7+S2RzwI4lacVL+p/ZyqCfuj3eP4JXBaLJs8Z6avC+
         fAj0ZSi50i9NHh0M1qNPq9nVfViVOLSQP676/vQCTT9dBM59R45Fa06QjMR1wRBWNjo3
         RIk7/eETQA/0coqOrSxdQLbq2a+cxBd7pC4fhsH6paJvEiwjmitodjcHx1etKaFT4Hrt
         Dk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526136; x=1781130936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVdTnI0pJfHnWBDHmpVBcU8HLOe/CVl+5XgqFog7sI4=;
        b=N08XcqdvS+VIwVGQ4aC2VcMTqOnuLWdjX91gZGVylLqwqBPh4iVl5+zvqjXSNqUBhX
         PQkOGSjgp9JiXu1KD5uUjV7VXoAB/Os5Drtsz7eOpr2zTaoohQhxA4eEyaLxdoUDrvz1
         35XjZo3DJCgh4uw1I05FxQ5cDr/UsbAAn+4PTUa5HPnE5XhRwmkumwVaknLbEKn4Nk8S
         mbnqi65Y0Yi67rOON9yFHggRTEci677FuKqXUTGFg5Q08+0XKi8HnijbvvVyfe57N0Oy
         KU7zAnZu6djtQzAy8q0VBpPAjb0VUAq5Z6SYffsBC6pdh8FVANbSh2Iwd+aTRtILlJpd
         YEMA==
X-Gm-Message-State: AOJu0YxYyLjY3uxW8MN9TXijJTaIj9GrvdmyrwnkwOFH0uz2IGK7IvSV
	VCO8BLDIg6jyigCBKuj1a8lvFbbPQ/QMB2mZKR4h2ASBU+L8VL+ZZfRfQKIRDvIA
X-Gm-Gg: Acq92OFkysZYT5wJXzubMIrFMC5BWsQjtMh2okAC0WfX2fGOAcjhJVTIcWSgt1rhpz0
	VnqMw/kgT5DEW5i9JXpauuYldbIIY27cY4408ogXsKhEt1Zk2HdIYA8mnOmAu9JHbSZRSgKyVij
	yqJ2ApwB7Fhg7MyZ7/dRAvF7MHDqevOphqoBoeqVNr2VRtV03XINPT+OVglEO6C7vyMvxqdS4Xg
	BPvvDr+eGdx6fin/aAImW82NlD9pH7bX0UW2RxE65tGZonphRWMy0R7Y5pAko6IRmK86d3X8tMi
	dITmvwWZCBddJXIpf3NLf9/fXr+qLSIfr0zX8Gx02MXLYqoGcXwD1BldyLJlwb/5FjWKyr8e9fK
	4D6LfMufNDeUavk0iFsBxmsEECX5spNlE3ItKJCLXO/ZqZ8MhKGH9YR93HmXRCgJWSKiFstlYkF
	t1/QaAAAaizbPBJ1CCXZrJ+KH5EhqPnpsL4MHj/Q==
X-Received: by 2002:a17:903:f90:b0:2b2:4bf9:1766 with SMTP id d9443c01a7336-2c1644a0a46mr56252805ad.33.1780526136431;
        Wed, 03 Jun 2026 15:35:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ab01sm35271175ad.71.2026.06.03.15.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 15:35:36 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Zijing Yin <yzjaurora@gmail.com>
Subject: [PATCH net-next v2 0/3] net: add retry mechanism to ndo_set_rx_mode_async
Date: Wed,  3 Jun 2026 15:35:32 -0700
Message-ID: <20260603223535.2504695-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294953-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:yzjaurora@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3889963B9D4

Original async ndo_set_rx_mode work left one place where we do netdev_WARN
in response to a ENOMEM. The intent was to see whether actual real
users can hit that (adding uc/mc under memory pressure seems like a
very unlikely thing to do). However, it was quickly triggered by
syzbot's failslab. Add a retry mechanism and downgrade netdev_WARN
to netdev_err. The retry logic is a typical exponential backoff:
1, 2, 4, 8 seconds, 15 in total, hopefully enough for a system to resolve
memory pressure.

Link: https://lore.kernel.org/netdev/20260416185712.2155425-1-sdf@fomichev.me/
Link: https://lore.kernel.org/netdev/20260519095557.3749407-1-yzjaurora@gmail.com/
Cc: Zijing Yin <yzjaurora@gmail.com>

v2:
- rx_mode_retry_work -> rx_mode_retry_timer (Jakub)
- (ulong) rx_mode_retry_delay -> (uint) rx_mode_retry_count (Jakub)
- remove dev_get/put (Jakub)
- drop fwd decl (Jakub)
- move comment about total retires to NETIF_RX_MODE_RETRY_MAX (Jakub)
- use -EAGAIN in bnxt to signal retry (Michael)

Stanislav Fomichev (3):
  net: change ndo_set_rx_mode_async return type to int
  net: add retry mechanism to ndo_set_rx_mode_async
  bnxt: convert to core rx_mode retry mechanism

 drivers/infiniband/ulp/ipoib/ipoib_main.c     |  9 ++--
 drivers/net/dummy.c                           |  7 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 38 +++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 -
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 10 ++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 +--
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  8 +--
 drivers/net/netdevsim/netdev.c                |  7 +--
 drivers/net/netkit.c                          |  7 +--
 include/linux/netdevice.h                     | 16 ++++--
 net/core/dev.c                                |  4 +-
 net/core/dev.h                                |  2 +
 net/core/dev_addr_lists.c                     | 53 ++++++++++++++++++-
 13 files changed, 114 insertions(+), 57 deletions(-)

-- 
2.53.0-Meta


