Return-Path: <netdev+bounces-302793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +TfuC1++Qmq5AQoAu9opvQ
	(envelope-from <netdev+bounces-302793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB916DE231
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:50:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=OeHRmF6N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302793-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302793-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A628B300E24A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2C3C0A05;
	Mon, 29 Jun 2026 18:50:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7F397342
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759003; cv=none; b=MTggrA8I9lYA4tN5RMYa1HW/57OmED8hnmFP1v4/5xN5B/lVXz5stUs9doJhfUM6vrQnPEfAomLJhpISSViTtb6v5Q6elGtiyBHohEtnKtehvdZwAZ1+GjIGB8uR44LLPA7CPvpubS8AT0p+wLSeOlRGYESMIEZjtnps0IoP0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759003; c=relaxed/simple;
	bh=JW23acsyXscKFahhJ3uLgymtIu+8SxA0avb5WEg4/oY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuI1gVLwbPAL5oEa8VG7X7jwBIOIOCgCLN5dXf6RLu8Svm5VDmJQn/2vGbxRWY1BqgwSadmGd2RiaMB0RirbSlmZQ+R/wkiTap3Z+6jUeKG8idOt5gfJtOFWpGJY/YqR9qqxm1n+hjHbvwbwrSKcadBhCN7oxQI9PmF6K1KpzBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OeHRmF6N; arc=none smtp.client-ip=209.85.128.227
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-80dd4766206so12286387b3.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759001; x=1783363801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2YFS+K5p0G0QqqcWmPd6NTVnxkheoF8BhYqZcRHkmA=;
        b=ejI93FwKpv+OL0becHqvwFY/VLUBUOBbMHPzaFXOWPLhpg0gCw8KJHMgzxlJXALY0w
         YKOzICd6Qf+BP20JYIby0kzKdOZ3Tvid5vRxL7MAzaXnhk1VEKVmJ6aHZkt/jwBFpZnr
         O2cDjhA/nZnuCdQBdbrjavNTMNtZfpdAoHJ79cafXMfCz3KMrf1W2pZ8lWDL0xNZcUAc
         2Td55dzQp7um6ULslfGlOIqxVVsyb3z6Nv6kBi1U1fFe1sKOqu+9x4yl11SuHd6LmUmg
         cSwXLC6j8XdsghQenGNW8y4C79P1D+/Zddki5oXHJ687M4udi9FvkW3upx1zgxi3EG9T
         QVNw==
X-Gm-Message-State: AOJu0YzVjabfMlbjH4MYti1CJlZs5u6g454xGA8c8CtcgW2WzqjvYr6W
	JYGgPLTNGfBRiVrhrp7bz9pG0TNW7HOMySetMkCeN8W3M+mSpFzz+UwuZO9gje5UC6Lau1L5wy8
	va9Bq9T17aV07nLflXdekMux7WS18ED5/JhuNBAFL6c1DGmQq0xhe9ETme0P1nt7BtTBeg4kiB8
	c5K2tPWvpxvWIXxs52cwpJJCh/SIYk7iTslzk+kUaLVcYqf8UbByfQvvzaJkloVYtlX9m7CKsx0
	3V9qFz1aK8=
X-Gm-Gg: AfdE7cmIqmGsNhHYtUPmyuElLsfkRElDITXIw+jhb4ql6pkqCq6jrpof1nvGBqR+HfT
	fRFJ50HFLRdWwsy4FaF/FxzCZyIcZ96hIQEyB75353Ct8Z+dCB2ERHrnzROq7k0Xhs557pxqMyv
	SCdeZPNjk7AEa8kG7Jl5Xj2l0IQ4Hcqj81sAIcTUzdvzGvLycDccLrZVioC15zCVTdZZN+s8uLi
	+1Gv3wsZO8utKEHI5ZjAI41BroelAGtD9wFXRwCEA/JmnmhJ33UiC999slSCmGyKrXErnf9jfI2
	/TNdhq+6pdu0GbJUoqhDH7osJqECBbSzgC2lCL90yA6Fk0em87oVleJlhFSUwGLQBmd5L7voxdH
	EpV0aU8EybZm7xrCGctXpO3aQhrq/n7cf33fjbfeNIvxMMMeO0edFAiD8TB2paOJSokSuHzLUXm
	F1x+MOjMH3MmUpWNlkrsEHV0qLUImVNBYA6CRW4RkYYfaeeQ==
X-Received: by 2002:a05:690c:4446:b0:7f5:87d3:c38c with SMTP id 00721157ae682-810d7db1120mr8212067b3.21.1782759000796;
        Mon, 29 Jun 2026 11:50:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-810e6e893adsm184927b3.6.2026.06.29.11.50.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51be9b2582cso37992611cf.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759000; x=1783363800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2YFS+K5p0G0QqqcWmPd6NTVnxkheoF8BhYqZcRHkmA=;
        b=OeHRmF6NvJ6UjhOmEMAyAdgrq61sK2JBVUIfTL6CMk9nYjAS8mwT4sFjLq03aZi832
         HSXzPgLkfOXl3giHFPj2KnLTa3ttDtHskPsAZDa+3Cz/6oZmDe04Y/aGepD/wxnBbUsf
         pR26ojTi449LR20r4ryWngFvWK8flJI+CKfOU=
X-Received: by 2002:ac8:5a8a:0:b0:51c:1005:d091 with SMTP id d75a77b69052e-51c1088621dmr7458181cf.56.1782759000020;
        Mon, 29 Jun 2026 11:50:00 -0700 (PDT)
X-Received: by 2002:ac8:5a8a:0:b0:51c:1005:d091 with SMTP id d75a77b69052e-51c1088621dmr7457461cf.56.1782758999243;
        Mon, 29 Jun 2026 11:49:59 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:49:57 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 00/15] bnxt_en: Add kTLS TX offload support
