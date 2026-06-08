Return-Path: <netdev+bounces-296383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vw+ZLV5rJmrkWAIAu9opvQ
	(envelope-from <netdev+bounces-296383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 136F56536A8
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:12:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296383-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296383-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02705302BA67
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D113290B0;
	Mon,  8 Jun 2026 07:10:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D02E6CB8
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:10:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902606; cv=none; b=FOX/Q1ugbp+3GcST64aSiEq4P4X/88U0R3AJEUGl3oV21RylehOFLpRKAPsN1YMEx39xv5YBklo8RLtU6gKTsROcgaAeNtgLOrM5qslrXo+jI4W2AGP9rVIJ2scmdm7krrYmXw9mhy0Agmr8fjxMV35EcwmPPMXh6iHExG+08OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902606; c=relaxed/simple;
	bh=FPU6ZZSWbmtJRNRRYPgfsIG7mdKktKajqHvlHdZhhP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gBx9IblFi6u/yXZZzUaEIAWdPwCtNabCXf2+1iFALaeYNAhtfYdOSRMfEcrDfTjZSZziTLN9FkKS4Tp6OJ8zplFi33bEPGLZ7ZIOtycvs29mlhkfwydY5WaNHCU+oUi9t7dAD32EtnefNit77astguEWKuhnwAh1lw9tBH4vABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
X-QQ-mid: esmtpgz13t1780902536t0fb5b13f
X-QQ-Originating-IP: DjFP08ug7f5Ljn8/qOjseuzvy/yAAxwE5KXMO+47ho4=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 15:08:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17286028086524605664
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 0/3] net: txgbe: fix module identification
Date: Mon,  8 Jun 2026 15:08:39 +0800
Message-Id: <20260608070842.36504-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NWy4VZNGBv1F4Yaacy14AouuHtC0rjbzeiyRohd++c4FAJbrKUvH6Qj0
	oKcB54x7WARcTdg8lu2Ag40UjwR5WoNL4F8ryKNa0hmv+if0KB7JA5TSbzqk0QfhX6DLhN1
	23kdhEaEYQRNb1q0B5ABL92etlio939B9M49i9mEGZkj1660HxJqo0YyKnpaHZuf8b1fAR3
	Lx+Um4vtegFSM94O0gUpRai/a9n+hrjF3C/MD1RK9h0l/a87ccJUsI+eYlpeIQnTDR5Qr97
	2jcs3qjw3Yb6wib6ppeXsIimE5E8WJ2mxIH4ZtfyukECTqI9u+ALhSbEfmVYms/kjLFCUV0
	x//kKiVwjQMynxwLoJT0U+En8i2avIUtuTCF6RNTbsO8po5Lxv3jv3mZdU+kdV4F6su8BRH
	0J9VE04IiDeNUcpW854pBoAt21rWpNI8FmOrdxdKGcGm+DxVCnsz6Vm3B0AHVEW8Hze/rtx
	/JUm7LtzpElrx2jnOJIXjfxRmx5Vp3jYt4K+tsANJb0t6fX8QUZOsI4XlSteLCxoMafzGMg
	hqMcruM8DdSp2kzZ9KGRS56210Su8f+sSgtQJflX+EjonMzNGvDGZokjjUO+0h/6NMSSvci
	QW4dCPg/Y1C4CCy0J0xy6KhuJ2G2ZgGg+HOrNx/KtWxLlJZCVNcyU6HeXJRFKcgHOeo3IEf
	WRpKqq4WWr4hgA+EzIvAgk+S+9Phgceik93xVlH7Tf5IAAaSuNsmqvEkCNU3eLdeqP2+Swj
	0r/Wnt7RDsSNsc/bEUbzM91LPOhQoPRK2/Ck3KTWCjFxIkLs3+T0xFF/VKKBX25nZTk33HZ
	6aMFeMtD8o1AL6NaptE2b4mynnP9/DHJ6JNSRUCe2BM5jrLUznWPwjTts6n8EjcKGHl6XU/
	JJakKgb/UMrScSateXro1/3X1RfA6lJ77gDEsCuSHc+8NVXgpXgptEK7L3wrm6DE6pDT9If
	kaXQPYFuELKmczjShDFtVmyON7P4F4lbofBrmKLhQLKNKgAdhXKH97hsvH1F9+OxWqBD6eD
	hvff7YWiaxlo/yIrri0FDbBDt0nONxoCRph7L326VJFXKhmXeqo69M8Kxx9d7o2uROkvH68
	eMNFxwx6zwAZI2zEIgqdYVquGmoxbC8ZA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296383-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,trustnetic.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 136F56536A8

For AML devices, there are some issues where the wrong module
indentified then configure PHY failed.

The module info buffers should be initialized to 0 before the firmware
returns information. And DECLARE_PHY_INTERFACE_MASK() does not guarantee
zeroed contents, so explicitly clear the temporary interface masks before
setting supported interfaces.

Rework txgbe_identify_module() to validate module identifiers through
explicit type checks instead of relying on transceiver_type heuristics.
When using the SFP module, transceiver_type could be a random value,
because it was read from an invalid register.

---
Changes log:
v3:
- Add a new macro DECLARE_PHY_INTERFACE_MASK_ZEROED().

v2: https://lore.kernel.org/all/20260605030850.17796-1-jiawenwu@trustnetic.com
- Split the patch into 3 fixes.
- Change DECLARE_PHY_INTERFACE_MASK() to empty array.

v1: https://lore.kernel.org/all/F3DA1ECDCE0A1E9E+20260602025443.332456-1-jiawenwu@trustnetic.com
---

Jiawen Wu (3):
  net: txgbe: initialize module info buffer
  net: txgbe: distinguish module types by checking identifier
  net: txgbe: initialize PHY interface to 0

 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 24 +++++++++----------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 +++
 2 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.51.0


