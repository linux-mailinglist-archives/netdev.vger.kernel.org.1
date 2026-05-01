Return-Path: <netdev+bounces-283171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLhmL62c9GloCwIAu9opvQ
	(envelope-from <netdev+bounces-283171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 14:29:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E14AC65A
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 14:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B38E30209E8
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9D3A2570;
	Fri,  1 May 2026 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdd9PcBc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71363A1E9E
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638490; cv=none; b=lO+Zbh8Tvr+S0icjnk8KNe+SFs7nXluJrgUtp/NGXeG2oKcTtoNsXibaVS9NFdrtMyFBr0x4tj7kTzk5h2WXARW2D6twQS69ykIjo6/ZyY/gw8MyYi4lgchZ+S4QGINg8Vw/UhDt7FZ65WCuBS7lCI9Fr+xo2gSeN+GOk9pMIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638490; c=relaxed/simple;
	bh=OBmgcolYEQMKyYQrSi+CBFo9fbF6RvfMpIQNEXT146E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uL5PeXTM7azOXaRDSJtKruOoP0bJAYD/4Nu70rG/hJlJdqLfAtds6LUkst+p5Ifww/EGIcAcGr5Tn+13ZZ+BRrX6e14nEc+ipkyySQyQO3EMt6v5l38BM4FZmlSbN/dv1lPW3oX6fHEe20E3kbgTQfCVEU7XngTuZ5ExPmdEcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdd9PcBc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b941cd869cso11439405ad.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777638489; x=1778243289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMtmjJ2k+w8uEBLIAQrkz6/bI6nhEEnnsMvMljpxvdE=;
        b=Bdd9PcBc5OdjZZm3Fq0p0c130lTEO/gxPkTZP2874KmpbJPyck7FXZN436ciybcJFw
         ceohFe4WfqdZOrtJ0VlCaCh17C/PWDHrX4mETFemSU/XLZTsEVfbIf1No63aYmZ/oH1H
         6E7XuaaM9KUnYCXamFK0J9YhkWhnlzDyxSWw8AbLc/TMN97Xyn43byHx/tpEmhz1edR2
         HiYygkooE5rNCNqzOSKLOUHecTKD/56uAqhAIBTtv74bxCSYN3fv8vhsPxKrcXRZL9wz
         FNzjKJzBwJnTk/VeAxmj6ejP7bHB3UhhPQXPdsb4/eM6SIE7fmeVDcfxp/d9oyZGaa6b
         CCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777638489; x=1778243289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMtmjJ2k+w8uEBLIAQrkz6/bI6nhEEnnsMvMljpxvdE=;
        b=IBemB0u0PkkPbibLTkIdkh2M5PWqxqJXykyBkTlNSXVtmD5kWzClLW3km0CwXxy9Yb
         Ld0D2WhfbMxt0kZSKR/MzaLbfXK8f/Y5vWOl2EwxvcG3v8rrWhE44qkmpHYo4FF1nLh/
         I6SgU7giKKAG0jSbYKjcEC8d/jSA4I5gJCDp5NwF4gxpKoNVUuENLGVtLRf55lbsRODl
         0yS/qRcl9Y+DxIc/1gHkV5JFuxSKAGUVXwvV1c/jLgoTq/JoKPeUwb6aI1CHM/CA2Wnf
         iym88vyfdIRnC35ydgRV70Cg8JUxxaYA64VYkuuD/xGdOvSZPGl19mKgdwqvWTj/g+b+
         f+Ig==
X-Gm-Message-State: AOJu0YwsrqYziYgAW91E0sNIe8So0J0tGJu52qt0YWi7zQLEP169FBrv
	yAtYelyYhF/rr6sBAKZO5aoDhgqba9NWhJTGwh2oZKjSG8lnvsdzXxvvivYcrZkFXZs=
X-Gm-Gg: AeBDies3ee6nhwEyQwVivcz1vhKClNEnFEPvh1YjLdkqyfrRUWaWYJJ8Xjf2wKuN58b
	VzgwDzBYOT4FHIrMVsIJZJig0uiQNC3dYitRf7lHE5vpqLmMeEQNo/sr42sO5ENZzxUMrGBr4pZ
	GoqY8syu9w9vCNWzavT3Hrwh3ObQBjcb1+bOx4/AWQ5D9LPQOPr/rlG34WGO3UkPdLwxpYQDY5n
	LATEciHLPdpkxQjWjRGoY8rmxoW5aEYWswUq/AEMurAAWd8gVV70O/BO65cb9pFgHTZ8AghJc80
	yT3m5p2X5gTcmWd1EfzY6U1zD1chtinxtc5zb1j7E4QgTpPb7UdD3VyWHUpSBj9h7rqwGQwGB1p
	adkAJrYchsBSFXuVSHqZtoS/DwcxsD2FFk8cCQkibPUdS00g3tc1RipX1I4Ju7JNYIGngNkSHlC
	Q57bzb9AP8vgfrUdzm4EtTpUTm6co=
X-Received: by 2002:a17:902:7b8b:b0:2b4:6470:760d with SMTP id d9443c01a7336-2b9a23438c4mr52827555ad.14.1777638488824;
        Fri, 01 May 2026 05:28:08 -0700 (PDT)
Received: from houminxi ([38.207.130.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9ca953894sm23370395ad.0.2026.05.01.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 05:28:08 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next 0/2] selftests: openvswitch: add pop_vlan test
Date: Fri,  1 May 2026 20:27:54 +0800
Message-ID: <20260501122756.3081754-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 287E14AC65A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,openvswitch.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283171-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovs-dpctl.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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

Minxi Hou (2):
  selftests: openvswitch: add vlan() and encap() flow string parsing
  selftests: openvswitch: add pop_vlan test

 .../selftests/net/openvswitch/openvswitch.sh  | 132 ++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 190 +++++++++++++++++-
 2 files changed, 320 insertions(+), 2 deletions(-)


base-commit: 4baf2415992e3051cb39b831191d12cb7e85ab60
-- 
2.53.0


