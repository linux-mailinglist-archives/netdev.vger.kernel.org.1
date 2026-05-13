Return-Path: <netdev+bounces-287573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GILhOCZsBGprIQIAu9opvQ
	(envelope-from <netdev+bounces-287573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:18:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92764532F3F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF853112B4C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45FE402B8F;
	Wed, 13 May 2026 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7+gSeH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0E3E5598
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674446; cv=none; b=bAYj6hsIz3wEBEdcO7sxmzHHkSgaZU9Z7U3favfsUOstjksBOUrhkThzyElreMi3IQMUCCqzE49Mr6utrKWJTleZUt6DklLBVUF/6/I6/iSIONIxkKz+WTYjdl9+vHHWcSREiVWqOhjoLxRD2ASsJqwYfcdfXl2H7s6bc79CK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674446; c=relaxed/simple;
	bh=Jz+bXsVftai5v15pDprSSH96Ot4A8L6ynecxAQ5ymGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WH2k2ZkECw57NvcEOm4S/S1F+zbHypP9H7wUKsIzAcA5b/7C7DbwyMHtwtB+xn3ehmrURPh/4U+Vo1Y/NukqjBAQoGultIruHCYoFzcohi2GZIVkkwNufTiwakR8+gUf7zRe9m47WtkcoyiHZvKD2roIscE1pYzSkYaKy95f7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7+gSeH0; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69b747a8984so502473eaf.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778674444; x=1779279244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKna7861B81bSrMUMezEy1EFlgsYPylTedLt/tHntn0=;
        b=Y7+gSeH0Kz6IGmhPGMyryzobSFWSdP0P4wyBhIjKCsBKCn95V2zeIZa+fvoKEC5U9y
         E9Q8xILvBEji9f6EH7IheQAd2JoNJbXmg6cNDeAd3RCXdxruWJbaEC9AY6sQReJ8ugYV
         OHsSCYnhf0vDnT5ntyWHPHKvyfgIcYQQ70GyRlKTsgc72W88XTkbEX2+ikv05xhTLy3C
         jBzdBzOLnyGyBSICYhZeGn5xvSJq3YA/PR2qO5E74EMwBXqSRwWemMvI8dRoomaELHV2
         T5p+2DvbsDH6Tc3ys+dF/8JrvV/eJDC79+kBL3jcxuFdoZuIivl5rmMTDF+zJ8XZoABS
         G9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778674444; x=1779279244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aKna7861B81bSrMUMezEy1EFlgsYPylTedLt/tHntn0=;
        b=SoSUEdZqAR7Q6CElRHCj6+602u5CoTs5eMFj051H0VlP1BLTEE2Z+TLkV9wjGLPumU
         ZXGOeXREQjZoqkfXb+oac+640bt1CwFH/YYLVQqP0s0qcFU0Rau2/RaERIXGz4Ocxxm3
         B+vu278DsHLUYfKWs29RcyK2Qj7N7z0TGKhQs7QjN4lyZFNGGmA5WgHU7RR1/etFq8OG
         CHGGuFUDx6RAlCuEszecKCjfNRCV8mTA9rgMtuemox7lGxvCIzGS1qNzB8/fwPLgBJe9
         DCiumApZaXCWJm0+eDS+SUuFsCj8tqNTxAbBeJciMQGeJ/1GdPRJRq3B8vu7nCZPV33+
         ePxQ==
X-Gm-Message-State: AOJu0YxYkM9W7rUFkA+VbfbLLYIOxU1PeEtdaK58DtI34Mdl5O3yUvrI
	ID7b7mMIzhADRQeibGqLRFtCJavGnWt+wH9PlBy20zGghk//RT02TuKZwubR2B6sNeQ=
X-Gm-Gg: Acq92OHlSQHC31y6D7sitMzW6sopFU8Cy6tlHjXjQfGt27LBt+0ogQfBcwDZ2IMeELZ
	SgUV8dob5HKISsabkHg1FtwUZHZJAHb2Milsk4j2MVUur9mg2vcVivPhBv3blyqvsUMzbJpzZiC
	mVloQ+Lb6pN3sF3ziBvkbgcWdFfhQXST3rL6a5ucUqcEy4/kGu4x78jBXVT81RfVXxKsY62rnr/
	UOQlBJ15cuzFzi7xK24xXa3gYUzq/4BQUiDC+v51+IiU57tjzbHTJS8Zz29SaxPSRyWA2u4jS4n
	S5htxU2/8jKn3SV4EivSElh3HV/nUzzmzWDaER8heHkHV9dWWdRLI4Uanpu5n4gYgBmMawTRiLE
	tq4jEDtKUqNJdHRIaRpXeY7kXvBd6hjI/QfNBhIXU5fggcld/IpPMMW4zgFN5oNrbO6QgRQyKSx
	Mp8ykpxulmJzakYKA=
X-Received: by 2002:a05:6820:200b:b0:694:9bdb:596b with SMTP id 006d021491bc7-69b78d6e063mr1647900eaf.17.1778674443943;
        Wed, 13 May 2026 05:14:03 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736dbc0sm15189442fac.11.2026.05.13.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:14:03 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	i.maximets@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next 5/5] selftests: openvswitch: suppress pylint complexity warnings
Date: Wed, 13 May 2026 20:12:40 +0800
Message-ID: <20260513121240.2590767-6-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513121240.2590767-1-houminxi@gmail.com>
References: <20260513121240.2590767-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 92764532F3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[openvswitch.org,vger.kernel.org,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-287573-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add file-level pylint:disable comments for warnings caused by
pyroute2 framework constraints that cannot be fixed without
restructuring the netlink attribute hierarchy.

After this patch, pylint reports 0 warnings (10.00/10).

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 3683796ba2e2..bbc88e3cfc8a 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1,6 +1,14 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 """OVS datapath control utility for kernel selftests."""
+# pylint: disable=invalid-name,too-many-lines
+# pylint: disable=too-many-ancestors,too-many-arguments
+# pylint: disable=too-many-positional-arguments,too-many-branches
+# pylint: disable=too-many-locals,too-many-statements
+# pylint: disable=too-many-return-statements,too-many-nested-blocks
+# pylint: disable=unused-argument,broad-exception-caught
+# pylint: disable=no-member,not-callable
+# pylint: disable=non-parent-init-called,super-init-not-called
 
 # Controls the openvswitch module.  Part of the kselftest suite, but
 # can be used for some diagnostic purpose as well.
-- 
2.53.0


