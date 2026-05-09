Return-Path: <netdev+bounces-286184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Bn0Mak8/2kS3wAAu9opvQ
	(envelope-from <netdev+bounces-286184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:54:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C434FFEAA
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59956300A125
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F63947AA;
	Sat,  9 May 2026 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5FOyxK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268433F580
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334883; cv=none; b=i+9DJ8w3NPD+EDG9ulDg0B05JmUC+PDszOhcBVJPC27JONbCTLdKulww9RjtHEqkO9RPQk0cpKR2RZi1dpfuOpIwXIYh+u/91IcrLPHdioDyjL1F4QlF6zNU/6HIjUbQPqiMz01jgwbSGkNp42/1zdUd4QzhOwsxEv7t0I90lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334883; c=relaxed/simple;
	bh=s8RkVMXZemdiQoY9pW2xt6lQMdfxzciD9VpqmjCZqG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=De20D5l7qDjxwH1VETP+dsotKW6gGV6yCHyVOBLjpvj20O0tgYrN3fF4FS6/qwH/An4nX9kdHFDgDKBFXPywhLiq6G2pNFicXHq2fjxDMRqqPXooxOB9XDvr/StiOk1uylwCjl0vZLYpzXKKIGry/rMafoh4l4pp8SepRDKm0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5FOyxK3; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dcd17e19b6so1738808a34.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778334879; x=1778939679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ig3nNhx1sG1zAlt0z0P6AoDxT9sb+Afm13UJ76h7LOI=;
        b=F5FOyxK363rSy+tnjU9lJHrRqAHYr9QVfLQ5X+CSc5PERZi9HkXu7NxafMsdbJ/v96
         En2uscGTFDryeEp7YleU1meJ3IDTfmFRycFOyNNSamD3IWV12Wi+lfWNAbg4EfVN5p0J
         v3nfmvmANyF27YXHPAlL6z/qQlxByQiMJrG+xzbzfDzv8Py7KS8TKABpzJLbAWwmSLV0
         e/aRB1FXAMqCZZOSLUC6FE5uUliznUcNzoDXADEbx1ZwmM76rYU3B2Ah9Y4DaRyGevbA
         Cm+/wDXiAh/F2bcrH2MrNlueIqARDBjpP6LikO9di24rXK4RRDICgl6opKoYT8fVetix
         URUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778334879; x=1778939679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig3nNhx1sG1zAlt0z0P6AoDxT9sb+Afm13UJ76h7LOI=;
        b=pC/VYrWfDfkRgkwJmObTJIapzEWQtBIRAesc4+VxDMqyv3MWkHF1Mx+xGvYnXSHfmH
         0EiKbtFdD/62Ym336kJ5ptKvc3dls5SDQkrWbVU4bBa3Lrd0sQjSo+20qkjnEn6yEz8D
         Ohie4kK3b5nDM2VPUQOG5I9hmeNrOz9rl3r38uu01kynGzPbMTvDwWh0KprLDlUqlqkH
         fDT8Uwp4rjWG0pCseXW7dFad85GMI6+DvojQ0oeEyS92waJ3BsoMZi8WfQRR9M6PFLwM
         uyIY2V6noGoWHSkPqVELmy16zxg/ZAYuNQmM9BhAvmtgZtKXutrXmDNQ0S+1gb94FOTH
         aQpQ==
X-Gm-Message-State: AOJu0Yx5SOLAEDkskXSM+w2Dc8B1sFT74U2AGfxHzS+O2URUOCc2cLyX
	uvwhlhP3j8QFD+6tsdogpbGduypwNDCJwcBHqnrh6bh37sIkvRnyPveMpWExlvASyYw=
X-Gm-Gg: Acq92OFV0tIqcysnUE1PXAXXelhG1gZY4XIss+24O4qQVW8i+W+GPfR0v7zjJh+HCsd
	0ZN928haIXCDUJeuhvMnFyyjd4CzhzLLBUCk67dy6w5PvEq91EQa5QJb1epctUJr444dqW5/DL1
	WdJwoRHaAJPxSDR5OVBtGNW9tdhemeclFFCMQzgvlJ7+IZ41EnzI/20kB7tzdlwPRwypC2hqLU8
	kgfeN3wCQwUCXYtRGpEvKtnRDBjl4i1CY9OPJuxrBzSjaYTxOvoLiKGplitlQLnzX7QrrPJW5LJ
	A7rMf2GV6Y6fn6uuu9ArB2VAzURPc4+O1My/BOM3X1qfjl+Pg+ZguogljbZAO+i4HGWX0RQVAtT
	FjX/+0VeFoomXvwsBCp4lTMHiL9Tsc+Osy4/MxxDyJTTHiZv1LQvQS4AeMXyfcXi3rNRErTRh+w
	tvLm7aqevvO07ztpv10AIZUQpR+w==
X-Received: by 2002:a05:6830:3697:b0:7dc:cc70:7788 with SMTP id 46e09a7af769-7e381f3b7cfmr1526122a34.7.1778334878643;
        Sat, 09 May 2026 06:54:38 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c04e66sm3098110a34.8.2026.05.09.06.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 06:54:38 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@redhat.com,
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
Subject: [PATCH net-next v9 0/2] selftests: openvswitch: add pop_vlan test
Date: Sat,  9 May 2026 21:54:21 +0800
Message-ID: <20260509135423.3433910-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 48C434FFEAA
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
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286184-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovs-dpctl.py:url]
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

v9:
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
 .../selftests/net/openvswitch/ovs-dpctl.py    | 322 +++++++++++++++++-
 2 files changed, 390 insertions(+), 10 deletions(-)

-- 
2.53.0


