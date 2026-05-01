Return-Path: <netdev+bounces-283182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Kg6fAB6t9GkwDgIAu9opvQ
	(envelope-from <netdev+bounces-283182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 15:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 508D54ACCA8
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 15:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A929300B558
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E73B27DE;
	Fri,  1 May 2026 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8ldFaQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319F36921B
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777642779; cv=none; b=R6XnoKmwfrgAhkcHWIe19b9bC0HF5LgMptp/qjQe+0eKG48XB/5DRf7LJfnujV8iP4xNVABGfK/Bb/NIUiQBk7SF06z09YM+iKdsB11/WiBtEK9wqgK+0KTxjXEPXDXQCyMeN6mt+IQTpXFKZCcBx4OZRup3nbjZBzBhQP1poBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777642779; c=relaxed/simple;
	bh=MCfCjYdl0XWkEjIaPEDCZdv+RgP7gA9P260x5j3Xsog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StiW1ZuB/DX+zTlTdpw8DD/2PC9ydkyh2LEPVK+h64QeR3uZnauBGkN7tL88+78WDevfOwoCl4t8nsSuM4w+ELjFgWg2G+9FhhCBhORd27TVX4iV4oiq3iPWhJXwarqSWRVUS3elXRNDAUPAKEo/BF8DWcw6wXF8C3pwOkxHN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8ldFaQm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7963df6f17so1191538a12.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 06:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777642777; x=1778247577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cssEscy0p2FNGQBzJbELyna0OySg7slhF/olyd4D58=;
        b=k8ldFaQmGnJyBXK9sVvvo8VcQbETu6vg9pzMEjwGhL4i3CkAoi/aNBzEPLhnZYl5X5
         K8hU5TgIb4JpDZj21Rg0KjMMFJ2r6bl9I316oUmePTiEd+xmGSj6LYj2052dQRLumIAv
         ifsRsJVhnaMiECwdmGDEG+Cq0OKIonpJOzXABJ6jIW9fVmHPaxbxge7p84zh09/SzETU
         qjadB855O+HpfpM1MtBgxu7W9Z5DA1h2W8+UD1gbgo79g2dV6mm25bxFvgmoBhztzFj4
         GT3r3SWZcHKea/BJKh/Parvuj3WPDdja544iyvPUefyexpFVcejofgMaGE5H/c0NZqN/
         ytQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777642777; x=1778247577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cssEscy0p2FNGQBzJbELyna0OySg7slhF/olyd4D58=;
        b=jP1BpsPcu6TS1YfUXxEXQ3HE15WSNq1BRM38rF88xYufjN1ryuEE1xkT7BZlVVPPN2
         Cfpoc2QAGbivQRTFVwnE1bp4cNdEkz1rrLr2fj83tImxm0VfTHM2DTMtg//GRMzxAGN5
         Fv5Rg5DVP2evWx6tHsM4AyZKudnrkqE4Ejkvk4aJRr3D+fuSElFLk6sAWfOoYxoDJkOu
         NvcO1DVxjN0JppO3ZREeW0gWXtUPjFETSVzP1oRNjvcIPfdELy2/VpanhDu9BlFk01fJ
         hPK+qQlIGo+wjO8Oss8hrpMHv3BehclkkCGGckcGxjZN10EW9ynDQ0hxVMpEVUBV4Dm1
         HJ1g==
X-Gm-Message-State: AOJu0Yz9a0hdq1pjoGmWd5UnmL7LG90aFPhpuYP9wQrSyuPax+obYR+l
	Kw68wpCu7z+/tJquOPiv3rmP2ZZftHzPbj4pvQqvQH5vyCAet6yRPDtw8Czy8bGv9fW93A==
X-Gm-Gg: AeBDieuKD2S6t4raN/lBymfHR7IiVxZbzvFe/plu+ZL+CV0Xg5nZo8DicvOkha1K2mK
	tGMBKHoapqOw5D3Ieey0Kp2gv5HBEpaUyrY9jQT1TPzP97EjkRLnA0q18SbVYo8cZ/c946M+3Dq
	sl652er2b+HfWseZ3S+YulOCmFN9hBeIyRYzmmb6oVa7qhZmGt6Z34S91eW3u6e29/MbHTz6peN
	9mo9zJ73QuufkDFz/hOZ57su/bq/K05ePqS7oa4snZfvbBHSUX8YA7t+4ZfHzkcYP7XRnj8WEz7
	lSepemZ8N1KjhfqM0yMVCyzs7j5bjsmnK7w0o1X+KNC8oEXiChNI6ILxBTuAlSNf5BGT8Mg3EDU
	kvixh8ng90ioaS+3E7UJt2cc0jWitPBycLNcKdjUhXo6Dvtd6p5kxveQw1Ovn8o0MjqyvxCmX8K
	wMIHA+tAIxRI3cFiOmMI21enzwccI=
X-Received: by 2002:a05:6a00:23c3:b0:834:df57:9d31 with SMTP id d2e1a72fcca58-8351a4028e2mr3213177b3a.28.1777642776842;
        Fri, 01 May 2026 06:39:36 -0700 (PDT)
Received: from houminxi ([38.207.130.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158aa1ffsm2548386b3a.22.2026.05.01.06.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:39:36 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v2 0/2] selftests: openvswitch: add pop_vlan test
Date: Fri,  1 May 2026 21:39:21 +0800
Message-ID: <20260501133924.3100680-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 508D54ACCA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,openvswitch.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283182-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This series extends the ovs-dpctl.py flow parser to support vlan() and
encap() match strings, then adds a test for the OVS datapath POP_VLAN
action.

The ovs-dpctl.py flow parser currently cannot express VLAN-tagged flow
matches.  The kernel unconditionally forces an exact match on VLAN TCI
when parsing flow keys, and requires both OVS_KEY_ATTR_VLAN and
OVS_KEY_ATTR_ENCAP for VLAN frame validation.  Without vlan()/encap()
parsing, no VLAN flow match is possible from ovs-dpctl.py.

Patch 1 fixes two pre-existing nla_map type bugs: OVS_KEY_ATTR_VLAN
was mapped to "uint16" instead of the correct big-endian "be16", and
OVS_KEY_ATTR_ENCAP was mapped to "none" instead of "nested".  It then
adds the vlan() and encap() flow string parsers, dpstr() display
support, and proper ovskey instance returns for encap.

Patch 2 adds a test that uses kernel VLAN sub-interfaces to generate
802.1Q tagged frames and verifies pop_vlan via pcap at the egress
veth.  A negative check confirms tagged frames arrive intact without
pop_vlan, then the positive check confirms the tag is stripped.

No regression in the existing OVS selftests.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
v1 -> v2: rebase to latest net-next/main, drop --base=auto

v1: https://lore.kernel.org/netdev/20260501122756.3081754-1-houminxi@gmail.com/

Minxi Hou (2):
  selftests: openvswitch: add vlan() and encap() flow string parsing
  selftests: openvswitch: add pop_vlan test

 .../selftests/net/openvswitch/openvswitch.sh  | 132 ++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 190 +++++++++++++++++-
 2 files changed, 320 insertions(+), 2 deletions(-)

-- 
2.53.0


