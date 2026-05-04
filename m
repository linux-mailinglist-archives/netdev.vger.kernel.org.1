Return-Path: <netdev+bounces-283820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMdaJBGT+Gl8wgIAu9opvQ
	(envelope-from <netdev+bounces-283820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:37:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA614BCF83
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C34301A73E
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053D43CE4BA;
	Mon,  4 May 2026 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDSKrjF4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F403D3319
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898245; cv=none; b=evBWuWU06md2T3z2gFetKGhnAtuVIAgOR2IC8+k1vXX4YzE8ckAdmXVjFipZHRszn2zc784RMSPrczVojwHs2ps64Qy7Q802RMYv0CX0zk4CWgnSmmuQeRti4Pe6OeqX6XuSFmfjTC7bEutb+HJNjBwBiRXPT0LCkFHvHigM/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898245; c=relaxed/simple;
	bh=bTuKn1DdihsBzgZCLCw2WFo+hdCwIzZvIiVGWxyeO0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEtc8WypxJk53sDFdH/QTAxU96gKFGu1NqUegzN+3WtNLZMeJXmX43Tu1yDGpYknCWegnjIZlkSsQbD7IhkQ5R4g0RUEqIiibG7eBU2TmqmRIuHoicZ/bcm/IdELx0rrxcbwHeeaMzOeQEuAhtiWbrZlPa22D6TAdpFWKraX9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDSKrjF4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36534668247so1100248a91.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898244; x=1778503044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9T1i7FdZhwacHJsq1bHlPf1QctcwfXVB2lsLVY3Qpg=;
        b=HDSKrjF4S8DSUoB8amkx3Rts699x/Td14Z+oU2a+E6DkNlk1x3+JuPNUby8Yv8F3Li
         /cBKY07/TtGAmd0v4F3Uhks/bgDqQRVI3iYNPHffv5ZuVFXbcNLWfeDxCsqyBoFtgs5p
         UKY6S4Tykv9u8QDcPx6TsLlTA53FARBlpwBUwIvG/J1MS+pZDNZWnoQMt/1ebalcEpsS
         zyjgui4e4OfI93OzaXsdsrOJSLBTuPc7njAqH/6po/fhYOMhrCAgVfj4rOBPW7CHWstX
         SiIOK7mW01vttTXNgErJyZ5pZfEkb+ZJrMl7TcE2US+ydWEUl/Bme2BF3ytbV5KJMjtG
         CqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898244; x=1778503044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9T1i7FdZhwacHJsq1bHlPf1QctcwfXVB2lsLVY3Qpg=;
        b=ILyFtsC9AmWGzjMcJIZIcFvzkXvfEtkNt6obLonX9hDRI2t0uPU/iREaPc539ZpyKg
         /jVCsCa0iopjFgsZS7jsm3lUsamyJ2Xj3s/W3UgVtL2UIivsjVhCkhh3yuDKfxzB5qNe
         T3G61D+5xTbCglPa2ZN3gFpv2GYIkuvOOVlnTNxXO3rzBiM5YOJ/Dgndib6g50lK6L7o
         wKZsiWlHAnQctQZzg2Jt1HlA+hh814npzJXUPv7VWZe0Wtq73S898QH5QShVvW0IS5he
         HnEPoGalPjNLZclLxNhftHjtBiRkLudngBs0SHKcmx7wWcs2VH7UZ6JzRtF69Li7ES/l
         +NJA==
X-Gm-Message-State: AOJu0YzcIk+WNmq4ZkvaZwdtz9ExLrdjmRq4rg/wCoMnBjrsmbAWvxPg
	Hwxvdv8fe0LCU9FEsKCasIyqnt0E7DNCfNY6ku0fqjlQDOo1ZjehdpgeMjRw8fe8pUc=
X-Gm-Gg: AeBDiesonhuANm0uHAQ1bn18pc0OAEDp4qwJzW9iRMq5xOTZXj5/I5OijLNI/+libp8
	1Ix/ZgPjjRuJXChleLGh78uIVMmF9kYYMH5pOdh7IbAE4lOhSDx46BKQQ208rnKMtQHT4j+FooW
	uXvzGZkOT1DLP8FuZKLJXHJduRTcTmlGZXOY8rs1IPG1qoam5AZNC9fa6tAgoZV2jR+XC/gE2Bq
	aVTTKbYtdfW6M5V2R4PZBRLpePQ4CMVNujETp5C1yMf2y4dzIxfewdwsNdT4BmCYq76C6h2Xulb
	UszQt1P96XHDeBss9PqMxX3/IYfjaF0b6EUIsE/f3n4UeWeIfgWK3Z2I7hDvkOgrDL3NPXnnuTW
	3Wsa8t92bMwojtRGNsC9KAQap4500WwSEOADVzPrzyLwu/emL33vbk5fpMsaEl1n5eRXXVFsr4I
	LjP9290f1b2f+zpH9/XaEjvmXv8sK7NLKbL5xa6g==
X-Received: by 2002:a17:90b:44:b0:35f:b348:63e with SMTP id 98e67ed59e1d1-3650cdd0f75mr9531724a91.9.1777898243721;
        Mon, 04 May 2026 05:37:23 -0700 (PDT)
Received: from houminxi ([151.242.165.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f4558e0dsm5883550a91.2.2026.05.04.05.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:37:23 -0700 (PDT)
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
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v4 0/2] selftests: openvswitch: add pop_vlan test
Date: Mon,  4 May 2026 20:37:11 +0800
Message-ID: <20260504123713.555461-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CA614BCF83
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
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283820-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add test_pop_vlan() to verify OVS kernel datapath pop_vlan action
correctly strips 802.1Q VLAN tags from frames.

Patch 1 extends ovs-dpctl.py with vlan(vid=X,pcp=Y,cfi=Z) formatting
and parsing, plus an encap_ovskey subclass for safe ENCAP NLA decoding.
Patch 2 adds the selftest with baseline, negative, and positive checks.

Tested with vng on x86_64, all OVS selftests pass (including new
test_pop_vlan).

v4:
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

 .../selftests/net/openvswitch/openvswitch.sh  | 196 +++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 268 +++++++++++++++++-
 2 files changed, 456 insertions(+), 8 deletions(-)

-- 
2.53.0


