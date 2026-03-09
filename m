Return-Path: <netdev+bounces-265768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIWbKdA5r2kPQQIAu9opvQ
	(envelope-from <netdev+bounces-265768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:21:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD8F241913
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 22:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D0FF30244D8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603A92DC76A;
	Mon,  9 Mar 2026 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Qc2xbnpi"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC025A2B4;
	Mon,  9 Mar 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091278; cv=none; b=EhHpxgm4/cuXTn4HbETIftlAulCQL2+qrpM57juB5PGXbR18n6WMT56eZFuilwFiP7e3FEgy9ZZG5ymrO2bi1ZY+IPU6ISy2OPXVWVGuAtVdWpmrJV7+VstvCJ4Lnwji8idVBurHrLla48brgxIecW4+sM6IySdPPU4ABelZ+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091278; c=relaxed/simple;
	bh=nd/1n3VdfhJSGBvD3Xr7ncEBlNZMS5jiyOT7E7O689s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZzOwiPtmVOMcfdo44+gjvYIeTDJ89E5rc43+fCRseAJnS/pii6TgAryhWOrwjlSvkdCAu42Pte1/H+1u1W3/YF5y0t/ZzAl5orFIEr1vhzSt+f4MjvJ8DxblzBaQkud1C/HceFM8AQFezK+zrl5sG85qjEeRn282RDUSmqW1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Qc2xbnpi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 20C6220B710C; Mon,  9 Mar 2026 14:21:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20C6220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773091277;
	bh=MAn2K1+Ub1L02MCyhWyLXhSTj3Aa/+L+stijV3Wcpio=;
	h=From:To:Cc:Subject:Date:From;
	b=Qc2xbnpikdM32h2rEuHMDmolnS1QrTX7KFoRuOO3/T7xn4NKWsro5hzwMsMosXWk8
	 hEdKlc2vPYB/OR8MbnA1EuTU6tdV1jK3tzEvKIMEzyUW15cB9l67HvAppiDEkdFaHX
	 2J+b5I4s/G4xFJwy5YXgJKuWWoGQ1RdJEBLuyY20=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH net-next,V4, 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS and use it in MANA driver
Date: Mon,  9 Mar 2026 14:20:42 -0700
Message-ID: <20260309212106.764156-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BD8F241913
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265768-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Haiyang Zhang <haiyangz@microsoft.com>

Add two parameters for drivers supporting Rx CQE Coalescing.

ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
Maximum number of frames that can be coalesced into a CQE.

ETHTOOL_A_COALESCE_RX_CQE_NSECS:
Time out value in nanoseconds after the first packet arrival in a
coalesced CQE to be sent.

Also implement in MANA driver with the new parameter and
counters.


Haiyang Zhang (3):
  net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS
  net: mana: Add support for RX CQE Coalescing
  net: mana: Add ethtool counters for RX CQEs in coalesced type

 Documentation/netlink/specs/ethtool.yaml      |  8 ++
 Documentation/networking/ethtool-netlink.rst  | 10 ++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 93 +++++++++++++------
 .../ethernet/microsoft/mana/mana_ethtool.c    | 75 ++++++++++++++-
 include/linux/ethtool.h                       |  6 +-
 include/net/mana/mana.h                       | 17 +++-
 .../uapi/linux/ethtool_netlink_generated.h    |  2 +
 net/ethtool/coalesce.c                        | 14 ++-
 8 files changed, 189 insertions(+), 36 deletions(-)

-- 
2.34.1


