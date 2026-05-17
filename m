Return-Path: <netdev+bounces-288703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC0eC4t9CWqVcQQAu9opvQ
	(envelope-from <netdev+bounces-288703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:34:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694C55FFD1
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB963007F67
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD834678C;
	Sun, 17 May 2026 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiGkcBNk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A636AF6
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006856; cv=none; b=pvA/sH5K2BqEM5sw/TtP674cGaadtFnU4EV+jX80gEtkVwlNryCJCLGNCKlNRXNrjaVLCcKQu5XltCtYJ7e93fO+4IzKuc20MWeOzYquvIkAItMaz4ZOsoFYEz5M4XIaj3xzRFFsN0pOXOPPC+0Z5qRdtzKXA9uonxug6dBzX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006856; c=relaxed/simple;
	bh=8Vx8CS8hLxfC62u1sFWEMAdgXd4OiO3chNChtoPL654=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMhcb5CMj187laWhUvJShRzsXnYAfcd3gJE+zkhM9Hanyurs0DFJr53+XEmP0uBxuoVLU0cJG/mmIFT+U4eGKeVfbncOWYz9qoqkMhoLrcK+EUpw/7ucva5lzMQNiQqkHIwFYFoukVfRiFZhsXwJVtdsh1co/8gvs1kppxIMw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiGkcBNk; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dcd9061b1aso1319685a34.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779006854; x=1779611654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmkV7QWvevbt4JypSgj+dxWwFO88u0DW4qNZmT22Q5s=;
        b=QiGkcBNkNGlJ9WWb8UC/8gdVzOCZWcYvEOi7vw6EzDMOLnmrhUa75n+spmUQhRJ/mS
         dVRy25HNv5F8J3Xh0EBKb3NqJYU7ruFwD/Wqg6RZHHi9ZUIUmvDMoYj2Z23qu5mpCVG7
         Is+U6TRl52QNn2fOM7loJWRM5eL7YyIc7NJY3ktra3lnvfwuaQqFz7B2xKdpDPzcZJnJ
         mM0J2XJWLTyyhB81aRUMPtIE0S2ioOn0wEhz6zsPmQTFtpnqzru8DZZmKkQCzDOqto5K
         0pIwOIlxghlxJYxfrnG6v/Vi46NsdDKakFC6w1baOj+kZrnLPdQtOF2AXl/C9ytjoDP2
         RNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779006854; x=1779611654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmkV7QWvevbt4JypSgj+dxWwFO88u0DW4qNZmT22Q5s=;
        b=tD4//t5crN65eicynWcWQ0v2rJxF/Z7hw+hyhGEGhrH1OOl3vkFyqhP9qcRs8RVWni
         AkvwDPk9PV9J6nqHkfo9Xie328F02XTrHQnR3ZkmvJVUDKL8MBRJKbe/2Ph0b3KD0+8f
         9ihpIhPq9Ccc661lbcVl5L6yBYz9tbf34spgpY8ESm/Q1USRL2LXAZoi7smTTpXsKNmu
         0mWwnbR6IBogrI+0C+Bj0ePPF5P7FamwxRxa856HhRD4HU/7/ospFpmSCeYdxrh6Lpg1
         fr/FoVdkyndgMJNiCFT6dth/eUyPMhWr8QyHzOmNn9CeJhfKvO7bb8DadyDXZtHAZ1bL
         aFjQ==
X-Gm-Message-State: AOJu0YyjdzbKDMsu9oE37fDq68M7jFz86W2id+ONMf2/la2NkybBRvlN
	lmqTEhVtFqLsBFbBD18lXQh8IQ2AzHR6l5+L/yyxRzNwfXDp8xAsoL6dSUEDAZyn+7Q=
X-Gm-Gg: Acq92OG9Tt/A1PH0iqyrV0BrJb/+OVSVZx15kBCB/mGseQLP70aPe5OcP5jLglXhZOK
	ytfr/SpFSyvivztvJp3dc90KkPIobqfu3yBVOQ9DW9BBs3R5WF6WRpQDP2MG8hW4yrvsqm1tkq3
	u3Qd7u4xgHj0iOaS7aqr6vcG8oGmHJujwEvgtT/cVVTfKFkg3CVYWs+gG9jXyn2d+YDoGp9I/Ip
	Utziw5yzrW9ujty0jSaciIHa5uvF4OtH5byngpeHm9oLpepwYS/0BE2WeiIyQEVHvpsJn8CctAw
	YP0zEFJzz7xjiRLbq5K7EbvztTRRmhF3uxgBiNQNqV3M90ZiHorKgiqcgAC/6ZWn9GToLHsNPKL
	qZpyyTFh5IXV4tbJZCPkqdWLicUtkgkxRAm99eHi/P+Ns1SOjLtSfn7ZZQp+9n8F218WwU45RhU
	u/Fk5y6xuO4NCn2X8=
X-Received: by 2002:a05:6830:4991:b0:7dd:9b19:a87b with SMTP id 46e09a7af769-7e4ea072138mr7069937a34.4.1779006854117;
        Sun, 17 May 2026 01:34:14 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd0bd6sm5345191a34.13.2026.05.17.01.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 01:34:12 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next 0/2] netlink: specs: complete OVS family coverage
Date: Sun, 17 May 2026 16:33:56 +0800
Message-ID: <20260517083358.2088599-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7694C55FFD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288703-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series adds the missing OVS_PACKET_FAMILY spec and a small
pyynl enhancement to support unicast notification receiving.

Patch 1 adds ovs_packet.yaml with MISS/ACTION events and the
EXECUTE operation, completing the set of OVS genetlink specs.

Patch 2 adds ntf_listen() to YnlFamily so that unicast
notifications (like OVS upcalls sent via genlmsg_unicast) can
be received through the existing poll_ntf/check_ntf path.

These two patches lay the groundwork for migrating the kernel
selftest ovs-dpctl.py from pyroute2 to in-tree pyynl.

Minxi Hou (2):
  netlink: specs: add OVS packet family specification
  tools: ynl: add unicast notification receive support

 Documentation/netlink/specs/ovs_packet.yaml | 138 ++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py              |   4 +
 2 files changed, 142 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovs_packet.yaml

-- 
2.53.0


