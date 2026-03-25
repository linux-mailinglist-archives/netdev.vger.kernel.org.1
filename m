Return-Path: <netdev+bounces-271567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPmLKM3ow2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:53:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3DB3262C4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 719F13109D71
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E633090DE;
	Wed, 25 Mar 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="W3BrBHXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f103.google.com (mail-wr1-f103.google.com [209.85.221.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FB2459C9
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446285; cv=none; b=Fg5X4Ba6YPF0n6oewqV293/gnwJpO8LgqfJ1LKK67GnqeAUHrkIoCojexC79W66Io/JLeKxn8W9MfEoXY5xDwURUjqxj6ltRFPTjdA/7qsgfeOCAY6CQ/VLsm/kZV+p/D4MMvyvvhTwtVGQC1mHzwF2vmYC5DHnL39h8Vi24DRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446285; c=relaxed/simple;
	bh=qsL98HCWKiKaSLCtXakBUZxhV7iELMqHWhkmVizwwIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P42QFBhd3Hk91wVCcwheSimWAlMTKG68xedDo9DBIeSdqRCd0JGQxQNLLO7KaBBGMtKVK0zS300JzrxEKS1Jkse/5czCetVF4pdA5aV0IVOT9Dv3Yy5IN7qDTW8B/jOaBR1fY0Wx8hWPL5iulNEKfWnBzz0Z7oUWy2BYXvmOrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=W3BrBHXd; arc=none smtp.client-ip=209.85.221.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f103.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso4327365f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774446282; x=1775051082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Djl3a9JK+lUi9uG1HATPHnI66G0NG0PJGY/xhrTxTs=;
        b=W3BrBHXdEAmLVoA6Js0ByweXwOpNX96EyNC4gr/fc1DaBBJGtTlRZLUqc5ZO4ENi89
         h6mnFjHy7PjbuzRS5xuVD6B+8ySk3gwK65v2SEN9qjR8bUSHhu+G79z5JLD+3Ay6ETCN
         ax82tuRejaX6YZDJWzYl0pA1X+WXOxZ1NkeGQLfo+ZK3cQaUy/sHHR4v7YcDzO+qdEWr
         N/c5JNWoAyzqyZ6QioauPS5qLnuwVsEkcR/Jy6TcNnQU7j4A2X4odKY4c8/chcx/M434
         SGgKIqXqtAEOg97nLUWHu0AKx4TTkKgm2C7gegXkmyV9W6xgqPPTir3DojFcVACBWXy/
         WJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774446282; x=1775051082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Djl3a9JK+lUi9uG1HATPHnI66G0NG0PJGY/xhrTxTs=;
        b=VRxIzXxv+zTyIfTUaKfwk0ZpBHoSbumOoNgBFqSpZ2i0zw+0ycrH8PqsxNjwwtB2ip
         LyzLra84VFWF+kRD4ha+PlqovJPhfyzHEQ2s2DJk2cVNHZ5AxLyJcO6G4/bAvrPyH6pc
         ZbrVm07PaWp8b9TEPD9110M/UjkioPub5f5lFdpMnhbMHYbJLvyWi0yIXpek33gOBULC
         k4EqSQg8HYx9+VDwAuRxjYuf789ZPNyzBjG/NKpVSG4ND/VD214k87DUSIyrs258IQYf
         rGYGd6qnf5SMQO+mm2GN8tt5KO9OpCYU01wueA2izRS6Q3O8vqgK4k/T5cKWctQrZtHi
         8BVQ==
X-Gm-Message-State: AOJu0YyBSq8K2JLxxJGejoodjY34feTVqIkXF/0DqszbeE6ITROKfS5w
	OMtRXqYhk9IrflkWOTJpLQsvtGafk46skAiTCC6Z6OWY1rHFRlHO86J7aoInpp/kalBLhw7vIpq
	fO2UydJCG5c6KzYcZC5MVYAzMUZlfwPQ3G+he