Date: Mon, 29 Jun 2026 11:49:06 -0700
Message-ID: <20260629184921.3496727-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-302793-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BB916DE231

This patchset adds kTLS offload support for TX direction.  A number
of new files are added:

bnxt_mpc.[ch] handle midpath channels (MPCs) used to offload kTLS
connections to the chip's crypto blocks without going through FW.

bnxt_crypto.[ch] handle the crypto interface and resources.

bnxt_ktls.[ch] handle kTLS offload.

A new CONFIG_BNXT_TLS is added to enable all of the above.  The first 6
patches add the MPC logic including resource accounting and reservations.
The next 5 patches add the crypto logic to handle the crypto resources
and to send/receive control data using the MPCs.  The last 4 patches
add kTLS offload for the TX direction.

There will be a follow-on patchset to make the TX offload more complete
and to add the RX direction offload.

v4:
Fix kerneldoc prototype warning and uninitialized variable warnings reported
by Jakub.

Fix most valid Sashiko reported issues.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-1-michael.chan@broadcom.com/

Fix most AI reported issues from Jakub.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-1-michael.chan@broadcom.com/

Fix unused variable compile warnings in patch 10 and 12 by reorganizing
the patches (reported by Jakub)

Fix some error recovery issues in patch 12

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-1-michael.chan@broadcom.com/

Michael Chan (15):
  bnxt_en: Add Midpath channel information
  bnxt_en: Account for the MPC TX and CP rings
  bnxt_en: Set default MPC ring count
  bnxt_en: Rename xdp_tx_lock to tx_lock
  bnxt_en: Allocate and free MPC software structures
  bnxt_en: Allocate and free MPC channels from firmware
  bnxt_en: Allocate crypto structure and backing store
  bnxt_en: Reserve crypto RX and TX key contexts on a PF
  bnxt_en: Add infrastructure for crypto key context IDs
  bnxt_en: Add MPC transmit and completion functions
  bnxt_en: Add crypto MPC transmit/completion infrastructure
  bnxt_en: Support kTLS TX offload by implementing .tls_dev_add/del()
  bnxt_en: Implement kTLS TX normal path
  bnxt_en: Add support for inline transmit BDs
  bnxt_en: Add kTLS retransmission support

 drivers/net/ethernet/broadcom/Kconfig         |   9 +
 drivers/net/ethernet/broadcom/bnxt/Makefile   |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 255 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  91 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 613 +++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 229 ++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  53 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 572 ++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 175 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 732 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 210 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   4 +-
 include/linux/bnxt/hsi.h                      |  37 +
 15 files changed, 2935 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

-- 
2.51.0


