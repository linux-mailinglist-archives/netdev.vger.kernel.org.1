Return-Path: <netdev+bounces-287567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMj8A/1qBGprIQIAu9opvQ
	(envelope-from <netdev+bounces-287567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:13:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F44532DF8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE03E3066324
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45394401A1E;
	Wed, 13 May 2026 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Wb0CE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECA3FCB03
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674380; cv=none; b=Fpfy4VOe8J6rSsHcGAQu6j28HKh1122/WSjsI5lEmDa5FObkC7U3JOVguHsv55GSWse+gRn02gKpbVuar1F6Tbxv+Z/v8ESHYckzDbsHRoinsjuLRNONkU4wa0/LgeqGyNYYaInD+ECml0KWHqbquycqNFuc/nBjNWQKieGqNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674380; c=relaxed/simple;
	bh=sIVkmbnPi62X8BjG8OyL5YZgklagbQK9bg+ZcgvmI4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3bo51ZWSm3xdvmdyFXkxrXAQ/pK67XchNYFrOHVJCo39jGho+cdaFYXq0BsbFHAxI9zMYHVzoa/NLhbGfOnqznDZf2U0d2ICn6F644gFQ03egfuVRewCCK/xDnONS//DgbExxARxIJV5u7lAbLVH6nUXJTELLEKJAF4m/ClEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4Wb0CE6; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbccf6a23dso5418709a34.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778674377; x=1779279177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFWZYsDIujsbYZ6k3QHQTk5T7lp4/robhtHZwKO93sc=;
        b=a4Wb0CE6nOkp7nT7LngOlBsUGsbweu8Pw54qyYoMK9N+KIhglr+2VsOdlBP1TG50La
         0JkEBR8x9VrFrSKJg6AyX0p6JGOsz6gDZj7ZSeQJHJPzRy0ih+VH9K0KDyaDQQWOOdxq
         yZHkcjge2xxmtXfmg22w0jAhOpWzOvUe/s67yob0kMj3Iy+n0/W3m8LD2nl67rJmzDKu
         5A5JrurKy3JX8YloERz3D/4PR2HPcmTP5981UDwd/bGsp84ARnEKo/GirmugjmH/uJI/
         7KWvIXb9w6Swpp54VIb3hjKCrEarIkrzl5ay4khCx0AdeoVvr0tyCpMY709jkMaPQHfx
         iD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778674377; x=1779279177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFWZYsDIujsbYZ6k3QHQTk5T7lp4/robhtHZwKO93sc=;
        b=LmF/jIfJ1qvCt9nbSBNdwLfzTQKvvq/di3pN+XY6GoGnwFIgrL3M/0D6S9Us0uHWnU
         gO+XWDW681U202RkautQpX2ybqqO5t0s2S8BuNUK45u/37+o6GZ161p6R4nbuLMJ9Pz0
         f4cMXjg5FZ3WWGOn+yP7zjM5+sWA1GyFJrMAiYMP0xl77Hw88CpoxQlmX3OpxytbYMTU
         JzX4wBmBi6qb4IZcUeLRG12pmACjmqs2RMG9aFd050cQQZCdErFhdq+3JpFlDjLoCqkV
         yH6LPzj+V7GM/ydU7W48l+DCHQwvxet2q4SWeA7npLvZCE0kejKZyrF8YL62MJHdIuQ6
         WKbQ==
X-Gm-Message-State: AOJu0YyIAR7cboY5dgC9c5MNvAi95Mx4HZdtARkiJPTeLntgGaT7M2Nh
	A6mcJtFTy+D2s7z3tgz54Q64ylHTkLnf05nvuLNQhHqTnMuDnwGIsC4GPtgnxRvNq54=
X-Gm-Gg: Acq92OFddOdl9iC6SvFNO3E0Ja+kqyWE3rNl0D11pP/0fi5ZHoX3gCvv1G17mv1jPru
	ROHJ5sWFZ21KdiQ+60RNa74qnwXbPFAQ4kL7VWFf0hH8OUGIsr7MfW6tRSh7NjNoh9RfqiidMsq
	8YGE21JhUnBE4t7CLrzsJKg/nyLmavHOzJPzs13X66doTejDbiQAKNRgmOrAOgYouBt2mWdj58j
	9Bq9iGBi/vndOfGf05Yaxb6PJzOKF5dY3sMcmAtSRpkALdcZogEe6PbvSZH8L1awrWu+WIpH+a8
	fXeaf+M7EJFHn4JeDpMmEhQlroTffhp7oLMgYb+dPcsXAblg1N9mQ6hlK5XMne6WwVSCaWDoZp+
	fKpYe9TD00SG9CS47afIpKLlptrBLDAPZidCtNTVujqrjbl8G0j2ScLYJg0zqDwZooG418opJ36
	CoP5ynInA9ERmPgjI=
X-Received: by 2002:a05:6820:609:b0:696:15bf:ca5f with SMTP id 006d021491bc7-69b78d82eecmr1615367eaf.19.1778674377518;
        Wed, 13 May 2026 05:12:57 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736dbc0sm15189442fac.11.2026.05.13.05.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:12:57 -0700 (PDT)
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
Subject: [PATCH net-next 0/5] selftests: openvswitch: pylint cleanup for ovs-dpctl.py
Date: Wed, 13 May 2026 20:12:35 +0800
Message-ID: <20260513121240.2590767-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83F44532DF8
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
	TAGGED_FROM(0.00)[bounces-287567-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovs-dpctl.py:url]
X-Rspamd-Action: no action

This series cleans up all pylint warnings in ovs-dpctl.py,
bringing the score from 7.62/10 to 10.00/10.

This series applies on top of:
  [PATCH net-next v10 1/2] selftests: openvswitch: add vlan() and
  encap() flow string parsing
  https://lore.kernel.org/netdev/20260512070841.1183581-2-houminxi@gmail.com/

Patch 1 converts 86 %-format strings to f-strings.
Patch 2 fixes misc warnings (unused import, bare except, unused
variables, redundant expressions).
Patch 3 renames classes to PascalCase and variables to snake_case.
Patch 4 adds one-line docstrings to all definitions.
Patch 5 suppresses complexity warnings from pyroute2 constraints.

Tested with vng on x86_64, all OVS selftests pass.

Minxi Hou (5):
  selftests: openvswitch: convert %-formatting to f-strings
  selftests: openvswitch: fix misc pylint warnings in ovs-dpctl.py
  selftests: openvswitch: rename classes and variables in ovs-dpctl.py
  selftests: openvswitch: add missing docstrings in ovs-dpctl.py
  selftests: openvswitch: suppress pylint complexity warnings

 .../selftests/net/openvswitch/ovs-dpctl.py    | 794 ++++++++++--------
 1 file changed, 428 insertions(+), 366 deletions(-)

-- 
2.53.0


