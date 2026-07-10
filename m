Return-Path: <netdev+bounces-306421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kVx4KiJ0UGonzQIAu9opvQ
	(envelope-from <netdev+bounces-306421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EA47371E8
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Kn3Wmk1Z;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306421-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306421-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F325301ECDD
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997436B046;
	Fri, 10 Jul 2026 04:24:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832A36B04E
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657489; cv=none; b=ZvGVzTZ44qzNnWC+gv4dSnK0lG1tHlgrCzncENSis/heIW0vQus1zCLbR4kvVHPw/r6nI/HoVEUW4RypMJXO2+DM/aFLJcfjxLxm9wMbYWpLI/GNvpbJGoahsagLgGLaPL9wPwDzAokyDtxsWVgWYj7DZa4uE3Kaqzk6h3XGmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657489; c=relaxed/simple;
	bh=q6T5HM1Ir7K1x8fqrDBpPwstlae3JcOMz+opCymJgFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQDs2Bq/9WILqJ5osJAR6tp/RDnKqGZn/IYuXIUJOT56X3kw65k1ClsdJxtvZZmdifZzWCOQ1Opt58vuD9hqYeWTfX/bd5y/lPSvM81rgzKwOmawe8k5BTn2ehLh1Xzix+WJMtc30Kyyb5G7/Ob+kZuKJx068N2AgNhdr8zPOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kn3Wmk1Z; arc=none smtp.client-ip=209.85.214.227
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ccf2360620so3489835ad.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657487; x=1784262287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5e7Yk3cbHBxYPRcBi3ZAvbzqKH+vbeBv5TvNBvieM88=;
        b=asoiq3XTnbiXm530LjFUzlygFeaTmrJFzKO3I6kUmy6PuAcJsJfiXLWGYwz4lv/RYz
         qxJr25xMQRpmP4GXfIPEg9eI5gZHkUHYg08gv+QFtyJEe87AD6pjOqIARA/X+Qk77oSe
         3i//+BcM7qZOADZiDrYW4hGKi0o65mKjJQvPoOaACWiPXb4CuYhUHB6S6ezeCPnkpcFw
         Hb9oxAJlQNC8wwFilzaNsxLnQfVKna5FKCkMO/QnpnJcRE3TD8w4hevLYGFMxpP5XddD
         D3vO4EDLsh4NoIMpjjngUHn0mEFj4rEiECpWLnszsqf+cFaYMdohKLIUD55er+HaCfBj
         olqQ==
X-Gm-Message-State: AOJu0YxvtkWjVMG+L5nCBhmR/BLxPCxX9u2UreDKNLHgvXHjy97CpXR3
	sNrOrkxF/n/DanS2OPjwMbrh02GrHo68+UkrFnf9K2sPe+ocU4jdXVARCXPwDPRhWQ0v2rmXiC1
	Larhh91u0mOfKgX8SkixMz2vzImw5cHs0GFcMTmM3MluKMyY280wr/i0COeL456T1g4eZzQWYZF
	KJHXBUM64TaXLDSUiMjK+9iUtq1BGFI/fv69b7/vuPx+uLrmMNIpuKRbyN4Z+DfH90l8pELVYCg
	uSLWbeFqq4=
X-Gm-Gg: AfdE7cklY3LeotZxm8a22OSf08z7u/9PCA6nyoMp0+QXGszdHenKATEySGpvY5d3x7C
	T2z6qoguj6nhgHoTh0nSSc+dN4U8yxQXUE+5M1ZxBgefZ4r+5Bz1cgap9w4VTJvn35eVD9zlVIB
	PsWjCoYZcd9b+cBmMMQFpvO/qZryhJMll70qexapJjyXnZCGPzagOX27KjkIC5ITlM8SyvWdqzK
	c/jYPOeOMcvQEkdfMt6eLK9XclmQH5OMkx9Jjcz8sBdbjZmYScelf6GUESbgtIxgIjhnoP0Kost
	oR+3RsHgQc9FEhCwIvoNqAWQBwr8Fa7riasVcRGG1djccplfecVUcZ0Tkw2BgCThWSeSKW+HOC5
	xsnIcirDsTNCe5rvs7NxmHroCJWSJgJC1a1lGixTeFDx3u7917oXry4kX8Zb1IwvKkEiUPxdLrL
	cYSsmxWxy8ONsLmGzwI8wsTTxjDN1RYdMhvDwsrfhvAcQAlA==
X-Received: by 2002:a17:902:c94e:b0:2ca:4cfd:a6df with SMTP id d9443c01a7336-2ccea45f347mr111062985ad.43.1783657486951;
        Thu, 09 Jul 2026 21:24:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccdfbee677sm7640875ad.17.2026.07.09.21.24.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:24:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so526147a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657485; x=1784262285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5e7Yk3cbHBxYPRcBi3ZAvbzqKH+vbeBv5TvNBvieM88=;
        b=Kn3Wmk1ZyLRQM9uTNZ+974OWjqJ5TIJJSuuZTvirJYIhA/EoXQYltXDWwqhAsQRXXs
         /HSGLUV2/9uBWYWtoJPNza2Pt2I1JGi5upMF76GvEIdIU34L8EfX+WwpyK9/T1YgqYuS
         bWQrkGIj72l/Q/hV7xYTCRx2RuMl/a55P6cNo=
X-Received: by 2002:a05:6a21:4591:b0:3bf:6f9f:3381 with SMTP id adf61e73a8af0-3c0bc9c00b3mr10850717637.33.1783657484794;
        Thu, 09 Jul 2026 21:24:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:4591:b0:3bf:6f9f:3381 with SMTP id adf61e73a8af0-3c0bc9c00b3mr10850697637.33.1783657484359;
        Thu, 09 Jul 2026 21:24:44 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:43 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v5 00/15] bnxt_en: Add kTLS TX offload support
