Return-Path: <netdev+bounces-303454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xGvtHjCIRGrawQoAu9opvQ
	(envelope-from <netdev+bounces-303454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:23:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF836E9717
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:23:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303454-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303454-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F85E302B838
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 03:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D913655CE;
	Wed,  1 Jul 2026 03:23:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7033ADB2;
	Wed,  1 Jul 2026 03:23:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876203; cv=none; b=rT92Nev/JlbUdrKd5aIrusqRFIl1yvyFImLJHSVXhNDOrVuSnAVJGiXEcjVn3XDYEcSg2cW+C/QrH5rDj1TULA8ISlDzxi8e72FJI9esBvRE5zLs3ctXCN0imkK0AgCOEjkKSlW3W4QkYFc9l6ISreiLT6MYoGGcYa0LL8a1DtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876203; c=relaxed/simple;
	bh=aPWUk+CO9bjN4NjZO1G52GZEFQTWx69FZ7cYLq8xaQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d+W24ckDCJqN3MrACRDjFzS4utwhdqJelGqcQxVda/eQePg0wLwAwhDpKmAigPwp7LR3bOB47UNuvBOZNkWUaJacvXuMWVFv6ZRRg0DZEO2INh0ZhSlrG9Lc/U2CPhEFFB7eveA/SwbmZQzgwBR1Di9RFp4hao+A7plmFHqckJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
X-QQ-mid: zesmtpgz3t1782876137tdc809c9e
X-QQ-Originating-IP: kI4mQ4Ekd8zOmb7dsnp5hItCpnL6aeGM0Vc6lilaad8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 11:22:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 74903392030740245
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v2 0/1] net: rnpgbe: fix mailbox endianness
Date: Wed,  1 Jul 2026 11:22:07 +0800
Message-Id: <20260701032208.1843156-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Ndw/mc8X39ObX3VadK+edLdvMpfRCvquyJ79NJWD0b+3681ROGpPTpHT
	hsBjB2QVI+nVc1ZpW+5iCHfeYaiOskFGzo6n4D9CUPW+cdhsY7PTi7ptnjL6VRbV2ePBq/X
	3Sh30WsrHe0ZEId68DZBWIRVpoANp8goAcc23oepLFk2HTw22r2dUe5VwtRz25ty4y3PLG5
	OoPLY7zydb36nLHbfX3x1l/X9PdNGRirj0krOYYYvCHC54iDyRen/J35d1zkEHZqIirzhuz
	k78juo9iIbsQUPc1uTHg77kwo9gnOQDA4WB06JvfHS3T87MAlQA7IJrDRajjKFrqJYCgXKc
	taTViT4q99mWvFY24k8paMHAKcTiTt5mDVDLeBbkiULzr9lhC3YvySOAkSkfeE5mBUOdtt8
	D4/v8cN3Vqwl8KIV/oiY73QzzocgkOeU98tYWONuRqnL81tHYZoVpWeTz2sf5B2iSNhzsbE
	5gcy2WgX5aho+zr6GvDTkY09PmyyZEApyXVfl5mMBAFmU30btQh3lxbjlw+15+iV8yEnSzI
	dRfQa+I9bnOB9956b9hY7NWn/kdM9nHmxpL6yoQh6Ih5NQxgDCrHAaQ8PALO3w/GeZLObrs
	wJxiRooSbFukJNOriPXlz4j3Fdi6TeIert0ljF0ucb1QsCle33aGiB/2wembNE/xxMmCZu2
	T2U79QkvHQ9wJ0JphxnkFPB3SXYa0AA8rx1vexaA+1T9pxmCDUZCWh56Yf+bVTGU8Q2HXN/
	4ww3rdqukiVtWXCU7fNSyRQllns8TtyjD1veP4STJDdywzRwUkGN/9wWOTiNzyG7KdCXZQa
	O2H9Xz7ER0/FaxbMA8yZJqqrtTtp9LGvvTvVDlzpE52eAop9oFEP9dyYt2UFc1CT/a0LnDG
	pnG8SS7EzCeRd9GI9OkjJNoVHPhQJmBmVp2ckKdIatb24zKf0ktLD6RfN6wmAwHOYiGCvcf
	1+oJ29d/2znuudqYf2xJGVT3glXsUdHLBtvNyRhUd098yBLyn24Cf8Sq2NyCoK6qE9gkk3H
	QlDJAQuJPW0Ty9QehBb1j+mDdkxNxXTX7wTI0/FcA/KRDL7hWtF+Lgjgs6TQKve+dBs42ZE
	A==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-303454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mucse.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dong100@mucse.com,m:yaojun@mucse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFF836E9717

The rnpgbe mailbox exchanges data through 32-bit MMIO registers in
little-endian wire format.  The original code had two problems:

 1. FW structs with __le16/__le32 fields were cast to (u32 *) before
    reaching the transport, hiding the endian annotations from sparse.

 2. No cpu_to_le32()/le32_to_cpu() conversion was performed between
    the CPU-endian MMIO values and the little-endian payload, causing
    data corruption on big-endian systems.

v2 fixes this by introducing union wrappers around the FW structs
and adding the missing byte-order conversions in the transport layer.
All pointer casts on the mailbox data path are eliminated.

Changelog:
v1 -> v2:
- Remove all pointer casts on the mailbox data path.  Use union
  wrappers (mbx_fw_cmd_req_u, mbx_fw_cmd_reply_u) that overlay
  each FW struct with a __le32 dwords[] array.  Callers fill
  named fields with cpu_to_le16/32() and pass dwords[] directly
  to the transport — no casts needed.
- Change transport signatures from u32 */void * to explicit
  __le32 * so sparse can verify endian correctness.
- Add comments in mucse_read_mbx_pf() and mucse_write_mbx_pf()
  explaining why memcpy_toio() cannot replace the readl()/writel()
  loop (the mailbox uses 32-bit MMIO registers, not byte-
  addressable RAM).

links:
---
v1: https://lore.kernel.org/netdev/20260617083531.251119-1-dong100@mucse.com/

Dong Yibo (1):
  net: rnpgbe: fix mailbox endianness and remove pointer casts

 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 26 ++++--
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  5 +-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 82 ++++++++++---------
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 14 ++++
 4 files changed, 80 insertions(+), 47 deletions(-)

-- 
2.25.1


