Return-Path: <netdev+bounces-264865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGc7Kdj3qmlxZAEAu9opvQ
	(envelope-from <netdev+bounces-264865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:50:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA1E2243A5
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B7E63033889
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58F3E9F79;
	Fri,  6 Mar 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHGaCHJQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC13431E7
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812162; cv=none; b=kSI8rKZ05wOiUW9mmx5IMYKCEiGCKfKIa7ALVm7/IeDVgaK70X/t41NIqX/sz1660x83GBdzmFbCCc5AOxKKKO0QL4eGG3wqPy8kA7453XKgccxVqNN7FrqqWvmsoxaI9F8a/ZpjaKX6L4d3e8fbg9iRRBQsaVTf1+glvlJDJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812162; c=relaxed/simple;
	bh=QD7pv1kyqhhfY7N4QInHc1vSNx2PxqqaYbQOT36TP54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgOMYRZIvnzsYyjg2441YH1Iz2zi4jKPuPqy4uC6X3n59hLUAe+yhLZMLQPJzmmL8My19zIZVaE9htgzK2C1H1cTN/axwmL4H+9uNZipJKD5v69Mq9YcqI1IC0Z18XXgWwcv90MvyWyONF5eLfR8IXykuSVDkwwMb8MiYhZOaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHGaCHJQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598c008455so3527238a91.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772812161; x=1773416961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UO2HBQnMOuVgien49ns0z7Zhjb02lkMWHBdqEHKfiSA=;
        b=BHGaCHJQ9GtUUU6Zxo6GpjLvmtfMfpJxwb92FY54g5/Kpy9KzwhODPU21wglWyGH8q
         Vk7Y4JefmhPL57MQb99nuQYVCxb5+ef0PJZHABoTJEfJQaVLchfpjvPSyjbzxWl6fkaC
         2qOmmxcGp4fqolF904UZ6au3FdUO96hZCH0NudpqRLo7uABC12aMHLlc1HQMJ14AzVqI
         3UUT9h3vgEh8aBQ+r3HI99fUQNpIPJLoFMnutZIsMH4FT8Rmr5sjfz17IysmG2JmLxAX
         2UbgbBzXWag5lf9aipPBjjm7kmkGdcSY2HAT2ALhxXtsNLzEC7bYfBNoSr8PB0KY7sRM
         sxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812161; x=1773416961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO2HBQnMOuVgien49ns0z7Zhjb02lkMWHBdqEHKfiSA=;
        b=sLKUOMhCXt/VcdZlCRDePRDEEN65BliZNOdGXTaApwKBcYf/pgvsKW4woNMsf100TE
         VtMi8+mQc7sJmEGACh4c5JFAp6fX3pd3l9af6+pYEjLg3mX1IaMRLJQDbjwgsDzQgnud
         T4qYdhlhpq5zI0TIoFY39qtTqMEdgyHH//3EL8bjJJoSy4kT3gdsH6EO7NcKDiKM0bxF
         F4QdnmFiMr5hytjr4ieQXQx1IjCe7ZpCPSYKtjQ4zptZk2y2OLbwiaB3a1roM3/W0OAp
         Y1koIR5OTS8dVVYUIFgPYe/FxrtX1/g1+klBns+m3b9SY27Su9BfUddDQ6qVxnQM5a0h
         +BYw==
X-Gm-Message-State: AOJu0YxPS9wBWKG/bInPk4To5IZMzxmxFhHckgcJLWw0zxSobaQZGZ9f
	33mB6wNNqmW5yhbrVfl3AyOc1OgxCfKF2kiGf+jHeK1W7+iNlVQtSanDrUhpWI2vJE8=
X-Gm-Gg: ATEYQzwDgJPynBaoc00fFAR8DrxuS2honKDaTX3+uXqBXrirnD5p+bqmPcf0l59xJHK
	IY8IOIk92io+ebSvNCvs1PsoQyw8rVZRwAbrNNh1A35MxaDBg5/3AwfsvyWzWDwwPxGd0jpfNiF
	DZSUWvXkMf0zyo/Qo+PMsy+fv9Id/FM30Uc9EUvAO0kCDWt2GBwapP2EAuywUE2WjQPa9wOCBBf
	Q/mQv4FsES4H4SgaGferSRd88Eavnd4JrexsR1vOstlRLdVnyzbTlkfdi3Pi10KSBRqcwpNAb1p
	I46vpqGApUv1OyCEzNVw/WwhzsKwUd/uMYzKyXHrjnStWoG2yBgJbpaXbekPLyn/K5+lBbNEYuV
	fsVUr377lB0c2hqMSM+GMvGIg8NKtnRj2UgR7ethXUD72x9R/9nD6Efcp/fSAV6D9OrltkPvzh5
	8As8O/2cKQVfdedANMeALBPWVU7gg4hIpc6Dg+jEd9pcRT
X-Received: by 2002:a17:90b:2792:b0:359:7eb:d91d with SMTP id 98e67ed59e1d1-359be3861e3mr2050728a91.26.1772812160948;
        Fri, 06 Mar 2026 07:49:20 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbaa5fa1sm1532769a91.0.2026.03.06.07.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 07:49:20 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] net: dsa: yt921x: Use u64_stats_t for MIB stats
Date: Fri,  6 Mar 2026 23:46:25 +0800
Message-ID: <20260306154637.3126497-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EA1E2243A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264865-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Avoid load/store tearing of 64-bit values on 32-bit architectures.

v3: https://lore.kernel.org/r/20260227135057.2730254-1-mmyangfl@gmail.com
  - rework commit message
  - avoid some type casting
v2: https://lore.kernel.org/r/20260224112411.1561917-1-mmyangfl@gmail.com
  - git rid of print_port_err()
  - remove unused variable
v1: https://lore.kernel.org/r/20260203171305.95085-1-mmyangfl@gmail.com
  - use functions instead of macros
  - rework commit message
  - hold lock for stats when possible
v0:
  - Sending remaining part of
    https://lore.kernel.org/r/20260118013019.1078847-1-mmyangfl@gmail.com

David Yang (2):
  net: dsa: yt921x: Return early for failed MIB read
  net: dsa: yt921x: Use u64_stats_t for MIB stats

 drivers/net/dsa/yt921x.c | 206 +++++++++++++++++++++++----------------
 drivers/net/dsa/yt921x.h | 114 ++++++++++++----------
 2 files changed, 184 insertions(+), 136 deletions(-)

--
2.51.0