Date: Thu,  9 Jul 2026 21:23:45 -0700
Message-ID: <20260710042400.3996847-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-306421-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:dkim,broadcom.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35EA47371E8

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

v5:
Fix most valid Sashiko reported issues or add comments to clarify:

Patch #2:
Clarify in the commit log that kTLS, MPC rings are only supported on
P5_PLUS chips in response to some Sashiko comments.

Patch #3:
Improve the ethtool -L MPC calculation to use the actual MPC rings
during ring check.

Add a comment in the code to explain the bnxt_trim_mpc_ring() call.

Patch #5:
Check for P5_PLUS before allocating mpc_info to more clearly document that
MPC rings are only supported on P5_PLUS chips.

Patch #8:
Pre-existing Sashiko issue not addressed.

Patch #9:
More clearly document and explain that bnxt_clear_crypto() has no
concurrent readers/writers.

Add comment to explain that the bnxt_free_one_ctx() caller is reponsible
to check the epoch value when needed.

Patch #10:
Add description in commit log that crypto engines use short completions
only.

Already explained that only P5_PLUS supports MPC.

Patch #11:
Defer the MPC ring reset to bnxt_sp_task() just like other resets to
avoid any possibility od deadlock.

Add more comments to explain the MPC ring disable, stop, start.

Patch #12:
The bnxt_drv_busy() is the existing driver scheme to wait for activities
to stop during shutdown.

Patch #13:
The kTLS software counters match the other driver software counters
using plain u64.  We can add u64_stats_sync for 32-bit systems but it
makes more sense to add it to all the existing counters as well.

Use BNXT_NO_FW_ACCESS() to fix possible massive AER timeout.

Patch #15:
Use bool instead of bit fields to keep track of kTLS states (requested by
Paolo).

v4:
https://lore.kernel.org/netdev/20260629184921.3496727-1-michael.chan@broadcom.com/

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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 291 +++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  95 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 617 ++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 230 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  61 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 578 +++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 174 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 783 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 227 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   8 +-
 include/linux/bnxt/hsi.h                      |  37 +
 15 files changed, 3052 insertions(+), 67 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

-- 
2.51.0


