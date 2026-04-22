Return-Path: <netdev+bounces-280462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFdsMsDx6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:05:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4D4483B5
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69E4D30065D2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F637AA6C;
	Wed, 22 Apr 2026 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZbRHzgP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5C37CD3C
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873909; cv=none; b=XXb1Yd9DcVIBSZ3xOl8+f+DABK7Wq2LMVIvwBOkaIQvM/85yDAnSZysjCKRpb2Cwp2INpsbTM/Qy85Lo+2qiN+V3kyuYUysI5w++mKWUrynylzQEYjoftQMy5KA22Fz2n7BNlBtnIBzb6Jbwk7X0jKEVGduAJEUPoCV4F6phxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873909; c=relaxed/simple;
	bh=MTFLpvqVFwD4wOUmZSXx4b0ZH4SvpKBE09cohDgGFFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBwLfp0sA6sjuSfMWQ4ZmK2Zs/MvlD6yM9+Ppd6YKClak9fXqJ0NbWvAO8gMiJHP8+mtsUVqYtS54gfRxuEksC+rRMvrHalwoF1QxNXqbWpOKY1Is9330+6vmaIm91WIV5jQmW408KL1U15j2Bmv+RdDyaGV82iwdvot7bmopsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZbRHzgP; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56f75445470so3406978e0c.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873905; x=1777478705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24ucL5O3EzfMhPg47OjudcgTvu+hLai1chIqdTg8Gs8=;
        b=BZbRHzgP/WAnZzspo62I5qcgLW9G2PdSkMExOt+6ndvEbBI/DFD49xfqkgX4gzy2ti
         oN4+ThKSzLC0+xs/Rj06mSQJjg0rit99DauF4UHdsI95knJLkaAAIKlcgMyc4K8Szggj
         d4BgZrjuZf3kDNN/+fqYnxCUmpEQpb7Vp3HgBvRu/aOH/nZ5lTesh85dxhUsZWMgphuB
         cXcK8LRqniQ3mWpKIpv8va5d16B1TjbhjD4ZgE0YGA9u3YRA5pSlC+3x41EApp7KpsEe
         6JOW7fIVKy7oJ9p/wTtgjglFkdiZxE1cM1wEblhO8b6snIwd6+q5CskNgETQNh4vjqSv
         N1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873905; x=1777478705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24ucL5O3EzfMhPg47OjudcgTvu+hLai1chIqdTg8Gs8=;
        b=KDscgwG/NRhizIDOHfQQiK/yK/PMnpTU0fzQQFLXZw7bc5MwlgW1oQb375e1vFeRnP
         3uCA1nQtreDJWqMl+vglLKzl0dQtV1YR5+dFcGQ1yrJ+UiZNibtVGXZ28D7099fhARwN
         7s8m4U9sdKBFFwq8cQg8u303bSnYTpCBJDa6piAejLV0L+khc8VfXtijVo2QjtgCfprm
         zdP75UI3fHfS3oaeSQVOaLVyFoWA/68Rx8ajE0gU4zg48n2recNifvq1l8ZCWvjvE1Pt
         /EvzyX5hyJKB5txelF2Nmo4qp1LjIegkUKUq3qf/RSPBBlsm4By8K/kGJrlFICZpBnRy
         yQgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZdQusbhqAutwCxmBilJTljJS0u4ey0iNno8tbCykFMZRmRj2QgVOrvCrqvmE1+9mnvXFrXwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXPaj6uxDZs8r9E5QysOtOKBotHj+wcFjywZ9gxx5J1BILGkW
	RvHTlUsEhAnbp462JOLRKEU+X3ipFjncRFF9lIEJnagZoIn7tDDqhnFl
