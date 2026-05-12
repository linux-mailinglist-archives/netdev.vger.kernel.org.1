Return-Path: <netdev+bounces-286973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJWCDnTSAmpJxwEAu9opvQ
	(envelope-from <netdev+bounces-286973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:10:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80F51B83F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33FAD305669B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BE3D4120;
	Tue, 12 May 2026 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrS2u+ia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78CD368D68
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569746; cv=none; b=M1wbrOTzQi3plriKjo7LNBN6umDPLTUAR0uYWdq3ReANyeWFZPfTzZyR8MmhFxYZ1C1GU4bNLZ1Ake1DKGXkGSKPq49LOtYT3rL8g/ZikQIREUkQBx9XxSbl0iMR1oTvRssbU9eDeQCdgQ6r9HcUvdcuSWXl8aZFjj0VqS5khYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569746; c=relaxed/simple;
	bh=gTpTMvSvFJ8GP4FRzcczUt4KNmNWQ5lbqdKG3wswn0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxJhVd922wbOfADM/k0uGHZ5bzlGtRXMj+9aXkK9cHPvlvPXB6qfvUQrlMOFTM8A5CxGVRd80/Fx1YfSP8ONdl4l3fmoti0im7Zzmmv6RfI6zJK3uyBsChJVEL2QdBmrbtI6WlK0L3VxD5GWgWvpFyIG7360ViPaWP8JetJPm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrS2u+ia; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d55b97f358so3628439a34.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778569741; x=1779174541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGMIjlJ1jx9Y1YzrayP6UPnE/naew0CuHij3QAkOKtw=;
        b=PrS2u+iae/NXDEH6CmKUsQ9ep5OU4W9F9uebtx36QZ8qHHAn6rX4bL/U5Iq7M7kE+H
         lZ0EgEKClixpjpnoCF9zsU5vI9Hw2+ZLwsGPDn+d5BJhlV+Ot64LRDRTm9uP2gxu6X5p
         llMeWYZQ6u6rDqVg6q/J5bY4y1kvIPVhkPxHPpF4akEKXSPMD0o3JMZ0kND5UWjrg4i0
         7ttP/CAz54FyR7ySuOqBjUwsnut/aNkUlXNcaGkeO3AAM38WJAe6IwA7wa36rlFWtWdm
         8DprbovPxi5H9pkot7O+dMTh5+HWegXYSTGN12MXtchyUq/oyojPr5BtAVZs1cgVgRTF
         Tw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569741; x=1779174541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGMIjlJ1jx9Y1YzrayP6UPnE/naew0CuHij3QAkOKtw=;
        b=Aulb+BSo1vxH+KcWFOdT5V0li9xa/iryfkAd1Y/G8lrF3x++e4vgFvlVZqbmoV9c8i
         tOUcklgkds4NuEj4jvsgrjoFQfvHOf+DkjkeXUVYcMoWFMlvhJUV6Tri0ynuFFW8+ODp
         mGrtHHlOaoRzTfIqgdil1H7pVLceihQMLaQmouuvBtVkpC6mzd/OMFTjV6PInyEnGab7
         RC5EHPYsiK61elRPzwd3yY1Nsk8PpbAEMUrCGgXoCh12uK5EuZZPRmsCLdMp1Pj21QG7
         XaZueqH7SQKh9uQdsz7ySSnyYihm4UPeTIJyBMEPBAhwJK8ytYhOYRXjlqt09wNhIZf9
         1HNQ==
X-Gm-Message-State: AOJu0Yy2HUZZ76ovsAP47G0zz2FbULoL5iBfbN+GUXlRVs402+yBkJrf
	oskX85x5oyZFt3w38pLopF6ayy/GCBn0GX0UQFrwK9RJLFkRhANje5J96wVK2WLqKv1E4Q==
X-Gm-Gg: Acq92OFE8k94W4cdGOyzhgXTnwGmOHqRvjF12KsaQthFGkEEd7/8UdJGVqXy0fPMene
	NcDkWN4jLafXgnUJQx0fh7HB0+rFduyxHr1x5t4/uogpDzIDG+dxL2a6zOBy6ySlDei3SiKgyIw
	OhPC9mUk1D/L7AJiGZdB5STChgf8c5CSsWiSQal03s9Ln11oUclcF7zIiP1HoUvtj0ihIWWWzyI
	0vY/frjQ9C+9miIYeoflDy7BE1tUi6ry2QSktX/XchZ0xV5rsYgUfYvcy/w9EPB3+fnXGZ/Eo6o
	J7DyJVxTORzCt+dK3/PnpuHn1ctvJRu6cl8uwjF0oz+90O3Ax02zacKQNIFRijVVI/O4+Kqzg1u
	aUCpEBDwsrmMMtV++7/G1OPoWqxhZGE/SCxqSAU1cE2oS2QJfLPmcUOumXFBNHkMhGZ3sbuOAN9
	9eUBX196qdZcFj0VI=
X-Received: by 2002:a05:6830:d81:b0:7dc:cd0b:58ba with SMTP id 46e09a7af769-7e1dee8f954mr16403178a34.4.1778569740857;
        Tue, 12 May 2026 00:09:00 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367a18481sm8417658a34.0.2026.05.12.00.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:08:59 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v10 0/2] selftests: openvswitch: add pop_vlan test
Date: Tue, 12 May 2026 15:08:39 +0800
Message-ID: <20260512070841.1183581-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509135423.3433910-1-houminxi@gmail.com>
References: <20260509135423.3433910-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F80F51B83F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[openvswitch.org,vger.kernel.org,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286973-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
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
validation).
Patch 2 adds the selftest using purely ping-based verification with
a push_vlan return flow for symmetric bidirectional testing.

Tested with vng on x86_64, all OVS selftests pass (including new
test_pop_vlan).

v10:
  - rebase on net-next
  - fix masked VLAN dpstr round-trip: use tci=0xNNNN/0xMMMM format
    for masked vlan() output instead of vid=X,pcp=Y,cfi=Z/vid=...
    which the parser cannot re-consume
  - fix int() base handling in _parse_vlan_from_flowstr: use
    int(val, 0) for auto base detection instead of manual
    0x prefix check
  - fix commit message: remove reference to nonexistent
    MAX_ENCAP_DEPTH constant, clarify "encap parse()" scope
v9: https://lore.kernel.org/netdev/20260509135423.3433910-1-houminxi@gmail.com/
  - rebase on net-next (resolve conflict with 05416ada37aa4
    "selftests: openvswitch: add tests for tunnel vport
    refcounting")
v8: https://lore.kernel.org/netdev/20260508134308.2857449-1-houminxi@gmail.com/
  - consistent error message prefix: push_vlan() instead of
    push_vlan (matches vlan() and encap() style)
  - unify encap() error messages for clarity
  - add empty-string guards for MAC address variables
  - remove slot number comments from encap_ovskey nla_map
  - remove explicit modprobe 8021q pre-flight check
v7: https://lore.kernel.org/netdev/20260507131541.2331771-1-houminxi@gmail.com/
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
v2: https://lore.kernel.org/netdev/20260501133924.3100680-1-houminxi@gmail.com/

Minxi Hou (2):
  selftests: openvswitch: add vlan() and encap() flow string parsing
  selftests: openvswitch: add pop_vlan test

 .../selftests/net/openvswitch/openvswitch.sh  |  78 +++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 324 +++++++++++++++++-
 2 files changed, 392 insertions(+), 10 deletions(-)

--
2.53.0


