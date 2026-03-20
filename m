Return-Path: <netdev+bounces-269925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHjnIiJWvWme9AIAu9opvQ
	(envelope-from <netdev+bounces-269925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:13:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E490D2DBA95
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C61D307E0A5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307231327A;
	Fri, 20 Mar 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="K3pOTnQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f101.google.com (mail-lf1-f101.google.com [209.85.167.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E94278161
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015746; cv=none; b=m3rk0Xw8DJPCAZdvV6A8pYDOcJptgN6MOB+w2TvxJDh0ZGfNh3Rnb0SpmLwaVhD5yw3lEHdl3EyXWPOaQTux9LMG3n+XneDrQIPROJEGUUHKY6jouA+eyV43JXFBSNhya6MN1o0behOGL+POqC4rm+m8L4imKHiyUX/u1dVqHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015746; c=relaxed/simple;
	bh=MdkSdzcGSqrTZBp2u7kvw+iKaY7GRTDLTOFKXdYrXU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gNXzCB1EnRKjjrJ7lAP8P+TtOpQ3MJxXmguF3pkkzfwDaUfXboqX7l7uOta3y8AGiIvN+toemoG1cbKhp165WGTJ8ETl3G1495+L6Etlaqyac9wZ/R5qf77FyEkhbq9VE8NMUnzydMg9CCazim8U6NwfxnIw+WM+t2ogEwbNCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=K3pOTnQt; arc=none smtp.client-ip=209.85.167.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f101.google.com with SMTP id 2adb3069b0e04-5a27c329e98so908613e87.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774015743; x=1774620543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qtVrvYA32Jc8pqlKZtKj3HEjzfaJ6albknHystgmyg=;
        b=K3pOTnQtDYzKqpTqb2gm7Rca6XIxF/mcmouJAIShbtyuPjO53vFGLsuZoK+G2UtPNu
         pbOroSTwdvJUwVfpfkJnCamAyAbqH9G6/8PQLwWU+f9VqSVoSEN86v5iAMCf+thzes43
         d2kEw0blZbrZIAklsTd2LdAvBXMgUcK4p76+jJpOeUayfPU+ET1WkB+KM3hPeOadifiN
         NoEEFhlzHDqUE+GR/sm6UDHm5TmCUmGbsYOyDw3OkO6IjPip5o53eEDZE18084vQMOYU
         eyhKyFd5T5C1KE+xMwKj0sonMYUTEOiCRr84J2UTIWp/TGl0DBdW3ioF49OxvNOEtYO8
         DLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015743; x=1774620543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qtVrvYA32Jc8pqlKZtKj3HEjzfaJ6albknHystgmyg=;
        b=lSnsrr84O9+snqOpfESUjrTyPs057ArFMTATltaPVK+L1gWmOno1Oysrj7bN1eYB6X
         pS2FbZcEXsile8e7li7Vp3IK543iNbb+B/DArcDzqAVGDNKBeEHmuExhNeByLxWRxPHa
         cDGLkbT5mwsd7Cn1Lwhx3FpuZAH5fCeR2oS5+NIZrNLFTsjedjyxEgFvX9iaolxX6EXJ
         4T5mo1pLQpoI4uAOjERHyG6khzs7mx5PtVFIZr4Yj3/hKvPbCqshF82gzKWfI4WPg2fl
         pHklBgxeVMCL1jPVqKqWaW1quIZ24ifY5A6I+hhMSZOni/7nEOFs5vHZURN/DHWkTlML
         PozA==
X-Gm-Message-State: AOJu0YwGB2g1DyG6CCke/0UFghqqVaw0iitBFtZy/CeJcErdyCkLZFNp
	hyH55aIjC51fZlYsUnikXFn9YRb7PBTuBTswR0fLseuNT2TjcKqi/uV7DThAb5H/ZCEy4/A8fRQ
	i5/ejnXpRCl3Ywdw6O62TVZl5qoPy95HUOWGr
X-Gm-Gg: ATEYQzzIa58GhFb7fRTQfodLKczRQeI3F62Y9sUQ8pE2HoS0v02a1X9UywLQZzRXo4g
	V9w+5OiC5ftYIZrb7He2PlrNLXPVOqWdUmtpyzJfsMBeaI0y8dRP5apNQgmG9+Lku1dLeCnA5vI
	1g7q1z0kCj7apm+ujhmSftTBntjnVuLr0PmdSEFU3BH/FDWI9ZOv/8ZKwZR7uM/06VqPJUVxuC2
	IwNbXMoZrWvPRX/Pqp9ckKpkx7/LXTjXJ7t7ue6imRqnzg2HRVq/03dTnsZq8zUydYkFcFU4Utb
	h1rRyfeAnzSXLVvScOD6bGhZG1RIwjJcj06jNq6ctFe6fcYsC4NhvkhEsdW9zgCUdsiurJS3Sej
	YNlALXzh3G/MrxptwtqnsSA1MJerTFMuMxt98G70BcuNz/qyhk4YedxYcTC8WdisPpoOTMZbsQA
	==
X-Received: by 2002:a05:6512:10cc:b0:5a1:382c:3a49 with SMTP id 2adb3069b0e04-5a285b6dc60mr1382315e87.32.1774015742958;
        Fri, 20 Mar 2026 07:09:02 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a28519f1e7sm227698e87.17.2026.03.20.07.09.02;
        Fri, 20 Mar 2026 07:09:02 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 7DC4C1C280;
	Fri, 20 Mar 2026 15:09:02 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	andrea.mayer@uniroma2.it,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH iproute2-next v2 0/3] Add support for seg6 tunsrc
Date: Fri, 20 Mar 2026 15:08:44 +0100
Message-Id: <20260320140847.1730633-1-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
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
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,uniroma2.it,gmail.com,6wind.com];
	TAGGED_FROM(0.00)[bounces-269925-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.864];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:mid]
X-Rspamd-Queue-Id: E490D2DBA95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for the new per-route seg6 "tunsrc" parameter.

Example:

ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
    segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0

Justin Iurman (3):
  uapi: add SEG6_IPTUNNEL_SRC
  seg6: add tunsrc support in iproute_lwtunnel
  man8: update seg6 encap documentation

 include/uapi/linux/seg6_iptunnel.h |  1 +
 ip/iproute_lwtunnel.c              | 31 ++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in             | 13 ++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

---
v2: include uapi change

v1:
https://lore.kernel.org/netdev/20260316164907.1255510-1-justin.iurman@6wind.com/

-- 
2.39.2