X-Gm-Gg: ATEYQzzEHnFnme899GkZbubwVC9ketol6jB3BNew/awCJAwByX/qrnD+NWHiStf4jlA
	yW2Pd7bEH2A4vGCXDmKEoF7WVx2oj/vawstuiisdN6fzDHX9XLFvBC3yLyRDII9xZ7+6GKfREgl
	Jybzt4CntPkT0Z1jslKcZx/BL+TaPy0Fy8RD4L7fxer9nsCfIcC+GTd6STmkf9JZVB07GTwiBqu
	HER/KJP+QGHpqfu8L53HD9YHQFegtLnzmFiG97f0jnhwHrAGSzzHx/xehGqvCzIwlzBg4XNtb4E
	mkzNEaaDsNpQIVfWNTrZsjBnI1AxkJdLd952n3K8nVmJiVG3Q0gKHNdtzqbcZXaBi94P9GGGe9d
	wgecrauWMVkA+iWeG/vbjWke3boI/1lrTUZtRo2IxHpTbum1+T+On
X-Received: by 2002:a05:6000:40c7:b0:43b:4951:6479 with SMTP id ffacd0b85a97d-43b88a0ca38mr5155173f8f.37.1774446282474;
        Wed, 25 Mar 2026 06:44:42 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-43b870d9ec1sm229271f8f.24.2026.03.25.06.44.42;
        Wed, 25 Mar 2026 06:44:42 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 5CA2D1EF6D;
	Wed, 25 Mar 2026 14:44:42 +0100 (CET)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v2 0/3] bonding: 3ad: fix mux port state on oper down 
Date: Wed, 25 Mar 2026 14:44:36 +0100
Message-Id: <20260325134439.3048615-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271567-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:mid]
X-Rspamd-Queue-Id: 1A3DB3262C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone,

This series addresses a blackholing issue and a subsequent link-flapping
issue in the 802.3ad bonding driver when dealing with inactive slaves
and the `min_links` parameter.

Currently, when an 802.3ad bond has no slaves in the collecting
/ distributing state, the bonding master still reports its carrier as up.
This causes upper-layer protocols to consider the interface operational,
resulting in silently dropped traffic. 

Patch 1 fixes the core issue by ensuring the carrier is only asserted when
at least `min_links` slaves are genuinely in a valid state (collecting/
distributing, or collecting only if coupled_control is disabled).

Patch 2 fixes a side effect of the first patch. Tightening the carrier 
logic exposes a state persistence bug: when a physical link goes down, 
the LACP collecting/distributing flags remain set. When the link returns, 
the interface briefly hallucinates that it is ready, bounces the carrier 
up, and then drops it again once LACP renegotiation starts. Unsetting the 
SELECTED flag when the link goes down forces the state machine through 
DETACHED, clearing the stale flags and preventing the flap.

Patch 3 fixes a side effect of the second patch caused by clearing the
SELECTED flag on disabled ports. After all ports in an aggregator go
down, if only a subset of ports comes back up, those ports can no
longer renegotiate LACP unless all aggregator ports come back up.

Changelog:

v1 -> v2
  - Patch 1: split a comment line that exceeded 80 characters.
  - Move the change from patch 2 in __agg_ports_are_ready() into a third
    patch, as it is actually a side effect of the fix introduced in
    patch 2.
  - Patch 2: Expand the commit message and add a code comment describing
    the change in ad_port_selection_logic().
  - Patch 3: Check the READY_N flag only on ports in the WAITING state,
    rather than on all enabled ports. This more closely matches 802.3ad.
  Link: https://lore.kernel.org/netdev/20260316131838.3257889-1-louis.scalbert@6wind.com/

Louis Scalbert (3):
  bonding: 3ad: fix carrier when no valid slaves
  bonding: 3ad: fix mux port state on oper down
  bonding: 3ad: fix stuck negotiation on recovery

 drivers/net/bonding/bond_3ad.c | 36 +++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

-- 
2.39.2


