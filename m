Return-Path: <netdev+bounces-284832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJVRBk4++2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:12:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF324DAC9A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 631E63008C2D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13E9466B58;
	Wed,  6 May 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/U2DIKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CB3F166B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073161; cv=none; b=Tf36+YaqalEMUB9UxAgXdd8dmJvpQ9xdkbGLYMTgv8EQ9OJD3DxcZkFhujjUUmpDERDzQ6p7gmkIuZWUsSvSZNRWXUhg9hSTLQt83a5Q287JjMRafJPkrwGjXwVIrp8tSjf6zWqW/S0zyuDCgEHYCqAMMiz6JTCd332DSczflJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073161; c=relaxed/simple;
	bh=X83K5mM1jYGkqZrBfO1Wt6FMuY7O2dGmxCA5gUpRXP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9kUTslHcVOlHrg+AhYefnmfV9M0A6UWIaZZRAF+/MwzD7ayBqbO6MEhqLGpB5DyyUavWjOAOKEL9cRTUGX+zyS22RhcyhTj50iAMfRsYA/aYNXv/f7C94vCEkNDi6rau7FEfjnZpkj293Z8VRTfRmKn0r1d7AXDnTST3psFvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/U2DIKE; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-42321c8b8f5so855657fac.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073159; x=1778677959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTEQSdm9N3Asj45KWJ/X8grv642fa/qSFTK0vp9knYo=;
        b=s/U2DIKEBP1H5O4CDwuuuR2Pr8w7yhZHpVdnzpOb77xI9lG/W2ksUET5RLClm3M7zX
         sz02BEefqYvil1c4ZRCPTeF2aM9jwWnAfBKemI2fPynvbbwanvOZzvUgZ6RAg1WVTaKW
         ONqGz3qeQf1eIWejbgECv4AEqLRvm4/NXFTE1WT6rP35ERTEq9Z6Xc/3OZhdGdqVAWml
         bAZwgPzONyhwGwvLn2gfExFz1qRF+j63Rvd+Tns+7+0QraHPM8/HMvOQNV+Boqh83o2K
         XK3AX3MoIA8PRYyyVVqWzpJh5TTywmfEaIDHfNHPMd1ShVbBsTt3eAGZ9GZ093A3bXcp
         BoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073159; x=1778677959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTEQSdm9N3Asj45KWJ/X8grv642fa/qSFTK0vp9knYo=;
        b=AweIv4QeCQOvjwGECi+j5alabf258usqCxUvvkkzI7jkUGUpzy062OrarB1DGrAyGv
         LPZHOPmnsee8q2EjLiBIPwhOi/dlO1zbTQUmm30PVvVK8ZelPjFxn8xgOelPa0nQTBp/
         1Ut40fOTBGtQ4bUNGcBCWrSYKrVBGStvT/gTug230vpTwvshruMwvxfxgRiV6gzF1MJe
         eusOHYwWG19hXegWusZtZ8QH/PIvWlX7mMM1UaSBURXj05zeGDtRpnZLcQkDANrMOmMw
         JQkrD9GpoqL7jKWvC1Gl6XlV1ZsKHBaHQtuWEr9LOS6mfGMUmZInTrGJ9SCDaFaIPeUL
         g0Ag==
X-Gm-Message-State: AOJu0Yxuq0oborUJttWHGn1p7Nf3HDvYpmrqTw8K6DzAnuA5/znoG70L
	qcIvCvhGqZzas1jHM184mwVxM+8EbQbK/v5nJluSC82dEPkIYmC2fjvPhyK61ofohuJt8w==
X-Gm-Gg: AeBDies/HF+1r3H40xhg8wvFSftt1YJvzrUF5i5OGrtqx2txosM3k6K6CLuVUzVY3Fc
	Xf6/9xnIjUJTkXsAllatWehcXwuRcKK1knPLxZmOCoQRTVDarwsXxTecXxYmXPmk9DQAH+VmGMi
	uiPgyu/2uhhhv9sgF9PfK+kcagMoGX5yGl4EDfE9negf3oqKE7GY6TAMdLw5Hw1J3Ew4w+I/iVC
	79CechYTmy6dIjtXryxBpgKbEZgNzZtrECMuxlHOjjwiaTCY5V/AyD6MpnYLSk9madUAPHEgrSR
	hsIbXJpGLbXmtsjgIzcyjfSFAeFLsAn+dK7AgY3eXZIRR0PKCb2O0nLvvLOkgd1YvzxP7HuOb2U
	UXZqtSqpRwjQwpn6NCAuVR49obYsJIYl/Dn2PLJ0pENi4KldWQ2xkX5EKOrXUmmuAsoQmLcQpYN
	0c8HYvngZNMdncfbwQ+FAwX25dog==
