Return-Path: <netdev+bounces-289395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAtDOG1ADGqqawUAu9opvQ
	(envelope-from <netdev+bounces-289395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:50:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF857CD2F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA954310D7A9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6733F5BE;
	Tue, 19 May 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs86bZIu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF85233955
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186733; cv=none; b=l1U/ozI1+tBGJgO/Ym8FP4s0Sbtq6b2+YerrPfYVrJGM29hdDX/vJaIdQ9pf5UVH5bBkQMJqCmIzrAVPpyh84SIVPESq061zI8aeQwa2OFnGjGtkckFmR44zhAz5cqrkuvWCpQxALwOiFl0vHx25ZYPtAmtVyMsgPczOG4AuEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186733; c=relaxed/simple;
	bh=mgeS6n2doK+6Elcu3PENTnSwZKhigUGssecK7hQwKp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkP8fIC3uvXOE7HugxiEDFpQgXF8NY/l8S6zktLhUXO/FKLzcEn0Wiva9+nckQyWL5bVjBNPSAddmtCNEbT/51r91fJvva4bwfanic+lTj9sHSpkd3nHZOp4CPpD5Q2kl2qIYNUJiDeqUqsgg1HXG+str//fX2CiGZUdMU5/YKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs86bZIu; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-47bdee5bfc4so2308724b6e.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779186731; x=1779791531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ydVYej1hBb4tF5EM529vT8DTw2nCCw4M4PT743AAcrU=;
        b=cs86bZIugNWpp1lidcUo05gqO3IQE2d1uMHwKpbTbWjI2jezs22zzm8n32zvFHlCQb
         UA3eBt9uU5XreMseRivA3FrGFbrWfgsVHmbtDyrZnuKGnx01I+kCqDsca2ryHKUe7ab9
         O+jFeZTBuUtF6RnXSMYHZH51RUG+7dBu+tJtzQhI/sz/ZQVMOjLfAqplMpI/IWZYLBGf
         lFn2Gw2i57zpdXKEeRuYFJgsfsqTOm1WPdqEfNLnkbyI3+5zLbCAAE9Cpw+Nfibm73GH
         4gqfBB4hMEHKGqc9Y/CuXQw5lExtIklhhffZuQ59vVeV1iDV3v9hwQpH+xtptZkzV0pX
         UN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186731; x=1779791531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydVYej1hBb4tF5EM529vT8DTw2nCCw4M4PT743AAcrU=;
        b=r0VjJfsnbgN6Rb3M1+RvCPckQEqWSdY9bgaHeNKXN6WInGGymsh/E/9L0WmzLdFwcZ
         B8iyDDDzrxEaw8UtMr+itraqZ/i6SvUPM92XbUmexJoQlqFSIo/m8mM2qMFy0l5S1Qna
         /dFbrHkPf7lxmrWX4de4+EgUy6Yoaym5K4B82SKd5oWFXWpTxDQntSsRzgvbCdXnWzmw
         iACq5rxhb/m4JLQtXeCMlXFTxCzvegCkKUB06NrBDSq8Rz3TKvdHzKuP3tmp8ih9KrIh
         RV6VW52HOQOSHJ6dGIhmZNHNQ3PTOJGL577V6BAm57EtLMcy7sj6RGS8h61bNwjlEbmg
         RkRQ==
X-Gm-Message-State: AOJu0Yxsl4p5Z+UbTkLSDC5H3Fwe2iA6m9MsRnIBFwXsBHokvGCEQwfJ
	NsyENWAKDFmn9gJpveFg7aQNSzhgUsCz4bwz62QSA1ZAmqFTX2CW6bZcPo90UZ/Q
X-Gm-Gg: Acq92OGJrng5YTF9EumVpxpSchYtRNvmFY6K5GvnYeanS4zYeRVkTFvo/EzwUQ4j7da
	HS/aJFOVge+baTa/SmE9/XIvYGdK8P45YUuH8wJqHyUrwKnIbIE7W8kzsKEDwKrVMh3VeiXU0Po
	Eo6im4oH7pf0Js0p1BVSO2yntWErfM7WDbh6fr9Y3mDn2XlKyrByIBbG2cgIWuUNoe0iMSW+PDv
	EePNSFtvZ5qARoKAKuxvDDZF+HXcHndkQxbNtEGhiwAiI64/bflVSPr5P6zQQN64ppol9TJYJMH
	VOqxNr90LJq4Q9cU+wKyV40Ynd640vjlqa084yQU4+Y9IjBcEF8tp3fKePXoUnWfXq2AU6Xeq3g
	7Po/2z/UaDpJ5UuBq8ZuG+Va1jw3O+cVYFRUODTzD3QxPdFwUXgNTRNq6LK/NT/Xw4EiPFM6166
	VIWcvTcz6HM/fahUtCxUWc+WQiGg==
X-Received: by 2002:a05:6808:67c8:b0:479:ae1d:fff6 with SMTP id 5614622812f47-482e4646516mr10643722b6e.11.1779186730991;
        Tue, 19 May 2026 03:32:10 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee389243sm6360969b6e.6.2026.05.19.03.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:32:09 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v3 0/2] Add OVS packet family YNL spec and unicast notification support
Date: Tue, 19 May 2026 18:31:51 +0800
Message-ID: <20260519103153.968549-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289395-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 60FF857CD2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds a YAML netlink spec for the OVS_PACKET_FAMILY genetlink
family and a bind-only ntf_listen() helper for receiving unicast
notifications.

Changes in v3:
- patch 1: add missing document start "---" after SPDX comment
  (yamllint warning in v2)

Changes in v2:
- patch 1: use YAML anchor (&event-attrs / *event-attrs) to avoid
  repeating the same attribute list for miss and action events
  (suggested by Donald Hunter)
- patch 1: fix enum-name from ovs-packet-attrs to ovs-packet-attr
  to match the kernel enum name ovs_packet_attr
- patch 2: add ntf_listen() to the YnlFamily docstring under the
  "Notification API" heading (suggested by Donald Hunter)

Minxi Hou (2):
  netlink: specs: add OVS packet family specification
  tools: ynl: add unicast notification receive support

 Documentation/netlink/specs/ovs_packet.yaml | 130 ++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py              |   5 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovs_packet.yaml

-- 
2.54.0