X-Gm-Gg: AeBDieveJAnvBvW6NhI6Og0K308zS3qy0zhi1BM/7XnyiT9+IGYlEb2bi6u393dSobV
	DnA8lZM6m/SlxtmI8/fCO2h+VlM1XjXGpeVsAqB4/B80M+mm2SFERbLgywQHC33ElhO5Sid+RYY
	WZtMJPKax4OwwlLhRUbC1dkby8ZdrvNRM02cE0yLEzeAbUOPFpCqfP7pTKIVa3WvP926yjWitPY
	cHGMwq/FzfbwAnGLPsagOzHig5HD6VpIN9UL9YqV8oOyOKg1H6BLOZLjHLDrU2d956MiovzK2v1
	bhjag/5O3xNejKzitaBZYOC7NwQsKKXD5k3gve7u4BmsGSbo14n7yMhhGHj8cfWKXmZENf1HxQb
	s1o3TqU7YYxTNFbKNrfGfYhgRvVbDAtx+zRPurHlu835nsCPl8OwIAVembBeEx54wRdqseMUy/F
	mq1EBM0Yh7Osc7LFwNbSE8Dq4rAPZC7f0eqFxdwK+jvF/z83r2KdKHzZHC8sEe8OABz7a1v+JeL
	+lgyZVsfMR+iKJxDjmBo001zC+uWUo=
X-Received: by 2002:a05:6122:4fa2:b0:56f:b2c3:d4d9 with SMTP id 71dfb90a1353d-56fb2c3daa2mr9155887e0c.14.1776873904625;
        Wed, 22 Apr 2026 09:05:04 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:03 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH net 0/6] net/ncsi: harden packet parsing against malformed BMC replies
Date: Wed, 22 Apr 2026 12:03:36 -0400
Message-ID: <20260422160342.1975093-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280462-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AD4D4483B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NC-SI treats the management controller as privileged, but the Linux
packet parser still needs to reject malformed or truncated replies
instead of walking past the skb or past its software filter tables.

This series closes six linked parser issues in net/ncsi:

  - short replies accepted before response header/checksum reads
  - GC/GP count fields exceeding software filter limits
  - GMCMA address counts exceeding payload-backed addresses
  - OEM response parsing that trusts vendor-specific payload offsets
  - short AEN packets accepted before AEN header/payload reads
  - GP payloads not checked against the consumed MAC/VLAN table bytes

The threat model here is a compromised BMC or management-channel MITM
on the NC-SI link. This is not internet-reachable remote input, so I am
sending it as a public [PATCH net] series with Cc: stable rather than
through security@.

Testing:

  - x86_64 defconfig with CONFIG_NET_NCSI=y and
    CONFIG_NCSI_OEM_CMD_GET_MAC=y:
    `make -C ~/src/linux-mainline O=~/src/build-ncsi-bmc-oob ARCH=x86_64
    -j$(nproc) net/ncsi/`
  - live x86_64/KASAN QEMU guest for the GP path: guest `virtio-net`
    registered with NCSI, `SP -> CIS -> GC -> GP` issued over the
    `NCSI` generic-netlink family, and a host tap responder returning
    matching NC-SI frames.  Without the series applied, a GP reply
    with mac_cnt=65 triggers
    `KASAN: slab-out-of-bounds in ncsi_rsp_handler_gp()`.  With the
    series applied, the same reply is rejected with `-ERANGE` and no
    KASAN report.
  - synthetic A/B userspace harness covering the other malformed-
    response cases: without the series, parsing either faults or
    corrupts adjacent state; with the series, each case is rejected
    or clamped at the parser boundary.

Impact / regression notes:

  - libclang call-graph query shows ncsi_validate_rsp_pkt() is only
    reached from ncsi_rcv_rsp() and ncsi_rsp_handler_dc(), so the new
    skb-length guard stays local to the response path.
  - cscope shows ncsi_aen_handler() is only reached from ncsi_rcv_rsp(),
    so the new AEN pulls stay local to AEN dispatch.
  - cscope on n_vids shows the downstream consumers are the response
    parser, the manage-side VLAN bitmap walkers, and ncsi-netlink's
    channel dump path, which is the surface this series intentionally
    tightens.

Michael Bommarito (6):
  net/ncsi: validate response packet lengths against the skb
  net/ncsi: bound filter table state to software limits
  net/ncsi: validate GMCMA address counts against the payload
  net/ncsi: validate OEM response payloads before parsing
  net/ncsi: validate AEN packet lengths against the skb
  net/ncsi: validate GP payload lengths before parsing

 net/ncsi/ncsi-aen.c |  30 +++++++++---
 net/ncsi/ncsi-rsp.c | 114 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 128 insertions(+), 16 deletions(-)

-- 
2.53.0

