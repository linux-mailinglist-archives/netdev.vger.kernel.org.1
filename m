Return-Path: <netdev+bounces-289166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOy6KWJ1C2oZIAUAu9opvQ
	(envelope-from <netdev+bounces-289166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:24:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3FE573554
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5812D301902C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA35391828;
	Mon, 18 May 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMyV2th1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12CC36215A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135840; cv=none; b=YN5NlZ6JQZGRaHPdgfj6DgleqKZthR4AmDLUIqnBOPbzVimDl7W7eDm+DnCx5r+qhfC0dt+P6+nFGC8L17Wh239A27/FB1KzlW5InWAh2Ss/If71bpRt1T7hFyvCkVAxMT7cyWPHleBAWmC7DruiBMOvQ9+eRQldgvFVYOQpB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135840; c=relaxed/simple;
	bh=NnQCvwb5AKocP6Nl4ekar4FXHLCO1zr5mkczoS6Xr20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cj0O2SV7FYubnRRcmO4wtGftGVwnsAHrzTfsPwvOKwdyK78nwFZaAed67sWn2WugXOnhF55rJTAuMPMeVRDYcbCJFfcoiTpy0BK1m8ckzMJfpQ8eNv676v9Y1GJZ/PGkJHB6QKZiE2BmSi1tPRxz+a3fgOChpagNoGvg4CD7qV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMyV2th1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f97c626aaso544205566b.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135837; x=1779740637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/b4hkfqN/dttSvH0Zc/qQNiFs0qaNjGyxhKYNir7vck=;
        b=rMyV2th1cBlbVK2cEvL51RoX5eRF2muUMO+BJrUChCVktGC9KZtQGVoTfRvP8YjAtu
         lCKBg89gX/64hQ9R0CfAJeLHHRFRHixokdf0iV9Yb5837gmUPpL+nzyOvU2L7QTf2+UD
         fybusASNaF81CUTwTjwBikcZiPlLWdSfJpUScJeORC+XKK7G/O/oWr65Qy7TJ6WvqRiy
         +07RHCI7Nw6yzpmx3kTqlvh3qW8ayI53hfoZ892mMzuFd0aQIJB11r8gu8SAL+HTG6Wx
         W7Da5x4eM/cveHagaxpe+wHXCS0Q8/fVueuY89Lk8GIxgj/+9RgTqMMc9tXUFt6JHzj7
         Y2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135837; x=1779740637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/b4hkfqN/dttSvH0Zc/qQNiFs0qaNjGyxhKYNir7vck=;
        b=G83eRlYilxjyOi32bUDaa4A+VOKXDvqIiNlPpYP2iTPrcrMtxeXSdYMyCHkIhmoJAa
         bjKUmtKf/cCInT7UXRzY2SdjomcwAl8x0Bk12f9eeLNDYkJJLe3QTOb4BruqCkg1x3Nr
         Z8QuxNFqMlV2EDKR+qg3q5yErflxoezevZKnIaYxrxju1Ojs0n3p6akCcY2/6zVshWCb
         /ec1LPIqxLRvajbPnWk6t9Ndi0dAPIeElDx6vc0agPn+rBNMJNQp24kr6wG6PkeEcGuc
         fvOjfR0EHJApSbA+gg0CrUK6hZ3K5lfRd6i0qR/CxOAnnH84HBWO7OniREFdGKFYC2b8
         D8Uw==
X-Gm-Message-State: AOJu0YzVagcjq2SUJ+ki71dSbxoYlmsVsVc+ybLBwgicLueM3DHPVocD
	OkGkFlGjWxKQaW3fIZG12qE7QYzU+XK9CC7Pfb2dzsHE4i1Mns14bvk18OoxrneyCCk=
X-Gm-Gg: Acq92OHtaoIhXoMqw355hTOtiY2dKQamopj1GUNzPm86ueAth2MHMN+Sf+kXoDshRIR
	Xxk/hzlh0WYikS0uO7tT41h3yeUeVxCrw2H+jESHw/BcrXtbSC8OudcViOukPPikJKTDQj/XDjj
	nVOBFKyikXBBiXZ54cAq6sTwQzWJ0r0IJ2SBIu77U9LPidQiIl+stlPPaLS2WO7abpvN6udRq/M
	2RTcz/op348gkAixuUysaTBGum1jTULTGvZ62ErzabW0OxndltgTWKKcg36gYtuy6kQlSGj6jCS
	FN+cw7OdlfO1ULJPbEhdHD+HAamOZZNIRTw03iol1cWhzpZQfNhE1Nu+mr/xAhn7ZYQccmO3CNS
	fWHsxUPifjDNkQWUGO+iukXuLnE1rraKXFSmVCkxUP7mK9rIFljZl79a+oGv/lMYpXDDcDrjfop
	D3vaX9ra80sQ33ZUox5So2PSmD0F4CO6U=
X-Received: by 2002:a17:907:d041:b0:bab:cab:c372 with SMTP id a640c23a62f3a-bd517805418mr926708866b.22.1779135836423;
        Mon, 18 May 2026 13:23:56 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:15::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c31404sm611984866b.25.2026.05.18.13.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:23:55 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [iproute2-next V4 0/6] netshaper: Extend netshaper support
Date: Mon, 18 May 2026 13:23:47 -0700
Message-ID: <20260518202353.390827-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289166-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,networkplumber.org,redhat.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0A3FE573554
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

This series extends the netshaper CLI with missing parameter support
and adds the group command for building scheduling hierarchies.

The existing netshaper tool only supports setting bw-max on individual
shapers. This series adds the remaining shaper attributes (bw-min,
weight) needed for TX scheduling, and introduces the group command
which ties leaf shapers to a parent node in a single operation.

Changelog:
V4:
  Patch 2:
  - Reorder BW_MAX/BW_MIN to BW_MIN/BW_MAX in usage text

  Patch 5:
  - Extract parse_scope_id() to share handle/parent scope+id parsing
  - Extract parse_leaves() with dynamic allocation, removing the
    static NET_SHAPER_MAX_LEAVES limit
  - Add per-leaf weight and priority support in group command
  - Remove inline declarations
  - Skip parent nest when parent not specified
  - Use goto free_leaves for error cleanup

  Patch 6:
  - Document per-leaf weight and priority usage

V3: https://lore.kernel.org/netdev/20260511183915.797792-1-mohsin.bashr@gmail.com/
V2: https://lore.kernel.org/netdev/20260509022353.3470738-1-mohsin.bashr@gmail.com/
V1: https://lore.kernel.org/netdev/20260501011611.3533573-1-mohsin.bashr@gmail.com/

Mohsin Bashir (6):
  netshaper: Extract parse_scope() and parse_rate() helpers
  netshaper: Add bw-min and weight parameter support
  netshaper: Extend show output with parent, bw-min and weight
  netshaper: Extract struct shaper_args and parse_shaper_arg() helper
  netshaper: Add group command for creating scheduling hierarchies
  netshaper: Update man page for new parameters and group command

 include/utils.h       |   1 +
 man/man8/netshaper.8  | 150 ++++++++++--
 netshaper/netshaper.c | 554 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 597 insertions(+), 108 deletions(-)

-- 
2.53.0-Meta

