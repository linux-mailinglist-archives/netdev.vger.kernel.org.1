Return-Path: <netdev+bounces-299158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zhVEJGJXLmrDtgQAu9opvQ
	(envelope-from <netdev+bounces-299158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:25:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980C6808C6
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:25:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=ajYDbh3f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299158-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299158-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 728D23003983
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D837391E7F;
	Sun, 14 Jun 2026 07:25:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61B1EB5E3
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421919; cv=none; b=kRU0sd91bPtX0r8wAEXi1OxI7Rhyz+L3h1mCfuOTj1X/tw6xRlTgbBIbjFMT9K39sbs7lCjy0m5EddKpkTavcM21DaoXJUc3o+9feZobWDUlPB9ehXQH7vuJiFB7Hv0AWZ7+KlwZzbKyJ9ouRH1T3B8z3IuAJ1WcE6MCQfiQYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421919; c=relaxed/simple;
	bh=w9I4hBSR4cKXwJ/Yq2IgNsG75/9VKJE4bqP+dr6MfHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUXfGwWWvVpjM5X+ckrExqZsSCaNnRYI0WoMLBo/edjI+oHtuACoh114lQifiKROW5HCholeOvDjc/4oyrSYWuIVN8f6yxb14dkTfRi6qXlK9ShWCLoTcXzq8UlMO8Nc6glyT8jm1ikV4qm1A84NZbKaqkyGbGMtd30rwidqy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ajYDbh3f; arc=none smtp.client-ip=209.85.222.226
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-9159477c893so277361385a.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421917; x=1782026717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxdKIRbROmL7EURprqH0ZHiUBctOyoJmhn4wXlBSfqo=;
        b=oENGSDOCNcOKzyuaaDAHoLcBk9LEjgFgNB8TG09XAjkiPnn4o/ffq4tdxks4tn5Rh4
         QAdAlUbee/d0Pc+QZN84bXubdsZRIHPQ5jBF3zVNB6scNlLaUJ/OqpcAcaoOOMdiYOQ4
         vvpy8U6zNuMfG96eHEiKPkixlzZWqVJVyjIM/drnLQ5BFC4ECGB/tCgtd91tPHuY5HJs
         3L5sMkDDypZQHxvSSn7T72AoArEOmJ/QcwajlDN/YkgiydcvqVONEz60fg8QbXmA+8z1
         VuHbScH9SXYhjBJCfYTXWkIXBCISwJ4PzhBRtIPNphmWwFLvo2W+TND7nIS3f5oMvJnH
         eQaQ==
X-Gm-Message-State: AOJu0Yx+qJvQj0DgMkYlPL3d4J4/gv9KbqOXx7W+kJxOyCfuNhZSZYTo
	uruJ6XGJKG7IzbFmXsJM5eXHXNBcN9zxT6muZa+MLRdv5nPjGCL0MzJCyym9ObvhWSDGVAmSuPW
	1IeVv6AMmQiIemtTqcaWCpEIsfIFjPwOvT/cfdv1gmP7p4cWOPcx0wXUyAQosPRrmuqHRPN7WFg
	XgcvDZ71SYvkagmkp3HF9kqHrboXPLdoKPhbM7oywKPlw7grZiZRq2anETp4C9pFcAfZ64Z7cBk
	xyg6SgglK8=
X-Gm-Gg: Acq92OHMXEq4oKEqrhtT/WJNIJ50yxI6do8S0ZUnEhma59n/0v0jqyrgeBy3GlKQJAY
	tdTfSOyzGhvDiaa958NBFjlE/30i5tzzFIY8HUYMRN9vJP0h1KKhrXEkNr4Uikl3+IJaTOeWMyM
	PEhh0tpENx83NDqRmgAOOCy/3cb0cAz5xkOf9GpgVrdXfVIXDgP3jjb/M83c3TI7MM+Apkpvg4D
	MeZ2Y1FZLf72G0o3/lqX5rVrKUnsJipUATv1R4e9+vMIzOC7fB3BmUaRtfTCbxW4ntiC5mpWnkz
	k8wJWdJSd//f32d7Belvy+FkrosY7BR4Yr08ZOupn6AoV81lL8Ye5NGXadyQy09Nvo80JjKpr4W
	u9eKjnzPiJdJ+ScKARBAdmSqA+GqmKNDgB/Io7bEWvaJTy/+gCFbmDSQ8AdQHI33jJ8K/cdpAoL
	NRt1uO1sPCjOClBEi3jYCSbOW7o+/FajBGvku/5i3at7/AADvDP5GYWi0YgYg=
X-Received: by 2002:a05:620a:1b99:b0:915:4c90:34fc with SMTP id af79cd13be357-9161bac4e76mr1491960985a.11.1781421916809;
        Sun, 14 Jun 2026 00:25:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-91619fd8f21sm19022985a.8.2026.06.14.00.25.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30762d67a64so3344684eec.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421915; x=1782026715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uxdKIRbROmL7EURprqH0ZHiUBctOyoJmhn4wXlBSfqo=;
        b=ajYDbh3fELrg/ksB7ertJ2/w0+3IaP6L5XARikB+yR7iuNtkE/sEofWDHrU9D3tkUf
         nboqzf24daWA4F9zyLO/CVMCFOTkA6ltq2PAJhwcwoBYftLE8hRBrjazUfnoDgv6U71/
         84gZ8qatOVUyvm7CpekHUACqFBN2OsZTM1szc=
X-Received: by 2002:a05:7300:8188:b0:2f3:3daf:3496 with SMTP id 5a478bee46e88-30820098dd8mr5247981eec.26.1781421914755;
        Sun, 14 Jun 2026 00:25:14 -0700 (PDT)
X-Received: by 2002:a05:7300:8188:b0:2f3:3daf:3496 with SMTP id 5a478bee46e88-30820098dd8mr5247967eec.26.1781421914120;
        Sun, 14 Jun 2026 00:25:14 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:13 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 00/15] bnxt_en: Add kTLS TX offload support
Date: Sun, 14 Jun 2026 00:23:52 -0700
Message-ID: <20260614072407.2761092-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-299158-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2980C6808C6

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

v3:
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 255 ++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  91 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 614 +++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  | 226 ++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  53 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 572 ++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    | 175 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 717 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 210 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   4 +-
 include/linux/bnxt/hsi.h                      |  37 +
 15 files changed, 2918 insertions(+), 54 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h

-- 
2.51.0


