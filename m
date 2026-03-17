Return-Path: <netdev+bounces-268597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMhdFitNuWm//wEAu9opvQ
	(envelope-from <netdev+bounces-268597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:46:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E882AA14F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63B50304B830
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607BB3C4547;
	Tue, 17 Mar 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LVGZSehw"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F553ACA43
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751587; cv=none; b=kfa7+d0B8KGUnvXDJd43/2UnQuBPWUI2ukl3LGc9f7vFzye2/EDyhploqkjbJrQiwf85Gw+KvJOCw0TwibADtu5HLLV+WRDUteocgCptDZT2lnMNMX6t9NsanMc6xRHHyxzNBEBLI+TrGodD0313djt+11AWyBj/AboRR7tdIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751587; c=relaxed/simple;
	bh=H+i7baUdVADCEmnsbi83752ZaNlDlaNzpdPDDZHYxQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqrN1qU30FXcjgxQkPLFKXlJz2qd2H9s9LtN+DnBxb6NkoxjcIe19GnfRUewZxxXBsdRGN6eJCeuyT2qgDcZb8GcF2xrqLZdTQsZkQDgSBEMr7j4AwbudM+22L2oEIaBB8ni/S62QxpKqAHz3yaVHtnuT4juYlrPDx6oSYs8hzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LVGZSehw; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773751574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dOVavYy0n2C8czHAJEk7oEi8c3Gg9gupOZ2rTN3VHhc=;
	b=LVGZSehw8R+0s2klgR+AhhLLWVtaiCum3cT1Hps3Jvza8mbPmrc+YIUtMO2wNGm+gn+Vem
	d+hCvDBpkKfyhqGoOM5qyanpYH4oAvhQW8uTK5u6hEgGxqvewZYUJvYHrGzmNVm04+UBWW
	VDSy54EYG5ZPeqIJ24XW59OxFeziIUI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 0/2] team: fix header_ops type confusion and add selftest
Date: Tue, 17 Mar 2026 20:45:52 +0800
Message-ID: <20260317124606.157035-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268597-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: C3E882AA14F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patch series fixes a panic reported by syzkaller in the team/bond/gre
stacked non-Ethernet configuration:
https://syzkaller.appspot.com/bug?extid=3d8bc31c45e11450f24c

The first patch fixes the header_ops type confusion / parse recursion context
issue in team. The second patch adds a selftest to reproduce the reported
scenario and prevent regressions in the future.

Thanks.

---
Changes in v2:
- The same fix approach was applied to bonding first, but could cause
  infinite recursion in bond_header_parse(). Eric spotted the issue and
  fixed it in:
  b7405dcf7385 ("bonding: prevent potential infinite loop in bond_header_parse()")
  After that fix landed, we continue with the same approach to fix team.

v1: https://lore.kernel.org/netdev/20260314062306.212765-1-jiayuan.chen@linux.dev/
Jiayuan Chen (2):
  team: fix header_ops type confusion with non-Ethernet ports
  selftests: team: add non-Ethernet header_ops reproducer

 drivers/net/team/team_core.c                  | 60 ++++++++++++++++++-
 .../selftests/drivers/net/team/Makefile       |  1 +
 .../testing/selftests/drivers/net/team/config |  2 +
 .../drivers/net/team/non_ether_header_ops.sh  | 40 +++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/non_ether_header_ops.sh

-- 
2.43.0


