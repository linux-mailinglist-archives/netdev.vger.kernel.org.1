Return-Path: <netdev+bounces-285324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKwfGASR/Gn3RQAAu9opvQ
	(envelope-from <netdev+bounces-285324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:17:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 211514E919C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A57C03051E8D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650936CDFE;
	Thu,  7 May 2026 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPCtNcgV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894B3F787C
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159762; cv=none; b=pczFvQGhMZUUuWc/7NpBi4lznTEsc6mDDbTq7VahBTUhOrbxAX9IuU9/vk95XybykNxta643C1VMvDSUAOvXuxwMw77KXY/RjXiayX9ERMpvagW8EI6K91NWhpj56F4oCp9yPrvRwHMfd+Nv0bVo7obl2smDb5+Xju2US5Oz6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159762; c=relaxed/simple;
	bh=GAJMcz8BWL9uaAoIKrjqh8nuURhEgi33jD5g9qzyjtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAtYdIo6Qckg7GJTkRBuSX6qHtGnsmMzuiErLH2QoLSDO4ePIZqxFtA4kwLYex0XDk8NP5MKZC33rpAWTa2QXWW+uAYlzbpoirON4ffPTkr++fBCaLbQT2DjPLzuJjgM5/J1L9FGZQQ7daGgX3CJS8By/J604dlgVb1HfC8ZZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPCtNcgV; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbccf6a23dso713339a34.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778159757; x=1778764557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRvWNkmel+YHvL5LZc0SrAVa4019euEI2glulSMITOg=;
        b=qPCtNcgV8JZtMW82QSx7h5HphHH9bLRHp5Zgf0v0Pti661q6oDqinTmNSnIzHicFCt
         /W8Luuop+k9UBVS2j/8nRrwnBBoRVHKTmNBJNE6359i9tQCPavDHRq63a2x1XSF0FZAy
         iKZFtyKabviVc2nJW8LlVGjEKiwdQm/xG0cUW7PcgHo+dvXMiYpX0eHZ5LqWGTFep/ln
         obb/NoQSLK0YIRN+brG4g0anWC6G7t+AzVRhXbaSTzR3gYj4ewgIunnE8UtDMPCoghOU
         FnKAEkz1J0tqf9GSbafq1Zx6ftf+cg/r9CLpy8AyM4TLV27NXriY4BsoTVS2rvcKtaSP
         tX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778159757; x=1778764557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRvWNkmel+YHvL5LZc0SrAVa4019euEI2glulSMITOg=;
        b=bFMChrl2zj1eyrhgfMcpmMyVtzsqaFAiul0ttZQmP8KvN9VMltGvLJzZrIqDqDKK/r
         w+bY3J1lljh1ao0pJYjRqtukAEcLBZ/9COuHPhZsYzv4ejvkIRP9mMaqD1qDetzDmR01
         lhGjKMNb9jeBsTWSSQ1mZc92gk4R/VKULRQskHj8Hfd3kDpKrYoRNLQEOs75shhd9Aoy
         aDqUFgZvrQi92wTSvo2CMyOL7yGE5vC/4CCP2mqQO2X3pbfTzo0jKMv92pSSbA85MwmZ
         4Dmy906/K+DMIuWp9C1cZUEWSSUvUsrnJtP7+iS+FV1UN5a1LX2DO/Cnp2MXsmhoNu2S
         8iIw==
X-Gm-Message-State: AOJu0YxRKifbf9Jee3yUcLcQp0DFKHldTEblbzkQsv6QRKo1Z4/pyaf5
	cg2zfjKJcfRXh9CsUauDxQHowP0EavA17o1YDasTlKzQEUG+zPSch1LST6YGq9NpNo7Zlg==
X-Gm-Gg: AeBDieumVCvEcQfDV1RjYS7uheNAhgH8aVsZO4T+dqSH7/n1bLBlGTQUxabQ6JlSFS5
	aePPxk7nY01fghUw9kAo0XjEL5cLQ9F3UoCRxagENJAktncHeJLRxr4Baa2QZSGBU0VxVVHPiQH
	J+PsBZn6xngsQ0VSLSmEtAM7S5IFYTfx+Ip7cpkJ5RZf9g+LIxAPqxvPlkYxpuD8W67S2R1iLKn
	+n+vjzff9O/XjVc/U1LzLhuuQLxZRnAvLUOfVX/MLxi8fhiP46MJsmQEFyB4nzlrVmgYU0BFkUS
	TNmx9kMhPKS0GKGKF2fSnEb+yvvc4xaU9aGZ3V6X/r9fuoPTAEualiZX7VMec1D7ddJcFfjrUd1
	DOeyvw6e9e+v7C2Ofz8Y4IASNUrgiXvd49yUTHfFO3Tp3PwcoxyxmgPAkZzEtj1Ueq9CWBnke0A
	I1jFkYx3cWq1FPV/kM6P79o0aYrc7154NXa6dX
X-Received: by 2002:a05:6830:6a88:b0:7d7:d524:bc8a with SMTP id 46e09a7af769-7e1def078b1mr4464120a34.9.1778159757284;
        Thu, 07 May 2026 06:15:57 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca826dbesm14047117a34.12.2026.05.07.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:15:56 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/2] selftests: openvswitch: add pop_vlan test
Date: Thu,  7 May 2026 21:15:39 +0800
Message-ID: <20260507131541.2331771-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 211514E919C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-285324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovs-dpctl.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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

v7:
  - remove slot number comments from encap_ovskey nla_map, keep
    only comments explaining differences from base ovskey class
  - remove explicit modprobe 8021q pre-flight check (ip link add
    type vlan auto-loads the module)
v6: https://lore.kernel.org/netdev/20260506131218.1880852-1-houminxi@gmail.com/
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

 .../selftests/net/openvswitch/openvswitch.sh  |  73 ++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 322 +++++++++++++++++-
 2 files changed, 385 insertions(+), 10 deletions(-)

-- 
2.53.0