X-Received: by 2002:a05:6870:c04:b0:42c:b9d:8987 with SMTP id 586e51a60fabf-434f993e8c8mr1573181fac.10.1778073158763;
        Wed, 06 May 2026 06:12:38 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548d9decsm17327859fac.3.2026.05.06.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:12:38 -0700 (PDT)
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
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v6 0/2] selftests: openvswitch: add pop_vlan test
Date: Wed,  6 May 2026 21:12:16 +0800
Message-ID: <20260506131218.1880852-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFF324DAC9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284832-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add test_pop_vlan() to verify OVS kernel datapath pop_vlan action
correctly strips 802.1Q VLAN tags from frames.

Patch 1 extends ovs-dpctl.py with vlan(vid=X,pcp=Y,cfi=Z) formatting
and parsing, plus an encap_ovskey subclass for safe ENCAP NLA decoding.
It changes OVS_KEY_ATTR_VLAN type from uint16 to be16 to match
the kernel __be16 wire format.
It also adds push_vlan action support (parse/format with range
validation) and removes the unnecessary MAX_ENCAP_DEPTH limit.
Patch 2 adds the selftest using purely ping-based verification with
a push_vlan return flow for symmetric bidirectional testing.

Tested with vng on x86_64, all OVS selftests pass (including new
test_pop_vlan).

v6:
  - fix non-ASCII characters (em dashes) in comments and commit
    messages
v5: https://lore.kernel.org/netdev/20260505124957.1239812-1-houminxi@gmail.com/
  - add push_vlan action class, dpstr format and parse with range
    validation (vid 0-4095, pcp 0-7, tpid 0-0xFFFF, CFI forced to 1)
  - remove MAX_ENCAP_DEPTH constant and depth tracking (bracket-depth
    counter in encap parser already handles nesting)
  - remove start_capture/stop_capture helpers and tcpdump/pcap
    verification -- use ping success/failure instead
  - remove modprobe/netns pre-flight checks (other tests don't do this)
  - remove ethtool VLAN offload disable (unnecessary for veth)
  - add push_vlan return flow for symmetric bidirectional ping
  - use ovs_sbx wrapper for ping commands (consistent with siblings)
v4: https://lore.kernel.org/netdev/20260504123713.555461-1-houminxi@gmail.com/
  - fix all checkpatch line-length warnings in new code
  - fix pylint W0707: use explicit exception chaining (from exc)
v3: https://lore.kernel.org/netdev/20260503120946.51869-1-houminxi@gmail.com/
  - encap_ovskey: MPLS type "ovs_key_mpls" -> "array(ovs_key_mpls)"
  - encap_ovskey: PRIORITY/IN_PORT set to "none" (metadata, not in ENCAP)
  - _vlan_dpstr: cfi=0 falls back to tci=0x%04x for round-trip safety
  - encap parse(): check return value for unrecognized trailing content
  - vlan parser: boundary check + raise-from for exception chaining
  - start_capture: || return $? to propagate ksft_skip correctly
  - on_exit: moved after resource creation, not before
  - ping success: changed from NOTE to FAIL + return 1
  - VLAN interface creation: added || return 1 error propagation
  - netns probe: distinguish EEXIST from missing CONFIG_NET_NS
  - sbx_add: || return $ksft_skip -> || return $? (match sibling tests)
v2: https://lore.kernel.org/netdev/20260501133924.3100680-1-houminxi@gmail.com/

Minxi Hou (2):
  selftests: openvswitch: add vlan() and encap() flow string parsing
  selftests: openvswitch: add pop_vlan test

 .../selftests/net/openvswitch/openvswitch.sh  |  77 +++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 322 +++++++++++++++++-
 2 files changed, 389 insertions(+), 10 deletions(-)

-- 
2.53.0


