Return-Path: <netdev+bounces-283593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Fr8WNB0792kddwIAu9opvQ
	(envelope-from <netdev+bounces-283593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:10:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2324B57E7
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F5C300679D
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08E3AE190;
	Sun,  3 May 2026 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CstfVs7A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D175C17B43F
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810203; cv=none; b=Zpkah8AGefXyn3h8DAYqPJs/LDV074cUmGHazNYXV+zrIY14psLIM6i2bYnEb07o0kwcEmIrCPspqVZrlFULjGrlnomNOdb59hucgM6fW0RQPlyZsN+qGGcGx+Cy2FhTiuHwczxar6RmpGZwqXpbcrm1YTbc8gjiCsDXYQgzLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810203; c=relaxed/simple;
	bh=2flNeLUiCIrbtqKOmVYqtZd9qLNEvgjPfbxF/XM2A5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foVUiGh2/sDRL6U/gXanGZm36w4d4e7bArlBrdHZUbJySND16aMvFhVX/dSEoBg9SSjFg97BsNnKGAx20gaNCBIICPnvPbJkxrbxgJLCaNH4g7QT02eTqXleQXb8DKvhNUO68BYMr5T7ilLZTcHnr8pNZnR88DQytfdhJP+ttOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CstfVs7A; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so1411018b3a.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810201; x=1778415001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SNwn5bZUqz03sFUDUBWAhIjrGPBXt2IlyrF4Is/zWk=;
        b=CstfVs7AE4jTfyDo7AN/wyikCBiG75RIMPTt472qhWuhtmkPCqFJdBaItItZ4jVycx
         G6U3lRy5VPVInrh5W20tL23h62dENKLYG5aQWlAvEXFerIJZzuhC9TwZmomIG38/orbk
         LJVQAwuylh56agmH2PNXGjUi568NcUEje5/Sob2mQKbz9AmZ3LY3ukWFDHtaiZi0eBaT
         es7EuBXyCuDL8h5D7TULPhj3fQvGM5XVM9yDCfWwVMcMQD6Ms5qdJ8HmmbXZWSkuJyaX
         ER0tRJliYuWSoOZuCmIvMy0DyJgrAyfjin5szMFSFwUIkrag0RpTp7HPecNRpmxslyz4
         myrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810201; x=1778415001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SNwn5bZUqz03sFUDUBWAhIjrGPBXt2IlyrF4Is/zWk=;
        b=jyAIWAK0o4ynP/qSAnU6MBUDuMK19g3tZ5c9TIYCFYK3kY5YNDVPeoH2yEwVIJiilo
         vem6uTUlaiY8WmxUO6NLtEerIB6WAYiLh2rfwe7NJo/cC/K4epuo7Da7vU4HxR2dVFe/
         D8BP5V1hrA7q/dyQJDtFnlwwTTKzoIHaquCesw8cDMNmP5SKD8RdAlWyfBAneQo/xur2
         aeHKIE+coHM9wM7lYDcOI5Blt5P/Jxem26wtZzoX7wOQs6hBBMCknuUVLa3EQpSk/WD2
         j2QbDP5uk0ychJTgx7Fxc+/BFbG9HeQREfH7hE/7I0g0EP6ZWJAzkxaZ2ucaJy4F7XZo
         PI1A==
X-Gm-Message-State: AOJu0YyeKwppmg2/NVbBFdt67+gJyL9UbMUsVJnxg+8dA/1HypW36lkU
	11P3TWQ4xyUuylDGZTabzHjmydH1J2dFsnbM64GL4WzAxMU6YRBa7kSKpn/QqmJi62/bJA==
X-Gm-Gg: AeBDiesHvjkzj4Asq/G7P8Jjw+39Rzih+fBIU2G3balysLZmrFMAbqhB1aJpCaJeqhF
	LUecMBhlQfnykTbNUb5aAfKyPhgQHInJw3IM6XWnKMDjgt1IZt+z4UL3HC6fGvTKb1+ucAmB/UP
	GStvAcNSoNExR1THP63kGG5YtJ5YnFCsVO9R/oq3Yj3wpOS0mMcrqMXia2J8KjKp2g4arXR3+tN
	+4dc7e2NeS5g32RausZoSewHBTvUyoGh3EjMgSgVhw+emxMiD4fmn3Sm1B2heltJ2fcWae6TiNy
	QSAp2769yavK+sjE8qhxdJGPtUXDt+6Zql+TXuhz9778J4/ZMYoAO0aDEU/dUhpRcrh3YKbmsfJ
	6kX4XIgfuP/ORaI2ywcsFpnllKD5afYzfYn0/2rJeA5pEB/r2ubSN/MzJEjN8bngb9VPT5KVeev
	kkwlCpldE+3inZ/BGiDa0/UzhwP5o=
X-Received: by 2002:a05:6a00:1a86:b0:828:d9a1:c5f9 with SMTP id d2e1a72fcca58-8352d240028mr5505126b3a.33.1777810200538;
        Sun, 03 May 2026 05:10:00 -0700 (PDT)
Received: from houminxi ([151.242.165.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515acfd8csm8240218b3a.29.2026.05.03.05.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:00 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v3 0/2] selftests: openvswitch: add pop_vlan test
Date: Sun,  3 May 2026 20:09:44 +0800
Message-ID: <20260503120946.51869-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D2324B57E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283593-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add test_pop_vlan() to verify OVS kernel datapath pop_vlan action
correctly strips 802.1Q VLAN tags from frames.

Patch 1 extends ovs-dpctl.py with vlan(vid=X,pcp=Y,cfi=Z) formatting
and parsing, plus an encap_ovskey subclass for safe ENCAP NLA decoding.
Patch 2 adds the selftest with baseline, negative, and positive checks.

Tested with vng on x86_64, all OVS selftests pass (including new
test_pop_vlan).

v3:
  - encap_ovskey: MPLS type "ovs_key_mpls" -> "array(ovs_key_mpls)"
  - encap_ovskey: PRIORITY/IN_PORT set to "none" (metadata, not in ENCAP)
  - _vlan_dpstr: cfi=0 falls back to tci=0x%04x for round-trip safety
  - _vlan_dpstr: docstring updated to match cfi=0 fallback behavior
  - encap parse(): check return value for unrecognized trailing content
  - vlan parser: add boundary check when both ',' and ')' are missing
  - start_capture: || return 1 -> || return $? (propagate ksft_skip)
  - on_exit: moved after resource creation, not before
  - ping success: changed from NOTE to FAIL + return 1
  - VLAN interface creation: added || return 1 error propagation
  - netns probe: distinguish EEXIST from missing CONFIG_NET_NS
  - sbx_add: || return $ksft_skip -> || return $? (match sibling tests)
v2: https://lore.kernel.org/netdev/20260501133924.3100680-1-houminxi@gmail.com/

Minxi Hou (2):
  selftests: openvswitch: add vlan() and encap() flow string parsing
  selftests: openvswitch: add pop_vlan test

 .../selftests/net/openvswitch/openvswitch.sh  | 192 +++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 267 +++++++++++++++++-
 2 files changed, 451 insertions(+), 8 deletions(-)

-- 
2.53.0


